#!/usr/bin/perl
use strict;
use warnings;
use Graph;


my $graphfile=shift;
my $l=shift;
my $outfile=shift;


my $g=Graph::Undirected->new;
my $h=Graph::Undirected->new;

open(IN,$graphfile) or die;
while(my $line=<IN>){
    chomp $line;
    my ($i,$j)=split(/\s+/,$line);
    $g->add_edge($i,$j);
    $h->add_edge($i,$j);
}
close(IN);

my $N=$g->vertices;
my %deleted;
my $count=0;

my $eachround=1; # 1回あたり何ノード削除するか
my $thresh=10; # giant component が thresh 個以下になったらやめる

open(my $fh,">$outfile-ci");

my $gc=$N;

# CI の高い順にノードを消して、giant component のサイズを求める
while ($gc>$thresh){
    my @nodes=highest_cis($g,$eachround);
    foreach my $node (@nodes){
	$deleted{$node}=1;
	$g->delete_vertex($node);
	$count++;
    }
    $gc=giant_component($g);
    print $count," ",$gc,"\n";
    print $fh $count," ",$gc,"\n";
}

close($fh);



# グラフがばらばらの状態から、c(i) の値が低い順にノードをグラフに追加し
# て、giant component のサイズを求める

$gc=giant_component($g);
open(my $ci_fh,">$outfile-ci+");
print $ci_fh $count," ",$gc,"\n";
print  $count," ",$gc,"\n";
my $i=0;
while ($i<$count){
    my @nodes=lowest_cscores($eachround,keys %deleted);
    foreach my $node (@nodes){
	$i++;
	delete $deleted{$node};
	$g->add_vertex($node);
	foreach my $u ($h->neighbours($node)){
	    $g->add_edge($node,$u) if ($g->has_vertex($u));
	}
    }

    $gc=giant_component($g);
    print $ci_fh $count-$i," ",$gc,"\n";
    print  $count-$i," ",$gc,"\n";
}

close($ci_fh);


# giant component の大きさを計算
sub giant_component{
    my $g=shift;
    my @cc= $g->connected_components();
    my $gc=0;
    foreach my $ref (@cc){
	my $size=@{$ref};
	if($size>$gc){
	    $gc=$size;
	}
    }
    return $gc;
}


# c(i) の低い順に $num 個のノードを返す
sub lowest_cscores{
    my $num=shift @_;
    my @deleted=@_;
    my %cscore;
    foreach my $v (@deleted){
	my $score=c_score2($h,$g,$v); # ここを c_score にすれば論文通りのはず
	$cscore{$v}=$score;
    }
    my @nodes;
    my $count=0;
    foreach my $v (sort {$cscore{$a}<=>$cscore{$b}} keys %cscore){
	push(@nodes,$v);
	$count++;
	last if($count>=$num);
    }
    return @nodes;

}

# 付録の c(i) を計算しているつもり
# 意図した通りには実装できているが、結果が良くない？
sub c_score{
    my $g=shift;
    my $h=shift;
    my $v=shift;
    my %visited;
    my $score=0;
    foreach my $u ($g->neighbours($v)){
	next unless ($h->has_vertex($u));
	next if (defined $visited{$u});
	$score++;
	my @que;
	push(@que,$u);
	$visited{$u}=1;
	foreach my $i (@que){
	    foreach my $j ($h->neighbours($i)){
		next if (defined $visited{$j});
		$visited{$j}=1;
		push(@que,$j);
	    }
	}
    }
    return $score;
}


# c(i) よりも、こっちの方がいいんじゃ？と思って実装したスコア
# グラフにノード $v を追加した時に、$v から到達可能なノードの数を計算している
# こっちを使うと結果が良さそう？

sub c_score2{
    my $g=shift;
    my $h=shift;
    my $v=shift;
    my %visited;
    my $score=0;
    foreach my $u ($g->neighbours($v)){
	next unless ($h->has_vertex($u));
	next if (defined $visited{$u});
	my @que;
	push(@que,$u);
	$visited{$u}=1;
	foreach my $i (@que){
	    foreach my $j ($h->neighbours($i)){
		next if (defined $visited{$j});
		$visited{$j}=1;
		push(@que,$j);
	    }
	}
    }
    $score=keys %visited;
    return $score;
}



# CI の高い順に $num 個のノードを返す
sub highest_cis{
    my $g=shift;
    my $num=shift;
    my %ci;
    for my $i ($g->vertices){
	my $score=n_hop_neighbor_score($l,$g,$i);
	$score=$score*($g->degree($i)-1);
	$ci{$i}=$score;
    }
    my @nodes;
    my $count=0;
    foreach my $v (sort {$ci{$b}<=>$ci{$a}} keys %ci){
	push(@nodes,$v);
	$count++;
	last if($count>=$num);
    }
    return @nodes;
}



# CI の式のシグマの部分を計算
sub n_hop_neighbor_score{
    my $rad=shift;
    my $g=shift;
    my $start=shift;
    my @que;
    my %dist;
    my $score=0;

# l=0 の場合は、そのノードの次数を返す
    if($rad==0){
	return $g->degree($start);
    }
    push(@que,$start);
    $dist{$start}=0;
    foreach my $i (@que){
	foreach my $j ($g->neighbours($i)){
	    unless(defined $dist{$j}){
		$dist{$j}=$dist{$i}+1;
		if($dist{$j}==$rad){
		    $score+=($g->degree($j)-1);
		}
		else{
		    push(@que,$j);
		}
	    }
	}
    }
    return $score;
}

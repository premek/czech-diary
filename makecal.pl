#!/usr/bin/perl -w
use Time::Local;
use strict;
use warnings;

my $year = shift @ARGV || 2008;

my $texfile="kalendar-$year.tex";

my @M = qw(Leden Únor Březen Duben Květen Červen Červenec Srpen Září Říjen Listopad Prosinec);
my @D = qw(Neděle Pondělí Úterý Středa Čtvrtek Pátek Sobota);
#                  D,M,YYYY
my $t=timelocal(0,0,0,1,0,$year-1900);
$t-=60*60*24 while ((localtime($t))[6]!=1);
open (TEX, ">$texfile");


print TEX '
\documentclass[10pt,a4paper]{article}
\usepackage[top=1.1cm, left=.8cm, right=.8cm, includefoot]{geometry}
\pagestyle{empty}
\usepackage[utf8]{inputenc}
\usepackage{graphics}

\setlength\parindent{0cm}
\setlength\parskip{1cm}
\linespread{1.4}

\begin{document}

%~\newpage

~\vspace{4.5cm}
\begin{center}
\resizebox{12cm}{!} {
\Huge{\it{'.$year.'}}
}
\end{center}
';
while($t<timelocal(0,0,0,1,0,$year-1899)){

print TEX '
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage
\resizebox{0.9\textwidth}{0.54\textheight} {
\begin{tabular*}{0.48\textwidth}{c@{\extracolsep{\fill}}r}
\hline\hline
';

#Norma ISO 8601 zahrnuje ISO datovací sytém týdne, číselný systém pro týdny; 
#každý týden je spojen s rokem ve kterém se vyskytuje jeho čtvrtek (tak, aby 
#samotný dlouhý víkend pátek-sobota se nestal týdnem jednoho roku).
#-- http://cs.wikipedia.org/wiki/Týden#.C4.8C.C3.ADslo_t.C3.BDdne

my $wn = 0;
my $m;
my $y;
for(my $i=0;$i<7;$i++){ # i = 0-6 = po-ne
	(my $wd,my $d,$m,$y)=((localtime($t))[6,3,4,5]);
	$y+=1900;
	print TEX '{\small '.$D[$wd].'}&\\\\ \Large{\bf{'.$d.'.}}&\\\\ {\small '.$M[$m].'}&{\\tiny {'.&statnisv($d,$m)." ".&svatek($d,$m) .'}}\\\\\hline'."\n";
	if($i==3){ # ctvrtek
		$wn = int((localtime($t))[7] / 7) + 1; # cislo tydne
	}
	$t+=60*60*24;
	print TEX "\\hline\n" if($i==4);
}

print TEX '
\hline\hline
\end{tabular*}
}

\newpage %%%%%%%%%%%%%%
\begin{flushright}
\resizebox{0.9\textwidth}{0.54\textheight} {
\begin{tabular*}{0.48\textwidth}{@{\extracolsep{\fill}}lp{3.4cm}}
\hline\hline
&
\begin{flushright}
{\Large '.$M[$m].' '.$y.'}\\\\'.$wn.'. týden
\end{flushright}\\\\\cline{2-2}
'.'&\\\\\cline{2-2}'x20 .
'\hline\hline
\end{tabular*}
}
\end{flushright}

';}


print TEX '\end{document}';


#system("pdflatex $texfile >/dev/null");;
system("pdflatex $texfile");;



sub svatek {
my @sv=();
$sv[101]='Nový rok';
$sv[102]='Karina';
$sv[103]='Radmila';
$sv[104]='Diana';
$sv[105]='Dalimil';
$sv[106]='Tři králové';
$sv[107]='Vilma';
$sv[108]='Čestmír';
$sv[109]='Vladan';
$sv[1010]='Břetislav';
$sv[1011]='Bohdana';
$sv[1012]='Pravoslav';
$sv[1013]='Edita';
$sv[1014]='Radovan';
$sv[1015]='Alice';
$sv[1016]='Ctirad';
$sv[1017]='Drahoslav';
$sv[1018]='Vladislav';
$sv[1019]='Doubravka';
$sv[1020]='Ilona a Sebastian';
$sv[1021]='Běla';
$sv[1022]='Slavomír';
$sv[1023]='Zdeněk';
$sv[1024]='Milena';
$sv[1025]='Miloš';
$sv[1026]='Zora';
$sv[1027]='Ingrid';
$sv[1028]='Otýlie';
$sv[1029]='Zdislava';
$sv[1030]='Robin';
$sv[1031]='Marika' ;
$sv[201]='Hynek a Jasmína';
$sv[202]='Nela';
$sv[203]='Blažej';
$sv[204]='Jarmila';
$sv[205]='Dobromila';
$sv[206]='Vanda';
$sv[207]='Veronika';
$sv[208]='Milada';
$sv[209]='Apolena';
$sv[2010]='Mojmír';
$sv[2011]='Božena';
$sv[2012]='Slavěna';
$sv[2013]='Věnceslav';
$sv[2014]='Valentýn';
$sv[2015]='Jiřina';
$sv[2016]='Ljuba';
$sv[2017]='Miloslava';
$sv[2018]='Gizela';
$sv[2019]='Patrik';
$sv[2020]='Oldřich';
$sv[2021]='Lenka a Eleonora';
$sv[2022]='Petr';
$sv[2023]='Svatopluk';
$sv[2024]='Matěj a Matyáš';
$sv[2025]='Liliana';
$sv[2026]='Dorota';
$sv[2027]='Alexandr';
$sv[2028]='Lumír';
$sv[2029]='Horymír' ;
$sv[301]='Bedřich';
$sv[302]='Anežka';
$sv[303]='Kamil';
$sv[304]='Stela';
$sv[305]='Kazimír';
$sv[306]='Miroslav';
$sv[307]='Tomáš';
$sv[308]='Gabriela';
$sv[309]='Františka';
$sv[3010]='Viktorie';
$sv[3011]='Anděla';
$sv[3012]='Řehoř';
$sv[3013]='Růžena';
$sv[3014]='Růt, Matylda a Vlastibor';
$sv[3015]='Ida';
$sv[3016]='Elena a Herbert';
$sv[3017]='Vlastimil';
$sv[3018]='Eduard';
$sv[3019]='Josef';
$sv[3020]='Světlana';
$sv[3021]='Radek';
$sv[3022]='Leona';
$sv[3023]='Ivona';
$sv[3024]='Gabriel';
$sv[3025]='Marián';
$sv[3026]='Emanuel';
$sv[3027]='Dita';
$sv[3028]='Soňa';
$sv[3029]='Taťána';
$sv[3030]='Arnošt';
$sv[3031]='Kvido' ;
$sv[401]='Hugo';
$sv[402]='Erika';
$sv[403]='Richard';
$sv[404]='Ivana';
$sv[405]='Miroslava';
$sv[406]='Vendula a Venuše';
$sv[407]='Heřman, Hermína';
$sv[408]='Ema';
$sv[409]='Dušan a Dušana';
$sv[4010]='Darja';
$sv[4011]='Izabela';
$sv[4012]='Julius';
$sv[4013]='Aleš';
$sv[4014]='Vincenc';
$sv[4015]='Anastázie';
$sv[4016]='Irena';
$sv[4017]='Rudolf';
$sv[4018]='Valérie';
$sv[4019]='Rostislav';
$sv[4020]='Marcela';
$sv[4021]='Alexandra';
$sv[4022]='Evženie';
$sv[4023]='Vojtěch';
$sv[4024]='Jiří';
$sv[4025]='Marek';
$sv[4026]='Oto';
$sv[4027]='Jaroslav';
$sv[4028]='Vlastislav';
$sv[4029]='Robert';
$sv[4030]='Blahoslav' ;
$sv[501]='Svátek práce';
$sv[502]='Zikmund';
$sv[503]='Alexej';
$sv[504]='Květoslav';
$sv[505]='Klaudie';
$sv[506]='Radoslav';
$sv[507]='Stanislav';
$sv[508]='Den osvobození';
$sv[509]='Ctibor';
$sv[5010]='Blažena';
$sv[5011]='Svatava';
$sv[5012]='Pankrác';
$sv[5013]='Servác';
$sv[5014]='Bonifác';
$sv[5015]='Žofie a Sofie';
$sv[5016]='Přemysl';
$sv[5017]='Aneta';
$sv[5018]='Nataša';
$sv[5019]='Ivo';
$sv[5020]='Zbyšek';
$sv[5021]='Monika';
$sv[5022]='Emil';
$sv[5023]='Vladimír';
$sv[5024]='Jana a Vanesa';
$sv[5025]='Viola';
$sv[5026]='Filip';
$sv[5027]='Valdemar';
$sv[5028]='Vilém';
$sv[5029]='Maxmilián, Maxim';
$sv[5030]='Ferdinand';
$sv[5031]='Kamila' ;
$sv[601]='Laura';
$sv[602]='Jarmil';
$sv[603]='Tamara';
$sv[604]='Dalibor';
$sv[605]='Dobroslav';
$sv[606]='Norbert';
$sv[607]='Iveta, Slavoj';
$sv[608]='Medard';
$sv[609]='Stanislava';
$sv[6010]='Gita a Margita';
$sv[6011]='Bruno';
$sv[6012]='Antonie';
$sv[6013]='Antonín';
$sv[6014]='Roland';
$sv[6015]='Vít';
$sv[6016]='Zbyněk';
$sv[6017]='Adolf';
$sv[6018]='Milan';
$sv[6019]='Leoš a Leo';
$sv[6020]='Květa a Květuše';
$sv[6021]='Alois a Aloisie';
$sv[6022]='Pavla';
$sv[6023]='Zdeňka';
$sv[6024]='Jan';
$sv[6025]='Ivan';
$sv[6026]='Adriana a Adrian';
$sv[6027]='Ladislav';
$sv[6028]='Lubomír';
$sv[6029]='Petr a Pavel';
$sv[6030]='Šárka' ;
$sv[701]='Jaroslava';
$sv[702]='Patricie';
$sv[703]='Radomír';
$sv[704]='Prokop';
$sv[705]='Cyril a Metoděj';
$sv[706]='Upálení Jana Husa';
$sv[707]='Bohuslava';
$sv[708]='Nora';
$sv[709]='Drahoslava a Drahuše';
$sv[7010]='Libuše a Amálie';
$sv[7011]='Olga a Helga';
$sv[7012]='Bořek';
$sv[7013]='Markéta';
$sv[7014]='Karolína';
$sv[7015]='Jindřich';
$sv[7016]='Luboš';
$sv[7017]='Martina';
$sv[7018]='Drahomíra';
$sv[7019]='Čeněk';
$sv[7020]='Ilja a Eliáš';
$sv[7021]='Vítězslav';
$sv[7022]='Magdaléna';
$sv[7023]='Libor';
$sv[7024]='Kristýna';
$sv[7025]='Jakub';
$sv[7026]='Anna a Anita';
$sv[7027]='Věroslav';
$sv[7028]='Viktor a Alina';
$sv[7029]='Marta';
$sv[7030]='Bořivoj';
$sv[7031]='Ignác' ;
$sv[801]='Oskar';
$sv[802]='Gustav';
$sv[803]='Miluše';
$sv[804]='Dominik a Dominika';
$sv[805]='Kristián';
$sv[806]='Oldřiška';
$sv[807]='Lada';
$sv[808]='Soběslav';
$sv[809]='Roman';
$sv[8010]='Vavřinec';
$sv[8011]='Zuzana';
$sv[8012]='Klára';
$sv[8013]='Alena';
$sv[8014]='Alan';
$sv[8015]='Hana';
$sv[8016]='Jáchym';
$sv[8017]='Petra';
$sv[8018]='Helena a Jelena';
$sv[8019]='Ludvík';
$sv[8020]='Bernard';
$sv[8021]='Johana a Jovana';
$sv[8022]='Bohuslav';
$sv[8023]='Sandra';
$sv[8024]='Bartoloměj';
$sv[8025]='Radim';
$sv[8026]='Luděk';
$sv[8027]='Otakar';
$sv[8028]='Augustýn';
$sv[8029]='Evelína';
$sv[8030]='Vladěna';
$sv[8031]='Pavlína' ;
$sv[901]='Linda a Samuel';
$sv[902]='Adéla';
$sv[903]='Bronislav a Bronislava';
$sv[904]='Jindřiška a Rozálie';
$sv[905]='Boris';
$sv[906]='Boleslav';
$sv[907]='Regína';
$sv[908]='Mariana';
$sv[909]='Daniela';
$sv[9010]='Irma';
$sv[9011]='Denis a Denisa';
$sv[9012]='Marie a Mia';
$sv[9013]='Lubor';
$sv[9014]='Radka';
$sv[9015]='Jolana';
$sv[9016]='Ludmila a Lola';
$sv[9017]='Naděžda';
$sv[9018]='Kryštof';
$sv[9019]='Zita';
$sv[9020]='Oleg';
$sv[9021]='Matouš';
$sv[9022]='Darina';
$sv[9023]='Berta';
$sv[9024]='Jaromír a Jaromíra';
$sv[9025]='Zlata';
$sv[9026]='Andrea';
$sv[9027]='Jonáš';
$sv[9028]='Den české státnosti, Václav';
$sv[9029]='Michal a Michael';
$sv[9030]='Jeroným' ;
$sv[1001]='Igor';
$sv[1002]='Olivie a Oliver';
$sv[1003]='Bohumil';
$sv[1004]='František';
$sv[1005]='Eliška';
$sv[1006]='Hanuš';
$sv[1007]='Justýna';
$sv[1008]='Věra';
$sv[1009]='Štefan a Sára';
$sv[10010]='Marina';
$sv[10011]='Andrej';
$sv[10012]='Marcel';
$sv[10013]='Renáta';
$sv[10014]='Agáta';
$sv[10015]='Tereza';
$sv[10016]='Havel';
$sv[10017]='Hedvika';
$sv[10018]='Lukáš';
$sv[10019]='Michaela';
$sv[10020]='Vendelín';
$sv[10021]='Brigita';
$sv[10022]='Sabina';
$sv[10023]='Teodor';
$sv[10024]='Nina';
$sv[10025]='Beáta';
$sv[10026]='Erik';
$sv[10027]='Šarlota a Zoe';
$sv[10028]='Den vzniku samostatného československého státu';
$sv[10029]='Silvie';
$sv[10030]='Tadeáš';
$sv[10031]='Štěpánka' ;
$sv[1101]='Felix';
$sv[1102]='Památka zesnulých, Tobiáš';
$sv[1103]='Hubert';
$sv[1104]='Karel a Karla';
$sv[1105]='Miriam';
$sv[1106]='Liběna';
$sv[1107]='Saskie';
$sv[1108]='Bohumír';
$sv[1109]='Bohdan';
$sv[11010]='Evžen';
$sv[11011]='Martin';
$sv[11012]='Benedikt';
$sv[11013]='Tibor';
$sv[11014]='Sáva';
$sv[11015]='Leopold';
$sv[11016]='Otmar';
$sv[11017]='Den boje za svobodu a demokracii, Mahulena';
$sv[11018]='Romana';
$sv[11019]='Alžběta';
$sv[11020]='Nikola a Nikolas';
$sv[11021]='Albert';
$sv[11022]='Cecílie';
$sv[11023]='Klement';
$sv[11024]='Emílie';
$sv[11025]='Kateřina';
$sv[11026]='Artur';
$sv[11027]='Xenie';
$sv[11028]='René';
$sv[11029]='Zina';
$sv[11030]='Ondřej' ;
$sv[1201]='Iva';
$sv[1202]='Blanka';
$sv[1203]='Svatoslav';
$sv[1204]='Barbora';
$sv[1205]='Jitka';
$sv[1206]='Mikuláš';
$sv[1207]='Ambrož a Benjamín';
$sv[1208]='Květoslava';
$sv[1209]='Vratislav a Vratislava';
$sv[12010]='Julie';
$sv[12011]='Dana a Danuše';
$sv[12012]='Simona';
$sv[12013]='Lucie';
$sv[12014]='Lýdie';
$sv[12015]='Radana a Radan';
$sv[12016]='Albína';
$sv[12017]='Daniel';
$sv[12018]='Miloslav';
$sv[12019]='Ester';
$sv[12020]='Dagmar';
$sv[12021]='Natálie';
$sv[12022]='Šimon';
$sv[12023]='Vlasta';
$sv[12024]='Štědrý den, Adam a Eva';
$sv[12025]='Boží hod vánoční';
$sv[12026]='Štěpán';
$sv[12027]='Žaneta';
$sv[12028]='Bohumila';
$sv[12029]='Judita';
$sv[12030]='David';
$sv[12031]='Silvestr';

return $sv[$_[1]+1 .0 .$_[0]];
}


sub statnisv {
#Velikonoční patek + pondělí!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	my $stsv = ",101,501,508,705,706,9028,10028,11017,12024,12025,12026,";
	my $p = $_[1]+1 .0 .$_[0];
	if($stsv =~ /,$p,/){ return "\\bf Státní svátek, " }
}

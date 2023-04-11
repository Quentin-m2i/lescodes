# Variables

$fichier='Communs','Compta','Recherches','Informatiques','Ventes','Clients','Paies','Plans' # Les fichier que nous souhaitons couvrir
$droit='CT','M','RW','RX','RO'

# Le domaine et le TLD en arguments
$DC1=$args[0] 
$DC2=$args[1] 

# Compteur pour les tableaux fichier et droits
$fi=0
$fi2=0

# Code


import-module activedirectory

# On crée une OU pour ranger nos GDL avec les droits
write-host "Creation de l'OU_Sharefile"
New-ADOrganizationalUnit -Name "OU_ShareFile" -Path "DC=$DC1,DC=$DC2"



while($fi -lt 8)
{
  # Mise en place du noms du GDL
	$fichiermaintenant=$fichier[$fi]
	$droitmaintenant=$droit[$fi2]
	$nomgdl="GDL_${fichiermaintenant}_${droitmaintenant}"
  
  # Créations du GDL
	write-host "Création de :$nomgdl"
	New-ADGroup -Name "$nomgdl" -GroupScope DomainLocal -groupcategory Security  -Path "OU=OU_ShareFile,DC=$DC1,DC=$DC2"
	$fi2=$fi2+1
	if ($fi2 -gt 4)
	{
		$fi2=0
		$fi=$fi+1
	}
}

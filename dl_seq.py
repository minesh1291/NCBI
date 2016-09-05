from Bio import Entrez
from Bio import SeqIO

Entrez.email = "my_name@my_website.com"
id_list = set(open('pids_test.csv', 'rU'))
id_list = list(id_list)

handle = Entrez.efetch(db="protein", rettype="fasta", retmode="text", id=id_list)	

out_handle = open("saved.fasta", "w")
for line in handle:
  out_handle.write(line)

out_handle.close()
handle.close()

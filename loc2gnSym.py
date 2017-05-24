# <accession>/<locus> to <gene symbol>

import re
from Bio import Entrez
Entrez.email = "A.N.Other@example.com"     # Always tell NCBI who you are



handle = Entrez.efetch(db="nucleotide", id="BC172725", rettype="gb", retmode="text")
gb_file_txt=handle.read()
gene=re.search('/gene=\"(.+)\"',gb_file_txt)
if(gene):
	print(gene.group(1))


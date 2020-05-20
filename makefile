README.md: 
	echo "# Collection of python helper function" > README.md
	echo "Date and time: " >> README.md
	date >> README.md
	echo "<br/>" >> README.md
	echo "Number of files in src: " >> README.md
	ls src | wc -l >> README.md

clean:
	rm README.md

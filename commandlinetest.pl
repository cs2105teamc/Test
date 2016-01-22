use strict;
use English;
use warnings;



my %Target_Repo = (
					Project_Name	=> "SCMTest",
					Project_URL		=> "https://github.com/cs2105teamc/SCMTest.git",
);

#Subroutine which calls remote repository, passed in as an argument, and returns an array of the results
sub repository_enumerate($) {												
					my @result = `git ls-remote -h @ARG 2>&1`;
					return @result
	}

#Checks output file for duplicate lines, returns 0 if line is found in file
sub duplicate_check($) 	{
						open (FILEIN, "<C:/Users/rashacor/GitPerl/test.txt") || return 1; 
						#undef $INPUT_RECORD_SEPARATOR;
						my @string_check = @ARG;
						my $contents = join("", <FILEIN>);
						if ($contents =~ /$string_check[0]/){
														print "Already exists\n";
														close FILEIN;
														#$INPUT_RECORD_SEPARATOR = "\n";
														return 0;
						}
						else {
							close FILEIN;
							#$INPUT_RECORD_SEPARATOR = "\n";
							return 1;
						}	
}

#Writes line to output file, expects string as argument	
sub write_line($) 	{
					open FILEOUT, ">>C:/Users/rashacor/GitPerl/test.txt";
					my @output = @ARG;
					print $output[0]."\n";
					print FILEOUT $output[0]."\n";
					close FILEOUT;
}

#Reformats results of git ls-remote -h command like so LogicalName::Branch::CommitID, expects string as argument
sub formatter($) {
				chomp @ARG;
				my @manipulator = @ARG;				
				@manipulator = split( " " ,$manipulator[0]);
				$manipulator[1] =~  /\b(\w+)\z/;
				my $formatted_line = join ( "::", $Target_Repo{"Project_Name"}, $1, $manipulator[0] );
				return $formatted_line;
}


#Every 10 seconds, 
sub main() {
			while (1){
						my @commit_list = repository_enumerate($Target_Repo{"Project_URL"});
						foreach my $commit_line (@commit_list) 	{unless (!duplicate_check(formatter($commit_line))) {write_line(formatter($commit_line));} }
			sleep(10);
			}
}

main();


exit;
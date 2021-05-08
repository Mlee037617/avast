import sys, getopt
import re
from datetime import datetime

class parser(object):
	def load_file(self, file_name, per_line=False):
		content = None
		f = open(file_name, 'r')
		if per_line:
			content = []
			for x in f:
				content.append(x)
		else:
			content = f.read()	
		f.close()
		return content

	def process_args(self):
		print(sys.argv)
		file_name = None
		option = None
		arguments = None
		if len(sys.argv) == 2:
			option = sys.argv[1]
		elif len(sys.argv) >2:
			file_name = sys.argv[1]
			option = sys.argv[2]
			arguments = sys.argv[3:]
		else:
			option = '-x'
		self.process_content(file_name, option, arguments)

	def process_content(self, file_name, option, arguments):
		if option == '-h':
			print('*** Options for this parser ***')
			print('-h prints out info about all the available switches')
			print('-s prints out the time difference between lines containing “TEST STARTED” and “TEST FINISHED”')
			print('-i <args,…> prints out lines containing all the provided arguments')
			print('-e <args,…> prints out all lines which don\'t contain any of the provided arguments')
		elif option == '-i':
			lines = []
			content_list = self.load_file(file_name, True)
			for a in arguments:
				for c in content_list:
					if a in c:
						lines.append(c)
			print(lines)
		elif option == '-s':
			content = self.load_file(file_name)
			pattern_start = '\n([\d\-\s:\.]+) === TEST STARTED ==='
			pattern_finish = '\n([\d\-\s:\.]+) === TEST FINISHED ==='
			result = re.search(pattern_start, content)
			start_time = result.group(1)
			result = re.search(pattern_finish, content)
			finish_time = result.group(1)
			fmt = '%m-%d %H:%M:%S.%f'
			diff = datetime.strptime(finish_time, fmt)-datetime.strptime(start_time, fmt)
			print('The difference between test end and start is', diff)
		elif option == '-e':
			lines = []
			content_list = self.load_file(file_name, True)
			for a in arguments:
				for c in content_list:
					if a in c:
						content_list.remove(c)
			print(content_list)
		else:
			print("Unable to recognize your command, please use -h for help")

p = parser()
p.process_args()
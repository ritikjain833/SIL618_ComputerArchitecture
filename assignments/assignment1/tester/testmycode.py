# import required libraries
import sys
import os
print(sys.path)
import shutil
import random
import subprocess
import glob
import zipfile
import re
import ntpath
from pathlib import Path
from datetime import datetime
from distutils.dir_util import copy_tree

# extract folder name from path
def path_leaf(path):
    head, tail = ntpath.split(path)
    return tail or ntpath.basename(head)

# check whether all the required files are present in directory
def check_bs_presence(path):
    dir = [i for i in os.listdir(path)]
    if ('binarysearch.asm' in dir):
        return 1
    else:
        return 0

def check_qs_presence(path):
    dir = [i for i in os.listdir(path)]
    if ('quicksort.asm' in dir):
        return 1
    else:
        return 0

# check whether code is in intended format
def check_code_format_bs(path):
    # check code of binarysearch
    fu = open(os.path.join(path, 'binarysearch.asm'), "r")
    bs_search = 1
    t = []
    for x in fu:
        if (bs_search == 1) and ('.binarysearch:' in x):
            print (x)
            bs_search += 1
        elif (bs_search == 2) and ('.main:' in x):
            bs_search += 1
            t = ['mov', 'r0']
        elif (bs_search == 3):
            bs_search += 1
            t = ['mov', 'r3']
        elif (bs_search == 4):
            if all(i in x for i in t):
                bs_search += 1
                t = ['@', 'Print']
        elif (bs_search == 5):
            if all(i in x for i in t):
                bs_search += 1
                break
    fu.close()
    if (bs_search == 6):
        return 1
    else:
        return 0

    # print('bs: ', bs_search)

def check_code_format_qs(path):
    # check code of quicksort
    fu = open(os.path.join(path, 'quicksort.asm'), "r")
    qs_search = 1
    t = []
    for x in fu:
        if (qs_search == 1) and ('.quicksort:' in x):
            qs_search += 1
        elif (qs_search == 2) and ('.partition:' in x):
            qs_search += 1
        elif (qs_search == 3) and ('.main:' in x):
            qs_search += 1
            t = ['add', 'r4', 'r2', 'r3']
        elif (qs_search == 4):
            if all(i in x for i in t):
                qs_search += 1
                t = ['@', 'Print']
        elif (qs_search == 5):
            if all(i in x for i in t):
                qs_search += 1
                break
    fu.close()
    if (qs_search == 6):
        return 1
    else:
        return 0
    # print('ms: ', qs_search)


# checks for recursive implementation of quick sort algorithm
def check_recursion_quicksort(path):
    fu = open(path, "r")
    partition_count = 0
    quicksort_count = 0
    for x in fu:
        if 'call' in x:
            if '.quicksort' in x:
                quicksort_count += 1
            elif '.partition' in x:
                partition_count += 1
            if (quicksort_count == 3) and (partition_count == 1):
                break
    fu.close()
    print('quicksort count:', quicksort_count)
    print('partition count:', partition_count)
    if (quicksort_count >= 3) and (partition_count >= 1):
        return 1
    else:
        return 0

# execute code and return the result
def execute_code(path,sorting,element, l=[]):
    t = ''
    found = 0
    try:
        t = subprocess.run(['./interpreter', path], stdout=subprocess.PIPE, timeout=1).stdout.decode('utf-8')
        # print(t)
        # extract integers from the output
        t = t.replace('r1 : ', ' ').replace('\n', ' ')
        t2 = [int(s) for s in re.findall(r'-?\d+', t)]
        res = list(map(int, t2))
        #print('res t t2',res, t, t2)
        # print("input: " + str(l))
        # print("output: " + str(res))
        sorted_l = l[:]
        
        if(sorting == "binarysearch"):
            if element in sorted_l:
                found = 1
            if(found == int(t)):
                return 1
            else:
                return 0
        sorted_l.sort()
                

                
                
        # print(sorted_l)
        if len(sorted_l) == len(res) and len(sorted_l) == sum([1 for i, j in zip(sorted_l, res) if i == j]):
            return 1  # expected output and actual output matches
        else:
            return 0  # expected output and actual output does not match
    except subprocess.TimeoutExpired:
        # print('subprocess timeout')
        return 0  # no output from execution

# generate test case for each sorting algorithm and trigger their execution
def generate_testcase_and_trigger_execution(path,sorting):
    t_path = path + '/testcases'  # sorting = binarysearch or quicksort
    element =0
    if os.path.exists(t_path) and os.path.isdir(t_path):
        shutil.rmtree(t_path)  # delete previously ceated test cases

    # make separate folders per sorting algorithm to store testcases
    # os.makedirs(t_path + '/binarysearch')
    s_path = t_path + "/"+sorting
    # shutil.rmtree(s_path)
    os.makedirs(s_path)
    # os.makedirs(t_path + '/quicksort')

    pf = []
    tc = 1
    while (tc <= 5):
        n = tc * 10
        
        y = random.randint(-200, 200)
        if (tc == 1): # forward sorted
            l = list(range(y, y + n))
            element = y + n -1
        elif (tc == 2): # reverse sorted
            l = list(range(y, y + n))
            l.sort(reverse = True)
            element = y
        elif (tc == 3):
            l = [y] * n # identical values
            element = y
        elif (tc == 4) or (tc == 5): # random values
            l = random.sample(range(-254, 254), n)
            element = random.randint(-200, 200)
        full_path = s_path+"/"
        sf = sorting+".asm"
        tf_name = sorting+"_tc_"
        name = tf_name + str(tc) + '.asm'
        ft = open(os.path.join(full_path, name), "w")
        fu = open(os.path.join(path, sf), "r")

        # start creating test case files
        for x in fu:
            if '.main:' in x:
                break
            ft.write(x)

        ft.write('\n.main:')
        ft.write('\n\t@ Loading the values as an array into the registers\n')
        ft.write('\tmov r0, 0\n')

        i = 0
        j = 0
        while (i < n):
            ft.write('\tmov r1, ' + str(l[i]))
            ft.write('\n\tst r1, ' + str(j) + '[r0]\n')
            i = i + 1
            j = j + 4

        if (sorting == "binarysearch"):
            
            #element = random.randint(-200, 200)
            #print ('element')
            #print(element)
            ft.write('\n\t@ Store the Element to be searched in r0')
            ft.write('\n\tmov r0, ' + str(element) + '\n')
            ft.write('\n\t@ Save the boolean result in r1')
            ft.write('\n\n\t mov r1, 0 \n')

        ft.write('\n\tmov r2, 0 @ Starting address of the array')
        ft.write('\n\n\t@ Retreive the end address of the array')
        ft.write('\n\tmov r3, ')

        if (sorting == "binarysearch"):
            ft.write(str(n))
            t = ['mov', 'r3']
        else:
            ft.write(str(n-1))
            ft.write('\n\tmul r3, r3, 4')
            ft.write('\n\tadd r4, r2, r3\n\n')
            t = ['add', 'r4', 'r2', 'r3']

        for x in fu:
            if all(i in x for i in t):
                break

        t = ['@', 'Print']
        for x in fu:
            if all(i in x for i in t):
                break
            ft.write(x)

        i = 0
        j = 0
        ft.write('\n\t@ Print statements for the result')
        if (sorting == "binarysearch"):
           # ft.write('\n\t@ Boolean result is stored in r1')
            ft.write('\n\t.print r1')     
        else:
            while (i < n):
                ft.write('\n\tld r1, ' + str(j) + '[r0]')
                ft.write('\n\t.print r1')
                i = i + 1
                j = j + 4

        fu.close()
        ft.close()

        # run the created test case file
        if execute_code(os.path.join(full_path, name),sorting,element, l) == 1:
            # print('run successful')
            pf.append('1')
        else:
            # print('run failed')
            pf.append('0')

        tc = tc + 1  # increment test case
    return pf  # return list of results where '1' indicates pass & '0' indicates fail

# main function
def main():
    bs = 1 
    ms = 1

    file = Path('./marks.txt')
    # try:
    #     file.resolve(strict=True)
    # except FileNotFoundError:  # doesn't exist
    #     pass
    # else:  # exists
    #     print('marks.txt already exists')
    #     exit()

    # create marks.txt to store the results of each entry number
    fm = open(file, "w")

    # delete previously created "all_submissions" folder
    # path = "./all_submissions"
    # if os.path.exists(path) and os.path.isdir(path):
    #     shutil.rmtree(path)

    # extract all submissions
    # zipfiles = glob.glob("./moodle_download/*.zip")
    # zipfiles = glob.glob("./moodle_download/2001-ELL782-Assignment-1-45774/*/*.zip")
    # for file in zipfiles:
    #     path_wo_ext = os.path.splitext(file)[0]
    #     folder_name = path_leaf(path_wo_ext)
    #     f = zipfile.ZipFile(file, "r")
    #     if (any(x.startswith("%s/" % folder_name.rstrip("/")) for x in f.namelist())):
    #         f.extractall("all_submissions")
    #     else:
    #         f.extractall("all_submissions/" + folder_name)

    # check each and every submission
    root = './mycode/'
    dir = [i for i in os.listdir(root) if os.path.isdir(os.path.join(root, i))]
    print(dir)
    dir_count = len(dir)
    # print('submissions count:', dir_count)
    
    i = 0
    while (i < dir_count):
        curr_dir = os.path.join(root, dir[i]) # dir[i] = assignment and otherwose it will be the dir for each submisssion (entry number)
        print('checking', curr_dir) # ./mycode/entrynumber or ./mycode/assignment
        fm.write(dir[i]) # write entry number

        # if 'arm_' in dir[i]:
        #     fm.write(' 2\n') # in arm
        #     print('moving', curr_dir, 'to arm_submissions')
        #     shutil.move(curr_dir, './arm_submissions')
        #     i += 1
        #     continue
        # elif 'x86_' in dir[i]:
        #     fm.write(' 3\n') # in x86
        #     print('moving', curr_dir, 'to x86_submissions')
        #     shutil.move(curr_dir, './x86_submissions')
        #     i += 1
        #     continue
        # else:
        #     fm.write(' 1 ') # in simple risc

        # check whether all files are present folder being checked
        # if check_file_presence(curr_dir) == 0:
        #     # print('required files absent in', curr_dir)
        #     fm.write(' 0\n')
        #     print('moving', curr_dir, 'to manual_check due to missing files')
        #     shutil.move(curr_dir, './manual_check')
        #     i += 1
        #     continue
        # else:
        #     fm.write(' 1')

        marks = 0 
        # check whether code is intended format
        if check_bs_presence(curr_dir) == 1:
            if check_code_format_bs(curr_dir) == 0:
                bs = 0
                fm.write('(BS-WF) ') # Binary Search in wrong format

            l = generate_testcase_and_trigger_execution(curr_dir,"binarysearch")
            for x in l:
                t_str = ' ' + str(x)
                fm.write(t_str)  # write pass / fail for each test case
            marks = ((l[0:5].count('1') * (10 / 5)))
            # print(bs_marks)        
        else:
            fm.write('BS-NP ') # Bubble Sort Not Present

        if check_qs_presence(curr_dir) == 1:
            if check_code_format_qs(curr_dir) == 0:
                qs = 0
                fm.write(' QS-WF')
                
            l = generate_testcase_and_trigger_execution(curr_dir,"quicksort")
            for x in l:
                t_str = ' ' + str(x)
                fm.write(t_str)  # write pass / fail for each test case
            marks += (l[0:5].count('1') * (15 / 5))
            #print(ms_marks)
            qs = check_recursion_quicksort(os.path.join(curr_dir, 'quicksort.asm'))    
            t_str = "    => qs_rec: "+str(qs)
            fm.write(t_str)
        else:
            fm.write(' QS-NP')

        # check for recursive implementation of partition and quick sort


         # write pass / fail for recursive implementation


        # marks = (bs_format*(l[0:5].count('1') * (14 / 5))) + (ms * l[5:10].count('1') * (18 / 5)) + (qs * l[10:].count('1') * (18 / 5))
        # marks = 0
        # if(check_bs_presence(curr_dir) == 1):
        #     marks = bs_marks
        # if(check_qs_presence(curr_dir) == 1):
        #     marks += ms_marks

        t_str = '  Total: ' + str(marks) + '\n'
        fm.write(t_str)
        # print('Number of passed testcases:', l.count('1'))
        # if (ms == 0) or (qs == 0):
        # if (ms == 0):    
        #     print('moving', curr_dir, 'to failed recursion')
        #     shutil.move(curr_dir, './failed_recursion')
        # elif (l.count('1') == 5):
        #     print('moving', curr_dir, 'to passed testcases')
        #     shutil.move(curr_dir, './passed_testcases')
        # else:
        #     print('moving', curr_dir, 'to failed testcases')
        #     shutil.move(curr_dir, './failed_testcases')
        i += 1

    fm.close()

if __name__ == "__main__":
    main()


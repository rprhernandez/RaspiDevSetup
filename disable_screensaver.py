
import re
import os

try:
    print('Disabling Screen Saver')
    the_file = "/etc/xdg/lxsession/LXDE-pi/autostart"
    file_read = open(the_file).read()
    file_write = open(the_file, 'w')
    split_string = file_read.split('\n')
    list_index = 0
    
    to_add = '@xset s off'
    if to_write.find(to_add) < 0:
        to_write = to_write + '\n{}'.format(to_add)
    
    to_add = '@xset -dpms'
    if to_write.find(to_add) < 0:
        to_write = to_write + '\n{}'.format(to_add)
		
    to_add = '@xset s noblank'
    if to_write.find(to_add) < 0:
        to_write = to_write + '\n{}'.format(to_add)

    file_write.write(to_write)
    file_write.close()
    print('    OK..')
except:
    print('    FAILED..')


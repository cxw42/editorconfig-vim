# Never exits
#v=IO.popen('vim -nNes -i NONE -u NONE -U NONE --servername foo')
#Process.wait(v.pid)

# Can't make the vim quit
system 'start vim -nNes -i NONE -u NONE -U NONE --servername foo'

# Modified from https://github.com/chef/win32-process/blob/ffi/README.md
require 'win32/process'
require 'random_word'

servername = RandomWord.nouns.next
info = Process.create( :command_line => "\"c:\\Program Files (x86)\\Vim\\vim81\\vim.exe\" --noplugin -i NONE -u NONE -U NONE --servername #{servername}", :creation_flags => Process::DETACHED_PROCESS, :process_inherit => false, :thread_inherit => true, :cwd => "C:\\", :close_handles => true )

p servername
p info.process_id

# From https://www.rubydoc.info/gems/win32-process/0.8.3/Process.create
sleep 0.1 while !Process.get_exitcode(info.process_id)

info=nil
# vim --servername #{servername} --remote-send ":q!<CR>" does cause an exit!
# However, the vim process stays running.
#
#

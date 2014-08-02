#!/usr/sbin/dtrace -s

#pragma D option quiet

dtrace:::BEGIN
{
        printf("Tracing... Hit Ctrl-C to end.\n");
}

syscall::link:entry 
   / execname == "backupd" / 
   { 
      printf("link entry: linking %s \n" , copyinstr(arg0)) ; 
      printf("... to %s \n" , copyinstr(arg1)) ; 
   }  

syscall::link:return 
   / execname == "backupd" / 
   {
      printf("link return code: %x \n", arg0) ;
   }  

syscall::open:entry , syscall::getattrlist:entry 
   / execname == "backupd" / 
   {
      printf("looking at: %s %ld \n",copyinstr(arg0),arg1) ; 
   }

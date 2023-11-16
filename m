Return-Path: <cgroups+bounces-453-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29D97EDF2F
	for <lists+cgroups@lfdr.de>; Thu, 16 Nov 2023 12:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB8F1F23FDF
	for <lists+cgroups@lfdr.de>; Thu, 16 Nov 2023 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4393C2D786;
	Thu, 16 Nov 2023 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f78.google.com (mail-pj1-f78.google.com [209.85.216.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79BFB2
	for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 03:09:28 -0800 (PST)
Received: by mail-pj1-f78.google.com with SMTP id 98e67ed59e1d1-280152bfd40so802691a91.0
        for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 03:09:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700132968; x=1700737768;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqCIaCYiImBYxXAw6skTyeTrBtW7RE2WUIlw919cm0w=;
        b=hymcvvnC8w1WT2ddlNVvcKK0L7mNmwu0ijoIIArFUr7PKr5obbYWNpmhsI9hf8fqPs
         38V1NJMGjT+kcXMZ30DICw8S6ygg6q0+toa5/4eReNJqKCZdrswWdzIE+w1U+5QFQyy1
         8xgja1zgtvVo+kUatZTt5ij8i1vAdeBPh2JCA7Jy1oBlg1q4k4mfYq2/i9SvXm4dxnNB
         oYsRKLRAsBUVkLXyZA408TuxVsxP/DsM1XQ9ka4PGjCkQNzrHNefmPIHs0NjKdB6/Wr9
         56ulKW8U6D7HoLDlxWDbe8oVb36I14WPCAmCKyTza7Gms4uCdZ9J5BGDBqogsuTeKGw/
         WQAA==
X-Gm-Message-State: AOJu0Yzfqe7vC6KCFjvdiD+cIY3r8OBeNTp8blr9tA5Y6Hb6Hh0+TiXe
	6vE688pWSPV5vUIpKcb3Q1cj0wHEEyXUu9NS5aOhYYK2F+1whv6D2w==
X-Google-Smtp-Source: AGHT+IEUSN2CpRwsD7N1rsR4ATU/7rFmMK1sr0MriC3Mu19skJ3UkTZM8Ne3QcObvF90O5QvbBqlyP/lD2Hjb+v+af0AIrcSpMlf
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90b:118e:b0:280:c576:31be with SMTP id
 gk14-20020a17090b118e00b00280c57631bemr4219950pjb.4.1700132968502; Thu, 16
 Nov 2023 03:09:28 -0800 (PST)
Date: Thu, 16 Nov 2023 03:09:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a89e92060a430d69@google.com>
Subject: [syzbot] [cgroups?] possible deadlock in ptrace_attach
From: syzbot <syzbot+6b6c93afd6dd93d21e3e@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	lizefan.x@bytedance.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f31817cbcf48 Add linux-next specific files for 20231116
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12e9b938e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
dashboard link: https://syzkaller.appspot.com/bug?extid=6b6c93afd6dd93d21e3e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/987488cb251e/disk-f31817cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d4a82d8bd4b/vmlinux-f31817cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc43dee9cb86/bzImage-f31817cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b6c93afd6dd93d21e3e@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
6.7.0-rc1-next-20231116-syzkaller #0 Not tainted
--------------------------------------------------------
syz-executor.0/8349 just changed the state of lock:
ffff888026a040d8 (&sighand->siglock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff888026a040d8 (&sighand->siglock){+.+.}-{2:2}, at: class_spinlock_constructor include/linux/spinlock.h:530 [inline]
ffff888026a040d8 (&sighand->siglock){+.+.}-{2:2}, at: ptrace_set_stopped kernel/ptrace.c:391 [inline]
ffff888026a040d8 (&sighand->siglock){+.+.}-{2:2}, at: ptrace_attach+0x401/0x650 kernel/ptrace.c:478
but this lock was taken by another, SOFTIRQ-safe lock in the past:
 (css_set_lock){..-.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sighand->siglock);
                               local_irq_disable();
                               lock(css_set_lock);
                               lock(&sighand->siglock);
  <Interrupt>
    lock(css_set_lock);

 *** DEADLOCK ***

2 locks held by syz-executor.0/8349:
 #0: ffff88801dc5c208 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: class_mutex_intr_constructor include/linux/mutex.h:225 [inline]
 #0: ffff88801dc5c208 (&sig->cred_guard_mutex){+.+.}-{3:3}, at: ptrace_attach+0x1eb/0x650 kernel/ptrace.c:455
 #1: ffffffff8cc0a098 (tasklist_lock){++++}-{2:2}, at: class_write_lock_constructor include/linux/spinlock.h:564 [inline]
 #1: ffffffff8cc0a098 (tasklist_lock){++++}-{2:2}, at: ptrace_attach+0x2c3/0x650 kernel/ptrace.c:464

the shortest dependencies between 2nd lock and 1st lock:
 -> (css_set_lock){..-.}-{2:2} {
    IN-SOFTIRQ-W at:
                      lock_acquire kernel/locking/lockdep.c:5753 [inline]
                      lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
                      put_css_set kernel/cgroup/cgroup-internal.h:208 [inline]
                      put_css_set kernel/cgroup/cgroup-internal.h:196 [inline]
                      cgroup_free+0x7c/0x1d0 kernel/cgroup/cgroup.c:6748
                      __put_task_struct+0x10b/0x3d0 kernel/fork.c:992
                      put_task_struct include/linux/sched/task.h:136 [inline]
                      put_task_struct include/linux/sched/task.h:123 [inline]
                      delayed_put_task_struct+0x22c/0x2d0 kernel/exit.c:227
                      rcu_do_batch kernel/rcu/tree.c:2158 [inline]
                      rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2431
                      __do_softirq+0x216/0x8d5 kernel/softirq.c:553
                      invoke_softirq kernel/softirq.c:427 [inline]
                      __irq_exit_rcu kernel/softirq.c:632 [inline]
                      irq_exit_rcu+0xb5/0x120 kernel/softirq.c:644
                      sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
                      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
                      lock_acquire+0x1f2/0x530 kernel/locking/lockdep.c:5721
                      rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
                      rcu_read_lock include/linux/rcupdate.h:747 [inline]
                      __mod_lruvec_page_state+0xbf/0x390 mm/memcontrol.c:881
                      __lruvec_stat_mod_folio include/linux/vmstat.h:615 [inline]
                      folio_add_new_anon_rmap+0x19f/0xa00 mm/rmap.c:1331
                      wp_page_copy mm/memory.c:3193 [inline]
                      do_wp_page+0x1973/0x36d0 mm/memory.c:3515
                      handle_pte_fault mm/memory.c:5059 [inline]
                      __handle_mm_fault+0x1d7d/0x3d70 mm/memory.c:5184
                      handle_mm_fault+0x476/0xa00 mm/memory.c:5349
                      do_user_addr_fault+0x309/0x1000 arch/x86/mm/fault.c:1364
                      handle_page_fault arch/x86/mm/fault.c:1505 [inline]
                      exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1561
                      asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5753 [inline]
                     lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                     __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                     _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
                     spin_lock_irq include/linux/spinlock.h:376 [inline]
                     cgroup_setup_root+0x62c/0xa00 kernel/cgroup/cgroup.c:2138
                     cgroup_init+0x23f/0x1100 kernel/cgroup/cgroup.c:6120
                     start_kernel+0x385/0x480 init/main.c:1063
                     x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
                     x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
                     secondary_startup_64_no_verify+0x166/0x16b
  }
  ... key      at: [<ffffffff8cff86b8>] css_set_lock+0x18/0x60
  ... acquired at:
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
   __lock_task_sighand+0xc2/0x340 kernel/signal.c:1422
   lock_task_sighand include/linux/sched/signal.h:748 [inline]
   cgroup_freeze_task+0x80/0x190 kernel/cgroup/freezer.c:160
   cgroup_freezer_migrate_task+0x1b7/0x3a0 kernel/cgroup/freezer.c:257
   cgroup_migrate_execute+0x2d3/0x1230 kernel/cgroup/cgroup.c:2580
   cgroup_attach_task+0x5a8/0x8e0 kernel/cgroup/cgroup.c:2888
   __cgroup_procs_write+0x311/0x540 kernel/cgroup/cgroup.c:5196
   cgroup_procs_write+0x26/0x50 kernel/cgroup/cgroup.c:5209
   cgroup_file_write+0x209/0x7c0 kernel/cgroup/cgroup.c:4092
   kernfs_fop_write_iter+0x33f/0x500 fs/kernfs/file.c:334
   call_write_iter include/linux/fs.h:2021 [inline]
   new_sync_write fs/read_write.c:491 [inline]
   vfs_write+0x64d/0xdf0 fs/read_write.c:584
   ksys_write+0x12f/0x250 fs/read_write.c:637
   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
   entry_SYSCALL_64_after_hwframe+0x62/0x6a

-> (&sighand->siglock){+.+.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5753 [inline]
                    lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    class_spinlock_constructor include/linux/spinlock.h:530 [inline]
                    ptrace_set_stopped kernel/ptrace.c:391 [inline]
                    ptrace_attach+0x401/0x650 kernel/ptrace.c:478
                    __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
                    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                    do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                    entry_SYSCALL_64_after_hwframe+0x62/0x6a
   SOFTIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5753 [inline]
                    lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    class_spinlock_constructor include/linux/spinlock.h:530 [inline]
                    ptrace_set_stopped kernel/ptrace.c:391 [inline]
                    ptrace_attach+0x401/0x650 kernel/ptrace.c:478
                    __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
                    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
                    do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
                    entry_SYSCALL_64_after_hwframe+0x62/0x6a
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5753 [inline]
                   lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:376 [inline]
                   calculate_sigpending+0x44/0xa0 kernel/signal.c:197
                   ret_from_fork+0x23/0x80 arch/x86/kernel/process.c:143
                   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 }
 ... key      at: [<ffffffff90b49f80>] __key.341+0x0/0x40
 ... acquired at:
   mark_usage kernel/locking/lockdep.c:4590 [inline]
   __lock_acquire+0x967/0x3b10 kernel/locking/lockdep.c:5090
   lock_acquire kernel/locking/lockdep.c:5753 [inline]
   lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   class_spinlock_constructor include/linux/spinlock.h:530 [inline]
   ptrace_set_stopped kernel/ptrace.c:391 [inline]
   ptrace_attach+0x401/0x650 kernel/ptrace.c:478
   __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
   do_syscall_x64 arch/x86/entry/common.c:51 [inline]
   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
   entry_SYSCALL_64_after_hwframe+0x62/0x6a


stack backtrace:
CPU: 0 PID: 8349 Comm: syz-executor.0 Not tainted 6.7.0-rc1-next-20231116-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_irq_inversion_bug.part.0+0x3e1/0x590 kernel/locking/lockdep.c:4079
 print_irq_inversion_bug kernel/locking/lockdep.c:4032 [inline]
 check_usage_forwards kernel/locking/lockdep.c:4110 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4242 [inline]
 mark_lock+0x570/0xc50 kernel/locking/lockdep.c:4677
 mark_usage kernel/locking/lockdep.c:4590 [inline]
 __lock_acquire+0x967/0x3b10 kernel/locking/lockdep.c:5090
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 class_spinlock_constructor include/linux/spinlock.h:530 [inline]
 ptrace_set_stopped kernel/ptrace.c:391 [inline]
 ptrace_attach+0x401/0x650 kernel/ptrace.c:478
 __do_sys_ptrace+0x204/0x230 kernel/ptrace.c:1290
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f1cbae7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1cbbc160c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000065
RAX: ffffffffffffffda RBX: 00007f1cbaf9c120 RCX: 00007f1cbae7cae9
RDX: 0000000000000000 RSI: 0000000000000198 RDI: 0000000000000010
RBP: 00007f1cbaec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f1cbaf9c120 R15: 00007ffcf4911798
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


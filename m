Return-Path: <cgroups+bounces-3502-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703F292479F
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 20:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E34289436
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 18:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9E21CCCA7;
	Tue,  2 Jul 2024 18:54:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF3143152
	for <cgroups@vger.kernel.org>; Tue,  2 Jul 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946468; cv=none; b=Q0PwCZe6IP3aCydoOWxFZXKh6Kch9mwDM2mkFKsPjj4EO5NAZ400GqDOYB17QmhXDqzGrIAc7mGyzJu6e204DtGnkq4POoYqs6BL+5m/c+u5iQfcj8o8jV8GWwfmn3mn1AFx0/WpIS2MIcshbOABb3Hv9Z4eL80mbarfxmh1a6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946468; c=relaxed/simple;
	bh=9G4wOeIwf5ploeNF30ak/FAUx4/xtayEJ1hWnxnrfPc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WxJNytBK4v5GiS4Sw8fLkKgGFTTPdWPtIjyuFa+wcSYUlNh7UCVmEis+b8jr+2wI+5onswJ2L8jO+khhJY9PT4doVhuu/HIXcWqlzFlJW2okTLjNmSwMKGBsa5khB1fZGJS51opnEId/79McuN1d9Hvx3yg9VXemitXHf3Mmmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f648151005so234601139f.1
        for <cgroups@vger.kernel.org>; Tue, 02 Jul 2024 11:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946466; x=1720551266;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ayBkiWWazh08zh1Rk4ClkHRgsUu4SJ893J55DMzfyBU=;
        b=tuSPekMJT/6lpkilBQLOTiyj9pw5ljtfMNcBbvI+2gw1I3UcLoXtBxxRPHTGQbr92r
         QmvU14AVFGnbnUwK+vtNy/01s5agoU/j5rlVgtJFfLlDZePdo2byRlwrBOqX+NTCJbfb
         rj0cKrVXGhTnDZd9FzO333brGbNjyRa+I7g27Pawhd2PquAaWNoNseOFLGqIcRl1YcCd
         dWk9DaL/Z0a3OaISjwiYHEgAtSUogfsHdjBIf9a3t1xM1u7RQazCaC+YchaHrIEpufo4
         O6MDGup8R4SVTryEXTXFWZySDlj6pnDjcoTL8CTu5LEZWhw1x99wt3cv1ATKqOdpAfRQ
         nKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCBbD8+pJKcg2hZ8MAK9Tph71hH1u9T7ht2zYXZyKegOjDBstRHdE6X0uIhZJGWi9M4MIh0TiX1F3hc6kHQx8AeCklLAVpRA==
X-Gm-Message-State: AOJu0Yxbm8GDrX0jgNsQx3hL8HdYgANFCHqzQQF3X+RE+o8HucypMjUZ
	sA6p1nHi+/gwT3aEmQ8XLrIu3kafSUQn1nSnWXZ54NfFqI1JsZF88qC3y/ul9f7ahb5vxM4+WTo
	g5+4SQB/plY8B33VQoLK8fBt42fFnx2yfrxzB2v4N1vHUqEZZBCV8pgc=
X-Google-Smtp-Source: AGHT+IFEa4YWBdAhrJz19jN8b+Sj5EhnUWJnDjbnm2mLwblaROPIBs5zqCZhx3SZuLkVMblRrmGq2JaYN6+Nwp5dEXFL41ZYg3R/
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2389:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4bbb6ec54d2mr522953173.1.1719946466543; Tue, 02 Jul 2024
 11:54:26 -0700 (PDT)
Date: Tue, 02 Jul 2024 11:54:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002be09b061c483ea1@google.com>
Subject: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_released
From: syzbot <syzbot+16b6ab88e66b34d09014@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	hawk@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, lizefan.x@bytedance.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, netdev@vger.kernel.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a12978712d90 selftests/bpf: Move ARRAY_SIZE to bpf_misc.h
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=130457fa980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=736daf12bd72e034
dashboard link: https://syzkaller.appspot.com/bug?extid=16b6ab88e66b34d09014
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125718be980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14528876980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d845a55bf58/disk-a1297871.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/12cb27bdb2de/vmlinux-a1297871.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db09a1fa448c/bzImage-a1297871.xz

The issue was bisected to:

commit 21c38a3bd4ee3fb7337d013a638302fb5e5f9dc2
Author: Jesper Dangaard Brouer <hawk@kernel.org>
Date:   Wed May 1 14:04:11 2024 +0000

    cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ecc085980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ecc085980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ecc085980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+16b6ab88e66b34d09014@syzkaller.appspotmail.com
Fixes: 21c38a3bd4ee ("cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints")

============================================
WARNING: possible recursive locking detected
6.10.0-rc2-syzkaller-00797-ga12978712d90 #0 Not tainted
--------------------------------------------
syz-executor646/5097 is trying to acquire lock:
ffff8880b94387e8 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b94387e8 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_released+0x83/0x620 mm/mmap_lock.c:243

but task is already holding lock:
ffff8880b94387e8 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b94387e8 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_released+0x83/0x620 mm/mmap_lock.c:243

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(lock#9);
  lock(lock#9);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz-executor646/5097:
 #0: ffff8880182eb118 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
 #0: ffff8880182eb118 (&mm->mmap_lock){++++}-{3:3}, at: acct_collect+0x1cf/0x830 kernel/acct.c:563
 #1: ffff8880b94387e8 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 #1: ffff8880b94387e8 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_released+0x83/0x620 mm/mmap_lock.c:243
 #2: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: get_memcg_path_buf mm/mmap_lock.c:139 [inline]
 #2: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: get_mm_memcg_path+0xb1/0x600 mm/mmap_lock.c:209
 #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: trace_call_bpf+0xbc/0x8a0
 #4: ffff8880182eb118 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 #4: ffff8880182eb118 (&mm->mmap_lock){++++}-{3:3}, at: stack_map_get_build_id_offset+0x237/0x9d0 kernel/bpf/stackmap.c:141

stack backtrace:
CPU: 0 PID: 5097 Comm: syz-executor646 Not tainted 6.10.0-rc2-syzkaller-00797-ga12978712d90 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 __mmap_lock_do_trace_released+0x9c/0x620 mm/mmap_lock.c:243
 __mmap_lock_trace_released include/linux/mmap_lock.h:42 [inline]
 mmap_read_unlock include/linux/mmap_lock.h:170 [inline]
 bpf_mmap_unlock_mm kernel/bpf/mmap_unlock_work.h:52 [inline]
 stack_map_get_build_id_offset+0x9c7/0x9d0 kernel/bpf/stackmap.c:173
 __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
 bpf_prog_e6cf5f9c69743609+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 bpf_prog_run_array include/linux/bpf.h:2104 [inline]
 trace_call_bpf+0x369/0x8a0 kernel/trace/bpf_trace.c:147
 perf_trace_run_bpf_submit+0x7c/0x1d0 kernel/events/core.c:10269
 perf_trace_mmap_lock+0x3d7/0x510 include/trace/events/mmap_lock.h:16
 trace_mmap_lock_released include/trace/events/mmap_lock.h:50 [inline]
 __mmap_lock_do_trace_released+0x5bb/0x620 mm/mmap_lock.c:243
 __mmap_lock_trace_released include/linux/mmap_lock.h:42 [inline]
 mmap_read_unlock include/linux/mmap_lock.h:170 [inline]
 acct_collect+0x81d/0x830 kernel/acct.c:566
 do_exit+0x936/0x27e0 kernel/exit.c:853
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 __do_sys_exit_group kernel/exit.c:1034 [inline]
 __se_sys_exit_group kernel/exit.c:1032 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8fac26d039
Code: 90 49 c7 c0 b8 ff ff ff be e7 00 00 00 ba 3c 00 00 00 eb 12 0f 1f 44 00 00 89 d0 0f 05 48 3d 00 f0 ff ff 77 1c f4 89 f0 0f 05 <48> 3d 00 f0 ff ff 76 e7 f7 d8 64 41 89 00 eb df 0f 1f 80 00 00 00
RSP: 002b:00007ffd95d56e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8fac26d039
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f8fac2e82b0 R08: ffffffffffffffb8 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8fac2e82b0
R13: 0000000000000000 R14: 00007f8fac2e8d20 R15: 00007f8fac23e1e0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


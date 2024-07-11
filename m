Return-Path: <cgroups+bounces-3625-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E592EAC8
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB3228220C
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61B11667FA;
	Thu, 11 Jul 2024 14:32:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7149A1EB26;
	Thu, 11 Jul 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708341; cv=none; b=Ff/MpA4ZKFEPDe9XjwaNBHu7872HDvq87LpZPqxfH2bSrqvh9gcKehW5X5cwR6WpNhZJ37T/JerBS92P5+0P77J2tGDHOOgWHMjotZpQeZk+d0Biv8fMgSsuvD8sMLnXcvsyBF/LQnmo4JHd5+R++c8Gp9mnuFQEfm6FV2xq1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708341; c=relaxed/simple;
	bh=up6W1K9mpxjGZ1T7a2dLYu/IsvtphCU8x2Vb6BTu6Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWzZ+Kf7q7kK24gD82ASCYCPwn9zsWjyCWIsfG2+g7cRZGOtlmgoyHqjVt0BxyqAOVE3cROPb23D8Cw3i29h4yz42sHYU8vdyYanmIU6Uz2b9OtJLXE9ja5ADPFnSDjQoEO7XMlGKe1z/owrrwth0j3ZOrqm6zMnx6PLPFk1JGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92796C116B1;
	Thu, 11 Jul 2024 14:32:19 +0000 (UTC)
Date: Thu, 11 Jul 2024 10:33:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: syzbot <syzbot+16b6ab88e66b34d09014@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, lizefan.x@bytedance.com,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Subject: Re: [syzbot] [mm?] possible deadlock in
 __mmap_lock_do_trace_released
Message-ID: <20240711103341.18a4eb4e@gandalf.local.home>
In-Reply-To: <95930836-5b56-4c40-b2a0-2ddd4a59ae74@kernel.org>
References: <0000000000002be09b061c483ea1@google.com>
	<95930836-5b56-4c40-b2a0-2ddd4a59ae74@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 22:12:45 +0200
Jesper Dangaard Brouer <hawk@kernel.org> wrote:

> > ============================================
> > WARNING: possible recursive locking detected
> > 6.10.0-rc2-syzkaller-00797-ga12978712d90 #0 Not tainted
> > --------------------------------------------
> > syz-executor646/5097 is trying to acquire lock:
> > ffff8880b94387e8 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
> > ffff8880b94387e8 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_released+0x83/0x620 mm/mmap_lock.c:243
> > 
> > but task is already holding lock:
> > ffff8880b94387e8 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
> > ffff8880b94387e8 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_released+0x83/0x620 mm/mmap_lock.c:243
> > 
> > other info that might help us debug this:
> >   Possible unsafe locking scenario:
> > 
> >         CPU0
> >         ----
> >    lock(lock#9);
> >    lock(lock#9);
> > 
> >   *** DEADLOCK ***

Looks like it's trying to take the rwsem mm->mmap_lock recursively. And
rwsems are *not* allowed to be recursively taken, as once there's a writer,
all new acquires of the reader will block. Then you can have:

   CPU0				    CPU1
   ----				    ----
  down_read(lockA);
				down_write(lockA); // blocks
  down_read(lockA); //blocks

DEADLOCK!


> > 
> >   May be due to missing lock nesting notation
> >   
> 
> To me, this looks like a lockdep false-positive, but I might be wrong.
> 
> Could someone with more LOCKDEP knowledge give their interpretation?
> 
> The commit[1] adds a fairly standard trylock scheme.
> Do I need to lockdep annotate trylock's in some special way?
> 
>   [1] https://git.kernel.org/torvalds/c/21c38a3bd4ee3fb733
> 
> Also notice change uses raw_spin_lock, which might be harder for lockdep?
> So, I also enabled CONFIG_PROVE_RAW_LOCK_NESTING in my testlab to help
> with this, and CONFIG_PROVE_LOCKING.
> (And obviously I also enabled LOCKDEP*)
> 
> --Jesper
> 
> > 5 locks held by syz-executor646/5097:
> >   #0: ffff8880182eb118 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
> >   #0: ffff8880182eb118 (&mm->mmap_lock){++++}-{3:3}, at: acct_collect+0x1cf/0x830 kernel/acct.c:563
> >   #1: ffff8880b94387e8 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
> >   #1: ffff8880b94387e8 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_released+0x83/0x620 mm/mmap_lock.c:243
> >   #2: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
> >   #2: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
> >   #2: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: get_memcg_path_buf mm/mmap_lock.c:139 [inline]
> >   #2: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: get_mm_memcg_path+0xb1/0x600 mm/mmap_lock.c:209
> >   #3: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: trace_call_bpf+0xbc/0x8a0
> >   #4: ffff8880182eb118 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
> >   #4: ffff8880182eb118 (&mm->mmap_lock){++++}-{3:3}, at: stack_map_get_build_id_offset+0x237/0x9d0 kernel/bpf/stackmap.c:141
> > 
> > stack backtrace:
> > CPU: 0 PID: 5097 Comm: syz-executor646 Not tainted 6.10.0-rc2-syzkaller-00797-ga12978712d90 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> > Call Trace:
> >   <TASK>
> >   __dump_stack lib/dump_stack.c:88 [inline]
> >   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> >   check_deadlock kernel/locking/lockdep.c:3062 [inline]
> >   validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3856
> >   __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
> >   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
> >   local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
> >   __mmap_lock_do_trace_released+0x9c/0x620 mm/mmap_lock.c:243

Here we have:

  static inline void mmap_read_lock(struct mm_struct *mm)
  {
        __mmap_lock_trace_start_locking(mm, false);
        down_read(&mm->mmap_lock);
        __mmap_lock_trace_acquire_returned(mm, false, true);
  }

Which is taking the mm->mmap_lock for read.

> >   __mmap_lock_trace_released include/linux/mmap_lock.h:42 [inline]
> >   mmap_read_unlock include/linux/mmap_lock.h:170 [inline]
> >   bpf_mmap_unlock_mm kernel/bpf/mmap_unlock_work.h:52 [inline]
> >   stack_map_get_build_id_offset+0x9c7/0x9d0 kernel/bpf/stackmap.c:173
> >   __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
> >   bpf_prog_e6cf5f9c69743609+0x42/0x46
> >   bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
> >   __bpf_prog_run include/linux/filter.h:691 [inline]
> >   bpf_prog_run include/linux/filter.h:698 [inline]
> >   bpf_prog_run_array include/linux/bpf.h:2104 [inline]
> >   trace_call_bpf+0x369/0x8a0 kernel/trace/bpf_trace.c:147
> >   perf_trace_run_bpf_submit+0x7c/0x1d0 kernel/events/core.c:10269
> >   perf_trace_mmap_lock+0x3d7/0x510 include/trace/events/mmap_lock.h:16

I'm guessing a bpf program attached to something within the same code:

> >   trace_mmap_lock_released include/trace/events/mmap_lock.h:50 [inline]
> >   __mmap_lock_do_trace_released+0x5bb/0x620 mm/mmap_lock.c:243

Here is the same function as above where it took the mm->mmap_lock.

My guess is the bpf program that attached to this event ends up calling the
same function and it tries to take the rwsem again, and that poses a risk
for deadlock.

-- Steve

> >   __mmap_lock_trace_released include/linux/mmap_lock.h:42 [inline]
> >   mmap_read_unlock include/linux/mmap_lock.h:170 [inline]
> >   acct_collect+0x81d/0x830 kernel/acct.c:566
> >   do_exit+0x936/0x27e0 kernel/exit.c:853
> >   do_group_exit+0x207/0x2c0 kernel/exit.c:1023
> >   __do_sys_exit_group kernel/exit.c:1034 [inline]
> >   __se_sys_exit_group kernel/exit.c:1032 [inline]
> >   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1032
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f8fac26d039
> > Code: 90 49 c7 c0 b8 ff ff ff be e7 00 00 00 ba 3c 00 00 00 eb 12 0f 1f
> > 44 00 00 89 d0 0f 05 48 3d 00 f0 ff ff 77 1c f4 89 f0 0f 05 <48> 3d 00
> > f0 ff ff 76 e7 f7 d8 64 41 89 00 eb df 0f 1f 80 00 00 00 RSP:
> > 002b:00007ffd95d56e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7 RAX:
> > ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8fac26d039 RDX:
> > 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000 RBP:
> > 00007f8fac2e82b0 R08: ffffffffffffffb8 R09: 00000000000000a0 R10:
> > 0000000000000000 R11: 0000000000000246 R12: 00007f8fac2e82b0 R13:
> > 0000000000000000 R14: 00007f8fac2e8d20 R15: 00007f8fac23e1e0 </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process
> > see: https://goo.gl/tpsmEJ#bisection
> > 
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> > 
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup  



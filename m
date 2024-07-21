Return-Path: <cgroups+bounces-3832-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6173F9384A8
	for <lists+cgroups@lfdr.de>; Sun, 21 Jul 2024 15:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147BC28132F
	for <lists+cgroups@lfdr.de>; Sun, 21 Jul 2024 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9BA160877;
	Sun, 21 Jul 2024 13:14:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658811581E0
	for <cgroups@vger.kernel.org>; Sun, 21 Jul 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721567663; cv=none; b=M6edLMllDGX3Vv0F1dahlwPCAjz/vcSHW8dUZHVZXXSdt6UGwGzDMchexM6wduJq5rUu7cCUoki3+lUyybGaXaSp9rAKoapA7CAXiv2OjzNTOCCrF+MgeIV2JXN+YDMsxGmtV1pRdJvktkyZOjD46S/9hDCznVi0/HaZ2gwNLMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721567663; c=relaxed/simple;
	bh=n9egGMoFbIqfnlnitSOF3+rXGnAwAU5CsyuQsIbrcqw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YGO2ATLFi57O6K555Hk5a9MnZjSGBOX9M13tx/48kfNlShw/LoBwYx09Uy1COdz672EYddaEDYF5SDc+IepnOu+2/n7/kwjagAt1wgvoam2aLs6zV6TzR2uYVwNRVS5FP4jzysooq0UTWxfgykMxTm2T7rJcIR2srjqe7Kt/suY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39858681a32so35841185ab.2
        for <cgroups@vger.kernel.org>; Sun, 21 Jul 2024 06:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721567660; x=1722172460;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vde6ZLE00Sya+q2ATm6+hgPJax0lxOI4uva3UKxdCIY=;
        b=UScHu4R/nCLwharZEydRBqz1KHSLuau4dbfAAeq8cy7JyhoBu0bzS/qp3DDBCpOOLT
         YKHsz+Tsx+uFjAjODwFzuLpajpo1qnLXfwPpnELi/Y2acuF4lmk+qMU8oKwfvvLX6Yq1
         /wiXnkRhQfg7rukeesJughfXZG/qib0bNiIBQnzDQtL8h1+WZFHt+4fg2Dabn5e9VyUb
         rDmAm3l/7+VLhEu+Akx8ZN1hz3352blhBmGyiAmjaSrH0vIqrYlhiIAQWiIMMc235aHi
         qAdUpmmAYu4zJi/fUMhbed+g3xb1fu6fqt/E2ZT2ayGba0+KmluRMl9jO+OpyiAXCL4T
         TgyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9XBFbWCXGEk1rB/pyAFxhKfZF1+yJxGRl/EZXUczHReOqitFwqJY6MQ+DpmaYXDOLQRTL45EkoABmGTBQqsxWczdQsEqjjw==
X-Gm-Message-State: AOJu0Yw/h0PcDX79jRoEfdNlXPjIJWGkotquhLpRkOJMYlHYIGKvWazM
	042BV6WavF2F/qDnx3xehEZzFF5evzFKpqQpMwjSqbB55Kw2NEjdLPfkxpXVtftW6EblGE09035
	aLbopcBvUxxytz9pqDrol37w/1Vr0Pen0nihsdRzAjHfpdiUaH8F03eE=
X-Google-Smtp-Source: AGHT+IEKO/EaXaZ6Oo4w2G1YS/BPI798GOb4bYtmRzbbEdVlVV6B53y2HC1Nk4W2ayLY1j7/4omlEZTM+L8QoxRUqzJPpPrzwXt3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:375:a535:f7ad with SMTP id
 e9e14a558f8ab-398e1995b14mr4506415ab.0.1721567660563; Sun, 21 Jul 2024
 06:14:20 -0700 (PDT)
Date: Sun, 21 Jul 2024 06:14:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd7346061dc1b458@google.com>
Subject: [syzbot] [cgroups?] [mm?] possible deadlock in try_charge_memcg
From: syzbot <syzbot+4825929f4608b51ff236@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D100c85e9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd27aad3c6f6c0b6=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3D4825929f4608b51ff=
236
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/96f6abdf83f2/disk-=
51835949.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ebfb97e3cc28/vmlinux-=
51835949.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c810b8ffe9f0/bzI=
mage-51835949.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+4825929f4608b51ff236@syzkaller.appspotmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.10.0-syzkaller-04472-g51835949dda3 #0 Not tainted
------------------------------------------------------
kworker/1:6/23181 is trying to acquire lock:
ffff8880b933dbd8 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x26b/0x1070 k=
ernel/workqueue.c:2301

but task is already holding lock:
ffff8880b9339680 (stock_lock){-.-.}-{2:2}, at: local_lock_acquire+0x10/0x15=
0 include/linux/local_lock_internal.h:29

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (stock_lock){-.-.}-{2:2}:
       local_lock_acquire+0x23/0x150 include/linux/local_lock_internal.h:29
       consume_stock mm/memcontrol.c:2476 [inline]
       try_charge_memcg+0x15c/0x10b0 mm/memcontrol.c:2905
       obj_cgroup_charge_pages mm/memcontrol.c:3416 [inline]
       __memcg_kmem_charge_page+0xda/0x420 mm/memcontrol.c:3442
       __alloc_pages_noprof+0x25b/0x2460 mm/page_alloc.c:4700
       __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
       alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
       __kmalloc_large_node+0x7f/0x1a0 mm/slub.c:4068
       __do_kmalloc_node mm/slub.c:4111 [inline]
       __kmalloc_node_noprof.cold+0x5/0x5f mm/slub.c:4130
       kmalloc_node_noprof include/linux/slab.h:681 [inline]
       bpf_map_kmalloc_node+0x98/0x4a0 kernel/bpf/syscall.c:422
       lpm_trie_node_alloc kernel/bpf/lpm_trie.c:299 [inline]
       trie_update_elem+0x1ef/0xe00 kernel/bpf/lpm_trie.c:342
       bpf_map_update_value+0x2c4/0x6c0 kernel/bpf/syscall.c:203
       map_update_elem+0x623/0x910 kernel/bpf/syscall.c:1654
       __sys_bpf+0x90c/0x4a30 kernel/bpf/syscall.c:5698
       __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
       __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5815
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&trie->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline=
]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       trie_delete_elem+0xb0/0x820 kernel/bpf/lpm_trie.c:462
       0xffffffffa00008ee
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
       bpf_trace_run4+0x248/0x5a0 kernel/trace/bpf_trace.c:2449
       __bpf_trace_sched_switch+0x13e/0x190 include/trace/events/sched.h:22=
2
       __traceiter_sched_switch+0x6f/0xc0 include/trace/events/sched.h:222
       trace_sched_switch include/trace/events/sched.h:222 [inline]
       __schedule+0x17cf/0x5490 kernel/sched/core.c:6526
       preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6708
       preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
       class_preempt_destructor include/linux/preempt.h:480 [inline]
       class_preempt_destructor include/linux/preempt.h:480 [inline]
       try_to_wake_up+0xc08/0x13e0 kernel/sched/core.c:4022
       wake_up_process kernel/sched/core.c:4299 [inline]
       wake_up_q+0x91/0x140 kernel/sched/core.c:1029
       futex_wake+0x43e/0x4e0 kernel/futex/waitwake.c:199
       do_futex+0x1e5/0x350 kernel/futex/syscalls.c:107
       __do_sys_futex kernel/futex/syscalls.c:179 [inline]
       __se_sys_futex kernel/futex/syscalls.c:160 [inline]
       __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:560
       raw_spin_rq_lock kernel/sched/sched.h:1415 [inline]
       rq_lock kernel/sched/sched.h:1714 [inline]
       task_fork_fair+0x73/0x250 kernel/sched/fair.c:12710
       sched_cgroup_fork+0x3d2/0x510 kernel/sched/core.c:4633
       copy_process+0x43a1/0x8de0 kernel/fork.c:2482
       kernel_clone+0xfd/0x980 kernel/fork.c:2780
       user_mode_thread+0xb4/0xf0 kernel/fork.c:2858
       rest_init+0x23/0x2b0 init/main.c:712
       start_kernel+0x3df/0x4c0 init/main.c:1103
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x148

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline=
]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 =
[inline]
       try_to_wake_up+0x9a/0x13e0 kernel/sched/core.c:4051
       create_worker+0x333/0x800 kernel/workqueue.c:2827
       workqueue_init+0x4b4/0xb70 kernel/workqueue.c:7837
       kernel_init_freeable+0x32f/0xca0 init/main.c:1562
       kernel_init+0x1c/0x2b0 init/main.c:1467
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&pool->lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5718
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x26b/0x1070 kernel/workqueue.c:2301
       queue_work_on+0x11a/0x140 kernel/workqueue.c:2392
       percpu_ref_put_many include/linux/percpu-refcount.h:335 [inline]
       percpu_ref_put include/linux/percpu-refcount.h:351 [inline]
       css_put include/linux/cgroup_refcnt.h:79 [inline]
       css_put include/linux/cgroup_refcnt.h:76 [inline]
       drain_stock+0x287/0x2e0 mm/memcontrol.c:2509
       __refill_stock+0x80/0x270 mm/memcontrol.c:2546
       drain_obj_stock+0x293/0x3a0 mm/memcontrol.c:3574
       drain_local_stock+0xb0/0x330 mm/memcontrol.c:2527
       process_one_work+0x9c8/0x1b40 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
       kthread+0x2c4/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &pool->lock --> &trie->lock --> stock_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(stock_lock);
                               lock(&trie->lock);
                               lock(stock_lock);
  lock(&pool->lock);

 *** DEADLOCK ***

5 locks held by kworker/1:6/23181:
 #0: ffff888015478948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_=
work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90004a2fd80 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((&memcg_stock) + 0))((void *)0); (void)__vpp_verify; } while (0=
); ({ unsigned long __ptr; __asm__ ("" : "=3Dr"(__ptr) : "0"((typeof(*((&me=
mcg_stock))) *)((&memcg_stock)))); (typeof((typeof(*((&memcg_stock))) *)((&=
memcg_stock)))) (__ptr + (((__per_cpu_offset[(cpu)])))); }); })->work)){+.+=
.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff8880b9339680 (stock_lock){-.-.}-{2:2}, at: local_lock_acquire+0x10=
/0x150 include/linux/local_lock_internal.h:29
 #3: ffffffff8dbb58a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire inc=
lude/linux/rcupdate.h:327 [inline]
 #3: ffffffff8dbb58a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock includ=
e/linux/rcupdate.h:839 [inline]
 #3: ffffffff8dbb58a0 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put_many =
include/linux/percpu-refcount.h:330 [inline]
 #3: ffffffff8dbb58a0 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put inclu=
de/linux/percpu-refcount.h:351 [inline]
 #3: ffffffff8dbb58a0 (rcu_read_lock){....}-{1:2}, at: css_put include/linu=
x/cgroup_refcnt.h:79 [inline]
 #3: ffffffff8dbb58a0 (rcu_read_lock){....}-{1:2}, at: css_put include/linu=
x/cgroup_refcnt.h:76 [inline]
 #3: ffffffff8dbb58a0 (rcu_read_lock){....}-{1:2}, at: drain_stock+0x13c/0x=
2e0 mm/memcontrol.c:2509
 #4: ffffffff8dbb58a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire inc=
lude/linux/rcupdate.h:327 [inline]
 #4: ffffffff8dbb58a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock includ=
e/linux/rcupdate.h:839 [inline]
 #4: ffffffff8dbb58a0 (rcu_read_lock){....}-{1:2}, at: __queue_work+0xf2/0x=
1070 kernel/workqueue.c:2261

stack backtrace:
CPU: 1 PID: 23181 Comm: kworker/1:6 Not tainted 6.10.0-syzkaller-04472-g518=
35949dda3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 06/07/2024
Workqueue: events drain_local_stock
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5718
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x26b/0x1070 kernel/workqueue.c:2301
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2392
 percpu_ref_put_many include/linux/percpu-refcount.h:335 [inline]
 percpu_ref_put include/linux/percpu-refcount.h:351 [inline]
 css_put include/linux/cgroup_refcnt.h:79 [inline]
 css_put include/linux/cgroup_refcnt.h:76 [inline]
 drain_stock+0x287/0x2e0 mm/memcontrol.c:2509
 __refill_stock+0x80/0x270 mm/memcontrol.c:2546
 drain_obj_stock+0x293/0x3a0 mm/memcontrol.c:3574
 drain_local_stock+0xb0/0x330 mm/memcontrol.c:2527
 process_one_work+0x9c8/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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


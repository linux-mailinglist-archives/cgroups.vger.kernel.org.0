Return-Path: <cgroups+bounces-4880-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7938A978D7F
	for <lists+cgroups@lfdr.de>; Sat, 14 Sep 2024 07:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9647A1C224B1
	for <lists+cgroups@lfdr.de>; Sat, 14 Sep 2024 05:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9024720328;
	Sat, 14 Sep 2024 05:23:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143917BBF
	for <cgroups@vger.kernel.org>; Sat, 14 Sep 2024 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291401; cv=none; b=BzwxrWhffV2ZQ5NZmv61nkbi1d3z8o5L/GOwKK2Q1y0q+P7u+pnQo/vtdtBGBbAHuvXwL16ts7jUvOitXtlAqXkwLNfPVqGLwEyIoUf5FYhkJ/vSzq3QjtHL2TOnsTy4SXKh7sf/AxgKtIaZYN+E5Gh4EfuVzB++s5yPBq/54mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291401; c=relaxed/simple;
	bh=i33NVdGmhxMeJpPIx773VKdMN1cLXUnLKgeBZrGQR08=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gNq4uiUQu9dwog3pn8RvGua3HLYfuOgdyyDfd14UIit1xnTrBWopyMZbrfKEqTuAb0E6LiBjq9j34oOnf+5roQAAhKyDO43W7loLLv2NjoWM0l14lL+Eo5J8STXdC4z2iCHzlBwqxnIK0Z2601vjH4zeBS/FtlvKGsAL8qSsfw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f5328fd5eso40656045ab.2
        for <cgroups@vger.kernel.org>; Fri, 13 Sep 2024 22:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726291398; x=1726896198;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IuzhE3quXoWLaf8W8LHd6PqdLfaO1wjo2HTcmvuxTMs=;
        b=SB8gEFsLTcrOAR3L/TCVMboKXsHDNBgVM/cQ0FO+Z+8iunzD7JbpBmrlPuxNDifSqR
         V7VZiDwqcHUXJbot0SplSRLG+ZbbWn+TRzqoSQlxGC6WvJQi5pQaak8gdQOMU/QJyNiH
         INBqmXtm0CHo+pw+xa6txdaPJrs5sEoz+J6NWYGADkYJT+iQjNz13OgCHm3nOVYLb5Qg
         7qJGnrMVCDV/rfGvkvHWe2P7f+6KA+aCYcsfYMd8znVcVjd16xlzuMhxDHc5r2WK29gA
         DceuoTOwX0ZXsYmsVsDuX83GFwocfCYqKMVOyBgFlJWptxDOcoAVtOXXjf8LZflz2K8n
         tQjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK5VFFwt3+1tssiq7D5SrqttqDFLTUwgAaRsWgDCwX5hFFvNGk02doYf/LsrtLtVYJz6CZ3aIJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+qIwuS3o89AN/yQDQPOnbmZoKCkHyILLkM5AehnOtX27stUC4
	1zRuLvRPAw1eLNK32pTO+lKJ7hoP8L44dVobvVbPHvNtfNnuJRTDmctRBahgvP2UvIsgctqwVY0
	Hn3vn5YwrH5C8ikLOU/KsJ+PYV0e/DSU4WLahNtxKihlSNPl7WteCiJw=
X-Google-Smtp-Source: AGHT+IEbbFc37o2ptQHTdnWKtB/vdHibyHqRMZ8AaBxIxHXoQX9APBMTiZgUJxUiynqm2f+WNBOKabIpOX2h8lLapdkt2eshK99W
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c549:0:b0:383:4a12:b77c with SMTP id
 e9e14a558f8ab-3a084902ac6mr97962545ab.8.1726291398627; Fri, 13 Sep 2024
 22:23:18 -0700 (PDT)
Date: Fri, 13 Sep 2024 22:23:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098231306220d8972@google.com>
Subject: [syzbot] [mm?] [cgroups?] possible deadlock in refill_stock
From: syzbot <syzbot+dfd0410e573d2afac470@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bc83b4d1f086 Merge tag 'bcachefs-2024-09-09' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1781a807980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61d235cb8d15001c
dashboard link: https://syzkaller.appspot.com/bug?extid=dfd0410e573d2afac470
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/beba571a2693/disk-bc83b4d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/827e1dae7a22/vmlinux-bc83b4d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a6d2fb15704/bzImage-bc83b4d1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dfd0410e573d2afac470@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc7-syzkaller-00017-gbc83b4d1f086 #0 Not tainted
------------------------------------------------------
syz-executor/5237 is trying to acquire lock:
ffff8880b893e158 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x759/0xf50

but task is already holding lock:
ffff8880b89394f8 (stock_lock){..-.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b89394f8 (stock_lock){..-.}-{2:2}, at: refill_stock+0x112/0x470 mm/memcontrol.c:1826

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (stock_lock){..-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
       consume_stock mm/memcontrol.c:1741 [inline]
       try_charge_memcg+0x27e/0x1170 mm/memcontrol.c:2171
       obj_cgroup_charge_pages+0x91/0x230 mm/memcontrol.c:2660
       __memcg_kmem_charge_page+0xc8/0x1d0 mm/memcontrol.c:2687
       __alloc_pages_noprof+0x28c/0x6c0 mm/page_alloc.c:4719
       __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
       alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
       ___kmalloc_large_node+0x8b/0x1d0 mm/slub.c:4107
       __kmalloc_large_node_noprof+0x1a/0x80 mm/slub.c:4134
       __do_kmalloc_node mm/slub.c:4150 [inline]
       __kmalloc_node_noprof+0x2d2/0x440 mm/slub.c:4168
       kmalloc_node_noprof include/linux/slab.h:708 [inline]
       bpf_map_kmalloc_node+0xd3/0x1c0 kernel/bpf/syscall.c:422
       lpm_trie_node_alloc kernel/bpf/lpm_trie.c:299 [inline]
       trie_update_elem+0x1cd/0xc00 kernel/bpf/lpm_trie.c:342
       bpf_map_update_value+0x4d5/0x540 kernel/bpf/syscall.c:203
       map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1654
       __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5698
       __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5815
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&trie->lock){....}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
       0xffffffffa0000912
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2406 [inline]
       bpf_trace_run4+0x336/0x590 kernel/trace/bpf_trace.c:2449
       __traceiter_sched_switch+0x9a/0xd0 include/trace/events/sched.h:222
       trace_sched_switch include/trace/events/sched.h:222 [inline]
       __schedule+0x2591/0x4a60 kernel/sched/core.c:6526
       __schedule_loop kernel/sched/core.c:6606 [inline]
       schedule+0x14b/0x320 kernel/sched/core.c:6621
       futex_wait_queue+0x14e/0x1d0 kernel/futex/waitwake.c:370
       __futex_wait+0x17f/0x320 kernel/futex/waitwake.c:669
       futex_wait+0x101/0x360 kernel/futex/waitwake.c:697
       do_futex+0x33b/0x560 kernel/futex/syscalls.c:102
       __do_sys_futex kernel/futex/syscalls.c:179 [inline]
       __se_sys_futex+0x3f9/0x480 kernel/futex/syscalls.c:160
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
       raw_spin_rq_lock kernel/sched/sched.h:1415 [inline]
       rq_lock kernel/sched/sched.h:1714 [inline]
       task_fork_fair+0x61/0x1e0 kernel/sched/fair.c:12710
       sched_cgroup_fork+0x37e/0x410 kernel/sched/core.c:4633
       copy_process+0x2217/0x3dc0 kernel/fork.c:2483
       kernel_clone+0x226/0x8f0 kernel/fork.c:2781
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2859
       rest_init+0x23/0x300 init/main.c:712
       start_kernel+0x47a/0x500 init/main.c:1103
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
       try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4051
       create_worker+0x507/0x720 kernel/workqueue.c:2827
       workqueue_init+0x520/0x8a0 kernel/workqueue.c:7841
       kernel_init_freeable+0x3fe/0x5d0 init/main.c:1562
       kernel_init+0x1d/0x2b0 init/main.c:1467
       ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&pool->lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x759/0xf50
       queue_work_on+0x1c2/0x380 kernel/workqueue.c:2392
       percpu_ref_put_many include/linux/percpu-refcount.h:335 [inline]
       percpu_ref_put+0x178/0x180 include/linux/percpu-refcount.h:351
       css_put include/linux/cgroup_refcnt.h:79 [inline]
       drain_stock mm/memcontrol.c:1774 [inline]
       __refill_stock+0x133/0x3e0 mm/memcontrol.c:1811
       refill_stock+0x1ad/0x470 mm/memcontrol.c:1827
       try_charge_memcg+0xd73/0x1170 mm/memcontrol.c:2294
       obj_cgroup_charge_pages+0x91/0x230 mm/memcontrol.c:2660
       __memcg_kmem_charge_page+0xc8/0x1d0 mm/memcontrol.c:2687
       __alloc_pages_noprof+0x28c/0x6c0 mm/page_alloc.c:4719
       alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
       pagetable_alloc_noprof include/linux/mm.h:2872 [inline]
       __pte_alloc_one_noprof include/asm-generic/pgalloc.h:70 [inline]
       pte_alloc_one+0x88/0x5d0 arch/x86/mm/pgtable.c:33
       __pte_alloc+0x79/0x3a0 mm/memory.c:448
       copy_pte_range mm/memory.c:1106 [inline]
       copy_pmd_range+0x7ccd/0x8500 mm/memory.c:1252
       copy_pud_range mm/memory.c:1289 [inline]
       copy_p4d_range mm/memory.c:1313 [inline]
       copy_page_range+0x99f/0xe90 mm/memory.c:1411
       dup_mmap kernel/fork.c:749 [inline]
       dup_mm kernel/fork.c:1672 [inline]
       copy_mm+0x11ea/0x1f30 kernel/fork.c:1721
       copy_process+0x187a/0x3dc0 kernel/fork.c:2374
       kernel_clone+0x226/0x8f0 kernel/fork.c:2781
       __do_sys_clone kernel/fork.c:2924 [inline]
       __se_sys_clone kernel/fork.c:2908 [inline]
       __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2908
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

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

6 locks held by syz-executor/5237:
 #0: ffffffff8e9e5390 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap kernel/fork.c:635 [inline]
 #0: ffffffff8e9e5390 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1672 [inline]
 #0: ffffffff8e9e5390 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x277/0x1f30 kernel/fork.c:1721
 #1: ffff88803429b118 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #1: ffff88803429b118 (&mm->mmap_lock){++++}-{3:3}, at: dup_mmap kernel/fork.c:636 [inline]
 #1: ffff88803429b118 (&mm->mmap_lock){++++}-{3:3}, at: dup_mm kernel/fork.c:1672 [inline]
 #1: ffff88803429b118 (&mm->mmap_lock){++++}-{3:3}, at: copy_mm+0x29a/0x1f30 kernel/fork.c:1721
 #2: ffff88803429cd98 (&mm->mmap_lock/1){+.+.}-{3:3}, at: mmap_write_lock_nested include/linux/mmap_lock.h:113 [inline]
 #2: ffff88803429cd98 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap kernel/fork.c:645 [inline]
 #2: ffff88803429cd98 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mm kernel/fork.c:1672 [inline]
 #2: ffff88803429cd98 (&mm->mmap_lock/1){+.+.}-{3:3}, at: copy_mm+0x3de/0x1f30 kernel/fork.c:1721
 #3: ffff8880b89394f8 (stock_lock){..-.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 #3: ffff8880b89394f8 (stock_lock){..-.}-{2:2}, at: refill_stock+0x112/0x470 mm/memcontrol.c:1826
 #4: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #4: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #4: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put_many include/linux/percpu-refcount.h:330 [inline]
 #4: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put+0x19/0x180 include/linux/percpu-refcount.h:351
 #5: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #5: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #5: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: __queue_work+0x199/0xf50 kernel/workqueue.c:2261

stack backtrace:
CPU: 1 UID: 0 PID: 5237 Comm: syz-executor Not tainted 6.11.0-rc7-syzkaller-00017-gbc83b4d1f086 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x759/0xf50
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2392
 percpu_ref_put_many include/linux/percpu-refcount.h:335 [inline]
 percpu_ref_put+0x178/0x180 include/linux/percpu-refcount.h:351
 css_put include/linux/cgroup_refcnt.h:79 [inline]
 drain_stock mm/memcontrol.c:1774 [inline]
 __refill_stock+0x133/0x3e0 mm/memcontrol.c:1811
 refill_stock+0x1ad/0x470 mm/memcontrol.c:1827
 try_charge_memcg+0xd73/0x1170 mm/memcontrol.c:2294
 obj_cgroup_charge_pages+0x91/0x230 mm/memcontrol.c:2660
 __memcg_kmem_charge_page+0xc8/0x1d0 mm/memcontrol.c:2687
 __alloc_pages_noprof+0x28c/0x6c0 mm/page_alloc.c:4719
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
 pagetable_alloc_noprof include/linux/mm.h:2872 [inline]
 __pte_alloc_one_noprof include/asm-generic/pgalloc.h:70 [inline]
 pte_alloc_one+0x88/0x5d0 arch/x86/mm/pgtable.c:33
 __pte_alloc+0x79/0x3a0 mm/memory.c:448
 copy_pte_range mm/memory.c:1106 [inline]
 copy_pmd_range+0x7ccd/0x8500 mm/memory.c:1252
 copy_pud_range mm/memory.c:1289 [inline]
 copy_p4d_range mm/memory.c:1313 [inline]
 copy_page_range+0x99f/0xe90 mm/memory.c:1411
 dup_mmap kernel/fork.c:749 [inline]
 dup_mm kernel/fork.c:1672 [inline]
 copy_mm+0x11ea/0x1f30 kernel/fork.c:1721
 copy_process+0x187a/0x3dc0 kernel/fork.c:2374
 kernel_clone+0x226/0x8f0 kernel/fork.c:2781
 __do_sys_clone kernel/fork.c:2924 [inline]
 __se_sys_clone kernel/fork.c:2908 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2908
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc048174753
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffcadc92ad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc048174753
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 000055557eebb7d0 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000003000d R14: 000000000002fe18 R15: 00007ffcadc92c60
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


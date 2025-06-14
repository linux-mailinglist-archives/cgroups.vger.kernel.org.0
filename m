Return-Path: <cgroups+bounces-8520-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD32AD9A64
	for <lists+cgroups@lfdr.de>; Sat, 14 Jun 2025 08:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2246A17E109
	for <lists+cgroups@lfdr.de>; Sat, 14 Jun 2025 06:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4AE1EB5CE;
	Sat, 14 Jun 2025 06:29:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C21DDC1A
	for <cgroups@vger.kernel.org>; Sat, 14 Jun 2025 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749882566; cv=none; b=Wud5NTJkX3/Xnu9NR/NxKjWvBnQsEK3yyrR83RBjqk/evV6Fb85+opZi1QiKJka5WEJmlAOb+vADWAvKprbKhQP09IjWFuMNOATWK1qhq6MqEyonCQVMgMXyd++czNdX4+7IakGESDOckAmVJtyTWQeXshtYd0HNzJDF4E0JVC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749882566; c=relaxed/simple;
	bh=1J40xiITuPFJaU4ni5DMSepwGHkj3c/mU6wKTfQfgJs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZZCuMQvHTCZdZZHKi3nEpOVP0nYi++s5a209TryhGXtVKngd1LcHIHGHz21fItcZdPXCWbC+VVKP4Zr05ILfbR1+Tbk81nAKuEJfH43880GSODknH6QufiTTmoWJauGxa1LWWKDXGpoDBt13qJMmtLSV2pu19c/zjVv4Fn3mYhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddc6d66787so38072475ab.3
        for <cgroups@vger.kernel.org>; Fri, 13 Jun 2025 23:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749882561; x=1750487361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vlTmje2DMtYqh0e/HCuEXyWXG8G8FHSNCBssKUmOdQw=;
        b=hOq3Q3T8ZohwNEM/qCVxzL7901h0MvpN7ZI9O8wEHFrWYp4hGeNEOQoTgM14ok5IT4
         BEx90vlcBNoqBdG37CuFqOgaZ8c4TgRri4n694IaMUkLuDZFiuzinhGbVPO44tkfR1iG
         qnfydkDs/H1yiZl0+cDrWVB4HaFg0loOf6SYN6TmdgKVs90jDpynC1MD25nX5Q2RBHWS
         RSHPRejdgEL0zkiDmBQxG0I5U477BeKlYX8fmmH0h885zMNSHXb/gFMhYq3X1nzptvqW
         144lAfbVRmETqu7hN+Wstk+3R88HlE9Hm+TcLvv8+4a5FQzHDZycSgvajOKvWqKpEYsb
         tpAg==
X-Gm-Message-State: AOJu0Yy54AsEZGGr72VZw61ftsri8eK7vSomXxLkjs3cxT6QCMMs48b7
	xZtrE/iBenxks6XzDPfLoBRUV+qo+v73wOz76C0fFXJ8sBNwCM2L2TdbSOf9A2qljdH6Gzys848
	3iPoyR0dJwS8RMMtM0oh5BA1ENgVbmYYMMXzY1jq4CISB8cv18QkihCCblN4yzA==
X-Google-Smtp-Source: AGHT+IFFYMBYIrhy7aaShNs38E2Tp+S1IVHi6ptgvzBrOLZS6a/JQ6zLI4yOl0VCuUGCKz8N0zthQ21XadTl26iYkNDuAQ9kFNkE
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:3dc:7fa4:845 with SMTP id
 e9e14a558f8ab-3de07ced0e2mr27611525ab.20.1749882560839; Fri, 13 Jun 2025
 23:29:20 -0700 (PDT)
Date: Fri, 13 Jun 2025 23:29:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684d16c0.050a0220.be214.02ad.GAE@google.com>
Subject: [syzbot] [cgroups?] possible deadlock in try_to_wake_up (8)
From: syzbot <syzbot+b4529efee5bf3751bc06@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    39dfc971e42d arm64/ptrace: Fix stack-out-of-bounds read in..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12fcb10c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=941e423b930a32dc
dashboard link: https://syzkaller.appspot.com/bug?extid=b4529efee5bf3751bc06
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ee1a7942f1b9/disk-39dfc971.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b94ed3d0f7e/vmlinux-39dfc971.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ce219d3314e/Image-39dfc971.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4529efee5bf3751bc06@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc1-syzkaller-g39dfc971e42d #0 Not tainted
------------------------------------------------------
bch-copygc/loop/7881 is trying to acquire lock:
ffff0000c9cb46c8 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:557 [inline]
ffff0000c9cb46c8 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0x68/0xdf0 kernel/sched/core.c:4226

but task is already holding lock:
ffff8000975fb610 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_object_init+0x6c/0x40c lib/debugobjects.c:741

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&obj_hash[i].lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
       debug_object_assert_init+0xa0/0x2c8 lib/debugobjects.c:1007
       debug_timer_assert_init kernel/time/timer.c:803 [inline]
       debug_assert_init kernel/time/timer.c:848 [inline]
       __mod_timer+0x5c/0xd00 kernel/time/timer.c:1025
       add_timer_global+0x88/0xc0 kernel/time/timer.c:1283
       __queue_delayed_work+0x218/0x2c8 kernel/workqueue.c:2526
       queue_delayed_work_on+0xe4/0x194 kernel/workqueue.c:2561
       queue_delayed_work include/linux/workqueue.h:677 [inline]
       schedule_delayed_work include/linux/workqueue.h:817 [inline]
       psi_group_change+0xd50/0x12e4 kernel/sched/psi.c:873
       psi_task_change+0xec/0x244 kernel/sched/psi.c:912
       psi_enqueue kernel/sched/stats.h:166 [inline]
       enqueue_task+0x250/0x2f4 kernel/sched/core.c:2086
       activate_task kernel/sched/core.c:2126 [inline]
       wake_up_new_task+0x324/0x990 kernel/sched/core.c:4891
       kernel_clone+0x440/0x7a0 kernel/fork.c:2630
       user_mode_thread+0xc8/0x11c kernel/fork.c:2677
       rest_init+0x30/0x2f4 init/main.c:709
       start_kernel+0x450/0x4ac init/main.c:1101
       __primary_switched+0x8c/0x94 arch/arm64/kernel/head.S:246

-> #1 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x50/0x6c kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested kernel/sched/core.c:606 [inline]
       raw_spin_rq_lock kernel/sched/sched.h:1532 [inline]
       task_rq_lock+0xc4/0x33c kernel/sched/core.c:708
       cgroup_move_task+0x9c/0x454 kernel/sched/psi.c:1161
       css_set_move_task+0x69c/0x8bc kernel/cgroup/cgroup.c:918
       cgroup_post_fork+0x160/0x5cc kernel/cgroup/cgroup.c:6754
       copy_process+0x2e48/0x31ec kernel/fork.c:2413
       kernel_clone+0x1d8/0x7a0 kernel/fork.c:2599
       user_mode_thread+0xc8/0x11c kernel/fork.c:2677
       rest_init+0x30/0x2f4 init/main.c:709
       start_kernel+0x450/0x4ac init/main.c:1101
       __primary_switched+0x8c/0x94 arch/arm64/kernel/head.S:246

-> #0 (&p->pi_lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5240
       lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5871
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:557 [inline]
       try_to_wake_up+0x68/0xdf0 kernel/sched/core.c:4226
       wake_up_process kernel/sched/core.c:4475 [inline]
       wake_up_q+0x70/0x9c kernel/sched/core.c:1081
       up+0x100/0x170 kernel/locking/semaphore.c:235
       __up_console_sem kernel/printk/printk.c:343 [inline]
       __console_unlock+0x88/0xc4 kernel/printk/printk.c:2885
       __console_flush_and_unlock kernel/printk/printk.c:3287 [inline]
       console_unlock+0xfc/0x288 kernel/printk/printk.c:3325
       vprintk_emit+0x298/0x430 kernel/printk/printk.c:2450
       vprintk_default+0x54/0x80 kernel/printk/printk.c:2465
       vprintk+0x90/0x128 kernel/printk/printk_safe.c:82
       _printk+0xd0/0x118 kernel/printk/printk.c:2475
       __report_bug lib/bug.c:191 [inline]
       report_bug+0x3a8/0x568 lib/bug.c:215
       bug_handler+0x50/0x1fc arch/arm64/kernel/traps.c:1002
       call_break_hook arch/arm64/kernel/debug-monitors.c:315 [inline]
       brk_handler+0x1d8/0x288 arch/arm64/kernel/debug-monitors.c:325
       do_debug_exception+0x1e4/0x38c arch/arm64/mm/fault.c:1002
       el1_dbg+0x64/0x80 arch/arm64/kernel/entry-common.c:513
       el1h_64_sync_handler+0x40/0xcc arch/arm64/kernel/entry-common.c:559
       el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
       debug_object_is_on_stack lib/debugobjects.c:-1 [inline]
       lookup_object_or_alloc lib/debugobjects.c:688 [inline]
       __debug_object_init+0x364/0x40c lib/debugobjects.c:743
       debug_object_init+0x20/0x2c lib/debugobjects.c:779
       __init_work+0x58/0x68 kernel/workqueue.c:677
       rhashtable_init_noprof+0x734/0xa10 lib/rhashtable.c:1085
       bch2_copygc_thread+0xec/0xd40 fs/bcachefs/movinggc.c:353
       kthread+0x5fc/0x75c kernel/kthread.c:464
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847

other info that might help us debug this:

Chain exists of:
  &p->pi_lock --> &rq->__lock --> &obj_hash[i].lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&obj_hash[i].lock);
                               lock(&rq->__lock);
                               lock(&obj_hash[i].lock);
  lock(&p->pi_lock);

 *** DEADLOCK ***

1 lock held by bch-copygc/loop/7881:
 #0: ffff8000975fb610 (&obj_hash[i].lock){-.-.}-{2:2}, at: __debug_object_init+0x6c/0x40c lib/debugobjects.c:741

stack backtrace:
CPU: 0 UID: 0 PID: 7881 Comm: bch-copygc/loop Not tainted 6.16.0-rc1-syzkaller-g39dfc971e42d #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 dump_stack+0x1c/0x28 lib/dump_stack.c:129
 print_circular_bug+0x324/0x32c kernel/locking/lockdep.c:2046
 check_noncircular+0x154/0x174 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain kernel/locking/lockdep.c:3911 [inline]
 __lock_acquire+0x1774/0x30a4 kernel/locking/lockdep.c:5240
 lock_acquire+0x14c/0x2e0 kernel/locking/lockdep.c:5871
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
 class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:557 [inline]
 try_to_wake_up+0x68/0xdf0 kernel/sched/core.c:4226
 wake_up_process kernel/sched/core.c:4475 [inline]
 wake_up_q+0x70/0x9c kernel/sched/core.c:1081
 up+0x100/0x170 kernel/locking/semaphore.c:235
 __up_console_sem kernel/printk/printk.c:343 [inline]
 __console_unlock+0x88/0xc4 kernel/printk/printk.c:2885
 __console_flush_and_unlock kernel/printk/printk.c:3287 [inline]
 console_unlock+0xfc/0x288 kernel/printk/printk.c:3325
 vprintk_emit+0x298/0x430 kernel/printk/printk.c:2450
 vprintk_default+0x54/0x80 kernel/printk/printk.c:2465
 vprintk+0x90/0x128 kernel/printk/printk_safe.c:82
 _printk+0xd0/0x118 kernel/printk/printk.c:2475
 __report_bug lib/bug.c:191 [inline]
 report_bug+0x3a8/0x568 lib/bug.c:215
 bug_handler+0x50/0x1fc arch/arm64/kernel/traps.c:1002
 call_break_hook arch/arm64/kernel/debug-monitors.c:315 [inline]
 brk_handler+0x1d8/0x288 arch/arm64/kernel/debug-monitors.c:325
 do_debug_exception+0x1e4/0x38c arch/arm64/mm/fault.c:1002
 el1_dbg+0x64/0x80 arch/arm64/kernel/entry-common.c:513
 el1h_64_sync_handler+0x40/0xcc arch/arm64/kernel/entry-common.c:559
 el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:595
 debug_object_is_on_stack lib/debugobjects.c:-1 [inline] (P)
 lookup_object_or_alloc lib/debugobjects.c:688 [inline] (P)
 __debug_object_init+0x364/0x40c lib/debugobjects.c:743 (P)
 debug_object_init+0x20/0x2c lib/debugobjects.c:779
 __init_work+0x58/0x68 kernel/workqueue.c:677
 rhashtable_init_noprof+0x734/0xa10 lib/rhashtable.c:1085
 bch2_copygc_thread+0xec/0xd40 fs/bcachefs/movinggc.c:353
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
WARNING: CPU: 0 PID: 7881 at lib/debugobjects.c:655 debug_object_is_on_stack lib/debugobjects.c:-1 [inline]
WARNING: CPU: 0 PID: 7881 at lib/debugobjects.c:655 lookup_object_or_alloc lib/debugobjects.c:688 [inline]
WARNING: CPU: 0 PID: 7881 at lib/debugobjects.c:655 __debug_object_init+0x364/0x40c lib/debugobjects.c:743
Modules linked in:
CPU: 0 UID: 0 PID: 7881 Comm: bch-copygc/loop Not tainted 6.16.0-rc1-syzkaller-g39dfc971e42d #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_object_is_on_stack lib/debugobjects.c:-1 [inline]
pc : lookup_object_or_alloc lib/debugobjects.c:688 [inline]
pc : __debug_object_init+0x364/0x40c lib/debugobjects.c:743
lr : debug_object_is_on_stack lib/debugobjects.c:-1 [inline]
lr : lookup_object_or_alloc lib/debugobjects.c:688 [inline]
lr : __debug_object_init+0x364/0x40c lib/debugobjects.c:743
sp : ffff80009c337700
x29: ffff80009c337700 x28: 0000000000000000 x27: dfff800000000000
x26: ffff800097693000 x25: ffff0000d2e30020 x24: 0000000000000000
x23: ffff0000f27cbd58 x22: 0000000000000000 x21: ffff8000975fb5f0
x20: ffff80008af70de0 x19: ffff80009c337bb0 x18: 00000000ffffffff
x17: ffff80009331f000 x16: ffff80008aec8e2c x15: 0000000000000001
x14: 1ffff00013866e58 x13: 0000000000000000 x12: 0000000000000000
x11: ffff700013866e59 x10: 0000000000ff0100 x9 : 6623cf50e130e900
x8 : 6623cf50e130e900 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff80009c337098 x4 : ffff80008f727060 x3 : ffff8000807c0744
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000050
Call trace:
 debug_object_is_on_stack lib/debugobjects.c:-1 [inline] (P)
 lookup_object_or_alloc lib/debugobjects.c:688 [inline] (P)
 __debug_object_init+0x364/0x40c lib/debugobjects.c:743 (P)
 debug_object_init+0x20/0x2c lib/debugobjects.c:779
 __init_work+0x58/0x68 kernel/workqueue.c:677
 rhashtable_init_noprof+0x734/0xa10 lib/rhashtable.c:1085
 bch2_copygc_thread+0xec/0xd40 fs/bcachefs/movinggc.c:353
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:847
irq event stamp: 18
hardirqs last  enabled at (17): [<ffff800083e7f73c>] get_random_u32+0x2d4/0x540 drivers/char/random.c:554
hardirqs last disabled at (18): [<ffff80008aeea2b4>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (18): [<ffff80008aeea2b4>] _raw_spin_lock_irqsave+0x2c/0x7c kernel/locking/spinlock.c:162
softirqs last  enabled at (0): [<ffff8000803afb44>] copy_process+0x1134/0x31ec kernel/fork.c:2114
softirqs last disabled at (0): [<0000000000000000>] 0x0
---[ end trace 0000000000000000 ]---


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


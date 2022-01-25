Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB849B91F
	for <lists+cgroups@lfdr.de>; Tue, 25 Jan 2022 17:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1585921AbiAYQpl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jan 2022 11:45:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50500 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354157AbiAYQno (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jan 2022 11:43:44 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643129022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hqe2SLHzou7+fSWI+ptx4GEX6e6xp7CVCz1WJaFdYd8=;
        b=iPGulEQ2aRqltzuKsQXAHl3cUY2hPM1MrZikCImDXMt67OWWJ5Ev3VlNDjQmhpc2t+6SW5
        6dMw3dYzEtHXo4aZUlz9x0GjT92/t+KjdFZnbM18aWz0CoCeRqgzvFAPJLSTbHBjG0phkm
        xL+Dmf6Rsm3e20Dm0diH+Z0/3XqYkFGKuVaSzoGJ07iW2nhuF/7TD8Y5OmpYHpcB1P5GYS
        vtb1kPNG2AcdOaFk5ZdgTVBdmc91nm1tQuC69Xw7elZdx4iLDZkgqLcedMQW/s5VhEZ6Ic
        jVJSDZI499kG3JSQhmclmzHA0R85pKlMPJj3YFNiACdE+rEwvEAHkfhs9QA1HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643129022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hqe2SLHzou7+fSWI+ptx4GEX6e6xp7CVCz1WJaFdYd8=;
        b=87T6zDmgUYPtr0sCSA0PlIz2vE7/pcytCb732OhJOoRgmd4p8rMBIsI+Cv7LlldLGkM3pb
        C2P+nIdjrFKHR9Dw==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/4] mm/memcg: Address PREEMPT_RT problems instead of disabling it.
Date:   Tue, 25 Jan 2022 17:43:33 +0100
Message-Id: <20220125164337.2071854-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

this series is a follow up to the initial RFC
    https://lore.kernel.org/all/20211222114111.2206248-1-bigeasy@linutronix=
.de

and aims to enable MEMCG for PREEMPT_RT instead of disabling it.

where it has been suggested that I should try again with memcg instead
of simply disabling it.

Changes since the RFC:
- cgroup.event_control / memory.soft_limit_in_bytes is disabled on
  PREEMPT_RT. It is a deprecated v1 feature. Fixing the signal path is
  not worth it.

- The updates to per-CPU counters are usually synchronised by disabling
  interrupts. There are a few spots where assumption about disabled
  interrupts are not true on PREEMPT_RT and therefore preemption is
  disabled. This is okay since the counter are never written from
  in_irq() context.

Patch #2 deals with the counters.

Patch #3 is a follow up to
   https://lkml.kernel.org/r/20211214144412.447035-1-longman@redhat.com

Patch #4 restricts the task_obj usage to !PREEMPTION kernels. Based on
the numbers in=20
   https://lore.kernel.org/all/YdX+INO9gQje6d0S@linutronix.de

it seems to make sense to not restrict it only to PREEMPT_RT but to
PREEMPTION kernels (including PREEMPT_DYNAMIC).

I tested them on CONFIG_PREEMPT_NONE + CONFIG_PREEMPT_RT with the
tools/testing/selftests/cgroup/* tests. It looked good except for the
following (which was also there before the patches):
- test_kmem sometimes complained about:
 not ok 2 test_kmem_memcg_deletion
=20
- test_memcontrol complained always about
 not ok 3 test_memcg_min
 not ok 4 test_memcg_low
 and did not finish.

- lockdep complains were triggered by test_core and test_freezer (both
  had to run):

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
5.17.0-rc1+ #2 Not tainted
------------------------------------------------------
test_core/4751 is trying to acquire lock:
ffffffff82a35018 (css_set_lock){..-.}-{2:2}, at: obj_cgroup_release+0x22/0x=
90

but task is already holding lock:
ffff88810ba6abd8 (&sighand->siglock){....}-{2:2}, at: __lock_task_sighand+0=
x60/0x170

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sighand->siglock){....}-{2:2}:
       _raw_spin_lock+0x2a/0x40
       cgroup_post_fork+0x1f5/0x290
       copy_process+0x1ac9/0x1fc0
       kernel_clone+0x5a/0x400
       __do_sys_clone3+0xb9/0x120
       do_syscall_64+0x64/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (css_set_lock){..-.}-{2:2}:
       __lock_acquire+0x1275/0x22e0
       lock_acquire+0xd0/0x2e0
       _raw_spin_lock_irqsave+0x39/0x50
       obj_cgroup_release+0x22/0x90
       refill_obj_stock+0x3cd/0x410
       obj_cgroup_charge+0x159/0x320
       kmem_cache_alloc+0xa7/0x480
       __sigqueue_alloc+0x129/0x2d0
       __send_signal+0x87/0x550
       do_send_specific+0x10f/0x1d0
       do_tkill+0x83/0xb0
       __x64_sys_tgkill+0x20/0x30
       do_syscall_64+0x64/0x90
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sighand->siglock);
                               lock(css_set_lock);
                               lock(&Sagan->siglock);
  lock(css_set_lock);

 *** DEADLOCK ***

3 locks held by test_core/4751:
 #0: ffffffff829a3f60 (rcu_read_lock){....}-{1:2}, at: do_send_specific+0x0=
/0x1d0
 #1: ffff88810ba6abd8 (&sighand->siglock){....}-{2:2}, at: __lock_task_sigh=
and+0x60/0x170
 #2: ffffffff829a3f60 (rcu_read_lock){....}-{1:2}, at: refill_obj_stock+0x1=
a4/0x410

stack backtrace:
CPU: 1 PID: 4751 Comm: test_core Not tainted 5.17.0-rc1+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x45/0x59
 check_noncircular+0xfe/0x110
 __lock_acquire+0x1275/0x22e0
 lock_acquire+0xd0/0x2e0
 _raw_spin_lock_irqsave+0x39/0x50
 obj_cgroup_release+0x22/0x90
 refill_obj_stock+0x3cd/0x410
 obj_cgroup_charge+0x159/0x320
 kmem_cache_alloc+0xa7/0x480
 __sigqueue_alloc+0x129/0x2d0
 __send_signal+0x87/0x550
 do_send_specific+0x10f/0x1d0
 do_tkill+0x83/0xb0
 __x64_sys_tgkill+0x20/0x30
 do_syscall_64+0x64/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
 </TASK>


Sebasttian


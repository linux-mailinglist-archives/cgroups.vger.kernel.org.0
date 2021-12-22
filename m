Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887C147D122
	for <lists+cgroups@lfdr.de>; Wed, 22 Dec 2021 12:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhLVLlV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Dec 2021 06:41:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60568 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbhLVLlU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Dec 2021 06:41:20 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640173279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SInYklV1GRO67nKTuIrqt5K8/wl4gnCZNFPRmmw4im0=;
        b=gsrtXN/tVsUALHVSJVO88Kxt4rg/drzA0RIlGFwbLYv28j5kQZJV+1wySOntrDZP0IjRyf
        TP5ELjoSPIVdDSlemdZ5gPmQ3uJm+kQbThQpxn9TdbKyEVpC6eeENljCGUrSBdbumA7kYt
        yP4a8KLygcirMJXQ+OxWekGWJV2hjbIShSItq1sWwdfLr7I0NJTAJeSMMGrG9aHqRNHgRy
        Eq/84xpMVNhBfqLa3GpIjsASFiRDjeB9Or0vOeLEipjV4q+Q9eKB9UBjaV1LByF8hjDFn/
        j5r2BSkYvtfzwRz0JT+jPRK96cgEnxro1uhIh6aVvhw0Vf2g6kPIofAZptONPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640173279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SInYklV1GRO67nKTuIrqt5K8/wl4gnCZNFPRmmw4im0=;
        b=RdqkbiEBKJ59ybHZ0ypx9jEFJf/FEmaOjgkqJZ+CcXsVQ9jfVJdmUtAcoaQS7o1U4ZmPwp
        D9cwO9TFLwYQmnAw==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 0/3] mm/memcg: Address PREEMPT_RT problems instead of disabling it.
Date:   Wed, 22 Dec 2021 12:41:08 +0100
Message-Id: <20211222114111.2206248-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

this is a follow up to
   https://lkml.kernel.org/r/20211207155208.eyre5svucpg7krxe@linutronix.de

where it has been suggested that I should try again with memcg instead
of simply disabling it.

Patch #1 deals with the counters. It has been suggested to simply
disable preemption on RT (like in vmstats) and I followed that advice as
closely as possible. The local_irq_save() could be removed from
mod_memcg_state() and the other wrapper on RT but I leave it since it
does not hurt and it might look nicer ;)

Patch #2 is a follow up to
   https://lkml.kernel.org/r/20211214144412.447035-1-longman@redhat.com

Patch #3 restricts the task_obj usage to !PREEMPTION kernels. Based on
my understanding the use of preempt_disable() minimizes (avoids?) the
win of the optimisation.

I tested them on CONFIG_PREEMPT_NONE + CONFIG_PREEMPT_RT with the
tools/testing/selftests/cgroup/* tests. I looked good except for the
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
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
 WARNING: possible circular locking dependency detected
 5.16.0-rc5 #259 Not tainted
 ------------------------------------------------------
 test_core/5996 is trying to acquire lock:
 ffffffff829a1258 (css_set_lock){..-.}-{2:2}, at: obj_cgroup_release+0x2d/0=
xb0
=20
 but task is already holding lock:
 ffff888103034618 (&sighand->siglock){....}-{2:2}, at: get_signal+0x8d/0xdb0
=20
 which lock already depends on the new lock.

=20
 the existing dependency chain (in reverse order) is:
=20
 -> #1 (&sighand->siglock){....}-{2:2}:
        _raw_spin_lock+0x27/0x40
        cgroup_post_fork+0x1f5/0x290
        copy_process+0x191b/0x1f80
        kernel_clone+0x5a/0x410
        __do_sys_clone3+0xb3/0x110
        do_syscall_64+0x43/0x90
        entry_SYSCALL_64_after_hwframe+0x44/0xae
=20
 -> #0 (css_set_lock){..-.}-{2:2}:
        __lock_acquire+0x1253/0x2280
        lock_acquire+0xd4/0x2e0
        _raw_spin_lock_irqsave+0x36/0x50
        obj_cgroup_release+0x2d/0xb0
        drain_obj_stock+0x1a9/0x1b0
        refill_obj_stock+0x4f/0x220
        memcg_slab_free_hook.part.0+0x108/0x290
        kmem_cache_free+0xf5/0x3c0
        dequeue_signal+0xaf/0x1e0
        get_signal+0x232/0xdb0
        arch_do_signal_or_restart+0xf8/0x740
        exit_to_user_mode_prepare+0x17d/0x270
        syscall_exit_to_user_mode+0x19/0x70
        do_syscall_64+0x50/0x90
        entry_SYSCALL_64_after_hwframe+0x44/0xae
=20
 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&sighand->siglock);
                                lock(css_set_lock);
                                lock(&sighand->siglock);
   lock(css_set_lock);
=20
  *** DEADLOCK ***

 2 locks held by test_core/5996:
  #0: ffff888103034618 (&sighand->siglock){....}-{2:2}, at: get_signal+0x8d=
/0xdb0
  #1: ffffffff82905e40 (rcu_read_lock){....}-{1:2}, at: drain_obj_stock+0x7=
1/0x1b0
=20
 stack backtrace:
 CPU: 2 PID: 5996 Comm: test_core Not tainted 5.16.0-rc5 #259
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/20=
14
 Call Trace:
  <TASK>
  dump_stack_lvl+0x45/0x59
  check_noncircular+0xfe/0x110
  __lock_acquire+0x1253/0x2280
  lock_acquire+0xd4/0x2e0
  _raw_spin_lock_irqsave+0x36/0x50
  obj_cgroup_release+0x2d/0xb0
  drain_obj_stock+0x1a9/0x1b0
  refill_obj_stock+0x4f/0x220
  memcg_slab_free_hook.part.0+0x108/0x290
  kmem_cache_free+0xf5/0x3c0
  dequeue_signal+0xaf/0x1e0
  get_signal+0x232/0xdb0
  arch_do_signal_or_restart+0xf8/0x740
  exit_to_user_mode_prepare+0x17d/0x270
  syscall_exit_to_user_mode+0x19/0x70
  do_syscall_64+0x50/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae
  </TASK>

Sebastian



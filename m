Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB734A6694
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 21:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiBAU4a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 15:56:30 -0500
Received: from foss.arm.com ([217.140.110.172]:36946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232087AbiBAU4a (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 1 Feb 2022 15:56:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BA1C113E;
        Tue,  1 Feb 2022 12:56:30 -0800 (PST)
Received: from u200865.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D24EE3F774;
        Tue,  1 Feb 2022 12:56:29 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-mm@kvack.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [BUG/RFC] mm/memcg: Possible cgroup migrate/signal deadlock
Date:   Tue,  1 Feb 2022 14:56:23 -0600
Message-Id: <20220201205623.1325649-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With CONFIG_MEMCG_KMEM and CONFIG_PROVE_LOCKING enabled (fedora
rawhide kernel), running a simple podman test tosses a circular
locking dependency warning. The podman container in question simpy
contains the echo command and the libc/ld-linux needed to run it. The
warning can be duplicated with just a single `podman build --network
host --layers=false -t localhost/echo .` command, although the exact
sequence that triggers the warning needs the task state to be changing
the frozen state as well. So, its easier to duplicate with a slightly
longer test case.

I've attempted to trigger the actual deadlock with some standalone
code and been unsuccessful, but looking at the code it appears to be a
legitimate deadlock if a signal is being sent to the process from
another thread while the task is migrating between cgroups.

Attached is a fix which I'm confident fixes the problem, but I'm not
really that confident in the fix since I don't fully understand all
the possible states in the cgroup code. The fix avoids the deadlock by
shifting the objcg->list manipulation to another spinlock and then
using list_del_rcu in obj_cgroup_release.

There is a bit more information in the actual BZ
https://bugzilla.redhat.com/show_bug.cgi?id=2033016 including a shell
script with the podman test/etc.

(this machine has a new 5.17 splat before in the network driver)
[   87.700526] ======================================================
[   87.706693] WARNING: possible circular locking dependency detected
[   87.712861] 5.17.0-rc2+ #171 Tainted: G        W
[   87.718161] ------------------------------------------------------
[   87.724328] podman/2371 is trying to acquire lock:
[   87.729107] ffffa723507a2838 (css_set_lock){..-.}-{2:2}, at: _raw_spin_lock_irqsave+0x1c/0x30
[   87.737636]
[   87.737636] but task is already holding lock:
[   87.743456] ffff577e760d88d8 (&sighand->siglock){....}-{2:2}, at: _raw_spin_lock_irqsave+0x1c/0x30
[   87.752409]
[   87.752409] which lock already depends on the new lock.
[   87.752409]
[   87.760572]
[   87.760572] the existing dependency chain (in reverse order) is:
[   87.768041]
[   87.768041] -> #1 (&sighand->siglock){....}-{2:2}:
[   87.774301]        __lock_acquire+0x444/0x9c0
[   87.778650]        lock_acquire.part.0+0xa8/0x1b0
[   87.783343]        lock_acquire+0x68/0x8c
[   87.787342]        __raw_spin_lock_irqsave+0x8c/0x140
[   87.792383]        _raw_spin_lock_irqsave+0x1c/0x30
[   87.797249]        __lock_task_sighand+0xa4/0x1d0
[   87.801944]        cgroup_freeze_task+0x28/0x80
[   87.806465]        cgroup_freezer_migrate_task+0x78/0xe0
[   87.811765]        cgroup_migrate_execute+0x33c/0x494
[   87.816807]        cgroup_update_dfl_csses+0x210/0x230
[   87.821935]        cgroup_subtree_control_write+0x41c/0x440
[   87.827497]        cgroup_file_write+0x90/0x260
[   87.832016]        kernfs_fop_write_iter+0x13c/0x1d0
[   87.836971]        new_sync_write+0xdc/0x15c
[   87.841230]        vfs_write+0x1cc/0x220
[   87.845141]        ksys_write+0x64/0xec
[   87.848966]        __arm64_sys_write+0x28/0x34
[   87.853398]        invoke_syscall+0x50/0x120
[   87.857657]        el0_svc_common.constprop.0+0x68/0x124
[   87.862957]        do_el0_svc+0x34/0x9c
[   87.866781]        el0_svc+0x5c/0x19c
[   87.870433]        el0t_64_sync_handler+0xa4/0x130
[   87.875213]        el0t_64_sync+0x1a4/0x1a8
[   87.879385]
[   87.879385] -> #0 (css_set_lock){..-.}-{2:2}:
[   87.885210]        check_prev_add+0xac/0x68c
[   87.889469]        validate_chain+0x3fc/0x590
[   87.893815]        __lock_acquire+0x444/0x9c0
[   87.898160]        lock_acquire.part.0+0xa8/0x1b0
[   87.902853]        lock_acquire+0x68/0x8c
[   87.906851]        __raw_spin_lock_irqsave+0x8c/0x140
[   87.911892]        _raw_spin_lock_irqsave+0x1c/0x30
[   87.916758]        obj_cgroup_release+0x4c/0xd0
[   87.921280]        percpu_ref_put_many.constprop.0+0x11c/0x130
[   87.927102]        drain_obj_stock+0x88/0xdc
[   87.931360]        refill_obj_stock+0x8c/0x1e0
[   87.935792]        obj_cgroup_charge+0x100/0x1cc
[   87.940398]        kmem_cache_alloc+0xb8/0x354
[   87.944829]        __sigqueue_alloc+0x164/0x340
[   87.949350]        __send_signal+0x248/0x560
[   87.953610]        send_signal+0x1c0/0x340
[   87.957695]        do_send_specific+0x1ac/0x1d0
[   87.962214]        do_tkill+0x84/0xa0
[   87.965864]        __arm64_sys_tgkill+0x38/0x50
[   87.970383]        invoke_syscall+0x50/0x120
[   87.974642]        el0_svc_common.constprop.0+0x68/0x124
[   87.979941]        do_el0_svc+0x34/0x9c
[   87.983765]        el0_svc+0x5c/0x19c
[   87.987416]        el0t_64_sync_handler+0xa4/0x130
[   87.992196]        el0t_64_sync+0x1a4/0x1a8
[   87.996367]
[   87.996367] other info that might help us debug this:
[   87.996367]
[   88.004356]  Possible unsafe locking scenario:
[   88.004356]
[   88.010263]        CPU0                    CPU1
[   88.014780]        ----                    ----
[   88.019297]   lock(&sighand->siglock);
[   88.023036]                                lock(css_set_lock);
[   88.028858]                                lock(&sighand->siglock);
[   88.035114]   lock(css_set_lock);
[   88.038418]
[   88.038418]  *** DEADLOCK ***
[   88.038418]
[   88.044324] 3 locks held by podman/2371:
[   88.048235]  #0: ffffa7235072d1c8 (rcu_read_lock){....}-{1:2}, at: do_send_specific+0x8/0x1d0
[   88.056756]  #1: ffff577e760d88d8 (&sighand->siglock){....}-{2:2}, at: _raw_spin_lock_irqsave+0x1c/0x30
[   88.066144]  #2: ffffa7235072d1c8 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put_many.constprop.0+0x0/0x130
[   88.075967]
[   88.075967] stack backtrace:
[   88.080312] CPU: 6 PID: 2371 Comm: podman Tainted: G        W         5.17.0-rc2+ #171
[   88.088217] Hardware name: SolidRun Ltd. SolidRun CEX7 Platform, BIOS EDK II Aug  9 2021
[   88.096294] Call trace:
[   88.098728]  dump_backtrace+0xf8/0x130
[   88.102466]  show_stack+0x24/0x80
[   88.105770]  dump_stack_lvl+0x8c/0xb8
[   88.109423]  dump_stack+0x18/0x34
[   88.112727]  print_circular_bug+0x1f8/0x200
[   88.116899]  check_noncircular+0x104/0x130
[   88.120984]  check_prev_add+0xac/0x68c
[   88.124722]  validate_chain+0x3fc/0x590
[   88.128547]  __lock_acquire+0x444/0x9c0
[   88.132371]  lock_acquire.part.0+0xa8/0x1b0
[   88.136543]  lock_acquire+0x68/0x8c
[   88.140021]  __raw_spin_lock_irqsave+0x8c/0x140
[   88.144541]  _raw_spin_lock_irqsave+0x1c/0x30
[   88.148886]  obj_cgroup_release+0x4c/0xd0
[   88.152886]  percpu_ref_put_many.constprop.0+0x11c/0x130
[   88.158187]  drain_obj_stock+0x88/0xdc
[   88.161924]  refill_obj_stock+0x8c/0x1e0
[   88.165836]  obj_cgroup_charge+0x100/0x1cc
[   88.169920]  kmem_cache_alloc+0xb8/0x354
[   88.173832]  __sigqueue_alloc+0x164/0x340
[   88.177831]  __send_signal+0x248/0x560
[   88.181569]  send_signal+0x1c0/0x340

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/memcontrol.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 09d342c7cbd0..0e6a5487457f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -255,6 +255,7 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 
 #ifdef CONFIG_MEMCG_KMEM
 extern spinlock_t css_set_lock;
+DEFINE_SPINLOCK(objcg_list_lock);
 
 bool mem_cgroup_kmem_disabled(void)
 {
@@ -298,9 +299,9 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
 
-	spin_lock_irqsave(&css_set_lock, flags);
-	list_del(&objcg->list);
-	spin_unlock_irqrestore(&css_set_lock, flags);
+	spin_lock_irqsave(&objcg_list_lock, flags);
+	list_del_rcu(&objcg->list);
+	spin_unlock_irqrestore(&objcg_list_lock, flags);
 
 	percpu_ref_exit(ref);
 	kfree_rcu(objcg, rcu);
@@ -333,6 +334,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
 
 	spin_lock_irq(&css_set_lock);
+	spin_lock(&objcg_list_lock);
 
 	/* 1) Ready to reparent active objcg. */
 	list_add(&objcg->list, &memcg->objcg_list);
@@ -342,6 +344,7 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
 	/* 3) Move already reparented objcgs to the parent's list */
 	list_splice(&memcg->objcg_list, &parent->objcg_list);
 
+	spin_unlock(&objcg_list_lock);
 	spin_unlock_irq(&css_set_lock);
 
 	percpu_ref_kill(&objcg->refcnt);
-- 
2.33.1


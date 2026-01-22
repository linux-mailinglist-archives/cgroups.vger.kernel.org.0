Return-Path: <cgroups+bounces-13375-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDpsL9ZicmnfjQAAu9opvQ
	(envelope-from <cgroups+bounces-13375-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 18:48:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 045F26BA2B
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 18:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1DB9309D81F
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 17:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E5635EDD5;
	Thu, 22 Jan 2026 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoTS7mb/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3211B35B656;
	Thu, 22 Jan 2026 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101026; cv=none; b=mT5rioys+duJ3WIUhfdce8N66FsGl+/+U3vmuc6mw9lrya4JrqXBoGGo5rmdxUGdzHE2c8ObGpCeJNH/xBg6gKtsZqX8dNOhLEfoK0/hdzIfblHDuNzJdzo2mGQemYRxLfLxiU09O20tnLMltXBtvKQx3A58Qh7eVLM0FTGsBGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101026; c=relaxed/simple;
	bh=s0oMuGPb732uIw/EsLu0fcU3jRK7MByMyCO9igLanEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjxXLutTBCN3b1ylrPomk1boi3HI1tgizuUD6yKFGADK6yovJZR6qmIl7wUG9VMjyEd2TZ0j8HaSOP6cV433SjQ/0yWj5OE7EV48WycUvLi6tr5viRpZe+q/F6yfueOhHUIcW65NJzjDQ5N/jlOW+aCrt6sngtCbQRo6bxnA4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoTS7mb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8565BC116D0;
	Thu, 22 Jan 2026 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769101024;
	bh=s0oMuGPb732uIw/EsLu0fcU3jRK7MByMyCO9igLanEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NoTS7mb/tWoJhSygW2i5943x8LV/6qV+eTsl5R8Z1tPgNcv+H7hvJpPc3pgeQ9vM7
	 y3Cu/tuG7KD08abNL3Emrs2qUWE6qSSIogfOUbKucD293Sm14MhGjn4FTD4cZgEY99
	 +1cQqK+vUf5v29o6U3E7z8Na03RHfmiD8n94n6uf8uy70EqOlEoXHNCZUak18fgjs/
	 qSzKlnN3Wq8mQplHCTASEbxyMXT8AoG4uSt+XskU3QERHPzMR5svvZPnfguZuzOQVY
	 hLjjQcn0BsTGoOECsagG9aJfisBlOWMEbe/GsNWV0lWg/u875EKLYDOZL5nNvygrVO
	 ocrEjlSb0K1mA==
Date: Thu, 22 Jan 2026 17:57:00 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next] sched/isolation: Use
 static_branch_enable_cpuslocked() on housekeeping_update
Message-ID: <aXJW3C_JfCke-KTO@localhost.localdomain>
References: <20260122080902.2312721-1-chenridong@huaweicloud.com>
 <aXIN45kR5_PQgtK2@localhost.localdomain>
 <c01767cc-9f8b-4331-8928-9de97b430cf4@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c01767cc-9f8b-4331-8928-9de97b430cf4@huaweicloud.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13375-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,huawei.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,localhost.localdomain:mid,cmpxchg.org:email,linutronix.de:email]
X-Rspamd-Queue-Id: 045F26BA2B
X-Rspamd-Action: no action

Le Thu, Jan 22, 2026 at 08:03:56PM +0800, Chen Ridong a écrit :
> 
> 
> On 2026/1/22 19:45, Frederic Weisbecker wrote:
> > Le Thu, Jan 22, 2026 at 08:09:02AM +0000, Chen Ridong a écrit :
> >> From: Chen Ridong <chenridong@huawei.com>
> >>
> >> The warning is observed:
> >>
> >>  WARNING: possible recursive locking detected
> >>  6.19.0-rc6-next-20260121 #1046 Not tainted
> >>  --------------------------------------------
> >>  test_cpuset_prs/686 is trying to acquire lock:
> >>  (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0xd/0x20
> >>
> >>  but task is already holding lock:
> >>  (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_partition_write+0x72/0x10
> >>
> >>  other info that might help us debug this:
> >>   Possible unsafe locking scenario:
> >>
> >>         CPU0
> >>         ----
> >>    lock(cpu_hotplug_lock);
> >>    lock(cpu_hotplug_lock);
> >>
> >>   *** DEADLOCK ***
> >>
> >>   May be due to missing lock nesting notation
> >>
> >>  stack backtrace:
> >>  CPU: 11 UID: 0 PID: 686 Comm: test_cpuset_prs  6.19.0-rc6-next-20260121 #1
> >>  Call Trace:
> >>   <TASK>
> >>   dump_stack_lvl+0x82/0xd0
> >>   print_deadlock_bug+0x288/0x3c0
> >>   __lock_acquire+0x1506/0x27f0
> >>   lock_acquire+0xc8/0x2d0
> >>   ? static_key_enable+0xd/0x20
> >>   cpus_read_lock+0x3b/0xd0
> >>   ? static_key_enable+0xd/0x20
> >>   static_key_enable+0xd/0x20
> >>   housekeeping_update+0xe7/0x1b0
> >>   update_prstate+0x3f2/0x580
> >>   cpuset_partition_write+0x98/0x100
> >>   kernfs_fop_write_iter+0x14e/0x200
> >>   vfs_write+0x367/0x510
> >>   ksys_write+0x66/0xe0
> >>   do_syscall_64+0x6b/0x390
> >>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>  RIP: 0033:0x7f824cf8c887
> >>
> >> The commit 7109b22e6581 ("cpuset: Update HK_TYPE_DOMAIN cpumask from
> >> cpuset") introduced housekeeping_update, which calls static_branch_enable
> >> while cpu_read_lock() is held. Since static_key_enable itself also acquires
> >> cpu_read_lock, this leads to a lockdep warning. To resolve this issue,
> >> replace the call to static_key_enable with static_branch_enable_cpuslocked.
> >>
> >> Fixes: 7109b22e6581 ("cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset")
> >> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> > 
> > Thanks for spotting that! Funny that it didn't deadlock when I tested it.
> > Ah probably because I always booted with isolcpus= filled.
> > 
> > So ideally I should add your change as a fixup within
> > 7109b22e6581 ("cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset") in order
> > not to break bisection.
> > 
> > Do you mind if I do that? I'll still add your Signed-off-by to the commit.
> > 
> > Thanks.
> > 
> 
> I'm not entirely clear on the specifics of "breaking bisection", never mind, I
> trust your judgment. Please go ahead and fix it in the way that you like.

git bisect requires that no commit breaks testing in the middle.
The preferred way to deal with fixes on commits that haven't yet been
pulled upstream is to apply directly the fixup to the offending patches.

Here is the new version:

---
From: Frederic Weisbecker <frederic@kernel.org>
Date: Wed, 28 May 2025 18:05:32 +0200
Subject: [PATCH] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Until now, HK_TYPE_DOMAIN used to only include boot defined isolated
CPUs passed through isolcpus= boot option. Users interested in also
knowing the runtime defined isolated CPUs through cpuset must use
different APIs: cpuset_cpu_is_isolated(), cpu_is_isolated(), etc...

There are many drawbacks to that approach:

1) Most interested subsystems want to know about all isolated CPUs, not
  just those defined on boot time.

2) cpuset_cpu_is_isolated() / cpu_is_isolated() are not synchronized with
  concurrent cpuset changes.

3) Further cpuset modifications are not propagated to subsystems

Solve 1) and 2) and centralize all isolated CPUs within the
HK_TYPE_DOMAIN housekeeping cpumask.

Subsystems can rely on RCU to synchronize against concurrent changes.

The propagation mentioned in 3) will be handled in further patches.

[Chen Ridong: Fix cpu_hotplug_lock deadlock and use correct static
branch API]

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Marco Crivellari <marco.crivellari@suse.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org
---
 include/linux/sched/isolation.h |  7 +++
 kernel/cgroup/cpuset.c          |  5 ++-
 kernel/sched/isolation.c        | 75 ++++++++++++++++++++++++++++++---
 kernel/sched/sched.h            |  1 +
 4 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index c7cf6934489c..d8d9baf44516 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -9,6 +9,11 @@
 enum hk_type {
 	/* Inverse of boot-time isolcpus= argument */
 	HK_TYPE_DOMAIN_BOOT,
+	/*
+	 * Same as HK_TYPE_DOMAIN_BOOT but also includes the
+	 * inverse of cpuset isolated partitions. As such it
+	 * is always a subset of HK_TYPE_DOMAIN_BOOT.
+	 */
 	HK_TYPE_DOMAIN,
 	/* Inverse of boot-time isolcpus=managed_irq argument */
 	HK_TYPE_MANAGED_IRQ,
@@ -35,6 +40,7 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
 extern bool housekeeping_enabled(enum hk_type type);
 extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
 extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
+extern int housekeeping_update(struct cpumask *isol_mask);
 extern void __init housekeeping_init(void);
 
 #else
@@ -62,6 +68,7 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
 	return true;
 }
 
+static inline int housekeeping_update(struct cpumask *isol_mask) { return 0; }
 static inline void housekeeping_init(void) { }
 #endif /* CONFIG_CPU_ISOLATION */
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5e2e3514c22e..e146e1f34bf9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1482,14 +1482,15 @@ static void update_isolation_cpumasks(void)
 	if (!isolated_cpus_updating)
 		return;
 
-	lockdep_assert_cpus_held();
-
 	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
 	WARN_ON_ONCE(ret < 0);
 
 	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
 	WARN_ON_ONCE(ret < 0);
 
+	ret = housekeeping_update(isolated_cpus);
+	WARN_ON_ONCE(ret < 0);
+
 	isolated_cpus_updating = false;
 }
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 6f77289c14c3..674a02891b38 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -29,18 +29,48 @@ static struct housekeeping housekeeping;
 
 bool housekeeping_enabled(enum hk_type type)
 {
-	return !!(housekeeping.flags & BIT(type));
+	return !!(READ_ONCE(housekeeping.flags) & BIT(type));
 }
 EXPORT_SYMBOL_GPL(housekeeping_enabled);
 
+static bool housekeeping_dereference_check(enum hk_type type)
+{
+	if (IS_ENABLED(CONFIG_LOCKDEP) && type == HK_TYPE_DOMAIN) {
+		/* Cpuset isn't even writable yet? */
+		if (system_state <= SYSTEM_SCHEDULING)
+			return true;
+
+		/* CPU hotplug write locked, so cpuset partition can't be overwritten */
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
+			return true;
+
+		/* Cpuset lock held, partitions not writable */
+		if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
+			return true;
+
+		return false;
+	}
+
+	return true;
+}
+
+static inline struct cpumask *housekeeping_cpumask_dereference(enum hk_type type)
+{
+	return rcu_dereference_all_check(housekeeping.cpumasks[type],
+					 housekeeping_dereference_check(type));
+}
+
 const struct cpumask *housekeeping_cpumask(enum hk_type type)
 {
+	const struct cpumask *mask = NULL;
+
 	if (static_branch_unlikely(&housekeeping_overridden)) {
-		if (housekeeping.flags & BIT(type)) {
-			return rcu_dereference_check(housekeeping.cpumasks[type], 1);
-		}
+		if (READ_ONCE(housekeeping.flags) & BIT(type))
+			mask = housekeeping_cpumask_dereference(type);
 	}
-	return cpu_possible_mask;
+	if (!mask)
+		mask = cpu_possible_mask;
+	return mask;
 }
 EXPORT_SYMBOL_GPL(housekeeping_cpumask);
 
@@ -80,12 +110,45 @@ EXPORT_SYMBOL_GPL(housekeeping_affine);
 
 bool housekeeping_test_cpu(int cpu, enum hk_type type)
 {
-	if (static_branch_unlikely(&housekeeping_overridden) && housekeeping.flags & BIT(type))
+	if (static_branch_unlikely(&housekeeping_overridden) &&
+	    READ_ONCE(housekeeping.flags) & BIT(type))
 		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
 	return true;
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 
+int housekeeping_update(struct cpumask *isol_mask)
+{
+	struct cpumask *trial, *old = NULL;
+
+	lockdep_assert_cpus_held();
+
+	trial = kmalloc(cpumask_size(), GFP_KERNEL);
+	if (!trial)
+		return -ENOMEM;
+
+	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), isol_mask);
+	if (!cpumask_intersects(trial, cpu_online_mask)) {
+		kfree(trial);
+		return -EINVAL;
+	}
+
+	if (!housekeeping.flags)
+		static_branch_enable_cpuslocked(&housekeeping_overridden);
+
+	if (housekeeping.flags & HK_FLAG_DOMAIN)
+		old = housekeeping_cpumask_dereference(HK_TYPE_DOMAIN);
+	else
+		WRITE_ONCE(housekeeping.flags, housekeeping.flags | HK_FLAG_DOMAIN);
+	rcu_assign_pointer(housekeeping.cpumasks[HK_TYPE_DOMAIN], trial);
+
+	synchronize_rcu();
+
+	kfree(old);
+
+	return 0;
+}
+
 void __init housekeeping_init(void)
 {
 	enum hk_type type;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 475bdab3b8db..653e898a996a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -30,6 +30,7 @@
 #include <linux/context_tracking.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask_api.h>
+#include <linux/cpuset.h>
 #include <linux/ctype.h>
 #include <linux/file.h>
 #include <linux/fs_api.h>
-- 
2.51.1



Return-Path: <cgroups+bounces-15400-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ7mL4/r5mnF1wEAu9opvQ
	(envelope-from <cgroups+bounces-15400-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:14:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC13435E8C
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B51A630235AD
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BB437DEA0;
	Tue, 21 Apr 2026 03:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbRfozG6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0F37DEAD
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740866; cv=none; b=foVlRjUXufZUfoV/nDD4Qz4bqnttjHOKLKQgC2tmae5MzDaV3uSsFtrGCBHH41e9jk5z1Ih9Zy3iG3Q61KLtabiFNDprrQjJYBiuXPF3jIwIw/eL7ubQvitAs2NJVjrtnhMXk3WwME82NUfZQALaKY8e4zsYH1CBdm+WBDE3n6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740866; c=relaxed/simple;
	bh=Qgh3Rtjk2sr92+QFAulS1sInUiw/DjGtzsAE3YOzHGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEJ0CHqZI2T0mSaNKQh8+OkvEL3WIMKfvPJNQPQhxLs8RQ19VQlSknvF6bO2XTwHFVSqOrl2YyXApVeBDHb0iXZWDvjxZp77ZU6mjzFDIOoZ8cQ46k+CPuc79EkcNzqNN1gPzVkkz7noqUkzmzCpbTWwpF1iVPR+CwjAMaO4b5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbRfozG6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T0PwgcY00dmEA7hW8N56Wi13Enoq6qNEhgoYsfVh+9A=;
	b=XbRfozG62lUhjfA5yYAu3GGDfJFNS3JWTbayq9j+CejAqZ5Z/66mIXXowWFffct/n5oyXu
	e6XpOBdFyZHKjGFI+OQGOPB6Zfh8KiEFRGcI0ud8efiVtxN0jZIn5srPfKM5HG1rbw5bCt
	XMOC8UG++4cjL5qCYhR3ymvLVa53aas=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-oW13N3nrN_K8wRsUogg44g-1; Mon,
 20 Apr 2026 23:07:41 -0400
X-MC-Unique: oW13N3nrN_K8wRsUogg44g-1
X-Mimecast-MFC-AGG-ID: oW13N3nrN_K8wRsUogg44g_1776740856
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A40451800358;
	Tue, 21 Apr 2026 03:07:36 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E4F719560AB;
	Tue, 21 Apr 2026 03:07:29 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Costa Shulyupin <cshulyup@redhat.com>,
	Qiliang Yuan <realwujing@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 22/23] cgroup/cpuset: Prevent offline_disabled CPUs from being used in isolated partition
Date: Mon, 20 Apr 2026 23:03:50 -0400
Message-ID: <20260421030351.281436-23-longman@redhat.com>
In-Reply-To: <20260421030351.281436-1-longman@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-15400-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[53];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAC13435E8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If tick_nohz_full_enabled() is true, we are going to use CPU
hotplug to enable runtime changes to the HK_TYPE_KERNEL_NOISE and
HK_TYPE_MANAGED_IRQ cpumasks. However, for some architectures, one
or maybe more CPUs will have the offline_disabled flag set in their
cpu devices. For instance, x64-64 will set this flag for its boot CPU
(typically CPU 0) to disable it from going offline. Those CPUs can't
be used in cpuset isolated partition, or we are going to have problem
in the CPU offline process.

Find out the set of CPUs with offline_disabled set in a
new cpuset_init_late() helper, set the corresponding bits in
offline_disabled_cpus cpumask and check it when isolated partitions are
being created or modified to ensure that we will not use any of those
offline disabled CPUs in an isolated partition.

An error message mentioning those offline disabled CPUs will be
constructed in cpuset_init_late() and shown in "cpuset.cpus.partition"
when isolated creation or modification fails.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset-internal.h |  1 +
 kernel/cgroup/cpuset.c          | 89 ++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index fd7d19842ded..87b7411540ff 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -35,6 +35,7 @@ enum prs_errcode {
 	PERR_HKEEPING,
 	PERR_ACCESS,
 	PERR_REMOTE,
+	PERR_OL_DISABLED,
 };
 
 /* bits in struct cpuset flags field */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5f6b4e67748f..f3af8ef6c64e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -20,6 +20,8 @@
  */
 #include "cpuset-internal.h"
 
+#include <linux/cpu.h>
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -48,7 +50,7 @@ DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
  */
 DEFINE_STATIC_KEY_FALSE(cpusets_insane_config_key);
 
-static const char * const perr_strings[] = {
+static const char *perr_strings[] __ro_after_init = {
 	[PERR_INVCPUS]   = "Invalid cpu list in cpuset.cpus.exclusive",
 	[PERR_INVPARENT] = "Parent is an invalid partition root",
 	[PERR_NOTPART]   = "Parent is not a partition root",
@@ -59,6 +61,7 @@ static const char * const perr_strings[] = {
 	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
 	[PERR_ACCESS]    = "Enable partition not permitted",
 	[PERR_REMOTE]    = "Have remote partition underneath",
+	[PERR_OL_DISABLED] = "", /* To be set up later */
 };
 
 /*
@@ -164,6 +167,12 @@ static cpumask_var_t	isolated_mirq_cpus;	/* T */
 static bool		boot_nohz_le_domain __ro_after_init;
 static bool		boot_mirq_le_domain __ro_after_init;
 
+/*
+ * Cpumask of CPUs with offline_disabled set
+ * The cpumask is effectively __ro_after_init.
+ */
+static cpumask_var_t	offline_disabled_cpus;
+
 /*
  * A flag to force sched domain rebuild at the end of an operation.
  * It can be set in
@@ -1649,6 +1658,8 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	 * The effective_xcpus mask can contain offline CPUs, but there must
 	 * be at least one or more online CPUs present before it can be enabled.
 	 *
+	 * An isolated partition cannot contain CPUs with offline disabled.
+	 *
 	 * Note that creating a remote partition with any local partition root
 	 * above it or remote partition root underneath it is not allowed.
 	 */
@@ -1661,6 +1672,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	     !isolated_cpus_can_update(tmp->new_cpus, NULL)) ||
 	    prstate_housekeeping_conflict(new_prs, tmp->new_cpus))
 		return PERR_HKEEPING;
+	if (tick_nohz_full_enabled() && (new_prs == PRS_ISOLATED) &&
+	    cpumask_intersects(tmp->new_cpus, offline_disabled_cpus))
+		return PERR_OL_DISABLED;
 
 	spin_lock_irq(&callback_lock);
 	partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
@@ -1746,6 +1760,16 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 		goto invalidate;
 	}
 
+	/*
+	 * Isolated partition cannot contains CPUs with offline_disabled
+	 * bit set.
+	 */
+	if (tick_nohz_full_enabled() && (prs == PRS_ISOLATED) &&
+	    cpumask_intersects(excpus, offline_disabled_cpus)) {
+		cs->prs_err = PERR_OL_DISABLED;
+		goto invalidate;
+	}
+
 	adding   = cpumask_andnot(tmp->addmask, excpus, cs->effective_xcpus);
 	deleting = cpumask_andnot(tmp->delmask, cs->effective_xcpus, excpus);
 
@@ -1913,6 +1937,11 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		if (tasks_nocpu_error(parent, cs, xcpus))
 			return PERR_NOCPUS;
 
+		if (tick_nohz_full_enabled() &&
+		    (new_prs == PRS_ISOLATED) &&
+		    cpumask_intersects(xcpus, offline_disabled_cpus))
+			return PERR_OL_DISABLED;
+
 		/*
 		 * This function will only be called when all the preliminary
 		 * checks have passed. At this point, the following condition
@@ -1979,12 +2008,21 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 					       parent->effective_xcpus);
 		}
 
+		/*
+		 * Isolated partition cannot contain CPUs with offline_disabled
+		 * bit set.
+		 */
+		if (tick_nohz_full_enabled() &&
+		   ((old_prs == PRS_ISOLATED) ||
+		    (old_prs == PRS_INVALID_ISOLATED)) &&
+		    cpumask_intersects(newmask, offline_disabled_cpus)) {
+			part_error = PERR_OL_DISABLED;
 		/*
 		 * TBD: Invalidate a currently valid child root partition may
 		 * still break isolated_cpus_can_update() rule if parent is an
 		 * isolated partition.
 		 */
-		if (is_partition_valid(cs) && (old_prs != parent_prs)) {
+		} else if (is_partition_valid(cs) && (old_prs != parent_prs)) {
 			if ((parent_prs == PRS_ROOT) &&
 			    /* Adding to parent means removing isolated CPUs */
 			    !isolated_cpus_can_update(tmp->delmask, tmp->addmask))
@@ -1995,6 +2033,19 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 				part_error = PERR_HKEEPING;
 		}
 
+		if (part_error) {
+			deleting = false;
+			/*
+			 * For a previously valid partition, we need to move
+			 * the exclusive CPUs back to its parent.
+			 */
+			if (is_partition_valid(cs) &&
+			    !cpumask_empty(cs->effective_xcpus)) {
+				cpumask_copy(tmp->addmask, cs->effective_xcpus);
+				adding = true;
+			}
+		}
+
 		/*
 		 * The new CPUs to be removed from parent's effective CPUs
 		 * must be present.
@@ -3829,6 +3880,7 @@ int __init cpuset_init(void)
 	BUG_ON(!zalloc_cpumask_var(&subpartitions_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&isolated_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&isolated_hk_cpus, GFP_KERNEL));
+	BUG_ON(!zalloc_cpumask_var(&offline_disabled_cpus, GFP_KERNEL));
 
 	cpumask_setall(top_cpuset.cpus_allowed);
 	nodes_setall(top_cpuset.mems_allowed);
@@ -4188,6 +4240,39 @@ void __init cpuset_init_smp(void)
 	BUG_ON(!cpuset_migrate_mm_wq);
 }
 
+/**
+ * cpuset_init_late - initialize the list of CPUs with offline_disabled set
+ *
+ * Description: Initialize a cpumask with CPUs that have the offline_disabled
+ *		bit set. It is done in a separate initcall as cpuset_init_smp()
+ *		is called before driver_init() where the CPU devices will be
+ *		set up.
+ */
+static int __init cpuset_init_late(void)
+{
+	int cpu;
+
+	if (!tick_nohz_full_enabled())
+		return 0;
+	/*
+	 * Iterate all the possible CPUs to see which one has offline disabled.
+	 */
+	for_each_possible_cpu(cpu) {
+		if (get_cpu_device(cpu)->offline_disabled)
+			__cpumask_set_cpu(cpu, offline_disabled_cpus);
+	}
+	if (!cpumask_empty(offline_disabled_cpus)) {
+		char buf[128];
+
+		snprintf(buf, sizeof(buf),
+			 "CPU %*pbl with offline disabled not allowed in isolated partition",
+			 cpumask_pr_args(offline_disabled_cpus));
+		perr_strings[PERR_OL_DISABLED] = kstrdup(buf, GFP_KERNEL);
+	}
+	return 0;
+}
+pure_initcall(cpuset_init_late);
+
 /*
  * Return cpus_allowed mask from a task's cpuset.
  */
-- 
2.53.0



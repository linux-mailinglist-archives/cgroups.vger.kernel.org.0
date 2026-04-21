Return-Path: <cgroups+bounces-15398-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGnABWfr5mlx1wEAu9opvQ
	(envelope-from <cgroups+bounces-15398-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:13:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0E5435E27
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC7AA30091C6
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7652439EF2A;
	Tue, 21 Apr 2026 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOELoH6H"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936B539DBD6
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740854; cv=none; b=GUJrncl3wRmH+C7JnYVIGTvxVqiFT76U5H7zUpk2atHeL/uZXBSB+hKZ/Sk4fyBdTNI6x/E0Do9s5uMhWA9RTVta/c+WBRsY+9Q0o29GqA/dD1nQf4kW/Ix023HvNkO+XQsz7d0ES4spU9Ew/Cv4uksTYW3orgidDbaM2R4CVK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740854; c=relaxed/simple;
	bh=y4yP5tRZ7eQlB15SkfEhgLy4KCCMqsQOclN9c++lXS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IX38Y6ozJiibiidYQd5GMcsuw2hK1NcfT/6NUYbY1JYwnIdtG1NQib1Mqu1z8BlqopZAPEf5DgPtQlAjnJ8EHf8ePsDp481lxNZgbHGrVfcnKtFhorcGVXIabo8TQ5fI9nXQ+niL83iRlW6pCNu9KEPdDE7RtP/chkiK3/GWHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOELoH6H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rj/Vtbhr3JXvU2mTPHbZebZmch25NsVuRvhs8pJ62G8=;
	b=LOELoH6Hqx+wrUrKc/qDfcmQMfkQI/3rdEIcISnu09umJcvoqLUb9M6aoUB6ssnxeKvvKN
	wyo9oAfZ6TANVBR1HDSAGsbNM6qkKPABqI8hXU95vDOQUNxK1tFZ4DpmVlAMLIoTab+MqM
	tAw07NdeE1tWWrcG2yxKEXFF2mj2ITU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-SDq97JYuPx29ycCUXIoJEQ-1; Mon,
 20 Apr 2026 23:07:26 -0400
X-MC-Unique: SDq97JYuPx29ycCUXIoJEQ-1
X-Mimecast-MFC-AGG-ID: SDq97JYuPx29ycCUXIoJEQ_1776740841
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5189019560B9;
	Tue, 21 Apr 2026 03:07:21 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E7F419560AB;
	Tue, 21 Apr 2026 03:07:14 +0000 (UTC)
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
Subject: [PATCH 20/23] cgroup/cpuset: Enable runtime update of HK_TYPE_{KERNEL_NOISE,MANAGED_IRQ} cpumasks
Date: Mon, 20 Apr 2026 23:03:48 -0400
Message-ID: <20260421030351.281436-21-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-15398-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 1D0E5435E27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

One simple way to enable runtime update of HK_TYPE_KERNEL_NOISE
(nohz_full) and HK_TYPE_MANAGED_IRQ cpumasks is to make use of the CPU
hotplug to facilitate the transition of those CPUs that are changing
states as long as CONFIG_HOTPLUG_CPU is enabled and a nohz_full boot
parameter is provided. Otherwise, only HK_TYPE_DOMAIN cpumask will be
updated at run time.

For changes in HK_TYPE_DOMAIN cpumask, it can be done without using CPU
hotplug. For changes in HK_TYPE_MANAGED_IRQ cpumask, we have to update
the cpumask first and then tear down and bring up the newly isolated
CPUs to migrate the managed irqs in those CPUs to other housekeeping
CPUs.

For changes in HK_TYPE_KERNEL_NOISE, we have to tear down all the newly
isolated and de-isolated CPUs, change the cpumask and then bring all the
offline CPUs back online.

As it is possible that the various boot versions of the housekeeping
cpumasks are different resulting in the use of different set of isolated
cpumasks for calling housekeeping_update(), we may need to pre-allocate
these cpumasks if necessary.

Note that the use of CPU hotplug to facilitate the changing of
HK_TYPE_KERNEL_NOISE and HK_TYPE_MANAGED_IRQ housekeeping cpumasks has
the drawback that during the tear down of a CPU from CPUHP_TEARDOWN_CPU
state to CPUHP_AP_OFFLINE, the stop_machine code will be invoked to stop
all the other CPUs including all the pre-existing isolated CPUs. That
will cause latency spikes on those isolated CPUs. That latency spike
should only happen when the cpuset isolated partition setting is changed
resulting in changes in those housekeeping cpumasks.

One possible workaround that is being used right now is to pre-allocate
a set of nohz_full and managed_irq CPUs at boot time. The semi-isolated
CPUs are then used to create cpuset isolated partitions when needed
to enable full isolation. This will likely continue even if we made
the nohz_full and managed_irq CPUs runtime changeable if they can't
tolerate these latency spikes.

This is a problem we need to address in a future patch series.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 199 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 182 insertions(+), 17 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1b0c50b46a49..a927b9cd4f71 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -152,9 +152,17 @@ static cpumask_var_t	isolated_cpus;		/* CSCB */
 static bool		update_housekeeping;	/* RWCS */
 
 /*
- * Copy of isolated_cpus to be passed to housekeeping_update()
+ * Cpumasks to be passed to housekeeping_update()
+ * isolated_hk_cpus - copy of isolated_cpus for HK_TYPE_DOMAIN
+ * isolated_nohz_cpus - for HK_TYPE_KERNEL_NOISE
+ * isolated_mirq_cpus - for HK_TYPE_MANAGED_IRQ
  */
 static cpumask_var_t	isolated_hk_cpus;	/* T */
+static cpumask_var_t	isolated_nohz_cpus;	/* T */
+static cpumask_var_t	isolated_mirq_cpus;	/* T */
+
+static bool		boot_nohz_le_domain __ro_after_init;
+static bool		boot_mirq_le_domain __ro_after_init;
 
 /*
  * A flag to force sched domain rebuild at the end of an operation.
@@ -1328,29 +1336,67 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 	return false;
 }
 
+static int cpuset_nohz_update_cbfunc(void *arg)
+{
+	struct cpumask *isol_cpus = (struct cpumask *)arg;
+
+	if (isol_cpus)
+		housekeeping_update(isol_cpus, BIT(HK_TYPE_KERNEL_NOISE));
+	return 0;
+}
+
 /*
- * cpuset_update_sd_hk_unlock - Rebuild sched domains, update HK & unlock
- *
- * Update housekeeping cpumasks and rebuild sched domains if necessary and
- * then do a cpuset_full_unlock().
- * This should be called at the end of cpuset operation.
  */
-static void cpuset_update_sd_hk_unlock(void)
-	__releases(&cpuset_mutex)
-	__releases(&cpuset_top_mutex)
+static void cpuset_update_housekeeping_unlock(void)
 {
-	update_housekeeping = false;
+	bool update_nohz, update_mirq;
+	cpumask_var_t cpus;
+	int ret;
 
-	/* force_sd_rebuild will be cleared in rebuild_sched_domains_locked() */
-	if (force_sd_rebuild)
-		rebuild_sched_domains_locked();
+	if (!tick_nohz_full_enabled())
+		return;
 
-	if (cpumask_equal(isolated_hk_cpus, isolated_cpus)) {
-		/* No housekeeping cpumask update needed */
+	update_nohz = boot_nohz_le_domain;
+	update_mirq = boot_mirq_le_domain;
+
+	if (WARN_ON_ONCE(!alloc_cpumask_var(&cpus, GFP_KERNEL))) {
 		cpuset_full_unlock();
 		return;
 	}
 
+	/*
+	 * Update isolated_nohz_cpus/isolated_mirq_cpus if necessary
+	 */
+	if (!boot_nohz_le_domain) {
+		cpumask_andnot(cpus, cpu_possible_mask,
+			       housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
+		cpumask_or(cpus, cpus, isolated_cpus);
+		update_nohz = !cpumask_equal(isolated_nohz_cpus, cpus);
+		if (update_nohz)
+			cpumask_copy(isolated_nohz_cpus, cpus);
+	}
+	if (!boot_mirq_le_domain) {
+		cpumask_andnot(cpus, cpu_possible_mask,
+			       housekeeping_cpumask(HK_TYPE_MANAGED_IRQ));
+		cpumask_or(cpus, cpus, isolated_cpus);
+		update_mirq = !cpumask_equal(isolated_mirq_cpus, cpus);
+		if (update_mirq)
+			cpumask_copy(isolated_mirq_cpus, cpus);
+	}
+
+	/*
+	 * Compute list of CPUs to be brought offline into "cpus"
+	 * isolated_hk_cpus - old cpumask
+	 * isolated_cpus    - new cpumask
+	 *
+	 * With update_nohz, we need to offline both the newly isolated
+	 * and de-isolated CPUs. With only update_mirq, we only need to
+	 * offline the new isolated CPUs.
+	 */
+	if (update_nohz)
+		cpumask_xor(cpus, isolated_hk_cpus, isolated_cpus);
+	else if (update_mirq)
+		cpumask_andnot(cpus, isolated_cpus, isolated_hk_cpus);
 	cpumask_copy(isolated_hk_cpus, isolated_cpus);
 
 	/*
@@ -1360,10 +1406,103 @@ static void cpuset_update_sd_hk_unlock(void)
 	 */
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
-	WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus, BIT(HK_TYPE_DOMAIN)));
+
+	if (!update_mirq) {
+		ret = housekeeping_update(isolated_hk_cpus, BIT(HK_TYPE_DOMAIN));
+	} else if (boot_mirq_le_domain) {
+		ret = housekeeping_update(isolated_hk_cpus,
+					  BIT(HK_TYPE_DOMAIN)|BIT(HK_TYPE_MANAGED_IRQ));
+	} else {
+		ret = housekeeping_update(isolated_hk_cpus, BIT(HK_TYPE_DOMAIN));
+		if (!ret)
+			ret = housekeeping_update(isolated_mirq_cpus,
+						  BIT(HK_TYPE_MANAGED_IRQ));
+	}
+
+	if (WARN_ON_ONCE(ret))
+		goto out_free;
+
+	/*
+	 * Calling cpuhp_offline_cb() is only needed if either
+	 * HK_TYPE_KERNEL_NOISE and/or HK_TYPE_MANAGED_IRQ cpumasks
+	 * needed to be updated.
+	 *
+	 * TODO: When tearing down a CPU from CPUHP_TEARDOWN_CPU state
+	 * downward to CPUHP_AP_OFFLINE, the stop_machine code will be
+	 * invoked to stop all the other CPUs in the system. This will
+	 * cause latency spikes on existing isolated CPUs. We will need
+	 * some new mechanism to enable us to not stop the existing
+	 * isolated CPUs whenever possible. A possible workaround is
+	 * to pre-allocate a set of nohz_full and manged_irq CPUs at
+	 * boot time and use them to create isolated cpuset partitions
+	 * so that CPU hotplug won't need to be used.
+	 */
+	if (update_mirq || update_nohz) {
+		struct cpumask *nohz_cpus;
+
+		/*
+		 * Calling housekeeping_update() is only needed if
+		 * update_nohz is set.
+		 */
+		nohz_cpus = !update_nohz ? NULL : boot_nohz_le_domain
+					 ? isolated_hk_cpus
+					 : isolated_nohz_cpus;
+		/*
+		 * Mask out offline CPUs in cpus
+		 * If there is no online CPUs, we can call
+		 * housekeeping_update() directly if needed.
+		 */
+		cpumask_and(cpus, cpus, cpu_online_mask);
+		if (!cpumask_empty(cpus))
+			ret = cpuhp_offline_cb(cpus, cpuset_nohz_update_cbfunc,
+					       nohz_cpus);
+		else if (nohz_cpus)
+			ret = housekeeping_update(nohz_cpus, BIT(HK_TYPE_KERNEL_NOISE));
+	}
+	WARN_ON_ONCE(ret);
+out_free:
+	free_cpumask_var(cpus);
 	mutex_unlock(&cpuset_top_mutex);
 }
 
+/*
+ * cpuset_update_sd_hk_unlock - Rebuild sched domains, update HK & unlock
+ *
+ * Update housekeeping cpumasks and rebuild sched domains if necessary and
+ * then do a cpuset_full_unlock().
+ * This should be called at the end of cpuset operation.
+ */
+static void cpuset_update_sd_hk_unlock(void)
+	__releases(&cpuset_mutex)
+	__releases(&cpuset_top_mutex)
+{
+	/* force_sd_rebuild will be cleared in rebuild_sched_domains_locked() */
+	if (force_sd_rebuild)
+		rebuild_sched_domains_locked();
+
+	update_housekeeping = false;
+
+	if (cpumask_equal(isolated_cpus, isolated_hk_cpus)) {
+		cpuset_full_unlock();
+		return;
+	}
+
+	if (!tick_nohz_full_enabled()) {
+		/*
+		 * housekeeping_update() is now called without holding
+		 * cpus_read_lock and cpuset_mutex. Only cpuset_top_mutex
+		 * is still being held for mutual exclusion.
+		 */
+		mutex_unlock(&cpuset_mutex);
+		cpus_read_unlock();
+		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus,
+						 BIT(HK_TYPE_DOMAIN)));
+		mutex_unlock(&cpuset_top_mutex);
+	} else {
+		cpuset_update_housekeeping_unlock();
+	}
+}
+
 /*
  * Work function to invoke cpuset_update_sd_hk_unlock()
  */
@@ -3700,6 +3839,29 @@ int __init cpuset_init(void)
 			       housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
 		cpumask_copy(isolated_hk_cpus, isolated_cpus);
 	}
+
+	/*
+	 * If nohz_full and/or managed_irq cpu list, if present, is a subset
+	 * of the domain cpu list, i.e. HK_TYPE_DOMAIN_BOOT cpumask is a subset
+	 * of HK_TYPE_KERNEL_NOISE_BOOT/HK_TYPE_MANAGED_IRQ_BOOT cpumask, the
+	 * corresponding non-boot housekeeping cpumasks will follow changes
+	 * in the HK_TYPE_DOMAIN cpumask. So we don't need to use separate
+	 * cpumasks to isolate them.
+	 */
+	boot_nohz_le_domain = cpumask_subset(housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT),
+					     housekeeping_cpumask(HK_TYPE_KERNEL_NOISE_BOOT));
+	boot_mirq_le_domain = cpumask_subset(housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT),
+					     housekeeping_cpumask(HK_TYPE_MANAGED_IRQ_BOOT));
+	if (!boot_nohz_le_domain) {
+		BUG_ON(!alloc_cpumask_var(&isolated_nohz_cpus, GFP_KERNEL));
+		cpumask_andnot(isolated_nohz_cpus, cpu_possible_mask,
+			       housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
+	}
+	if (!boot_mirq_le_domain) {
+		BUG_ON(!alloc_cpumask_var(&isolated_mirq_cpus, GFP_KERNEL));
+		cpumask_andnot(isolated_mirq_cpus, cpu_possible_mask,
+			       housekeeping_cpumask(HK_TYPE_MANAGED_IRQ));
+	}
 	return 0;
 }
 
@@ -3954,7 +4116,10 @@ static void cpuset_handle_hotplug(void)
 	 */
 	if (force_sd_rebuild)
 		rebuild_sched_domains_cpuslocked();
-	if (update_housekeeping)
+	/*
+	 * Don't need to update housekeeping cpumasks in cpuhp_offline_cb mode.
+	 */
+	if (update_housekeeping && !cpuhp_offline_cb_mode)
 		queue_work(system_dfl_wq, &hk_sd_work);
 
 	free_tmpmasks(ptmp);
-- 
2.53.0



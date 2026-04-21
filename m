Return-Path: <cgroups+bounces-15380-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HAmFgDq5mlx1wEAu9opvQ
	(envelope-from <cgroups+bounces-15380-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:07:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C54C2435B73
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21E43301AF4C
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC4D365A19;
	Tue, 21 Apr 2026 03:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OElpFtJn"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AFE3644C3
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740719; cv=none; b=MO+f/fnUh3Sc/TNnk5Gf9ZQ/clWOs0hLr+PjFpy3EM5/tfBRZflbmg55HNaEM9voVLLKb+90MO0XinVc8PrUz+jHMk3hMrJ65Mu0To9DyIw42wPJlU7KxwF7FpQGbZFpNtIT/GEs+7Jioi63mACP+ldr0M62UQtGCtzcU6ioD+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740719; c=relaxed/simple;
	bh=1Nd7aPAPB5e+PcIf2RAe7/ngkqO3BsCY9Zy6mLvapVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B05dwxhI0FWgoVOhdvQC8cNg5d35/+SNNXxTrQmu/Sah4RUd94soIW/RCnjAwSubBkpYwfGl3FZazGzgW3qhS3/HuO4BJN+PcL8IU9ewzQfyOHtZ+8cPJFiQZr3oF6u3jK0Kx1Hvn0vxNkVBNJJud/wxh7hHf8rQMUK+4WSU0y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OElpFtJn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQviQUpprZdMxpcMLHlo8S0MLdAxDjnOlUbcwDg0V50=;
	b=OElpFtJnlv+JjEJlibF3Nr+PPBHnS9FX+Yi341eWsYo5IYjCG9h6WpDY85i3H491NPJ/77
	aLxRE1BYts5jfcRyBOHLs3WXOpKavOw5lC6BisQowEEPM0Do3fBWlV+MBQ0LRWCMNF6Jlh
	3sQ0keZNeVuYmx9AQ4FIwaadX3hhvIY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-IEHGJGybNguUVibdx0jmng-1; Mon,
 20 Apr 2026 23:05:13 -0400
X-MC-Unique: IEHGJGybNguUVibdx0jmng-1
X-Mimecast-MFC-AGG-ID: IEHGJGybNguUVibdx0jmng_1776740708
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E4CA18001C7;
	Tue, 21 Apr 2026 03:05:07 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E6DE819560AB;
	Tue, 21 Apr 2026 03:04:58 +0000 (UTC)
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
Subject: [PATCH 02/23] sched/isolation: Enhance housekeeping_update() to support updating more than one HK cpumask
Date: Mon, 20 Apr 2026 23:03:30 -0400
Message-ID: <20260421030351.281436-3-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-15380-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C54C2435B73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The housekeeping_update() function currently allows update to the
HK_TYPE_DOMAIN cpumask only. As we are going to enable dynamic
modification of the other housekeeping cpumasks, we need to extend
it to support passing in the information about the HK cpumask(s) to
be updated.  In cases where some HK cpumasks happen to be the same,
it will be more efficient to update multiple HK cpumasks in one single
call instead of calling it multiple times. Extend housekeeping_update()
to support that as well.

Also add the restriction that passed in isolated cpumask parameter
of housekeeping_update() must include all the CPUs isolated at boot
time. This is currently the case for cpuset anyway.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched/isolation.h |  2 +-
 kernel/cgroup/cpuset.c          |  2 +-
 kernel/sched/isolation.c        | 99 +++++++++++++++++++++++----------
 3 files changed, 71 insertions(+), 32 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index d1707f121e20..a17f16e0156e 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -51,7 +51,7 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
 extern bool housekeeping_enabled(enum hk_type type);
 extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
 extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
-extern int housekeeping_update(struct cpumask *isol_mask);
+extern int housekeeping_update(struct cpumask *isol_mask, unsigned long flags);
 extern void __init housekeeping_init(void);
 
 #else
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1335e437098e..a4eccb0ec0d1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1354,7 +1354,7 @@ static void cpuset_update_sd_hk_unlock(void)
 		 */
 		mutex_unlock(&cpuset_mutex);
 		cpus_read_unlock();
-		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus));
+		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus, BIT(HK_TYPE_DOMAIN)));
 		mutex_unlock(&cpuset_top_mutex);
 	} else {
 		cpuset_full_unlock();
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 9ec9ae510dc7..965d6f8fe344 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -120,48 +120,87 @@ bool housekeeping_test_cpu(int cpu, enum hk_type type)
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 
-int housekeeping_update(struct cpumask *isol_mask)
-{
-	struct cpumask *trial, *old = NULL;
-	int err;
+/* HK type processing table */
+static struct {
+	int type;
+	int boot_type;
+} hk_types[] = {
+	{ HK_TYPE_DOMAIN,       HK_TYPE_DOMAIN_BOOT	  },
+	{ HK_TYPE_MANAGED_IRQ,  HK_TYPE_MANAGED_IRQ_BOOT  },
+	{ HK_TYPE_KERNEL_NOISE, HK_TYPE_KERNEL_NOISE_BOOT }
+};
 
-	trial = kmalloc(cpumask_size(), GFP_KERNEL);
-	if (!trial)
-		return -ENOMEM;
+#define HK_TYPE_CNT	ARRAY_SIZE(hk_types)
 
-	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), isol_mask);
-	if (!cpumask_intersects(trial, cpu_online_mask)) {
-		kfree(trial);
-		return -EINVAL;
+int housekeeping_update(struct cpumask *isol_mask, unsigned long flags)
+{
+	struct cpumask *trial[HK_TYPE_CNT];
+	int i, err = 0;
+
+	for (i = 0; i < HK_TYPE_CNT; i++) {
+		int type = hk_types[i].type;
+		int boot = hk_types[i].boot_type;
+
+		trial[i] = NULL;
+		if (flags & BIT(type)) {
+			trial[i] = kmalloc(cpumask_size(), GFP_KERNEL);
+			if (!trial[i]) {
+				err = -ENOMEM;
+				goto out;
+			}
+			/*
+			 * The new HK cpumask must be a subset of its boot
+			 * cpumask.
+			 */
+			cpumask_andnot(trial[i], cpu_possible_mask, isol_mask);
+			if (!cpumask_intersects(trial[i], cpu_online_mask) ||
+			    !cpumask_subset(trial[i], housekeeping_cpumask(boot))) {
+				i++;
+				err = -EINVAL;
+				goto out;
+			}
+		}
 	}
 
 	if (!housekeeping.flags)
 		static_branch_enable(&housekeeping_overridden);
 
-	if (housekeeping.flags & HK_FLAG_DOMAIN)
-		old = housekeeping_cpumask_dereference(HK_TYPE_DOMAIN);
-	else
-		WRITE_ONCE(housekeeping.flags, housekeeping.flags | HK_FLAG_DOMAIN);
-	rcu_assign_pointer(housekeeping.cpumasks[HK_TYPE_DOMAIN], trial);
-
-	synchronize_rcu();
-
-	pci_probe_flush_workqueue();
-	mem_cgroup_flush_workqueue();
-	vmstat_flush_workqueue();
+	for (i = 0; i < HK_TYPE_CNT; i++) {
+		int type =  hk_types[i].type;
+		struct cpumask *old;
 
-	err = workqueue_unbound_housekeeping_update(housekeeping_cpumask(HK_TYPE_DOMAIN));
-	WARN_ON_ONCE(err < 0);
+		if (!trial[i])
+			continue;
+		old = NULL;
+		if (housekeeping.flags & BIT(type))
+			old = housekeeping_cpumask_dereference(type);
+		rcu_assign_pointer(housekeeping.cpumasks[type], trial[i]);
+		trial[i] = old;
+	}
 
-	err = tmigr_isolated_exclude_cpumask(isol_mask);
-	WARN_ON_ONCE(err < 0);
+	if ((housekeeping.flags & flags) != flags)
+		WRITE_ONCE(housekeeping.flags, housekeeping.flags | flags);
 
-	err = kthreads_update_housekeeping();
-	WARN_ON_ONCE(err < 0);
+	synchronize_rcu();
 
-	kfree(old);
+	if (flags & HK_FLAG_DOMAIN) {
+		/*
+		 * HK_TYPE_DOMAIN specific callbacks
+		 */
+		pci_probe_flush_workqueue();
+		mem_cgroup_flush_workqueue();
+		vmstat_flush_workqueue();
+
+		WARN_ON_ONCE(workqueue_unbound_housekeeping_update(
+				housekeeping_cpumask(HK_TYPE_DOMAIN)) < 0);
+		WARN_ON_ONCE(tmigr_isolated_exclude_cpumask(isol_mask) < 0);
+		WARN_ON_ONCE(kthreads_update_housekeeping() < 0);
+	}
 
-	return 0;
+out:
+	while (--i >= 0)
+		kfree(trial[i]);
+	return err;
 }
 
 void __init housekeeping_init(void)
-- 
2.53.0



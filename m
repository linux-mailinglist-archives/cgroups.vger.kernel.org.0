Return-Path: <cgroups+bounces-15396-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHgyJ7br5mlx1wEAu9opvQ
	(envelope-from <cgroups+bounces-15396-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:15:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D001435EF4
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C506230A49C3
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3665C3783A0;
	Tue, 21 Apr 2026 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMDvojSP"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C5B377EA5
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740839; cv=none; b=EZwB28lnPtHcsFg1euRW6+KcFYhMjW0vCHJr7f5mHCxoouggb37WKY0EV2b9GVv0begTlWOFUwWsiQ6aL0RWjujzR4jZ7dlcaeg0pgXyxTI7amBgtJHw3F4xbi8f2FQ9Rz2yFgHpbt8KmqLDIeopibLci+dXDDRSnTgBYAZirbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740839; c=relaxed/simple;
	bh=7PyCAYPTzVOicWSr/jRl6qoxbI9T+FJqQCf6F+XuTOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6ycwnunaMx2pAaLrjrXgTfSrE+Up6xCn0iLGNE7v9zzRXCOivSLv+7bSEDd2VKBBaxVq04XZpFDdzcjHgHLpKhRRnOEN7pzYqlE1Ttti6wt6xovB98rIB85HLVuaKfclHDMGtXw90WGmd605PuPE2RVv1qTVHWLxH2cXA5RFkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMDvojSP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3J2xEvoiZlc0ekRXR4e4rpd5+KNi4GznOay8CXNFrmI=;
	b=NMDvojSP4LOX0TqP4tPd5V7VOZmf5WHCJEaFqAwiZRsaqVqFO0WUyci0LjrU75nroq+OZE
	Cgul89Gp9h40b9iGPkVy8hWSvYW0ddEsonCj3YLDpEZ+2q79v/ngkg2ZK4JYRyV0/Vr6Ix
	Rf6hb3SstYpyE0BE6+f1K6iRJ2Blku4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-TOLBnhFlOXqsjWlnoZiSkQ-1; Mon,
 20 Apr 2026 23:07:11 -0400
X-MC-Unique: TOLBnhFlOXqsjWlnoZiSkQ-1
X-Mimecast-MFC-AGG-ID: TOLBnhFlOXqsjWlnoZiSkQ_1776740827
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E22E61956056;
	Tue, 21 Apr 2026 03:07:06 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D134019560AB;
	Tue, 21 Apr 2026 03:06:59 +0000 (UTC)
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
Subject: [PATCH 18/23] cpu/hotplug: Add a new cpuhp_offline_cb() API
Date: Mon, 20 Apr 2026 23:03:46 -0400
Message-ID: <20260421030351.281436-19-longman@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-15396-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 3D001435EF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new cpuhp_offline_cb() API that allows us to offline a set of
CPUs one-by-one, run the given callback function and then bring those
CPUs back online again while inhibiting any concurrent CPU hotplug
operations from happening.

This new API can be used to enable runtime adjustment of nohz_full and
isolcpus boot command line options. A new cpuhp_offline_cb_mode flag
is also added to signal that the system is in this offline callback
transient state so that some hotplug operations can be optimized out
if we choose to.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cpuhplock.h |  9 +++++
 kernel/cpu.c              | 70 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/linux/cpuhplock.h b/include/linux/cpuhplock.h
index 286b3ab92e15..37637baa32eb 100644
--- a/include/linux/cpuhplock.h
+++ b/include/linux/cpuhplock.h
@@ -9,7 +9,9 @@
 
 #include <linux/cleanup.h>
 #include <linux/errno.h>
+#include <linux/cpumask_types.h>
 
+typedef int (*cpuhp_cb_t)(void *arg);
 struct device;
 
 extern int lockdep_is_cpus_held(void);
@@ -29,6 +31,8 @@ void clear_tasks_mm_cpumask(int cpu);
 int remove_cpu(unsigned int cpu);
 int cpu_device_down(struct device *dev);
 void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
+int cpuhp_offline_cb(struct cpumask *mask, cpuhp_cb_t func, void *arg);
+extern bool cpuhp_offline_cb_mode;
 
 #else /* CONFIG_HOTPLUG_CPU */
 
@@ -43,6 +47,11 @@ static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
 static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
 static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
+static inline int cpuhp_offline_cb(struct cpumask *mask, cpuhp_cb_t func, void *arg)
+{
+	return -EPERM;
+}
+#define cpuhp_offline_cb_mode	false
 #endif	/* !CONFIG_HOTPLUG_CPU */
 
 DEFINE_LOCK_GUARD_0(cpus_read_lock, cpus_read_lock(), cpus_read_unlock())
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0d02b5d7a7ba..9b32f742cd1d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1520,6 +1520,76 @@ int remove_cpu(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(remove_cpu);
 
+bool cpuhp_offline_cb_mode;
+
+/**
+ * cpuhp_offline_cb - offline CPUs, invoke callback function & online CPUs afterward
+ * @mask: A mask of CPUs to be taken offline and then online
+ * @func: A callback function to be invoked while the given CPUs are offline
+ * @arg:  Argument to be passed back to the callback function
+ *
+ * Return: 0 if successful, an error code otherwise
+ */
+int cpuhp_offline_cb(struct cpumask *mask, cpuhp_cb_t func, void *arg)
+{
+	int off_cpu, on_cpu, ret, ret2 = 0;
+
+	if (WARN_ON_ONCE(cpumask_empty(mask) ||
+	   !cpumask_subset(mask, cpu_online_mask)))
+		return -EINVAL;
+
+	pr_debug("%s: begin (CPU list = %*pbl)\n", __func__, cpumask_pr_args(mask));
+	lock_device_hotplug();
+	cpuhp_offline_cb_mode = true;
+	/*
+	 * If all offline operations succeed, off_cpu should become nr_cpu_ids.
+	 */
+	for_each_cpu(off_cpu, mask) {
+		ret = device_offline(get_cpu_device(off_cpu));
+		if (unlikely(ret))
+			break;
+	}
+	if (!ret)
+		ret = func(arg);
+
+	/* Bring previously offline CPUs back online */
+	for_each_cpu(on_cpu, mask) {
+		int retries = 0;
+
+		if (on_cpu == off_cpu)
+			break;
+
+retry:
+		ret2 = device_online(get_cpu_device(on_cpu));
+
+		/*
+		 * With the unlikely event that CPU hotplug is disabled while
+		 * this operation is in progress, we will need to wait a bit
+		 * for hotplug to hopefully be re-enabled again. If not, print
+		 * a warning and return the error.
+		 *
+		 * cpu_hotplug_disabled is supposed to be accessed while
+		 * holding the cpu_add_remove_lock mutex. So we need to
+		 * use the data_race() macro to access it here.
+		 */
+		while ((ret2 == -EBUSY) && data_race(cpu_hotplug_disabled) &&
+		       (++retries <= 5)) {
+			msleep(20);
+			if (!data_race(cpu_hotplug_disabled))
+				goto retry;
+		}
+		if (ret2) {
+			pr_warn("%s: Failed to bring CPU %d back online!\n",
+				__func__, on_cpu);
+			break;
+		}
+	}
+	cpuhp_offline_cb_mode = false;
+	unlock_device_hotplug();
+	pr_debug("%s: end\n", __func__);
+	return ret ? ret : ret2;
+}
+
 void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
 {
 	unsigned int cpu;
-- 
2.53.0



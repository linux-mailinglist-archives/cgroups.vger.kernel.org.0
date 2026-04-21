Return-Path: <cgroups+bounces-15384-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IME7LtDq5mlx1wEAu9opvQ
	(envelope-from <cgroups+bounces-15384-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:11:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C500435CF0
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5742B30649C0
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6603371071;
	Tue, 21 Apr 2026 03:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ml9oJTm6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B075366061
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740750; cv=none; b=BOLBYFKNRVveWxDaVwGl8qwoeocpch+tBQ6a1uzehG/DBYPOMCmZd8RnnX75j/1xCFKMPjAAVM2ovFss8jluK+VwhDdT7oUbvm7pB4bk95hLZCb9OL3Gwco8EzhL8d7q/AeAvfpWT3tFddikx5BRI2ynCE6pN9GlupoO8aefyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740750; c=relaxed/simple;
	bh=rOGBf0wYekJdoD4SBA74vbDVOqUx1Wsq4aN0zXB95Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1dNdB+5WCjNE4aa99hrC0kSOaQERjW+8zFLKqeZSLEgFjiskz8vAVLSRrH7gQAHIaFYRTLyMLEp1VL9axIJwoY01SUWu6wzpg/N5p/BSdr6URzsohJSe5Nqt5vhc/8aI46N7Avg9E6/D7rBXHbQIn+LXu0KHnOOg+eQCxP6VH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ml9oJTm6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VstpRTEn9ptpP1VmY9IUyGFYY+MvC6/GBVaS0P0YxY=;
	b=Ml9oJTm6iSanwimrg9raD1jFqjHevpZ08ky1VeXvA0ZEAJVhwPxLCLGFR/MJdFVCTotkWD
	NCGIxPbp388RBUJ7v5+tWQqjoBA9v3BsJlgkb6zB7x1pA9JzWaqWG1I3kbMHNjVl9cRSr1
	7lSS8eX3aQj6Lms+bmj/FKVD21ZI+IU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-wfxxcSTJNc2iOwvbuYVEbw-1; Mon,
 20 Apr 2026 23:05:44 -0400
X-MC-Unique: wfxxcSTJNc2iOwvbuYVEbw-1
X-Mimecast-MFC-AGG-ID: wfxxcSTJNc2iOwvbuYVEbw_1776740740
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEEC219560BC;
	Tue, 21 Apr 2026 03:05:38 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CECEB19560AB;
	Tue, 21 Apr 2026 03:05:31 +0000 (UTC)
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
Subject: [PATCH 06/23] rcu/nocbs: Allow runtime changes in RCU NOCBS cpumask
Date: Mon, 20 Apr 2026 23:03:34 -0400
Message-ID: <20260421030351.281436-7-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-15384-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 5C500435CF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We can make use of the rcu_nocb_cpu_offload()/rcu_nocb_cpu_deoffload()
APIs to enable RCU NO-CB CPU offloading of newly isolated CPUs and
deoffloading of de-isolated CPUs.

Add a new rcu_nocb_update_cpus() helper to do that and call it directly
from housekeeping_update() when the HK_TYPE_KERNEL_NOISE cpumask is
being changed.

This dynamic RCU NO-CB CPU offloading feature can only used if either
"rcs_nocbs" or the "nohz_full" boot command parameters are used with or
without parameter so that the proper RCU NO-CB resources are properly
initialized at boot time.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rcupdate.h |  2 ++
 kernel/rcu/tree_nocb.h   | 22 ++++++++++++++++++++++
 kernel/sched/isolation.c |  4 +++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 04f3f86a4145..987e3d1d413e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -150,6 +150,7 @@ void rcu_init_nohz(void);
 int rcu_nocb_cpu_offload(int cpu);
 int rcu_nocb_cpu_deoffload(int cpu);
 void rcu_nocb_flush_deferred_wakeup(void);
+void rcu_nocb_update_cpus(struct cpumask *cpumask);
 
 #define RCU_NOCB_LOCKDEP_WARN(c, s) RCU_LOCKDEP_WARN(c, s)
 
@@ -159,6 +160,7 @@ static inline void rcu_init_nohz(void) { }
 static inline int rcu_nocb_cpu_offload(int cpu) { return -EINVAL; }
 static inline int rcu_nocb_cpu_deoffload(int cpu) { return 0; }
 static inline void rcu_nocb_flush_deferred_wakeup(void) { }
+static inline void rcu_nocb_update_cpus(struct cpumask *cpumask) { }
 
 #define RCU_NOCB_LOCKDEP_WARN(c, s)
 
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 2d06dcb61f37..b2daba1e5cb9 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1173,6 +1173,28 @@ int rcu_nocb_cpu_offload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
+void rcu_nocb_update_cpus(struct cpumask *cpumask)
+{
+	int cpu, ret;
+
+	if (!rcu_state.nocb_is_setup) {
+		pr_warn_once("Dynamic RCU NOCB cannot be enabled without nohz_full/rcu_nocbs kernel boot parameter!\n");
+		return;
+	}
+
+	for_each_cpu_andnot(cpu, cpumask, rcu_nocb_mask) {
+		ret = rcu_nocb_cpu_offload(cpu);
+		if (WARN_ON_ONCE(ret))
+			return;
+	}
+
+	for_each_cpu_andnot(cpu, rcu_nocb_mask, cpumask) {
+		ret = rcu_nocb_cpu_deoffload(cpu);
+		if (WARN_ON_ONCE(ret))
+			return;
+	}
+}
+
 #ifdef CONFIG_RCU_LAZY
 static unsigned long
 lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 48b155e0b290..b5635484ec69 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -181,8 +181,10 @@ int housekeeping_update(struct cpumask *isol_mask, unsigned long flags)
 	if ((housekeeping.flags & flags) != flags)
 		WRITE_ONCE(housekeeping.flags, housekeeping.flags | flags);
 
-	if (flags & HK_FLAG_KERNEL_NOISE)
+	if (flags & HK_FLAG_KERNEL_NOISE) {
 		tick_nohz_full_update_cpus(isol_mask);
+		rcu_nocb_update_cpus(isol_mask);
+	}
 
 	synchronize_rcu();
 
-- 
2.53.0



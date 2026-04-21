Return-Path: <cgroups+bounces-15385-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIYrGgDq5mlx1wEAu9opvQ
	(envelope-from <cgroups+bounces-15385-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:07:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFA2435B74
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE1CB302011C
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794CB374183;
	Tue, 21 Apr 2026 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+15v5yS"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6E365A1B
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740758; cv=none; b=llvfnHqEQsy6iBWM6VuFHSVWAFWROFKcegtK9x+2H+B4BlQbNLmEp2vRQjRKfbjmXNKLed6nLk1gIB3kTS5p31mFat+O7OSlJ+MOHzVqHKvYPLaw8W7soJmpHJLid+75aiMqM47GK3ckmYyElAhz/cmST7bsHYcBEZ2QgAzkiZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740758; c=relaxed/simple;
	bh=6dOR9VvfHXSOAa+3ONfN9QOA7EaOHN44SvLAlIcSGZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7HE/BroMbVrWfxl8En9jBY9RvUG/1YOjsoShFrpjVMPIqVfsiwNcOPRWtRRT1JzNsp3pqhX2eej+J3h62tPCxExN/1sneuZogkNP9V8AcectaOx7uls0Ad4X145oOl5i25Mv21ew4wcyhYjeNkFXJu5Z0UbkLhRMmWGh/zCAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+15v5yS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRnLiTFd5Q/8p4sCGe2o1EMdVAtDIxePLghGCtdhHc0=;
	b=X+15v5yS5NulZPzaxZg3ZfCFI2u44VWt9jd2wpos9OFKC1I4AOV1Lc511Iq2sHItnnHK9y
	tBHTc9dohJ8HDyVqfSMjR1jz2WcFbelMd1h+V9KwH1ur0WZhqyNGWPTg2Llq1IO3nw68u1
	DMPzulCFPU0TvVrJc9WhLbiRzOr5yyk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-2NDOP3YyMf-mNL6wwN032w-1; Mon,
 20 Apr 2026 23:05:51 -0400
X-MC-Unique: 2NDOP3YyMf-mNL6wwN032w-1
X-Mimecast-MFC-AGG-ID: 2NDOP3YyMf-mNL6wwN032w_1776740746
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ACED19560AD;
	Tue, 21 Apr 2026 03:05:46 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2157519560B7;
	Tue, 21 Apr 2026 03:05:39 +0000 (UTC)
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
Subject: [PATCH 07/23] watchdog: Sync up with runtime change of isolated CPUs
Date: Mon, 20 Apr 2026 23:03:35 -0400
Message-ID: <20260421030351.281436-8-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-15385-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCFA2435B74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

At bootup, watchdog will exclude nohz_full CPUs specified at boot time.
As we are now enabling runtime changes to nohz_full CPUs, the list of
CPUs with watchdog timer running should be updated to exclude the
current set of isolated CPUs.

Add a new watchdog_cpumask_update() helper to be invoked
by housekeeping_update() when the HK_TYPE_KERNEL_NOISE
(HK_TYPE_TIMER) cpumask is being updated to update watchdog_cpumask and
watchdog_allowed_mask for soft lockup detector. The cpumask updates will
be done when the affected CPUs are in the offline state. When those
CPUs are brought up later, the new cpumask will be used to determine
if any hard/soft watchdog should be enabled again.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/nmi.h      |  2 ++
 kernel/sched/isolation.c |  1 +
 kernel/watchdog.c        | 24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index bc1162895f35..5bf941d2b168 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -17,6 +17,7 @@
 void lockup_detector_init(void);
 void lockup_detector_retry_init(void);
 void lockup_detector_soft_poweroff(void);
+void watchdog_cpumask_update(struct cpumask *mask);
 
 extern int watchdog_user_enabled;
 extern int watchdog_thresh;
@@ -37,6 +38,7 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
 static inline void lockup_detector_init(void) { }
 static inline void lockup_detector_retry_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
+static inline void watchdog_cpumask_update(struct cpumask *mask) { }
 #endif /* !CONFIG_LOCKUP_DETECTOR */
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index b5635484ec69..1f3f1c83dd12 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -184,6 +184,7 @@ int housekeeping_update(struct cpumask *isol_mask, unsigned long flags)
 	if (flags & HK_FLAG_KERNEL_NOISE) {
 		tick_nohz_full_update_cpus(isol_mask);
 		rcu_nocb_update_cpus(isol_mask);
+		watchdog_cpumask_update(isol_mask);
 	}
 
 	synchronize_rcu();
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 87dd5e0f6968..498c1463b843 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -1071,6 +1071,30 @@ static inline void lockup_detector_setup(void)
 }
 #endif /* !CONFIG_SOFTLOCKUP_DETECTOR */
 
+/**
+ * watchdog_cpumask_update - update watchdog_cpumask & watchdog_allowed_mask
+ * @isol_mask: cpumask of isolated CPUs
+ *
+ * Update watchdog_cpumask and watchdog_allowed_mask to be inverse of the
+ * given isolated cpumask to disable watchdog activities on isolated CPUs.
+ * It should be called with the affected CPUs in offline state which will be
+ * brought up online later.
+ *
+ * Any changes made in watchdog_cpumask by users via the sysctl parameter will
+ * be overridden. However, proc_watchdog_update() isn't called. So change will
+ * only happens on CPUs that will brought up later on to minimize changes to
+ * the existing watchdog configuration.
+ */
+void watchdog_cpumask_update(struct cpumask *isol_mask)
+{
+	mutex_lock(&watchdog_mutex);
+	cpumask_andnot(&watchdog_cpumask, cpu_possible_mask, isol_mask);
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
+	cpumask_copy(&watchdog_allowed_mask, &watchdog_cpumask);
+#endif
+	mutex_unlock(&watchdog_mutex);
+}
+
 /**
  * lockup_detector_soft_poweroff - Interface to stop lockup detector(s)
  *
-- 
2.53.0



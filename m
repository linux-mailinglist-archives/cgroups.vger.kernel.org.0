Return-Path: <cgroups+bounces-15379-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNovKczp5mlx1wEAu9opvQ
	(envelope-from <cgroups+bounces-15379-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:06:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B427435B38
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE642302B74D
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F3D36495B;
	Tue, 21 Apr 2026 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8SgnS7x"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6D4365A19
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740712; cv=none; b=U4ghtdsM2SDRg+7+iM8hRBgy0p7SYb12YxZhEIAdvmBWw52r2C/cSCPD5ZQEIu66TsxhLTfcsxJHkImGbuhCkkkxbJmk6C58gu/BxzdIdDAbz3Yv9DALI0+jzPlPEICvQS0RnlBnpondrx+RBSih09UCQ2FbYBo/Dh9cLCD9bvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740712; c=relaxed/simple;
	bh=p9SIr6JlyYQGg3qYXe3y5yHG3ZDHW+SwoXZ/LQtgZsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtYldcJskIxEMtrFs8gJVG2ROkadzOdyabTbpk5RgYZE/V46bwkt1YGqEIeYY2vH5YTLLbhU/JwcftqcXSEgZTapkXX0M5TqZB4WHnJc/6EcJgem+sbMsXzDnauDYSxiIqf+nKaOBRX0TwkNVDEIOZfMWLLayeuJPVpM/5YdIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W8SgnS7x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+3KY5q3C4zcW8nPMRe1a9XaTfWzQ7AxIKaewiYDXwA=;
	b=W8SgnS7xnkt6n9UIYI8vb0njUGOoQTfVOUGdiRWEFpl8Dhhiw+ZPshc3tMvQ3cNjik6TbV
	Trbr1YA87frfSDRebrOAvyLcysfmHEhkkr12M8QFC0vGguP+lffjVImlE7VgNPZp8Yt7Ym
	pRDiJVj+o87LF3hdfdhE1/7GTV/VvNY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-nv81B0bGPKm_IRIqpOUuyw-1; Mon,
 20 Apr 2026 23:05:04 -0400
X-MC-Unique: nv81B0bGPKm_IRIqpOUuyw-1
X-Mimecast-MFC-AGG-ID: nv81B0bGPKm_IRIqpOUuyw_1776740700
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF1101800473;
	Tue, 21 Apr 2026 03:04:58 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67A2F19560B7;
	Tue, 21 Apr 2026 03:04:50 +0000 (UTC)
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
Subject: [PATCH 01/23] sched/isolation: Add HK_TYPE_KERNEL_NOISE_BOOT & HK_TYPE_MANAGED_IRQ_BOOT
Date: Mon, 20 Apr 2026 23:03:29 -0400
Message-ID: <20260421030351.281436-2-longman@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-15379-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 4B427435B38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit 4fca0e550d50 ("sched/isolation: Save boot defined
domain flags"), HK_TYPE_DOMAIN_BOOT was added to record the boot
time "isolcpus{=domain}" setting. As we are going to make the
HK_TYPE_MANAGED_IRQ and HK_TYPE_KERNEL_NOISE housekeeping cpumasks
runtime modifiable, we need some additional cpumasks to record the boot
time settings to make sure that those housekeeping cpumasks will always
be a subset of their boot time equivalents.

Introduce the new HK_TYPE_KERNEL_NOISE_BOOT and HK_TYPE_MANAGED_IRQ_BOOT
housekeeping types to do that.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched/isolation.h | 16 ++++++++++++++--
 kernel/sched/isolation.c        | 16 +++++++++-------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index dc3975ff1b2e..d1707f121e20 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -14,10 +14,22 @@ enum hk_type {
 	 * is always a subset of HK_TYPE_DOMAIN_BOOT.
 	 */
 	HK_TYPE_DOMAIN,
-	/* Inverse of boot-time isolcpus=managed_irq argument */
-	HK_TYPE_MANAGED_IRQ,
+
 	/* Inverse of boot-time nohz_full= or isolcpus=nohz arguments */
+	HK_TYPE_KERNEL_NOISE_BOOT,
+	/*
+	 * A subset of HK_TYPE_KERNEL_NOISE_BOOT as it may excludes some
+	 * additional isolated CPUs at run time.
+	 */
 	HK_TYPE_KERNEL_NOISE,
+
+	/* Inverse of boot-time isolcpus=managed_irq argument */
+	HK_TYPE_MANAGED_IRQ_BOOT,
+	/*
+	 * A subset of HK_TYPE_MANAGED_IRQ_BOOT as it may excludes some
+	 * additional isolated CPUs at run time.
+	 */
+	HK_TYPE_MANAGED_IRQ,
 	HK_TYPE_MAX,
 
 	/*
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index a947d75b43f1..9ec9ae510dc7 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -12,10 +12,12 @@
 #include "sched.h"
 
 enum hk_flags {
-	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
-	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
-	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
-	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
+	HK_FLAG_DOMAIN_BOOT	  = BIT(HK_TYPE_DOMAIN_BOOT),
+	HK_FLAG_DOMAIN		  = BIT(HK_TYPE_DOMAIN),
+	HK_FLAG_KERNEL_NOISE_BOOT = BIT(HK_TYPE_KERNEL_NOISE_BOOT),
+	HK_FLAG_KERNEL_NOISE	  = BIT(HK_TYPE_KERNEL_NOISE),
+	HK_FLAG_MANAGED_IRQ_BOOT  = BIT(HK_TYPE_MANAGED_IRQ_BOOT),
+	HK_FLAG_MANAGED_IRQ	  = BIT(HK_TYPE_MANAGED_IRQ),
 };
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -315,7 +317,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
 {
 	unsigned long flags;
 
-	flags = HK_FLAG_KERNEL_NOISE;
+	flags = HK_FLAG_KERNEL_NOISE | HK_FLAG_KERNEL_NOISE_BOOT;
 
 	return housekeeping_setup(str, flags);
 }
@@ -334,7 +336,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 		 */
 		if (!strncmp(str, "nohz,", 5)) {
 			str += 5;
-			flags |= HK_FLAG_KERNEL_NOISE;
+			flags |= HK_FLAG_KERNEL_NOISE | HK_FLAG_KERNEL_NOISE_BOOT;
 			continue;
 		}
 
@@ -346,7 +348,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
 
 		if (!strncmp(str, "managed_irq,", 12)) {
 			str += 12;
-			flags |= HK_FLAG_MANAGED_IRQ;
+			flags |= HK_FLAG_MANAGED_IRQ | HK_FLAG_MANAGED_IRQ_BOOT;
 			continue;
 		}
 
-- 
2.53.0



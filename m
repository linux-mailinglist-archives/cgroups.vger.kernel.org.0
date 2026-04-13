Return-Path: <cgroups+bounces-15254-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HV4LPGe3GkEUgkAu9opvQ
	(envelope-from <cgroups+bounces-15254-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:44:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 275A23E86CD
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63D183027DA5
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 07:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADD839890A;
	Mon, 13 Apr 2026 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMq/tAXi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C333988FA
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066227; cv=none; b=GBm+txz7lgISNNBrursbholq0eLFtwdwa3idNOvQ5OcFKVGjAl8i7iyZsWrCcYXfFlGRcnMhWyT1WhsYHN7b0ew1qEeey4Zh59wi04ubmkBnr9LlRaL6BhX58SO31ghMxhnke/LO6pR6gSfqI9gZOmI8/Z58oq2I+ssrl2B/tLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066227; c=relaxed/simple;
	bh=MShK07QngNcPAGv1iPWC1iUlxvhu3WgkHxBSDLvs5+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qo5Z3kjbc7UlpOs+oxPvXeFcRcqEaCDocMl/CHCIJWADBJ0o3ZS3vwFcQMomqKh3rGLJDibGbSdqCEREOONqlXggLXrYmdK2fZefzIT0DB0U+GPM/Q6CVsMalOK/EEIMSal7nJeRGCOpZgmWv+b44Yb/Uwy/9cpFQKel0esx2Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMq/tAXi; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c20010f10so10473466c88.0
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066225; x=1776671025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuagEmmraWwH0d8g+cKuhFh1+5bCP0hdNVypbGGgG6g=;
        b=aMq/tAXi0PqDKyDp4TwV7FgMTwJs1orFXxdpfpU4r0iMHCcjv9Ix+Hd6l8Ic6wUad9
         SE07Ug6ec1I2KWgnc05UL/FGA0Kb7MmbUZQfSw0ViNlBWPr23wBTmVowH9WCSrxETAa8
         0uCDHukGCwhWeWrEfH1UcRrCyUwVrrBVaRnl562Xs8sQ7LSRlbskcHmT8XHQoTnDkoIj
         6i5o5OgBXvOI9kgjH4HHA0XUJ1bvXg2pxl2+uumWDVh/ns7YbeBjSGy2Zbs04FVAyQT/
         RRrWcgcj244+eNVxo6uEriJYFOBHmfFjdzVSqsUSWQsonnVovFL2uN61/qMVo1sHxX9E
         cCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066225; x=1776671025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LuagEmmraWwH0d8g+cKuhFh1+5bCP0hdNVypbGGgG6g=;
        b=mK8HJlI8DU7VUCDqQjz58snvv8EZyqZYvdtzb6qShmzdyKkVOf3ksQQtdsyQfLb8S+
         FqvCSUR1wVbC94jpIU2dftUZ/Gr4cVft+1zOXg6dlDiMHPPHCRTuzIrpUzNgoWcnkHzz
         kE43PkAhKy6gDLjDrrpehvc2bTGUMn00yCSyRhnE+NmQvFxoRcYj08YJb8DSP0LdcRd8
         5+qoaFAKii2CoLmBHmmRKsLwUU+LiAtLm3ILlTZ4vwL8YQb4U9yEW3kvYRb9nKu6phog
         Zw6QEAE20TCbitjvYJN7IYDnFUZp64ux24VrDuRL8Gs/342EWxq2tjyzC1J7xQYdRR3P
         Fozw==
X-Forwarded-Encrypted: i=1; AFNElJ+Oz5TyAZmCdkoJUcW4d8icxhAhWQfE+SiVbaPdmc9X/throPbmcKV+Y5sIr5uEVnh4c5JQ3ppu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxna3XE38TFnNccdoKzh+6LVlegSCKfVP4sAoJ1GaL2NO07oKgo
	ENvTpnEr5aYT+iiHWTcD0RENkz1pVY2ncWToSQwK/XpVZ6UvqI2z4w4v
X-Gm-Gg: AeBDieuqf7YxoR4X24xF+u5NYREpyUOJ5gm4ZpSuqgrt/lvWKZ3j2RzVJGZAQPDkC+G
	lvnO71nToCCsKE7t2pb0uxA3dm6Y5k+PKwgAKw0R4ErVdJIQ4g4I2FR4psgZJvqtWS7eqBFj8ql
	GsKlORcRD0PHh5/nhSoNgknfMTFUXmdATZ7Te6fffqSYquGexOwAEoIOGZHu4h4JuDSOnqwNpug
	faU7nxByjiYFuLCPTMALYPWtDyQqqYO2qwcXO5H9vdEnO195v9jGEMNl56FRR8GiV6GBMWPHekh
	bQel6pXdfkjbXViP1dpLUy7Io1fl+krKG/zYMXNj3iP1yEveGutGQAf5TCHp2rAsnPl7uzXl/Iy
	mcrKNVve9nBlRNL5sOND8A8YqlxATsZTF8ZnGsbUMNkdRtFAaNxvaQEFl7QL18z4p3/6bE6Kgo2
	32jrIIR9iPUXQJOcPp
X-Received: by 2002:a05:7022:2528:b0:127:33e0:ea44 with SMTP id a92af1059eb24-12c34eec8d0mr7477882c88.29.1776066224747;
        Mon, 13 Apr 2026 00:43:44 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:43:44 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:08 +0800
Subject: [PATCH v2 02/12] sched/isolation: Introduce housekeeping notifier
 infrastructure
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-2-06df21caba5d@gmail.com>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
In-Reply-To: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15254-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 275A23E86CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Subsystems currently rely on static housekeeping masks determined at
boot. Supporting runtime reconfiguration (DHM v2) requires a mechanism
to broadcast mask changes to affected kernel components.

Implement a blocking notifier chain for housekeeping mask updates. This
infrastructure enables subsystems like genirq, workqueues, and RCU to
react dynamically to isolation changes triggered by cpusets.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 include/linux/sched/isolation.h | 21 +++++++++++++++++++++
 kernel/sched/isolation.c        | 26 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index b9a041247565c..aea1dbc4d7486 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -4,6 +4,7 @@
 #include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/tick.h>
+#include <linux/notifier.h>
 
 enum hk_type {
 	/* Inverse of boot-time isolcpus= argument */
@@ -28,6 +29,13 @@ enum hk_type {
 
 #define HK_TYPE_KERNEL_NOISE HK_TYPE_TICK
 
+struct housekeeping_update {
+	enum hk_type type;
+	const struct cpumask *new_mask;
+};
+
+#define HK_UPDATE_MASK	0x01
+
 #ifdef CONFIG_CPU_ISOLATION
 DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
 extern int housekeeping_any_cpu(enum hk_type type);
@@ -38,6 +46,9 @@ extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
 extern int housekeeping_update(struct cpumask *isol_mask);
 extern void __init housekeeping_init(void);
 
+extern int housekeeping_register_notifier(struct notifier_block *nb);
+extern int housekeeping_unregister_notifier(struct notifier_block *nb);
+
 #else
 
 static inline int housekeeping_any_cpu(enum hk_type type)
@@ -65,6 +76,16 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
 
 static inline int housekeeping_update(struct cpumask *isol_mask) { return 0; }
 static inline void housekeeping_init(void) { }
+
+static inline int housekeeping_register_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int housekeeping_unregister_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
 #endif /* CONFIG_CPU_ISOLATION */
 
 static inline bool housekeeping_cpu(int cpu, enum hk_type type)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index e05ed5118e651..0462b41807161 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -10,6 +10,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/pci.h>
 #include "sched.h"
+#include <linux/notifier.h>
 
 enum hk_flags {
 	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
@@ -26,6 +27,8 @@ enum hk_flags {
 #define HK_FLAG_KERNEL_NOISE (HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | \
 			      HK_FLAG_MISC | HK_FLAG_WQ | HK_FLAG_KTHREAD)
 
+static BLOCKING_NOTIFIER_HEAD(housekeeping_notifier_list);
+
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
 
@@ -170,6 +173,29 @@ int housekeeping_update(struct cpumask *isol_mask)
 	return 0;
 }
 
+int housekeeping_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&housekeeping_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(housekeeping_register_notifier);
+
+int housekeeping_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&housekeeping_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(housekeeping_unregister_notifier);
+
+int housekeeping_update_notify(enum hk_type type, const struct cpumask *new_mask)
+{
+	struct housekeeping_update update = {
+		.type = type,
+		.new_mask = new_mask,
+	};
+
+	return blocking_notifier_call_chain(&housekeeping_notifier_list, HK_UPDATE_MASK, &update);
+}
+EXPORT_SYMBOL_GPL(housekeeping_update_notify);
+
 void __init housekeeping_init(void)
 {
 	enum hk_type type;

-- 
2.43.0



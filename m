Return-Path: <cgroups+bounces-15260-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDmCFQqh3GkEUgkAu9opvQ
	(envelope-from <cgroups+bounces-15260-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:53:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA83C3E893A
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6CB630812B2
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C25397E9D;
	Mon, 13 Apr 2026 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgnwjA3T"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42718397685
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066288; cv=none; b=Rh8SIMV7wp0kRBLKu7rCZzhgro+vHgY/wWgWfM9TLye6xlEsxkx1JNYwgDlWQ+mX1aiL3FDc/xq3eliCSBgObGkiivs7psvfCG8v+OEt416wjn6JuwGN19Ps1gKz1LCbyYg0aiZHKTGejWpKx1CqAOYVjqd8d/k7e02mLEtOpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066288; c=relaxed/simple;
	bh=kiArkSt0flIs7bU/fXEY7xT5bOeGaqUbcFrMu1wIeUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4OOBvbrnAvkBqwD+MvwHzIgkRtvt4nn/hoLUWvZ6dP9ZGPHBxtu4tAT5rGo+nqc6ddpb1LHtD4qmE88c88gseGJL3Hr1KqfF8iThTmhBd0T+wnzRxZ42AJsez/5WTYnG5n9IUInn6HQfJbWr5UQMK3Zv3mAxLBtCi7lp8aHUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgnwjA3T; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1273349c56bso5221416c88.0
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066286; x=1776671086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyDvJikQxepnDoa9At7D55yqji9L3lHPWXvHJrxbFWg=;
        b=lgnwjA3TLeboVOt7tdBB7T2Z/AXluc+LVd2DZ6NLe5wr4foxO2TQapCKhLZt0YH0be
         T+ZYkABD3ysqa/LweE+RXd+eUEgTor2n+X+gUFM+/QYv0oTmkTyr14bD7IgSrMrrzdjW
         mpoHKgALSgQzPqfJHANCccwE7vS7+QQEeSUOgKsdEbJLbJ+OweLbJXW9Sk0kfce2E1ib
         MWWIbPqmgg5dNvtsLb2ZgdlRdxYo8I3nSRY4T3J2fc7C3VEMCfbHprhE6kTzVflo/wL9
         BbqOm+Z/pBstDD60zpS6YewnhcTDPCbPAO/Jre1woxVaEkYPy849EpuqasTS7OfaPNeM
         ejVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066286; x=1776671086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CyDvJikQxepnDoa9At7D55yqji9L3lHPWXvHJrxbFWg=;
        b=O+7FNrKpBHJY7HR0QFG3RIRxjZUvR7IB7agKtbNywWiXVxKATVaqwTeYvaynTuxgRW
         gditr4kMJrpGHcsAvKiVvaDMLhtxNxMiCOXawWW5DDsHkiTNBU+UUgoLXtcFSV7QmUpW
         YQF5Z+QAw80BnhTMOfpPG5M7FjTYHGU7CrY/34TzPNG4qkEdy6im7j/PKA8imzUkOqlH
         INvHwzXeRvothwuAzjcp/dMALQKr0JhO70keG68b4efpdcOQqNYTk5+y8WlKbSaMcnfJ
         OknzPRzIhjVULsLwOA4c8JCcna8AAyauA8Iq0/k+fZtw5Z1OR5IdPj88TexSPJLvnFny
         kXaw==
X-Forwarded-Encrypted: i=1; AFNElJ8bUVl95DtCVQl1iR9NvAzkwHTLgoH1+Y106SC9eEvZGrHwcyRx68M+k6lSgcQnLdxP7r5UfmlI@vger.kernel.org
X-Gm-Message-State: AOJu0YwZlJL+rtfuMu/tXsNBKPVtNPNUS69gH4RJWM36OaZ4PMJYDDjj
	OrHKND6XQ6eHpqRl2gga8qC1ldp5hEr4IGPnDEyh4r9LI5NggQAxWxWM
X-Gm-Gg: AeBDiesFCx0r9nTNBFD1LzNbybq8cWx2ijEaeTeVEDviTNJnXqmceQj/SKptS/mRnAq
	VY2BsMKsAzr0F6UUmV08xgS4i1Qh7Y13kppZQ6Q+jCMDPjjd4+Sw75M7tjiAE71gkQyobMpMs5Q
	QNRkm2HK+8B/J+wmWvq5RGzQ3rSovcYfLzVwF5AhZikw27CCWe2N72GMLNTk17W2K/GO3SlSpqF
	tmiWjQlV2IJ8ySBnlwOytlxrUg6dvVOvfxttBHIZHqEwZ7WNslEoXHdPIgnqnQUtn9r3KscNvwg
	0GV7vM3QYNLeGKmdHG/oXpJXyNN4Q3znphg5hvu4rfyKewV/UgpUTDrvJ4cwZ6cuLHS2ZaamwbS
	YMrcG7W+vfx7yMfxtdw1Ypt2rWrQkyDtyshs4edr8Gmw7RhK01mKaC+8PpxWLRdy3FuNVlhuJ85
	t9YpTvXnYozKyRSDq8
X-Received: by 2002:a05:7022:61a2:b0:128:d51a:5157 with SMTP id a92af1059eb24-12c34f1449emr6389794c88.33.1776066286323;
        Mon, 13 Apr 2026 00:44:46 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:44:46 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:14 +0800
Subject: [PATCH v2 08/12] workqueue, mm: Support dynamic housekeeping mask
 updates
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-8-06df21caba5d@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15260-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA83C3E893A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Unbound workqueues and kcompactd threads determine their default CPU
affinity from housekeeping masks (HK_TYPE_WQ, HK_TYPE_DOMAIN, and
HK_TYPE_KTHREAD) at boot. Currently, these boundaries are static and
are not updated if housekeeping is reconfigured at runtime.

Implement housekeeping notifiers for both workqueue and mm compaction.

This ensures that unbound workqueue tasks and background compaction
threads honor dynamic isolation boundaries configured via sysfs or
cpuset at runtime.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/workqueue.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 mm/compaction.c    | 27 +++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index eda756556341a..354e788004b48 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -8008,6 +8008,47 @@ static void __init wq_cpu_intensive_thresh_init(void)
 	wq_cpu_intensive_thresh_us = thresh;
 }
 
+static int wq_housekeeping_reconfigure(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	if (action == HK_UPDATE_MASK) {
+		struct housekeeping_update *upd = data;
+		unsigned int type = upd->type;
+
+		if (type == HK_TYPE_WQ || type == HK_TYPE_DOMAIN) {
+			cpumask_var_t cpumask;
+
+			if (!alloc_cpumask_var(&cpumask, GFP_KERNEL)) {
+				pr_warn("workqueue: failed to allocate cpumask for housekeeping update\n");
+				return NOTIFY_BAD;
+			}
+
+			cpumask_copy(cpumask, cpu_possible_mask);
+			if (!cpumask_empty(housekeeping_cpumask(HK_TYPE_WQ)))
+				cpumask_and(cpumask, cpumask, housekeeping_cpumask(HK_TYPE_WQ));
+			if (!cpumask_empty(housekeeping_cpumask(HK_TYPE_DOMAIN)))
+				cpumask_and(cpumask, cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
+
+			workqueue_set_unbound_cpumask(cpumask);
+
+			if (type == HK_TYPE_DOMAIN) {
+				apply_wqattrs_lock();
+				cpumask_andnot(wq_isolated_cpumask, cpu_possible_mask,
+						housekeeping_cpumask(HK_TYPE_DOMAIN));
+				apply_wqattrs_unlock();
+			}
+
+			free_cpumask_var(cpumask);
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block wq_housekeeping_nb = {
+	.notifier_call = wq_housekeeping_reconfigure,
+};
+
 /**
  * workqueue_init - bring workqueue subsystem fully online
  *
@@ -8068,6 +8109,7 @@ void __init workqueue_init(void)
 
 	wq_online = true;
 	wq_watchdog_init();
+	housekeeping_register_notifier(&wq_housekeeping_nb);
 }
 
 /*
diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c6..574ee3c6dc942 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -24,6 +24,7 @@
 #include <linux/page_owner.h>
 #include <linux/psi.h>
 #include <linux/cpuset.h>
+#include <linux/sched/isolation.h>
 #include "internal.h"
 
 #ifdef CONFIG_COMPACTION
@@ -3246,6 +3247,7 @@ void __meminit kcompactd_run(int nid)
 		pr_err("Failed to start kcompactd on node %d\n", nid);
 		pgdat->kcompactd = NULL;
 	} else {
+		housekeeping_affine(pgdat->kcompactd, HK_TYPE_KTHREAD);
 		wake_up_process(pgdat->kcompactd);
 	}
 }
@@ -3320,6 +3322,30 @@ static const struct ctl_table vm_compaction[] = {
 	},
 };
 
+static int kcompactd_housekeeping_reconfigure(struct notifier_block *nb,
+					      unsigned long action, void *data)
+{
+	struct housekeeping_update *upd = data;
+	unsigned int type = upd->type;
+
+	if (action == HK_UPDATE_MASK && type == HK_TYPE_KTHREAD) {
+		int nid;
+
+		for_each_node_state(nid, N_MEMORY) {
+			pg_data_t *pgdat = NODE_DATA(nid);
+
+			if (pgdat->kcompactd)
+				housekeeping_affine(pgdat->kcompactd, HK_TYPE_KTHREAD);
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block kcompactd_housekeeping_nb = {
+	.notifier_call = kcompactd_housekeeping_reconfigure,
+};
+
 static int __init kcompactd_init(void)
 {
 	int nid;
@@ -3327,6 +3353,7 @@ static int __init kcompactd_init(void)
 	for_each_node_state(nid, N_MEMORY)
 		kcompactd_run(nid);
 	register_sysctl_init("vm", vm_compaction);
+	housekeeping_register_notifier(&kcompactd_housekeeping_nb);
 	return 0;
 }
 subsys_initcall(kcompactd_init)

-- 
2.43.0



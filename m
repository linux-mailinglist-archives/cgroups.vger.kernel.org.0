Return-Path: <cgroups+bounces-15259-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLA8Awmf3Gk7UgkAu9opvQ
	(envelope-from <cgroups+bounces-15259-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:45:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F9F3E8720
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF5F73007B9F
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 07:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3AE397E88;
	Mon, 13 Apr 2026 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu5CiQUF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165DB397E81
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066278; cv=none; b=MMleIlWB8AQ1awtqaktgxP/uxJVCND83kNIVwZn/3QXMIBCF+dFILuXM37DDr2rFNfI4F9jWUICVx9irdAuIIkyYJEJL0ClBhBXDIn3IjLu7e0f/MuCQhqLhffnxsQpFpnfvgWlYq76KvwYQJaBXvv4nshm9MFQ0bbjByVv5Xzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066278; c=relaxed/simple;
	bh=fwh11Z5Rw9aSnpZTME81tDT+ucj23bt65tyOS18FZ6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=anjECvR0Q5KTP4P1YoM51hQ4KRKTM5gVc5FqBIL+e1sXNdwx2p0me7yJPneQfQGi3xHhB+3PdkAgaRdeH8sdHxHYfll62YH5DUb6wLl4SiFvl/d4caS15cKh1KiM5gYXtRWsG245s0kbCtVnb1u2Tg6AQsv/Ya8CHqVSsiLD6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu5CiQUF; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c1a170a50so3667992c88.0
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066276; x=1776671076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWLi6Bh6Nz5J4yZhvIk8yyG7xG2dO9eEtzSyvnHXfpA=;
        b=Uu5CiQUFgwT9Tvcyp1y19u4pKgl6VHALdbdGT+LYNFMG2dSQ30/UlRH2NsohD3TBVH
         t5/6gTTTUNbYW4Ysza1zsf+c+FRxo5qXfaANKR+s/HW3YmREBqfWo7Q5Yn1KlYqpWCtg
         lvuRvG6lo5hFbrJUW4bjFnWSSzwogvvIODmQHj2pA8cNO9OaNBw1lK/LzhxMojpf4m6Z
         K94b9zXWN6e84oiq0nSflOVeFcCEDXqaO7Hjo5GwzK62iBvMZ7qtYbkqKbjA3QY2v8Xc
         Kvs0r8BvzkZoLXpiNIqurD4uPxN6MvdYF9YAGYMgdXDvom5ob34Q1NuWtDsO4Gr2JxpK
         N99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066276; x=1776671076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gWLi6Bh6Nz5J4yZhvIk8yyG7xG2dO9eEtzSyvnHXfpA=;
        b=JJqFG2WXYesDMjYGg+H3ybWFE/xeqgAK2KHxzkELj3O7bnCYBv63l98cMWExPR8qpP
         RtLi8NEb98pq0gIeB2Ydeb+TZqhyr482Nm6IAH3r4UW3RPqt+qx4w11krNr12TcdYrrc
         t5D9vt4oynWLDUflvW4QTKsc/KoBsRMR1XohDSVcTEgErKaoDlWweZzJsbc+2zDU0XH+
         DKW69yqSd7zEUf2kXq5FBxB1nWmqDeer7Q7Pb47UVBHAkrW1CLCOdkRBagwZhKGuGnV7
         KWfZqa9Zit8KNfX1HO3ZB4IG9GmA1UqKGwGwV9WR1JduYnrFkEVxk0OSYtZCI2oBC9kL
         Mu5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8g1aky6B9Z+nncfnnIMtywjL7v9yncHJZppCrdlnjC4o70romNJA64c9WMTV2LBYlZ8O7e4aLc@vger.kernel.org
X-Gm-Message-State: AOJu0YyacZ4uTXRboqLeUTeVn9/OgH21z6qlzXsXUEInXh7awvK2HosX
	xK674iwJXzBvAqu53uVpulgbB0LDxzN+doXknjBqkSeLB+872PWtYxEL
X-Gm-Gg: AeBDieuAU641X7ZAtrEC3+aofcJ76YREIEnnJSoEP3R+Z5PHFC+3efM1CkMAduOrcNc
	nmS7IGQtDvOWWr0BdlN12TbGVu2MeCLL2bSeTGKCquKTToAYiJX6aR2opLSRpMs9DUFL9QvaID3
	PcmxGZ+9H7XSHHrzxsi3ecT2Ho3gItTOK93o5fuTXohBmYZH0wgchQXsBjayIhmgWqPjL53darM
	5+dbXz5VB6bBpMc03qPBRgyhLgpysudha0hHBHSvZUMbGwCnHuNyGUCizsDz2C2bK/ir31DjO58
	UNfU45kPgAr2AOwB7zBBjK6BU2pKMy8zcDqGbNJV6q9WVUn5Rj5XIxvKqtijH5ief9KPXEEdY/z
	V8fsGQEdtLTE3i3FcA9d9n7h01dwhohOMm2sQ7WEErQ/v3jsFXSCyytBOCWa/PPZH/n7EgNrqDQ
	aCIvNAG5dt2Qcb6wbO
X-Received: by 2002:a05:7022:6725:b0:128:d23d:81a7 with SMTP id a92af1059eb24-12c34e68fe3mr6219069c88.6.1776066276106;
        Mon, 13 Apr 2026 00:44:36 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:44:35 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:13 +0800
Subject: [PATCH v2 07/12] sched/core: Dynamically update scheduler domain
 housekeeping mask
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-7-06df21caba5d@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15259-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6F9F3E8720
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Scheduler domains rely on HK_TYPE_DOMAIN to identify which CPUs are
isolated from general load balancing. Currently, these boundaries are
static and determined only during boot-time domain initialization.

Trigger a scheduler domain rebuild when the HK_TYPE_DOMAIN mask changes.

This ensures that scheduler isolation boundaries can be reconfigured
at runtime via the DHEI sysfs or cpuset interface.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/sched/core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 496dff740dcaf..b71c433bbc420 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -39,6 +39,7 @@
 #include <linux/sched/nohz.h>
 #include <linux/sched/rseq_api.h>
 #include <linux/sched/rt.h>
+#include <linux/sched/topology.h>
 
 #include <linux/blkdev.h>
 #include <linux/context_tracking.h>
@@ -10959,3 +10960,25 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}
 }
+
+static int sched_housekeeping_update(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct housekeeping_update *update = data;
+
+	if (action == HK_UPDATE_MASK && update->type == HK_TYPE_DOMAIN)
+		rebuild_sched_domains();
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sched_housekeeping_nb = {
+	.notifier_call = sched_housekeeping_update,
+};
+
+static int __init sched_housekeeping_init(void)
+{
+	housekeeping_register_notifier(&sched_housekeeping_nb);
+	return 0;
+}
+late_initcall(sched_housekeeping_init);

-- 
2.43.0



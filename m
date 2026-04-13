Return-Path: <cgroups+bounces-15258-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ9SNPag3GkEUgkAu9opvQ
	(envelope-from <cgroups+bounces-15258-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:53:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6641F3E892C
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 094343079F24
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 07:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7784397E6D;
	Mon, 13 Apr 2026 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkrLNq4d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4BD3988F2
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066267; cv=none; b=cffDMVHAsKMlfwL2JpSCdC2d7J1t6MoDQkdgaHXEVPry3lTIC1QwnbnBWFevrxjuDD9rG7ELmb7ajaYPMOH1vPnNkkfsNn+/zjixJfPd9LQ6/geLjxUhmaAx9S/6+pdQhPjJPFBKK8RokxUpu/gD1EoBgFSSxQ/ofzhdTHuhTIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066267; c=relaxed/simple;
	bh=EgiM0bjXMWcDXl+eqa0GeWLZyOOpvT+Ey4r6eUdy/I4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Np94/Jckg+2fNtdPhZQla3lRWEBnDXdSpd7OCH1vfzSgA00Bu6hPRjLt+vMh1MvhX8ttXY50v+f6EdAVsL2oML61lfMXN7EJm1i02QfxDdk/G+lHLX3hqTmtsYID5BUsmvva9pNGPifQ5cptAlB8tC6kXOm2sYaKptn7bL6GYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkrLNq4d; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12713e56abdso2616186c88.1
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066266; x=1776671066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0z+BpAj/vLJ0rBDjEb9ZBDVSgQZI0DaLWhxEyOZ7nyg=;
        b=QkrLNq4doKCsleR3Ma7HxR3hzZQUFsMJdDIdPiJb27ekNexXOZlRDvoESCgNq7brQp
         Sau3+37we3Enj3+P8UQzhRxLGNEHhCsgoc0t94Wa/8tpN/O3P5puN9+YoeCXz3Dwl9US
         2Nr8XDH9/YwI+tz3PJ5HHuo4ku+OIs8uLW0y1+Ieq7z6fEtBiuho+2JJKTrGVGqvqyIB
         UlPazTO5nrytVmGkKfnPvbCZsckM8q76/gxJ1lTPdv/u8o1tiV7l2fOz4pORYvI0Nqi0
         3Tl9eTKL4xF17H6bH1TvtP9gTOu7RVxWo49NNZByF/wYDM4l8H90CZFQ6Q2g5aN6FkhD
         0g8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066266; x=1776671066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0z+BpAj/vLJ0rBDjEb9ZBDVSgQZI0DaLWhxEyOZ7nyg=;
        b=FXdQfZdwSvYFuMHD+K6fzf7CwZ3Kxc8YSp38AtjOU2CUdFSYpcIPOUvqyfIcdSzV5H
         nc1q5Q7VxehLS69Fj8UUvFt4V8iN1X8bPYc2MKIR5DBEu9N3nsUP8NyUPlocKklugPbu
         XJ0LRUFTl3PTo0s2ORM7mzuYMUu8WuGOp9xth1sdZseds0tlhNpZAR7Fz8elRce17Gy+
         paPVejoXC3uJmegXKh3JahcjAr8ApIlwaKhSR7GMWgjh66WORwTyR55ewHXX7cJjtPUC
         oq937d6IsOi0I/evxt6rsgsJglndj04YN8+XyOBOAoCd8KHqpHTCQR8qPiUnWFZX8dSE
         NoZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+RrnOIQmJyJp+ac92g10gal96cFh4jR/yziJZrQyHXcRI5VNHoqyOL2tNkH+JVxVealtL+Nber@vger.kernel.org
X-Gm-Message-State: AOJu0YyOMLOaJiKsheLF7CQSlLS9EITwkWfsZLyr0NTUNYPWDj9QZbTD
	+h7K1czDzN+TmkEns9axgZXEv8iMKlwHY7Ovrg1ZqVkG70Ssbrw0lC2m
X-Gm-Gg: AeBDieu1GWkQ8MHV5kqJcAt2BRrGL0ENEUOzWnn+XVUFdrdl9JcL9t26dRpz00EIsSi
	k5HQLlD57QpIaGd9bZhYE3KggWeqVF+pfZRPhzIotWDOz382N/7bOGllteksGMh16aq14VIn48Q
	feZp9X99aS+x2/CQVml/FJ7PirmXsNygNeoUc9OMqfLBX24Al8g7To38l8xKC5MdK6JmepoNXRf
	wGJn+C3gTncpQ53vJIrSpXpIMBScjydQGxHb337bhOou94tei/8jP9geyj/lErpq9TTXXVdR2ln
	hr1HaBpyJ27AdkBjPIYOBDQgk6j8Vp2KtUVMhFKpuy3Kp2wzRobLx8OgN00CCjYnVT10SLU4+cQ
	MHgGoRA0Vth7TKG20Pez8gBX9A8IBD01in8ybG1pEC1iSiMJAl0czk/OSAEIq3ZDWXuSgllNgu/
	fTkipBkLgsZ3Lsopmx
X-Received: by 2002:a05:7022:4a2:b0:123:3c24:b15 with SMTP id a92af1059eb24-12c28c31ef4mr6458629c88.19.1776066265460;
        Mon, 13 Apr 2026 00:44:25 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:44:25 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:12 +0800
Subject: [PATCH v2 06/12] watchdog: Allow runtime toggle of lockup detector
 affinity
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-6-06df21caba5d@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-15258-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 6641F3E892C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The hardlockup detector threads are affined to CPUs based on the
HK_TYPE_TIMER housekeeping mask at boot. If this mask is updated at
runtime, these threads remain on their original CPUs, potentially
running on isolated cores.

Synchronize watchdog thread affinity with HK_TYPE_TIMER updates.

This ensures that hardlockup detector threads correctly follow the
dynamic housekeeping boundaries for timers.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/watchdog.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7d675781bc917..bcd8373038126 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -26,6 +26,7 @@
 #include <linux/sysctl.h>
 #include <linux/tick.h>
 #include <linux/sys_info.h>
+#include <linux/sched/isolation.h>
 
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
@@ -1361,6 +1362,30 @@ static int __init lockup_detector_check(void)
 }
 late_initcall_sync(lockup_detector_check);
 
+static int watchdog_housekeeping_reconfigure(struct notifier_block *nb,
+					    unsigned long action, void *data)
+{
+	if (action == HK_UPDATE_MASK) {
+		struct housekeeping_update *upd = data;
+		unsigned int type = upd->type;
+
+		if (type == HK_TYPE_TIMER) {
+			mutex_lock(&watchdog_mutex);
+			cpumask_copy(&watchdog_cpumask,
+				     housekeeping_cpumask(HK_TYPE_TIMER));
+			cpumask_and(&watchdog_cpumask, &watchdog_cpumask, cpu_possible_mask);
+			__lockup_detector_reconfigure(false);
+			mutex_unlock(&watchdog_mutex);
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block watchdog_housekeeping_nb = {
+	.notifier_call = watchdog_housekeeping_reconfigure,
+};
+
 void __init lockup_detector_init(void)
 {
 	if (tick_nohz_full_enabled())
@@ -1375,4 +1400,5 @@ void __init lockup_detector_init(void)
 		allow_lockup_detector_init_retry = true;
 
 	lockup_detector_setup();
+	housekeeping_register_notifier(&watchdog_housekeeping_nb);
 }

-- 
2.43.0



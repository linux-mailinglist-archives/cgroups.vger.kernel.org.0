Return-Path: <cgroups+bounces-17639-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jL7TAFpnUGo8yQIAu9opvQ
	(envelope-from <cgroups+bounces-17639-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:30:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 871DB736FAB
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:30:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jfRS0gus;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17639-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17639-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9384E3031814
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 03:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF4B224F3;
	Fri, 10 Jul 2026 03:29:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E0367292
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 03:29:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654169; cv=none; b=mQq46fAJCr/DY6aMPe3n+cnQlJE3gBJFfHWZPPeCSU7Vw9I4SFwq0Ua44vrx7T3ZvcuS3uguhv81/i0ou2DhQSyQZ8cl70ppwLIDL8sU+WG7uIYIqEK9Kn6XRYVBlFSWRAta8LYjyM/ZIlXmV7oQPF3rMlaKt29MEe2LpZnweSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654169; c=relaxed/simple;
	bh=Gwt0vIVRdUfUurXNz0U9um8/c6hFVw+sQjNLaLm168U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQ7xR6ip1SJMJa0B+G1pZiEQQyENoPFv/4yws5tGyzRdmv6Pa3fqsix3gVAr3lACg3p/uL3oZI1qTEdXdLlR/n6wa0Q7OjUES5aFH7K4KtoEQvdFYtdpym2HapTEpXI6A6+tICZ218lH5RRzkgTas9OOKugBmlPbJhkHpBt2B68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfRS0gus; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2caf4496889so3432495ad.1
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 20:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654168; x=1784258968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6HyVQ93m8I4DnhXDv5rSatBwFHcjRnR8kBcgkmMTv+c=;
        b=jfRS0gusrHnEQMRd1dhgGrBgdfHybLeQ9ECOlV9GUjmEr3cT0oYfIiX3gea9Wmf2Uy
         U7pHaSzygXfxwMA6JX/+Mp2DF3Yat95RQu4rTarDlE0EK1twr6zceJfVlxYP0uTJ3BkS
         SiHdPXVaYYEiNN4bMvZVAie3epJWEdtHrUeQyOQBhS1VAn2dYrKlniXvb92s62idar3y
         NaUCEvTYX4Exl0JQ0NMe8FyrHge9eGJ97kfDoHmbQf4Vxe7wzgs0O69fEqwSVDXtzwYx
         c0/2doFPj7ukUyNyPBYqzLiamn4Qi37xwr1FRlVN+SE6QEfeei6IP2wcvIqmVYFSIti8
         hXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654168; x=1784258968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6HyVQ93m8I4DnhXDv5rSatBwFHcjRnR8kBcgkmMTv+c=;
        b=j6bO7zXm/o0RJZGG1iXU0WdsyJrHDJ/YQbq92U32qDVl27IkkKKQqbMcZwKnS0Lg0+
         GncwMyHV1iRDWm2WV30OEaxLtT+iFFhZTaOgRzhwcq1gzLKmNwTRLmFTK0KIPcTt5TVg
         aoUqI1oP2vPSCrIjBKo/BCMO8pH+n0YBR4FmLsRd4SMXVAKiW9YVe6F/a3Jhuvfk6gD6
         iWysr8wbs3xH2oOT/EunDK38xxo31QEIX9bJh508tP6ph5p+1xAinUuPyLF1NxgeMenW
         R2Q4MVZaRkdgMZZ0QMuff8fy6o63JpXAiphKuAHBKtaqGzdfyCcH6Xmlfn+9+cyCOzNV
         /+nQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro4HzdL0OtDQh8b0Gl9k/grP5uPit56AFaLJJbVyRGEYXWulFxl8RzMc7a93P7xgFF4NHCMQjdp@vger.kernel.org
X-Gm-Message-State: AOJu0YyrdBhZF0dgJ9agA+0RjBQ8uBueLCZyKCaM5ZXf+wrQ3jOWZ26K
	Eq+umo4UDjJeu7teAnsK5Iu8DkjAVX6pjG+OiwGsTIFaromMjghq26JS
X-Gm-Gg: AfdE7cnzwTXXRlHUWNkT+r2nliOdKVW1RkYFC/x8Xi9Uj8YosBsCX0VaSQ1BFMLzd2e
	wK2/vWmC/aJdMYwHcYkWqk29H3JQrLgF02ObA9pFy1kkE7R/Qjrzk0S2EF9hoFC8u/sdBRX69Ff
	BixwZaZP6fb5UZyK6F4+tK6SiWe7cpuqw7dl++d3ZViUgFavcvuzYvO7j5W+3YCmB+C3a2fDEzp
	6DeDgCAloP+X0wIp/5NEboUlcb7MTOTxKdM2QAoKq1EageVtf4bzRErZDT2SSH9RHlK5LkHXZ9B
	ksp2oJHJlEJzVQo53wF5fZE6SGmeogkodZUWN0YtJsV28MPKR4NzrXmTI7iOiOKwCooQXuSWxDJ
	EJV6Wg77SKK8enUFIxd/6nG7uK8na2b98PSK8fQmuhnbcSm2yxgYs+NebbuUrAdsXOMbfpXrZkp
	4rwg5I7qUSxwI=
X-Received: by 2002:a17:902:d98b:b0:2c6:8d95:fd7e with SMTP id d9443c01a7336-2ce8285abefmr20003265ad.6.1783654167651;
        Thu, 09 Jul 2026 20:29:27 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:29:27 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Fri, 10 Jul 2026 11:28:18 +0800
Subject: [PATCH v4 07/11] tick/nohz: add runtime tick_nohz_full_mask update
 for CPU isolation
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-wujing-dhm-v4-7-2e912e5d9645@gmail.com>
References: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
In-Reply-To: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
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
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:longman@redhat.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17639-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,chinatelecom.cn];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,chinatelecom.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 871DB736FAB

When kernel-noise isolation is requested for a CPU at runtime via a
cpuset isolated partition, tick suppression must be activated on the
affected CPU without requiring nohz_full= at boot.

tick_nohz_full_mask and tick_nohz_full_running are currently set only
during boot by tick_nohz_full_setup(). There is no runtime path to add
or remove CPUs from the full-dynticks set.

Add tick_nohz_cpu_isolate() and tick_nohz_cpu_deisolate(), both called
with the target CPU offline (between remove_cpu and add_cpu in the
hotplug cycling path):

  tick_nohz_cpu_isolate(cpu) - lazily allocates tick_nohz_full_mask
    if it was never set up at boot, sets the CPU's bit in the mask,
    sets tick_nohz_full_running, and calls ct_cpu_track_user() to
    activate per-CPU context tracking so kernel/user transitions
    suppress the scheduler tick.

  tick_nohz_cpu_deisolate(cpu) - reverses the above: deactivates
    context tracking via ct_cpu_untrack_user(), clears the CPU's bit,
    and clears tick_nohz_full_running when the mask becomes empty.

A per-function mutex guards the lazy allocation and running flag
updates against concurrent isolation requests.

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 include/linux/tick.h     |  4 ++++
 kernel/time/tick-sched.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 738007d6f577f..c4038e62533ba 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -210,6 +210,8 @@ extern void tick_nohz_dep_set_signal(struct task_struct *tsk,
 extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit);
 extern bool tick_nohz_cpu_hotpluggable(unsigned int cpu);
+extern int tick_nohz_cpu_isolate(int cpu);
+extern void tick_nohz_cpu_deisolate(int cpu);
 
 /*
  * The below are tick_nohz_[set,clear]_dep() wrappers that optimize off-cases
@@ -281,6 +283,8 @@ static inline bool tick_nohz_full_cpu(int cpu) { return false; }
 static inline void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
 static inline void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
 static inline bool tick_nohz_cpu_hotpluggable(unsigned int cpu) { return true; }
+static inline int tick_nohz_cpu_isolate(int cpu) { return -EINVAL; }
+static inline void tick_nohz_cpu_deisolate(int cpu) { }
 
 static inline void tick_dep_set(enum tick_dep_bits bit) { }
 static inline void tick_dep_clear(enum tick_dep_bits bit) { }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index ba7adc671c580..1bc01e2ab525b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -621,6 +621,51 @@ void __tick_nohz_task_switch(void)
 	}
 }
 
+static DEFINE_MUTEX(tick_nohz_cpu_isolate_mutex);
+
+/*
+ * tick_nohz_cpu_isolate - Add a CPU to the full-dynticks set at runtime.
+ * @cpu: the CPU to isolate; must be offline.
+ *
+ * Lazily allocates tick_nohz_full_mask on the first call so that no
+ * nohz_full= boot parameter is required.  Activates per-CPU context
+ * tracking so that kernel/user transitions suppress the scheduler tick.
+ */
+int tick_nohz_cpu_isolate(int cpu)
+{
+	mutex_lock(&tick_nohz_cpu_isolate_mutex);
+	if (!cpumask_available(tick_nohz_full_mask)) {
+		if (!zalloc_cpumask_var(&tick_nohz_full_mask, GFP_KERNEL)) {
+			mutex_unlock(&tick_nohz_cpu_isolate_mutex);
+			return -ENOMEM;
+		}
+	}
+	cpumask_set_cpu(cpu, tick_nohz_full_mask);
+	if (!tick_nohz_full_running)
+		tick_nohz_full_running = true;
+	mutex_unlock(&tick_nohz_cpu_isolate_mutex);
+
+	ct_cpu_track_user(cpu);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tick_nohz_cpu_isolate);
+
+/*
+ * tick_nohz_cpu_deisolate - Remove a CPU from the full-dynticks set.
+ * @cpu: the CPU to de-isolate; must be offline.
+ */
+void tick_nohz_cpu_deisolate(int cpu)
+{
+	ct_cpu_untrack_user(cpu);
+
+	mutex_lock(&tick_nohz_cpu_isolate_mutex);
+	cpumask_clear_cpu(cpu, tick_nohz_full_mask);
+	if (cpumask_empty(tick_nohz_full_mask))
+		tick_nohz_full_running = false;
+	mutex_unlock(&tick_nohz_cpu_isolate_mutex);
+}
+EXPORT_SYMBOL_GPL(tick_nohz_cpu_deisolate);
+
 /* Get the boot-time nohz CPU list from the kernel parameters. */
 void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 {

-- 
2.43.0



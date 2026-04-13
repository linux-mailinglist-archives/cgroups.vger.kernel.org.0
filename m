Return-Path: <cgroups+bounces-15261-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOLxDeCf3GkEUgkAu9opvQ
	(envelope-from <cgroups+bounces-15261-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:48:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3583E881C
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9D2E300EC6A
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 07:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F195393DDB;
	Mon, 13 Apr 2026 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aumniG8d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02091397E91
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066301; cv=none; b=LyNTV0ATNW6Sg0NOVpfEUxe0+C45VYCyutNPhLTDtuFuBHfwObTlvKrcElH08WlAmStjHCDuzT3jISxdB6SWHVu97EzLXMni5a/go1Jve88tmodE6dbqxH+RZR3LZC2covXNBYw/dcHiHWnzuzG9HrdSJgXdyBKFlLwYAcA715M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066301; c=relaxed/simple;
	bh=eaKGgV2EnLtxmq33JJLj/dYzBmiozYO1bQPRfgQi93o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bSgenZJVNWc/VXtvV4CnSlhcydruAtseeO2iqfPZDQQG63gFe2mS0UzqKIkAvpysirjzHEkIENwJZuVwzmWcomHhWVnM4Se2f1Q0J9YQb/I88MYwncRl+7j72KrwkuAIsUSut8upaksR3K8twJlzfYyYBWpzEb8e0COLxsHIi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aumniG8d; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c15414820so2798704c88.0
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066299; x=1776671099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3n2Y5xzqBT13fCT8NafM8IZJKMHdw2LLWT217qys08w=;
        b=aumniG8dlLVXg4rH0KFGoI/yqlxJ2pTZsIJyhFG/2/0ZYbHVpzdvawnZLMKqgJPS7V
         odyDq73wFRieT9I7d5MGNwUE0XMGnx5XTW5UN8kQ/px2v+CjIfKZ8SmEr7TbQrWIhdoi
         yjkEwS9UxhQxtr918L0qTINsLWtPNAY3ywmZvDTFLVwXM7iKxFZCIhbdg2zfe3T56Lvu
         //L2v93Ai5TDGIyh0Zfq5cDiUPv1UfA6fEvQ6s19w4hVRmyNWEgp0JkQqYmcRM91gXFp
         r3f+ayi7BGBrWoWZbPF8Zbc9hPj65KfLwqrBhoC1RW9Dm4oIh3Pf/y5YeJORwFyFnuLl
         PmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066299; x=1776671099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3n2Y5xzqBT13fCT8NafM8IZJKMHdw2LLWT217qys08w=;
        b=gv7HavCMg6QidCPl8cFs7ajLVBG7w0MUqkxDgynA9zZx0b2tfqbPAOX6LHVEsuKScz
         GC2cC1ZO7hkc1WJnpUGH0wMJLUTkceV49GNcnJayOqL7M70dkvISjm1bbiWZy027Nf/j
         nMmts8bMQ6Cb5v+nFyNF562gMDBdkKv9E3kElIFzjCvk5skHdAsubEkQIwicSEU7Hpd3
         X2FZR88y521rRoLZAgK6bowNUt2keYVrkDt6brcGXlx7K2Dml7BJCrJnalxJCumJZka7
         n/T0dC4WLdcIYuB681iUyMe4BLeYDWWX38C7jJoQ4XkiHz8PB62td0dp/GBEo2aKCv+s
         YEmg==
X-Forwarded-Encrypted: i=1; AFNElJ9v85z6jwskI5UM1rFMLwwrJ2NYSPuRjDG7bA8L0Coh7XKv+O5zV/hpz0+ODem6N659M8rFM9YA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzclxd9QSzSNHHxHy6Uj1VX9tb7Rw9HKZX3klMX1CJ66uabuV8o
	59yZLRL4JWbt66KPcJkKw13Th5HXMkSMkSRJ15EwFdIPFWCUaf5CHIWT
X-Gm-Gg: AeBDietaepdR4gQ6DBV+85T3//t/1s7kYUKAJWjfl9Io58XotBmnRr6hGCgf1PZgBDB
	C/E4VZYYg06CDxEkcS6XQrX7aeOAieNvYFvyo/un+ChcsuSkKyIaJP73log9YYeM2mS2ypbs3qw
	cFYVW1uHIVlSdj4kP2RCP6ViY2G6uZ1AsFYDza7kRksEWX8gtzKGeh9lrdotCJELmIkCVOBRJ1O
	Yp+6wtH334B+oKNjrBOIBNa+BvVsm1qhM/uevcuxeGY/Fqr8rySI6JQGpNtXCEfZY9wn/Ely03V
	nyOn2MCFjCnSDQ5PuqtbEG0jwW856ITk/tx+tBiB5MoRk7+bTYnE+Pumjhq5zBYPjMqIJ9wV9TJ
	Hr2Hq09uGgrJk3SG5Tm7HE8GHAAOzQ6j5zw6dMnW2y/XMuDNJuu1EUytl6LwQVsYhOzZZNIO1yD
	G51AA+ulJeYBufK+pb
X-Received: by 2002:a05:7022:e1d:b0:119:e569:f874 with SMTP id a92af1059eb24-12c35300841mr5317906c88.17.1776066298973;
        Mon, 13 Apr 2026 00:44:58 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:44:58 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:15 +0800
Subject: [PATCH v2 09/12] cgroup/cpuset: Introduce CPUSet-driven dynamic
 housekeeping (DHM)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-9-06df21caba5d@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15261-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A3583E881C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, subsystem housekeeping masks are generally static and can
only be configured via boot-time parameters (e.g., isolcpus, nohz_full).
This inflexible approach forces a system reboot whenever an orchestrator
needs to change workload isolation boundaries.

This patch introduces CPUSet-driven Dynamic Housekeeping Management (DHM)
by exposing the `cpuset.housekeeping.cpus` control file on the root cgroup.
Writing a new cpumask to this file dynamically updates the housekeeping
masks of all registered subsystems (scheduler, RCU, timers, tick, workqueues,
and managed IRQs) simultaneously, without restarting the node.

At the cpuset and isolation core level, this change implements:
1. `housekeeping_update_all_types(const struct cpumask *new_mask)` API inside
   `isolation.c` to safely allocate, update, and replace all enabled hk_type masks.
2. The `cpuset.housekeeping.cpus` attribute in `dfl_files` for the root cpuset.
3. Hooking the write operation to iterate over enabled housekeeping types
   and invoke `housekeeping_update_notify()` (the DHM notifier chain) to
   push these configuration changes live into individual kernel subsystems.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 include/linux/sched/isolation.h | 12 ++++++++++++
 kernel/cgroup/cpuset-internal.h |  1 +
 kernel/cgroup/cpuset.c          | 36 ++++++++++++++++++++++++++++++++++++
 kernel/sched/isolation.c        | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index aea1dbc4d7486..299167f627895 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -48,6 +48,8 @@ extern void __init housekeeping_init(void);
 
 extern int housekeeping_register_notifier(struct notifier_block *nb);
 extern int housekeeping_unregister_notifier(struct notifier_block *nb);
+extern int housekeeping_update_notify(enum hk_type type, const struct cpumask *new_mask);
+extern int housekeeping_update_all_types(const struct cpumask *new_mask);
 
 #else
 
@@ -86,6 +88,16 @@ static inline int housekeeping_unregister_notifier(struct notifier_block *nb)
 {
 	return 0;
 }
+
+static inline int housekeeping_update_notify(enum hk_type type, const struct cpumask *new_mask)
+{
+	return 0;
+}
+
+static inline int housekeeping_update_all_types(const struct cpumask *new_mask)
+{
+	return 0;
+}
 #endif /* CONFIG_CPU_ISOLATION */
 
 static inline bool housekeeping_cpu(int cpu, enum hk_type type)
diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index fd7d19842ded7..3ab437f54ecdf 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -60,6 +60,7 @@ typedef enum {
 	FILE_EXCLUSIVE_CPULIST,
 	FILE_EFFECTIVE_XCPULIST,
 	FILE_ISOLATED_CPULIST,
+	FILE_HOUSEKEEPING_CPULIST,
 	FILE_CPU_EXCLUSIVE,
 	FILE_MEM_EXCLUSIVE,
 	FILE_MEM_HARDWALL,
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1335e437098e8..5df19dc9bfa89 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3201,6 +3201,30 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	mutex_unlock(&cpuset_mutex);
 }
 
+/*
+ * DHM interface: root cpuset allows updating global housekeeping cpumask.
+ */
+static ssize_t cpuset_write_housekeeping_cpus(struct kernfs_open_file *of,
+					      char *buf, size_t nbytes, loff_t off)
+{
+	cpumask_var_t new_mask;
+	int retval;
+
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	buf = strstrip(buf);
+	retval = cpulist_parse(buf, new_mask);
+	if (retval)
+		goto out_free;
+
+	retval = housekeeping_update_all_types(new_mask);
+
+out_free:
+	free_cpumask_var(new_mask);
+	return retval ?: nbytes;
+}
+
 /*
  * Common handling for a write to a "cpus" or "mems" file.
  */
@@ -3290,6 +3314,9 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	case FILE_ISOLATED_CPULIST:
 		seq_printf(sf, "%*pbl\n", cpumask_pr_args(isolated_cpus));
 		break;
+	case FILE_HOUSEKEEPING_CPULIST:
+		seq_printf(sf, "%*pbl\n", cpumask_pr_args(housekeeping_cpumask(HK_TYPE_DOMAIN)));
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -3428,6 +3455,15 @@ static struct cftype dfl_files[] = {
 		.flags = CFTYPE_ONLY_ON_ROOT,
 	},
 
+	{
+		.name = "housekeeping.cpus",
+		.seq_show = cpuset_common_seq_show,
+		.write = cpuset_write_housekeeping_cpus,
+		.max_write_len = (100U + 6 * NR_CPUS),
+		.private = FILE_HOUSEKEEPING_CPULIST,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
+
 	{ }	/* terminate */
 };
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 0462b41807161..a92b0bb41de3a 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -27,6 +27,7 @@ enum hk_flags {
 #define HK_FLAG_KERNEL_NOISE (HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | \
 			      HK_FLAG_MISC | HK_FLAG_WQ | HK_FLAG_KTHREAD)
 
+static DEFINE_MUTEX(housekeeping_mutex);
 static BLOCKING_NOTIFIER_HEAD(housekeeping_notifier_list);
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -196,6 +197,43 @@ int housekeeping_update_notify(enum hk_type type, const struct cpumask *new_mask
 }
 EXPORT_SYMBOL_GPL(housekeeping_update_notify);
 
+int housekeeping_update_all_types(const struct cpumask *new_mask)
+{
+	enum hk_type type;
+	struct cpumask *old_masks[HK_TYPE_MAX] = { NULL };
+
+	if (cpumask_empty(new_mask) || !cpumask_intersects(new_mask, cpu_online_mask))
+		return -EINVAL;
+
+	if (!housekeeping.flags)
+		static_branch_enable(&housekeeping_overridden);
+
+	mutex_lock(&housekeeping_mutex);
+	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
+		struct cpumask *nmask = kmalloc(cpumask_size(), GFP_KERNEL);
+
+		if (!nmask) {
+			mutex_unlock(&housekeeping_mutex);
+			return -ENOMEM;
+		}
+
+		cpumask_copy(nmask, new_mask);
+		old_masks[type] = housekeeping_cpumask_dereference(type);
+		rcu_assign_pointer(housekeeping.cpumasks[type], nmask);
+	}
+	mutex_unlock(&housekeeping_mutex);
+
+	synchronize_rcu();
+
+	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
+		housekeeping_update_notify(type, new_mask);
+		kfree(old_masks[type]);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(housekeeping_update_all_types);
+
 void __init housekeeping_init(void)
 {
 	enum hk_type type;

-- 
2.43.0



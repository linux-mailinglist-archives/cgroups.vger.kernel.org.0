Return-Path: <cgroups+bounces-17062-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xPOdG7xiM2olAAYAu9opvQ
	(envelope-from <cgroups+bounces-17062-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:15:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFA769D468
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:15:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fHU98Jew;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17062-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17062-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24C7030A6F5C
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 03:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093B233A6E9;
	Thu, 18 Jun 2026 03:12:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53701331ED8
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 03:12:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752331; cv=none; b=MkT7Voith0aqcByDVbbM8QsZ72iOF13XNtHGpb0Egi2s9PjsF8KuRJIUiIKojei9sUOq5VP6M1eE7JM42gbw06pX4BrAeDl8dTHwyforxrWVPVIQdYvCbEUa0H7BCAA2LRS4m8FO9X7xmZQ0jpAIiZSnl0Ez4KvrxYghJjFnA8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752331; c=relaxed/simple;
	bh=B8gyjG7FPCLUh1O4Z9fKhzpiDUNCioFcs5Lz1i1uV6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRCS2CoUzeQrPBxhvdwji751CyZznOLZcuMuYl9JAiF8xWPEQ41/TC0gVMw8RbPVoQN1m3+YDv4wCCBH0LmKlUypMpsXHCg+dtNKJ/4FvVuNYN8W4DSxO422P85w+j/ErBxXzoxo4TmzO6ln3KotiwOsTs4qoTnyCB/7bl3uDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHU98Jew; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b8d414666so182609a91.3
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 20:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752330; x=1782357130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NERal9DiopbIQ+nDYvnmg4O3D7AE0rEg1povJlnV+E4=;
        b=fHU98JewrVJ1wDqYVeMzen+xCWrLzTAJhVR/pC1orc9O3m/zXfxOtH6EkGnFuOkwQo
         iSgb82m4fG+KXp6mKsiTKWzqkLP1R3IvuzFqSBno/Qk8XKFare3LXx4v2BSvttuUN57w
         gtBipLBsexh9aY1ssft/b2o+tY57rOIwnJ/SXz5HmUccJvgksYRWkXdAj6pVgZrbj+Xy
         Vb69yLyxMI7sE3Q8BfCbcUCdLktIpAWmnUYvncIaxuLPchznDQM51tcxwYasyWPzDKIo
         6y6lzofw2le8q6jp88rPez38cc2yUEKWJqLVZeqWfwEDGqH0SR9sWfNOpxx99m90ucVk
         F/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752330; x=1782357130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NERal9DiopbIQ+nDYvnmg4O3D7AE0rEg1povJlnV+E4=;
        b=qJA8KSGbMRyuMNkb+9LjqEn4lAwaJ3m6L55aaljsByuWzkc04OyYNTYBtBgN9dH8L9
         Zn7CXoV4nShtpBCOD02gW2Ki5UV9gmZkiXJTK81Eoaf5IwstOUYfuZJnjgUvinISAV7U
         Ukpt91pUvlP/892s4Ktf3KF9HQlZRNad5Xn8FZiHvsQQ43B/8ZYtqD5eB/fJffy651wP
         kMdrSlX3dIVh3umYEoSjhKbTyG0+87uV+X9BeiG+vN7ooVF1AoPTYk5CRjz+QP4CZxam
         eTYS1CI5W90L5iYrSZPVokYw4/nm5h3x0aEeraeLZT7IHCkBVT//7C3z7cBFhBpZ1oz3
         7hrw==
X-Forwarded-Encrypted: i=1; AFNElJ8kkra269c8Urd1h/UAlwRaO1nY0jxivc2ny5qw+JIoTIr7IFBOMNb0wNslZb7KZoUwce4ShEpW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgx2Cv0e8YyzqpWBFG6pva5lJQ1Ewx1B1Gj4T0R8B3ybaZJxgB
	Jo9RccV2KB+zSEIPQr83D4luzBFqd2VMFb5LxVU5qpYKZqcICJs0RfEY
X-Gm-Gg: AfdE7clf5lk1jAO0Ou/ou4ddwpdU6Zj43G2Rfkc/ipnWmt3TeJ/MH5PykdqrE2QW2AU
	i7k6IVLfgdt9C9a753yZMvIjFMyvL/O/MW7x8NOFlkz8CV8k/wf1GYD8uEyemkwM9U1OYZ9VdUj
	nSUidnt72tX9mpvNPprRUG2tbcQbLz4z43Fx/AtmAuDA2kXVFsGid8qVluOFpkXAv8qFvUzbRxy
	Iho3LkR6daCh6oFrHm82bLVDh6YuwyWsLg1Grz9LteVeW06jAGA53FCH3a6SOTOqYlxUA3uq5EJ
	hnEzJjj/Gh3BmmgZxSZv2IhIPU4pRV1r9ZJK/kgZz9aaUNW5GjqOvn8QSPM5GOBACfTEDcqeD8C
	kxYNWAWjto7hL779r0yOrQM3jNJkFUaPMFL9X8Hx5d/9rGohOZ4WUpyHRNMsImBw6cdZ5TXURdX
	siHo1CKy7lCSo=
X-Received: by 2002:a17:902:ce07:b0:2bf:211c:4980 with SMTP id d9443c01a7336-2c6f347e06fmr4597485ad.35.1781752329634;
        Wed, 17 Jun 2026 20:12:09 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:12:09 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:18 +0800
Subject: [PATCH v3 07/13] rcu/nocb: Add explicit housekeeping callback for
 runtime NOCB toggling
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wujing-dhm-v3-7-28f1a4d83b68@gmail.com>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
In-Reply-To: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
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
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17062-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,chinatelecom.cn];
	RCPT_COUNT_TWELVE(0.00)[32];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFFA769D468

Register a housekeeping callback for HK_TYPE_KERNEL_NOISE.  When the
mask changes, schedule asynchronous work to iterate all possible CPUs
and toggle NOCB mode for CPUs whose state disagrees with the new mask.
CPUs in the housekeeping set are de-offloaded; isolated CPUs are
offloaded.

Use CPU hotplug (remove_cpu() / add_cpu()) because
rcu_nocb_cpu_offload() and rcu_nocb_cpu_deoffload() require the target
CPU to be offline.  The hotplug cycle takes the CPU fully offline to
quiesce its RCU state before toggling the NOCB flag, then brings it
back.  Skip CPUs whose state already matches to avoid unnecessary
hotplug churn.  Only bring a CPU back online if it was online before
the state change (was_online guard avoids add_cpu() on a CPU that was
already offline).

This differs from Frederic Weisbecker's suggestion to "assume the CPU
is offline" within the RCU subsystem and toggle NOCB without a full
hotplug cycle.  The full hotplug approach was chosen for v3 because
rcu_nocb_cpu_offload() and rcu_nocb_cpu_deoffload() are the existing
stable interfaces and the "assume offline" path would require adding
new internal RCU APIs.  This is a known limitation that may be
addressed by RCU maintainers in follow-up work.

Snapshot the current HK_TYPE_KERNEL_NOISE cpumask inside the work
function under an RCU read lock rather than caching the pointer at
apply() time.  Caching at apply() time would create a use-after-free
hazard: a subsequent housekeeping_update_types() call frees the old
cpumask after synchronize_rcu() but before the work function runs.

Remove the cpus_read_lock() / cpus_read_unlock() pair that wrapped the
hotplug loop.  remove_cpu() and add_cpu() acquire the cpu_hotplug_lock
write side; holding the read side via cpus_read_lock() before calling
them causes a deadlock.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/rcu/tree.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55df6d37145e8..214ce940f501b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4929,3 +4929,107 @@ void __init rcu_init(void)
 #include "tree_exp.h"
 #include "tree_nocb.h"
 #include "tree_plugin.h"
+
+#ifdef CONFIG_RCU_NOCB_CPU
+/*
+ * RCU NOCB runtime toggle via housekeeping callback.
+ * Schedule the CPU-hotplug work asynchronously because
+ * remove_cpu() and add_cpu() must not be called while holding
+ * cpuset_top_mutex (the hk callback context).
+ *
+ * Snapshot the current HK_TYPE_KERNEL_NOISE cpumask inside the work
+ * function under an RCU read lock to avoid caching a pointer at
+ * apply() time that could be freed before the work runs.
+ */
+struct rcu_hk_work {
+	struct work_struct work;
+};
+
+static void rcu_hk_workfn(struct work_struct *w)
+{
+	struct rcu_hk_work *hw = container_of(w, struct rcu_hk_work, work);
+	cpumask_var_t hk_mask;
+	int cpu, ret;
+
+	if (!alloc_cpumask_var(&hk_mask, GFP_KERNEL)) {
+		kfree(hw);
+		return;
+	}
+
+	rcu_read_lock();
+	cpumask_copy(hk_mask, housekeeping_cpumask_rcu(HK_TYPE_KERNEL_NOISE));
+	rcu_read_unlock();
+
+	for_each_possible_cpu(cpu) {
+		bool should_offload = !cpumask_test_cpu(cpu, hk_mask);
+		bool is_offloaded;
+		bool was_online;
+
+		if (!cpumask_available(rcu_nocb_mask)) {
+			is_offloaded = false;
+		} else {
+			is_offloaded = cpumask_test_cpu(cpu, rcu_nocb_mask);
+		}
+
+		if (should_offload == is_offloaded)
+			continue;
+
+		was_online = cpu_online(cpu);
+		if (was_online) {
+			ret = remove_cpu(cpu);
+			if (ret)
+				continue;
+		}
+		if (should_offload)
+			rcu_nocb_cpu_offload(cpu);
+		else
+			rcu_nocb_cpu_deoffload(cpu);
+		if (was_online)
+			add_cpu(cpu);
+	}
+
+	free_cpumask_var(hk_mask);
+	kfree(hw);
+}
+
+static void rcu_hk_apply(enum hk_type type)
+{
+	struct rcu_hk_work *hw;
+
+	if (!cpumask_available(rcu_nocb_mask))
+		return;
+
+	hw = kmalloc(sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		return;
+
+	INIT_WORK(&hw->work, rcu_hk_workfn);
+	schedule_work(&hw->work);
+}
+
+static int rcu_hk_validate(enum hk_type type,
+			   const struct cpumask *cur_mask,
+			   const struct cpumask *new_mask)
+{
+	if (!IS_ENABLED(CONFIG_RCU_NOCB_CPU))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static struct housekeeping_cbs rcu_hk_cbs = {
+	.name		= "rcu/nocb",
+	.pre_validate	= rcu_hk_validate,
+	.apply		= rcu_hk_apply,
+};
+
+static int __init rcu_hk_init(void)
+{
+	int ret;
+
+	ret = housekeeping_register_cbs(HK_TYPE_KERNEL_NOISE, &rcu_hk_cbs);
+	if (ret)
+		pr_info("rcu/nocb: runtime NOCB toggle disabled (%d)\n", ret);
+	return 0;
+}
+late_initcall(rcu_hk_init);
+#endif /* CONFIG_RCU_NOCB_CPU */

-- 
2.43.0



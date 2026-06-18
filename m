Return-Path: <cgroups+bounces-17057-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IjApOv9hM2rp/wUAu9opvQ
	(envelope-from <cgroups+bounces-17057-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:11:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161969D3A8
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:11:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RNbVv9Mb;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17057-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17057-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58FA030E484C
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 03:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96B333445;
	Thu, 18 Jun 2026 03:11:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645FD331EB3
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 03:11:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752300; cv=none; b=FX/R89U8JGwdD57brume4k1iR8S7DJuZyqd6v6PJNFBZ81D9Pm6M3+A3rfO6SgCPUo9RBeRe0PtA28agdA4uNzJzXF95h6rIVk4ZuqLBYGnPWPjxSYKW5u/kcPsWUP0WH9g4ZW3Hdpa2iTmJn9hBfrAM6JJiecyJHpXIL59Yycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752300; c=relaxed/simple;
	bh=wNAVoY+2XUhNXD7ws5hDG4Y7LngUTCxkc6ilR6rWf9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQpID57HVXaZVpvdy6OnSt8n7G4qSXCV5ZV4MbOcZ2/R/sQalo7fYkEqaIZbeX5gQmo+aZlW7QvkMJ+5uMTjt7FCjKp5kgLpAUgQ5RZ/0siGm3GpArL3AncQh1v1dH4PtfRYHHq/2DF0wqBQlHetcSPoNbf7Z8qSQOdyKpMlfXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNbVv9Mb; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c3546924so4125225ad.3
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 20:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752298; x=1782357098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GH2J//DFdecoNTzDNyFAADQileJGwCOemNHhoqIoONY=;
        b=RNbVv9Mb9PpiUrdAQpE9vJagWCFUYRcE4SfoUFAoTQjFEO/62sIBh5NDM+zQtGy48C
         CLRHkE0ctwXA9zcmEbRa3fLDapHAQnWkU+TqIscCln0iqqviIt7iCg8xYMABo8onmNJG
         Rby8kq6RpslJcF/iy+8aBy4ZbncoWvcjXlWFCzJtxFIoey93oo7m6ieRNRHOo3aOTvB6
         +3caSVFAgM7vYRzjBKNU21wBmhhKRVAxhcjZ+Hwoj1uvl7vgUO7ub82M+P4Q9UC83GSE
         4oJbOS4+8sJeiG6KEX2KfTgcjx4uewd7z9n+1mqdQ9y7R/oCrdT+TgZtesptSoF1Slbt
         qAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752298; x=1782357098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GH2J//DFdecoNTzDNyFAADQileJGwCOemNHhoqIoONY=;
        b=nuOT2asjgE+dHk5lywC8KMo7QLr+q6MIpA5w/bDOOO/2RBoUyNCiLp8iH5Qy/CETWW
         b3o317orMdyyMFPC+a//zPMG50SLHA9+dmX8ifWVtn5Axmx3z06jcfoEZkLkmYoN4NkZ
         NFQZZQe8wusXsr8cZJ95HZ2bXASjFTsLdxRLpXX5/m1VzF+8Ge8lHGbZGHZtuOXS815S
         7RUwpK6jJxcql9w7rcs7NT4SZmAH5nrQiF4VVPrlJB7ZVgvcvYWTKQxXUMjVlfNZ+fPj
         aTdb460xeGHC5IoxQoSOZeHkW5vfj9dWI184N5Xyq63631FhM5U4JrsgrVaOhO3oZzb2
         MJ4w==
X-Forwarded-Encrypted: i=1; AFNElJ+2SmdAuurvnE+CGOwMdBYBne4Fgd3kP6IaWKEVMixIWgg41QVrSSwenr8ha31uenk2QpYF6LIr@vger.kernel.org
X-Gm-Message-State: AOJu0YwThpwEdR+OxqeXDXISX89o2JUe21hB049oSp1GQi4B5zU2M7LY
	/fY89XAfCDgNj+riJGS26PGiIrh7AemSB5JCOLkUjy63iYZgA9qa3pmB
X-Gm-Gg: AfdE7cmoH10YW2qvrfawCI7EbdSLMrCPd9tFx5CK/6ZIcgQAKjQQ5+aR70JVU88/XA8
	E+RHKhfos3pEv4Nt83sKL0JXdtoCYLqf9VotKHuO9IcsxHOMpQfcUiGPOerIfOMzuAaqIqc0bTe
	Y5gQ/f8AYB/LWYdIK57/KXmzX790UNIanRQzOizaa+KwpJ4+P87W2qvIEJlLF5fke/2UyMV+GXI
	OEJ6PO5xka8muGuW590oioNcb6OPLatDLO9h1m+QtVeOSGeLhu0t9azHx26JTkjpn0oI1J9gDuA
	3/A/vyJHSIyn0yH3Qg87t+XWh1WD0uO5VtGSLEy4QC7+fz3ZdzTGhb2p5GVnyjWISYzjmLIZBUE
	dbZm2XKr4PoaD7UZ+sxN6zecxtoBplSgAJZK2GzLUrfR7/EoTyCwihsoZvkpJ7f9NVGi+E4Xgcw
	X7AEebV7+42/0=
X-Received: by 2002:a17:903:3550:b0:2c0:e5ee:f56c with SMTP id d9443c01a7336-2c6e527622dmr16575975ad.20.1781752297602;
        Wed, 17 Jun 2026 20:11:37 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:11:37 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:13 +0800
Subject: [PATCH v3 02/13] sched/isolation: Add housekeeping_update_types()
 for kernel-noise masks
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wujing-dhm-v3-2-28f1a4d83b68@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17057-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6161969D3A8

Introduce housekeeping_update_types(), which updates the cpumask for
each specified housekeeping type atomically using an RCU pointer swap.

For each type in @type_mask the trial mask is computed as
(base & ~isol_mask), where the base depends on the type:

  - Most types use the current housekeeping cpumask as base.  For
    types that are only set at boot this is equivalent to the boot
    mask, so trial = (boot_mask & ~isol_mask).

  - HK_TYPE_KERNEL_NOISE always uses cpu_possible_mask as base.  Its
    semantics are "all possible CPUs minus the currently-isolated set";
    using the current HK mask instead would leave it stuck at its last
    non-trivial value after de-isolation, breaking subsequent isolation
    cycles.

HK_TYPE_KERNEL_NOISE also supports runtime first-enable: if it was not
registered at boot (no nohz_full= on the kernel command line),
housekeeping_update_types() registers it in housekeeping.flags on the
first call.  All other types must already be boot-enabled.

For each type the function validates the trial mask against
cpu_online_mask, runs registered pre_validate() callbacks (which may
reject the update), swaps all RCU cpumask pointers in a single pass,
calls synchronize_rcu(), frees the old masks, and then runs apply()
callbacks.

The existing housekeeping_update() continues to update only
HK_TYPE_DOMAIN and remains the entry point for the cpuset partition
path.  housekeeping_update_types() enables the partition path to also
drive the kernel-noise types (HK_TYPE_KERNEL_NOISE,
HK_TYPE_MANAGED_IRQ) through the explicit callback interface added in
the previous patch.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 include/linux/sched/isolation.h |   4 ++
 kernel/sched/isolation.c        | 112 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index f362876b3ebdf..eecbcbe802bd0 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -44,6 +44,8 @@ extern bool housekeeping_enabled(enum hk_type type);
 extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
 extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
 extern int housekeeping_update(struct cpumask *isol_mask);
+extern int housekeeping_update_types(unsigned long type_mask,
+				     struct cpumask *isol_mask);
 extern void __init housekeeping_init(void);
 
 /**
@@ -99,6 +101,8 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
 }
 
 static inline int housekeeping_update(struct cpumask *isol_mask) { return 0; }
+static inline int housekeeping_update_types(unsigned long type_mask,
+					    struct cpumask *isol_mask) { return 0; }
 static inline void housekeeping_init(void) { }
 static inline int housekeeping_register_cbs(enum hk_type type,
 					    struct housekeeping_cbs *cbs) { return 0; }
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index aae4dff7fbfc8..4eca18cc5e8ce 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -249,6 +249,118 @@ int housekeeping_update(struct cpumask *isol_mask)
 	return 0;
 }
 
+/**
+ * housekeeping_update_types - Update housekeeping masks for specified types
+ * @type_mask: Bitmask of housekeeping types to update
+ * @isol_mask: CPUs being added to the isolation set
+ *
+ * For each type in @type_mask that was enabled at boot, compute the
+ * trial mask as (boot mask & ~@isol_mask), validate it against
+ * @cpu_online_mask, invoke pre_validate() callbacks, swap the RCU
+ * mask pointer, and run apply() callbacks after synchronize_rcu().
+ *
+ * HK_TYPE_KERNEL_NOISE also supports runtime first-enable: when an
+ * isolated cpuset partition is created without nohz_full= at boot,
+ * cpu_possible_mask is used as the initial base and the type flag is
+ * set in housekeeping.flags on the first call.
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure, -EINVAL if
+ * a trial mask has no online CPUs.
+ */
+int housekeeping_update_types(unsigned long type_mask,
+			      struct cpumask *isol_mask)
+{
+	struct cpumask *trials[HK_TYPE_MAX] = {};
+	struct cpumask *old_masks[HK_TYPE_MAX] = {};
+	enum hk_type type;
+	int ret = 0;
+
+	for_each_set_bit(type, &type_mask, HK_TYPE_MAX) {
+		const struct cpumask *base;
+
+		if (type == HK_TYPE_DOMAIN_BOOT)
+			continue;
+		if (!housekeeping_enabled(type)) {
+			/*
+			 * HK_TYPE_KERNEL_NOISE supports runtime first-enable
+			 * for DHM isolated partitions created without nohz_full=
+			 * at boot.  All other types must be boot-enabled.
+			 */
+			if (type != HK_TYPE_KERNEL_NOISE)
+				continue;
+		}
+
+		/*
+		 * HK_TYPE_KERNEL_NOISE always uses cpu_possible_mask as its
+		 * base.  Its semantics are exactly "cpu_possible minus the
+		 * currently-isolated set", so the base never shrinks across
+		 * successive isolation/de-isolation cycles.  If we used the
+		 * current HK mask instead, de-isolating all partitions would
+		 * leave the mask at its last non-trivial value rather than
+		 * reverting to cpu_possible, breaking subsequent isolations.
+		 */
+		if (type == HK_TYPE_KERNEL_NOISE)
+			base = cpu_possible_mask;
+		else
+			base = housekeeping_cpumask(type);
+		trials[type] = kmalloc(cpumask_size(), GFP_KERNEL);
+		if (!trials[type]) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
+		cpumask_andnot(trials[type], base, isol_mask);
+		if (!cpumask_intersects(trials[type], cpu_online_mask)) {
+			ret = -EINVAL;
+			goto err_free;
+		}
+	}
+
+	if (!housekeeping.flags) {
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	for_each_set_bit(type, &type_mask, HK_TYPE_MAX) {
+		if (!trials[type])
+			continue;
+		ret = housekeeping_pre_validate_cbs(type,
+						    housekeeping_cpumask(type),
+						    trials[type]);
+		if (ret < 0)
+			goto err_free;
+	}
+
+	for_each_set_bit(type, &type_mask, HK_TYPE_MAX) {
+		if (!trials[type])
+			continue;
+		old_masks[type] = housekeeping_cpumask_dereference(type);
+		/* First-time runtime enable: register the type now. */
+		if (!housekeeping_enabled(type))
+			WRITE_ONCE(housekeeping.flags,
+				   housekeeping.flags | BIT(type));
+		rcu_assign_pointer(housekeeping.cpumasks[type], trials[type]);
+		trials[type] = NULL;
+	}
+
+	synchronize_rcu();
+
+	for_each_set_bit(type, &type_mask, HK_TYPE_MAX) {
+		if (housekeeping_cbs_table[type].nr == 0)
+			continue;
+		housekeeping_apply_cbs(type);
+	}
+
+	for_each_set_bit(type, &type_mask, HK_TYPE_MAX)
+		kfree(old_masks[type]);
+
+	return 0;
+
+err_free:
+	for_each_set_bit(type, &type_mask, HK_TYPE_MAX)
+		kfree(trials[type]);
+	return ret;
+}
+
 void __init housekeeping_init(void)
 {
 	enum hk_type type;

-- 
2.43.0



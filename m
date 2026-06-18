Return-Path: <cgroups+bounces-17063-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PAEMDSBiM2r1/wUAu9opvQ
	(envelope-from <cgroups+bounces-17063-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:12:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABC469D3C9
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:12:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="r/uq9dbg";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17063-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17063-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6029E300B463
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 03:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E4C33B6D9;
	Thu, 18 Jun 2026 03:12:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8146333A70F
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 03:12:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752340; cv=none; b=iofV1ng8tCZ2Zlm1GuzQTPH8Wmivu7QKSIaQssg1X1HFXEdb6ly582kB/dD0efS7QXyyoblU3yITAGcE8WQTrjXX1HwfG3VjLWhwKYEUdZt7PoRIC38GcGjTlReRV3YBq1mbp90MSXqBP89YBZePhoayaTQYVGuq72qNYXtilNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752340; c=relaxed/simple;
	bh=3HjydHuBQc8Yz/ieYczKmbxBkWvFg657XPocXx3aUSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U3ub4+EyPTxWubCKT8Z9M0phz9uEQXMCOv77u+bG9Ij7FO9d69Mss/4Nbk1v8Yk4KKwBsxPjQD8ErBDAdUrq4koGWAEz2WfFoYBWcJUCcVkLonYvq1HvQrtkzOFNjfyFQ3XLuFGULahGWJFX4PLhNAIXKe/JUW7Jw1dOIBmpRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/uq9dbg; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf1f074a12so4867385ad.0
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 20:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752336; x=1782357136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POSLMoWO52pf9/fOCCs2lrXk8F61Uty8Y4SKc9fV888=;
        b=r/uq9dbgmTSTgBtkQQFEDXdDvYL4SmgILgJ4iqOB5Uvjw1LpHYc2zeB1zrVw5ZvyVk
         u8SPn77jlToZzZLatU9Nbsin7wIImhw2+kThl4Louxqe6QPZaQ7EOqueg16cASSWmVjR
         HJmw2amKIE57qK3SWfLHjDWs+3iXJOVS4pGsidLOlEDb5oXUngZrdZI2KJrqYSxLCHxy
         Mihi0Plt733FUpYw6g0jRoa4L+NguZKhotv5RRP8vxak0goBovFNP+yOo5YM0tK0MruU
         BSq1qMKxYbDOtnwBDSGNxYoEBQUFPJ1C/7P7bFKnu+XNwIzBOINNVrThMACVY/1AORS2
         eWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752336; x=1782357136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=POSLMoWO52pf9/fOCCs2lrXk8F61Uty8Y4SKc9fV888=;
        b=SFONLPRd5r89mb1OyvccZNaaCHJ9cYMn/70u0lFEPLzAn8VMBq6IF58OkZuYiV2Ckx
         nxfj3hZiB/14PHriqLfXacA/i9s3UP6AQGXL7BYbZeNZE0y1YEuEBngFXWx36yNrs5i2
         lJitgKusub7TIhmgFWeoF9KGVdpya/gBDpyM6VBD5FeEREHCAQAPdal62DmtTel5E+MU
         xBLudu1lOMcXQgHaSeg5sSdvanFSlQ9X+lYlSQacq1ZBZ7jMjY5LWBauFzs5fzFnSYi+
         XI7PimO1i0sAJ9R25bma9PRnAS0F32Jfy/eR0yGm2ssDWVNhmNjTbxg323li75xcsieU
         qwLA==
X-Forwarded-Encrypted: i=1; AFNElJ+h5QQfc5qDZfqOh/fLWnHKg6/pEs2J7VbF59LUCk7iiuIbM990DvBqbExh8asxzwOyTi+F3TMz@vger.kernel.org
X-Gm-Message-State: AOJu0YzzDNIOQUC67VjXJiomoC67q7xM7QAZQ1gZOiu1YmDgMuLdldj3
	kOvXl70N9UCrnVw/FWAp61PivXvfeZAS9KMeGHRLNB4gP0/BApjEJfBU
X-Gm-Gg: AfdE7cmmE/66KiiCVdApTj7cbW3mbvoSXCkwW/j5J8EeJpe45bs/bKA618/faWUhLV/
	ljTlCPiMRr62SbagNRh18sVnB7hwh+g/59Bxt4mohb0hQhYZjmgzw3Jpsi5mgQBXDZphY/e3isn
	dmKQcJ1vH7uTvFDB9u+qj7V+qPn+gFYwFvrwOkBacnBDcCZDaA2ERuDnuNjVmrxjAFxUeh5h81M
	wd1yRakNzqH1ia4vD4z7w2VkFZeosYWJ0ai7xfOKxNjB6tdXg8ACjG8gfWLnXmBZp4G5XBNNc0a
	Rb0doyh8J95FMdmYL/ZJjGzLG1l1EGgWv+orc+fHatO5Xv5rVgnVvk1RjxCutIHjvZj1H2KJ4S9
	bxeDTr+VsksKVmqFNwFdidcZqwtj2ayRZZYre+8/k3V6Kbz2z/2WouV1r+BDHQM9UeRmz502cLw
	Mv5C1KjatIDGo=
X-Received: by 2002:a17:903:b85:b0:2c6:cf7b:d34d with SMTP id d9443c01a7336-2c6cf7bd4fdmr41476075ad.13.1781752335960;
        Wed, 17 Jun 2026 20:12:15 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:12:15 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:19 +0800
Subject: [PATCH v3 08/13] genirq: Add explicit housekeeping callback for
 managed IRQ migration
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wujing-dhm-v3-8-28f1a4d83b68@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17063-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0ABC469D3C9

Register a housekeeping callback for HK_TYPE_MANAGED_IRQ.  When the
mask changes, iterate all active managed interrupts, intersect their
current affinity mask with the new housekeeping mask, and re-apply
with irq_do_set_affinity().  Managed interrupts on CPUs removed from
the housekeeping set are migrated to remaining housekeeping CPUs.

Only managed interrupts (IRQF_AFFINITY_MANAGED) are selected because
the kernel owns their affinity; user-controlled IRQ affinities must
not be overridden by the housekeeping layer.

The new HK_TYPE_MANAGED_IRQ cpumask is snapshotted once under an RCU
read lock before the IRQ loop, satisfying the lockdep annotation in
housekeeping_cpumask() for runtime-mutable types.

When the intersection of the IRQ's current affinity and the new
housekeeping mask is non-empty, irq_do_set_affinity() moves the IRQ
to the restricted set.  If the intersection is empty (all CPUs that
were serving this IRQ are now isolated), the affinity update is skipped
and the IRQ continues to run on the isolated CPU temporarily.  Full
support for the IRQ shutdown / re-startup path (when all serving CPUs
become isolated) is left for follow-up work.

Guarded by irq_lock_sparse() and per-descriptor raw_spin_lock to
prevent races with concurrent affinity changes.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/irq/manage.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2e80724378267..ea97f455eab2a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2801,3 +2801,89 @@ bool irq_check_status_bit(unsigned int irq, unsigned int bitmask)
 	return res;
 }
 EXPORT_SYMBOL_GPL(irq_check_status_bit);
+
+/*
+ * Managed IRQ housekeeping callback: iterate all managed IRQs and ask
+ * the chip to move them off CPUs newly removed from HK_TYPE_MANAGED_IRQ.
+ */
+static void irq_hk_apply(enum hk_type type)
+{
+	cpumask_var_t hk_mask;
+	struct irq_desc *desc;
+	unsigned int irq;
+
+	if (!alloc_cpumask_var(&hk_mask, GFP_KERNEL))
+		return;
+
+	/*
+	 * Snapshot the new HK_TYPE_MANAGED_IRQ mask under an RCU read lock
+	 * before iterating IRQ descriptors.  The lockdep annotation in
+	 * housekeeping_cpumask() requires an RCU read-side critical section
+	 * for runtime-mutable types.
+	 */
+	rcu_read_lock();
+	cpumask_copy(hk_mask, housekeeping_cpumask_rcu(HK_TYPE_MANAGED_IRQ));
+	rcu_read_unlock();
+
+	irq_lock_sparse();
+
+	for_each_active_irq(irq) {
+		desc = irq_to_desc(irq);
+		if (!desc || !desc->action)
+			continue;
+
+		/*
+		 * Only managed interrupts are selected: they have
+		 * IRQF_AFFINITY_MANAGED set, meaning the kernel owns their
+		 * affinity.  User-controlled IRQs are intentionally skipped.
+		 *
+		 * When the intersection of the current affinity mask and the
+		 * new housekeeping mask is non-empty, re-apply the restricted
+		 * affinity to migrate the IRQ away from newly isolated CPUs.
+		 * If the intersection is empty (all serving CPUs are now
+		 * isolated), the IRQ is left on its current CPU temporarily;
+		 * handling that case (IRQ shutdown / re-startup) is left for
+		 * a follow-up.
+		 */
+		if (irqd_affinity_is_managed(&desc->irq_data)) {
+			const struct cpumask *mask;
+			struct cpumask *tmp = this_cpu_ptr(&__tmp_mask);
+
+			raw_spin_lock_irq(&desc->lock);
+			mask = irq_data_get_affinity_mask(&desc->irq_data);
+			cpumask_and(tmp, mask, hk_mask);
+			if (cpumask_intersects(tmp, cpu_online_mask))
+				irq_do_set_affinity(&desc->irq_data, tmp, false);
+			raw_spin_unlock_irq(&desc->lock);
+		}
+	}
+
+	irq_unlock_sparse();
+	free_cpumask_var(hk_mask);
+}
+
+static int irq_hk_validate(enum hk_type type,
+			   const struct cpumask *cur_mask,
+			   const struct cpumask *new_mask)
+{
+	if (!IS_ENABLED(CONFIG_SMP))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static struct housekeeping_cbs irq_hk_cbs = {
+	.name		= "genirq/managed",
+	.pre_validate	= irq_hk_validate,
+	.apply		= irq_hk_apply,
+};
+
+static int __init irq_hk_init(void)
+{
+	int ret;
+
+	ret = housekeeping_register_cbs(HK_TYPE_MANAGED_IRQ, &irq_hk_cbs);
+	if (ret)
+		pr_info("genirq: managed IRQ runtime migration disabled (%d)\n", ret);
+	return 0;
+}
+late_initcall(irq_hk_init);

-- 
2.43.0



Return-Path: <cgroups+bounces-12158-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A6EC7A42C
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 15:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1EC834AA3B
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32643355035;
	Fri, 21 Nov 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRP7m9Oh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0262355023;
	Fri, 21 Nov 2025 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735715; cv=none; b=OIMMTAAKVqkpx5jLFGAUctthb/NQEjMFr6qlE9sAZegufnJALUaScLbsO5C9kUqCPJl8nfV9UsqRIfMVlLQ2Z4MfQY4G6LLg68Ak8YE2rYnQB+P6BoB3AYup9t2l/wP+ad0TpQ7zyVgVxKN4hpnxerUmBurTjaPHWk6NlxZDPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735715; c=relaxed/simple;
	bh=dyCoJDoYsCRUuAKuca0A0XMg7WKKlrbhXatmoKQwgYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IV8pGE41JFMoIBI+hBY5LOA8NVwRDZAGNnDrZKZ1rBG7raWtancRWlZHIl876b1AjPTVg6nNhpf89p04fCa5e8xjcqRl9F5LMp+VurjQwZZscmRRDAByVgN3pPwL6O0T+BDg0c7YZyQhhXoAM2zTzMeLDZWm7h1usKpmhaKMJ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRP7m9Oh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2441C4CEFB;
	Fri, 21 Nov 2025 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763735714;
	bh=dyCoJDoYsCRUuAKuca0A0XMg7WKKlrbhXatmoKQwgYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRP7m9Oh0rNwQXpX5crjM1vHDP9fgxeb++rRrqT3+fzZfAau900UPx3GN2F2uawe2
	 Tul2NGCqfjnL66iuFegRqEbsLfSWYAEdgosbTSjWfyCe1RReLd0lVCYrDEh8WOj5NU
	 PPQK1NewxL5t8lnr20WNFzJlJo125CFU7u6vS0dwq9r6Nwa2SMoO7zn2gsFyNs/FX8
	 5fgRci3r2a1q+7Xyub7BVKYt6KYaODhFwkCFzPI5d5Mkz8l4ztza0Kfmr+Hlj77Z9i
	 kinuAG+zHMUOixIJh9ID256By3XCISvlJiUFKvhiPo97HBj5iHfC1jkXFUgMKwX9Np
	 dyrSaKJFWsrIA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Waiman Long <llong@redhat.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 3/3 v3] genirq: Remove cpumask availability check on kthread affinity setting
Date: Fri, 21 Nov 2025 15:35:00 +0100
Message-ID: <20251121143500.42111-4-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251121143500.42111-1-frederic@kernel.org>
References: <20251121143500.42111-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Failing to allocate the affinity mask of an interrupt descriptor fails the
whole descriptor initialization. It is then guaranteed that the cpumask is
always available whenever the related interrupt objects are alive, such as
the kthread handler.

Therefore remove the superfluous check since it is merely just a historical
leftover. Get rid also of the comments above it that are either obsolete or
useless.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251118143052.68778-3-frederic@kernel.org
---
 kernel/irq/manage.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 98b9b8b4de27..76c7b58f54c8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1001,7 +1001,6 @@ static irqreturn_t irq_forced_secondary_handler(int irq, void *dev_id)
 static void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action)
 {
 	cpumask_var_t mask;
-	bool valid = false;
 
 	if (!test_and_clear_bit(IRQTF_AFFINITY, &action->thread_flags))
 		return;
@@ -1018,21 +1017,13 @@ static void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *a
 	}
 
 	scoped_guard(raw_spinlock_irq, &desc->lock) {
-		/*
-		 * This code is triggered unconditionally. Check the affinity
-		 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
-		 */
-		if (cpumask_available(desc->irq_common_data.affinity)) {
-			const struct cpumask *m;
+		const struct cpumask *m;
 
-			m = irq_data_get_effective_affinity_mask(&desc->irq_data);
-			cpumask_copy(mask, m);
-			valid = true;
-		}
+		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
+		cpumask_copy(mask, m);
 	}
 
-	if (valid)
-		set_cpus_allowed_ptr(current, mask);
+	set_cpus_allowed_ptr(current, mask);
 	free_cpumask_var(mask);
 }
 #else
-- 
2.51.1



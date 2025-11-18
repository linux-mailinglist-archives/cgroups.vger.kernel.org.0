Return-Path: <cgroups+bounces-12063-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F24BC69FEE
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 15:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 696EE2C245
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA778361DDF;
	Tue, 18 Nov 2025 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSj3WriX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9808E361DB3;
	Tue, 18 Nov 2025 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476264; cv=none; b=gbowpxgqmrxs8Jp6jDy18oMME5nqKHKtbO53HbUTXEpX+ZvOFls33pJBDXFwHH/9eg0BQpFko8eqv2opHZZkOTTF73pjwAudjkNUSD7y02XmBM/Dlwmqt/yKdrftNidL+ufR5G3bh4Hsb6GAGITO2DdMFIeRpH5rXAfwkwNxl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476264; c=relaxed/simple;
	bh=yRIPKAk49U6SxsBTjD/cRK3gPHkkbPpDSuC72X3MQcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyXAB1PDw6YxDGzVS5K51G2W+6xnQbXL0ttw0LWR/d7/T7mBnFJS9ya0vlyPU6u790c2/H9qFxv1Dp1eju/CBJNO6vgiFz5XFLrgt/l+qiH+C3nCPhurHhXgAsqjYdlfiK9S9UC9dYskXfbzZU8H3dMpXJcVxvyI53FGQn5Vwb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSj3WriX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876B5C116B1;
	Tue, 18 Nov 2025 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763476264;
	bh=yRIPKAk49U6SxsBTjD/cRK3gPHkkbPpDSuC72X3MQcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSj3WriXS/DuardfyxVIRzqEqQY/ufJ2oQbvc+U01Qu91YAaGTnFfKSvxTWWBm2sh
	 IESV2O1XeStWP8ks9oVDy1P9eK0iC2k1SonGALiYUI2EfANkrHH9+95jgKqC2Ak+JB
	 yv4zWXUWCuriIzRpKhIvojuVhIYy8Bw3b4/0bDQZLLZ+pChrLOsi0DOFZa9fq3a+Fe
	 x2KAqFaFJwZIxY1qBTr4WBVGw2LlCnwK0BgbOyAhFIlLbUN5VtRv88VJtu2Q8HRPT8
	 nVw5V4xeFG2T32qFzD0al9IsbtoIJeLMm2fHPbShKj3Rq4v8MNWJduOgKf94jtoBwq
	 Ofae0LM5K6LFA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Waiman Long <llong@redhat.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 2/2] genirq: Remove cpumask availability check on kthread affinity setting
Date: Tue, 18 Nov 2025 15:30:52 +0100
Message-ID: <20251118143052.68778-3-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118143052.68778-1-frederic@kernel.org>
References: <20251118143052.68778-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Failing to allocate the affinity mask of an irqdesc eventually fails
the whole irqdesc initialization. It is then guaranteed that the cpumask
is always available whenever the related IRQ objects are alive, such as
the kthread handler.

Therefore remove the superfluous check since it is merely just a
historical leftover. Get rid also of the comments above it that are
either obsolete or useless.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/irq/manage.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 76e2cbe21d1f..e9316cba311c 100644
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
 
-- 
2.51.0



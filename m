Return-Path: <cgroups+bounces-12157-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB56C7A369
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 15:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A21142A3AA
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1541A354AE3;
	Fri, 21 Nov 2025 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsR3Tch/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2287354709;
	Fri, 21 Nov 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735712; cv=none; b=HHZwc+23/J1vAZeTMHoUlT53ds23EJY2wELQw1UDAfvzoHXyr8SejFJKjif5jt04NAunCBeAcLQwwIejgJ6rLwZBxwuVZ9/nGTJ7dZjUlyFe6c03FrLuF+72TkAcsD+4B56CJwmMUVjE1jmSMuuwppvGVHM/eZRKfJOoUvSmeCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735712; c=relaxed/simple;
	bh=mK23Wrz2tyOLkmHq33uZwRXwCptc6LPDcU+pTlSPJug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbFJpgUxllyGDLse/oOvKkY+auk9qkCQJa9yV1YBjtd8GPwvAJBXDBZS07e/FMhvu8waFPYxM04Bg+ILN1ogK5esz+dIdvjAqHYnBWMKcQ+ifN106vtQ9KBia6cPckUpFI1VhIa8qh6UuZc55CXSP2xBM7JRYlyHRhdUTuRu2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsR3Tch/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E28AC4CEF1;
	Fri, 21 Nov 2025 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763735712;
	bh=mK23Wrz2tyOLkmHq33uZwRXwCptc6LPDcU+pTlSPJug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LsR3Tch/2/JZf/BYN/Xm+b+8pCtjNdMOq0RzrPFVbao7sysVPij2LoRQ153MsPRfU
	 zfRkeCqYF1ytmJ6bhR2mEynJcYD5mIpvzcAMlAVqkWPAZvVps4e2w7xO7uTFelrlig
	 8MwBPGa2IqeCXChS2lfQC4wNUXnwazCgbU4D5mZzfI+ZVnTatiYW0g9bLY93TT3T21
	 T+eRCxUDJKYrvtPEAj7k7SrzHLoBcviAniH85PLL2PZxHFjMGQ8WUg1JGSA6s/irvp
	 wscchFNmh9JCaQgaBQY9D/7x6rphHvFZR2RrXFmcO6gIQKakFexhKIsDjkaFelOUum
	 3SKahIdN8PV7A==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Waiman Long <llong@redhat.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 2/3 v3] genirq: Fix interrupt threads affinity vs. cpuset isolated partitions
Date: Fri, 21 Nov 2025 15:34:59 +0100
Message-ID: <20251121143500.42111-3-frederic@kernel.org>
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

When a cpuset isolated partition is created / updated or destroyed, the
interrupt threads are affine blindly to all the non-isolated CPUs. And this
happens without taking into account the interrupt threads initial affinity
that becomes ignored.

For example in a system with 8 CPUs, if an interrupt and its kthread are
initially affine to CPU 5, creating an isolated partition with only CPU 2
inside will eventually end up affining the interrupt kthread to all CPUs
but CPU 2 (that is CPUs 0,1,3-7), losing the kthread preference for CPU 5.

Besides the blind re-affinity, this doesn't take care of the actual low
level interrupt which isn't migrated. As of today the only way to isolate
non managed interrupts, along with their kthreads, is to overwrite their
affinity separately, for example through /proc/irq/

To avoid doing that manually, future development should focus on updating
the interrupt's affinity whenever cpuset isolated partitions are updated.

In the meantime, cpuset shouldn't fiddle with interrupt threads directly.
To prevent from that, set the PF_NO_SETAFFINITY flag to them.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251118143052.68778-2-frederic@kernel.org
---
 kernel/irq/manage.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c1ce30c9c3ab..98b9b8b4de27 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1408,16 +1408,23 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 	 * references an already freed task_struct.
 	 */
 	new->thread = get_task_struct(t);
+
 	/*
-	 * Tell the thread to set its affinity. This is
-	 * important for shared interrupt handlers as we do
-	 * not invoke setup_affinity() for the secondary
-	 * handlers as everything is already set up. Even for
-	 * interrupts marked with IRQF_NO_BALANCE this is
-	 * correct as we want the thread to move to the cpu(s)
-	 * on which the requesting code placed the interrupt.
+	 * The affinity may not yet be available, but it will be once
+	 * the IRQ will be enabled. Delay and defer the actual setting
+	 * to the thread itself once it is ready to run. In the meantime,
+	 * prevent it from ever being reaffined directly by cpuset or
+	 * housekeeping. The proper way to do it is to reaffine the whole
+	 * vector.
 	 */
-	set_bit(IRQTF_AFFINITY, &new->thread_flags);
+	kthread_bind_mask(t, cpu_possible_mask);
+
+	/*
+	 * Ensure the thread adjusts the affinity once it reaches the
+	 * thread function.
+	 */
+	new->thread_flags = BIT(IRQTF_AFFINITY);
+
 	return 0;
 }
 
-- 
2.51.1



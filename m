Return-Path: <cgroups+bounces-12156-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B58C7A4E2
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 15:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F24114EB7D9
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65DD354703;
	Fri, 21 Nov 2025 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSNMVtOX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1E3546F2;
	Fri, 21 Nov 2025 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735710; cv=none; b=BexC7kOOyJ+IlLtHC4nrXg6U710fj6UjyevgD0Jsl1xShsKkfctqJbUSR1pWmezKkTzbLd3925HMBil5VkI4exT6ks9yP2+41y+ZTBuzI2AIaJ6pxV8Lp+ehJ/a99zCgKBZf+CWTIXMLVXdnl/lRq57WQPa4s5kRe7qFeWtpPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735710; c=relaxed/simple;
	bh=Bl7vO2+kYXaMHB3qf2doPbfGNWec/DE/aLmf8ZT5pa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aK1Yt46ZElnFdQWtWQ5LTzawGyjZZnpbd9dzLElxfs3b0jD0ycUIFhVEe/bITQzJit9yVJrwC4Ir6+nfCsrHhIpnzyAL/MimbRnD/AToCCHWqhw9nFjOgxdcieh9+EZ/1f9ScVHF25SJtawFKkKnOD7q9VXtWsHMJXKlC1/NRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSNMVtOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3E9C116C6;
	Fri, 21 Nov 2025 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763735710;
	bh=Bl7vO2+kYXaMHB3qf2doPbfGNWec/DE/aLmf8ZT5pa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSNMVtOXIdjaF3LxB+tc3X7pt103E1XAlf7fRzYegFVnv/Tcs7TfjUNUbPLSR10iA
	 lIFputcFRdnSg7WpjHQyYGAmf0Bf0pldhZ8KTS7XhI6KgwHTRhCin6eEv77ziBzbUP
	 mTgXn0vqg9Z/gXmWjne30vjloKXsMKpCjoaqAQTP4JrQE0aZeZUhDA7RSs6zoc1rQs
	 m+IfDoMOr+cNMz+lX2Li4kgxRfwSc4oW+ipuLxmTxuVkH2jcr+AKOSndSps75IWhAX
	 syl7Isy1fSJJMopBtLeDKptK69SdVhrb1mvVG1qg8kEE4e8EKvhvYRy9GoiqkwAEWt
	 0IPnYbw6NhFqg==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Waiman Long <llong@redhat.com>,
	cgroups@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/3 v3] genirq: Prevent from early irq thread spurious wake-ups
Date: Fri, 21 Nov 2025 15:34:58 +0100
Message-ID: <20251121143500.42111-2-frederic@kernel.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

During initialization, the IRQ thread is created before the IRQ get a
chance to be enabled. But the IRQ enablement may happen before the first
official kthread wake up point. As a result, the firing IRQ can perform
an early wake-up of the IRQ thread before the first official kthread
wake up point.

Although this has happened to be harmless so far, this uncontrolled
behaviour is a bug waiting to happen at some point in the future with
the threaded handler accessing halfway initialized states.

Prevent from such surprise with performing a wake-up only if the target
is in TASK_INTERRUPTIBLE state. Since the IRQ thread waits in this state
for interrupts to handle only after proper initialization, it is then
guaranteed not to be spuriously woken up while waiting in
TASK_UNINTERRUPTIBLE, right after creation in the kthread code, before
the official first wake up point to be reached.

Not-yet-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/irq/handle.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index e103451243a0..786f5570a640 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -133,7 +133,15 @@ void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
 	 */
 	atomic_inc(&desc->threads_active);
 
-	wake_up_process(action->thread);
+	/*
+	 * This might be a premature wakeup before the thread reached the
+	 * thread function and set the IRQTF_READY bit. It's waiting in
+	 * kthread code with state UNINTERRUPTIBLE. Once it reaches the
+	 * thread function it waits with INTERRUPTIBLE. The wakeup is not
+	 * lost in that case because the thread is guaranteed to observe
+	 * the RUN flag before it goes to sleep in wait_for_interrupt().
+	 */
+	wake_up_state(action->thread, TASK_INTERRUPTIBLE);
 }
 
 static DEFINE_STATIC_KEY_FALSE(irqhandler_duration_check_enabled);
-- 
2.51.1



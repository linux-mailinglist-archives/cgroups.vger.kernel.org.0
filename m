Return-Path: <cgroups+bounces-11591-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7586EC35CC7
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 14:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98E3460D75
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 13:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE532D73A7;
	Wed,  5 Nov 2025 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpqAVXTi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7698730C61E;
	Wed,  5 Nov 2025 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348653; cv=none; b=LW/NhdxU2ZMoYBKGFfq/AZvIGfzNvrlzIYcX7w6NX9wMNewTyFQXaGtTVlTmciAtehwlNyRQqVhpUZG4OARNUqV5q0Xif+YYZQ/hu5vFPlRaJb2YZm/OXR67fNP9Uy91b4W9BswpYU1S8E6z6YUdnRe7XhrhULJRWP5C14gAkr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348653; c=relaxed/simple;
	bh=xug3FxWs/d/eOrBPa1Z165fcOCw7ZLCHRBYee2J7rJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DoEj6s8zElGsKlos5sIeJrXo+kIhMfEHw3UbEFWIT4r5LOgx7YieGrFLqnzb/0hsEidi5l3CuCCgzf+ROdEn+oDod/UzU85MlCSOeGXbGX+9Ek2ZowUgnJtXCq5g2OlkuMv1pSiOEmYz39sl6iJ03C5LtvY5xDSfljyksR5sYqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpqAVXTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8310C4CEF8;
	Wed,  5 Nov 2025 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762348653;
	bh=xug3FxWs/d/eOrBPa1Z165fcOCw7ZLCHRBYee2J7rJY=;
	h=From:To:Cc:Subject:Date:From;
	b=rpqAVXTiHk7l4qK1MoF6D2zSvXCnSn88TIQnzinbIfaYm5Nvoz6eBDsjGVq1STANS
	 xQKHPNLyjpGcbXd4Hu3cDTK8NKedfAZhaHtAuBWXaxEiCe7RXFZZO5ZGP0mK+EFtFZ
	 rViV+YJUbsopJLoFmaD/Ny7wqv2z4sMRjByhU/vMU7wgyMYdwjU4g2qCEWjxxr5HiN
	 /KBzy14eZ/0krF4Mk7P29WhYIr7R/ooyd63JokXklH0sRJHsUGA9PQeuLe6OEUBl/d
	 XzMFjsGqaYskj5SuksaTfvEbBuQrbMb4jiDBSNO0uU3LZeHSqmVVh1R+ldFUgSM+y0
	 FUcW/F5SGMxOw==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	cgroups@vger.kernel.org
Subject: [PATCH] genirq: Fix IRQ threads affinity VS cpuset isolated partitions
Date: Wed,  5 Nov 2025 14:17:26 +0100
Message-ID: <20251105131726.46364-1-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a cpuset isolated partition is created / updated or destroyed,
the IRQ threads are affine blindly to all the non-isolated CPUs. And
this happens without taking into account the IRQ thread initial
affinity that becomes ignored.

For example in a system with 8 CPUs, if an IRQ and its kthread are
initially affine to CPU 5, creating an isolated partition with only
CPU 2 inside will eventually end up affining the IRQ kthread to all
CPUs but CPU 2 (that is CPUs 0,1,3-7), losing the kthread preference for
CPU 5.

Besides the blind re-affinity, this doesn't take care of the actual
low level interrupt which isn't migrated. As of today the only way to
isolate non managed interrupts, along with their kthreads, is to
overwrite their affinity separately, for example through /proc/irq/

To avoid doing that manually, future development should focus on
updating the IRQs affinity whenever cpuset isolated partitions are
updated.

In the meantime, cpuset shouldn't fiddle with IRQ threads directly.
To prevent from that, set the PF_NO_SETAFFINITY flag to them.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/irq/manage.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 400856abf672..5ca000c9f4a7 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -176,7 +176,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
 }
 
 /**
- * irq_set_thread_affinity - Notify irq threads to adjust affinity
+ * irq_thread_update_affinity - Notify irq threads to adjust affinity
  * @desc:	irq descriptor which has affinity changed
  *
  * Just set IRQTF_AFFINITY and delegate the affinity setting to the
@@ -184,7 +184,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
  * we hold desc->lock and this code can be called from hard interrupt
  * context.
  */
-static void irq_set_thread_affinity(struct irq_desc *desc)
+static void irq_thread_update_affinity(struct irq_desc *desc)
 {
 	struct irqaction *action;
 
@@ -283,7 +283,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 		fallthrough;
 	case IRQ_SET_MASK_OK_NOCOPY:
 		irq_validate_effective_affinity(data);
-		irq_set_thread_affinity(desc);
+		irq_thread_update_affinity(desc);
 		ret = 0;
 	}
 
@@ -1035,8 +1035,23 @@ static void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *a
 		set_cpus_allowed_ptr(current, mask);
 	free_cpumask_var(mask);
 }
+
+static inline void irq_thread_set_affinity(struct task_struct *t,
+					   struct irq_desc *desc)
+{
+	const struct cpumask *mask;
+
+	if (cpumask_available(desc->irq_common_data.affinity))
+		mask = irq_data_get_effective_affinity_mask(&desc->irq_data);
+	else
+		mask = cpu_possible_mask;
+
+	kthread_bind_mask(t, mask);
+}
 #else
 static inline void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
+static inline void irq_thread_set_affinity(struct task_struct *t,
+					   struct irq_desc *desc) { }
 #endif
 
 static int irq_wait_for_interrupt(struct irq_desc *desc,
@@ -1221,6 +1236,7 @@ static void wake_up_and_wait_for_irq_thread_ready(struct irq_desc *desc,
 	if (!action || !action->thread)
 		return;
 
+	irq_thread_set_affinity(action->thread, desc);
 	wake_up_process(action->thread);
 	wait_event(desc->wait_for_threads,
 		   test_bit(IRQTF_READY, &action->thread_flags));
@@ -1405,16 +1421,7 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 	 * references an already freed task_struct.
 	 */
 	new->thread = get_task_struct(t);
-	/*
-	 * Tell the thread to set its affinity. This is
-	 * important for shared interrupt handlers as we do
-	 * not invoke setup_affinity() for the secondary
-	 * handlers as everything is already set up. Even for
-	 * interrupts marked with IRQF_NO_BALANCE this is
-	 * correct as we want the thread to move to the cpu(s)
-	 * on which the requesting code placed the interrupt.
-	 */
-	set_bit(IRQTF_AFFINITY, &new->thread_flags);
+
 	return 0;
 }
 
-- 
2.51.0



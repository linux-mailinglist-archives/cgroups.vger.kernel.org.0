Return-Path: <cgroups+bounces-12062-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8F9C6A090
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 15:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44A414FD01B
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 14:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614635E530;
	Tue, 18 Nov 2025 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egyj0KB7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFA2361DB5;
	Tue, 18 Nov 2025 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476262; cv=none; b=oTgjFYXUylElUgSwBA3MH4qDAbrCPKMLD18hlbEBP7a6ZMAipLhBWKH1h5vq0WJm/WEs/CwX1tp/9X6M4UqorFXGsofo3V/ms8hRcD8M89P/uEIRRqR8gac+1PwHZzsimu7meYEzPtWXD24JwkG2EZT5zuBrlIK0oVFVAnSjFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476262; c=relaxed/simple;
	bh=f6tLyuKcwQRyVUQTkPxdFWRvjiuXwnoZ1zyHEl+ONUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyPNCU/oxD5Pu3kgX0geuc7huYxmI3zcp/gOGTUbf1MsEsNJVsoFlkhY9pfsA9N+uZok6cngqaRwLIytTSjkPvpYs3OQYCinus+L84ShdfXFKtj0uyxVjFIZEJLxrkWy0Qc71dX040a3Jr2wht9iHBEJl9BQs7lr/6A3J2YOoYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egyj0KB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D13C4CEF1;
	Tue, 18 Nov 2025 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763476262;
	bh=f6tLyuKcwQRyVUQTkPxdFWRvjiuXwnoZ1zyHEl+ONUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egyj0KB7E3XAHxzdKKK0lSG0ErQUu6ibI4v3kLug6WspL3rDbKgllhInwGQlu/O30
	 MACxRddBOc3TIkAdTJma2MXPeoPbAwXtaXuev/C5QLuMoa8KDeWhGN46cAKVThc/WI
	 7StZ8TNwhk9ed6pCpTh5U75o40UdQlj4D+d5YDUL2D4ymb32L7MLbSZZFYNntiFCt8
	 FfUU2DCM3YatTdhEsJZ4fDcBJB/s/aTN9MRrZN568cghkEmzOMvNo5oY6c1VWLwf0d
	 69+uHKv2rPX7SZ0tGCfs8ChFb6lAMrpuIyYRDQo2NM3kS9VQloz5zTA+kWecxV0Rop
	 6xiI9X0BYj7sw==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Waiman Long <llong@redhat.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 1/2] genirq: Fix IRQ threads affinity VS cpuset isolated partitions
Date: Tue, 18 Nov 2025 15:30:51 +0100
Message-ID: <20251118143052.68778-2-frederic@kernel.org>
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
 kernel/irq/manage.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 400856abf672..76e2cbe21d1f 100644
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
 
@@ -1035,8 +1035,16 @@ static void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *a
 		set_cpus_allowed_ptr(current, mask);
 	free_cpumask_var(mask);
 }
+
+static inline void irq_thread_set_affinity(struct task_struct *t,
+					   struct irq_desc *desc)
+{
+	kthread_bind_mask(t, irq_data_get_effective_affinity_mask(&desc->irq_data));
+}
 #else
 static inline void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
+static inline void irq_thread_set_affinity(struct task_struct *t,
+					   struct irq_desc *desc) { }
 #endif
 
 static int irq_wait_for_interrupt(struct irq_desc *desc,
@@ -1221,6 +1229,7 @@ static void wake_up_and_wait_for_irq_thread_ready(struct irq_desc *desc,
 	if (!action || !action->thread)
 		return;
 
+	irq_thread_set_affinity(action->thread, desc);
 	wake_up_process(action->thread);
 	wait_event(desc->wait_for_threads,
 		   test_bit(IRQTF_READY, &action->thread_flags));
@@ -1405,16 +1414,7 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
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



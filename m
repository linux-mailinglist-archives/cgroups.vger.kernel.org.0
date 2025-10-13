Return-Path: <cgroups+bounces-10699-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE52DBD63B5
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 22:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 854234F8DE2
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 20:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DE630CDBB;
	Mon, 13 Oct 2025 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2HsIj0G"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4730C372;
	Mon, 13 Oct 2025 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387765; cv=none; b=CNfJpFCT1EdtW0e3w4MJlw6liP5cWO5hiLR2C1FlgnEyFBfe0vNwz+jDgnonoTD++/R3xfpN4egUV7Jq/Th6m0z2r5TqWuA3gkDancY3eK36R+z/GTGHXezoi+c03ISloAHc/rqv7PEH6S+KJ3rBWxcnaiBtAteudSB5MhEaZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387765; c=relaxed/simple;
	bh=chMAaHPdvZjXfYZQTfmqroMaCahKvWi7hxvycGkBc0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOnu3eQ3NPPxpzhbchL/8yrhPjuxh6RzqXWGyUq9Vn9N22S8kFRH7ZHyVWMW2mYkX1PEmUTwLotGMmdbb1KTjxFvcJ16LGEObZC8wtdIeVr0PslsJuGMLgqPhBM6Gva4qPi9W6OaKyok2YsibWZ0+qGMNJLy4Zyg9njwLYmSBwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2HsIj0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2137C4CEE7;
	Mon, 13 Oct 2025 20:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387764;
	bh=chMAaHPdvZjXfYZQTfmqroMaCahKvWi7hxvycGkBc0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2HsIj0GjEnJTG81nuvxt+rh9V8jVDkwbolK1vZjH/QLdrhSvnA4rL0lejyT03fUk
	 AYQKAmOHXS+cRkZyMi+8eL/fcdpoD5VY6iC9oTM4NqHv00OF3hCY96KH1rhoGQ9WaS
	 FAvGOoJh3cunza7z8okA+g3/wzRnll3xJH1fzYwKHMUEuxT9HranLKJnuHZYIdXZCl
	 DAR47RiTFVA+tE01uD8gMxCMzvEl7IPtksM+od6OjCFZjAEroLlDCHRxcoddmDtTra
	 uUCQU+FtsHyohiTXjUfWqTx58+dKEq/DSkCy0XlqFAOBoVjCCVB/zzVTbAzQ5eAKLi
	 rFUdm4g/rBL6g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 32/33] genirq: Correctly handle preferred kthreads affinity
Date: Mon, 13 Oct 2025 22:31:45 +0200
Message-ID: <20251013203146.10162-33-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013203146.10162-1-frederic@kernel.org>
References: <20251013203146.10162-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[CHECKME: Do some IRQ threads have strong affinity requirements? In
which case they should use kthread_bind()...]

The affinity of IRQ threads is applied through a direct call to the
scheduler. As a result this affinity may not be carried correctly across
hotplug events, cpuset isolated partitions updates, or against
housekeeping constraints.

For example a simple creation of cpuset isolated partition will
overwrite all IRQ threads affinity to the non isolated cpusets.

To prevent from that, use the appropriate kthread affinity APIs that
takes care of the preferred affinity during these kinds of events.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/irq/manage.c | 47 +++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c94837382037..d96f6675c888 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -176,15 +176,15 @@ bool irq_can_set_affinity_usr(unsigned int irq)
 }
 
 /**
- * irq_set_thread_affinity - Notify irq threads to adjust affinity
+ * irq_thread_notify_affinity - Notify irq threads to adjust affinity
  * @desc:	irq descriptor which has affinity changed
  *
  * Just set IRQTF_AFFINITY and delegate the affinity setting to the
- * interrupt thread itself. We can not call set_cpus_allowed_ptr() here as
- * we hold desc->lock and this code can be called from hard interrupt
+ * interrupt thread itself. We can not call kthread_affine_preferred_update()
+ * here as we hold desc->lock and this code can be called from hard interrupt
  * context.
  */
-static void irq_set_thread_affinity(struct irq_desc *desc)
+static void irq_thread_notify_affinity(struct irq_desc *desc)
 {
 	struct irqaction *action;
 
@@ -283,7 +283,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 		fallthrough;
 	case IRQ_SET_MASK_OK_NOCOPY:
 		irq_validate_effective_affinity(data);
-		irq_set_thread_affinity(desc);
+		irq_thread_notify_affinity(desc);
 		ret = 0;
 	}
 
@@ -1032,11 +1032,26 @@ static void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *a
 	}
 
 	if (valid)
-		set_cpus_allowed_ptr(current, mask);
+		kthread_affine_preferred_update(current, mask);
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
+	kthread_affine_preferred(t, mask);
+}
 #else
 static inline void irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
+static inline void irq_thread_set_affinity(struct task_struct *t,
+					   struct irq_desc *desc) { }
 #endif
 
 static int irq_wait_for_interrupt(struct irq_desc *desc,
@@ -1384,7 +1399,8 @@ static void irq_nmi_teardown(struct irq_desc *desc)
 }
 
 static int
-setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
+setup_irq_thread(struct irqaction *new, struct irq_desc *desc,
+		 unsigned int irq, bool secondary)
 {
 	struct task_struct *t;
 
@@ -1405,16 +1421,9 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
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
+	irq_thread_set_affinity(t, desc);
+
 	return 0;
 }
 
@@ -1486,11 +1495,11 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	 * thread.
 	 */
 	if (new->thread_fn && !nested) {
-		ret = setup_irq_thread(new, irq, false);
+		ret = setup_irq_thread(new, desc, irq, false);
 		if (ret)
 			goto out_mput;
 		if (new->secondary) {
-			ret = setup_irq_thread(new->secondary, irq, true);
+			ret = setup_irq_thread(new->secondary, desc, irq, true);
 			if (ret)
 				goto out_thread;
 		}
-- 
2.51.0



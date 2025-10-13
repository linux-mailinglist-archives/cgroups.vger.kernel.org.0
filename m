Return-Path: <cgroups+bounces-10697-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B76A9BD634D
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 22:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1764418886F4
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 20:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F08311C19;
	Mon, 13 Oct 2025 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGk5nfr+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3CA30CD92;
	Mon, 13 Oct 2025 20:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387750; cv=none; b=IXDRqJ2xHfJtEVeN88w1umeb5CiDKutttxd5mPJC/1zYCQeXET5yV6FcUReKLuQORjOMO4/65pE5PNa9atR6YpkTmq7tkJHixFT+0Wvd/9XhkUA1+t34yMcGWUm+0OK0oZrHvZBm345o/G6P49bMzhYULqkp2ZlQwLlCzacXXc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387750; c=relaxed/simple;
	bh=tmme1GHCRZttEH0fzbesyJQ/RQ0GFTr99io8B0/CrOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsRQX9xMgNjod2R7/9gb6IA3WHmwkrTkwdsmB9uyFlma+w0vrg64N1aJFaYOk/wrWSPg4wRQ5y2SViCjhjQHveuZtgBm1Mo7l6u/7l/L55P2+ENamX5nM4kpKr7sAJHNvnrNrXfjP1bKPYIq0/kI3tyiTJcIgLH0teA7t9gYR34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGk5nfr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39411C4CEF8;
	Mon, 13 Oct 2025 20:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387749;
	bh=tmme1GHCRZttEH0fzbesyJQ/RQ0GFTr99io8B0/CrOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qGk5nfr+6FsZ+NjmwnCpmAIaenxkl60KAACf6wbri2p0S9pMENlqql05tS3cfeHFe
	 uKiGz3Z1CNQF9dQ5na0Eo9YKToVMYig8jRDhXl6mjij12opct/nqMuc04zcTbWIkUp
	 Pv4FcATUmHuTXDyFfwmtBXSk+cueqvuhxXcz79ZHZkNl/G05hC4WAIWCUq6mXj3vlC
	 8GL1Mo9r7l5G3jIvY1YprkTxP7uSL9d4kbRQllwCO4VpCnFsXjxKKnDv13lxqm/xOg
	 uIG/Hsns7R68qcZY9rnBMiW6uZGF0Fd9OINAd0lw3yS0nEqn0SX9YPNmoF+o7eFaGf
	 O1f7778QWb7+g==
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
Subject: [PATCH 30/33] kthread: Add API to update preferred affinity on kthread runtime
Date: Mon, 13 Oct 2025 22:31:43 +0200
Message-ID: <20251013203146.10162-31-frederic@kernel.org>
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

Kthreads can apply for a preferred affinity upon creation but they have
no means to update that preferred affinity after the first wake up.
kthread_affine_preferred() is optimized by assuming the kthread
is sleeping while applying the allowed cpumask.

Therefore introduce a new API to further update the preferred affinity.

It will be used by IRQ kthreads.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/kthread.h |  1 +
 kernel/kthread.c        | 55 +++++++++++++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index c92c1149ee6e..a06cae7f2c55 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -86,6 +86,7 @@ void free_kthread_struct(struct task_struct *k);
 void kthread_bind(struct task_struct *k, unsigned int cpu);
 void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
 int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask);
+int kthread_affine_preferred_update(struct task_struct *p, const struct cpumask *mask);
 int kthread_stop(struct task_struct *k);
 int kthread_stop_put(struct task_struct *k);
 bool kthread_should_stop(void);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index d36bdfbd004e..f3397cf7542a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -322,17 +322,16 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
 void __noreturn kthread_exit(long result)
 {
 	struct kthread *kthread = to_kthread(current);
+	struct cpumask *to_free = NULL;
 	kthread->result = result;
-	if (!list_empty(&kthread->affinity_node)) {
-		mutex_lock(&kthread_affinity_lock);
-		list_del(&kthread->affinity_node);
-		mutex_unlock(&kthread_affinity_lock);
 
-		if (kthread->preferred_affinity) {
-			kfree(kthread->preferred_affinity);
-			kthread->preferred_affinity = NULL;
-		}
+	scoped_guard(mutex, &kthread_affinity_lock) {
+		if (!list_empty(&kthread->affinity_node))
+			list_del_init(&kthread->affinity_node);
+		to_free = kthread->preferred_affinity;
+		kthread->preferred_affinity = NULL;
 	}
+	kfree(to_free);
 	do_exit(0);
 }
 EXPORT_SYMBOL(kthread_exit);
@@ -900,6 +899,46 @@ int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
 }
 EXPORT_SYMBOL_GPL(kthread_affine_preferred);
 
+/**
+ * kthread_affine_preferred_update - update a kthread's preferred affinity
+ * @p: thread created by kthread_create().
+ * @cpumask: new mask of CPUs (might not be online, must be possible) for @k
+ *           to run on.
+ *
+ * Update the cpumask of the desired kthread's affinity that was passed by
+ * a previous call to kthread_affine_preferred(). This can be called either
+ * before or after the first wakeup of the kthread.
+ *
+ * Returns 0 if the affinity has been applied.
+ */
+int kthread_affine_preferred_update(struct task_struct *p,
+				    const struct cpumask *mask)
+{
+	struct kthread *kthread = to_kthread(p);
+	cpumask_var_t affinity;
+	int ret = 0;
+
+	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
+		return -ENOMEM;
+
+	scoped_guard(mutex, &kthread_affinity_lock) {
+		if (WARN_ON_ONCE(!kthread->preferred_affinity ||
+				 list_empty(&kthread->affinity_node))) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		cpumask_copy(kthread->preferred_affinity, mask);
+		kthread_fetch_affinity(kthread, affinity);
+		set_cpus_allowed_ptr(p, affinity);
+	}
+out:
+	free_cpumask_var(affinity);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kthread_affine_preferred_update);
+
 static int kthreads_update_affinity(bool force)
 {
 	cpumask_var_t affinity;
-- 
2.51.0



Return-Path: <cgroups+bounces-11632-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F890C37ED0
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193B43AA0A2
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B934FF5C;
	Wed,  5 Nov 2025 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz7xihx1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB434D4E1;
	Wed,  5 Nov 2025 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376816; cv=none; b=FbE/uDVH9p3z3OvyV9c1CBFdZ9I7U8EupxH0LI0KwEzFwnjHM3+YAgyPNBlZmaEAugokJtnq1rKDN5azFA+qMXGY4IKfvmfsjLNkZK5eB3KnbxgwQSrdS1HgSqbOFNf2BRAxZU5SvxOa/5pPrYu0VdmfNy308/lQua9buu383vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376816; c=relaxed/simple;
	bh=rc90r/VJRIFUeghTYji80GjIJHgeRfSLzAtAWtKNZdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td9iluG47f5twEtCRnu041Aj6TOxZPkhjNkUsMkS1jDkQqZJwOhnE81btX9q8zVQwgrLIs6yMLFnf74FxKVZ8pXp7jkDw86o5UyQAyRbzNmcBNEOUvYH7Js2TjQEIGEcHnpsxsTPP+JGSl1FUV1mc6BY+XzzQaa/YE1ppUIiAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz7xihx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918F2C116B1;
	Wed,  5 Nov 2025 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376816;
	bh=rc90r/VJRIFUeghTYji80GjIJHgeRfSLzAtAWtKNZdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hz7xihx1glmCXa1xYOTXCOtZCwF0OTEG4MDXz4ESiFKIT/eSzyLgw6tdM/A/8ArrJ
	 IEd6sw+KI8CCzzGQUHk4lbghlqPOFoH0V+bJWqxwNfBrriit2+q0O9a/xMKNAVftG1
	 pdEtz6CY10kisa6Dvp3UjaeNE1tQMLiHK0nc3QJKfijSBQW1LtHsUNCwdyFZvY3JRx
	 30ZUh5GLz8QEnuL2xArNJEP1+nfwTiM+E7KRZVU84r9zqRWV8rANivY1p/SX18pPk8
	 Q13aJlDvbtRaohmyRA5PXJR2bE/8UKI4+NRSo21D37HRxvequjK1Me/ZODpo/5OSaB
	 S5lgY0KgQyIzw==
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
Subject: [PATCH 22/31] kthread: Include unbound kthreads in the managed affinity list
Date: Wed,  5 Nov 2025 22:03:38 +0100
Message-ID: <20251105210348.35256-23-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105210348.35256-1-frederic@kernel.org>
References: <20251105210348.35256-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The managed affinity list currently contains only unbound kthreads that
have affinity preferences. Unbound kthreads globally affine by default
are outside of the list because their affinity is automatically managed
by the scheduler (through the fallback housekeeping mask) and by cpuset.

However in order to preserve the preferred affinity of kthreads, cpuset
will delegate the isolated partition update propagation to the
housekeeping and kthread code.

Prepare for that with including all unbound kthreads in the managed
affinity list.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 70 ++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index c4dd967e9e9c..b4794241420f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -365,9 +365,10 @@ static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpum
 	if (kthread->preferred_affinity) {
 		pref = kthread->preferred_affinity;
 	} else {
-		if (WARN_ON_ONCE(kthread->node == NUMA_NO_NODE))
-			return;
-		pref = cpumask_of_node(kthread->node);
+		if (kthread->node == NUMA_NO_NODE)
+			pref = housekeeping_cpumask(HK_TYPE_KTHREAD);
+		else
+			pref = cpumask_of_node(kthread->node);
 	}
 
 	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_KTHREAD));
@@ -380,32 +381,29 @@ static void kthread_affine_node(void)
 	struct kthread *kthread = to_kthread(current);
 	cpumask_var_t affinity;
 
-	WARN_ON_ONCE(kthread_is_per_cpu(current));
+	if (WARN_ON_ONCE(kthread_is_per_cpu(current)))
+		return;
 
-	if (kthread->node == NUMA_NO_NODE) {
-		housekeeping_affine(current, HK_TYPE_KTHREAD);
-	} else {
-		if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
-			WARN_ON_ONCE(1);
-			return;
-		}
-
-		mutex_lock(&kthread_affinity_lock);
-		WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
-		list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
-		/*
-		 * The node cpumask is racy when read from kthread() but:
-		 * - a racing CPU going down will either fail on the subsequent
-		 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
-		 *   afterwards by the scheduler.
-		 * - a racing CPU going up will be handled by kthreads_online_cpu()
-		 */
-		kthread_fetch_affinity(kthread, affinity);
-		set_cpus_allowed_ptr(current, affinity);
-		mutex_unlock(&kthread_affinity_lock);
-
-		free_cpumask_var(affinity);
+	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
+		WARN_ON_ONCE(1);
+		return;
 	}
+
+	mutex_lock(&kthread_affinity_lock);
+	WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
+	list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
+	/*
+	 * The node cpumask is racy when read from kthread() but:
+	 * - a racing CPU going down will either fail on the subsequent
+	 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
+	 *   afterwards by the scheduler.
+	 * - a racing CPU going up will be handled by kthreads_online_cpu()
+	 */
+	kthread_fetch_affinity(kthread, affinity);
+	set_cpus_allowed_ptr(current, affinity);
+	mutex_unlock(&kthread_affinity_lock);
+
+	free_cpumask_var(affinity);
 }
 
 static int kthread(void *_create)
@@ -924,8 +922,22 @@ static int kthreads_online_cpu(unsigned int cpu)
 			ret = -EINVAL;
 			continue;
 		}
-		kthread_fetch_affinity(k, affinity);
-		set_cpus_allowed_ptr(k->task, affinity);
+
+		/*
+		 * Unbound kthreads without preferred affinity are already affine
+		 * to housekeeping, whether those CPUs are online or not. So no need
+		 * to handle newly online CPUs for them.
+		 *
+		 * But kthreads with a preferred affinity or node are different:
+		 * if none of their preferred CPUs are online and part of
+		 * housekeeping at the same time, they must be affine to housekeeping.
+		 * But as soon as one of their preferred CPU becomes online, they must
+		 * be affine to them.
+		 */
+		if (k->preferred_affinity || k->node != NUMA_NO_NODE) {
+			kthread_fetch_affinity(k, affinity);
+			set_cpus_allowed_ptr(k->task, affinity);
+		}
 	}
 
 	free_cpumask_var(affinity);
-- 
2.51.0



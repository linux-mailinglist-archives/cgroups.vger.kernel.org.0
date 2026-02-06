Return-Path: <cgroups+bounces-13742-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLc4JYz9hWnUIwQAu9opvQ
	(envelope-from <cgroups+bounces-13742-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 15:41:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6D1FF19F
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 15:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15F2A301983F
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB38423A8F;
	Fri,  6 Feb 2026 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrAWY9MS"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E7423165
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388818; cv=none; b=SdM2hnnE9Su9DT8wllzknxeF4w5VPT/se9qGH5HDvtlbefMOL+Mic2RPzTs5zeMmjs52KvSqLsKJayV7dUor6lSiXib8mczOnepsYtQzNVGWc4WYdrBr0a0o25bzW/LBfus2OIIARDk7TVala+RS7YbP4aVcGKKJEQJLvFUcSPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388818; c=relaxed/simple;
	bh=m6kEmEIfXFU1Hl0FIsgn6Fy2bN3huAhWxrtV4Z4+Dlg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=U6fO2kkL9bCJdWpwNAhd2XUwXnsJIegQ+PUyxFfSe1DFrv3iFVS95e0n3C9fBT9RQrk1XMN4llYbojLoLz8MpNkPcXWcuuLtmy3Wt919Ujrc6jt7EUKwXltwxd9rU0WNFcppf41YVq++GtUS2P5u4vLIwnlbJm58oft0m6IiRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrAWY9MS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770388817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CIBbWTksw7DvJ78/DV3io3akwWeED1pL6ZqB6VcV8to=;
	b=LrAWY9MSBsVgzYHKA4mivppd5nQmVWXeXpGDTFBGn/8GI3U9uKVMjZFlqIjSBHOHK6v3+Y
	xNPYG4CJX1eenxm6BFkUgdKi2P0RlZNcC8qvod0sW/uvI3hsElBKbDq3SCq3EUeqbcKGsv
	71yX0EXrWkCHVd+mO52wX3ASmQggzm0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-wu1KRp-3McuXwj9pNVbERQ-1; Fri,
 06 Feb 2026 09:40:12 -0500
X-MC-Unique: wu1KRp-3McuXwj9pNVbERQ-1
X-Mimecast-MFC-AGG-ID: wu1KRp-3McuXwj9pNVbERQ_1770388810
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21DDB18001FC;
	Fri,  6 Feb 2026 14:40:10 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.22.74.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F78B1800465;
	Fri,  6 Feb 2026 14:40:07 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id B40B841DF09EC; Fri,  6 Feb 2026 11:39:20 -0300 (-03)
Message-ID: <20260206143741.621816322@redhat.com>
User-Agent: quilt/0.66
Date: Fri, 06 Feb 2026 11:34:34 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 4/4] slub: apply new queue_percpu_work_on() interface
References: <20260206143430.021026873@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,linux.com,google.com,lge.com,suse.cz,gmail.com,redhat.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-13742-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1B6D1FF19F
X-Rspamd-Action: no action

Make use of the new qpw_{un,}lock*() and queue_percpu_work_on()
interface to improve performance & latency on PREEMPT_RT kernels.

For functions that may be scheduled in a different cpu, replace
local_{un,}lock*() by qpw_{un,}lock*(), and replace schedule_work_on() by
queue_percpu_work_on(). The same happens for flush_work() and
flush_percpu_work().

This change requires allocation of qpw_structs instead of a work_structs,
and changing parameters of a few functions to include the cpu parameter.

This should bring no relevant performance impact on non-RT kernels:
For functions that may be scheduled in a different cpu, the local_*lock's
this_cpu_ptr() becomes a per_cpu_ptr(smp_processor_id()).

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 mm/slub.c |  218 ++++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 142 insertions(+), 76 deletions(-)

Index: slab/mm/slub.c
===================================================================
--- slab.orig/mm/slub.c
+++ slab/mm/slub.c
@@ -49,6 +49,7 @@
 #include <linux/irq_work.h>
 #include <linux/kprobes.h>
 #include <linux/debugfs.h>
+#include <linux/qpw.h>
 #include <trace/events/kmem.h>
 
 #include "internal.h"
@@ -128,7 +129,7 @@
  *   For debug caches, all allocations are forced to go through a list_lock
  *   protected region to serialize against concurrent validation.
  *
- *   cpu_sheaves->lock (local_trylock)
+ *   cpu_sheaves->lock (qpw_trylock)
  *
  *   This lock protects fastpath operations on the percpu sheaves. On !RT it
  *   only disables preemption and does no atomic operations. As long as the main
@@ -156,7 +157,7 @@
  *   Interrupts are disabled as part of list_lock or barn lock operations, or
  *   around the slab_lock operation, in order to make the slab allocator safe
  *   to use in the context of an irq.
- *   Preemption is disabled as part of local_trylock operations.
+ *   Preemption is disabled as part of qpw_trylock operations.
  *   kmalloc_nolock() and kfree_nolock() are safe in NMI context but see
  *   their limitations.
  *
@@ -417,7 +418,7 @@ struct slab_sheaf {
 };
 
 struct slub_percpu_sheaves {
-	local_trylock_t lock;
+	qpw_trylock_t lock;
 	struct slab_sheaf *main; /* never NULL when unlocked */
 	struct slab_sheaf *spare; /* empty or full, may be NULL */
 	struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
@@ -479,7 +480,7 @@ static nodemask_t slab_nodes;
 static struct workqueue_struct *flushwq;
 
 struct slub_flush_work {
-	struct work_struct work;
+	struct qpw_struct qpw;
 	struct kmem_cache *s;
 	bool skip;
 };
@@ -2826,7 +2827,7 @@ static void __kmem_cache_free_bulk(struc
  *
  * returns true if at least partially flushed
  */
-static bool sheaf_flush_main(struct kmem_cache *s)
+static bool sheaf_flush_main(struct kmem_cache *s, int cpu)
 {
 	struct slub_percpu_sheaves *pcs;
 	unsigned int batch, remaining;
@@ -2835,10 +2836,10 @@ static bool sheaf_flush_main(struct kmem
 	bool ret = false;
 
 next_batch:
-	if (!local_trylock(&s->cpu_sheaves->lock))
+	if (!qpw_trylock(&s->cpu_sheaves->lock, cpu))
 		return ret;
 
-	pcs = this_cpu_ptr(s->cpu_sheaves);
+	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
 	sheaf = pcs->main;
 
 	batch = min(PCS_BATCH_MAX, sheaf->size);
@@ -2848,7 +2849,7 @@ next_batch:
 
 	remaining = sheaf->size;
 
-	local_unlock(&s->cpu_sheaves->lock);
+	qpw_unlock(&s->cpu_sheaves->lock, cpu);
 
 	__kmem_cache_free_bulk(s, batch, &objects[0]);
 
@@ -2932,13 +2933,13 @@ static void rcu_free_sheaf_nobarn(struct
  * flushing operations are rare so let's keep it simple and flush to slabs
  * directly, skipping the barn
  */
-static void pcs_flush_all(struct kmem_cache *s)
+static void pcs_flush_all(struct kmem_cache *s, int cpu)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *spare, *rcu_free;
 
-	local_lock(&s->cpu_sheaves->lock);
-	pcs = this_cpu_ptr(s->cpu_sheaves);
+	qpw_lock(&s->cpu_sheaves->lock, cpu);
+	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
 
 	spare = pcs->spare;
 	pcs->spare = NULL;
@@ -2946,7 +2947,7 @@ static void pcs_flush_all(struct kmem_ca
 	rcu_free = pcs->rcu_free;
 	pcs->rcu_free = NULL;
 
-	local_unlock(&s->cpu_sheaves->lock);
+	qpw_unlock(&s->cpu_sheaves->lock, cpu);
 
 	if (spare) {
 		sheaf_flush_unused(s, spare);
@@ -2956,7 +2957,7 @@ static void pcs_flush_all(struct kmem_ca
 	if (rcu_free)
 		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
 
-	sheaf_flush_main(s);
+	sheaf_flush_main(s, cpu);
 }
 
 static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
@@ -3881,13 +3882,13 @@ static void flush_cpu_sheaves(struct wor
 {
 	struct kmem_cache *s;
 	struct slub_flush_work *sfw;
+	int cpu = qpw_get_cpu(w);
 
-	sfw = container_of(w, struct slub_flush_work, work);
-
+	sfw = &per_cpu(slub_flush, cpu);
 	s = sfw->s;
 
 	if (cache_has_sheaves(s))
-		pcs_flush_all(s);
+		pcs_flush_all(s, cpu);
 }
 
 static void flush_all_cpus_locked(struct kmem_cache *s)
@@ -3904,17 +3905,17 @@ static void flush_all_cpus_locked(struct
 			sfw->skip = true;
 			continue;
 		}
-		INIT_WORK(&sfw->work, flush_cpu_sheaves);
+		INIT_QPW(&sfw->qpw, flush_cpu_sheaves, cpu);
 		sfw->skip = false;
 		sfw->s = s;
-		queue_work_on(cpu, flushwq, &sfw->work);
+		queue_percpu_work_on(cpu, flushwq, &sfw->qpw);
 	}
 
 	for_each_online_cpu(cpu) {
 		sfw = &per_cpu(slub_flush, cpu);
 		if (sfw->skip)
 			continue;
-		flush_work(&sfw->work);
+		flush_percpu_work(&sfw->qpw);
 	}
 
 	mutex_unlock(&flush_lock);
@@ -3933,17 +3934,18 @@ static void flush_rcu_sheaf(struct work_
 	struct slab_sheaf *rcu_free;
 	struct slub_flush_work *sfw;
 	struct kmem_cache *s;
+	int cpu = qpw_get_cpu(w);
 
-	sfw = container_of(w, struct slub_flush_work, work);
+	sfw = &per_cpu(slub_flush, cpu);
 	s = sfw->s;
 
-	local_lock(&s->cpu_sheaves->lock);
-	pcs = this_cpu_ptr(s->cpu_sheaves);
+	qpw_lock(&s->cpu_sheaves->lock, cpu);
+	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
 
 	rcu_free = pcs->rcu_free;
 	pcs->rcu_free = NULL;
 
-	local_unlock(&s->cpu_sheaves->lock);
+	qpw_unlock(&s->cpu_sheaves->lock, cpu);
 
 	if (rcu_free)
 		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
@@ -3968,14 +3970,14 @@ void flush_rcu_sheaves_on_cache(struct k
 		 * sure the __kfree_rcu_sheaf() finished its call_rcu()
 		 */
 
-		INIT_WORK(&sfw->work, flush_rcu_sheaf);
+		INIT_QPW(&sfw->qpw, flush_rcu_sheaf, cpu);
 		sfw->s = s;
-		queue_work_on(cpu, flushwq, &sfw->work);
+		queue_percpu_work_on(cpu, flushwq, &sfw->qpw);
 	}
 
 	for_each_online_cpu(cpu) {
 		sfw = &per_cpu(slub_flush, cpu);
-		flush_work(&sfw->work);
+		flush_percpu_work(&sfw->qpw);
 	}
 
 	mutex_unlock(&flush_lock);
@@ -4472,22 +4474,24 @@ bool slab_post_alloc_hook(struct kmem_ca
  *
  * Must be called with the cpu_sheaves local lock locked. If successful, returns
  * the pcs pointer and the local lock locked (possibly on a different cpu than
- * initially called). If not successful, returns NULL and the local lock
- * unlocked.
+ * initially called), and migration disabled. If not successful, returns NULL
+ * and the local lock unlocked, with migration enabled.
  */
 static struct slub_percpu_sheaves *
-__pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs, gfp_t gfp)
+__pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs, gfp_t gfp,
+			 int *cpu)
 {
 	struct slab_sheaf *empty = NULL;
 	struct slab_sheaf *full;
 	struct node_barn *barn;
 	bool can_alloc;
 
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
+	qpw_lockdep_assert_held(&s->cpu_sheaves->lock);
 
 	/* Bootstrap or debug cache, back off */
 	if (unlikely(!cache_has_sheaves(s))) {
-		local_unlock(&s->cpu_sheaves->lock);
+		qpw_unlock(&s->cpu_sheaves->lock, *cpu);
+		migrate_enable();
 		return NULL;
 	}
 
@@ -4498,7 +4502,8 @@ __pcs_replace_empty_main(struct kmem_cac
 
 	barn = get_barn(s);
 	if (!barn) {
-		local_unlock(&s->cpu_sheaves->lock);
+		qpw_unlock(&s->cpu_sheaves->lock, *cpu);
+		migrate_enable();
 		return NULL;
 	}
 
@@ -4524,7 +4529,8 @@ __pcs_replace_empty_main(struct kmem_cac
 		}
 	}
 
-	local_unlock(&s->cpu_sheaves->lock);
+	qpw_unlock(&s->cpu_sheaves->lock, *cpu);
+	migrate_enable();
 
 	if (!can_alloc)
 		return NULL;
@@ -4550,7 +4556,9 @@ __pcs_replace_empty_main(struct kmem_cac
 	 * we can reach here only when gfpflags_allow_blocking
 	 * so this must not be an irq
 	 */
-	local_lock(&s->cpu_sheaves->lock);
+	migrate_disable();
+	*cpu = smp_processor_id();
+	qpw_lock(&s->cpu_sheaves->lock, *cpu);
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	/*
@@ -4593,6 +4601,7 @@ void *alloc_from_pcs(struct kmem_cache *
 	struct slub_percpu_sheaves *pcs;
 	bool node_requested;
 	void *object;
+	int cpu;
 
 #ifdef CONFIG_NUMA
 	if (static_branch_unlikely(&strict_numa) &&
@@ -4627,13 +4636,17 @@ void *alloc_from_pcs(struct kmem_cache *
 		return NULL;
 	}
 
-	if (!local_trylock(&s->cpu_sheaves->lock))
+	migrate_disable();
+	cpu = smp_processor_id();
+	if (!qpw_trylock(&s->cpu_sheaves->lock, cpu)) {
+		migrate_enable();
 		return NULL;
+	}
 
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	if (unlikely(pcs->main->size == 0)) {
-		pcs = __pcs_replace_empty_main(s, pcs, gfp);
+		pcs = __pcs_replace_empty_main(s, pcs, gfp, &cpu);
 		if (unlikely(!pcs))
 			return NULL;
 	}
@@ -4647,7 +4660,8 @@ void *alloc_from_pcs(struct kmem_cache *
 		 * the current allocation or previous freeing process.
 		 */
 		if (page_to_nid(virt_to_page(object)) != node) {
-			local_unlock(&s->cpu_sheaves->lock);
+			qpw_unlock(&s->cpu_sheaves->lock, cpu);
+			migrate_enable();
 			stat(s, ALLOC_NODE_MISMATCH);
 			return NULL;
 		}
@@ -4655,7 +4669,8 @@ void *alloc_from_pcs(struct kmem_cache *
 
 	pcs->main->size--;
 
-	local_unlock(&s->cpu_sheaves->lock);
+	qpw_unlock(&s->cpu_sheaves->lock, cpu);
+	migrate_enable();
 
 	stat(s, ALLOC_FASTPATH);
 
@@ -4670,10 +4685,15 @@ unsigned int alloc_from_pcs_bulk(struct
 	struct slab_sheaf *main;
 	unsigned int allocated = 0;
 	unsigned int batch;
+	int cpu;
 
 next_batch:
-	if (!local_trylock(&s->cpu_sheaves->lock))
+	migrate_disable();
+	cpu = smp_processor_id();
+	if (!qpw_trylock(&s->cpu_sheaves->lock, cpu)) {
+		migrate_enable();
 		return allocated;
+	}
 
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
@@ -4683,7 +4703,8 @@ next_batch:
 		struct node_barn *barn;
 
 		if (unlikely(!cache_has_sheaves(s))) {
-			local_unlock(&s->cpu_sheaves->lock);
+			qpw_unlock(&s->cpu_sheaves->lock, cpu);
+			migrate_enable();
 			return allocated;
 		}
 
@@ -4694,7 +4715,8 @@ next_batch:
 
 		barn = get_barn(s);
 		if (!barn) {
-			local_unlock(&s->cpu_sheaves->lock);
+			qpw_unlock(&s->cpu_sheaves->lock, cpu);
+			migrate_enable();
 			return allocated;
 		}
 
@@ -4709,7 +4731,8 @@ next_batch:
 
 		stat(s, BARN_GET_FAIL);
 
-		local_unlock(&s->cpu_sheaves->lock);
+		qpw_unlock(&s->cpu_sheaves->lock, cpu);
+		migrate_enable();
 
 		/*
 		 * Once full sheaves in barn are depleted, let the bulk
@@ -4727,7 +4750,8 @@ do_alloc:
 	main->size -= batch;
 	memcpy(p, main->objects + main->size, batch * sizeof(void *));
 
-	local_unlock(&s->cpu_sheaves->lock);
+	qpw_unlock(&s->cpu_sheaves->lock, cpu);
+	migrate_enable();
 
 	stat_add(s, ALLOC_FASTPATH, batch);
 
@@ -4877,6 +4901,7 @@ kmem_cache_prefill_sheaf(struct kmem_cac
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *sheaf = NULL;
 	struct node_barn *barn;
+	int cpu;
 
 	if (unlikely(!size))
 		return NULL;
@@ -4906,7 +4931,9 @@ kmem_cache_prefill_sheaf(struct kmem_cac
 		return sheaf;
 	}
 
-	local_lock(&s->cpu_sheaves->lock);
+	migrate_disable();
+	cpu = smp_processor_id();
+	qpw_lock(&s->cpu_sheaves->lock, cpu);
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	if (pcs->spare) {
@@ -4925,7 +4952,8 @@ kmem_cache_prefill_sheaf(struct kmem_cac
 			stat(s, BARN_GET_FAIL);
 	}
 
-	local_unlock(&s->cpu_sheaves->lock);
+	qpw_unlock(&s->cpu_sheaves->lock, cpu);
+	migrate_enable();
 
 
 	if (!sheaf)
@@ -4961,6 +4989,7 @@ void kmem_cache_return_sheaf(struct kmem
 {
 	struct slub_percpu_sheaves *pcs;
 	struct node_barn *barn;
+	int cpu;
 
 	if (unlikely((sheaf->capacity != s->sheaf_capacity)
 		     || sheaf->pfmemalloc)) {
@@ -4969,7 +4998,9 @@ void kmem_cache_return_sheaf(struct kmem
 		return;
 	}
 
-	local_lock(&s->cpu_sheaves->lock);
+	migrate_disable();
+	cpu = smp_processor_id();
+	qpw_lock(&s->cpu_sheaves->lock, cpu);
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 	barn = get_barn(s);
 
@@ -4979,7 +5010,8 @@ void kmem_cache_return_sheaf(struct kmem
 		stat(s, SHEAF_RETURN_FAST);
 	}
 
-	local_unlock(&s->cpu_sheaves->lock);
+	qpw_unlock(&s->cpu_sheaves->lock, cpu);
+	migrate_enable();
 
 	if (!sheaf)
 		return;
@@ -5507,9 +5539,9 @@ slab_empty:
  */
 static void __pcs_install_empty_sheaf(struct kmem_cache *s,
 		struct slub_percpu_sheaves *pcs, struct slab_sheaf *empty,
-		struct node_barn *barn)
+		struct node_barn *barn, int cpu)
 {
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
+	qpw_lockdep_assert_held(&s->cpu_sheaves->lock);
 
 	/* This is what we expect to find if nobody interrupted us. */
 	if (likely(!pcs->spare)) {
@@ -5546,31 +5578,34 @@ static void __pcs_install_empty_sheaf(st
 /*
  * Replace the full main sheaf with a (at least partially) empty sheaf.
  *
- * Must be called with the cpu_sheaves local lock locked. If successful, returns
- * the pcs pointer and the local lock locked (possibly on a different cpu than
- * initially called). If not successful, returns NULL and the local lock
- * unlocked.
+ * Must be called with the cpu_sheaves local lock locked, and migration counter
+ * increased. If successful, returns the pcs pointer and the local lock locked
+ * (possibly on a different cpu than initially called), with migration counter
+ * increased. If not successful, returns NULL and the local lock unlocked,
+ * and migration counter decreased.
  */
 static struct slub_percpu_sheaves *
 __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
-			bool allow_spin)
+			bool allow_spin, int *cpu)
 {
 	struct slab_sheaf *empty;
 	struct node_barn *barn;
 	bool put_fail;
 
 restart:
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
+	qpw_lockdep_assert_held(&s->cpu_sheaves->lock);
 
 	/* Bootstrap or debug cache, back off */
 	if (unlikely(!cache_has_sheaves(s))) {
-		local_unlock(&s->cpu_sheaves->lock);
+		qpw_unlock(&s->cpu_sheaves->lock, *cpu);
+		migrate_enable();
 		return NULL;
 	}
 
 	barn = get_barn(s);
 	if (!barn) {
-		local_unlock(&s->cpu_sheaves->lock);
+		qpw_unlock(&s->cpu_sheaves->lock, *cpu);
+		migrate_enable();
 		return NULL;
 	}
 
@@ -5607,7 +5642,8 @@ restart:
 		stat(s, BARN_PUT_FAIL);
 
 		pcs->spare = NULL;
-		local_unlock(&s->cpu_sheaves->lock);
+		qpw_unlock(&s->cpu_sheaves->lock, *cpu);
+		migrate_enable();
 
 		sheaf_flush_unused(s, to_flush);
 		empty = to_flush;
@@ -5623,7 +5659,8 @@ restart:
 	put_fail = true;
 
 alloc_empty:
-	local_unlock(&s->cpu_sheaves->lock);
+	qpw_unlock(&s->cpu_sheaves->lock, *cpu);
+	migrate_enable();
 
 	/*
 	 * alloc_empty_sheaf() doesn't support !allow_spin and it's
@@ -5640,11 +5677,17 @@ alloc_empty:
 	if (put_fail)
 		 stat(s, BARN_PUT_FAIL);
 
-	if (!sheaf_flush_main(s))
+	migrate_disable();
+	*cpu = smp_processor_id();
+	if (!sheaf_flush_main(s, *cpu)) {
+		migrate_enable();
 		return NULL;
+	}
 
-	if (!local_trylock(&s->cpu_sheaves->lock))
+	if (!qpw_trylock(&s->cpu_sheaves->lock, *cpu)) {
+		migrate_enable();
 		return NULL;
+	}
 
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
@@ -5659,13 +5702,14 @@ alloc_empty:
 	return pcs;
 
 got_empty:
-	if (!local_trylock(&s->cpu_sheaves->lock)) {
+	if (!qpw_trylock(&s->cpu_sheaves->lock, *cpu)) {
+		migrate_enable();
 		barn_put_empty_sheaf(barn, empty);
 		return NULL;
 	}
 
 	pcs = this_cpu_ptr(s->cpu_sheaves);
-	__pcs_install_empty_sheaf(s, pcs, empty, barn);
+	__pcs_install_empty_sheaf(s, pcs, empty, barn, *cpu);
 
 	return pcs;
 }
@@ -5678,22 +5722,28 @@ static __fastpath_inline
 bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
 {
 	struct slub_percpu_sheaves *pcs;
+	int cpu;
 
-	if (!local_trylock(&s->cpu_sheaves->lock))
+	migrate_disable();
+	cpu = smp_processor_id();
+	if (!qpw_trylock(&s->cpu_sheaves->lock, cpu)) {
+		migrate_enable();
 		return false;
+	}
 
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
 	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
 
-		pcs = __pcs_replace_full_main(s, pcs, allow_spin);
+		pcs = __pcs_replace_full_main(s, pcs, allow_spin, &cpu);
 		if (unlikely(!pcs))
 			return false;
 	}
 
 	pcs->main->objects[pcs->main->size++] = object;
 
-	local_unlock(&s->cpu_sheaves->lock);
+	qpw_unlock(&s->cpu_sheaves->lock, cpu);
+	migrate_enable();
 
 	stat(s, FREE_FASTPATH);
 
@@ -5777,14 +5827,19 @@ bool __kfree_rcu_sheaf(struct kmem_cache
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *rcu_sheaf;
+	int cpu;
 
 	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
 		return false;
 
 	lock_map_acquire_try(&kfree_rcu_sheaf_map);
 
-	if (!local_trylock(&s->cpu_sheaves->lock))
+	migrate_disable();
+	cpu = smp_processor_id();
+	if (!qpw_trylock(&s->cpu_sheaves->lock, cpu)) {
+		migrate_enable();
 		goto fail;
+	}
 
 	pcs = this_cpu_ptr(s->cpu_sheaves);
 
@@ -5795,7 +5850,8 @@ bool __kfree_rcu_sheaf(struct kmem_cache
 
 		/* Bootstrap or debug cache, fall back */
 		if (unlikely(!cache_has_sheaves(s))) {
-			local_unlock(&s->cpu_sheaves->lock);
+			qpw_unlock(&s->cpu_sheaves->lock, cpu);
+			migrate_enable();
 			goto fail;
 		}
 
@@ -5807,7 +5863,8 @@ bool __kfree_rcu_sheaf(struct kmem_cache
 
 		barn = get_barn(s);
 		if (!barn) {
-			local_unlock(&s->cpu_sheaves->lock);
+			qpw_unlock(&s->cpu_sheaves->lock, cpu);
+			migrate_enable();
 			goto fail;
 		}
 
@@ -5818,15 +5875,18 @@ bool __kfree_rcu_sheaf(struct kmem_cache
 			goto do_free;
 		}
 
-		local_unlock(&s->cpu_sheaves->lock);
+		qpw_unlock(&s->cpu_sheaves->lock, cpu);
+		migrate_enable();
 
 		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
 
 		if (!empty)
 			goto fail;
 
-		if (!local_trylock(&s->cpu_sheaves->lock)) {
+		migrate_disable();
+		if (!qpw_trylock(&s->cpu_sheaves->lock, cpu)) {
 			barn_put_empty_sheaf(barn, empty);
+			migrate_enable();
 			goto fail;
 		}
 
@@ -5862,7 +5922,8 @@ do_free:
 	if (rcu_sheaf)
 		call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
 
-	local_unlock(&s->cpu_sheaves->lock);
+	qpw_unlock(&s->cpu_sheaves->lock, cpu);
+	migrate_enable();
 
 	stat(s, FREE_RCU_SHEAF);
 	lock_map_release(&kfree_rcu_sheaf_map);
@@ -5889,6 +5950,7 @@ static void free_to_pcs_bulk(struct kmem
 	void *remote_objects[PCS_BATCH_MAX];
 	unsigned int remote_nr = 0;
 	int node = numa_mem_id();
+	int cpu;
 
 next_remote_batch:
 	while (i < size) {
@@ -5918,7 +5980,9 @@ next_remote_batch:
 		goto flush_remote;
 
 next_batch:
-	if (!local_trylock(&s->cpu_sheaves->lock))
+	migrate_disable();
+	cpu = smp_processor_id();
+	if (!qpw_trylock(&s->cpu_sheaves->lock, cpu))
 		goto fallback;
 
 	pcs = this_cpu_ptr(s->cpu_sheaves);
@@ -5961,7 +6025,8 @@ do_free:
 	memcpy(main->objects + main->size, p, batch * sizeof(void *));
 	main->size += batch;
 
-	local_unlock(&s->cpu_sheaves->lock);
+	qpw_unlock(&s->cpu_sheaves->lock, cpu);
+	migrate_enable();
 
 	stat_add(s, FREE_FASTPATH, batch);
 
@@ -5977,7 +6042,8 @@ do_free:
 	return;
 
 no_empty:
-	local_unlock(&s->cpu_sheaves->lock);
+	qpw_unlock(&s->cpu_sheaves->lock, cpu);
+	migrate_enable();
 
 	/*
 	 * if we depleted all empty sheaves in the barn or there are too
@@ -7377,7 +7443,7 @@ static int init_percpu_sheaves(struct km
 
 		pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
 
-		local_trylock_init(&pcs->lock);
+		qpw_trylock_init(&pcs->lock);
 
 		/*
 		 * Bootstrap sheaf has zero size so fast-path allocation fails.




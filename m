Return-Path: <cgroups+bounces-13741-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMIVLnj9hWnUIwQAu9opvQ
	(envelope-from <cgroups+bounces-13741-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 15:40:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A10FF195
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 15:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9826A3033E41
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 14:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3551C4219E9;
	Fri,  6 Feb 2026 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkmU7uh9"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB59F4218BE
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388818; cv=none; b=X/uIR8dLuMSq6CkisYjsj6tS2HmvGrUPu9AruDGDzyUVu/QSmQjbw1TCpZPQu6JMU4+8TfjM2/d6AVWkpSrR4wBtpLyyQVYgc3MFZca2gRskuP5zJi/33e4KWLznVDXtiQIfWapoG4INciP4gerTj9JcLyg8sxbCmNTCvb+heUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388818; c=relaxed/simple;
	bh=zyitgazVbNyRejUntdJMXClL49rmA/pJjcIiOHvRTe0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ShRTNLCPRA1MmdAu7h6JlNJU1aRW3p2GLQWLPasJ7c4uziaFEnHOGPamlizblB/XU3EBv606Qa6vy1EkvNqSt5L1lYgeZeQhn89xeocTXWjNPj+TsaP0a8ncVtFbLwI8mroIDIxIzxrbIL1xIPpm7VGTA1chlcJbJPik1L6GiiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GkmU7uh9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770388816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=u+vDHDuyg1tZxOCkT1e6XPP9sTvmKQrxuHI3KpZjiIU=;
	b=GkmU7uh9y0gpLuPuZSGlU92gs8uC4/iGzEui3fA6QRl4cTWsSoiaR28LWoo/lQr3ILjYd8
	pCrrn9XqOEvusLtjW9QhlZ9iMacz+MmxER/Cpg2op2GO0eUF1P0aNFrrnoYaWUfUIYEDzl
	itqiXnP9zLqJEWPvQECFw9HNeLm6Uvw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450--cr5hfH1OYSwaV0E10P2yA-1; Fri,
 06 Feb 2026 09:40:12 -0500
X-MC-Unique: -cr5hfH1OYSwaV0E10P2yA-1
X-Mimecast-MFC-AGG-ID: -cr5hfH1OYSwaV0E10P2yA_1770388810
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B95CA1955F68;
	Fri,  6 Feb 2026 14:40:09 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.22.74.16])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 793AF1800464;
	Fri,  6 Feb 2026 14:40:07 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id B0BD0401E2F84; Fri,  6 Feb 2026 11:39:20 -0300 (-03)
Message-ID: <20260206143741.589656953@redhat.com>
User-Agent: quilt/0.66
Date: Fri, 06 Feb 2026 11:34:33 -0300
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
Subject: [PATCH 3/4] swap: apply new queue_percpu_work_on() interface
References: <20260206143430.021026873@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,linux.com,google.com,lge.com,suse.cz,gmail.com,redhat.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-13741-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mtosatti@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 74A10FF195
X-Rspamd-Action: no action

Make use of the new qpw_{un,}lock*() and queue_percpu_work_on()
interface to improve performance & latency on PREEMPT_RT kernels.

For functions that may be scheduled in a different cpu, replace
local_{un,}lock*() by qpw_{un,}lock*(), and replace schedule_work_on() by
queue_percpu_work_on(). The same happens for flush_work() and
flush_percpu_work().

The change requires allocation of qpw_structs instead of a work_structs,
and changing parameters of a few functions to include the cpu parameter.

This should bring no relevant performance impact on non-RT kernels:
For functions that may be scheduled in a different cpu, the local_*lock's
this_cpu_ptr() becomes a per_cpu_ptr(smp_processor_id()).

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 mm/internal.h   |    4 +-
 mm/mlock.c      |   71 ++++++++++++++++++++++++++++++++------------
 mm/page_alloc.c |    2 -
 mm/swap.c       |   90 +++++++++++++++++++++++++++++++-------------------------
 4 files changed, 108 insertions(+), 59 deletions(-)

Index: slab/mm/mlock.c
===================================================================
--- slab.orig/mm/mlock.c
+++ slab/mm/mlock.c
@@ -25,17 +25,16 @@
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
 #include <linux/secretmem.h>
+#include <linux/qpw.h>
 
 #include "internal.h"
 
 struct mlock_fbatch {
-	local_lock_t lock;
+	qpw_lock_t lock;
 	struct folio_batch fbatch;
 };
 
-static DEFINE_PER_CPU(struct mlock_fbatch, mlock_fbatch) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-};
+static DEFINE_PER_CPU(struct mlock_fbatch, mlock_fbatch);
 
 bool can_do_mlock(void)
 {
@@ -209,18 +208,25 @@ static void mlock_folio_batch(struct fol
 	folios_put(fbatch);
 }
 
-void mlock_drain_local(void)
+void mlock_drain_cpu(int cpu)
 {
 	struct folio_batch *fbatch;
 
-	local_lock(&mlock_fbatch.lock);
-	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
+	qpw_lock(&mlock_fbatch.lock, cpu);
+	fbatch = per_cpu_ptr(&mlock_fbatch.fbatch, cpu);
 	if (folio_batch_count(fbatch))
 		mlock_folio_batch(fbatch);
-	local_unlock(&mlock_fbatch.lock);
+	qpw_unlock(&mlock_fbatch.lock, cpu);
 }
 
-void mlock_drain_remote(int cpu)
+void mlock_drain_local(void)
+{
+	migrate_disable();
+	mlock_drain_cpu(smp_processor_id());
+	migrate_enable();
+}
+
+void mlock_drain_offline(int cpu)
 {
 	struct folio_batch *fbatch;
 
@@ -242,9 +248,12 @@ bool need_mlock_drain(int cpu)
 void mlock_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
+	int cpu;
 
-	local_lock(&mlock_fbatch.lock);
-	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
+	migrate_disable();
+	cpu = smp_processor_id();
+	qpw_lock(&mlock_fbatch.lock, cpu);
+	fbatch = per_cpu_ptr(&mlock_fbatch.fbatch, cpu);
 
 	if (!folio_test_set_mlocked(folio)) {
 		int nr_pages = folio_nr_pages(folio);
@@ -257,7 +266,8 @@ void mlock_folio(struct folio *folio)
 	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
-	local_unlock(&mlock_fbatch.lock);
+	qpw_unlock(&mlock_fbatch.lock, cpu);
+	migrate_enable();
 }
 
 /**
@@ -268,9 +278,13 @@ void mlock_new_folio(struct folio *folio
 {
 	struct folio_batch *fbatch;
 	int nr_pages = folio_nr_pages(folio);
+	int cpu;
+
+	migrate_disable();
+	cpu = smp_processor_id();
+	qpw_lock(&mlock_fbatch.lock, cpu);
 
-	local_lock(&mlock_fbatch.lock);
-	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
+	fbatch = per_cpu_ptr(&mlock_fbatch.fbatch, cpu);
 	folio_set_mlocked(folio);
 
 	zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
@@ -280,7 +294,8 @@ void mlock_new_folio(struct folio *folio
 	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
-	local_unlock(&mlock_fbatch.lock);
+	migrate_enable();
+	qpw_unlock(&mlock_fbatch.lock, cpu);
 }
 
 /**
@@ -290,9 +305,13 @@ void mlock_new_folio(struct folio *folio
 void munlock_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
+	int cpu;
 
-	local_lock(&mlock_fbatch.lock);
-	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
+	migrate_disable();
+	cpu = smp_processor_id();
+	qpw_lock(&mlock_fbatch.lock, cpu);
+
+	fbatch = per_cpu_ptr(&mlock_fbatch.fbatch, cpu);
 	/*
 	 * folio_test_clear_mlocked(folio) must be left to __munlock_folio(),
 	 * which will check whether the folio is multiply mlocked.
@@ -301,7 +320,8 @@ void munlock_folio(struct folio *folio)
 	if (!folio_batch_add(fbatch, folio) ||
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
-	local_unlock(&mlock_fbatch.lock);
+	qpw_unlock(&mlock_fbatch.lock, cpu);
+	migrate_enable();
 }
 
 static inline unsigned int folio_mlock_step(struct folio *folio,
@@ -823,3 +843,18 @@ void user_shm_unlock(size_t size, struct
 	spin_unlock(&shmlock_user_lock);
 	put_ucounts(ucounts);
 }
+
+int __init mlock_init(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct mlock_fbatch *fbatch = &per_cpu(mlock_fbatch, cpu);
+
+		qpw_lock_init(&fbatch->lock);
+	}
+
+	return 0;
+}
+
+module_init(mlock_init);
Index: slab/mm/swap.c
===================================================================
--- slab.orig/mm/swap.c
+++ slab/mm/swap.c
@@ -35,7 +35,7 @@
 #include <linux/uio.h>
 #include <linux/hugetlb.h>
 #include <linux/page_idle.h>
-#include <linux/local_lock.h>
+#include <linux/qpw.h>
 #include <linux/buffer_head.h>
 
 #include "internal.h"
@@ -52,7 +52,7 @@ struct cpu_fbatches {
 	 * The following folio batches are grouped together because they are protected
 	 * by disabling preemption (and interrupts remain enabled).
 	 */
-	local_lock_t lock;
+	qpw_lock_t lock;
 	struct folio_batch lru_add;
 	struct folio_batch lru_deactivate_file;
 	struct folio_batch lru_deactivate;
@@ -61,14 +61,11 @@ struct cpu_fbatches {
 	struct folio_batch lru_activate;
 #endif
 	/* Protecting the following batches which require disabling interrupts */
-	local_lock_t lock_irq;
+	qpw_lock_t lock_irq;
 	struct folio_batch lru_move_tail;
 };
 
-static DEFINE_PER_CPU(struct cpu_fbatches, cpu_fbatches) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-	.lock_irq = INIT_LOCAL_LOCK(lock_irq),
-};
+static DEFINE_PER_CPU(struct cpu_fbatches, cpu_fbatches);
 
 static void __page_cache_release(struct folio *folio, struct lruvec **lruvecp,
 		unsigned long *flagsp)
@@ -183,22 +180,24 @@ static void __folio_batch_add_and_move(s
 		struct folio *folio, move_fn_t move_fn, bool disable_irq)
 {
 	unsigned long flags;
+	int cpu;
 
 	folio_get(folio);
 
+	cpu = smp_processor_id();
 	if (disable_irq)
-		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
+		qpw_lock_irqsave(&cpu_fbatches.lock_irq, flags, cpu);
 	else
-		local_lock(&cpu_fbatches.lock);
+		qpw_lock(&cpu_fbatches.lock, cpu);
 
-	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
+	if (!folio_batch_add(per_cpu_ptr(fbatch, cpu), folio) ||
 			!folio_may_be_lru_cached(folio) || lru_cache_disabled())
-		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
+		folio_batch_move_lru(per_cpu_ptr(fbatch, cpu), move_fn);
 
 	if (disable_irq)
-		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
+		qpw_unlock_irqrestore(&cpu_fbatches.lock_irq, flags, cpu);
 	else
-		local_unlock(&cpu_fbatches.lock);
+		qpw_unlock(&cpu_fbatches.lock, cpu);
 }
 
 #define folio_batch_add_and_move(folio, op)		\
@@ -358,9 +357,10 @@ static void __lru_cache_activate_folio(s
 {
 	struct folio_batch *fbatch;
 	int i;
+	int cpu = smp_processor_id();
 
-	local_lock(&cpu_fbatches.lock);
-	fbatch = this_cpu_ptr(&cpu_fbatches.lru_add);
+	qpw_lock(&cpu_fbatches.lock, cpu);
+	fbatch = per_cpu_ptr(&cpu_fbatches.lru_add, cpu);
 
 	/*
 	 * Search backwards on the optimistic assumption that the folio being
@@ -381,7 +381,7 @@ static void __lru_cache_activate_folio(s
 		}
 	}
 
-	local_unlock(&cpu_fbatches.lock);
+	qpw_unlock(&cpu_fbatches.lock, cpu);
 }
 
 #ifdef CONFIG_LRU_GEN
@@ -653,9 +653,9 @@ void lru_add_drain_cpu(int cpu)
 		unsigned long flags;
 
 		/* No harm done if a racing interrupt already did this */
-		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
+		qpw_lock_irqsave(&cpu_fbatches.lock_irq, flags, cpu);
 		folio_batch_move_lru(fbatch, lru_move_tail);
-		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
+		qpw_unlock_irqrestore(&cpu_fbatches.lock_irq, flags, cpu);
 	}
 
 	fbatch = &fbatches->lru_deactivate_file;
@@ -733,10 +733,12 @@ void folio_mark_lazyfree(struct folio *f
 
 void lru_add_drain(void)
 {
-	local_lock(&cpu_fbatches.lock);
-	lru_add_drain_cpu(smp_processor_id());
-	local_unlock(&cpu_fbatches.lock);
-	mlock_drain_local();
+	int cpu = smp_processor_id();
+
+	qpw_lock(&cpu_fbatches.lock, cpu);
+	lru_add_drain_cpu(cpu);
+	qpw_unlock(&cpu_fbatches.lock, cpu);
+	mlock_drain_cpu(cpu);
 }
 
 /*
@@ -745,30 +747,32 @@ void lru_add_drain(void)
  * the same cpu. It shouldn't be a problem in !SMP case since
  * the core is only one and the locks will disable preemption.
  */
-static void lru_add_mm_drain(void)
+static void lru_add_mm_drain(int cpu)
 {
-	local_lock(&cpu_fbatches.lock);
-	lru_add_drain_cpu(smp_processor_id());
-	local_unlock(&cpu_fbatches.lock);
-	mlock_drain_local();
+	qpw_lock(&cpu_fbatches.lock, cpu);
+	lru_add_drain_cpu(cpu);
+	qpw_unlock(&cpu_fbatches.lock, cpu);
+	mlock_drain_cpu(cpu);
 }
 
 void lru_add_drain_cpu_zone(struct zone *zone)
 {
-	local_lock(&cpu_fbatches.lock);
-	lru_add_drain_cpu(smp_processor_id());
+	int cpu = smp_processor_id();
+
+	qpw_lock(&cpu_fbatches.lock, cpu);
+	lru_add_drain_cpu(cpu);
 	drain_local_pages(zone);
-	local_unlock(&cpu_fbatches.lock);
-	mlock_drain_local();
+	qpw_unlock(&cpu_fbatches.lock, cpu);
+	mlock_drain_cpu(cpu);
 }
 
 #ifdef CONFIG_SMP
 
-static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
+static DEFINE_PER_CPU(struct qpw_struct, lru_add_drain_qpw);
 
-static void lru_add_drain_per_cpu(struct work_struct *dummy)
+static void lru_add_drain_per_cpu(struct work_struct *w)
 {
-	lru_add_mm_drain();
+	lru_add_mm_drain(qpw_get_cpu(w));
 }
 
 static DEFINE_PER_CPU(struct work_struct, bh_add_drain_work);
@@ -883,12 +887,12 @@ static inline void __lru_add_drain_all(b
 	cpumask_clear(&has_mm_work);
 	cpumask_clear(&has_bh_work);
 	for_each_online_cpu(cpu) {
-		struct work_struct *mm_work = &per_cpu(lru_add_drain_work, cpu);
+		struct qpw_struct *mm_qpw = &per_cpu(lru_add_drain_qpw, cpu);
 		struct work_struct *bh_work = &per_cpu(bh_add_drain_work, cpu);
 
 		if (cpu_needs_mm_drain(cpu)) {
-			INIT_WORK(mm_work, lru_add_drain_per_cpu);
-			queue_work_on(cpu, mm_percpu_wq, mm_work);
+			INIT_QPW(mm_qpw, lru_add_drain_per_cpu, cpu);
+			queue_percpu_work_on(cpu, mm_percpu_wq, mm_qpw);
 			__cpumask_set_cpu(cpu, &has_mm_work);
 		}
 
@@ -900,7 +904,7 @@ static inline void __lru_add_drain_all(b
 	}
 
 	for_each_cpu(cpu, &has_mm_work)
-		flush_work(&per_cpu(lru_add_drain_work, cpu));
+		flush_percpu_work(&per_cpu(lru_add_drain_qpw, cpu));
 
 	for_each_cpu(cpu, &has_bh_work)
 		flush_work(&per_cpu(bh_add_drain_work, cpu));
@@ -950,7 +954,7 @@ void lru_cache_disable(void)
 #ifdef CONFIG_SMP
 	__lru_add_drain_all(true);
 #else
-	lru_add_mm_drain();
+	lru_add_mm_drain(smp_processor_id());
 	invalidate_bh_lrus_cpu();
 #endif
 }
@@ -1124,6 +1128,7 @@ static const struct ctl_table swap_sysct
 void __init swap_setup(void)
 {
 	unsigned long megs = PAGES_TO_MB(totalram_pages());
+	unsigned int cpu;
 
 	/* Use a smaller cluster for small-memory machines */
 	if (megs < 16)
@@ -1136,4 +1141,11 @@ void __init swap_setup(void)
 	 */
 
 	register_sysctl_init("vm", swap_sysctl_table);
+
+	for_each_possible_cpu(cpu) {
+		struct cpu_fbatches *fbatches = &per_cpu(cpu_fbatches, cpu);
+
+		qpw_lock_init(&fbatches->lock);
+		qpw_lock_init(&fbatches->lock_irq);
+	}
 }
Index: slab/mm/internal.h
===================================================================
--- slab.orig/mm/internal.h
+++ slab/mm/internal.h
@@ -1061,10 +1061,12 @@ static inline void munlock_vma_folio(str
 		munlock_folio(folio);
 }
 
+int __init mlock_init(void);
 void mlock_new_folio(struct folio *folio);
 bool need_mlock_drain(int cpu);
 void mlock_drain_local(void);
-void mlock_drain_remote(int cpu);
+void mlock_drain_cpu(int cpu);
+void mlock_drain_offline(int cpu);
 
 extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
Index: slab/mm/page_alloc.c
===================================================================
--- slab.orig/mm/page_alloc.c
+++ slab/mm/page_alloc.c
@@ -6251,7 +6251,7 @@ static int page_alloc_cpu_dead(unsigned
 	struct zone *zone;
 
 	lru_add_drain_cpu(cpu);
-	mlock_drain_remote(cpu);
+	mlock_drain_offline(cpu);
 	drain_pages(cpu);
 
 	/*




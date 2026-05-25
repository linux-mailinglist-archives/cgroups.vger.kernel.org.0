Return-Path: <cgroups+bounces-16245-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHdUNXY/FGoXLQcAu9opvQ
	(envelope-from <cgroups+bounces-16245-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 14:24:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B765CA6EE
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 14:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAF0530315F2
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E673815F5;
	Mon, 25 May 2026 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLYw8XLH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50C37FF79
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711785; cv=none; b=sptDAyJpNmusYb38tw2LRUGPKCYJcLqtqBQCEg6YtxgoNz3d2TPkPuO6m/K1erddmRpJfaPvD0EFAFj9XycaRS0UlIvoguOzTVcRLfJ7qtXGeHdRZxWPVFdCMyxtGX5bo1NwbKWq0kKkPQpIkPR0NKYlOh9alr5CAoPqaqj2ADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711785; c=relaxed/simple;
	bh=UBB195Ozt5QE0T4ary3zwUYu4vqp88ETqIcNr3qHkjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFFr/Y8fH+SEghfY0G/QKL214PtbzJAfbVg89cqBQuOKKcPUAo9V3qMTMe18J8XfUYIC74PbeRHsnNeP4J+2XnyCzayyt6Tc4qCA7zr4hKlZqRMKxI8AeYoJLeops1mZOQegdQa14BLlO6dctSpliwFcL4aOlgSetJc6c54vNhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLYw8XLH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36900945df5so4759491a91.0
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 05:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779711784; x=1780316584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtMgcDN043IrMH4z5Dydpux33DpRRQAjJ0E9E7yR9Fo=;
        b=rLYw8XLHNNa5aV53Jeh3nr3yqZW91pi6RrJ9EoHsvjiP0EMaN+tS/rnZtZ2pdiHWN+
         +DHjmK3ib04Bko4VaGOoCR4PA2XSdQFS/8KSwPSNi7t/8xXSQnyvt5n0QKZ1pqP2za+3
         5ad8hDUUeuO3DH6AkC49ZywIK3RxducnDCPAcN+feJaHfq0FpzuF2hRxk/DPH+s4tav9
         r3/ftj+SGUSqBlusNkQwDSoiZXXt/IP8RYa8XMN6AAVkTHjuISVeZ0g1lzHgeIJ6m/kC
         Pv+wOLmcUTsrkeeD5sv3NWWXc5Pyth1BDheuWtLjsax3H5XoTfLj6kochEaoXqM4Ilph
         vikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711784; x=1780316584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QtMgcDN043IrMH4z5Dydpux33DpRRQAjJ0E9E7yR9Fo=;
        b=pZnSE8ncTi3BjxnK8x8cvKx+6/gK3f8hLF5oCrl+TaBkdY2PUVUbuYdLngvDEEuu+D
         6TmO5gkM2FbXUqqbOCqxb8NmivGbPMwvPvKfl1QAfyuB958byCR44rRcEeTsZQNF5R0f
         1gYpe2DUicZFJzijW91mUIyOM8Ik8zrxFODcKzlVa2UvVFMIBLZ+1bEEMRguj8oe0NfB
         n2XoX1GfNHS8tw6Z/vEAxdITFImz84hha+33Wh1ptmjtVvxhWUlpLhVB4S2mFf7tGC/k
         3nbhKJTjPsrIgnZhmDET8jFqnaodfHM+TrI3G6duiJqcoFubCoh4DZ+NI5llUqUIvUZP
         DPwQ==
X-Gm-Message-State: AOJu0Yzrb6rFAv2g41mEpuFlQpcIbZAaKquFJswFXiW8nmwSTaLaSNmD
	ZeZJ6sa41v0dB2ULxw2ZblK1PEj71bqzj5VzOEPa8TmIiwButFl/Jl3T
X-Gm-Gg: Acq92OGhhyK+dVQ+6sorEvtxaQeCucq2gLu8QMnj7yJ+dsUr3WS3d76f7H96SW2ifwO
	+pAIBOj+5pAX1RRgidGYa02EPQElWDVocOYv0lEWG8h62HW7h7mTtVgnrop45n4fswpcFnXd3+h
	01CV9lF/Aflnxs/PqRONc8X2Frq9mkb2EXmexdEFfzDj2gbToVTEfmuGHEP7Ih/1R2CNE5WGFFb
	SNeiI+odzPjteUiyzsKXSN3f8XGussUtW7qxvdtLXVeNURGLFa8vwS7GaaBNqouC1GgkFSieeSG
	proz1m3hJ5M0A7XiUXSX21MUZUxyI6mCHGtY9SDC+2As1/NWF+mAQE9ywdK+kM//QN64+aK/+w6
	7A0sbMw+mdnVYoaK7/C4aEFY9ceGuJPhOFWCLFRexHKps7m2u9YPYum774ccas78gbIdqkX7KFz
	qjpCHGnbqJqKtfZyE3F8SxeD437bg7hdoe9hE4UMdA87BpyAnLypjJbWSJS9o2eg==
X-Received: by 2002:a17:90a:d44f:b0:368:763a:17b8 with SMTP id 98e67ed59e1d1-36a6741dd0bmr9210428a91.2.1779711783550;
        Mon, 25 May 2026 05:23:03 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c913a1sm8999131a91.15.2026.05.25.05.22.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 May 2026 05:23:03 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: akpm@linux-foundation.org,
	tj@kernel.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	yosry@kernel.org,
	mkoutny@suse.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH v2 1/4] mm/zswap: Make shrink_worker writeback cursor per-memcg
Date: Mon, 25 May 2026 20:22:39 +0800
Message-Id: <20260525122242.36127-2-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260525122242.36127-1-jiahao.kernel@gmail.com>
References: <20260525122242.36127-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16245-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lixiang.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 75B765CA6EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hao Jia <jiahao1@lixiang.com>

The zswap background writeback worker shrink_worker() uses a global
cursor zswap_next_shrink, protected by zswap_shrink_lock, to round-robin
across the online memcgs under root_mem_cgroup.

Proactive writeback also wants a similar per-memcg cursor that is
scoped to the specified memcg, so that repeated invocations against
the same memcg make forward progress across its descendant memcgs
instead of restarting from the first child memcg each time.

Naturally, group the cursor and its protecting spinlock into a
zswap_wb_iter struct, and make it a member of struct mem_cgroup to
realize per-memcg cursor management. Accordingly, shrink_worker() now
uses the lock and cursor in root_mem_cgroup->zswap_wb_iter.

Because the cursor is now per-memcg, the offline cleanup must visit
every ancestor that could be holding a reference to the dying memcg.
Factor out __zswap_memcg_offline_cleanup() and walk from dead_memcg up
to the root.

No functional change intended for shrink_worker().

Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 include/linux/memcontrol.h |   3 +
 include/linux/zswap.h      |   9 +++
 mm/memcontrol.c            |   3 +
 mm/zswap.c                 | 119 ++++++++++++++++++++++++++-----------
 4 files changed, 98 insertions(+), 36 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index dc3fa687759b..b8323c8d6565 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -228,6 +228,9 @@ struct mem_cgroup {
 	 * swap, and from being swapped out on zswap store failures.
 	 */
 	bool zswap_writeback;
+
+	/* Per-memcg writeback cursor */
+	struct zswap_wb_iter zswap_wb_iter;
 #endif
 
 	/* vmpressure notifications */
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 30c193a1207e..efa6b551217e 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -11,6 +11,15 @@ extern atomic_long_t zswap_stored_pages;
 
 #ifdef CONFIG_ZSWAP
 
+/* Iteration cursor for zswap writeback over a memcg's subtree. */
+struct zswap_wb_iter {
+	/* protects @pos against concurrent advances */
+	spinlock_t lock;
+	struct mem_cgroup *pos;
+};
+
+void zswap_wb_iter_init(struct zswap_wb_iter *iter);
+
 struct zswap_lruvec_state {
 	/*
 	 * Number of swapped in pages from disk, i.e not found in the zswap pool.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c03d4787d466..409c41359dc8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4022,6 +4022,9 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	INIT_LIST_HEAD(&memcg->memory_peaks);
 	INIT_LIST_HEAD(&memcg->swap_peaks);
 	spin_lock_init(&memcg->peaks_lock);
+#ifdef CONFIG_ZSWAP
+	zswap_wb_iter_init(&memcg->zswap_wb_iter);
+#endif
 	memcg->socket_pressure = get_jiffies_64();
 #if BITS_PER_LONG < 64
 	seqlock_init(&memcg->socket_pressure_seqlock);
diff --git a/mm/zswap.c b/mm/zswap.c
index 4b5149173b0e..6519f646b496 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -163,9 +163,6 @@ struct zswap_pool {
 /* Global LRU lists shared by all zswap pools. */
 static struct list_lru zswap_list_lru;
 
-/* The lock protects zswap_next_shrink updates. */
-static DEFINE_SPINLOCK(zswap_shrink_lock);
-static struct mem_cgroup *zswap_next_shrink;
 static struct work_struct zswap_shrink_work;
 static struct shrinker *zswap_shrinker;
 
@@ -717,28 +714,88 @@ void zswap_folio_swapin(struct folio *folio)
 	}
 }
 
-/*
- * This function should be called when a memcg is being offlined.
+void zswap_wb_iter_init(struct zswap_wb_iter *iter)
+{
+	spin_lock_init(&iter->lock);
+}
+
+#ifdef CONFIG_MEMCG
+/**
+ * zswap_mem_cgroup_iter - advance the writeback cursor
+ * @root: subtree root whose cursor to advance
+ *
+ * Advance @root->zswap_wb_iter.pos to @root itself or the next online
+ * descendant. Passing root_mem_cgroup yields a global walk.
  *
- * Since the global shrinker shrink_worker() may hold a reference
- * of the memcg, we must check and release the reference in
- * zswap_next_shrink.
+ * The cursor is retained across invocations, so successive calls walk
+ * @root's subtree cyclically in pre-order and, after %NULL, restart
+ * from the beginning.
  *
- * shrink_worker() must handle the case where this function releases
- * the reference of memcg being shrunk.
+ * The returned memcg carries an extra reference; release it with
+ * mem_cgroup_put().
+ *
+ * Return: the next online memcg in @root's subtree, or @root itself,
+ * with an extra reference, or %NULL after a full round-trip.
  */
-void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
+static struct mem_cgroup *zswap_mem_cgroup_iter(struct mem_cgroup *root)
 {
-	/* lock out zswap shrinker walking memcg tree */
-	spin_lock(&zswap_shrink_lock);
-	if (zswap_next_shrink == memcg) {
+	struct mem_cgroup *memcg;
+
+	if (mem_cgroup_disabled())
+		return NULL;
+
+	spin_lock(&root->zswap_wb_iter.lock);
+	do {
+		memcg = mem_cgroup_iter(root, root->zswap_wb_iter.pos, NULL);
+		root->zswap_wb_iter.pos = memcg;
+	} while (memcg && !mem_cgroup_tryget_online(memcg));
+	spin_unlock(&root->zswap_wb_iter.lock);
+
+	return memcg;
+}
+
+/*
+ * If @root's cursor currently points at @dead_memcg, advance it to the
+ * next online descendant so @dead_memcg can be freed.
+ */
+static void __zswap_memcg_offline_cleanup(struct mem_cgroup *root,
+					  struct mem_cgroup *dead_memcg)
+{
+	spin_lock(&root->zswap_wb_iter.lock);
+	if (root->zswap_wb_iter.pos == dead_memcg) {
 		do {
-			zswap_next_shrink = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
-		} while (zswap_next_shrink && !mem_cgroup_online(zswap_next_shrink));
+			root->zswap_wb_iter.pos =
+				mem_cgroup_iter(root,
+						root->zswap_wb_iter.pos, NULL);
+		} while (root->zswap_wb_iter.pos &&
+			 !mem_cgroup_online(root->zswap_wb_iter.pos));
 	}
-	spin_unlock(&zswap_shrink_lock);
+	spin_unlock(&root->zswap_wb_iter.lock);
+}
+
+/*
+ * Called when a memcg is being offlined. If @memcg or any of its
+ * ancestors has a cursor pointing at @memcg, it must be advanced
+ * past @memcg before @memcg can be freed. Walk the chain and
+ * release such references.
+ */
+void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *parent = memcg;
+
+	do {
+		__zswap_memcg_offline_cleanup(parent, memcg);
+	} while ((parent = parent_mem_cgroup(parent)));
+}
+#else /* !CONFIG_MEMCG */
+static struct mem_cgroup *zswap_mem_cgroup_iter(struct mem_cgroup *root)
+{
+	return NULL;
 }
 
+void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) { }
+#endif /* CONFIG_MEMCG */
+
 /*********************************
 * zswap entry functions
 **********************************/
@@ -1328,38 +1385,28 @@ static void shrink_worker(struct work_struct *w)
 	 * - No writeback-candidate memcgs found in a memcg tree walk.
 	 * - Shrinking a writeback-candidate memcg failed.
 	 *
-	 * We save iteration cursor memcg into zswap_next_shrink,
+	 * We save the iteration cursor in root_mem_cgroup->zswap_wb_iter.pos,
 	 * which can be modified by the offline memcg cleaner
 	 * zswap_memcg_offline_cleanup().
 	 *
 	 * Since the offline cleaner is called only once, we cannot leave an
-	 * offline memcg reference in zswap_next_shrink.
+	 * offline memcg reference in root_mem_cgroup->zswap_wb_iter.pos.
 	 * We can rely on the cleaner only if we get online memcg under lock.
 	 *
 	 * If we get an offline memcg, we cannot determine if the cleaner has
 	 * already been called or will be called later. We must put back the
 	 * reference before returning from this function. Otherwise, the
-	 * offline memcg left in zswap_next_shrink will hold the reference
-	 * until the next run of shrink_worker().
+	 * offline memcg left in root_mem_cgroup->zswap_wb_iter.pos will hold
+	 * the reference until the next run of shrink_worker().
 	 */
 	do {
 		/*
-		 * Start shrinking from the next memcg after zswap_next_shrink.
-		 * When the offline cleaner has already advanced the cursor,
-		 * advancing the cursor here overlooks one memcg, but this
-		 * should be negligibly rare.
-		 *
-		 * If we get an online memcg, keep the extra reference in case
-		 * the original one obtained by mem_cgroup_iter() is dropped by
-		 * zswap_memcg_offline_cleanup() while we are shrinking the
-		 * memcg.
+		 * Start shrinking from the next memcg after
+		 * root_mem_cgroup->zswap_wb_iter.pos. When the offline cleaner
+		 * has already advanced the cursor, advancing the cursor here
+		 * overlooks one memcg, but this should be negligibly rare.
 		 */
-		spin_lock(&zswap_shrink_lock);
-		do {
-			memcg = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
-			zswap_next_shrink = memcg;
-		} while (memcg && !mem_cgroup_tryget_online(memcg));
-		spin_unlock(&zswap_shrink_lock);
+		memcg = zswap_mem_cgroup_iter(root_mem_cgroup);
 
 		if (!memcg) {
 			/*
-- 
2.34.1



Return-Path: <cgroups+bounces-15737-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPUuDH22AWr2igEAu9opvQ
	(envelope-from <cgroups+bounces-15737-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:59:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C546750C63F
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C94063039C99
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 10:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E7E3DBD74;
	Mon, 11 May 2026 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOs54a9c"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C13CFF6F
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496732; cv=none; b=BBjV0mxtM1uMmP7xUTCgOqQ59yTCoPYHlnUK9uD8cqU1Se1hK3NZuhfTrj/hl4vIAM0JcGYJddooFK3uQsw/zsjXjNaiEbRlPvnOtsisO3U8NytvNPUJ7F+YviBe9ASbGeUefEtAKTUciCGcBYuTpAkeZCYlbk2W5FsnvrG5lOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496732; c=relaxed/simple;
	bh=FyIqTq7KzjIEluRyUgLgG60I4S5apuZAqf2XLTtBDBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oGzPzWRjS0o+1Pv+oXLanQQ/ufjYhb9eHxJX4LfuDq1IVNC44GdD5vWAn0ZY4lFnLw0NaN04xp+lu3s/tomklku7dOSH5TwovvNRPUThBLvovbhhti5H/t9Fj6czaRXFKerbW8/lUhEOoEqLUEeIKbRf9avwKV7Ly7s2K2OePaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOs54a9c; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab077e3f32so19408525ad.3
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 03:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778496730; x=1779101530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtZHWbxmSq2itef1lwgRS73YF1vAkySaw+AaQooe+e0=;
        b=nOs54a9cajWZxVMtjR1BL60keAekpVs5vXqXHwaFJU2UWmXQ+GnfIDcMGNhnuXAzoP
         8uR/QsZ9g4JCM1CTaM3QmE92Ffm7C6xsAg0I9dFxrgcAn7AJXGWOp6lDuPH90JKflxXN
         Af/Exfye5sCb2y7Pu3vnGio2vk6Mk+KJGWLR0yIKgjSqO75w6aB4cLd/3h/ImO70Ne9u
         iH6WAn6AU2P8hFdFHGhxfYKuNz/OoXSfIavN4RZ3YJv4P+dQRKmLwfwrl3A4ealJV3w+
         xMPqkIO+mqqn5gLJdefPcOsO5C9xvTuLTucB2Xy5Z28LU6OPEx1TgmMw7aWt0ooexQKa
         LVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496730; x=1779101530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XtZHWbxmSq2itef1lwgRS73YF1vAkySaw+AaQooe+e0=;
        b=KHB3AeMvrTUzzJ1zDVzCpGTH9tdrVpegocmfGgMiCrI3D7MyY0g0MhGcA1V3WS8vAv
         nrVf3XkXQB9A3hU1ps32kDKPlzwJGkwUAno4lBQgZIGJgN2YBnsxUTClakr02TVQoLVF
         ZNo+HSIjxpUMtBvFYg++4TUCF5Yaf9K1RNFEAWyhXId4yYHWrw87+NskolF8KgfZZfTT
         BCfNs0KKDu5qN7kf8BRwhz+cj35tF7kfXMUOwlKVykbRgFKWRC2ipvKk66Ewy79yssml
         LfmBbhpo/z2fTj7Mwq59+owZLX0m+Rs11lH+iKcWBHSAT+gswWYxv7Oyx08BW9PVAZUD
         /QEQ==
X-Gm-Message-State: AOJu0YwGv4c1VGG8M81i4QS0YhI22m98wvJBAqCTsm2r6+LxSS+MGtTo
	P7dPQJLq8aUOl9OH21DfnpDnclkVao+Nkyp+yheIbfZaKyYLRSMzLuCC
X-Gm-Gg: Acq92OGnWWBiD3xaN906XdmhCuKoIfZErA8lYAkFcfPOIc8L2K5NjUW4eJzzf1nLmdh
	WpveW/pe7EBS7CEV4iVnA8wtkylT2K01RLFRg3o7nOonNndbJFy7Yj7+rNIgzH2p9E4x2+2MtDY
	0B9CmA0/Ks71br7eT+GJbtC0fAfYCXKVWCBB9qwwZO08mmfAIlvOB2yPAqX6ZBi84covjZBB6r9
	brGjl8Q8CLqKRJ3Z9kTbo+5+qxTRu81bKQeEQvg2S5+zWzpfUFTx4RVnl+pwlJUurli/y16gaSV
	UWknL2mYJN1Sagd1f5JNHgtX8i+J6I3IYzU6JpFR9unMHcvN4vggT0uF/jaeIX9wFbzWZoLmAZk
	LSvTapwTq20g+JQv7b95Xiy7gtnplrsrDas7gCLw+cRV/jjVsiOKTQukOAQcFhqkjd1Pp5RG/jR
	qGZIM5GdJK2xh3qpMSdqv+oK1Z/x9fIjDXU8EszwWMepRHNEGBMiRj1PSdDXEZEw==
X-Received: by 2002:a17:902:f78d:b0:2b0:606b:6fd3 with SMTP id d9443c01a7336-2ba78b30a89mr253673435ad.5.1778496729907;
        Mon, 11 May 2026 03:52:09 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d409eesm98571745ad.32.2026.05.11.03.52.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 May 2026 03:52:09 -0700 (PDT)
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
Subject: [PATCH 1/3] mm/zswap: Make shrink_worker writeback cursor per-memcg
Date: Mon, 11 May 2026 18:51:47 +0800
Message-Id: <20260511105149.75584-2-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260511105149.75584-1-jiahao.kernel@gmail.com>
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C546750C63F
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-15737-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lixiang.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Hao Jia <jiahao1@lixiang.com>

The zswap background writeback worker shrink_worker() uses a global
cursor zswap_next_shrink, protected by zswap_shrink_lock, to round-robin
across the online memcgs under root_mem_cgroup.

Proactive writeback, about to be introduced by
memory.zswap.proactive_writeback, also wants a similar per-memcg cursor
that is scoped to the specified memcg, so that repeated invocations
against the same memcg make forward progress across its descendant
memcgs instead of restarting from the first child memcg each time.

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
 include/linux/memcontrol.h |   6 ++
 include/linux/zswap.h      |   9 +++
 mm/memcontrol.c            |   3 +
 mm/zswap.c                 | 116 +++++++++++++++++++++++++------------
 4 files changed, 98 insertions(+), 36 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index dc3fa687759b..00ae646a3a15 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -228,6 +228,12 @@ struct mem_cgroup {
 	 * swap, and from being swapped out on zswap store failures.
 	 */
 	bool zswap_writeback;
+
+	/*
+	 * Per-memcg writeback cursor: root by shrink_worker, non-root by
+	 * proactive writeback.
+	 */
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
index 4b5149173b0e..19538d6f169a 100644
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
 
@@ -717,28 +714,85 @@ void zswap_folio_swapin(struct folio *folio)
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
+ *
+ * The cursor is retained across invocations, so successive calls walk
+ * @root's subtree cyclically in pre-order and, after %NULL, restart
+ * from the beginning.
  *
- * Since the global shrinker shrink_worker() may hold a reference
- * of the memcg, we must check and release the reference in
- * zswap_next_shrink.
+ * The returned memcg carries an extra reference; release it with
+ * mem_cgroup_put().
  *
- * shrink_worker() must handle the case where this function releases
- * the reference of memcg being shrunk.
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
 }
 
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
+}
+
+void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) { }
+#endif /* CONFIG_MEMCG */
+
 /*********************************
 * zswap entry functions
 **********************************/
@@ -1328,38 +1382,28 @@ static void shrink_worker(struct work_struct *w)
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



Return-Path: <cgroups+bounces-17467-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pUt2IIu1R2p2dwAAu9opvQ
	(envelope-from <cgroups+bounces-17467-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 15:13:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 703C9702B9A
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 15:13:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=AmfaWloh;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17467-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17467-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C6F83041D92
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2026 13:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825963D6465;
	Fri,  3 Jul 2026 13:06:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF77F3D47A5;
	Fri,  3 Jul 2026 13:06:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084007; cv=none; b=KGpDmn0LaeCj+F1CYN1Ol2VjZl0TJrIvWu8ECxhNQZesafz1/UB/ohMiQz4xAOCeQ9FXgSBpLL6wghZyEHwQE0UHDXTt5BXXAlj0YVxHG+F0rveGRlLlpStTy8LyTJxAxu/5WXj1KTZ7pGvYVnofOTtmU9U0a9KBBwh6d40PmB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084007; c=relaxed/simple;
	bh=HYMXmKmRFywdBFBEDnzPvhyqKw005at0RQkkl+JCZ4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJvbF6xyO4n0kcoHz7CSIwv9OEZxxDafjAWmp5xIUt8mQRmoMNFt5qacw3bgH9x7N/HvIpxiyoUyAuDrWbiwXcU5/vMhPXz9PMhWCQ4gEcubr5c1tTSsj4D4JKt0W5AS2FpbzF3aqHfeme9isnLsZTEr4qP16HuP3BHIg2yTjNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AmfaWloh; arc=none smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783084006; x=1814620006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HYMXmKmRFywdBFBEDnzPvhyqKw005at0RQkkl+JCZ4g=;
  b=AmfaWlohIc5dQdH4yhWZnq0nx6pmzY1I4RkWEmBcWawrMus28aQsj8Ue
   FfbCeKkXnn0zxky4/rZzCuWuovTT2GS3ukvczl21fagF9zf1AQrr6AMtK
   cErEVOUvdIec7W9ptlF6WeJRAH3z976Aqyb8uZiui8ctRpXnu6vMXb1Nd
   bMRdsfGoo5nLUM6Qg6BhOCsCiamprTqrAnpHnXaBbm2TKYpWS0dB9/4Co
   67Lpq2InMyQWOEEXzfTyLx62w1gA8IbcmQSE2hu6jIjLhbduqZtagu1Zi
   ez6ZsJiJlRF95TJ24LFOExC61EOcriqE3eLghE6LyHU773f3qD1ASvfN+
   w==;
X-CSE-ConnectionGUID: xqZluWd4QsS9D2toJYnW9w==
X-CSE-MsgGUID: eEgGx6c3QrqRUZLJhlmahw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83702321"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83702321"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:06:45 -0700
X-CSE-ConnectionGUID: oVhRDTIhRceQuRSmDyQa2Q==
X-CSE-MsgGUID: mkGjoBoLTnOMmn0/GrZftw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="283199584"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.245.146])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:06:40 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Natalie Vock <natalie.vock@gmx.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/6] cgroup/dmem: Add reclaim callback for lowering max below current usage
Date: Fri,  3 Jul 2026 15:05:38 +0200
Message-ID: <20260703130541.2686-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17467-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:thomas.hellstrom@linux.intel.com,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:tj@kernel.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:christian.koenig@amd.com,m:cascardo@igalia.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:dri-devel@lists.freedesktop.org,m:amd-gfx@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,igalia.com,lists.freedesktop.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.intel.com:mid,linux.intel.com:from_mime,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 703C9702B9A

Add an optional reclaim callback to struct dmem_cgroup_region. When
dmem.max is set below the current usage of a cgroup pool, the new limit
is applied immediately (so that concurrent allocations are throttled
while reclaim is in progress) and then the driver is asked to evict
memory to bring usage back below the limit.

Reclaim is attempted up to a bounded number of times. No error is
returned to userspace if usage remains above the limit after reclaim,
and a pending signal will abort the reclaim loop early. This matches
the behavior of memory.max in the memory cgroup controller.

Also honor O_NONBLOCK so that if that flag is set during the
max value write, no reclaim is initiated. The idea is to avoid
charging the reclaim cost to the writer of the max value.

v2:
- Write max before reclaim is attempted (Maarten)
- Let signals abort the reclaim without error (Maarten)
- If a new max value is written with the O_NONBLOCK flag,
  reclaim is not attempted (Maarten)
- Extract region from the pool parameter rather than
  passing it explicitly to set_resource_xxx().

v3:
- Use an rw_semaphore (unregister_sem) to protect reclaim callbacks
  against concurrent region unregistration: readers (reclaim) hold the
  read side; dmem_cgroup_unregister_region() takes the write side to
  drain in-flight callbacks before returning. (Sashiko-bot)

v5:
- Rebased on the introduction of struct dmem_cgroup_init.
- Use nonblock=true in reset_all_resource_limits() to avoid sleeping
  inside rcu_read_lock() in dmemcs_offline(). (Sashiko-bot)
- Compare usage against the truncated limit value stored in cnt.max,
  not the original u64. (Sashiko-bot)
- Use a DMEM_MAX_RECLAIM_RETRIES (16) retry budget instead of 5, matching
  the memcg controller's MAX_RECLAIM_RETRIES. Only -ENOSPC (no progress)
  counts against the retry budget; other errors terminate the loop
  immediately.

v6:
- Fix dmem_cgroup_ops->reclaim docstring: -ENOSPC does not stop reclaim
  immediately but is retried up to DMEM_MAX_RECLAIM_RETRIES times; only
  other negative errors terminate the loop. (Sashiko-bot)

v7:
- Replace the per-region rw_semaphore with a static SRCU domain
  (dmemcg_srcu). SRCU is a better fit than rwsem for this use: it
  avoids the per-region lock overhead on every reclaim call, and
  synchronize_srcu() at unregister time is a rare operation. (Maarten)
- Trim in-function comments to focus on what rather than how.

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/linux/cgroup_dmem.h | 22 ++++++++++
 kernel/cgroup/dmem.c        | 81 +++++++++++++++++++++++++++++++------
 2 files changed, 91 insertions(+), 12 deletions(-)

diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index d9eab8a2c1ee..8664321fa9f7 100644
--- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -14,12 +14,34 @@ struct dmem_cgroup_pool_state;
 /* Opaque definition of a cgroup region, used internally */
 struct dmem_cgroup_region;
 
+/**
+ * struct dmem_cgroup_ops - Operations for a dmem cgroup region.
+ * @reclaim: Optional callback invoked when dmem.max is set below the current
+ *           usage of a pool. The driver should attempt to free at least
+ *           @target_bytes from @pool. May be called multiple times if usage
+ *           remains above the limit after returning.
+ *
+ *           Return: 0 if some progress was made (even if less than
+ *           @target_bytes was freed), -ENOSPC if no progress could be made
+ *           (the caller will retry up to a bounded number of times), or
+ *           another negative error code if a fatal error occurred (stops
+ *           further reclaim attempts immediately).
+ */
+struct dmem_cgroup_ops {
+	int (*reclaim)(struct dmem_cgroup_pool_state *pool,
+		       u64 target_bytes, void *priv);
+};
+
 /**
  * struct dmem_cgroup_init - Initialization parameters for a dmem cgroup region.
  * @size: Size of the region in bytes.
+ * @ops: Optional operations for this region. May be NULL.
+ * @reclaim_priv: Opaque pointer passed to @ops->reclaim. May be NULL.
  */
 struct dmem_cgroup_init {
 	u64 size;
+	const struct dmem_cgroup_ops *ops;
+	void *reclaim_priv;
 };
 
 #if IS_ENABLED(CONFIG_CGROUP_DMEM)
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index d12c8543f3fe..719d28dd1078 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -17,6 +17,13 @@
 #include <linux/refcount.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
+#include <linux/srcu.h>
+
+/* Maximum reclaim attempts before giving up when lowering dmem.max. */
+#define DMEM_MAX_RECLAIM_RETRIES 16
+
+/* SRCU domain serialising reclaim callbacks against region unregistration. */
+DEFINE_STATIC_SRCU(dmemcg_srcu);
 
 struct dmem_cgroup_region {
 	/**
@@ -48,9 +55,18 @@ struct dmem_cgroup_region {
 
 	/**
 	 * @unregistered: Whether the region is unregistered by its caller.
-	 * No new pools should be added to the region afterwards.
+	 * No new pools should be added to the region afterwards, and no new
+	 * reclaim callbacks should be invoked.
 	 */
 	bool unregistered;
+
+	/**
+	 * @ops: Optional driver operations for this region.
+	 */
+	const struct dmem_cgroup_ops *ops;
+
+	/** @reclaim_priv: Private data passed to @ops->reclaim. */
+	void *reclaim_priv;
 };
 
 struct dmemcg_state {
@@ -145,21 +161,52 @@ static void free_cg_pool(struct dmem_cgroup_pool_state *pool)
 }
 
 static void
-set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
+set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val, bool nonblock)
 {
 	page_counter_set_min(&pool->cnt, val);
 }
 
 static void
-set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
+set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val, bool nonblock)
 {
 	page_counter_set_low(&pool->cnt, val);
 }
 
 static void
-set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
+set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val, bool nonblock)
 {
-	page_counter_set_max(&pool->cnt, val);
+	struct dmem_cgroup_region *region = pool->region;
+	unsigned long limit = (unsigned long)val;
+
+	/* Apply the new limit immediately so concurrent allocations are throttled. */
+	xchg(&pool->cnt.max, limit);
+
+	if (nonblock)
+		return;
+
+	int srcu_idx = srcu_read_lock(&dmemcg_srcu);
+
+	if (!READ_ONCE(region->unregistered) && region->ops && region->ops->reclaim) {
+		for (int retries = DMEM_MAX_RECLAIM_RETRIES; ; ) {
+			u64 usage = page_counter_read(&pool->cnt);
+			int ret;
+
+			if (usage <= limit)
+				break;
+
+			if (signal_pending(current))
+				break;
+
+			ret = region->ops->reclaim(pool, usage - limit, region->reclaim_priv);
+
+			/* -ENOSPC means no progress; other errors are fatal. */
+			if (ret && (ret != -ENOSPC || !retries--))
+				break;
+
+			cond_resched();
+		}
+	}
+	srcu_read_unlock(&dmemcg_srcu, srcu_idx);
 }
 
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
@@ -189,9 +236,10 @@ static u64 get_resource_peak(struct dmem_cgroup_pool_state *pool)
 
 static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
-	set_resource_min(rpool, 0);
-	set_resource_low(rpool, 0);
-	set_resource_max(rpool, PAGE_COUNTER_MAX);
+	set_resource_min(rpool, 0, false);
+	set_resource_low(rpool, 0, false);
+	/* nonblock: raising to max makes reclaim a no-op; sleeping is forbidden here. */
+	set_resource_max(rpool, PAGE_COUNTER_MAX, true);
 }
 
 static void dmemcs_offline(struct cgroup_subsys_state *css)
@@ -468,7 +516,10 @@ static void dmemcg_free_region(struct kref *ref)
  * dmem_cgroup_unregister_region() - Unregister a previously registered region.
  * @region: The region to unregister.
  *
- * This function undoes dmem_cgroup_register_region.
+ * This function undoes dmem_cgroup_register_region.  It drains any
+ * in-flight reclaim callbacks before returning, so the caller may safely
+ * free the resources pointed to by the @reclaim_priv that was passed at
+ * registration time.
  */
 void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region)
 {
@@ -493,9 +544,11 @@ void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region)
 	 * no new pools should be added to the dead region
 	 * by get_cg_pool_unlocked.
 	 */
-	region->unregistered = true;
+	WRITE_ONCE(region->unregistered, true);
 	spin_unlock(&dmemcg_lock);
 
+	synchronize_srcu(&dmemcg_srcu);
+
 	kref_put(&region->ref, dmemcg_free_region);
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_unregister_region);
@@ -537,6 +590,8 @@ dmem_cgroup_register_region(const struct dmem_cgroup_init *init,
 	INIT_LIST_HEAD(&ret->pools);
 	ret->name = region_name;
 	ret->size = init->size;
+	ret->ops = init->ops;
+	ret->reclaim_priv = init->reclaim_priv;
 	kref_init(&ret->ref);
 
 	spin_lock(&dmemcg_lock);
@@ -733,9 +788,10 @@ static int dmemcg_parse_limit(char *options, u64 *new_limit)
 
 static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off,
-				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
+				 void (*apply)(struct dmem_cgroup_pool_state *, u64, bool))
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
+	bool nonblock = of->file->f_flags & O_NONBLOCK;
 	int err = 0;
 
 	while (buf && !err) {
@@ -780,7 +836,8 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 		}
 
 		/* And commit */
-		apply(pool, new_limit);
+		apply(pool, new_limit, nonblock);
+
 		dmemcg_pool_put(pool);
 
 out_put:
-- 
2.54.0



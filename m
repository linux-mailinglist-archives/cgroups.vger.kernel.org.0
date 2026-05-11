Return-Path: <cgroups+bounces-15768-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PbUL3ISAmq+ngEAu9opvQ
	(envelope-from <cgroups+bounces-15768-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 19:31:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8EB5137EE
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 19:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06B38301B34B
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 17:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E136045348A;
	Mon, 11 May 2026 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zf0QM4mB"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CAD4508FF;
	Mon, 11 May 2026 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520658; cv=none; b=tUT9SkrEXYhRmbSSYVZ6bSTx9uDa4VQ/4KTmW26dnkJEy+pMMYhcKgd0lgsoqJtxRJHuSGbLnQqp7SewuU66V4/BrAWYtWJ4c1QDkIzNM6zl2ZV6DU18MH/8Cghz7b5Xo6/3HNY0XiYjw7tAfhn89WjR9ic5rei0scVQ5UWqMPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520658; c=relaxed/simple;
	bh=bQWecHFcBq87ss3OM4J3cujuOBJnVEKB2A85X2D8cPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiKPL7g33xyxW6LuiS6xq8YkDAc8G9x4dI5ULXZpJwCo/HI+NkvmNLi0rLWDHqR8UUj0L6wXrNTUGmIxDnij+SoK0a1tCH4UdIZY7AeZk24SMXVfc/buf8n7YC9BO+Lul6JQCgajOGoQBn99A9uUpXFo/9Zho/803cIG1gXLklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zf0QM4mB; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778520657; x=1810056657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bQWecHFcBq87ss3OM4J3cujuOBJnVEKB2A85X2D8cPQ=;
  b=Zf0QM4mBXUTy7haG26vBgKL27vnE1EwT/iIhzvrN6zwGYlrdDYt918rr
   /kSwSRjVoTVsUatR7ATvEIvXWPs6wl9RuuUj8MtSBEUzbUMoLO/PRpVJ5
   D9bV+EPDrifqoFrH/fm48+YWNdwvpd2BwbobJsORZjKwrncncrxMsTprn
   VQIqOtwY3AxFtekf3nI2GHucqgq1JyZxCPCLRtsaQb8y7/uadKuhFxifP
   q3mTqfqc9AO8r7aHGHd6+vzjD5aeVhskLHJEACWd2+p8Q9VuHL0t2C+eQ
   +Ytvzs1w9QehUKAB3sVJmmbI2nuFWAVvEst2kLyTNmhzlhBj3NHzKE93Y
   w==;
X-CSE-ConnectionGUID: RxRjXKK/TMSCCRZawa4hvg==
X-CSE-MsgGUID: 2hwJpjGlQXC/2TwBReJ+8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79314148"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79314148"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:30:49 -0700
X-CSE-ConnectionGUID: m3qXd0HlSQe47iinqetkOQ==
X-CSE-MsgGUID: 0/ieesWXQZGi4uGfltaS1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="261000363"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fedora) ([10.245.244.248])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 10:30:44 -0700
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
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] cgroup/dmem: Add reclaim callback for lowering max below current usage
Date: Mon, 11 May 2026 19:30:05 +0200
Message-ID: <20260511173008.36526-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511173008.36526-1-thomas.hellstrom@linux.intel.com>
References: <20260511173008.36526-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D8EB5137EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15768-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

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
- Use an rwsem to protect reclaim callback registration and
  region unregister against concurrent reclaim invocations,
  ensuring reclaim_priv is visible when the callback is
  invoked. (Sashiko-bot)

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/linux/cgroup_dmem.h |  24 ++++++++
 kernel/cgroup/dmem.c        | 106 +++++++++++++++++++++++++++++++++---
 2 files changed, 121 insertions(+), 9 deletions(-)

diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index dd4869f1d736..c3bce21cbe80 100644
--- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -14,6 +14,21 @@ struct dmem_cgroup_pool_state;
 /* Opaque definition of a cgroup region, used internally */
 struct dmem_cgroup_region;
 
+/**
+ * typedef dmem_cgroup_reclaim_fn_t - Reclaim callback for a dmem cgroup region.
+ * @pool: The cgroup pool that needs memory reclaimed.
+ * @target_bytes: Minimum number of bytes the driver should attempt to free.
+ * @priv: Private data registered with dmem_cgroup_region_set_reclaim().
+ *
+ * Called by the dmem cgroup controller when dmem.max is set below the current
+ * usage of @pool. The driver should evict at least @target_bytes of memory
+ * from @pool. May be called multiple times if usage remains above the limit.
+ *
+ * Return: 0 if progress was made, negative error code otherwise.
+ */
+typedef int (*dmem_cgroup_reclaim_fn_t)(struct dmem_cgroup_pool_state *pool,
+					u64 target_bytes, void *priv);
+
 #if IS_ENABLED(CONFIG_CGROUP_DMEM)
 struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size, const char *name_fmt, ...) __printf(2,3);
 void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region);
@@ -26,6 +41,9 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      bool ignore_low, bool *ret_hit_low);
 
 void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
+void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
+				    dmem_cgroup_reclaim_fn_t reclaim,
+				    void *priv);
 #else
 static inline __printf(2,3) struct dmem_cgroup_region *
 dmem_cgroup_register_region(u64 size, const char *name_fmt, ...)
@@ -62,5 +80,11 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
 { }
 
+static inline void
+dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
+			       dmem_cgroup_reclaim_fn_t reclaim,
+			       void *priv)
+{ }
+
 #endif
 #endif	/* _CGROUP_DMEM_H */
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 1ab1fb47f271..5fd5a1634d21 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -51,6 +51,20 @@ struct dmem_cgroup_region {
 	 * No new pools should be added to the region afterwards.
 	 */
 	bool unregistered;
+
+	/**
+	 * @reclaim: Optional callback invoked when dmem.max is set below the
+	 * current usage of a pool. The driver should attempt to free at least
+	 * @target_bytes from @pool. May be called multiple times if usage
+	 * remains above the limit after returning.
+	 */
+	dmem_cgroup_reclaim_fn_t reclaim;
+
+	/** @reclaim_priv: Private data passed to @reclaim. */
+	void *reclaim_priv;
+
+	/** @unregister_sem: Protect @reclaim while it is running. */
+	struct rw_semaphore unregister_sem;
 };
 
 struct dmemcg_state {
@@ -145,21 +159,58 @@ static void free_cg_pool(struct dmem_cgroup_pool_state *pool)
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
+
+	/*
+	 * Always update the limit, even if usage currently exceeds it.
+	 * Concurrent allocations will be throttled against the new limit
+	 * while reclaim is in progress.
+	 */
+	xchg(&pool->cnt.max, (unsigned long)val);
+
+	if (nonblock || !READ_ONCE(region->reclaim))
+		return;
+
+	for (int retries = 5; retries > 0; retries--) {
+		u64 usage = page_counter_read(&pool->cnt);
+		int ret;
+
+		if (usage <= val)
+			break;
+
+		if (signal_pending(current))
+			break;
+
+		/* Block unregister until the reclaim callback completes. */
+		if (down_read_interruptible(&region->unregister_sem))
+			break;
+
+		if (!region->reclaim) {
+			up_read(&region->unregister_sem);
+			break;
+		}
+
+		ret = region->reclaim(pool, usage - val, region->reclaim_priv);
+		up_read(&region->unregister_sem);
+		if (ret)
+			break;
+
+		cond_resched();
+	}
 }
 
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
@@ -184,9 +235,9 @@ static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
 
 static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
-	set_resource_min(rpool, 0);
-	set_resource_low(rpool, 0);
-	set_resource_max(rpool, PAGE_COUNTER_MAX);
+	set_resource_min(rpool, 0, false);
+	set_resource_low(rpool, 0, false);
+	set_resource_max(rpool, PAGE_COUNTER_MAX, false);
 }
 
 static void dmemcs_offline(struct cgroup_subsys_state *css)
@@ -491,6 +542,12 @@ void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region)
 	region->unregistered = true;
 	spin_unlock(&dmemcg_lock);
 
+	/* Ensure all reclaim() callbacks have finished. */
+	down_write(&region->unregister_sem);
+	/* Pairs with READ_ONCE() in set_resource_max() */
+	WRITE_ONCE(region->reclaim, NULL);
+	up_write(&region->unregister_sem);
+
 	kref_put(&region->ref, dmemcg_free_region);
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_unregister_region);
@@ -530,6 +587,7 @@ struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size, const char *fmt
 	INIT_LIST_HEAD(&ret->pools);
 	ret->name = region_name;
 	ret->size = size;
+	init_rwsem(&ret->unregister_sem);
 	kref_init(&ret->ref);
 
 	spin_lock(&dmemcg_lock);
@@ -568,6 +626,34 @@ void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_pool_state_put);
 
+/**
+ * dmem_cgroup_region_set_reclaim() - Register a reclaim callback on a region.
+ * @region: The region to register the callback for.
+ * @reclaim: Callback to invoke when dmem.max is set below current usage.
+ *           Called with the pool that needs reclaiming and the number of
+ *           bytes to free. Returns 0 on progress, negative on failure.
+ * @priv: Opaque pointer passed back to @reclaim.
+ *
+ * When dmem.max is lowered below the current usage of a cgroup pool, the
+ * dmem controller will call @reclaim with a target number of bytes to free.
+ * After @reclaim returns the controller retries setting the limit; if usage
+ * is still too high it calls @reclaim again, up to a bounded retry count.
+ */
+void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
+				    dmem_cgroup_reclaim_fn_t reclaim,
+				    void *priv)
+{
+	if (!region)
+		return;
+
+	down_write(&region->unregister_sem);
+	region->reclaim_priv = priv;
+	/* Pairs with READ_ONCE() in set_resource_max() */
+	WRITE_ONCE(region->reclaim, reclaim);
+	up_write(&region->unregister_sem);
+}
+EXPORT_SYMBOL_GPL(dmem_cgroup_region_set_reclaim);
+
 static struct dmem_cgroup_pool_state *
 get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
 {
@@ -725,9 +811,10 @@ static int dmemcg_parse_limit(char *options, u64 *new_limit)
 
 static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off,
-				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
+				 void (*apply)(struct dmem_cgroup_pool_state *, u64, bool))
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
+	bool nonblock = of->file->f_flags & O_NONBLOCK;
 	int err = 0;
 
 	while (buf && !err) {
@@ -772,7 +859,8 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 		}
 
 		/* And commit */
-		apply(pool, new_limit);
+		apply(pool, new_limit, nonblock);
+
 		dmemcg_pool_put(pool);
 
 out_put:
-- 
2.54.0



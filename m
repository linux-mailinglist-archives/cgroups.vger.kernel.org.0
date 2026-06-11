Return-Path: <cgroups+bounces-16856-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MnxQNwjFKmpTwgMAu9opvQ
	(envelope-from <cgroups+bounces-16856-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 16:24:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C41672AEE
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 16:24:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=gUedNku2;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16856-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16856-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5AB60301E803
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF8411661;
	Thu, 11 Jun 2026 14:23:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1846D416CFC;
	Thu, 11 Jun 2026 14:23:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187802; cv=none; b=iMOPEVU859f0+zO+9THx7cvvyljJDrkaC/XQTLs57Ad2gG4npmLWWXxd0hjw5ow7hy0hUalXaCivuwo/va1sS2isx8os/2Fuu2Av2mckByvjA2JDu+B3Xd4eUtxWqnkdY8CgVTPLlEjdJgUYkZs7gOeSqTXQdMHZh054lvERcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187802; c=relaxed/simple;
	bh=W27qChgvDLql5BpUhT0nO9KfLhglRJ9yb9bYJIXVJn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5Y3vMWix4HwuAk1uwdVmVxHhzx8OxSmHYjJuiC9lB8hUJEgFrKf66gDSw1IV2t0u6E4Oe0Zvm+0V2KrokcJmTmfV2EkzaQdimqGRLxmT/qnSO7aU36PRFE9f4SNq3/W0TFDaqJ2DMCwUHt926WByEexPfiQKJQwV3kxPdl1flE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUedNku2; arc=none smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781187801; x=1812723801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W27qChgvDLql5BpUhT0nO9KfLhglRJ9yb9bYJIXVJn4=;
  b=gUedNku2qn7tgVyB3O3vmeqgfsKrqjStskjw+N4DXjxMFjTpi5GJW6gk
   Ej3+jpJLR9RWiv82HckLwH7HgXHJ56QCqFP96LH2POw5+vDkqogZKLhPC
   30Dpmwm/eRtDGyFRW8LAMEMJTdtvJAwBV2RZaCotapMV60iQ5ooNo40N5
   VwjzyNRNpRjhRvHNpY8udqQTiSkJ01hVc9FmM336cGIJhY9RhOT6IpIGq
   DRv+/C6nbgMU81bFI0OmKlaoj8jpRt/zuuc0XZzBYkGByOZ06Qh7ed+5J
   2Et9Vl+HXGuRQ46ObwLcVvG8s/MltC/Ee88KQeYQPNaq84zWzZJn854SJ
   A==;
X-CSE-ConnectionGUID: shGW8188SsykU7viBgnGjw==
X-CSE-MsgGUID: xJKMlxr/RYG/E53UCnMLkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81983416"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81983416"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 07:23:20 -0700
X-CSE-ConnectionGUID: 5ZA10f8qSa+9Rf+0NoD1cg==
X-CSE-MsgGUID: iEPbzckGRPKP1EuEH5EeCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="284574326"
Received: from amilburn-desk.amilburn-desk (HELO fedora) ([10.245.244.169])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 07:23:16 -0700
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
Subject: [PATCH v5 3/6] cgroup/dmem: Add reclaim callback for lowering max below current usage
Date: Thu, 11 Jun 2026 16:22:39 +0200
Message-ID: <20260611142242.2529-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611142242.2529-1-thomas.hellstrom@linux.intel.com>
References: <20260611142242.2529-1-thomas.hellstrom@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16856-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:thomas.hellstrom@linux.intel.com,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:tj@kernel.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:christian.koenig@amd.com,m:alexander.deucher@amd.com,m:rodrigo.vivi@intel.com,m:dri-devel@lists.freedesktop.org,m:amd-gfx@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:email,linux.intel.com:mid,linux.intel.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79C41672AEE

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
Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/linux/cgroup_dmem.h |  21 +++++++
 kernel/cgroup/dmem.c        | 119 +++++++++++++++++++++++++++++++++---
 2 files changed, 130 insertions(+), 10 deletions(-)

diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index d9eab8a2c1ee..d705e94d8784 100644
--- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -14,12 +14,33 @@ struct dmem_cgroup_pool_state;
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
+ *           @target_bytes was freed), -ENOSPC if no progress could be made,
+ *           or another negative error code if a fatal error occurred.
+ *           Any non-zero return stops further reclaim attempts.
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
index d12c8543f3fe..da99d133182c 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -18,6 +18,13 @@
 #include <linux/rculist.h>
 #include <linux/slab.h>
 
+/*
+ * Number of reclaim attempts before giving up when lowering dmem.max
+ * below current usage. Mirrors memcg's MAX_RECLAIM_RETRIES; unify the
+ * two in a follow-up instead of duplicating the constant.
+ */
+#define DMEM_MAX_RECLAIM_RETRIES 16
+
 struct dmem_cgroup_region {
 	/**
 	 * @ref: References keeping the region alive.
@@ -51,6 +58,24 @@ struct dmem_cgroup_region {
 	 * No new pools should be added to the region afterwards.
 	 */
 	bool unregistered;
+
+	/**
+	 * @ops: Optional operations, set from dmem_cgroup_init at registration.
+	 */
+	const struct dmem_cgroup_ops *ops;
+
+	/** @reclaim_priv: Private data passed to @ops->reclaim. */
+	void *reclaim_priv;
+
+	/**
+	 * @unregister_sem: Serialises reclaim callbacks against unregistration.
+	 *
+	 * Readers (reclaim) hold the read side for the duration of a callback
+	 * invocation.  dmem_cgroup_unregister_region() takes the write side to
+	 * drain any in-flight callbacks before returning, so callers may safely
+	 * free @reclaim_priv once unregister returns.
+	 */
+	struct rw_semaphore unregister_sem;
 };
 
 struct dmemcg_state {
@@ -145,21 +170,71 @@ static void free_cg_pool(struct dmem_cgroup_pool_state *pool)
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
+	/*
+	 * Always update the limit, even if usage currently exceeds it.
+	 * Concurrent allocations will be throttled against the new limit
+	 * while reclaim is in progress.
+	 */
+	xchg(&pool->cnt.max, limit);
+
+	if (nonblock)
+		return;
+
+	/*
+	 * Hold the read side for the duration of the reclaim loop so that
+	 * dmem_cgroup_unregister_region() cannot return (and the caller
+	 * cannot free reclaim_priv) while a callback is in progress.
+	 *
+	 * The ops check must happen inside the lock.  A caller may have
+	 * observed ops != NULL before dmem_cgroup_unregister_region()
+	 * acquired the write side; rechecking under down_read() is safe
+	 * because region->unregistered is set while the write side is
+	 * held, so any down_read() that succeeds after up_write() will
+	 * see unregistered = true and skip the loop.
+	 */
+	down_read(&region->unregister_sem);
+	if (!region->unregistered && region->ops && region->ops->reclaim) {
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
+			/*
+			 * Mirror memcg's retry strategy: only count -ENOSPC (no
+			 * progress) against the retry budget; any other error is
+			 * fatal and terminates the loop immediately.
+			 */
+			if (ret && (ret != -ENOSPC || !retries--))
+				break;
+
+			cond_resched();
+		}
+	}
+	up_read(&region->unregister_sem);
 }
 
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
@@ -189,9 +264,14 @@ static u64 get_resource_peak(struct dmem_cgroup_pool_state *pool)
 
 static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
-	set_resource_min(rpool, 0);
-	set_resource_low(rpool, 0);
-	set_resource_max(rpool, PAGE_COUNTER_MAX);
+	set_resource_min(rpool, 0, false);
+	set_resource_low(rpool, 0, false);
+	/*
+	 * Use nonblock=true: we are raising the limit to PAGE_COUNTER_MAX so
+	 * reclaim is pointless, and dmemcs_offline() holds rcu_read_lock()
+	 * which forbids sleeping.
+	 */
+	set_resource_max(rpool, PAGE_COUNTER_MAX, true);
 }
 
 static void dmemcs_offline(struct cgroup_subsys_state *css)
@@ -468,7 +548,10 @@ static void dmemcg_free_region(struct kref *ref)
  * dmem_cgroup_unregister_region() - Unregister a previously registered region.
  * @region: The region to unregister.
  *
- * This function undoes dmem_cgroup_register_region.
+ * This function undoes dmem_cgroup_register_region.  It drains any
+ * in-flight reclaim callbacks before returning, so the caller may safely
+ * free the resources pointed to by @init.reclaim_priv once this function
+ * returns.
  */
 void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region)
 {
@@ -477,6 +560,15 @@ void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region)
 	if (!region)
 		return;
 
+	/*
+	 * Acquire the write side to drain any in-flight reclaim callbacks.
+	 * After up_write() below, set_resource_max() will observe
+	 * region->unregistered = true under its own down_read() and skip
+	 * the reclaim loop, so reclaim_priv is safe to free once this
+	 * function returns.
+	 */
+	down_write(&region->unregister_sem);
+
 	spin_lock(&dmemcg_lock);
 
 	/* Remove from global region list */
@@ -496,6 +588,8 @@ void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region)
 	region->unregistered = true;
 	spin_unlock(&dmemcg_lock);
 
+	up_write(&region->unregister_sem);
+
 	kref_put(&region->ref, dmemcg_free_region);
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_unregister_region);
@@ -537,7 +631,10 @@ dmem_cgroup_register_region(const struct dmem_cgroup_init *init,
 	INIT_LIST_HEAD(&ret->pools);
 	ret->name = region_name;
 	ret->size = init->size;
+	ret->ops = init->ops;
+	ret->reclaim_priv = init->reclaim_priv;
 	kref_init(&ret->ref);
+	init_rwsem(&ret->unregister_sem);
 
 	spin_lock(&dmemcg_lock);
 	list_add_tail_rcu(&ret->region_node, &dmem_cgroup_regions);
@@ -733,9 +830,10 @@ static int dmemcg_parse_limit(char *options, u64 *new_limit)
 
 static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off,
-				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
+				 void (*apply)(struct dmem_cgroup_pool_state *, u64, bool))
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
+	bool nonblock = of->file->f_flags & O_NONBLOCK;
 	int err = 0;
 
 	while (buf && !err) {
@@ -780,7 +878,8 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 		}
 
 		/* And commit */
-		apply(pool, new_limit);
+		apply(pool, new_limit, nonblock);
+
 		dmemcg_pool_put(pool);
 
 out_put:
-- 
2.54.0



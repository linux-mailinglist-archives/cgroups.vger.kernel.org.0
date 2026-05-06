Return-Path: <cgroups+bounces-15636-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBb/A5Et+2npXAMAu9opvQ
	(envelope-from <cgroups+bounces-15636-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 14:01:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 916954D9EF7
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 14:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B6F8303266C
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B5643E4B0;
	Wed,  6 May 2026 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="N7UJOoSX"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9409D3B8BBF;
	Wed,  6 May 2026 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778068813; cv=none; b=l6KAuK4Q2ohn2UwBEOdtKSGX7xmaa0ImhzeKoTinDh7xSHfiFVs8a176eZh1gKIeXEi5cBWEQxxqOnxuDEO5z8xp8bPIek9lxk3u3sr/9MrVwNI4sHswCf7l/uIQ07QC61cCUXGJmt3s7SoUmm7+Vy/f7jONGEXf1Yu7owSK+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778068813; c=relaxed/simple;
	bh=s0iQw1nuHUf+GNr3teWrkBsxV6MwephCgs2+lAGgxMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fOn4r8EQwqIWzeLgGRfNU8OATfk5NgCCvXts4bs0ouYEcslcbWQVZBWb8J8Do+yaI7DKSgcz3SjoHu1nTL1olxW4VtXyIfsYa+LRZB7EHvYshHOS1rLSK2fM4iefxOb4BKLDgdId+5NOPAb3fBiXxT6D84tGZspJkYNtTHzSlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=N7UJOoSX; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VzPiqsNNKP8D31HnrqSylsehZjTjNsGJjks0JiVA82w=; b=N7UJOoSXgWni0eCu+o9wxTrZf6
	AxAqiL6kbPkBb2IQ++jLQV19OgJ8wRTlXztWj+Dx7a0pLObtJnwE0yjtiVer5Vd88BiY0te0LNqdO
	zKgXMDAsfiejsVOMG/L3qwiiMvqtixf5W+pC4WM858tjWZZTyx2f9dSxzeA2V9B3P9EtMXkr1T4oK
	9hD9e4YlDhbHxXcRUQ7drQjFpakooglG9HtBBXP/ssDF0pAoMkT12/+3QISFWbIGoO1mHqCOG5Xmb
	cO2ZM3/7GDO/zs6lm96IDTRgV0kU6aVFiOmCZA2ApkJ7XuZbIBCDAuLlXyR5UHsgO69hRSaj9sR7u
	6wikuVNg==;
Received: from 179-125-92-238-dinamico.pombonet.net.br ([179.125.92.238] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wKavB-006sxt-2K; Wed, 06 May 2026 14:00:08 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 06 May 2026 08:58:25 -0300
Subject: [PATCH 2/2] cgroup/dmem: introduce a peak file
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-dmem_peak-v1-2-8d803eb3449c@igalia.com>
References: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
In-Reply-To: <20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, kernel-dev@igalia.com
X-Mailer: b4 0.16-dev-62088
X-Rspamd-Queue-Id: 916954D9EF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,linux.dev,linux-foundation.org,lwn.net,linuxfoundation.org,lankhorst.se,gmx.de,igalia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15636-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Just like we have memory.peak, introduce a dmem.peak, which uses the
page_counter support for that.

It can be written to in order to reset the peak, but different from
memory.peak, which expects any write, dmem.peak expects the region name to
be written to it. That region peak is the one that is reset.

That requires ofp_peak to carry a pointer to the pool that was reset.

Writing a different region name will reset the different region and make
the original region peak get back to its non-reset value.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  10 +++
 include/linux/cgroup-defs.h             |   1 +
 kernel/cgroup/dmem.c                    | 132 ++++++++++++++++++++++++++++++--
 3 files changed, 137 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed99..3ba7ab3a36b3 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2808,6 +2808,16 @@ DMEM Interface Files
 	The semantics are the same as for the memory cgroup controller, and are
 	calculated in the same way.
 
+  dmem.peak
+	A readwrite nested-keyed file that exists on non-root cgroups.
+
+	The max memory usage recorded for the cgroup and its descendants since
+	either the creation of the cgroup or the most recent reset for that FD.
+
+	A write of a region name to this file resets it to the current memory
+	usage for subsequent reads through the same file descriptor for that
+	region.
+
   dmem.capacity
 	A read-only file that describes maximum region capacity.
 	It only exists on the root cgroup. Not all memory can be
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index a85044cb0553..b536054bd916 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -874,6 +874,7 @@ extern bool cgroup_enable_per_threadgroup_rwsem;
 struct cgroup_of_peak {
 	unsigned long		value;
 	struct list_head	list;
+	struct dmem_cgroup_pool_state *pool;
 };
 
 void of_peak_reset(struct cgroup_of_peak *ofp, struct page_counter *pc,
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 1ab1fb47f271..afa380c9839b 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -57,6 +57,9 @@ struct dmemcg_state {
 	struct cgroup_subsys_state css;
 
 	struct list_head pools;
+
+	/** @peaks_lock: Protects access to the pools' peaks lists */
+	spinlock_t peaks_lock;
 };
 
 struct dmem_cgroup_pool_state {
@@ -72,6 +75,10 @@ struct dmem_cgroup_pool_state {
 	struct rcu_head rcu;
 
 	struct page_counter cnt;
+
+	/* Protected by the dmemcg_state peaks_lock */
+	struct list_head peaks;
+
 	struct dmem_cgroup_pool_state *parent;
 
 	refcount_t ref;
@@ -162,26 +169,45 @@ set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
 	page_counter_set_max(&pool->cnt, val);
 }
 
-static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
+static u64 get_resource_low(struct seq_file *sf, struct dmem_cgroup_pool_state *pool)
 {
 	return pool ? READ_ONCE(pool->cnt.low) : 0;
 }
 
-static u64 get_resource_min(struct dmem_cgroup_pool_state *pool)
+static u64 get_resource_min(struct seq_file *sf, struct dmem_cgroup_pool_state *pool)
 {
 	return pool ? READ_ONCE(pool->cnt.min) : 0;
 }
 
-static u64 get_resource_max(struct dmem_cgroup_pool_state *pool)
+static u64 get_resource_max(struct seq_file *sf, struct dmem_cgroup_pool_state *pool)
 {
 	return pool ? READ_ONCE(pool->cnt.max) : PAGE_COUNTER_MAX;
 }
 
-static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
+static u64 get_resource_current(struct seq_file *sf, struct dmem_cgroup_pool_state *pool)
 {
 	return pool ? page_counter_read(&pool->cnt) : 0;
 }
 
+static u64 get_resource_peak(struct seq_file *sf, struct dmem_cgroup_pool_state *pool)
+{
+	struct cgroup_of_peak *ofp = of_peak(sf->private);
+	u64 fd_peak, peak;
+	struct dmem_cgroup_pool_state *of_pool;
+
+	if (!pool)
+		return 0;
+
+	of_pool = READ_ONCE(ofp->pool);
+
+	fd_peak = READ_ONCE(ofp->value);
+	if (of_pool != pool || fd_peak == OFP_PEAK_UNSET)
+		peak = pool->cnt.watermark;
+	else
+		peak = max(fd_peak, READ_ONCE(pool->cnt.local_watermark));
+	return peak;
+}
+
 static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
 	set_resource_min(rpool, 0);
@@ -227,6 +253,7 @@ dmemcs_alloc(struct cgroup_subsys_state *parent_css)
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&dmemcs->pools);
+	spin_lock_init(&dmemcs->peaks_lock);
 	return &dmemcs->css;
 }
 
@@ -377,6 +404,7 @@ alloc_pool_single(struct dmemcg_state *dmemcs, struct dmem_cgroup_region *region
 			  ppool ? &ppool->cnt : NULL, true);
 	reset_all_resource_limits(pool);
 	refcount_set(&pool->ref, 1);
+	INIT_LIST_HEAD(&pool->peaks);
 	kref_get(&region->ref);
 	if (ppool && !pool->parent) {
 		pool->parent = ppool;
@@ -784,7 +812,7 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 }
 
 static int dmemcg_limit_show(struct seq_file *sf, void *v,
-			    u64 (*fn)(struct dmem_cgroup_pool_state *))
+			    u64 (*fn)(struct seq_file *, struct dmem_cgroup_pool_state *))
 {
 	struct dmemcg_state *dmemcs = css_to_dmemcs(seq_css(sf));
 	struct dmem_cgroup_region *region;
@@ -796,7 +824,7 @@ static int dmemcg_limit_show(struct seq_file *sf, void *v,
 
 		seq_puts(sf, region->name);
 
-		val = fn(pool);
+		val = fn(sf, pool);
 		if (val < PAGE_COUNTER_MAX)
 			seq_printf(sf, " %lld\n", val);
 		else
@@ -807,6 +835,90 @@ static int dmemcg_limit_show(struct seq_file *sf, void *v,
 	return 0;
 }
 
+static int dmem_cgroup_region_peak_open(struct kernfs_open_file *of)
+{
+	struct cgroup_of_peak *ofp = of_peak(of);
+
+	ofp->value = OFP_PEAK_UNSET;
+
+	return 0;
+}
+
+static void dmem_cgroup_region_peak_remove(struct cgroup_of_peak *ofp)
+{
+	struct dmem_cgroup_pool_state *pool;
+	struct dmemcg_state *dmemcs;
+
+	pool = xchg(&ofp->pool, NULL);
+	if (!pool)
+		return;
+
+	dmemcs = pool->cs;
+
+	spin_lock(&dmemcs->peaks_lock);
+	list_del(&ofp->list);
+	spin_unlock(&dmemcs->peaks_lock);
+
+	WRITE_ONCE(ofp->value, OFP_PEAK_UNSET);
+
+	dmemcg_pool_put(pool);
+}
+
+static void dmem_cgroup_region_peak_release(struct kernfs_open_file *of)
+{
+	struct cgroup_of_peak *ofp = of_peak(of);
+
+	if (ofp->value == OFP_PEAK_UNSET) {
+		/* fast path (no writes on this fd) */
+		return;
+	}
+
+	dmem_cgroup_region_peak_remove(ofp);
+}
+
+static ssize_t dmem_cgroup_region_peak_write(struct kernfs_open_file *of,
+					     char *buf, size_t nbytes, loff_t off)
+{
+	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
+	struct cgroup_of_peak *ofp = of_peak(of);
+	struct dmem_cgroup_pool_state *pool = NULL;
+	struct dmem_cgroup_region *region;
+	int err = 0;
+
+	buf = strstrip(buf);
+	if (!buf[0])
+		return -EINVAL;
+
+	rcu_read_lock();
+	region = dmemcg_get_region_by_name(buf);
+	rcu_read_unlock();
+
+	if (!region)
+		return -EINVAL;
+
+	pool = get_cg_pool_unlocked(dmemcs, region);
+	if (IS_ERR(pool)) {
+		err = PTR_ERR(pool);
+		goto out_put;
+	}
+
+	dmem_cgroup_region_peak_remove(ofp);
+
+	xchg(&ofp->pool, pool);
+	spin_lock(&dmemcs->peaks_lock);
+	of_peak_reset(ofp, &pool->cnt, &pool->peaks);
+	spin_unlock(&dmemcs->peaks_lock);
+
+out_put:
+	kref_put(&region->ref, dmemcg_free_region);
+	return err ?: nbytes;
+}
+
+static int dmem_cgroup_region_peak_show(struct seq_file *sf, void *v)
+{
+	return dmemcg_limit_show(sf, v, get_resource_peak);
+}
+
 static int dmem_cgroup_region_current_show(struct seq_file *sf, void *v)
 {
 	return dmemcg_limit_show(sf, v, get_resource_current);
@@ -855,6 +967,14 @@ static struct cftype files[] = {
 		.name = "current",
 		.seq_show = dmem_cgroup_region_current_show,
 	},
+	{
+		.name = "peak",
+		.open = dmem_cgroup_region_peak_open,
+		.release = dmem_cgroup_region_peak_release,
+		.write = dmem_cgroup_region_peak_write,
+		.seq_show = dmem_cgroup_region_peak_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{
 		.name = "min",
 		.write = dmem_cgroup_region_min_write,

-- 
2.47.3



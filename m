Return-Path: <cgroups+bounces-14117-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCNTNYfEmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14117-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:55:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 601C816EBA8
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 203E430160DA
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C809E248F7C;
	Sun, 22 Feb 2026 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="j0HCcjWJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6662147F9
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750198; cv=none; b=bzPV2cxFav3B6h6SCc3DhsMYKe0fGJLuRCRdocZAd8KLx/oqOLzUUKlEvjViLCpz84pA/tPxjX9xvOdOIQYrK9zvrry3leltuWUesjqBY+ku+nuR40PD1WnbNkSyQ/ofEbiEQrh1k0YejJh9YWf67czwwImBQbEsmAIl5wyiluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750198; c=relaxed/simple;
	bh=BSG2lMY02dbxdPdlh1TMYKShkj9KPDKN6hRO4sQjJuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBryeMlpb0b4ceTQIPo1Lw8244KN+oVHyJK0hWMM79o5x/yaqoityYZTWkXL5aXiWkhm0o/5vR0Z8PQtmuTXlAfAJOL9F5/oyEN5uetCBPMj5L/qnuP6Uyl4xK0kXMw/qdmOuBOzCTs0qaSL6i4TkMd2znGJPibrpQa9EE/ZuLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=j0HCcjWJ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb3fb47559so322690685a.1
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750196; x=1772354996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usXNzPjhzvXJyzCooKRQ50P2LfA8iFR+qYeKDTB2vCk=;
        b=j0HCcjWJOZISGPBdaJTWKobUL1ZspGtgzo2NjlFJYkhorsy6hp9l9dwtKryGDQinmt
         rR6GQzkTXwZd1VY0hcZrhfzIhdH6ZU5K0PpIERe6leL3x42NwJeTldlQPRIVy8B4rSW/
         ivBVzM819PRObxVh4FM6Ep/JPxQRICwQu8MUnWoFWYLkG+q3T9WKmYMKuuultftGVgpk
         AkHfruT42fkVr7wppSRPpXsaeY1fx8w8g3yutelNF0YRt+OpOmORuTqzo2SvHeF+6BKE
         pechERNs+uwmDBTFJBeb9lqrzgNbd4EmPDRJ4Z7xEXzxlycFWWnDwwgitD/29Lqv1Vk1
         BOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750196; x=1772354996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=usXNzPjhzvXJyzCooKRQ50P2LfA8iFR+qYeKDTB2vCk=;
        b=QW6i829SJsGhn+sDn0JHGnNTHVo6pIcKZJ6HSiCbPkTlIplIE6p2vi+EvpWRBuYwHy
         JpnM466/f93SSKtCa6k4lpwZ2YFua6NDJYsLw36UW8mDJmrJS1CL5kbmW6agYNnbcuH0
         Gl1wKDMQhypGCmilpdcs0LmWaQNW+R5JjXGu7DlIF2UagO+I84MbMAJPI4II2WHWb+79
         fdLixVAnP/+kwT1uFUFwMOzmlvsDaTz95DA0Nj1rX4kgZgQnvJbX8/KIhrrLPKf9hFUG
         d8XJj8JTR95p1bffuMh6I8xq8XZ4G6Hc5hYOkydr+9u7jTd0UG5SgSz6Z+LBluODMGWi
         CVUw==
X-Forwarded-Encrypted: i=1; AJvYcCWKPtV7DnZYLn1thdI8di9DKrODAUfgFTYCEmKP7PXkQGdGm0fFBVtuARl2ftklxJp6NxydOrcJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxmTikMwUb/EP95yjfYR+QNZgCK7tfUSMbBpSXoh/f1RKGe8DKp
	SvL3fvABltEd1NMlcgO7Y++JxwhgQDub6P1agQ2kZfI3NGEuxD7v7jzhFTJasKeg9kI=
X-Gm-Gg: AZuq6aK4i8SxhudFLF6NZTWZXnLM5aH6vgMsR/JN+3+avngjY/pQ/uK4mehW6vuVw+z
	W0OM6kN11e0poCWgxOel1dkLZ7o/BhB2LJWl75xyHJ2T1opC/+AgefZmIO6rdKejy1AMui9eIXY
	gNpJRJohMxPTPU4Ngoy+Z6J6yFoABH1n3MWYTA/3GRpa+ohnYFgdUcZBXWWdQj/1GFQ2O/J/9hs
	/VJmDRBXutv/yg6hDsVPa/LUYrHkAmAy/JTSZcAugTvCASVA3GIfyJXYSE6rQNA7RNI73PWgEj5
	whXIbKEj8j630dLBw1fSgida0oxLrYWbhds5x+hlebxIWt9ZAofhJTTTW1tyLA4P3cdnN/how8B
	NI/bkvtQ9zveyXWRstVyNrolgs5/baHT0LsrxtoNR+zyEEs8sOnUe9PN0UgMk8QtMaW9nbbSj/N
	ZgIU1c6kJhECr3JG9IdBtPDc1JwknAYz67sp9RLdKV+4f1vOiraCGtXTObahZpW1Um6DsGEeNk8
	tG8VpafkUJmxLo=
X-Received: by 2002:a05:620a:f0d:b0:8cb:3a1d:79f2 with SMTP id af79cd13be357-8cb8ca9274fmr587644685a.71.1771750195536;
        Sun, 22 Feb 2026 00:49:55 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:54 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 16/27] mm: NP_OPS_RECLAIM - private node reclaim participation
Date: Sun, 22 Feb 2026 03:48:31 -0500
Message-ID: <20260222084842.1824063-17-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14117-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gourry.net:mid,gourry.net:dkim,gourry.net:email]
X-Rspamd-Queue-Id: 601C816EBA8
X-Rspamd-Action: no action

Private node services that drive kswapd via watermark_boost need
control over the reclaim policy.  There are three problems:

1) Boosted reclaim suppresses may_swap and may_writepage.  When
   demotion is not possible, swap is the only evict path, so kswapd
   cannot make progress and pages are stranded.

2) __setup_per_zone_wmarks() unconditionally zeros watermark_boost,
   killing the service's pressure signal.

3) Not all private nodes want reclaim to touch their pages.

Add a reclaim_policy callback to struct node_private_ops and a
struct node_reclaim_policy with:

  - active:             set by the helper when a callback was invoked
  - may_swap:           allow swap writeback during boosted reclaim
  - may_writepage:      allow writepage during boosted reclaim
  - managed_watermarks: service owns watermark_boost lifecycle

We do not allow disabling swap/writepage, as core MM may have
explicitly enabled them on a non-boosted pass.

We only allow enablign swap/writepage, so that the supression during
a boost can be overridden.  This allows a device to force evictions
even when the system otherwise would not percieve pressure.

This is important for a service like compressed RAM, as device capacity
may differ from reported capacity, and device may want to relieve real
pressure (poor compression ratio) as opposed to percieved pressure
(i.e. how many pages are in use).

Add zone_reclaim_allowed() to filter private nodes that have not
opted into reclaim.

Regular nodes fall through to cpuset_zone_allowed() unchanged.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/node_private.h | 28 ++++++++++++++++++++++++++++
 mm/internal.h                | 36 ++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c              | 11 ++++++++++-
 mm/vmscan.c                  | 25 +++++++++++++++++++++++--
 4 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 27d6e5d84e61..34be52383255 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -14,6 +14,24 @@ struct page;
 struct vm_area_struct;
 struct vm_fault;
 
+/**
+ * struct node_reclaim_policy - Reclaim policy overrides for private nodes
+ * @active: set by node_private_reclaim_policy() when a callback was invoked
+ * @may_swap: allow swap writeback during boosted reclaim
+ * @may_writepage: allow writepage during boosted reclaim
+ * @managed_watermarks: service owns watermark_boost lifecycle; kswapd must
+ *                      not clear it after boosted reclaim
+ *
+ * Passed to the reclaim_policy callback so each private node service can
+ * inject its own reclaim policy before kswapd runs boosted reclaim.
+ */
+struct node_reclaim_policy {
+	bool active;
+	bool may_swap;
+	bool may_writepage;
+	bool managed_watermarks;
+};
+
 /**
  * struct node_private_ops - Callbacks for private node services
  *
@@ -88,6 +106,13 @@ struct vm_fault;
  *
  *   Returns: vm_fault_t result (0, VM_FAULT_RETRY, etc.)
  *
+ * @reclaim_policy: Configure reclaim policy for boosted reclaim.
+ *   [called hodling rcu_read_lock, MUST NOT sleep]
+ *   Called by kswapd before boosted reclaim to let the service override
+ *   may_swap / may_writepage.  If provided, the service also owns the
+ *   watermark_boost lifecycle (kswapd will not clear it).
+ *   If NULL, normal boost policy applies.
+ *
  * @flags: Operation exclusion flags (NP_OPS_* constants).
  *
  */
@@ -101,6 +126,7 @@ struct node_private_ops {
 	void (*folio_migrate)(struct folio *src, struct folio *dst);
 	vm_fault_t (*handle_fault)(struct folio *folio, struct vm_fault *vmf,
 				   enum pgtable_level level);
+	void (*reclaim_policy)(int nid, struct node_reclaim_policy *policy);
 	unsigned long flags;
 };
 
@@ -112,6 +138,8 @@ struct node_private_ops {
 #define NP_OPS_DEMOTION			BIT(2)
 /* Prevent mprotect/NUMA from upgrading PTEs to writable on this node */
 #define NP_OPS_PROTECT_WRITE		BIT(3)
+/* Kernel reclaim (kswapd, direct reclaim, OOM) operates on this node */
+#define NP_OPS_RECLAIM			BIT(4)
 
 /**
  * struct node_private - Per-node container for N_MEMORY_PRIVATE nodes
diff --git a/mm/internal.h b/mm/internal.h
index ae4ff86e8dc6..db32cb2d7a29 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1572,6 +1572,42 @@ static inline void folio_managed_migrate_notify(struct folio *src,
 		ops->folio_migrate(src, dst);
 }
 
+/**
+ * node_private_reclaim_policy - invoke the service's reclaim policy callback
+ * @nid: NUMA node id
+ * @policy: reclaim policy struct to fill in
+ *
+ * Called by kswapd before boosted reclaim.  Zeroes @policy, then if the
+ * private node service provides a reclaim_policy callback, invokes it
+ * and sets policy->active to true.
+ */
+#ifdef CONFIG_NUMA
+static inline void node_private_reclaim_policy(int nid,
+					       struct node_reclaim_policy *policy)
+{
+	struct node_private *np;
+
+	memset(policy, 0, sizeof(*policy));
+
+	if (!node_state(nid, N_MEMORY_PRIVATE))
+		return;
+
+	rcu_read_lock();
+	np = rcu_dereference(NODE_DATA(nid)->node_private);
+	if (np && np->ops && np->ops->reclaim_policy) {
+		np->ops->reclaim_policy(nid, policy);
+		policy->active = true;
+	}
+	rcu_read_unlock();
+}
+#else
+static inline void node_private_reclaim_policy(int nid,
+					       struct node_reclaim_policy *policy)
+{
+	memset(policy, 0, sizeof(*policy));
+}
+#endif
+
 struct vm_struct *__get_vm_area_node(unsigned long size,
 				     unsigned long align, unsigned long shift,
 				     unsigned long vm_flags, unsigned long start,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e272dfdc6b00..9692048ab5fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/delayacct.h>
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
+#include <linux/node_private.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -6437,6 +6438,8 @@ static void __setup_per_zone_wmarks(void)
 	unsigned long lowmem_pages = 0;
 	struct zone *zone;
 	unsigned long flags;
+	struct node_reclaim_policy rp;
+	int prev_nid = NUMA_NO_NODE;
 
 	/* Calculate total number of !ZONE_HIGHMEM and !ZONE_MOVABLE pages */
 	for_each_zone(zone) {
@@ -6446,6 +6449,7 @@ static void __setup_per_zone_wmarks(void)
 
 	for_each_zone(zone) {
 		u64 tmp;
+		int nid = zone_to_nid(zone);
 
 		spin_lock_irqsave(&zone->lock, flags);
 		tmp = (u64)pages_min * zone_managed_pages(zone);
@@ -6482,7 +6486,12 @@ static void __setup_per_zone_wmarks(void)
 			    mult_frac(zone_managed_pages(zone),
 				      watermark_scale_factor, 10000));
 
-		zone->watermark_boost = 0;
+		if (nid != prev_nid) {
+			node_private_reclaim_policy(nid, &rp);
+			prev_nid = nid;
+		}
+		if (!rp.managed_watermarks)
+			zone->watermark_boost = 0;
 		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_HIGH] = low_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_PROMO] = high_wmark_pages(zone) + tmp;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0f534428ea88..07de666c1276 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -73,6 +73,13 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/vmscan.h>
 
+static inline bool zone_reclaim_allowed(struct zone *zone, gfp_t gfp_mask)
+{
+	if (node_state(zone_to_nid(zone), N_MEMORY_PRIVATE))
+		return zone_private_flags(zone, NP_OPS_RECLAIM);
+	return cpuset_zone_allowed(zone, gfp_mask);
+}
+
 struct scan_control {
 	/* How many pages shrink_list() should reclaim */
 	unsigned long nr_to_reclaim;
@@ -6274,7 +6281,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		 * to global LRU.
 		 */
 		if (!cgroup_reclaim(sc)) {
-			if (!cpuset_zone_allowed(zone,
+			if (!zone_reclaim_allowed(zone,
 						 GFP_KERNEL | __GFP_HARDWALL))
 				continue;
 
@@ -6992,6 +6999,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	unsigned long zone_boosts[MAX_NR_ZONES] = { 0, };
 	bool boosted;
 	struct zone *zone;
+	struct node_reclaim_policy policy;
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.order = order,
@@ -7016,6 +7024,9 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	}
 	boosted = nr_boost_reclaim;
 
+	/* Query/cache private node reclaim policy once per balance() */
+	node_private_reclaim_policy(pgdat->node_id, &policy);
+
 restart:
 	set_reclaim_active(pgdat, highest_zoneidx);
 	sc.priority = DEF_PRIORITY;
@@ -7083,6 +7094,12 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		sc.may_writepage = !laptop_mode && !nr_boost_reclaim;
 		sc.may_swap = !nr_boost_reclaim;
 
+		/* Private nodes may enable swap/writepage when using boost */
+		if (policy.active) {
+			sc.may_swap |= policy.may_swap;
+			sc.may_writepage |= policy.may_writepage;
+		}
+
 		/*
 		 * Do some background aging, to give pages a chance to be
 		 * referenced before reclaiming. All pages are rotated
@@ -7176,6 +7193,10 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 			if (!zone_boosts[i])
 				continue;
 
+			/* Some private nodes may own the\ boost lifecycle */
+			if (policy.managed_watermarks)
+				continue;
+
 			/* Increments are under the zone lock */
 			zone = pgdat->node_zones + i;
 			spin_lock_irqsave(&zone->lock, flags);
@@ -7406,7 +7427,7 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 	if (!managed_zone(zone))
 		return;
 
-	if (!cpuset_zone_allowed(zone, gfp_flags))
+	if (!zone_reclaim_allowed(zone, gfp_flags))
 		return;
 
 	pgdat = zone->zone_pgdat;
-- 
2.53.0



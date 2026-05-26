Return-Path: <cgroups+bounces-16286-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPP8H0oWFWpoSgcAu9opvQ
	(envelope-from <cgroups+bounces-16286-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:40:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BEB5D068D
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72FA730093BF
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29183988FA;
	Tue, 26 May 2026 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Je6Ijy+W"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADCE3B27CE
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779766825; cv=none; b=idu9MEAkSmrXf1lM9lgR5BDB3xsRwapA7jk0LxjKqkopa4cAL5J6wc/4bLhNTNQiIL3BMkwoDc3bJR8xpiZs5p9+Hr2SrQ5bHhTaU6BBoAxIDNtpnwG3MvILa/18P7ANwtAw05x4x54cMpEpWNMgVGWrjNhEbvKRuLYwS6A8ZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779766825; c=relaxed/simple;
	bh=wvOzrHJXCXfu+AtG3FTqF+X0QrpIulwbkMEfYzCnyUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxOHD2f3vWJF60BIfynlBpsmx4BjRpltAyHzOxjDqG0zrQ+MIRSvXuDoNmJpMfw3ftsk7EXggq1BztOfXfrZF/7tMwGOtoS2rFQtaiXB3gwX4lUMfNZsSbbJosGkpcc2ryfaNneW4RA+JCMOcy57IC50Vu5/j14hZptQDfSQDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Je6Ijy+W; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779766822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUqtonBf8W/F4/BUz1cM/qYSJHRoI6UWWhfXJV6hdNs=;
	b=Je6Ijy+WC/N5AGJ1y2KE5X+taxE9xddABSxY7PU8tcJ6CSnJ5gycwyj84UAjwTD1/8UgNc
	h153RH/3//HSjvFmIx8ymq5CESp5HLezaBmIjlyPKED9ItKRV5b0TkNdIWACGQH75pHRbL
	CpGWgrr1uMPmRVKYOjzVu0HlpPepyn4=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Harry Yoo <harry@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v3 3/4] memcg: int16_t for cached slab stats
Date: Mon, 25 May 2026 20:39:30 -0700
Message-ID: <20260526033931.1760588-4-shakeel.butt@linux.dev>
In-Reply-To: <20260526033931.1760588-1-shakeel.butt@linux.dev>
References: <20260526033931.1760588-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-16286-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 90BEB5D068D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently struct obj_stock_pcp stores cached slab stats in 'int' which
is 4 bytes per counter on 64-bit machines. Switch them to int16_t to
shrink the cached metadata.

The existing PAGE_SIZE flush in __account_obj_stock() bounds *bytes at
PAGE_SIZE on 4KiB and 16KiB page archs, well within int16_t. On 64KiB
pages PAGE_SIZE is well above S16_MAX so that flush never fires, and a
sufficiently long run of accumulations would overflow the cache. Add
an explicit S16_MAX guard before each add: when the next add would
push abs(*bytes) past S16_MAX, fold the cached value into @nr and
flush directly via mod_objcg_mlstate() before the accumulation.

Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
Tested-by: kernel test robot <oliver.sang@intel.com>
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes since v2:
- Simplify code based on David Laight's suggestion.
- Collected tags

Changes since v1:
- Collected tags

 mm/memcontrol.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index be82e52c7999..fbe0e9915daa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2035,8 +2035,8 @@ struct obj_stock_pcp {
 	struct obj_cgroup *cached_objcg;
 	obj_stock_bytes_t nr_bytes;
 	int16_t node_id;
-	int nr_slab_reclaimable_b;
-	int nr_slab_unreclaimable_b;
+	int16_t nr_slab_reclaimable_b;
+	int16_t nr_slab_unreclaimable_b;
 
 	struct work_struct work;
 	unsigned long flags;
@@ -3173,7 +3173,7 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 				struct obj_stock_pcp *stock, int nr,
 				struct pglist_data *pgdat, enum node_stat_item idx)
 {
-	int *bytes;
+	int16_t *bytes;
 
 	/*
 	 * Though at the moment MAX_NUMNODES <= 1024 in all archs but let's make
@@ -3210,21 +3210,20 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 
 	bytes = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
 					       : &stock->nr_slab_unreclaimable_b;
+
 	/*
-	 * Even for large object >= PAGE_SIZE, the vmstat data will still be
-	 * cached locally at least once before pushing it out.
+	 * Fold @nr into the cached value and decide whether to keep it cached
+	 * or flush it directly. Cache the combined value when it fits in the
+	 * int16_t storage and either the cache was empty (so even a value
+	 * above PAGE_SIZE gets a chance to be canceled by a paired delta) or
+	 * the combined value is within the PAGE_SIZE flush threshold.
 	 */
-	if (!*bytes) {
+	nr += *bytes;
+	if (abs(nr) <= S16_MAX && (!*bytes || abs(nr) <= PAGE_SIZE)) {
 		*bytes = nr;
 		nr = 0;
 	} else {
-		*bytes += nr;
-		if (abs(*bytes) > PAGE_SIZE) {
-			nr = *bytes;
-			*bytes = 0;
-		} else {
-			nr = 0;
-		}
+		*bytes = 0;
 	}
 direct:
 	if (nr)
-- 
2.53.0-Meta



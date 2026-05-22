Return-Path: <cgroups+bounces-16188-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMuEOLyvD2rmOgYAu9opvQ
	(envelope-from <cgroups+bounces-16188-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 03:22:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4172F5ADA5A
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 03:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33C2F302D0A2
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3991288C2C;
	Fri, 22 May 2026 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jy/r4gRI"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2E123E33D
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779412816; cv=none; b=ieOB3sD8ppu5GGnrQ9YfNHcz+cGWe241keSPCjc/hNV6+EnBp2+wuqdJLeisyFAneWIXsyXXPsW2DnbhetSyqUXFWqr8iDDmQLbMfqsIgXtHq+1EigWWTNoo68i7c0Fyb+A29PmVZukt0Z0oMJVLFAaAE8yrWVeTiMTEqc/08bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779412816; c=relaxed/simple;
	bh=vJDjCztTbemGieM7E9AKDabvaixnTahDNI3PCkVOjzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5j3IgRNjqjyDuCrGo2SLsHPSEkLGl+4JdhqZvxvjXsiqrYGSTsj3G4nFUt1zxkJQQT86Uhwgv3C+EDB8bPilhDcpshMTM/trM5ncT72497P269VYfKAQvjiHVIMgp2UrxBvU7eIJSwSr/Eyl7KKabRNBxD9RbM+d01oE23kN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jy/r4gRI; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779412813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHNkZOw2UW3I07VSJDEzsPCBLxzvWAd9K3Bgudx7KQM=;
	b=jy/r4gRIe+INC0fMlfJlaVAV5x+Nb+kKW1ZjbpReCKKEkZqCimx5YRDWT3Q3+hCVkcV9UX
	2YgRNKrwM6EBzzzk6gUti1L+SEw9QMo2ynp9MTl9SL4EgNljClhgVgTeceWaHS2AmnOZWe
	xndOWTYnRO2WY7oCNwoD4m2/fxcPkao=
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
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 3/4] memcg: int16_t for cached slab stats
Date: Thu, 21 May 2026 18:19:07 -0700
Message-ID: <20260522011908.1669332-4-shakeel.butt@linux.dev>
In-Reply-To: <20260522011908.1669332-1-shakeel.butt@linux.dev>
References: <20260522011908.1669332-1-shakeel.butt@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-16188-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4172F5ADA5A
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
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
---

Changes since v2:
- Collected tags

 mm/memcontrol.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e4f00a8159d5..78c02451312b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2022,8 +2022,8 @@ struct obj_stock_pcp {
 	struct obj_cgroup *cached_objcg;
 	uint16_t nr_bytes;
 	int16_t node_id;
-	int nr_slab_reclaimable_b;
-	int nr_slab_unreclaimable_b;
+	int16_t nr_slab_reclaimable_b;
+	int16_t nr_slab_unreclaimable_b;
 
 	struct work_struct work;
 	unsigned long flags;
@@ -3158,7 +3158,7 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 				struct obj_stock_pcp *stock, int nr,
 				struct pglist_data *pgdat, enum node_stat_item idx)
 {
-	int *bytes;
+	int16_t *bytes;
 
 	/*
 	 * Though at the moment MAX_NUMNODES <= 1024 in all archs but let's make
@@ -3195,6 +3195,16 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 
 	bytes = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
 					       : &stock->nr_slab_unreclaimable_b;
+	/*
+	 * To avoid overflow or underflow, flush directly if accumulating @nr
+	 * would push the cached value past S16_MAX.
+	 */
+	if (abs(nr + *bytes) > S16_MAX) {
+		nr += *bytes;
+		*bytes = 0;
+		goto direct;
+	}
+
 	/*
 	 * Even for large object >= PAGE_SIZE, the vmstat data will still be
 	 * cached locally at least once before pushing it out.
-- 
2.53.0-Meta



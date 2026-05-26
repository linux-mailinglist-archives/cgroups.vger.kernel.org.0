Return-Path: <cgroups+bounces-16285-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGiQKjQWFWpoSgcAu9opvQ
	(envelope-from <cgroups+bounces-16285-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:40:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B996F5D067E
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9009300292B
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC433B583D;
	Tue, 26 May 2026 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fEU5/DyU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C379383C94
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 03:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779766818; cv=none; b=FZQwt7OAaP8Q6s6zcWfwUIK3C/eeFytqG4ECseBGix8H553o08xhDphusQf3YYgSR0RxuLRkxF4HPAOrkLKVbx3/VPaUluAlRJuyktT6TWZMQcZ4ydNzUWk15Q4MaxHX59giEAS9PJspZ4u1NQXGQ+SJyYz46guM/c3T8R7jfxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779766818; c=relaxed/simple;
	bh=eDnLZ0By1XW+2gfnjXc5iFcL/khyto/SzDy2j0Mt0/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUYZ7ldZUaEFMpUd79LKRVZK+9RxaLElAsJpCKJtAWRbAjVKqwJwaL73cvns0Ph85/t0oWqNFafZSkzbxPSMubZRvpsJ4jmpBDI2JlPXgyWzNcUVvr4R7MTHPnP9tXZ3Mvvy+pXGlGSZpehqHoBaJb+9djxT10L81HfeMd3u3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fEU5/DyU; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779766814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DhCjAMoSVz9odIihzeNS/7m2ssbSIYp4a1jvAvsbJjI=;
	b=fEU5/DyU6aWgLcZRzwlOoaHUpbf3wC6CXYF4Nk89wq6qtBtJD7upZ9CgEWEORch3biQASN
	EK/+xE9Ae6KPnLk45aegdJiNG33fImRIlaTzZbbk24OtpfDivoumCYqjEmQFA6rNYfssCV
	LXdhdBGcizL2+3BW8PkvPs4ul0k2vYY=
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
Subject: [PATCH v3 2/4] memcg: uint16_t for nr_bytes in obj_stock_pcp
Date: Mon, 25 May 2026 20:39:29 -0700
Message-ID: <20260526033931.1760588-3-shakeel.butt@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-16285-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: B996F5D067E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently struct obj_stock_pcp stores nr_bytes in an 'unsigned int'
which is 4 bytes on 64-bit machines. Switch the field to uint16_t to
shrink the per-CPU cache.

The kernel supports PAGE_SIZE_4KB, _8KB, _16KB, _32KB, _64KB and
_256KB (see HAVE_PAGE_SIZE_* in arch/Kconfig). After the
PAGE_SIZE-aligned flush in __refill_obj_stock(), the sub-page
remainder fits in uint16_t up through 64KiB pages where PAGE_SIZE - 1
== U16_MAX, but on 256KiB pages PAGE_SIZE - 1 == 0x3FFFF exceeds
U16_MAX. The accumulator also needs to stay within uint16_t between
page-aligned flushes on 64KiB pages where PAGE_SIZE itself is
U16_MAX + 1.

Accumulate the new total in an 'unsigned int' local, then on
PAGE_SHIFT <= 16 flush whenever the accumulator would hit U16_MAX;
together with the existing allow_uncharge flush at PAGE_SIZE this
keeps the uint16_t safe.

On configs with PAGE_SHIFT > 16 (PAGE_SIZE_256KB on hexagon and
powerpc 44x, both 32-bit), uint16_t cannot represent the sub-page
remainder. Define obj_stock_bytes_t as 'unsigned int' on those
archs so nr_bytes can hold the full remainder and the normal
page-boundary flush in __refill_obj_stock() and the page extraction
in drain_obj_stock() both work correctly.

The single-cache-line layout target only applies to PAGE_SHIFT <= 16;
those archs are 32-bit embedded and not the optimization target.

Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
Tested-by: kernel test robot <oliver.sang@intel.com>
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes since v2:
- Based on Sashiko's concern regarding archs with 256KiB base pages, added
  special handling for such arch and simplify the code overall.
- Updated commit message.
- Have kept the review tags as overall code remains same mostly. 

Changes since v1:
- Collected tags
- Rearrange fields of obj_stock_pcp (David Laight)
- Fix comparison operator (Harry)

 mm/memcontrol.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9bee9031171f..8c1b65e6da5d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2020,8 +2020,17 @@ static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
 
 struct obj_stock_pcp {
 	local_trylock_t lock;
-	unsigned int nr_bytes;
 	struct obj_cgroup *cached_objcg;
+#if PAGE_SHIFT > 16
+	/*
+	 * On rare archs with 256KiB base page size (hexagon and powerpc 44x)
+	 * keep nr_bytes to unsigned int as uint16_t cannot represent the full
+	 * sub-page remainder.
+	 */
+	unsigned int nr_bytes;
+#else
+	uint16_t nr_bytes;
+#endif
 	int16_t node_id;
 	int nr_slab_reclaimable_b;
 	int nr_slab_unreclaimable_b;
@@ -3334,6 +3343,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
 			       bool allow_uncharge)
 {
 	unsigned int nr_pages = 0;
+	unsigned int stock_nr_bytes;
 
 	if (!stock) {
 		nr_pages = nr_bytes >> PAGE_SHIFT;
@@ -3342,21 +3352,24 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
 		goto out;
 	}
 
+	stock_nr_bytes = stock->nr_bytes;
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
 		drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
-		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
+		stock_nr_bytes = atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
 		WRITE_ONCE(stock->cached_objcg, objcg);
 
 		allow_uncharge = true;	/* Allow uncharge when objcg changes */
 	}
-	stock->nr_bytes += nr_bytes;
+	stock_nr_bytes += nr_bytes;
 
-	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
-		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
-		stock->nr_bytes &= (PAGE_SIZE - 1);
+	if ((allow_uncharge && (stock_nr_bytes > PAGE_SIZE)) ||
+	    stock_nr_bytes > U16_MAX) {
+		nr_pages = stock_nr_bytes >> PAGE_SHIFT;
+		stock_nr_bytes &= (PAGE_SIZE - 1);
 	}
+	stock->nr_bytes = stock_nr_bytes;
 
 out:
 	if (nr_pages)
-- 
2.53.0-Meta



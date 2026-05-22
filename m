Return-Path: <cgroups+bounces-16187-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QANuJrGvD2rmOgYAu9opvQ
	(envelope-from <cgroups+bounces-16187-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 03:21:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B925ADA53
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 03:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC6E302AE19
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 01:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63328850D;
	Fri, 22 May 2026 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LBjWDd/H"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480B28CF5F
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779412804; cv=none; b=nszaJKI17m7H1umtwmI5qs3T1QZrjzChXpcXf+neMPhIZtk3ZOGtwGAZuvGXPsJe6lCr+EUcfC1Q54+K1SxL0piJtCgEZ+GaR94V1YUHPwiPcH665haRvhpapXLQKVeslLJ8S2VeSqqi+2DMDsbU3HvnTAEIzjusoKzc5sWVImw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779412804; c=relaxed/simple;
	bh=j3r4Q1ZbbYd2Var5WVJ3HcVYRvGRTTpGMe7MUkK5OR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ky6xIg3Cf0x+QmkFalWx4YpgILfBPMW9lIAkSDYU3T+FZ3KRrFOpibzSG9h0HCiiYqp1LrlXdW2UVbbgsYgnEH6ONaRNKNGbNMN0hgqxWvc9LB9CClvQ2nOxrqrIukVhvLK9Vmb8EHMqhSfqipYDUyRVw4bk0qng1szfdTV8ims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LBjWDd/H; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779412790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0DDjB0w4E9tMqU+JEwxbi4iz46ciqDj+g3fDXVBUs8=;
	b=LBjWDd/HeERmF6Rf8dihT6KKDeCm9NG6KIIBMxZfB69IOMazt2pX6Wn1nfoXxIAKbwbL4z
	lfv2KcxH0aceH3Bm/26jxoCn9id9qEBK1UyJ2oUDuD3LLhAQx763nh7zneCEZvHkdNufhi
	qiEAedwMNnd+OQ4XUAgQaNtBDY9ria0=
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
Subject: [PATCH v2 2/4] memcg: uint16_t for nr_bytes in obj_stock_pcp
Date: Thu, 21 May 2026 18:19:06 -0700
Message-ID: <20260522011908.1669332-3-shakeel.butt@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-16187-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 03B925ADA53
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

Accumulate the new total in an 'unsigned int' local, then:

  1. Flush whenever the accumulator would hit U16_MAX. Together with
     the existing allow_uncharge flush at PAGE_SIZE, this keeps the
     uint16_t safe on PAGE_SIZE <= 64KiB.

  2. On configs with PAGE_SHIFT > 16 (PAGE_SIZE_256KB on hexagon and
     powerpc 44x), push any sub-page remainder above U16_MAX into
     objcg->nr_charged_bytes via atomic_add before storing back, so
     the store cannot silently truncate. The PAGE_SHIFT > 16 guard
     folds the branch out at compile time on smaller page sizes.

Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
---

Changes since v1:
- Collected tags
- Rearrange fields of obj_stock_pcp (David Laight)
- Fix comparison operator (Harry)

 mm/memcontrol.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d7c162946719..e4f00a8159d5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2019,8 +2019,8 @@ static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
 
 struct obj_stock_pcp {
 	local_trylock_t lock;
-	unsigned int nr_bytes;
 	struct obj_cgroup *cached_objcg;
+	uint16_t nr_bytes;
 	int16_t node_id;
 	int nr_slab_reclaimable_b;
 	int nr_slab_unreclaimable_b;
@@ -3331,6 +3331,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
 			       bool allow_uncharge)
 {
 	unsigned int nr_pages = 0;
+	unsigned int stock_nr_bytes;
 
 	if (!stock) {
 		nr_pages = nr_bytes >> PAGE_SHIFT;
@@ -3339,21 +3340,41 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
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
+
+	/* Since stock->nr_bytes is uint16_t, don't refill >= U16_MAX */
+	if ((allow_uncharge && (stock_nr_bytes > PAGE_SIZE)) ||
+	    stock_nr_bytes > U16_MAX) {
+		nr_pages = stock_nr_bytes >> PAGE_SHIFT;
+		stock_nr_bytes &= (PAGE_SIZE - 1);
+
+		/*
+		 * On configs with PAGE_SHIFT > 16 (PAGE_SIZE_256KB on
+		 * hexagon and powerpc 44x), the sub-page remainder can
+		 * still exceed U16_MAX. Push the excess back to
+		 * objcg->nr_charged_bytes so the store into uint16_t
+		 * cannot silently truncate; folded out at compile time
+		 * on smaller page sizes.
+		 */
+		if (PAGE_SHIFT > 16 && stock_nr_bytes > U16_MAX) {
+			unsigned int kept = stock_nr_bytes & U16_MAX;
 
-	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
-		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
-		stock->nr_bytes &= (PAGE_SIZE - 1);
+			atomic_add(stock_nr_bytes - kept,
+				   &objcg->nr_charged_bytes);
+			stock_nr_bytes = kept;
+		}
 	}
+	stock->nr_bytes = stock_nr_bytes;
 
 out:
 	if (nr_pages)
-- 
2.53.0-Meta



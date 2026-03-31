Return-Path: <cgroups+bounces-15126-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJreEKuSy2nMJAYAu9opvQ
	(envelope-from <cgroups+bounces-15126-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 11:23:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 956A9366FD8
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 11:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7940D3069998
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D773ED10A;
	Tue, 31 Mar 2026 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="urNiOCnm"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA15584039
	for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948649; cv=none; b=jymMonWNozHvzOlAOC5RU3BJqp1WA8zFzA/QEHrjhU9Kv/7WutdkMUAvF0HzvWmAWy+PtZXpv5nGVMuFYufQMNY5hENuykRLPihyDMlRLixiiZD5MbxMfb3k0duXNP6ijJkXX33vntX2miSWw+lo2w93KOJPtNp551DgNR06rcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948649; c=relaxed/simple;
	bh=v+MMdLnwwUXjaZr7iC9Cg6OAA5IW91QdKR17/FuEM38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cs2VhtRIevg56zTVrmEvfwkb32MjWflNtY9W24YF6+uiVULslB9zpQUuVxtc3Mb2eKeJxCUf8ZP7NbQp07u2URAQtzs0WwvAKIECe7Quq0EgkZJJkVkCaWFf5hCWff1DpmYw5jsWggMpgEMpKBU4PpBB1aUWYYG+y0ow7bWH72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=urNiOCnm; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774948645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lp3DpxTMCR7y+PPNSc4ZSesA8X8RvD0NTh7t+I9q0Pk=;
	b=urNiOCnm2nA1ap8689/tDYlQ/VXYIFTKHVvXNCZnKlJYDDK/+GzCJ/wgrIIst/j+7thz4v
	qZwF/jJt/Ts7FFBGcQ0D/E1PcXRVpSvE2u+CjhCkZry2q8S5Gw+6ZD/8OqJ/ZG5Ho4g8v2
	GeyAxmhOMUkGUUtMZoRK47cgFHzOXRs=
From: Hui Zhu <hui.zhu@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH mm-stable v3] mm/memcontrol: batch memcg charging in __memcg_slab_post_alloc_hook
Date: Tue, 31 Mar 2026 17:17:07 +0800
Message-ID: <20260331091707.226786-1-hui.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15126-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 956A9366FD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hui Zhu <zhuhui@kylinos.cn>

When kmem_cache_alloc_bulk() allocates multiple objects, the post-alloc
hook __memcg_slab_post_alloc_hook() previously charged memcg one object
at a time, even though consecutive objects may reside on slabs backed by
the same pgdat node.

Batch the memcg charging by scanning ahead from the current position to
find a contiguous run of objects whose slabs share the same pgdat, then
issue a single __obj_cgroup_charge() / __consume_obj_stock() call for
the entire run. The per-object obj_ext assignment loop is preserved as-is
since it cannot be further collapsed.

This implements the TODO comment left in commit bc730030f956 ("memcg:
combine slab obj stock charging and accounting").

The existing error-recovery contract is unchanged: if size == 1 then
memcg_alloc_abort_single() will free the sole object, and for larger
bulk allocations kmem_cache_free_bulk() will uncharge any objects that
were already charged before the failure.

Benchmark using kmem_cache_alloc_bulk() with SLAB_ACCOUNT
(iters=100000):

  bulk=32  before: 215 ns/object   after: 174 ns/object  (-19%)
  bulk=1   before: 344 ns/object   after: 335 ns/object  (  ~)

No measurable regression for bulk=1, as expected.

Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---

Changelog:
v3:
Update base from "mm-unstable" to "mm-stable".
v2:
According to the comments in [1], add code to handle the integer
overflow issue.

[1] https://sashiko.dev/#/patchset/20260316084839.1342163-1-hui.zhu%40linux.dev

 mm/memcontrol.c | 77 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 051b82ebf371..3159bf39e060 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3277,51 +3277,90 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 			return false;
 	}
 
-	for (i = 0; i < size; i++) {
+	for (i = 0; i < size; ) {
 		unsigned long obj_exts;
 		struct slabobj_ext *obj_ext;
 		struct obj_stock_pcp *stock;
+		struct pglist_data *pgdat;
+		int batch_bytes;
+		size_t run_len = 0;
+		size_t j;
+		size_t max_size;
+		bool skip_next = false;
 
 		slab = virt_to_slab(p[i]);
 
 		if (!slab_obj_exts(slab) &&
 		    alloc_slab_obj_exts(slab, s, flags, false)) {
+			i++;
 			continue;
 		}
 
+		pgdat = slab_pgdat(slab);
+		run_len = 1;
+
+		/*
+		 * The value of batch_bytes must not exceed
+		 * (INT_MAX - PAGE_SIZE) to prevent integer overflow in
+		 * the final accumulation performed by __account_obj_stock().
+		 */
+		max_size = min((size_t)((INT_MAX - PAGE_SIZE) / obj_size),
+			       size);
+
+		for (j = i + 1; j < max_size; j++) {
+			struct slab *slab_j = virt_to_slab(p[j]);
+
+			if (slab_pgdat(slab_j) != pgdat)
+				break;
+
+			if (!slab_obj_exts(slab_j) &&
+			    alloc_slab_obj_exts(slab_j, s, flags, false)) {
+				skip_next = true;
+				break;
+			}
+
+			run_len++;
+		}
+
 		/*
-		 * if we fail and size is 1, memcg_alloc_abort_single() will
+		 * If we fail and size is 1, memcg_alloc_abort_single() will
 		 * just free the object, which is ok as we have not assigned
-		 * objcg to its obj_ext yet
-		 *
-		 * for larger sizes, kmem_cache_free_bulk() will uncharge
-		 * any objects that were already charged and obj_ext assigned
+		 * objcg to its obj_ext yet.
 		 *
-		 * TODO: we could batch this until slab_pgdat(slab) changes
-		 * between iterations, with a more complicated undo
+		 * For larger sizes, kmem_cache_free_bulk() will uncharge
+		 * any objects that were already charged and obj_ext assigned.
 		 */
+		batch_bytes = obj_size * run_len;
 		stock = trylock_stock();
-		if (!stock || !__consume_obj_stock(objcg, stock, obj_size)) {
+		if (!stock || !__consume_obj_stock(objcg, stock, batch_bytes)) {
 			size_t remainder;
 
 			unlock_stock(stock);
-			if (__obj_cgroup_charge(objcg, flags, obj_size, &remainder))
+			if (__obj_cgroup_charge(objcg, flags, batch_bytes, &remainder))
 				return false;
 			stock = trylock_stock();
 			if (remainder)
 				__refill_obj_stock(objcg, stock, remainder, false);
 		}
-		__account_obj_stock(objcg, stock, obj_size,
-				    slab_pgdat(slab), cache_vmstat_idx(s));
+		__account_obj_stock(objcg, stock, batch_bytes,
+				    pgdat, cache_vmstat_idx(s));
 		unlock_stock(stock);
 
-		obj_exts = slab_obj_exts(slab);
-		get_slab_obj_exts(obj_exts);
-		off = obj_to_index(s, slab, p[i]);
-		obj_ext = slab_obj_ext(slab, obj_exts, off);
-		obj_cgroup_get(objcg);
-		obj_ext->objcg = objcg;
-		put_slab_obj_exts(obj_exts);
+		for (j = 0; j < run_len; j++) {
+			slab = virt_to_slab(p[i + j]);
+			obj_exts = slab_obj_exts(slab);
+			get_slab_obj_exts(obj_exts);
+			off = obj_to_index(s, slab, p[i + j]);
+			obj_ext = slab_obj_ext(slab, obj_exts, off);
+			obj_cgroup_get(objcg);
+			obj_ext->objcg = objcg;
+			put_slab_obj_exts(obj_exts);
+		}
+
+		if (skip_next)
+			i = i + run_len + 1;
+		else
+			i += run_len;
 	}
 
 	return true;
-- 
2.43.0



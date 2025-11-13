Return-Path: <cgroups+bounces-11898-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EEBC54E09
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 01:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF0E3B4D6C
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 00:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796942110;
	Thu, 13 Nov 2025 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BeG5DlQv"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891C17D2
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992586; cv=none; b=gkRDfaCtS+hydUT6iPoalUv8753VD4555A+vvMv8+pGTLzNE2OAPZuFDWmiYdzB905j8U2PWv0QRkLoRkIV4UE+uz1c92qiAY6C+IFW8YoTUKqnn21pRfbT0T0NfEKZOJ3SzsQDw0vyoEn3GnVrq7+sWdUUzqM6CMgH7lWNEoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992586; c=relaxed/simple;
	bh=GS3zXq0GptIhdpJ09QBFE5N/O2z8PYkSDIO98VYL7bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/YOWAFsBepwzKg5nZRiiGcsW/tRFB125X1ICFVW5lIW2mOIWxqJg8bZn9IWMlMiua60Rwc8f+7/vfWnuxXlwK2lrm26XRt7JXM1/N6WHY1zrW6hrSJr2Ce5eGZYt561vcaox2e6T0ASMCW3CxpVuojaFI+6zoaguiQuxAncS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BeG5DlQv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=PxZkdsw3AvExa2s+lE/wpoYA3pnAzbSC5CA5PV/sp7E=; b=BeG5DlQvLMsI8zTq7f/ymzTUTo
	RXI366pSGQdULy0UCAI0at39JngyFgeOoXKLARXJgugslliJjiH+0ZIAhWbN1G1nirv29no66lzSe
	fm8zQXKEhHuQnWogDO7THGgMZbxkC5hDGUvtY+ACKU9h8z3ZJ77P1XfA5S5xg/Rwld0n4HUdWJcf8
	HPVJtwCJm53cizrhHEVKrDPdXdE5MG651Jkt6xSaJAidBeRVNgo1B5GIbsXrKDzxsqQILGV9Vyqff
	1OF9rr7QZfPMfDHaTdZOVPC5N5ShfTOHITMZ+VWtXZWy3zTxiArUSlrEkDnPBJ/E8DGdUJrsUeq7h
	wFAXBUqA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJKu7-00000006fPH-3R1L;
	Thu, 13 Nov 2025 00:09:35 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org
Subject: [PATCH v4 14/16] memcg: Convert mem_cgroup_from_obj_folio() to mem_cgroup_from_obj_slab()
Date: Thu, 13 Nov 2025 00:09:28 +0000
Message-ID: <20251113000932.1589073-15-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113000932.1589073-1-willy@infradead.org>
References: <20251113000932.1589073-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for splitting struct slab from struct page and struct
folio, convert the pointer to a slab rather than a folio.  This means
we can end up passing a NULL slab pointer to mem_cgroup_from_obj_slab()
if the pointer is not to a page allocated to slab, and we handle that
appropriately by returning NULL.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org
---
 mm/memcontrol.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 025da46d9959..b239d8ad511a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2589,38 +2589,28 @@ static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
 }
 
 static __always_inline
-struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
+struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 {
 	/*
 	 * Slab objects are accounted individually, not per-page.
 	 * Memcg membership data for each individual object is saved in
 	 * slab->obj_exts.
 	 */
-	if (folio_test_slab(folio)) {
-		struct slabobj_ext *obj_exts;
-		struct slab *slab;
-		unsigned int off;
-
-		slab = folio_slab(folio);
-		obj_exts = slab_obj_exts(slab);
-		if (!obj_exts)
-			return NULL;
+	struct slabobj_ext *obj_exts;
+	unsigned int off;
 
-		off = obj_to_index(slab->slab_cache, slab, p);
-		if (obj_exts[off].objcg)
-			return obj_cgroup_memcg(obj_exts[off].objcg);
+	if (!slab)
+		return NULL;
 
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
 		return NULL;
-	}
 
-	/*
-	 * folio_memcg_check() is used here, because in theory we can encounter
-	 * a folio where the slab flag has been cleared already, but
-	 * slab->obj_exts has not been freed yet
-	 * folio_memcg_check() will guarantee that a proper memory
-	 * cgroup pointer or NULL will be returned.
-	 */
-	return folio_memcg_check(folio);
+	off = obj_to_index(slab->slab_cache, slab, p);
+	if (obj_exts[off].objcg)
+		return obj_cgroup_memcg(obj_exts[off].objcg);
+
+	return NULL;
 }
 
 /*
@@ -2637,7 +2627,7 @@ struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
 	if (mem_cgroup_disabled())
 		return NULL;
 
-	return mem_cgroup_from_obj_folio(virt_to_folio(p), p);
+	return mem_cgroup_from_obj_slab(virt_to_slab(p), p);
 }
 
 static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
-- 
2.47.2



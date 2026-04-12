Return-Path: <cgroups+bounces-15240-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFVKFUfs22lkIwkAu9opvQ
	(envelope-from <cgroups+bounces-15240-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:02:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C58133E5985
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80E993011059
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 19:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37037376462;
	Sun, 12 Apr 2026 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q164J1pa"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53430FC34;
	Sun, 12 Apr 2026 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020463; cv=none; b=LM5QfnXNyZaYRwND5nklTIhv4rvnsO24Haj0qpRAcSGCLWTpw/U3JMV2ndetgDMusyH9pepkcMDyaiN9WUlvmqLhR+X2TR8butQT2ZouMW+c2psuwcKNoP/b6l3aTFcl7/W/OAQZRI/AZhxI1LxJfB5pG6qtWOXA3136QwNC65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020463; c=relaxed/simple;
	bh=k8TV/mQzckSwoxZFZIPvSw0wxio7o/z3Stq1Dmp0NZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=myBUgr8Vn33qhFiKqzizkF1iyutBpyX88ShGuo9iV/RPhDrnvyZXGXrZaGnp4bw8cp78NQU88NO/NpqdgCmr17Uhkb6koFvOXLC5yDCwjDSlVVhoZM+MsA7KAKBYMTx7KWE7NdKutjQTbZ9Sk5n5Y94axd6qXP+y7upXBATIruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q164J1pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD326C19424;
	Sun, 12 Apr 2026 19:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020462;
	bh=k8TV/mQzckSwoxZFZIPvSw0wxio7o/z3Stq1Dmp0NZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q164J1pajjP4GBWPj23Lp4mHTBftGYsPTAk2vvdxdR/yQe+DD7tj2pRK8pcMKN634
	 +GAdTuR6FVgGt3/WAZXgGtlQ984Z24P8H+PirEXkevyNklnZEL4D7G7wwRUak4ZMeN
	 k+6v8smDNXW2RTuj294tKZxMvWuyyTgP+sD7wZOXa6ZGFQVa//ETaavK1A2OzCpQEG
	 +qMp+227FiOVegvRcSgAZL88fSP9wyn0gykkYJTd3EGJZOdL6Ozdoq3p+jOfgK252Z
	 u/jyERY99l2LOXyf011ZvhceXK8RGQbnnceVAsg2bTXj5lBfbmhyIwuxdBr+spdGHB
	 VnXsbGFVt1YaQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 12 Apr 2026 20:59:41 +0200
Subject: [PATCH RFC 10/13] mm: re-consolidate folio->_pincount
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-mapcount-v1-10-05e8dfab52e0@kernel.org>
References: <20260412-mapcount-v1-0-05e8dfab52e0@kernel.org>
In-Reply-To: <20260412-mapcount-v1-0-05e8dfab52e0@kernel.org>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Brendan Jackman <jackmanb@google.com>, 
 Zi Yan <ziy@nvidia.com>, Pedro Falcato <pfalcato@suse.de>, 
 Matthew Wilcox <willy@infradead.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15240-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C58133E5985
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that we have some space left in page[1] of a large folio on 32bit,
we can re-consolidate folio->_pincount.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h       |  4 +---
 include/linux/mm_types.h |  7 ++-----
 mm/debug.c               |  5 +----
 mm/internal.h            |  3 +--
 mm/page_alloc.c          | 14 +++-----------
 5 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1715c6ed14d4..6dd906585420 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2593,9 +2593,7 @@ static inline pud_t folio_mk_pud(const struct folio *folio, pgprot_t pgprot)
 
 static inline bool folio_has_pincount(const struct folio *folio)
 {
-	if (IS_ENABLED(CONFIG_64BIT))
-		return folio_test_large(folio);
-	return folio_order(folio) > 1;
+	return folio_test_large(folio);
 }
 
 /**
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e59571d2f81d..450f61cad678 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -451,11 +451,11 @@ struct folio {
 			union {
 				struct {
 	/* public: */
-					unsigned int _unused_2;
+					atomic_t _pincount;
 					atomic_t _entire_mapcount;
 #ifdef CONFIG_64BIT
 					unsigned int _unused_1;
-					atomic_t _pincount;
+					unsigned int _unused_2;
 #endif /* CONFIG_64BIT */
 					mm_id_mapcount_t _mm_id_mapcount[2];
 					union {
@@ -482,9 +482,6 @@ struct folio {
 			unsigned long _head_2;
 	/* public: */
 			struct list_head _deferred_list;
-#ifndef CONFIG_64BIT
-			atomic_t _pincount;
-#endif /* !CONFIG_64BIT */
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_2;
diff --git a/mm/debug.c b/mm/debug.c
index bfb41ef17a5e..80e050bf29ba 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -81,10 +81,7 @@ static void __dump_folio(const struct folio *folio, const struct page *page,
 			folio_ref_count(folio), mapcount, mapping,
 			folio->index + idx, pfn);
 	if (folio_test_large(folio)) {
-		int pincount = 0;
-
-		if (folio_has_pincount(folio))
-			pincount = atomic_read(&folio->_pincount);
+		int pincount = atomic_read(&folio->_pincount);
 
 		pr_warn("head: order:%u mapcount:%d entire_mapcount:%d pincount:%d\n",
 				folio_order(folio),
diff --git a/mm/internal.h b/mm/internal.h
index 53b20de141b9..aa1206495bc6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -869,8 +869,7 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 		folio->_mm_id_mapcount[1] = -1;
 	}
 	atomic_set(&folio->_entire_mapcount, -1);
-	if (IS_ENABLED(CONFIG_64BIT) || order > 1)
-		atomic_set(&folio->_pincount, 0);
+	atomic_set(&folio->_pincount, 0);
 	if (order > 1)
 		INIT_LIST_HEAD(&folio->_deferred_list);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1c09d79cade3..8ed4c73fdba4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1125,11 +1125,9 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "nonzero entire_mapcount");
 			goto out;
 		}
-		if (IS_ENABLED(CONFIG_64BIT)) {
-			if (unlikely(atomic_read(&folio->_pincount))) {
-				bad_page(page, "nonzero pincount");
-				goto out;
-			}
+		if (unlikely(atomic_read(&folio->_pincount))) {
+			bad_page(page, "nonzero pincount");
+			goto out;
 		}
 		break;
 	case 2:
@@ -1138,12 +1136,6 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "on deferred list");
 			goto out;
 		}
-		if (!IS_ENABLED(CONFIG_64BIT)) {
-			if (unlikely(atomic_read(&folio->_pincount))) {
-				bad_page(page, "nonzero pincount");
-				goto out;
-			}
-		}
 		break;
 	case 3:
 		/* the third tail page: hugetlb specifics overlap ->mappings */

-- 
2.43.0



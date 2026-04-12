Return-Path: <cgroups+bounces-15237-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJTlNLPs22mLIwkAu9opvQ
	(envelope-from <cgroups+bounces-15237-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:04:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808203E5A17
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A98C5305582A
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC8E37BE6E;
	Sun, 12 Apr 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMfyBNro"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E80F33987F;
	Sun, 12 Apr 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020443; cv=none; b=s1TENQP/cCFE1SPs5vhnnlwzgN7t3tyFEQXNDTSW0fX9c3yaYR7OTSSjvj8XzPsKTS5Y5Iu8ZnZaqDmX/mOdJVHNOPty5hc72qe+du3ig4MmZikvg75UgJLYovP596JIOx5BcBlIg0run+65ERHXEYzwYRvH8URzcfR53YJ5bNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020443; c=relaxed/simple;
	bh=R0nTOV0e4UXBnZHM/i98LWNnXx5at53ZamlgFkrFi2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmLXk1EbhUIGpn8F/ZUwWcCMrgXd9sSo4HlZ1PcXbxtLVKeEE4f2p9UUzkvzpTE01Kr8rMMOpuLV7v+qaU+Ql4E7EUYRYjp2Nh3Fdx3XH0HnJA/7Dot6sAyY/yY2FhOusbA89X4CvoFy+xH+cbVYxnO8dBYfvMf74wzqIbEFdCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMfyBNro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6710FC19424;
	Sun, 12 Apr 2026 19:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020443;
	bh=R0nTOV0e4UXBnZHM/i98LWNnXx5at53ZamlgFkrFi2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kMfyBNroYJWH/YPTOYl5elR0tf4Rs5AsOvgIhJPsdx4c/rWytCnMcYpidevEi986H
	 I0JECN9XuB5EeJr+vo4nq5yL+wFW3ifiGqzUnNMWhYKXd4Q8uB+XSPcmQ6JPSCSgtZ
	 vVaHvJ/FqgM4RGvgHymqoGgMhMnnNnnh0R/3AxN2q8822NmUTd1Bha9nME7SYspi/U
	 Yb01uIHY0jGNZZkNKXwG640IjlQ9QVNd6YjMdWczHjVntXqOCq/iMnMs0XwXo4GMkO
	 /49DR1TGLhIiV+N+dVOpQGPvZ36yM5l/s6+PkXfLhMG787YSyUbs7XiHCbcve9q6/7
	 cUsuIIWre4Zyg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 12 Apr 2026 20:59:38 +0200
Subject: [PATCH RFC 07/13] mm/rmap: remove CONFIG_PAGE_MAPCOUNT
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-mapcount-v1-7-05e8dfab52e0@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15237-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 808203E5A17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

page->mapcount is still updated but essentially unused. So let's
remove CONFIG_PAGE_MAPCOUNT. Given that CONFIG_NO_PAGE_MAPCOUNT is the
only remaining variant, that Kconfig can go as well.

We can replace some instances of "orig_nr_pages" by the "nr_pages" as
the latter is no longer modified.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 Documentation/mm/transhuge.rst |  3 ---
 include/linux/rmap.h           | 11 +----------
 mm/Kconfig                     | 17 -----------------
 mm/rmap.c                      | 36 ++++++------------------------------
 4 files changed, 7 insertions(+), 60 deletions(-)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index f200c1ac19cb..eb5ac076e4c6 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -129,9 +129,6 @@ pages:
     corresponding mapcount), and the current status ("maybe mapped shared" vs.
     "mapped exclusively").
 
-    With CONFIG_PAGE_MAPCOUNT, we also increment/decrement
-    page->_mapcount.
-
 split_huge_page internally has to distribute the refcounts in the head
 page to the tail pages before clearing all PG_head/tail bits from the page
 structures. It can be done easily for refcounts taken by page table
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e5569f5fdaec..4894e43e5f52 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -493,8 +493,6 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *dst_vma,
 		enum pgtable_level level)
 {
-	const int orig_nr_pages = nr_pages;
-
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
 	switch (level) {
@@ -504,12 +502,7 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 			break;
 		}
 
-		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT)) {
-			do {
-				atomic_inc(&page->_mapcount);
-			} while (page++, --nr_pages > 0);
-		}
-		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
+		folio_add_large_mapcount(folio, nr_pages, dst_vma);
 		break;
 	case PGTABLE_LEVEL_PMD:
 	case PGTABLE_LEVEL_PUD:
@@ -608,8 +601,6 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 		do {
 			if (PageAnonExclusive(page))
 				ClearPageAnonExclusive(page);
-			if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
-				atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
 		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
 		break;
diff --git a/mm/Kconfig b/mm/Kconfig
index bd283958d675..576db4fdf16e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -948,25 +948,8 @@ config READ_ONLY_THP_FOR_FS
 	  support of file THPs will be developed in the next few release
 	  cycles.
 
-config NO_PAGE_MAPCOUNT
-	bool "No per-page mapcount (EXPERIMENTAL)"
-	help
-	  Do not maintain per-page mapcounts for pages part of larger
-	  allocations, such as transparent huge pages.
-
-	  When this config option is enabled, some interfaces that relied on
-	  this information will rely on less-precise per-allocation information
-	  instead: for example, using the average per-page mapcount in such
-	  a large allocation instead of the per-page mapcount.
-
-	  EXPERIMENTAL because the impact of some changes is still unclear.
-
 endif # TRANSPARENT_HUGEPAGE
 
-# simple helper to make the code a bit easier to read
-config PAGE_MAPCOUNT
-	def_bool !NO_PAGE_MAPCOUNT
-
 #
 # The architecture supports pgtable leaves that is larger than PAGE_SIZE
 #
diff --git a/mm/rmap.c b/mm/rmap.c
index df42c38fe387..27488183448b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1354,7 +1354,6 @@ static __always_inline void __folio_add_rmap(struct folio *folio,
 		enum pgtable_level level)
 {
 	int nr = 0, nr_pmdmapped = 0, mapcount;
-	const int orig_nr_pages = nr_pages;
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
@@ -1365,14 +1364,8 @@ static __always_inline void __folio_add_rmap(struct folio *folio,
 			break;
 		}
 
-		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT)) {
-			do {
-				atomic_inc(&page->_mapcount);
-			} while (page++, --nr_pages > 0);
-		}
-
-		mapcount = folio_add_return_large_mapcount(folio, orig_nr_pages, vma);
-		if (mapcount == orig_nr_pages)
+		mapcount = folio_add_return_large_mapcount(folio, nr_pages, vma);
+		if (mapcount == nr_pages)
 			nr = folio_large_nr_pages(folio);
 		break;
 	case PGTABLE_LEVEL_PMD:
@@ -1518,15 +1511,6 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		VM_WARN_ON_FOLIO(folio_test_large(folio) &&
 				 folio_entire_mapcount(folio) > 1 &&
 				 PageAnonExclusive(cur_page), folio);
-		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT))
-			continue;
-
-		/*
-		 * While PTE-mapping a THP we have a PMD and a PTE
-		 * mapping.
-		 */
-		VM_WARN_ON_FOLIO(atomic_read(&cur_page->_mapcount) > 0 &&
-				 PageAnonExclusive(cur_page), folio);
 	}
 
 	/*
@@ -1628,14 +1612,12 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		int i;
 
 		nr = folio_large_nr_pages(folio);
-		for (i = 0; i < nr; i++) {
-			struct page *page = folio_page(folio, i);
+		if (exclusive) {
+			for (i = 0; i < nr; i++) {
+				struct page *page = folio_page(folio, i);
 
-			if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
-				/* increment count (starts at -1) */
-				atomic_set(&page->_mapcount, 0);
-			if (exclusive)
 				SetPageAnonExclusive(page);
+			}
 		}
 
 		folio_set_large_mapcount(folio, nr, vma);
@@ -1769,12 +1751,6 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		if (!mapcount)
 			nr = folio_large_nr_pages(folio);
 
-		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT)) {
-			do {
-				atomic_dec(&page->_mapcount);
-			} while (page++, --nr_pages > 0);
-		}
-
 		partially_mapped = __folio_certainly_partially_mapped(folio, mapcount);
 		break;
 	case PGTABLE_LEVEL_PMD:

-- 
2.43.0



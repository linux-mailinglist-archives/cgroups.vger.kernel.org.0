Return-Path: <cgroups+bounces-15234-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id U4b2CVHs22mLIwkAu9opvQ
	(envelope-from <cgroups+bounces-15234-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:02:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C510A3E59A2
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A178E30379A8
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9597837C90D;
	Sun, 12 Apr 2026 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB4iR0sb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5537A37BE87;
	Sun, 12 Apr 2026 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020424; cv=none; b=G/EALHaihc3fBRQtSSvChiMIGyP9mnZLkXfqLjL42ntxMSriM80Zmk2GtXPvWwbAIki3SnM/vJ0bpfrVkq7lfTlJS0W+R/YvqqM7pPmyNGx2WpFy10pXnBcHeofGdfGRBaXuViCQshnE5Dq/YoJ/zah8jbzqMmAUuTruALFbe3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020424; c=relaxed/simple;
	bh=1jHVYet/oe54ZKAneg+n7pyqjRhk04H+YUkgPDqua+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NWDVkaSCvghsBp9nvnan8j5vv3E4z/zKyIr8H1uW2kCtuGjLFa+cHUc7DfsxDtgBJsvdnGK+Sd6mdisaHF2WsJ7PVHxYt4ksDCI+mWtYLIVKn5pFHjaEXIh2WaA+ktojjz7wqlTwQ7jQUAuLTitu862Nsuh5TyOl4WX+2R/eF9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB4iR0sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FABC19425;
	Sun, 12 Apr 2026 19:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020423;
	bh=1jHVYet/oe54ZKAneg+n7pyqjRhk04H+YUkgPDqua+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YB4iR0sbgw8zJtiXrS8IWUbYJCa3vxqiIyKQd3DG46XWAtcsyOav4SlBasiBRWUpp
	 qe0/hyS6ixZnB/78TTE+tZUUHmGgCua+5Ae+b2kx1WEaQHozVkpz9odDDoI2muc9UB
	 PHUYm838J1usr6bDmc+/3cmWyP4pUzts9gKH0ZVsH9YLxCR7bLmrs/wE3Rm5IVlbwD
	 m7bxRkxtv5lDA6b6eEEmWMtrZ/vMvF8QHvtGSbUqZhSVOkolJWtKHvV3SPr7rotNLA
	 jAiL7jEjhNWdZGpF3t9qsrh+AoWfhXgturlGDoSvwBZeALPa6qPYiDvCTH3+frOc5e
	 v1aKBieXzcNTQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 12 Apr 2026 20:59:35 +0200
Subject: [PATCH RFC 04/13] fs/proc/task_mmu: remove CONFIG_PAGE_MAPCOUNT
 handling for PM_MMAP_EXCLUSIVE
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-mapcount-v1-4-05e8dfab52e0@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-15234-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: C510A3E59A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation for removing CONFIG_PAGE_MAPCOUNT, let's always use a
folio_maybe_mapped_shared() to detect possible page sharing, like we do
with CONFIG_NO_PAGE_MAPCOUNT.

Update the doc to state that this behavior no longer depends on the
kernel config, and simplify the doc a bit to mention less details that
are hard to follow.

For small folios and for large folios that were never mapped in multiple
processes at the same time, there is no change at all. For large folios,
there might be a change if

(1) The folio was once mapped at the same time into more than two
    address space, and now is only mapped in a single address space. We
    might detect it as shared.
(2) A folio page is only mapped into a single address space, but folio
    pages mapped into other address spaces. We will detect it as
    shared.
(3) A folio page is mapped multiple times into the same address space. We
    will detect it as exclusive.

We can now remove __folio_page_mapped_exclusively().

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 Documentation/admin-guide/mm/pagemap.rst | 17 +++++++----------
 fs/proc/task_mmu.c                       | 12 ++----------
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index f9478bcbb6a9..67eb04b1e246 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -38,16 +38,13 @@ There are four components to pagemap:
    precisely which pages are mapped (or in swap) and comparing mapped
    pages between processes.
 
-   Traditionally, bit 56 indicates that a page is mapped exactly once and bit
-   56 is clear when a page is mapped multiple times, even when mapped in the
-   same process multiple times. In some kernel configurations, the semantics
-   for pages part of a larger allocation (e.g., THP) can differ: bit 56 is set
-   if all pages part of the corresponding large allocation are *certainly*
-   mapped in the same process, even if the page is mapped multiple times in that
-   process. Bit 56 is clear when any page page of the larger allocation
-   is *maybe* mapped in a different process. In some cases, a large allocation
-   might be treated as "maybe mapped by multiple processes" even though this
-   is no longer the case.
+   Bit 56 set indicates that the page is currently *certainly* exclusively
+   mapped in this process, and bit 56 clear indicates that the page *might be*
+   mapped into multiple processes ("shared").  Note that in the past, the bit
+   precisely indicated that a page was mapped exactly once, and the bit was
+   clear also if mapped multiple times in the same process.  As this precise
+   information is not available for pages that are part of large allocations
+   (e.g., THP), the semantics have been slightly adjusted.
 
    Efficient users of this interface will use ``/proc/pid/maps`` to
    determine which areas of memory are actually mapped and llseek to
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ad0989d101ab..1e1572849fed 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1884,13 +1884,6 @@ static int add_to_pagemap(pagemap_entry_t *pme, struct pagemapread *pm)
 	return 0;
 }
 
-static bool __folio_page_mapped_exclusively(struct folio *folio, struct page *page)
-{
-	if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
-		return folio_precise_page_mapcount(folio, page) == 1;
-	return !folio_maybe_mapped_shared(folio);
-}
-
 static int pagemap_pte_hole(unsigned long start, unsigned long end,
 			    __always_unused int depth, struct mm_walk *walk)
 {
@@ -1985,8 +1978,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		folio = page_folio(page);
 		if (!folio_test_anon(folio))
 			flags |= PM_FILE;
-		if ((flags & PM_PRESENT) &&
-		    __folio_page_mapped_exclusively(folio, page))
+		if ((flags & PM_PRESENT) && !folio_maybe_mapped_shared(folio))
 			flags |= PM_MMAP_EXCLUSIVE;
 	}
 
@@ -2058,7 +2050,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 		pagemap_entry_t pme;
 
 		if (folio && (flags & PM_PRESENT) &&
-		    __folio_page_mapped_exclusively(folio, page))
+		    !folio_maybe_mapped_shared(folio))
 			cur_flags |= PM_MMAP_EXCLUSIVE;
 
 		pme = make_pme(frame, cur_flags);

-- 
2.43.0



Return-Path: <cgroups+bounces-15233-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK6aCOjr22lkIwkAu9opvQ
	(envelope-from <cgroups+bounces-15233-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:00:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CF73E590F
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11230300E274
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BB7366054;
	Sun, 12 Apr 2026 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlL8la5a"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6636655B;
	Sun, 12 Apr 2026 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020417; cv=none; b=aHydcvCJHTnvKv+ihwW8w0BKRQZGJ/3WOuDNN9ZojffGsYjlqXjNTTAzkij4Oq0nqaDvAH4nbpS38cpA1zSQdXEryCqjN+VXYxF2VLyiOnjUJ8gX4TV6l452NT+S0kXBK2FvMA80UtPcW3MwCs1r871lnUdQ/HHao0vMimG4S+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020417; c=relaxed/simple;
	bh=RyVlYvHfIoEn55OlunbAh+fxrKhxnjkmlCH/p959CXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+5AhgIfubpq+8xIZvJkuWsIGzlPWGUmzda2Yp1borHLGKLf2uW31Q3FMUGzxZLYgTyGXkmvBBKKuFBDdCOPTiLCpE/IvayA6ab0b/JOmIqxcOYqIJK07fBZNl4z1q9z8kIV2PyXPCNQEv5NJ2Q6ckxAAAxqV2AIVfHLkmf426k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlL8la5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA48C19425;
	Sun, 12 Apr 2026 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020417;
	bh=RyVlYvHfIoEn55OlunbAh+fxrKhxnjkmlCH/p959CXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KlL8la5at+fHsXlDhR6jR0X5V8H6/8FVTR+yOXU5z/cWgGlf1h/WCdGPT2F0BSEA1
	 yRnvhuRzT03Eq+b8yHvSeQCl8VqiBukTYccYyaXT+mDz+nKwu5mc3TlPaO4TVG8Fiy
	 TJVILmv9J1AqmSdx+/tWwt4Vf9FkD7o5cIiVusFrRWcW2IcnUfEr17iN7rSK0pdNGk
	 8uzQ7B+xMnQKa4kyT03u/FROye8ox4fEsmxvHzRbmfBwnotP7s4GoB3+KJJLYAlFG0
	 j9SnSOjXfgC89F1+wJYGQmWoA0AheD0UP9k2HyUZDrhAbC9RPCaWQ4EP417VJrf6qz
	 N8b0m+Bb5rWjg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 12 Apr 2026 20:59:34 +0200
Subject: [PATCH RFC 03/13] fs/proc/page: remove CONFIG_PAGE_MAPCOUNT
 handling for kpagecount
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-mapcount-v1-3-05e8dfab52e0@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15233-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95CF73E590F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation for removing CONFIG_PAGE_MAPCOUNT, let's always use a
folio's average page mapcount instead of the precise page mapcount when
calculating the kpagecount value, like we do with CONFIG_NO_PAGE_MAPCOUNT.

Update the doc to state that this behavior no longer depends on the
kernel config. While at it, improve the documentation a bit. "pagecount"
was really misnamed back in the days ...

Should we mention that the value is not actually really expressive in many
cases, such as for the shared zeropage or pages with a PFNMAP mapping?
Let's keep it simple, the hope is that this interface is not used at
all anymore, except for some weird debugging scenarios.

For small folios, or large folios that are fully-mapped everywhere, there
is no change at all.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 Documentation/admin-guide/mm/pagemap.rst | 13 ++++++-------
 fs/proc/page.c                           | 10 +---------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index c57e61b5d8aa..f9478bcbb6a9 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -53,13 +53,12 @@ There are four components to pagemap:
    determine which areas of memory are actually mapped and llseek to
    skip over unmapped regions.
 
- * ``/proc/kpagecount``.  This file contains a 64-bit count of the number of
-   times each page is mapped, indexed by PFN. Some kernel configurations do
-   not track the precise number of times a page part of a larger allocation
-   (e.g., THP) is mapped. In these configurations, the average number of
-   mappings per page in this larger allocation is returned instead. However,
-   if any page of the large allocation is mapped, the returned value will
-   be at least 1.
+ * ``/proc/kpagecount``.  This file contains a 64-bit value for each page,
+   indexed by PFN, representing its mapcount, i.e., the number of times it
+   is mapped into page tables.  For pages that are part of larger allocations
+   (e.g., THP), the average mapcount per page in the allocation is used, since
+   precise per-page mapcounts are not available.  If any page in such an
+   allocation is mapped, the returned value will be at least 1.
 
 The page-types tool in the tools/mm directory can be used to query the
 number of times a page is mapped.
diff --git a/fs/proc/page.c b/fs/proc/page.c
index f9b2c2c906cd..bc4d7c3751de 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -45,17 +45,9 @@ static inline unsigned long get_max_dump_pfn(void)
 static u64 get_kpage_count(const struct page *page)
 {
 	struct page_snapshot ps;
-	u64 ret;
 
 	snapshot_page(&ps, page);
-
-	if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
-		ret = folio_precise_page_mapcount(&ps.folio_snapshot,
-						  &ps.page_snapshot);
-	else
-		ret = folio_average_page_mapcount(&ps.folio_snapshot);
-
-	return ret;
+	return folio_average_page_mapcount(&ps.folio_snapshot);
 }
 
 static ssize_t kpage_read(struct file *file, char __user *buf,

-- 
2.43.0



Return-Path: <cgroups+bounces-15239-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOxAAffs22mLIwkAu9opvQ
	(envelope-from <cgroups+bounces-15239-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:05:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 574D03E5A46
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0764306774E
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA59237BE89;
	Sun, 12 Apr 2026 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnGNwtNI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AA61B6CE9;
	Sun, 12 Apr 2026 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020456; cv=none; b=TzdKIOKGvYnrChn0eVnWyBwXKAI8Od/juFWusHgrwo4oOMXUyIDxBBhoHj9hLz6MU5Q8nfVyJfvL8vrF4WgaXZCpE4RKt02tCLqE/TJkammbb6rt8YYqt17Or5WamMkv9y8XiNWCbiRTYl2Q/L/DYomL4qM7kDIMNLb3n3hAlWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020456; c=relaxed/simple;
	bh=biBQNj2Q5bpJxVa6feZIxbrGpqC66DvZQbPgZ/KMGNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=unBpS+x6jcrQ3R6qpRLFUVQx4GAGvGX77UOx3GH5ElwQCXZgEpIleCiksdetsHqPFlu3kSUiYf3eLzwr7lWLQgX5Dr/DkrpN8QS+Q+w0D+KVbH4V0Fo7k6uKm+qCUMgHd2i+Rrp6zp3Z2PC7uYWkj5Mu6Ot4OyMbc3sdeky+zsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnGNwtNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3768EC19425;
	Sun, 12 Apr 2026 19:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020456;
	bh=biBQNj2Q5bpJxVa6feZIxbrGpqC66DvZQbPgZ/KMGNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LnGNwtNIKGiNzkf3BUyiJ+gBC8o4Y/YSN9pVOD5J353jC9TZoHKYOSShn8SWi4juP
	 LFlxoLuvvSjzjZm4OCh770IPovW8I/0Zh//ejAaFphI4Tzac7M4DSxnlubbEL6jQ2V
	 uQ1yuJJdcldak/64gVzrg2ABWFQ2w7PrQZh1NfmNMoH3B9j18r0RmvrMbqMVlexWOS
	 kf5uDNtltjJrOzuoeysOw8OZ+zl8FPjyghawrE3EdNugd+tXTDp+VaBosz+bJMkIH/
	 Z55CNFkWSJCZJ20jp9N6qxJnofLibGwENGAqY6TF5tfCxjA7/0BQnrYMFUKPL+YYaZ
	 7PsYli9ekpbgQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 12 Apr 2026 20:59:40 +0200
Subject: [PATCH RFC 09/13] mm: move _large_mapcount to _mapcount in page[1]
 of a large folio
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-mapcount-v1-9-05e8dfab52e0@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-15239-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 574D03E5A46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that the _mapcount in tail pages is completely unused, we can
re-purpose it to ... store another mapcount.

In theory, it should now unnecessary to initialize the large mapcount to -1
in prep_compound_head(), but let's keep doing that for now.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm_types.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1e1befe7d418..e59571d2f81d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -155,8 +155,7 @@ struct page {
 		/*
 		 * For head pages of typed folios, the value stored here
 		 * allows for determining what this page is used for. The
-		 * tail pages of typed folios will not store a type
-		 * (page_type == _mapcount == -1).
+		 * tail pages of typed folios will not store a type.
 		 *
 		 * See page-flags.h for a list of page types which are currently
 		 * stored here.
@@ -378,6 +377,7 @@ typedef unsigned short mm_id_t;
  * @_entire_mapcount: Do not use directly, call folio_entire_mapcount().
  * @_large_mapcount: Do not use directly, call folio_mapcount().
  * @_unused_1: Temporary placeholder.
+ * @_unused_2: Temporary placeholder.
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_nr_pages: Do not use directly, call folio_nr_pages().
  * @_mm_id: Do not use outside of rmap code.
@@ -451,7 +451,7 @@ struct folio {
 			union {
 				struct {
 	/* public: */
-					atomic_t _large_mapcount;
+					unsigned int _unused_2;
 					atomic_t _entire_mapcount;
 #ifdef CONFIG_64BIT
 					unsigned int _unused_1;
@@ -466,7 +466,7 @@ struct folio {
 				};
 				unsigned long _usable_1[4];
 			};
-			atomic_t _mapcount_1;
+			atomic_t _large_mapcount;
 			atomic_t _refcount_1;
 	/* public: */
 #ifdef NR_PAGES_IN_LARGE_FOLIO
@@ -529,7 +529,7 @@ FOLIO_MATCH(_last_cpupid, _last_cpupid);
 			offsetof(struct page, pg) + sizeof(struct page))
 FOLIO_MATCH(flags, _flags_1);
 FOLIO_MATCH(compound_info, _head_1);
-FOLIO_MATCH(_mapcount, _mapcount_1);
+FOLIO_MATCH(_mapcount, _large_mapcount);
 FOLIO_MATCH(_refcount, _refcount_1);
 #undef FOLIO_MATCH
 #define FOLIO_MATCH(pg, fl)						\

-- 
2.43.0



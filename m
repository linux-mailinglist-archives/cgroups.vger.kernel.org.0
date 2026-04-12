Return-Path: <cgroups+bounces-15241-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ4XBRvs22lkIwkAu9opvQ
	(envelope-from <cgroups+bounces-15241-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:01:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8E63E5957
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98F753004434
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 19:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AD937BE8B;
	Sun, 12 Apr 2026 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRr9aHWa"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC718363C73;
	Sun, 12 Apr 2026 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020469; cv=none; b=ILeJc4tToaB553SnqkwePLIMpjCgvEhH2LSXxivfostdZfxoqXnzOiBdncD9xgRq86i89M+DbroST0wyZ+NMkcnpVe6FadFgz26pWtBa3COEdCKEb6eki6yzzctA4NAuI45dPMzXZ0IcsIz33ta/KesH7z5etnzxvBM/zDwm1wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020469; c=relaxed/simple;
	bh=JZvLJcjv2gHfduMXKfq+mJwAx6s5YsFTAkgnQcxaWZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fH8BT8Wgb5fWoP0kpuGynXgMU6KulUO1YFU68/GZXy5EeA6tHZSNTa/rDUm8/pccueUvS6N9Fq6fdYu5wQd2uxK2eds5OsrCbBcxCXeP3ug1HSZI3b0U/dLXWfTxi0rB5lw/dAkFjLRBqiNlnuoAqbkRPDmzJBd1MEh6d+EjdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRr9aHWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC77C19424;
	Sun, 12 Apr 2026 19:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020469;
	bh=JZvLJcjv2gHfduMXKfq+mJwAx6s5YsFTAkgnQcxaWZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iRr9aHWahhYBJDnSK4lcL93nbxXeh1H0DOCfQ3M9PZ2xMgUj97NCkumGeDCiyxP9v
	 oT+3kt1T/dyrZHEOIZlECOMCBIEiJUpdkMSemjLbuzq7qAOpEch/qupOm6M0JiD1Dt
	 rW3TF8KL0nFUKarTNHNLta0ujwL5itdjcrL+Pj3K7cwzRmKfDQx3xiZaxYTmxD7yMr
	 FPgIb7KZk9/riNdA0ehd6LerPOaFiwbPf7y3cVArZX5v4QAwYMsisneU9NxeHwzu/G
	 Ug24HXsQ3mPwPnftLqoO+iy071bG7XdjEOopTktpsA28fJyxFeHYZmfd0cCSXr5zAW
	 kYbKmvc9lQqdQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 12 Apr 2026 20:59:42 +0200
Subject: [PATCH RFC 11/13] mm/rmap: stop using the entire mapcount for
 hugetlb folios
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-mapcount-v1-11-05e8dfab52e0@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15241-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C8E63E5957
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is no real reason why hugetlb still updates the entire mapcount:
the value always corresponds to folio_mapcount().

As we want to change the semantics of the entire mapcount in a way
incompatible with hugetlb, let's just stop using the entire mapcount
for hugetlb folios entirely.

We only have to teach folio_average_page_mapcount() about the change.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/internal.h   | 3 +++
 include/linux/mm.h   | 2 ++
 include/linux/rmap.h | 3 ---
 mm/debug.c           | 2 +-
 mm/rmap.c            | 4 +---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index a5908167ce2d..1dd46e55c850 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -186,6 +186,9 @@ static inline int folio_average_page_mapcount(struct folio *folio)
 	mapcount = folio_large_mapcount(folio);
 	if (unlikely(mapcount <= 0))
 		return 0;
+	if (folio_test_hugetlb(folio))
+		return mapcount;
+
 	entire_mapcount = folio_entire_mapcount(folio);
 	if (mapcount <= entire_mapcount)
 		return entire_mapcount;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6dd906585420..3092db64a009 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1829,6 +1829,8 @@ static inline int is_vmalloc_or_module_addr(const void *x)
  * How many times the entire folio is mapped as a single unit (eg by a
  * PMD or PUD entry).  This is probably not what you want, except for
  * debugging purposes or implementation of other core folio_*() primitives.
+ *
+ * Always 0 for hugetlb folios.
  */
 static inline int folio_entire_mapcount(const struct folio *folio)
 {
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 4894e43e5f52..b81b1d9e1eaa 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -443,7 +443,6 @@ static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
 			return -EBUSY;
 		ClearPageAnonExclusive(&folio->page);
 	}
-	atomic_inc(&folio->_entire_mapcount);
 	atomic_inc(&folio->_large_mapcount);
 	return 0;
 }
@@ -477,7 +476,6 @@ static inline void hugetlb_add_file_rmap(struct folio *folio)
 	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
 
-	atomic_inc(&folio->_entire_mapcount);
 	atomic_inc(&folio->_large_mapcount);
 }
 
@@ -485,7 +483,6 @@ static inline void hugetlb_remove_rmap(struct folio *folio)
 {
 	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 
-	atomic_dec(&folio->_entire_mapcount);
 	atomic_dec(&folio->_large_mapcount);
 }
 
diff --git a/mm/debug.c b/mm/debug.c
index 80e050bf29ba..82baaf87ef3d 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -86,7 +86,7 @@ static void __dump_folio(const struct folio *folio, const struct page *page,
 		pr_warn("head: order:%u mapcount:%d entire_mapcount:%d pincount:%d\n",
 				folio_order(folio),
 				folio_mapcount(folio),
-				folio_entire_mapcount(folio),
+				folio_entire_mapcount(folio);
 				pincount);
 	}
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 27488183448b..d08927949284 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -3042,11 +3042,10 @@ void hugetlb_add_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	VM_WARN_ON_FOLIO(!folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
-	atomic_inc(&folio->_entire_mapcount);
 	atomic_inc(&folio->_large_mapcount);
 	if (flags & RMAP_EXCLUSIVE)
 		SetPageAnonExclusive(&folio->page);
-	VM_WARN_ON_FOLIO(folio_entire_mapcount(folio) > 1 &&
+	VM_WARN_ON_FOLIO(folio_large_mapcount(folio) > 1 &&
 			 PageAnonExclusive(&folio->page), folio);
 }
 
@@ -3057,7 +3056,6 @@ void hugetlb_add_new_anon_rmap(struct folio *folio,
 
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	/* increment count (starts at -1) */
-	atomic_set(&folio->_entire_mapcount, 0);
 	atomic_set(&folio->_large_mapcount, 0);
 	folio_clear_hugetlb_restore_reserve(folio);
 	__folio_set_anon(folio, vma, address, true);

-- 
2.43.0



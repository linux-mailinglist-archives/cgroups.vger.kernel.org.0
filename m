Return-Path: <cgroups+bounces-15242-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMk7EjDs22lkIwkAu9opvQ
	(envelope-from <cgroups+bounces-15242-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:02:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 450F83E596C
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C9BC300AD4D
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 19:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B0B37BE99;
	Sun, 12 Apr 2026 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKqWaEcJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AEE363C73;
	Sun, 12 Apr 2026 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020476; cv=none; b=IoIrWpjjlEjna9dGQ8Umx2xD5vsKFzgtCPrcWJI/2IUQ3kIv/Pg4q3QO8HJ42BRMXSzNwSND394BJFjWI87cbEidYL0+p4RBBlsRFq7n+a0qcHJyJwLxLHh6UkwOFO588RqnFsLRs+yMyWzha9mcVu230fTyRJYgm6XZ+o6md4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020476; c=relaxed/simple;
	bh=75B3Sn7MVipkRyt3ca6vBN0Fy65OWdrpROiMT2it6RU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqyZBimYUySD5PNU6kUfqWaBS0cbw4xLSC9Y1GRmiAHncX5TwIluItARfkR6gsals7nAq02cbjeeEmJiTTYLxNHHbZYsr89HhQZu4fq43eEWFqpAsabIZxGq1JNFi7sJsxaFCYLJiW3eGMggs2+VEWxpkQWb+KyP7P9UDPqCJu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKqWaEcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F8AC19425;
	Sun, 12 Apr 2026 19:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020475;
	bh=75B3Sn7MVipkRyt3ca6vBN0Fy65OWdrpROiMT2it6RU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BKqWaEcJ+ZORRiArbkuZkg8xbXuXikiCRf0z1gsWnrRW3aTdA5Cl9LCAVkUrEVf7H
	 LrpkE2RhqWvU4XhQxq3sfsOfxpF8DjYFlOlBTZqWLcco/EwF4+LS2uhcMjBA60Lstq
	 XXUkYUi+z1JQ6IclXGlZtzdWaPB7g2GMV2zmssLvnpCOTGWCdGVmKQqs5E7KCTZlag
	 4M2rT9q26kl6qhuiBzhZUwHEwmSGXMJfw0kTKUyGtj74WKZ2hyPyOuHYw4gn+O1c9I
	 EJdjEcpRHat1Uwh/DHSRj8IeQEKOORylIVHfK6Py1xb7eOkbsT6mzx8+ur1G/8G4nd
	 srNY+Zm28Otwg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 12 Apr 2026 20:59:43 +0200
Subject: [PATCH RFC 12/13] mm/rmap: large mapcount interface cleanups
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-mapcount-v1-12-05e8dfab52e0@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15242-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 450F83E596C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Let's prepare for passing another counter by renaming diff/mapcount to
"nr_mappings" and just using an "unsigned int".

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/rmap.h | 61 ++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b81b1d9e1eaa..5a02ffd3744a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -133,10 +133,10 @@ static inline void folio_set_mm_id(struct folio *folio, int idx, mm_id_t id)
 }
 
 static inline void __folio_large_mapcount_sanity_checks(const struct folio *folio,
-		int diff, mm_id_t mm_id)
+		unsigned int nr_mappings, mm_id_t mm_id)
 {
 	VM_WARN_ON_ONCE(!folio_test_large(folio) || folio_test_hugetlb(folio));
-	VM_WARN_ON_ONCE(diff <= 0);
+	VM_WARN_ON_ONCE(nr_mappings == 0);
 	VM_WARN_ON_ONCE(mm_id < MM_ID_MIN || mm_id > MM_ID_MAX);
 
 	/*
@@ -145,7 +145,7 @@ static inline void __folio_large_mapcount_sanity_checks(const struct folio *foli
 	 * a check on 32bit, where we currently reduce the size of the per-MM
 	 * mapcount to a short.
 	 */
-	VM_WARN_ON_ONCE(diff > folio_large_nr_pages(folio));
+	VM_WARN_ON_ONCE(nr_mappings > folio_large_nr_pages(folio));
 	VM_WARN_ON_ONCE(folio_large_nr_pages(folio) - 1 > MM_ID_MAPCOUNT_MAX);
 
 	VM_WARN_ON_ONCE(folio_mm_id(folio, 0) == MM_ID_DUMMY &&
@@ -161,29 +161,29 @@ static inline void __folio_large_mapcount_sanity_checks(const struct folio *foli
 }
 
 static __always_inline void folio_set_large_mapcount(struct folio *folio,
-		int mapcount, struct vm_area_struct *vma)
+		unsigned int nr_mappings, struct vm_area_struct *vma)
 {
-	__folio_large_mapcount_sanity_checks(folio, mapcount, vma->vm_mm->mm_id);
+	__folio_large_mapcount_sanity_checks(folio, nr_mappings, vma->vm_mm->mm_id);
 
 	VM_WARN_ON_ONCE(folio_mm_id(folio, 0) != MM_ID_DUMMY);
 	VM_WARN_ON_ONCE(folio_mm_id(folio, 1) != MM_ID_DUMMY);
 
 	/* Note: mapcounts start at -1. */
-	atomic_set(&folio->_large_mapcount, mapcount - 1);
-	folio->_mm_id_mapcount[0] = mapcount - 1;
+	atomic_set(&folio->_large_mapcount, nr_mappings - 1);
+	folio->_mm_id_mapcount[0] = nr_mappings - 1;
 	folio_set_mm_id(folio, 0, vma->vm_mm->mm_id);
 }
 
 static __always_inline int folio_add_return_large_mapcount(struct folio *folio,
-		int diff, struct vm_area_struct *vma)
+		unsigned int nr_mappings, struct vm_area_struct *vma)
 {
 	const mm_id_t mm_id = vma->vm_mm->mm_id;
 	int new_mapcount_val;
 
 	folio_lock_large_mapcount(folio);
-	__folio_large_mapcount_sanity_checks(folio, diff, mm_id);
+	__folio_large_mapcount_sanity_checks(folio, nr_mappings, mm_id);
 
-	new_mapcount_val = atomic_read(&folio->_large_mapcount) + diff;
+	new_mapcount_val = atomic_read(&folio->_large_mapcount) + nr_mappings;
 	atomic_set(&folio->_large_mapcount, new_mapcount_val);
 
 	/*
@@ -194,14 +194,14 @@ static __always_inline int folio_add_return_large_mapcount(struct folio *folio,
 	 * we might be in trouble when unmapping pages later.
 	 */
 	if (folio_mm_id(folio, 0) == mm_id) {
-		folio->_mm_id_mapcount[0] += diff;
+		folio->_mm_id_mapcount[0] += nr_mappings;
 		if (!IS_ENABLED(CONFIG_64BIT) && unlikely(folio->_mm_id_mapcount[0] < 0)) {
 			folio->_mm_id_mapcount[0] = -1;
 			folio_set_mm_id(folio, 0, MM_ID_DUMMY);
 			folio->_mm_ids |= FOLIO_MM_IDS_SHARED_BIT;
 		}
 	} else if (folio_mm_id(folio, 1) == mm_id) {
-		folio->_mm_id_mapcount[1] += diff;
+		folio->_mm_id_mapcount[1] += nr_mappings;
 		if (!IS_ENABLED(CONFIG_64BIT) && unlikely(folio->_mm_id_mapcount[1] < 0)) {
 			folio->_mm_id_mapcount[1] = -1;
 			folio_set_mm_id(folio, 1, MM_ID_DUMMY);
@@ -209,13 +209,13 @@ static __always_inline int folio_add_return_large_mapcount(struct folio *folio,
 		}
 	} else if (folio_mm_id(folio, 0) == MM_ID_DUMMY) {
 		folio_set_mm_id(folio, 0, mm_id);
-		folio->_mm_id_mapcount[0] = diff - 1;
+		folio->_mm_id_mapcount[0] = nr_mappings - 1;
 		/* We might have other mappings already. */
-		if (new_mapcount_val != diff - 1)
+		if (new_mapcount_val != nr_mappings - 1)
 			folio->_mm_ids |= FOLIO_MM_IDS_SHARED_BIT;
 	} else if (folio_mm_id(folio, 1) == MM_ID_DUMMY) {
 		folio_set_mm_id(folio, 1, mm_id);
-		folio->_mm_id_mapcount[1] = diff - 1;
+		folio->_mm_id_mapcount[1] = nr_mappings - 1;
 		/* Slot 0 certainly has mappings as well. */
 		folio->_mm_ids |= FOLIO_MM_IDS_SHARED_BIT;
 	}
@@ -225,15 +225,15 @@ static __always_inline int folio_add_return_large_mapcount(struct folio *folio,
 #define folio_add_large_mapcount folio_add_return_large_mapcount
 
 static __always_inline int folio_sub_return_large_mapcount(struct folio *folio,
-		int diff, struct vm_area_struct *vma)
+		unsigned int nr_mappings, struct vm_area_struct *vma)
 {
 	const mm_id_t mm_id = vma->vm_mm->mm_id;
 	int new_mapcount_val;
 
 	folio_lock_large_mapcount(folio);
-	__folio_large_mapcount_sanity_checks(folio, diff, mm_id);
+	__folio_large_mapcount_sanity_checks(folio, nr_mappings, mm_id);
 
-	new_mapcount_val = atomic_read(&folio->_large_mapcount) - diff;
+	new_mapcount_val = atomic_read(&folio->_large_mapcount) - nr_mappings;
 	atomic_set(&folio->_large_mapcount, new_mapcount_val);
 
 	/*
@@ -243,13 +243,13 @@ static __always_inline int folio_sub_return_large_mapcount(struct folio *folio,
 	 * negative.
 	 */
 	if (folio_mm_id(folio, 0) == mm_id) {
-		folio->_mm_id_mapcount[0] -= diff;
+		folio->_mm_id_mapcount[0] -= nr_mappings;
 		if (folio->_mm_id_mapcount[0] >= 0)
 			goto out;
 		folio->_mm_id_mapcount[0] = -1;
 		folio_set_mm_id(folio, 0, MM_ID_DUMMY);
 	} else if (folio_mm_id(folio, 1) == mm_id) {
-		folio->_mm_id_mapcount[1] -= diff;
+		folio->_mm_id_mapcount[1] -= nr_mappings;
 		if (folio->_mm_id_mapcount[1] >= 0)
 			goto out;
 		folio->_mm_id_mapcount[1] = -1;
@@ -275,35 +275,36 @@ static __always_inline int folio_sub_return_large_mapcount(struct folio *folio,
  * See __folio_rmap_sanity_checks(), we might map large folios even without
  * CONFIG_TRANSPARENT_HUGEPAGE. We'll keep that working for now.
  */
-static inline void folio_set_large_mapcount(struct folio *folio, int mapcount,
+static inline void folio_set_large_mapcount(struct folio *folio,
+		unsigned int nr_mappings,
 		struct vm_area_struct *vma)
 {
 	/* Note: mapcounts start at -1. */
-	atomic_set(&folio->_large_mapcount, mapcount - 1);
+	atomic_set(&folio->_large_mapcount, nr_mappings - 1);
 }
 
 static inline void folio_add_large_mapcount(struct folio *folio,
-		int diff, struct vm_area_struct *vma)
+		unsigned int nr_mappings, struct vm_area_struct *vma)
 {
-	atomic_add(diff, &folio->_large_mapcount);
+	atomic_add(nr_mappings, &folio->_large_mapcount);
 }
 
 static inline int folio_add_return_large_mapcount(struct folio *folio,
-		int diff, struct vm_area_struct *vma)
+		unsigned int nr_mappings, struct vm_area_struct *vma)
 {
-	return atomic_add_return(diff, &folio->_large_mapcount) + 1;
+	return atomic_add_return(nr_mappings, &folio->_large_mapcount) + 1;
 }
 
 static inline void folio_sub_large_mapcount(struct folio *folio,
-		int diff, struct vm_area_struct *vma)
+		unsigned int nr_mappings, struct vm_area_struct *vma)
 {
-	atomic_sub(diff, &folio->_large_mapcount);
+	atomic_sub(nr_mappings, &folio->_large_mapcount);
 }
 
 static inline int folio_sub_return_large_mapcount(struct folio *folio,
-		int diff, struct vm_area_struct *vma)
+		unsigned int nr_mappings, struct vm_area_struct *vma)
 {
-	return atomic_sub_return(diff, &folio->_large_mapcount) + 1;
+	return atomic_sub_return(nr_mappings, &folio->_large_mapcount) + 1;
 }
 #endif /* CONFIG_MM_ID */
 

-- 
2.43.0



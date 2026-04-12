Return-Path: <cgroups+bounces-15238-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HIsDtXs22mLIwkAu9opvQ
	(envelope-from <cgroups+bounces-15238-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:04:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C3B3E5A35
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 21:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EE5A305E1F8
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B84837BE99;
	Sun, 12 Apr 2026 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwkJzGsa"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018F364025;
	Sun, 12 Apr 2026 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020449; cv=none; b=HDtup4FMtaI1oaDVPQcX4OlBUP5oD21gHR6XUHud4apocP0fQgK0nFTp8mun8Ri9fcaQ6T6dJG0/dN4hX59k+0qm2PDydUa6yO4sH67vY2bzA8F07Rv0yjfT5lHcP9Y0NFboD7D2daArL66SoDmBGbLA5xMxfyg/+xDSQCYzzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020449; c=relaxed/simple;
	bh=TsVZ6e4sn2FbkgFq2K8DRDubBw0VwKHbpvbtJYgoQ1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZT9J1YNUCce+7Yo0B2FS7xbSC/ME6H40gKBKXbIKkAnA5N5ZecNhmAffqIaRPOcFmkFjPluX+zo00KeaGFjm7BFvkUcBM3Mc6zpvQ9hZSXrJDltPxuaXUkrZNrpDn3zYRDUEesJtSk72YwUwTtFpQkqNWn66he5hujaXeo+o1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwkJzGsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CE0C19424;
	Sun, 12 Apr 2026 19:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020449;
	bh=TsVZ6e4sn2FbkgFq2K8DRDubBw0VwKHbpvbtJYgoQ1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pwkJzGsayS+/jZo+nmmiIQrNnaxEr+SOQh4PaqC2CP88io1g96Coj60Z0D4Va39Xv
	 NyZXxGz5tGTTYxsnqgOha8cYbv5sDXQlTLswIdukhw9BvLxMDR95awZ3m4a6UBGArO
	 rPg/u3lq52tr12XFXLMEDB0DUSc2syhebLJfmO2XYVk+IHpKpxxqAhAU9oAZIU783o
	 OHo/7Up+ti46w21INDiL1Ct4VP6JRvWvaPxOEzp6P+i7mqkiNBKoijbmul+ADOD5c3
	 nxxZXaNu8Dm36XbmFuRiFDbD87rSbhb8w2bKGvjCqcSsS/ZhvZ2LvbPxkd5lARvBS5
	 VW1YnArficdgw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 12 Apr 2026 20:59:39 +0200
Subject: [PATCH RFC 08/13] mm: re-consolidate folio->_entire_mapcount
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-mapcount-v1-8-05e8dfab52e0@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-15238-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: D6C3B3E5A35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that we have some space left in page[1] of a large folio on 32bit,
we can re-consolidate folio->_entire_mapcount.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mm.h       |  4 +---
 include/linux/mm_types.h |  5 ++---
 mm/internal.h            |  5 ++---
 mm/page_alloc.c          | 12 ++++--------
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 633bbf9a184a..1715c6ed14d4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1832,9 +1832,7 @@ static inline int is_vmalloc_or_module_addr(const void *x)
  */
 static inline int folio_entire_mapcount(const struct folio *folio)
 {
-	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
-	if (!IS_ENABLED(CONFIG_64BIT) && unlikely(folio_large_order(folio) == 1))
-		return 0;
+	VM_WARN_ON_FOLIO(!folio_test_large(folio), folio);
 	return atomic_read(&folio->_entire_mapcount) + 1;
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 47b2c3d05f41..1e1befe7d418 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -452,9 +452,9 @@ struct folio {
 				struct {
 	/* public: */
 					atomic_t _large_mapcount;
-					unsigned int _unused_1;
-#ifdef CONFIG_64BIT
 					atomic_t _entire_mapcount;
+#ifdef CONFIG_64BIT
+					unsigned int _unused_1;
 					atomic_t _pincount;
 #endif /* CONFIG_64BIT */
 					mm_id_mapcount_t _mm_id_mapcount[2];
@@ -483,7 +483,6 @@ struct folio {
 	/* public: */
 			struct list_head _deferred_list;
 #ifndef CONFIG_64BIT
-			atomic_t _entire_mapcount;
 			atomic_t _pincount;
 #endif /* !CONFIG_64BIT */
 	/* private: the union with struct page is transitional */
diff --git a/mm/internal.h b/mm/internal.h
index 30e48f39d2de..53b20de141b9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -868,10 +868,9 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 		folio->_mm_id_mapcount[0] = -1;
 		folio->_mm_id_mapcount[1] = -1;
 	}
-	if (IS_ENABLED(CONFIG_64BIT) || order > 1) {
+	atomic_set(&folio->_entire_mapcount, -1);
+	if (IS_ENABLED(CONFIG_64BIT) || order > 1)
 		atomic_set(&folio->_pincount, 0);
-		atomic_set(&folio->_entire_mapcount, -1);
-	}
 	if (order > 1)
 		INIT_LIST_HEAD(&folio->_deferred_list);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8888f31aca49..1c09d79cade3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1121,11 +1121,11 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 				goto out;
 			}
 		}
+		if (folio_entire_mapcount(folio)) {
+			bad_page(page, "nonzero entire_mapcount");
+			goto out;
+		}
 		if (IS_ENABLED(CONFIG_64BIT)) {
-			if (unlikely(atomic_read(&folio->_entire_mapcount) + 1)) {
-				bad_page(page, "nonzero entire_mapcount");
-				goto out;
-			}
 			if (unlikely(atomic_read(&folio->_pincount))) {
 				bad_page(page, "nonzero pincount");
 				goto out;
@@ -1139,10 +1139,6 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			goto out;
 		}
 		if (!IS_ENABLED(CONFIG_64BIT)) {
-			if (unlikely(atomic_read(&folio->_entire_mapcount) + 1)) {
-				bad_page(page, "nonzero entire_mapcount");
-				goto out;
-			}
 			if (unlikely(atomic_read(&folio->_pincount))) {
 				bad_page(page, "nonzero pincount");
 				goto out;

-- 
2.43.0



Return-Path: <cgroups+bounces-6668-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E39A428B0
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 18:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B643AA2B2
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFCB266B62;
	Mon, 24 Feb 2025 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGOYcCRk"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE77266568
	for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416191; cv=none; b=oaJ6fDOFLpBZqGRwbDhgajUDWns3s0HDjBquZHO6QJnq/MTq59W4x4TWlh2FWGajbEh3CCefadCvfIxCPVF5pOclrAeokpm0BDAfjfXa1Y0bdNmlYvX8btrPjvaRy7EahwdCu+naNwyVOi0vJR+/wdMhCQfrUtEwkl9YBPhzSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416191; c=relaxed/simple;
	bh=Ycu3g93agHZ5+lzaLOnuhINjqTNBvJJTMooJF9ouEus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjJVMf7hp1DWB6suY2ZtQXFWaya/OVBfF9rELaeaJ86pPZJSC+Ps/QmHEUbKvQ4R8cv9SwF4MZcRt7NmDm0rj1U23hWbERo6OJaSo0ND6kjlKhwZy/x/h4YqGPbb2M5Bwk2PoboeeAixFzBqnOS8HubOgXVEnSK7bqZOBgqmsEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGOYcCRk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cb8Ah8lJoOkHJddlEV7mqidKdKB3PYdRohUjXTfR2AA=;
	b=TGOYcCRk+oScdqIk+XREUk+dL5pqXUK8hLiCLIw05ba26RLYymupLksUFiuT4lotew3cSg
	r6FoLfP+nS7UZA7dvZ49O0sULwD09Hb4LFj88PXy4tRRCO7J2zyulfj9tjPp4dHHR2ja5p
	a5lcaoigxY2Xek6iOw0Vnkx1boRf6Jk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-zR84T-kuNd69selsenncLg-1; Mon, 24 Feb 2025 11:56:25 -0500
X-MC-Unique: zR84T-kuNd69selsenncLg-1
X-Mimecast-MFC-AGG-ID: zR84T-kuNd69selsenncLg_1740416184
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43935e09897so32828955e9.1
        for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 08:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416184; x=1741020984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb8Ah8lJoOkHJddlEV7mqidKdKB3PYdRohUjXTfR2AA=;
        b=iExmeq9Yv4ZqHe9Vk17IVbeLR58K/pzIu90HgAy0uY3xuX6vSZk26eDs7NAbQa69Y6
         R8bPKQGDXkehn7V2XgY+4k/m0xWL7EzE/JhBO+mRD82Z1jFhUIfJku7As6A9fVO+5c/p
         /qJLe7RDKIsj5LwmIcu8oL2fBlJwk1JKFYUxBezMfvZr7bGeJ4d92Y8/PqHAy65w3wnS
         LmaSOUntZWjUBkFRTqIqWdHJLr4vZmdwgsW5v7t/rqd8xOWZlV4XOLjs7PU8mK/O3V+A
         uxrC/1aQAGUyDLQufUbc0+24p/RdelZcmxyyeCDdfqjX3i4Ulc+UZM1p0KIU8KAJXa3S
         HETQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcU7XP0xUzu/+I0W9j3DzYBJEBTv3r7YHVAUs+PRXrL8NXd9qRIUnGYeXpKnQ60ezfqHuk208E@vger.kernel.org
X-Gm-Message-State: AOJu0YyOyfo1ynicyObhYWduqImF+EU/2h/HVzgdqr4C26JLrxlZiAwC
	k494q1/+lLoeV9S3x7vM1ABk+Os3Pq5SEBl6dn902KyXN37EOICsllO+edJzKTlFKAU/wixIuAJ
	kMQqlFBiTRuLpEitAnSoKK2Sw1z2/wxcs2V2Hmi3aSdFgiPpVkK6aQw4=
X-Gm-Gg: ASbGnctsTFaXAv3bmv1ciRR0RAGJfKT3FFXO1B3v6G0vyfFfy6kes7G5G/lleBpBBTr
	iGF2kSnFscYXfSbskszfUo/o4vScuH21sP8CXRALdw/DqMnJXyGz9MANJmKnvSB2LaoAmQYFjEA
	Jc7tSEXSPBxwR+XFVSVLx6ASfgs8+TsOWbT84k8+nM+MeC/DxkVyY7kbJulqi0W+9Zqn8m4MQZq
	7bYxoYuizrUJTJymlBpKF2CKVBrVcKB2QpkTTwUUeF6KlFWJhM9U/tHkNQD7l34GvHceEYrydGh
	Yqi+whAU7xELuaqFuSCiiZnCkxXgAUDrSF1BcY57/w==
X-Received: by 2002:a05:600c:4e8c:b0:439:6712:643d with SMTP id 5b1f17b1804b1-439ae1e6c15mr101103405e9.9.1740416184316;
        Mon, 24 Feb 2025 08:56:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELVR15SfmZbX6a5/LWsD6f0rg6Y8hiw7+oMACeve7JZ9CA6HteUq/ZR57fRSUerpUCoh+bqg==
X-Received: by 2002:a05:600c:4e8c:b0:439:6712:643d with SMTP id 5b1f17b1804b1-439ae1e6c15mr101103135e9.9.1740416183869;
        Mon, 24 Feb 2025 08:56:23 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439b031b613sm111082365e9.33.2025.02.24.08.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:23 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v2 09/20] mm/rmap: abstract large mapcount operations for large folios (!hugetlb)
Date: Mon, 24 Feb 2025 17:55:51 +0100
Message-ID: <20250224165603.1434404-10-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224165603.1434404-1-david@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's abstract the operations so we can extend these operations easily.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 32 ++++++++++++++++++++++++++++----
 mm/rmap.c            | 14 ++++++--------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e795610bade80..d1e888cc97a58 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -173,6 +173,30 @@ static inline void anon_vma_merge(struct vm_area_struct *vma,
 
 struct anon_vma *folio_get_anon_vma(const struct folio *folio);
 
+static inline void folio_set_large_mapcount(struct folio *folio, int mapcount,
+		struct vm_area_struct *vma)
+{
+	/* Note: mapcounts start at -1. */
+	atomic_set(&folio->_large_mapcount, mapcount - 1);
+}
+
+static inline void folio_add_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	atomic_add(diff, &folio->_large_mapcount);
+}
+
+static inline void folio_sub_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	atomic_sub(diff, &folio->_large_mapcount);
+}
+
+#define folio_inc_large_mapcount(folio, vma) \
+	folio_add_large_mapcount(folio, 1, vma)
+#define folio_dec_large_mapcount(folio, vma) \
+	folio_sub_large_mapcount(folio, 1, vma)
+
 /* RMAP flags, currently only relevant for some anon rmap operations. */
 typedef int __bitwise rmap_t;
 
@@ -352,12 +376,12 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		do {
 			atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
-		atomic_add(orig_nr_pages, &folio->_large_mapcount);
+		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
 		atomic_inc(&folio->_entire_mapcount);
-		atomic_inc(&folio->_large_mapcount);
+		folio_inc_large_mapcount(folio, dst_vma);
 		break;
 	}
 }
@@ -451,7 +475,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 				ClearPageAnonExclusive(page);
 			atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
-		atomic_add(orig_nr_pages, &folio->_large_mapcount);
+		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
@@ -461,7 +485,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 			ClearPageAnonExclusive(page);
 		}
 		atomic_inc(&folio->_entire_mapcount);
-		atomic_inc(&folio->_large_mapcount);
+		folio_inc_large_mapcount(folio, dst_vma);
 		break;
 	}
 	return 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index 8a7d023b02e0c..08846b7eced60 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1266,7 +1266,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		    atomic_add_return_relaxed(first, mapped) < ENTIRELY_MAPPED)
 			nr = first;
 
-		atomic_add(orig_nr_pages, &folio->_large_mapcount);
+		folio_add_large_mapcount(folio, orig_nr_pages, vma);
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
@@ -1290,7 +1290,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 				nr = 0;
 			}
 		}
-		atomic_inc(&folio->_large_mapcount);
+		folio_inc_large_mapcount(folio, vma);
 		break;
 	}
 	return nr;
@@ -1556,14 +1556,12 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 				SetPageAnonExclusive(page);
 		}
 
-		/* increment count (starts at -1) */
-		atomic_set(&folio->_large_mapcount, nr - 1);
+		folio_set_large_mapcount(folio, nr, vma);
 		atomic_set(&folio->_nr_pages_mapped, nr);
 	} else {
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
-		/* increment count (starts at -1) */
-		atomic_set(&folio->_large_mapcount, 0);
+		folio_set_large_mapcount(folio, 1, vma);
 		atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
 		if (exclusive)
 			SetPageAnonExclusive(&folio->page);
@@ -1665,7 +1663,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			break;
 		}
 
-		atomic_sub(nr_pages, &folio->_large_mapcount);
+		folio_sub_large_mapcount(folio, nr_pages, vma);
 		do {
 			last += atomic_add_negative(-1, &page->_mapcount);
 		} while (page++, --nr_pages > 0);
@@ -1678,7 +1676,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
-		atomic_dec(&folio->_large_mapcount);
+		folio_dec_large_mapcount(folio, vma);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
-- 
2.48.1



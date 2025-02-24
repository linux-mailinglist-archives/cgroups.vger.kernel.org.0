Return-Path: <cgroups+bounces-6672-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075B5A42894
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 18:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC847A43B8
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5149B263F5D;
	Mon, 24 Feb 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bxb+WrKb"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39848267392
	for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416198; cv=none; b=QDiiCuel8avbfzvTD7PHwu5ga+AMMldhz0UGUXXjP43vxFQlaBHh65Io1OqaC/OSj3IudstycBnWxtgBr/DQeOmFNk+R95KGEhr4R9grgIJHfrq9037J78nh4/qoodgyDayVE/w72eTD7DPyhBIBqBxraeOfhbUStHwG5n+s3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416198; c=relaxed/simple;
	bh=+oO0YOFo2loLfbEqLOJlR2w0XdWVO+uOgMtYkv7+0wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFfBJgF2oGqeo3u/2TLfnDQcjacLJqisHO+2TaE+oLs22ai2bC/IjQCfzhtj7GVEugtY6dBhRmKsaqJE3KDSKUElLInxcBnqoY/kU6M+T4E8Sl12kv3B4KjNuBH/XVLs/RezpMoGWX1HfDkhStG+nZOk5BK8emT5AGhwgnuBv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bxb+WrKb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pg2vY9vqWz7IHDYregwabj5LRZT1HxPxFKsGucVLMU4=;
	b=Bxb+WrKbyvXSXgGJjpMwICQUQNQhB00d5hchNzMIJ5WfPw0G3AB6DL/KUXwQ47VlE6GLFN
	n+O2U97CeIkDmFm0ZjRFSFnsrnOWjO2FgIaKIuGfM09QchtwoXnsEgLlXjGEpbXhowPNoS
	yqWe9AdTdOf00hsexXRAqA/koEejg38=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-P28Pib9BNqCvUE17leYTJg-1; Mon, 24 Feb 2025 11:56:33 -0500
X-MC-Unique: P28Pib9BNqCvUE17leYTJg-1
X-Mimecast-MFC-AGG-ID: P28Pib9BNqCvUE17leYTJg_1740416193
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f4e3e9c5bso1906736f8f.1
        for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 08:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416192; x=1741020992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pg2vY9vqWz7IHDYregwabj5LRZT1HxPxFKsGucVLMU4=;
        b=IXtYetQ/UPEqGt1rt77/fsTa+P4ecPlVoE7B6848i5Bl18OzSCMHo3TU4ybC8Gy/15
         /ICAmgcSeBo9WzOccI3gxpEut5b9T2arq9EC7LAXW5f20Cslp9TipfiMOWz5xx8lH6gB
         EhAjIE4fTJT69jb8/owEnIfYmBUrWgKv9XFJqnO+Bku4erYL9LJbJ8VPktqBc09mPObx
         fKXa+flGyaMdw4LFa7IyhH2y07+MXvtlUMPzA0wChEXyCKUlAyeFgbA7Ay9nyS+6SIBr
         pSyFFX+XovJaIfZd/ntdG7TWHiMeEBGrWUBZM+FJLvq+nHeFdE4bN2iOsIHOhvB3z1Rk
         aKhA==
X-Forwarded-Encrypted: i=1; AJvYcCUD5IpzAXCGGZBaDxSKXvTZwq+cgXm6PN2vde0GKll2Y7sMpSO5Z4RQFQXNCBkZN73P5RoW+3o2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgfrhgv993OMw9dngsVdyS/efz26PKUOoqqg3Sswa2kD6l1LUh
	WKWmbZm4olQJuLJEP57VdsmXGju6VDbwjTwo8GRGm2xymIw8FXzPQYcUQLLFGjqbMcGPnmYOMwb
	vU6zoEFPFXbxo+i/vWKc2BGOYDGjv7c827+y0MFT4+Y6o2/TjVlbWS6A=
X-Gm-Gg: ASbGncuhx9/wCxYKN945M4CmPXxbDqVUpNRzXNXXLtptToDPfOufzqa5FN5JhH/BBw2
	3ubkg5ViKDIUoNUHadPlqIrmmQkzHGq5WKH0HSYm1UKdNiSkRvBsTDnf2gPtiLaQfff4M8xHjso
	sSaSQ7Qu3SDDtpmmjo3IVLrl+DpNwGA0Vd8KjJT0PhiHAQYo96UL/YrtVIDF3VEnN9m+KLgMah7
	yt3+uRqdkSDpTAWwXLY3xDsbdYaH4J76rC9QzAXaiXhgdm7X8OIqob5zobulzU6zQijkowCH9vl
	Jwzc6ILItmtzedlbPLTBvcqfTV45kMlPmj0QmOdWvQ==
X-Received: by 2002:a5d:648a:0:b0:38d:db7b:5d90 with SMTP id ffacd0b85a97d-38f6f0951bbmr11757091f8f.41.1740416192482;
        Mon, 24 Feb 2025 08:56:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaIBsZiKHsVYYcLtCIPoeZB3FHIPU3YJhCLPdlvukEQ+/K5hEIgCDRy8AjGPWVYvGgArScYA==
X-Received: by 2002:a5d:648a:0:b0:38d:db7b:5d90 with SMTP id ffacd0b85a97d-38f6f0951bbmr11757061f8f.41.1740416192060;
        Mon, 24 Feb 2025 08:56:32 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f258b4163sm32531566f8f.19.2025.02.24.08.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:31 -0800 (PST)
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
Subject: [PATCH v2 13/20] mm: Copy-on-Write (COW) reuse support for PTE-mapped THP
Date: Mon, 24 Feb 2025 17:55:55 +0100
Message-ID: <20250224165603.1434404-14-david@redhat.com>
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

Currently, we never end up reusing PTE-mapped THPs after fork. This
wasn't really a problem with PMD-sized THPs, because they would have to
be PTE-mapped first, but it's getting a problem with smaller THP
sizes that are effectively always PTE-mapped.

With our new "mapped exclusively" vs "maybe mapped shared" logic for
large folios, implementing CoW reuse for PTE-mapped THPs is straight
forward: if exclusively mapped, make sure that all references are
from these (our) mappings. Add some helpful comments to explain the
details.

CONFIG_TRANSPARENT_HUGEPAGE selects CONFIG_MM_ID. If we spot an anon
large folio without CONFIG_TRANSPARENT_HUGEPAGE in that code, something
is seriously messed up.

There are plenty of things we can optimize in the future: For example, we
could remember that the folio is fully exclusive so we could speedup
the next fault further. Also, we could try "faulting around", turning
surrounding PTEs that map the same folio writable. But especially the
latter might increase COW latency, so it would need further
investigation.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ef74c4f009f84..8dc241961b684 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3706,19 +3706,87 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
 	return ret;
 }
 
-static bool wp_can_reuse_anon_folio(struct folio *folio,
-				    struct vm_area_struct *vma)
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
+		struct vm_area_struct *vma)
 {
+	bool exclusive = false;
+
+	/* Let's just free up a large folio if only a single page is mapped. */
+	if (folio_large_mapcount(folio) <= 1)
+		return false;
+
 	/*
-	 * We could currently only reuse a subpage of a large folio if no
-	 * other subpages of the large folios are still mapped. However,
-	 * let's just consistently not reuse subpages even if we could
-	 * reuse in that scenario, and give back a large folio a bit
-	 * sooner.
+	 * The assumption for anonymous folios is that each page can only get
+	 * mapped once into each MM. The only exception are KSM folios, which
+	 * are always small.
+	 *
+	 * Each taken mapcount must be paired with exactly one taken reference,
+	 * whereby the refcount must be incremented before the mapcount when
+	 * mapping a page, and the refcount must be decremented after the
+	 * mapcount when unmapping a page.
+	 *
+	 * If all folio references are from mappings, and all mappings are in
+	 * the page tables of this MM, then this folio is exclusive to this MM.
 	 */
-	if (folio_test_large(folio))
+	if (folio_test_large_maybe_mapped_shared(folio))
+		return false;
+
+	VM_WARN_ON_ONCE(folio_test_ksm(folio));
+	VM_WARN_ON_ONCE(folio_mapcount(folio) > folio_nr_pages(folio));
+	VM_WARN_ON_ONCE(folio_entire_mapcount(folio));
+
+	if (unlikely(folio_test_swapcache(folio))) {
+		/*
+		 * Note: freeing up the swapcache will fail if some PTEs are
+		 * still swap entries.
+		 */
+		if (!folio_trylock(folio))
+			return false;
+		folio_free_swap(folio);
+		folio_unlock(folio);
+	}
+
+	if (folio_large_mapcount(folio) != folio_ref_count(folio))
 		return false;
 
+	/* Stabilize the mapcount vs. refcount and recheck. */
+	folio_lock_large_mapcount(folio);
+	VM_WARN_ON_ONCE(folio_large_mapcount(folio) < folio_ref_count(folio));
+
+	if (folio_test_large_maybe_mapped_shared(folio))
+		goto unlock;
+	if (folio_large_mapcount(folio) != folio_ref_count(folio))
+		goto unlock;
+
+	VM_WARN_ON_ONCE(folio_mm_id(folio, 0) != vma->vm_mm->mm_id &&
+			folio_mm_id(folio, 1) != vma->vm_mm->mm_id);
+
+	/*
+	 * Do we need the folio lock? Likely not. If there would have been
+	 * references from page migration/swapout, we would have detected
+	 * an additional folio reference and never ended up here.
+	 */
+	exclusive = true;
+unlock:
+	folio_unlock_large_mapcount(folio);
+	return exclusive;
+}
+#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
+static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
+		struct vm_area_struct *vma)
+{
+	BUILD_BUG();
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static bool wp_can_reuse_anon_folio(struct folio *folio,
+				    struct vm_area_struct *vma)
+{
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && folio_test_large(folio))
+		return __wp_can_reuse_large_anon_folio(folio, vma);
+	VM_WARN_ON_ONCE(folio_test_large(folio));
+
 	/*
 	 * We have to verify under folio lock: these early checks are
 	 * just an optimization to avoid locking the folio and freeing
-- 
2.48.1



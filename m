Return-Path: <cgroups+bounces-4590-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80D4964C75
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 19:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121D31C22D4F
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 17:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A675E1B6539;
	Thu, 29 Aug 2024 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hp2uUa3q"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4691B6532
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950767; cv=none; b=Zv7OFEcZK07q6RSSGomS4eFQij/oy/QgO7O4vS5y1jZvl8n3gE8BoKroacC6SDBhtX/+OovbScB5WGbYvKhxg3TV3jNI8qQyUSGMQFPjzr79N12i4/pL8AHxpILzYS6VQscJHO/I57U+mGj12A8tmIXwV4z+m4wbv3lhNCKUfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950767; c=relaxed/simple;
	bh=2kZ7QGLHXwtMIchnMAYhCynmld3eYgcPA3qlbJ9RCfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+CI7qxxPH2gpmUi6kILhShvhlMIs6cMoCD1PtjMDQ4BPuJPOibtXaspTG0x0CEpTXVs4m5gzhpTyuA1uyB1IoDRTAtR5HlcMoRAsvNsBEI230tQbih3E5J4Aqhe/tb9cWMknm+HhHTVfTZE8TaZdCfnIn5oywpZASq6k2JBvNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hp2uUa3q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724950765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZddLqrKBd43/r/px6zwJ3YX6SWmvbs5NWYNR2u4nCE=;
	b=hp2uUa3qOQXGIp3s8mAV5jUxMl0ABeltgXQNmatmcs1guWhxZGLyRlTt6nJ4KBeN2WB/MW
	lELXf8iL1uyp+ZjZkF5IPo5ocW3+KqiJjYSURR/QKVbmZ9e1qAJbk1TrNx9PYwVoCXRZug
	ZnxE4jA/QKvmgbZzMJDX3npujBKDW2A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-IesVcwbKN1S5VOVmE03pWw-1; Thu,
 29 Aug 2024 12:59:18 -0400
X-MC-Unique: IesVcwbKN1S5VOVmE03pWw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B545196E0A8;
	Thu, 29 Aug 2024 16:59:16 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 343891955F21;
	Thu, 29 Aug 2024 16:59:08 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	x86@kernel.org,
	linux-fsdevel@vger.kernel.org,
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
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v1 16/17] fs/proc/task_mmu: remove per-page mapcount dependency for smaps/smaps_rollup (CONFIG_NO_PAGE_MAPCOUNT)
Date: Thu, 29 Aug 2024 18:56:19 +0200
Message-ID: <20240829165627.2256514-17-david@redhat.com>
In-Reply-To: <20240829165627.2256514-1-david@redhat.com>
References: <20240829165627.2256514-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Let's implement an alternative when per-page mapcounts in large folios are
no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.

When computing the output for smaps / smaps_rollups, in particular when
calculating the USS (Unique Set Size) and the PSS (Proportional Set Size),
we still rely on per-page mapcounts.

To determine private vs. shared, we'll use folio_likely_mapped_shared(),
similar to how we handle PM_MMAP_EXCLUSIVE. Similarly, we might now
under-estimate the USS and count pages towards "shared" that are
actually "private" ("exclusively mapped").

When calculating the PSS, we'll now also use the average per-page
mapcount for large folios: this can result in both, an over-estimation
and an under-estimation of the PSS. The difference is not expected to
matter much in practice, but we'll have to learn as we go.

We can now provide folio_precise_page_mapcount() only with
CONFIG_PAGE_MAPCOUNT, and remove one of the last users of per-page
mapcounts when CONFIG_NO_PAGE_MAPCOUNT is enabled.

Document the new behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/filesystems/proc.rst | 13 +++++++++++++
 fs/proc/internal.h                 |  2 ++
 fs/proc/task_mmu.c                 | 17 +++++++++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index bed03e77c0f91..7cbab4135f244 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -504,6 +504,19 @@ Note that even a page which is part of a MAP_SHARED mapping, but has only
 a single pte mapped, i.e.  is currently used by only one process, is accounted
 as private and not as shared.
 
+Note that in some kernel configurations, all pages part of a larger allocation
+(e.g., THP) might be considered "shared" if the large allocation is
+considered "shared": if not all pages are exclusive to the same process.
+Further, some kernel configurations might consider larger allocations "shared",
+if they were at one point considered "shared", even if they would now be
+considered "exclusive".
+
+Some kernel configurations do not track the precise number of times a page part
+of a larger allocation is mapped. In this case, when calculating the PSS, the
+average number of mappings per page in this larger allocation might be used
+as an approximation for the number of mappings of a page. The PSS calculation
+will be imprecise in this case.
+
 "Referenced" indicates the amount of memory currently marked as referenced or
 accessed.
 
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 3c687f97e18c4..8c9ef19526d2b 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -143,6 +143,7 @@ unsigned name_to_int(const struct qstr *qstr);
 /* Worst case buffer size needed for holding an integer. */
 #define PROC_NUMBUF 13
 
+#ifdef CONFIG_PAGE_MAPCOUNT
 /**
  * folio_precise_page_mapcount() - Number of mappings of this folio page.
  * @folio: The folio.
@@ -173,6 +174,7 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
 
 	return mapcount;
 }
+#endif /* CONFIG_PAGE_MAPCOUNT */
 
 /**
  * folio_average_page_mapcount() - Average number of mappings per page in this
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3d9fe99346478..30306e231ff04 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -734,6 +734,8 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 	struct folio *folio = page_folio(page);
 	int i, nr = compound ? compound_nr(page) : 1;
 	unsigned long size = nr * PAGE_SIZE;
+	bool exclusive;
+	int mapcount;
 
 	/*
 	 * First accumulate quantities that depend only on |size| and the type
@@ -774,18 +776,29 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 				      dirty, locked, present);
 		return;
 	}
+
+#ifndef CONFIG_PAGE_MAPCOUNT
+	mapcount = folio_average_page_mapcount(folio);
+	exclusive = !folio_likely_mapped_shared(folio);
+#endif
+
 	/*
 	 * We obtain a snapshot of the mapcount. Without holding the folio lock
 	 * this snapshot can be slightly wrong as we cannot always read the
 	 * mapcount atomically.
 	 */
 	for (i = 0; i < nr; i++, page++) {
-		int mapcount = folio_precise_page_mapcount(folio, page);
 		unsigned long pss = PAGE_SIZE << PSS_SHIFT;
+
+#ifdef CONFIG_PAGE_MAPCOUNT
+		mapcount = folio_precise_page_mapcount(folio, page);
+		exclusive = mapcount < 2;
+#endif
+
 		if (mapcount >= 2)
 			pss /= mapcount;
 		smaps_page_accumulate(mss, folio, PAGE_SIZE, pss,
-				dirty, locked, mapcount < 2);
+				dirty, locked, exclusive);
 	}
 }
 
-- 
2.46.0



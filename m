Return-Path: <cgroups+bounces-1771-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC9785E85B
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 20:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D0B282EFB
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 19:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3DE15959D;
	Wed, 21 Feb 2024 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUa81Mik"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FD01272AD
	for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544534; cv=none; b=rhvrNPmiYFXIAiubbkHZCT2wh1/buxU1uvNoK8d+zrVV6ccxrptVCpLxkro8Z1LWgUIvtPMwqxFURUEDrnlHoU8LkkOBprUAhNJkWPj33G4EgbA/LgIPW/Bk1+xfoubCqMe45TnoJjlTfJKTd4aAl2zlEQfyPs08QYzpEIck1TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544534; c=relaxed/simple;
	bh=RoZm3YN0uynf4m5K7QVx0oQIBiXR6RrrUDV2dOeXaWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uDe3OwhNSDenR0sQoXmF4e7n+CRX/5YekRkQNuN74yt3vYWQEg8fPg4uz4oXTPlGeB5IEEkD9nmq9JivYA1xuqnIugw3fkdjblJGMR8jlpZkZXRQeAZUW/tvaZx5W0QR8brJ9Ix8vhE+c8WyEC0hzWf+5eEPTf2SH/yF27H9L+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUa81Mik; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607838c0800so1365227b3.1
        for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 11:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544530; x=1709149330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CzDIuQ0nYms/65bHZ69fKMNRRXjNNeWyOZfzFtq6j+Q=;
        b=mUa81MikPjJhddwqPszWEFwAxM2++YhzGlIw5vA/oyiFqgN3f2gvzasZ22iuJH4HLj
         b9326PiyIKpl+oepQy6pkQCseMss0a01Ho7F7GVeE34WPMLClwkgvZupI3eN8JmZgL2u
         hEQLYfZU65YuZ63cxsCurbCxy30SkZfnc4/ICNcODwyj7ZKzTpsJ68Hjeg0fFJl9gu4+
         ANqnALU7ZItlHn9GhkNTCAaP7YZI+6rA+S/ekxrhmDLIdCAwPzb5q6+fwpIL0jxrOGnl
         7c+BrIHLerDbWQ2cTsu4XP87aWHGsyAjAynnrLONq7X/sf8T/zt3fAjR0Z/RGWc1WJVW
         722g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544530; x=1709149330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzDIuQ0nYms/65bHZ69fKMNRRXjNNeWyOZfzFtq6j+Q=;
        b=YWoNrGS/CECtqBzB4hFBerd+eVgLOhdUn/3euxK6W+NfAJVdlGdbI95TwGGhNa6/uA
         Mq5QElWsI1xyoN9CRyUt1cQEjKSw0yslaSzch9Yt/3+Q53+Jbv+BUv/TIS3/9wxLW0uu
         NpCXp1Nx9yxn/LRTjm7mOsgQE1CsqXLxGXqyX+XajC7saJS8ivjqfh9CS3TLxnCYPNl5
         SANK69E+K1WrGwq98T85YZta/VeTGo/j4x/xIAcUlrld3nnnbK4Nw9olF5MXnEL7LySN
         GVY2l1Z+gzaDrU+epaOqIuxGtKhA/7S4lCMNC7+R6Pup4AvfpNjQcNXA6ByZCctGFyYO
         mo4A==
X-Forwarded-Encrypted: i=1; AJvYcCVtTB5V3wMqDNV959A2MB2ad4lJCasBaL2skgv/UjXm/iTGKT8KdnmQYtLDWKNSSOzIGOPh91aSRR9jaGghENGotQ2w7oItsg==
X-Gm-Message-State: AOJu0YyqjuQCtH3YYfuBiblUqlDiZQyaTw9Uj8IvyKdwRH2gYF3AT+lL
	yv4sv4ADor7Fjc2x8EE+DqMghF64IIrCkJMYXnAiZ8w/7I0o4JQwN/hcSJTZrHxM5jCRCRVkhni
	OJA==
X-Google-Smtp-Source: AGHT+IFe7qNCg82jNJD+RarPvS2YBMTSZ7x4HEvuAvHP+lTF13VKJQxl18VpWOGqr99d4PU9keICw1gSItE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a81:b287:0:b0:608:6b9:bf09 with SMTP id
 q129-20020a81b287000000b0060806b9bf09mr97625ywh.1.1708544529717; Wed, 21 Feb
 2024 11:42:09 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:46 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-34-surenb@google.com>
Subject: [PATCH v4 33/36] codetag: debug: mark codetags for reserved pages as empty
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To avoid debug warnings while freeing reserved pages which were not
allocated with usual allocators, mark their codetags as empty before
freeing.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/alloc_tag.h   |  1 +
 include/linux/mm.h          |  9 +++++++++
 include/linux/pgalloc_tag.h |  2 ++
 mm/mm_init.c                | 12 +++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 4a3fc865d878..64aa9557341e 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -46,6 +46,7 @@ static inline void set_codetag_empty(union codetag_ref *ref)
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline bool is_codetag_empty(union codetag_ref *ref) { return false; }
+static inline void set_codetag_empty(union codetag_ref *ref) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..b9a4e2cb3ac1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -5,6 +5,7 @@
 #include <linux/errno.h>
 #include <linux/mmdebug.h>
 #include <linux/gfp.h>
+#include <linux/pgalloc_tag.h>
 #include <linux/bug.h>
 #include <linux/list.h>
 #include <linux/mmzone.h>
@@ -3112,6 +3113,14 @@ extern void reserve_bootmem_region(phys_addr_t start,
 /* Free the reserved page into the buddy system, so it gets managed. */
 static inline void free_reserved_page(struct page *page)
 {
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			set_codetag_empty(ref);
+			put_page_tag_ref(ref);
+		}
+	}
 	ClearPageReserved(page);
 	init_page_count(page);
 	__free_page(page);
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 9e6ad8e0e4aa..7a41ed612423 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -98,6 +98,8 @@ static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
 
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
+static inline union codetag_ref *get_page_tag_ref(struct page *page) { return NULL; }
+static inline void put_page_tag_ref(union codetag_ref *ref) {}
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int order) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int order) {}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index e9ea2919d02d..6b5410a5112c 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2566,7 +2566,6 @@ void __init set_dma_reserve(unsigned long new_dma_reserve)
 void __init memblock_free_pages(struct page *page, unsigned long pfn,
 							unsigned int order)
 {
-
 	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
 		int nid = early_pfn_to_nid(pfn);
 
@@ -2578,6 +2577,17 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 		/* KMSAN will take care of these pages. */
 		return;
 	}
+
+	/* pages were reserved and not allocated */
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			set_codetag_empty(ref);
+			put_page_tag_ref(ref);
+		}
+	}
+
 	__free_pages_core(page, order);
 }
 
-- 
2.44.0.rc0.258.g7320e95886-goog



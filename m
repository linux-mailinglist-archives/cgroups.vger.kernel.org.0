Return-Path: <cgroups+bounces-5358-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A42169B863C
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 23:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB39B21CD8
	for <lists+cgroups@lfdr.de>; Thu, 31 Oct 2024 22:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0471E2829;
	Thu, 31 Oct 2024 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtLUuDIc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F021A0BD1
	for <cgroups@vger.kernel.org>; Thu, 31 Oct 2024 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414822; cv=none; b=uv2m6z6LkD/4PSPVMYS07ElK8fFxJTIP90kle0x51yulV/HD+NB0oPx5jzopOqc8gAhfyNwwXjQW8SbQAc88xU+U7hV8bGsMgBG75LSGA0lUnCD5leaOI8k1J2v6e8nkudg71KGxplxCOJF/8Vyi4DasEjtSiGGuAYrd8YNG5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414822; c=relaxed/simple;
	bh=gpNhkl8JRQNQcbUpwHiXhYHWR7awIPV7sOfZto9Xxl4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T9kCcEU/5pMgwBIWNg/73zalwSQYIImUyGytMqVNlzN4pHGbf5eYq5e7fAzwNDDrLpHDkeHjUCWNzM4+y4i0H/BZ+xNofMNQwDTIHnEpoU9V0zWUxXdyZybJkKcjpBawvfDQhy3tI07ltbbNg+pJowbo5fmM8LJOR1jWH4PH4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtLUuDIc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea6aa3b68bso1370097b3.3
        for <cgroups@vger.kernel.org>; Thu, 31 Oct 2024 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730414814; x=1731019614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=guCTOxzKlbAV7mFNRx7TvPMOy3sTYQa/R9Du6hcfImY=;
        b=vtLUuDIciTIdNaFrLiq8Ur8VsFUei7GaZIT9ePSik7jWTqdAJpzlbnvUGoAltaal8C
         eCHcQlYgR1YYg7zxglaANb4tWbG/bELvWs/D1wavBciRrzgK6NqRmtODPOXvMNGo0LPM
         qSFLgbds4GOp7VhJQCvFwmbkF+Q3Ot6711TUYesN9X3e8LwN7G5Mbxmy3RCCDJtyRgKW
         i4L2VEYAnoCCOrg216jaLaGWt/mOxIaqMA73JWuzi3oYpNtJnnn8NFe8bIrk+aCwmH7N
         Bn3Nynyikd1tR8buGM0mUywCMYBpwohaMHA1Fd2LHYnNiokC5il5upbdUerUI95Bkfub
         bN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730414814; x=1731019614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guCTOxzKlbAV7mFNRx7TvPMOy3sTYQa/R9Du6hcfImY=;
        b=gsDmzY+bKTwnr/iVXXrAKjgF+k8TXdd/9JKY9+fq89wOlIzLGI8xpJt3i25XL7IVhr
         drOWC3+s/nuWmNJgLwqz27arGaLteeXnIDdzIhTqDoozEr2syfw1URjsM1EtwF6M5exu
         ipxx83FnkMIS+yjkKHJ5uYA4xNZG6dKMaFl4Mq8wtrXj9L8LAmJmGlLH1Y7/GTLj6R7D
         4n8wUsSIjl56o8iKE16z1MmEWE0gnjrRQH/lF5u8Zc7uDUgwcdopEXawIYm4bJPpEAJg
         xKUinnwMWSeiqips9j8R9hYlPnyv3X2HA+n4D4qyFhIx11KAicLnXhCtnQq2gKx7kqRG
         OKbA==
X-Forwarded-Encrypted: i=1; AJvYcCXXbSxHsedOgfGkDRw4rXTlKLA42J6mETMZy5l/T4iku0Bq2Ich9coIyj3TkJI+b+mrjS3X8NAj@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpDGA5YyRM80nL3/h9Or1STtKguIj/p7Tl29WT6EOHHWfA5eK
	vhWtrR9ufVdm3w9LTCSuwsJuU8WQgT9D59udWC6GTxB3WW1zKz9wdfk7lN7UG7Gri7YousxtBtK
	5Ayzw2RHfog==
X-Google-Smtp-Source: AGHT+IGA5sjZe8vpyl9lON3SR0LDoe9B+CE24eA4rKmGB1vEzw7Pi4vx0K181caj3vNLVFXCXdibXtjqBQbgGQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:a1:836b:ac13:31a5])
 (user=kinseyho job=sendgmr) by 2002:a25:6b49:0:b0:e0e:8b26:484e with SMTP id
 3f1490d57ef6-e30e5b41dffmr2685276.8.1730414813939; Thu, 31 Oct 2024 15:46:53
 -0700 (PDT)
Date: Thu, 31 Oct 2024 22:45:50 +0000
In-Reply-To: <20241031224551.1736113-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031224551.1736113-1-kinseyho@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031224551.1736113-2-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 1/2] mm: add generic system-wide page counters
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Rientjes <rientjes@google.com>, willy@infradead.org, Vlastimil Babka <vbabka@suse.cz>, 
	David Hildenbrand <david@redhat.com>, Kinsey Ho <kinseyho@google.com>, 
	Joel Granados <joel.granados@kernel.org>, Kaiyang Zhao <kaiyang2@cs.cmu.edu>, 
	Sourav Panda <souravpanda@google.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

commit f4cb78af91e3 ("mm: add system wide stats items category") and
commit 9d8573111024 ("mm: don't account memmap per-node") renamed
NR_VM_WRITEBACK_STAT_ITEMS to NR_VM_STAT_ITEMS to track
memmap/memmap_boot pages system wide.

Extend the implementation so that the system wide page statistics can
be tracked using a generic interface. This patch is in preparation for
the next patch which adds a rarely modified system wide vmstat.

Note that this implementation uses global atomic fields with no per-cpu
optimizations as the existing usecase (memmap pages) is rarely modified
as well.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 include/linux/vmstat.h |  8 ++++++++
 mm/vmstat.c            | 32 +++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index d2761bf8ff32..ac4d42c4fabd 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -145,6 +145,11 @@ extern atomic_long_t vm_zone_stat[NR_VM_ZONE_STAT_ITEMS];
 extern atomic_long_t vm_node_stat[NR_VM_NODE_STAT_ITEMS];
 extern atomic_long_t vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
 
+/*
+ * Global page accounting (no per cpu differentials).
+ */
+extern atomic_long_t vm_global_stat[NR_VM_STAT_ITEMS];
+
 #ifdef CONFIG_NUMA
 static inline void zone_numa_event_add(long x, struct zone *zone,
 				enum numa_stat_item item)
@@ -491,6 +496,9 @@ static inline void node_stat_sub_folio(struct folio *folio,
 	mod_node_page_state(folio_pgdat(folio), item, -folio_nr_pages(folio));
 }
 
+void mod_global_page_state(enum vm_stat_item item, long nr);
+unsigned long global_page_state(enum vm_stat_item item);
+
 extern const char * const vmstat_text[];
 
 static inline const char *zone_stat_name(enum zone_stat_item item)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 22a294556b58..e5a6dd5106c2 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -161,9 +161,11 @@ void vm_events_fold_cpu(int cpu)
  */
 atomic_long_t vm_zone_stat[NR_VM_ZONE_STAT_ITEMS] __cacheline_aligned_in_smp;
 atomic_long_t vm_node_stat[NR_VM_NODE_STAT_ITEMS] __cacheline_aligned_in_smp;
+atomic_long_t vm_global_stat[NR_VM_STAT_ITEMS] __cacheline_aligned_in_smp;
 atomic_long_t vm_numa_event[NR_VM_NUMA_EVENT_ITEMS] __cacheline_aligned_in_smp;
 EXPORT_SYMBOL(vm_zone_stat);
 EXPORT_SYMBOL(vm_node_stat);
+EXPORT_SYMBOL(vm_global_stat);
 
 #ifdef CONFIG_NUMA
 static void fold_vm_zone_numa_events(struct zone *zone)
@@ -1033,22 +1035,34 @@ unsigned long node_page_state(struct pglist_data *pgdat,
 }
 #endif
 
+void mod_global_page_state(enum vm_stat_item item, long nr)
+{
+	atomic_long_add(nr, &vm_global_stat[item]);
+}
+
+unsigned long global_page_state(enum vm_stat_item item)
+{
+	long x = atomic_long_read(&vm_global_stat[item]);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
+}
+
 /*
  * Count number of pages "struct page" and "struct page_ext" consume.
- * nr_memmap_boot_pages: # of pages allocated by boot allocator
- * nr_memmap_pages: # of pages that were allocated by buddy allocator
+ * NR_MEMMAP_BOOT_PAGES: # of pages allocated by boot allocator
+ * NR_MEMMAP_PAGES: # of pages that were allocated by buddy allocator
  */
-static atomic_long_t nr_memmap_boot_pages = ATOMIC_LONG_INIT(0);
-static atomic_long_t nr_memmap_pages = ATOMIC_LONG_INIT(0);
-
 void memmap_boot_pages_add(long delta)
 {
-	atomic_long_add(delta, &nr_memmap_boot_pages);
+	mod_global_page_state(NR_MEMMAP_BOOT_PAGES, delta);
 }
 
 void memmap_pages_add(long delta)
 {
-	atomic_long_add(delta, &nr_memmap_pages);
+	mod_global_page_state(NR_MEMMAP_PAGES, delta);
 }
 
 #ifdef CONFIG_COMPACTION
@@ -1880,8 +1894,8 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 
 	global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
 			    v + NR_DIRTY_THRESHOLD);
-	v[NR_MEMMAP_PAGES] = atomic_long_read(&nr_memmap_pages);
-	v[NR_MEMMAP_BOOT_PAGES] = atomic_long_read(&nr_memmap_boot_pages);
+	for (int i = NR_MEMMAP_PAGES; i < NR_VM_STAT_ITEMS; i++)
+		v[i] = global_page_state(i);
 	v += NR_VM_STAT_ITEMS;
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
-- 
2.47.0.163.g1226f6d8fa-goog



Return-Path: <cgroups+bounces-14883-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHLKC4wnu2kcfwIAu9opvQ
	(envelope-from <cgroups+bounces-14883-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:30:36 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C47912C3629
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 935C53141BD3
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C670372ED7;
	Wed, 18 Mar 2026 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ5NQ5TP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF03793C5
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873000; cv=none; b=hd0jgoad2WRmvYciWO9qS93dZgRxiZ+ogNm3SX62b0QjzBGA5F+D3hiy4R2lOaNdcT0jKsN9YbKrME+S97fpWM1wrRqYDo7OM4iV/ED8UfVhu/x5Oyj2kcCQXbXK0oQuDlfNXwYTqQMfbvpjwSjc5xllS8v3EwEjC8YKjVycikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873000; c=relaxed/simple;
	bh=E7IvwqT01r9Y9AARhPTA4kVsR7QTb37BUUQJU1OMnqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhqhafGl4uLch05ukxctWo8U8T7q5dlvEWx9HEGN3vMpBx9zOSIszAGwoB4wb0qRC7bxIhCxDcFTexRGoIHHgJ7MmX9LY8AJBioBVFgLUoqWiQZLGA4Z3FgzIFk6DU+rTliXKbuBYAoGzl0m0P1bHO4hK5SY5UiIUOq7IRNAWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ5NQ5TP; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-404254ffe8aso246137fac.0
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773872997; x=1774477797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQz9gXtG0BjRbamDLXajf4zSV33YchOog2Zf6fZXOug=;
        b=IQ5NQ5TPksFfcPor3JfPJ8aYfq0xx8nRd29UIfQw10u8vIU0Hopyf9WpnHff+55Cav
         Hkf44AQEAcYfyGDr0DFFXOsN4zC1o8aBWV5H6zkpwlzYhvniu78hi68znf1kKLRJb1hA
         z6z7Y6Kjvevm3qdgmCFOuKtEDQuv9Y5d1VDhq1u5uG0Bc2hempmUpZ9R/thlxhMBdBVs
         s3bI6l/K+H1/bebyUhbGdIdMkxIXy8mtKbpfFoFkVEzUbBQDWoIb7Z1TVlmgsR2bkpVx
         FzEA9fPw3dflWBH2+uKHg2QhcvD08Qb4vSYzbGIup4hBWsjYdbG89NpizUeWDaLHvxVk
         HvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773872997; x=1774477797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQz9gXtG0BjRbamDLXajf4zSV33YchOog2Zf6fZXOug=;
        b=gq4575AZHtfynC0gINJ/N8hMvdJ1h2SpkkPlac3VwfNwLpktHhwr8kpulxWNOPgPzG
         0HMOFslCEyp6/QYwBjdxrR2yHXGt8JMNJov6cYtgNHycLGxPCzMA8knqjDTJ4YqZf9kp
         2N7VhmPP4QyjljVlvdri2K+fL1as0AjVhUGfyzjIrvwcqgGCR2uUbbtFOcg8zrbSSqi9
         CmDrcIhYyEqizLWtY4BEx08EcMo/7h3m7Xt5/vlYjZ7UXUah8Eg7zk60HAcrLczE9jPF
         8zqnOkz/diWJajlFqZ5K+hr5sZsKwAa0uJETWEKKjVptO3vx6faSwOC7TZ6aGnG5rQQi
         uUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwQH1xMMhKi3CjNjzqlWc879I1pmnxxbqiU3E37/HHtkJlcVkdIPQroPPtjqY6kZEByb6uNy24@vger.kernel.org
X-Gm-Message-State: AOJu0YwsP+HrNhllHLI8gYqIFE5BmZQDWBfFJl8j4I95ZITDgSAlPmbO
	Pf5U8odppqyyG877aDiIMYwHnXc2Ldxq1P49G/eSKIy5mWIHTLPUzc2s
X-Gm-Gg: ATEYQzzv/Mpmzcd7cwmHrW+Bpbe3pj6QNTgnBnpyuSxzww+VNGvgJfh0KGbkufpihQ1
	JLyauUlf4iDm4MueQA917Vh/dIT/PW6jtrwYszcCfLj1tFQS939nxCYscJREacqPPawt4GBv/R4
	hU1YpUuAZaLzA1ri4I8+gCdXwGlM11d50mZepujUjn/lZDyAdQ/8ikvHJrmxpo2K3adwTuB+cNt
	n/pdIlNh8rugd1loWBg4e4K13NEFSvWSnbU3sFq9sUBqv1qfmd0Y0p9/+znDRLnSpjpjPK+7Zmt
	kDsRK/gDTN6isuJ2fRveJRRHE+afLPi7b2AuqoK2W/cH503DADDDWNA/nFeXZs2l8O29WB3+mPV
	3lG1U158rPyPdD4F6Fz/HtnjX1LXhVzfREUntRue+zE351NbLIkzU7ODbVMNB6NJSG6WGnILvlO
	Di+FQn1hlZ0QDwdJIxwBHkqQI0RpZ4L4I1AqBlcbzriQDWWA==
X-Received: by 2002:a05:6871:a18e:b0:417:3689:a380 with SMTP id 586e51a60fabf-41befea5a0emr635307fac.16.1773872997245;
        Wed, 18 Mar 2026 15:29:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd2cbcdb4sm4009222fac.13.2026.03.18.15.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:29:56 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	nphamcs@gmail.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	kernel-team@meta.com,
	riel@surriel.com
Subject: [PATCH v4 02/21] swap: rearrange the swap header file
Date: Wed, 18 Mar 2026 15:29:33 -0700
Message-ID: <20260318222953.441758-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318222953.441758-1-nphamcs@gmail.com>
References: <20260318222953.441758-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14883-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.791];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C47912C3629
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the swap header file (include/linux/swap.h), group the swap API into
the following categories:

1. Lifecycle swap functions (i.e the function that changes the reference
   count of the swap entry).

2. Swap cache API.

3. Physical swapfile allocator and swap device API.

Also remove extern in the functions that are rearranged.

This is purely a clean up. No functional change intended.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h | 53 +++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 38ca3df687160..aa29d8ac542d1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -423,20 +423,34 @@ extern void __meminit kswapd_stop(int nid);
 
 #ifdef CONFIG_SWAP
 
-int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
-		unsigned long nr_pages, sector_t start_block);
-int generic_swapfile_activate(struct swap_info_struct *, struct file *,
-		sector_t *);
-
+/* Lifecycle swap API (mm/swapfile.c) */
+int folio_alloc_swap(struct folio *folio);
+bool folio_free_swap(struct folio *folio);
+void put_swap_folio(struct folio *folio, swp_entry_t entry);
+void swap_shmem_alloc(swp_entry_t, int);
+int swap_duplicate(swp_entry_t);
+int swapcache_prepare(swp_entry_t entry, int nr);
+void swap_free_nr(swp_entry_t entry, int nr_pages);
+void free_swap_and_cache_nr(swp_entry_t entry, int nr);
+int __swap_count(swp_entry_t entry);
+bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
+int swp_swapcount(swp_entry_t entry);
+
+/* Swap cache API (mm/swap_state.c) */
 static inline unsigned long total_swapcache_pages(void)
 {
 	return global_node_page_state(NR_SWAPCACHE);
 }
-
-void free_swap_cache(struct folio *folio);
 void free_folio_and_swap_cache(struct folio *folio);
 void free_pages_and_swap_cache(struct encoded_page **, int);
-/* linux/mm/swapfile.c */
+void free_swap_cache(struct folio *folio);
+
+/* Physical swap allocator and swap device API (mm/swapfile.c) */
+int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
+		unsigned long nr_pages, sector_t start_block);
+int generic_swapfile_activate(struct swap_info_struct *, struct file *,
+		sector_t *);
+
 extern atomic_long_t nr_swap_pages;
 extern long total_swap_pages;
 extern atomic_t nr_rotate_swap;
@@ -452,26 +466,15 @@ static inline long get_nr_swap_pages(void)
 	return atomic_long_read(&nr_swap_pages);
 }
 
-extern void si_swapinfo(struct sysinfo *);
-int folio_alloc_swap(struct folio *folio);
-bool folio_free_swap(struct folio *folio);
-void put_swap_folio(struct folio *folio, swp_entry_t entry);
-extern swp_entry_t get_swap_page_of_type(int);
-extern int add_swap_count_continuation(swp_entry_t, gfp_t);
-extern void swap_shmem_alloc(swp_entry_t, int);
-extern int swap_duplicate(swp_entry_t);
-extern int swapcache_prepare(swp_entry_t entry, int nr);
-extern void swap_free_nr(swp_entry_t entry, int nr_pages);
-extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
+void si_swapinfo(struct sysinfo *);
+swp_entry_t get_swap_page_of_type(int);
+int add_swap_count_continuation(swp_entry_t, gfp_t);
 int swap_type_of(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
-extern unsigned int count_swap_pages(int, int);
-extern sector_t swapdev_block(int, pgoff_t);
-extern int __swap_count(swp_entry_t entry);
-extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
-extern int swp_swapcount(swp_entry_t entry);
+unsigned int count_swap_pages(int, int);
+sector_t swapdev_block(int, pgoff_t);
 struct backing_dev_info;
-extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
+struct swap_info_struct *get_swap_device(swp_entry_t entry);
 sector_t swap_folio_sector(struct folio *folio);
 
 static inline void put_swap_device(struct swap_info_struct *si)
-- 
2.52.0



Return-Path: <cgroups+bounces-7922-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D49AA3CA5
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247281B66F98
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98902E62AF;
	Tue, 29 Apr 2025 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnDZeZlS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25502E3365;
	Tue, 29 Apr 2025 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969942; cv=none; b=Bvkk2yLKSO/YjvUUkyZJXB1T6agkY8gxTD/N+E5MmD1Pf8e1n69S3+m/KqZejvWoQABoAKt0rRtokDf6No6huipSbvZlFNWAuGxUfNfEgSJr49N5ic7zfgzfTkNLfBArzGDwGpdw68rl5pbW6Le4IbMpwLlkIwcASmcxeF7tEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969942; c=relaxed/simple;
	bh=nh5sXd7001T9p5XYT6xTzXrfxlVThNejp4CgBjL9AYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv3WuQEOsb2+h1RXnV55o7aiQM7xoS7mv83QtloXpaP/sDR6u1DWLoqMJ42taWljPBk7MsgZlVbMO7nnGcou71JlljGx9q5eeLWwp4Q6YN430KOuNUAhPem4F8LfCYWaBpey7qTTw1MSdbP5En1P89cRehIv8u5kCs0+db/LImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnDZeZlS; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70811611315so57367227b3.1;
        Tue, 29 Apr 2025 16:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969939; x=1746574739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFhHSkDxJzypIaqtTPtajYYCWi+xgmJi1aAEQUZ9t58=;
        b=bnDZeZlStQ6fB45Zw5nh0i15si0taml3Mkq80l9bQ9lQ+AzWWH7BNGOjJ+RYy13ekx
         ulJWnnGxn7aEHlfL/NwXv7obK9x95cjd7lkY0QIrtepSkvUC4NAq1o75Id2VVpGrE/as
         zezCcN3VXfLEomveuA26ZDNb240zk4vT63flEQLNpso8p2S+Dw+RiQL6obc4j/0boOpH
         1sLnyOhJQS/rqBsIbDMPQgg/bH9BChlm1D4CMgPRz7nIpVQnib+0xKqIaMR3FPdhlB4I
         3WAR9XHcEK0KhvM9jd2P1PufoImoN7f2vZWN0PXeZAM1LuKxSc2Wx7C58iMAJsbphX7q
         ZIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969940; x=1746574740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFhHSkDxJzypIaqtTPtajYYCWi+xgmJi1aAEQUZ9t58=;
        b=hCE5WoprtcfIPAvqXbTuj3vEM7JiNRBFMf70pcsNflHRv+2gMf5jPxA8S8qqvMK8gG
         i1xE7rzM7ikuuRXzIYcjayWi+JvpRDiWyVvfjuuVKiGpoimeM1MqjBBgfmqjqtSMupRI
         mYhlBh4cIl58MUTjx6/W3itxfJaM3jHu3McEUe0U8PonEWnsgbQxaTmwCmwtDQSyNAIx
         g3mGM1qIUZP2uWYdJ7BqKQFYt2Vd5hFG70ecR+TjyUfphwXEcgPr3oismRIU2TGUDKb7
         HWF4jJXfKWH+E89KV/vuPFNb6RhUR6gLCGKBaOurO9JM5j2bPzd2DuTGkHUECYob3d/n
         KmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSBXQHfAq2KMxn9ilaBc6SWr25t+cYl0YXRp4UjCowtiUQSqp8shf7EJHnW+/aO8Qf91oqrdjh5pM=@vger.kernel.org, AJvYcCVz0at2fgPp/9m24ZPa6Z+Xt6ZIXMgncGHwCbzWDq2T7kGcU5ldqMSK2SdMtjTcZuWzoyUxEP/pP6oI8qX/@vger.kernel.org, AJvYcCXJxugLxYY0Z6uKuPvN09yUBSNy3UFDQrO/PyJTYWum3uNID5K/wjtteoDmrUAorwuyRZJ2cIYD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0zgMZyd3hA6mg3Lktky+VMEN7+up5IiLvoIzmEWei8zaU8brU
	64B4m/iOeNEdPi5bKg26ArrlQB/yyj5TdRVdkShwVsrP5NrweW8J
X-Gm-Gg: ASbGncukjoxcKoSrnajZQ/YCMXnXIwLaKt/ouY12/PGtIPIEVr0Dqqlu7xEbGFT/zfs
	H5r1MNBjtRSSDNcyZgv1437TnrFuVMG+aMsV2MgmzFWqPNS00kZjB3AoM3MV8Xk15b5kPrclt02
	/eEfPgFhaA7RzgPTi5PuvYK3aFwiulTdhZLl20aeNJRTl56zrZpGNArdDrhtxYxDEjELuQvMy1W
	afc/lwJlTsm88enjj/YEAQNtWzeuvzcCyAF4U1tjieEN1ZyNAsa1+Iy18LjDWWcIdRG49RdiMpO
	d41OJpLkVVNOcYK4dmOO8y4Vb8rHdMA=
X-Google-Smtp-Source: AGHT+IHTUZTqhcYgGJbQPuDnVTu9sU6OrQRADCC7lMuDWvnweWgrgBFJr5UsG76GOWcxTplwIkyh3g==
X-Received: by 2002:a05:690c:6a05:b0:702:5920:c3c8 with SMTP id 00721157ae682-708ad5c4c7emr9892907b3.8.1745969939647;
        Tue, 29 Apr 2025 16:38:59 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708ae1b429esm724327b3.74.2025.04.29.16.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 16:38:59 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com
Subject: [RFC PATCH v2 11/18] mm: swap: temporarily disable THP swapin and batched freeing swap
Date: Tue, 29 Apr 2025 16:38:39 -0700
Message-ID: <20250429233848.3093350-12-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429233848.3093350-1-nphamcs@gmail.com>
References: <20250429233848.3093350-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable THP swapin on virtual swap implementation, for now. Similarly,
only operate on one swap entry at a time when we zap a PTE range. There
is no real reason why we cannot build support for this in the new
design. It is simply to make the following patch, which decouples swap
backends, smaller and more manageable for reviewers - these capabilities
will be restored in a following patch.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/internal.h | 16 ++++++++--------
 mm/memory.c   |  4 +++-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index ca28729f822a..51061691a731 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -268,17 +268,12 @@ static inline swp_entry_t swap_nth(swp_entry_t entry, long n)
 	return (swp_entry_t) { entry.val + n };
 }
 
-/* similar to swap_nth, but check the backing physical slots as well. */
+/* temporary disallow batched swap operations */
 static inline swp_entry_t swap_move(swp_entry_t entry, long delta)
 {
-	swp_slot_t slot = swp_entry_to_swp_slot(entry), next_slot;
-	swp_entry_t next_entry = swap_nth(entry, delta);
-
-	next_slot = swp_entry_to_swp_slot(next_entry);
-	if (swp_slot_type(slot) != swp_slot_type(next_slot) ||
-			swp_slot_offset(slot) + delta != swp_slot_offset(next_slot))
-		next_entry.val = 0;
+	swp_entry_t next_entry;
 
+	next_entry.val = 0;
 	return next_entry;
 }
 #else
@@ -349,6 +344,8 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
  * max_nr must be at least one and must be limited by the caller so scanning
  * cannot exceed a single page table.
  *
+ * Note that for virtual swap space, we will not batch anything for now.
+ *
  * Return: the number of table entries in the batch.
  */
 static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
@@ -363,6 +360,9 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 	VM_WARN_ON(!is_swap_pte(pte));
 	VM_WARN_ON(non_swap_entry(entry));
 
+	if (IS_ENABLED(CONFIG_VIRTUAL_SWAP))
+		return 1;
+
 	cgroup_id = lookup_swap_cgroup_id(entry);
 	while (ptep < end_ptep) {
 		pte = ptep_get(ptep);
diff --git a/mm/memory.c b/mm/memory.c
index a8c418104f28..2a8fd26fb31d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4230,8 +4230,10 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	 * A large swapped out folio could be partially or fully in zswap. We
 	 * lack handling for such cases, so fallback to swapping in order-0
 	 * folio.
+	 *
+	 * We also disable THP swapin on the virtual swap implementation, for now.
 	 */
-	if (!zswap_never_enabled())
+	if (!zswap_never_enabled() || IS_ENABLED(CONFIG_VIRTUAL_SWAP))
 		goto fallback;
 
 	entry = pte_to_swp_entry(vmf->orig_pte);
-- 
2.47.1



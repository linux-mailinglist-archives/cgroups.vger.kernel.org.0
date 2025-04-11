Return-Path: <cgroups+bounces-7490-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34695A868D1
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 00:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD44F1BA5E99
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 22:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F69C2BD597;
	Fri, 11 Apr 2025 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LZ6ak8wR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD932BE7DE
	for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744409500; cv=none; b=IF/qlGaQpy7UFn8mRHHUQBxdMZKbuwT3aj3EjtqzC0xEYEFBvAdz2z13ie595niEEsKfTUGJ4DyGoXuFn2nbmEhWdyyuwBDh7Zed2dVaW3Hn8IIwRMLE0aC/DxdcK6nfSem/MzCyR/Q9tmlg9Wm+hmRTeOB2zEWqw2vUFDFpC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744409500; c=relaxed/simple;
	bh=iipUogHWKqbSnD4CjJCUz99hy1w9mLc5GhkbwJjFgE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRQDbgBRWnMCgs+6mlzORLYEK5OdIK3bFUpZNwo2k+NTYdH6lbS0OwzkDNwKVBtYIJ4tZ8f1W59IjvgsPQM1rlSA4b3qDM+aqTgr/2Kzu9LkS0teHa/UxOFXTxduVkGHsTbdEQWBzDKK0e0JVCIrF8E+1vgvGpGzmiQW8MVeMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LZ6ak8wR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be49f6b331so283318985a.1
        for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 15:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744409498; x=1745014298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWwZ2vfL+KhsRUswnAKZ8QRNf9jCtW28RDZA6bxWNqI=;
        b=LZ6ak8wR1fshCx0fXAjvmT/MFyk5V3oySomvy27rN65222y2m+kiIAq7DC0VBJWW95
         9qXTGAq+4CFncw+tOmtqQRAmU4IlOkz/f6FJErAmD0HJo+mwY4OhqS5HNLBqqPlYGspl
         yda+kscupelujuOAG00hQPejteMZrfi5NXXKf9WXq9A1tRqgqaXYMkLXjY/bL64ni02S
         nYNNRo2QI2ILeXJMUcBrcx4TlAgzUJjNcqrbuHyyY1vXRWFzuYw+dXMmwAY4vCeD9ifl
         /X990Ptl41isNUeFi7rFioLVSgiFhwl7jHFtJLrbh/XW8XjGRfI7vvmrEzJnHFnTL2uO
         gqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744409498; x=1745014298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWwZ2vfL+KhsRUswnAKZ8QRNf9jCtW28RDZA6bxWNqI=;
        b=AqcclouCkWiA4ZCo8qCWR7w2bHTgYazl67h9Lf+D+s5iSBFlskUkfWUrArNpmsWcCQ
         RtFXsghNhYBgFNeJ6tHCtc16D1Y0a+Z75bmS0lldPuCUsls0rcb+bE4K63KP4oDjexHT
         dzORDLvtwGfX3az/gT7Ej7hbqCFhU8YdjPXnt1YohrXypE0HgsiGx4Gt5NiBn/sneY1p
         /2feUU0EjPZH6PFDFKU3qOybTOEuXS+BW1CryNqOY98ZRVPmwVMPttt562Xvxl+k0B/3
         eraChtSzYVagIa/HqeiiTX67tO0DKCXa9SJkbQb7RJ7ZUfIrfIFUXPjZFW7rjkudo1HD
         vQkg==
X-Gm-Message-State: AOJu0Yy6ZGv8k8oNqt6OnjY4dpQ5PErDUJY9/77qm5K3k5YxwEsv8SNJ
	xz5lrnufsS/3JiQNqRCCAzUi9insg/7rdJ6uTZCOzxHlOwIxy/gMh3OzEysZk2A=
X-Gm-Gg: ASbGnct4lKiIGak3UrgLhe32ofGrngquiwSLFXFwdpfpUqxZEnROumkAddjDoLiPboE
	7UpG+NPnuDJCN7BoOfseisBdNNR7ZsGvReZjJl/qBaAC1lt/YXQlHqQagiS6k4pTtBjX7FEYXE0
	FpndCFtoIlsOYciacoDYIuAFg96Xvf5bnO+eR5PAIZhXlF/ryqVQz0Nnkqd6L29yNPxBmBmySNL
	Uk/gfxTw00BP85q8obs+Pf2oxFQUqh2Ne7nDUyiKUgFT066nFUdjkEyJyyeMYX2XyQ5C3zv62rD
	Bg+cqkK9F8RXBkzAc3UcQ8pZz/hT2BOBpGeLt1hTZUoLTR2TRhkSVg7BYuZwHtxQQX6waBNqAtT
	szKI9HGLY14vk0n6Mq13N1t/mpRbD
X-Google-Smtp-Source: AGHT+IGLtJZR0JJVKRILz/ZiqYmeVboSBH4PK1DJ0UoO9oX8aCb9uz98PkTHNKxCb1p4ZJETUczmng==
X-Received: by 2002:a05:620a:3913:b0:7c7:a602:66ee with SMTP id af79cd13be357-7c7af0bd2fbmr513370685a.10.1744409497970;
        Fri, 11 Apr 2025 15:11:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8943afcsm321264485a.16.2025.04.11.15.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 15:11:37 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	donettom@linux.ibm.com
Subject: [RFC PATCH v4 6/6] mm/swap.c: Enable promotion of unmapped MGLRU page cache pages
Date: Fri, 11 Apr 2025 18:11:11 -0400
Message-ID: <20250411221111.493193-7-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411221111.493193-1-gourry@gourry.net>
References: <20250411221111.493193-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Donet Tom <donettom@linux.ibm.com>

Extend MGLRU to support promotion of page cache pages.

An MGLRU page cache page is eligible for promotion when:

1. Memory Tiering and pagecache_promotion_enabled are enabled
2. It resides in a lower memory tier.
3. It is referenced.
4. It is part of the working set.
5. folio reference count is maximun (LRU_REFS_MASK).

When a page is accessed through a file descriptor, folio_inc_refs()
is invoked. The first access will set the folio’s referenced flag,
and subsequent accesses will increment the reference count in the
folio flag (reference counter size in folio flags is 2 bits). Once
the referenced flag is set, and the folio’s reference count reaches
the maximum value (LRU_REFS_MASK), the working set flag will be set
as well.

If a folio has both the referenced and working set flags set, and its
reference count equals LRU_REFS_MASK, it becomes a good candidate for
promotion. These pages will be added to the promotion list. The
per-process task task_numa_promotion_work() takes the pages from the
promotion list and promotes them to a higher memory tier.

In the MGLRU, for folios accessed through a file descriptor, if the
folio’s referenced and working set flags are set, and the folio's
reference count is equal to LRU_REFS_MASK, the folio is lazily
promoted to the second oldest generation in the eviction path. When
folio_inc_gen() does this, it clears the LRU_REFS_FLAGS so that
lru_gen_inc_refs() can start over.

Test process:
We measured the read time in below scenarios for both LRU and MGLRU.
Scenario 1: Pages are on Lower tier + promotion off
Scenario 2: Pages are on Lower tier + promotion on
Scenario 3: Pages are on higher tier

Test Results MGLRU
----------------------------------------------------------------
Pages on higher   | Pages Lower tier |  Pages on Lower Tier    |
   Tier           |  promotion off   |   Promotion On          |
----------------------------------------------------------------
  0.48s           |    1.6s          |During Promotion - 3.3s  |
                  |                  |After Promotion  - 0.48s |
                  |                  |                         |
----------------------------------------------------------------

Test Results LRU
----------------------------------------------------------------
Pages on higher   | Pages Lower tier |  Pages on Lower Tier    |
   Tier           |  promotion off   |   Promotion On          |
----------------------------------------------------------------
   0.48s          |    1.6s          |During Promotion - 3.3s  |
                  |                  |After Promotion  - 0.48s |
                  |                  |                         |
----------------------------------------------------------------

MGLRU and LRU are showing similar performance benefit.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 mm/swap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 382828fde505..3af2377515ad 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -399,8 +399,13 @@ static void lru_gen_inc_refs(struct folio *folio)
 
 	do {
 		if ((old_flags & LRU_REFS_MASK) == LRU_REFS_MASK) {
-			if (!folio_test_workingset(folio))
+			if (!folio_test_workingset(folio)) {
 				folio_set_workingset(folio);
+			} else if (!folio_test_isolated(folio) &&
+				  (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+				   numa_pagecache_promotion_enabled) {
+				promotion_candidate(folio);
+			}
 			return;
 		}
 
-- 
2.49.0



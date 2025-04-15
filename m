Return-Path: <cgroups+bounces-7574-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EFBA8923F
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99E93B7C14
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028582356C7;
	Tue, 15 Apr 2025 02:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kPovSJD3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B32206B2
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685308; cv=none; b=pCdJA7QD7p+wNNZDd+mW/PCOzwlj1BUjF7tjhMkJtdaTWsORfPtCbgA8V5Ks3I0Iosc9obwxL6r3LcJKLhnS0ptQrLdcvSICAk2u3nE9GuBPyu2ooLgiytwFyNdryVLppuIEMjsa2z8ngaC9e0+IyQzBCLYIoVyJET5bf5E8Izk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685308; c=relaxed/simple;
	bh=qfxs19SK10slyUO0O8nR8PbPqoZ9Hjoq9tzPkm4Mjx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rGuOLSOintXvle5Z4jBEYBMHSrVHazti02rzJ2tTQTwfxphW8ifh28aNHwV894/M1ckQDCd6gcYZ97XcDJNbidzJ4JGJ81Hdu1gu5OAHo6DskZZWUIsTaoJBN85xIIJx7iiCVS5YnldKt/DpbVkqAqSY8Taz5CApOmlAkYj0aIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kPovSJD3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af908bb32fdso4362999a12.1
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685306; x=1745290106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXOKqlBcK7wmw0vjxin9AD5vy+d1LV8LiFHk+wC2Q/0=;
        b=kPovSJD3T5k4Wp3/2QgSI2nVOJlsPBaE/mXyRp1yP1T6zU6bqQUUZhSFpTkX92hAp8
         NyKFgvPOrkxzi5h02VVY1TgrEU+jwsbJm0BiQGSySJje5M4WwzU1K1u25UeFfTywUP97
         ObhZIdxypCfmdzJrM8KfHu9aXX5KGFjt4qIwEp6W2pX0QTsyCiKNq9vOO6QkMOnJejmO
         w4lConQT8sno2bzPxgMaf0kL70BTNgxcIEnEC8q0/WeP+HYuiI5PJ9INtcTnXu4Dexs3
         wMj8VW4BUoQ0FhMw5HKji0VvypzhV6GrLBFUpo/OdljAHn/BA9L/ZhGX1aA76DUGKcip
         7IkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685306; x=1745290106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXOKqlBcK7wmw0vjxin9AD5vy+d1LV8LiFHk+wC2Q/0=;
        b=tnTnJ6QgjvjL/xhks4lmK+aUSVfH1jSiC7B//7eXO+WXi8NZ5SLe4e0GFH+M7RMAjf
         TqI7VCCvfC/1wcd5DptSXytHJVT5+mD3j9WXyUF9wNhKWSjj1qrU3L7zS4I4aqOQHIFQ
         yoU3i2l7kaJDQB2GRJHERMIXfdUxmB8j8LORpKbOs2MyyrF3wDgxGWA2J/csqKZDrU69
         j2Euy6lUxM+gwpF7QPA5gjyIElosBpUgxnpEeonPDtRcXiaAoyoGLhy3N/Y7Opsy0XBb
         MDnW3mJO9WZfQO7zHVBJtdnimb3dTMFuQZJmAVLQZaE+PWkYvssuVY4Fqfx/GSIHVr36
         4kyw==
X-Forwarded-Encrypted: i=1; AJvYcCVNA0Xadt+qwtxGmFOCCNCH0qpnR9YnDVGi/YJM0RyJHCw+Ae3l931AJli08o2uyewiepubOczw@vger.kernel.org
X-Gm-Message-State: AOJu0YytHLqc6Ve0DM69upkE6EJ7UhUETRLUJFOF5DUM21sxWhpRhKFn
	ZzhpLsTC509PS2KiBkUlMGbfZuNOIUuXGvYjFon7+BLxUXk04MjsdKYHliIOficlt6kuCYKpuqx
	9AiqQCA==
X-Gm-Gg: ASbGncukEmslNoiy3VEJD9mOuhKnLPjGqAV6X1loF+Bv/euft4haYoxobu8lwwtMx+A
	3SB+vCcNo2e7Pqd2mp9wkRxMk3QdnDxCdLwfMVwKoTddFbgFjpGdbVXu63TLSTwP/N4pnCWrxZC
	Lxmq7DE7qGKTnI6PSLFg/KbprJlRc7+nyQq+O9EUVO8WLlImCMfimVKBYK8GgDgxrdAy3Ndug6f
	gbaTdF4H9+DqLs8sXENOpUX88Oex5VbtBhep5HNYruzGwiaGa486c4jIbaQjEyJ/NUAJWBq2Pjd
	tTbafAXWjhWW6RDCKKdjiSDS0oZl+Dgeh5R0+1WTPGEObTqwoOCsR047oq9eJr5Qjn3ETY0UUlO
	gITxkXJs=
X-Google-Smtp-Source: AGHT+IH7xXBf+pSvn3kHgRy6uEQ3xLaVZ8ScWHSC0IXjydDRK6JttBy5tPzuwSPN3xTseySeCrXp4w==
X-Received: by 2002:a17:90b:28d0:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-3084f3d2a3amr2508095a91.15.1744685306495;
        Mon, 14 Apr 2025 19:48:26 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.48.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:48:26 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 28/28] mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers
Date: Tue, 15 Apr 2025 10:45:32 +0800
Message-Id: <20250415024532.26632-29-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We must ensure the folio is deleted from or added to the correct lruvec list.
So, add VM_WARN_ON_ONCE_FOLIO() to catch invalid users. The VM_BUG_ON_PAGE()
in move_pages_to_lru() can be removed as add_page_to_lru_list() will perform
the necessary check.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/mm_inline.h | 6 ++++++
 mm/vmscan.c               | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f9157a0c42a5..f36491c42ace 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -341,6 +341,8 @@ void lruvec_add_folio(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	if (lru_gen_add_folio(lruvec, folio, false))
 		return;
 
@@ -355,6 +357,8 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	if (lru_gen_add_folio(lruvec, folio, true))
 		return;
 
@@ -369,6 +373,8 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 {
 	enum lru_list lru = folio_lru_list(folio);
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
+
 	if (lru_gen_del_folio(lruvec, folio, false))
 		return;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fbba14094c6d..a59268bf4112 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1952,7 +1952,6 @@ static unsigned int move_folios_to_lru(struct list_head *list)
 			continue;
 		}
 
-		VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
 		lruvec_add_folio(lruvec, folio);
 		nr_pages = folio_nr_pages(folio);
 		nr_moved += nr_pages;
-- 
2.20.1



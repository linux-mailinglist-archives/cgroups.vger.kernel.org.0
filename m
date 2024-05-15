Return-Path: <cgroups+bounces-2904-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A79E8C5EC0
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 03:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2FC1F21FB6
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 01:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575262FB6;
	Wed, 15 May 2024 01:25:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B279C0;
	Wed, 15 May 2024 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736318; cv=none; b=bb9eCobtPHXe4hITyimPE6uNWKlgzVfB6iw3UT6vDaXxj5FC8Wt2RVUxEn9xmM+/WoRsJzlAR87AXeHMuLakxyoRS1/wD3CJcyBgJkAmYFOCrPG9+CmM3qBKDhNV1FDsJphzbToJwWObqcS8dy1JFVHRjKAJ3VPXNO1CC6AgOZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736318; c=relaxed/simple;
	bh=yMMIUz7DubXFQXYpZ3HCVv1OQrz7GVWdZJEPrbTdrZU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dc6mmrOdRG0g69A4CAdUL+JVxry2oWuVlTq4o4bIiybNIaaFeY9IFLp4P5RhOny07ZLTpjuZQh1IvN5qqJv/92NB1ksZpIbJSvQpSaZkXcG7ksxlPtYS2mfDfnCltBbinJpHFiThBA26cbBWuJJE6vc/LDI8PRphEUjuA6wBSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 44F1O7LZ051706;
	Wed, 15 May 2024 09:24:07 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VfFm04QmWz2PDtZH;
	Wed, 15 May 2024 09:20:48 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 15 May 2024 09:24:05 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
	<willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo
	<tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <steve.kang@unisoc.com>
Subject: [RFC PATCH 2/2] mm: introduce budgt control in readahead
Date: Wed, 15 May 2024 09:23:50 +0800
Message-ID: <20240515012350.1166350-3-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240515012350.1166350-1-zhaoyang.huang@unisoc.com>
References: <20240515012350.1166350-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 44F1O7LZ051706

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Currently, readahead's size is decided mainly by page cache's status
like hit/miss or hole size which could lead to suspension of following
bio which is over the size of blk-throttle allowed size when
BLK_THROTTLING is on. Introduce the budgt value here to have the bio's
size be within the legal size.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/readahead.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 130c0e7df99f..2b6120ced6f9 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -128,6 +128,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/fadvise.h>
 #include <linux/sched/mm.h>
+#include <linux/minmax.h>
 
 #include "internal.h"
 
@@ -358,16 +359,23 @@ static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
  *  Get the previous window size, ramp it up, and
  *  return it as the new window size.
  */
-static unsigned long get_next_ra_size(struct file_ra_state *ra,
+static unsigned long get_next_ra_size(struct readahead_control *ractl,
 				      unsigned long max)
 {
-	unsigned long cur = ra->size;
+	unsigned long cur = ractl->ra->size;
+	struct inode *inode = ractl->mapping->host;
+	unsigned long budgt = inode->i_sb->s_bdev ?
+			blk_throttle_budgt(inode->i_sb->s_bdev) : 0;
+	unsigned long val = max;
 
 	if (cur < max / 16)
-		return 4 * cur;
+		val = 4 * cur;
 	if (cur <= max / 2)
-		return 2 * cur;
-	return max;
+		val = 2 * cur;
+
+	val = budgt ? min(budgt / PAGE_SIZE, val) : val;
+
+	return val;
 }
 
 /*
@@ -437,6 +445,8 @@ static int try_context_readahead(struct address_space *mapping,
 				 unsigned long max)
 {
 	pgoff_t size;
+	unsigned long budgt = mapping->host->i_sb->s_bdev ?
+		blk_throttle_budgt(mapping->host->i_sb->s_bdev) : 0;
 
 	size = count_history_pages(mapping, index, max);
 
@@ -455,7 +465,7 @@ static int try_context_readahead(struct address_space *mapping,
 		size *= 2;
 
 	ra->start = index;
-	ra->size = min(size + req_size, max);
+	ra->size = min3(budgt / PAGE_SIZE, size + req_size, max);
 	ra->async_size = 1;
 
 	return 1;
@@ -552,6 +562,8 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	pgoff_t index = readahead_index(ractl);
 	pgoff_t expected, prev_index;
 	unsigned int order = folio ? folio_order(folio) : 0;
+	unsigned long budgt = ractl->mapping->host->i_sb->s_bdev ?
+		blk_throttle_budgt(ractl->mapping->host->i_sb->s_bdev) : 0;
 
 	/*
 	 * If the request exceeds the readahead window, allow the read to
@@ -574,7 +586,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 			1UL << order);
 	if (index == expected || index == (ra->start + ra->size)) {
 		ra->start += ra->size;
-		ra->size = get_next_ra_size(ra, max_pages);
+		ra->size = get_next_ra_size(ractl, max_pages);
 		ra->async_size = ra->size;
 		goto readit;
 	}
@@ -599,7 +611,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 		ra->start = start;
 		ra->size = start - index;	/* old async_size */
 		ra->size += req_size;
-		ra->size = get_next_ra_size(ra, max_pages);
+		ra->size = get_next_ra_size(ractl, max_pages);
 		ra->async_size = ra->size;
 		goto readit;
 	}
@@ -631,6 +643,9 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 * standalone, small random read
 	 * Read as is, and do not pollute the readahead state.
 	 */
+	if (budgt)
+		req_size = min(budgt / PAGE_SIZE, req_size);
+
 	do_page_cache_ra(ractl, req_size, 0);
 	return;
 
@@ -647,7 +662,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 * Take care of maximum IO pages as above.
 	 */
 	if (index == ra->start && ra->size == ra->async_size) {
-		add_pages = get_next_ra_size(ra, max_pages);
+		add_pages = get_next_ra_size(ractl, max_pages);
 		if (ra->size + add_pages <= max_pages) {
 			ra->async_size = add_pages;
 			ra->size += add_pages;
-- 
2.25.1



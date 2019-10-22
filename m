Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4473EE0D28
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2019 22:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389347AbfJVUPW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Oct 2019 16:15:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37785 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389341AbfJVUPV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Oct 2019 16:15:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id g50so14615411qtb.4
        for <cgroups@vger.kernel.org>; Tue, 22 Oct 2019 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SKH3PcY5YzXD6Qge68ymWg6Ins6ocLR9l5DfPryEBgk=;
        b=KaaLg/bw88z77buICYAJEe5iw5ThIZJCDvLL4q2RSdmGOXSdlsryIy4UAPdKiR3U1i
         TnF8jNwIgRKrMzBMH2cBT8Qyy9tg/M9wTtR3Wrx6e/JrVGOp77QhbBjRArE2l/meQdby
         SOdO/mGWcTubS8kR90ln5IenSVxDk0WPTvDqpdaDO4iRAPQXIssKgsKkCTzxFI7D99tI
         K/w9BneoewwmdaDHDt5q8QWenhYLUUAhYRi0GJm58lfdROEHZrbuhSNsUmJ7vhrTLZoB
         TlgRns9OFeILnr1C45VJ/hBfpRmLpXl6WY6/23dwwSlktV02dZHRpDlk39xE/9wyzzJf
         OKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SKH3PcY5YzXD6Qge68ymWg6Ins6ocLR9l5DfPryEBgk=;
        b=o2rQvVLHDhxjJPF94UgCdeItDbfi5Gs+6BiKgGfHfzlouedQmVIHpeA0vdMvYt8sSl
         Mu8zefOsmPHSuEs9QmvVzfYmhcbYyRPvbCuc+CyeJLkWPiBRuFEoScxTGVss6FbrF70v
         QQ1lDS2bJHSgLeu2DfDnTsWX2iAGddtR9WtOavOEZODG6ngbjb79f8Az+BCFapP2CA50
         m1dEGBokeLF31KrLnv2rzTa29yhlerrk2Dqsq4fGeIkv2xUS04Yvq9ECHdlvd4l4Ap2E
         UHFPpS0trqyrfOZxJLRJkZXucEVtdE0gWdbMIgk5nhURqIhckQCoLxJNkkP6KhixosS9
         3DdA==
X-Gm-Message-State: APjAAAWSdJSx6zVtL1RiLUUcV80ZZk4jK1wxhzlI/YglsSL5rWasYnKt
        tFUIfvjJQbi5YjTrxP456wECpA==
X-Google-Smtp-Source: APXvYqwgUaBUtrSrtIlAxyDVz2P4+gAp3Nwe5EnwHYyjxxj2PszLHekWjQXPyQk3tbOPUN9yPnbdVQ==
X-Received: by 2002:a0c:d0e1:: with SMTP id b30mr5126174qvh.197.1571775320721;
        Tue, 22 Oct 2019 13:15:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:869e])
        by smtp.gmail.com with ESMTPSA id e15sm7759814qkm.130.2019.10.22.13.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 13:15:20 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/2] mm: memcontrol: try harder to set a new memory.high
Date:   Tue, 22 Oct 2019 16:15:18 -0400
Message-Id: <20191022201518.341216-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022201518.341216-1-hannes@cmpxchg.org>
References: <20191022201518.341216-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Setting a memory.high limit below the usage makes almost no effort to
shrink the cgroup to the new target size.

While memory.high is a "soft" limit that isn't supposed to cause OOM
situations, we should still try harder to meet a user request through
persistent reclaim.

For example, after setting a 10M memory.high on an 800M cgroup full of
file cache, the usage shrinks to about 350M:

+ cat /cgroup/workingset/memory.current
841568256
+ echo 10M
+ cat /cgroup/workingset/memory.current
355729408

This isn't exactly what the user would expect to happen. Setting the
value a few more times eventually whittles the usage down to what we
are asking for:

+ echo 10M
+ cat /cgroup/workingset/memory.current
104181760
+ echo 10M
+ cat /cgroup/workingset/memory.current
31801344
+ echo 10M
+ cat /cgroup/workingset/memory.current
10440704

To improve this, add reclaim retry loops to the memory.high write()
callback, similar to what we do for memory.max, to make a reasonable
effort that the usage meets the requested size after the call returns.

Afterwards, a single write() to memory.high is enough in all but
extreme cases:

+ cat /cgroup/workingset/memory.current
841609216
+ echo 10M
+ cat /cgroup/workingset/memory.current
10182656

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ff90d4e7df37..8090b4c99ac7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6074,7 +6074,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-	unsigned long nr_pages;
+	unsigned int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+	bool drained = false;
 	unsigned long high;
 	int err;
 
@@ -6085,12 +6086,29 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 
 	memcg->high = high;
 
-	nr_pages = page_counter_read(&memcg->memory);
-	if (nr_pages > high)
-		try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					     GFP_KERNEL, true);
+	for (;;) {
+		unsigned long nr_pages = page_counter_read(&memcg->memory);
+		unsigned long reclaimed;
+
+		if (nr_pages <= high)
+			break;
+
+		if (signal_pending(current))
+			break;
+
+		if (!drained) {
+			drain_all_stock(memcg);
+			drained = true;
+			continue;
+		}
+
+		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
+							 GFP_KERNEL, true);
+
+		if (!reclaimed && !nr_retries--)
+			break;
+	}
 
-	memcg_wb_domain_size_changed(memcg);
 	return nbytes;
 }
 
-- 
2.23.0


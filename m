Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348597999BE
	for <lists+cgroups@lfdr.de>; Sat,  9 Sep 2023 18:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjIIQZk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 9 Sep 2023 12:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346701AbjIIPw4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 9 Sep 2023 11:52:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337BF180;
        Sat,  9 Sep 2023 08:52:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c1e780aa95so21566655ad.3;
        Sat, 09 Sep 2023 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694274771; x=1694879571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgpa7ePPXDf81q5q2R0+qC0wZ59LoDUqcXyRaIm3KfE=;
        b=a2EtqDj0feMdhivyTEMi3UkoWCVwvdJux7/mjhCaknL0lZvZUR7SgSxz9VQMadR7AV
         dyzGa/PKGhPfrRGv0KhDFnEemyolJt0d7j7yJh4RYxz4QB0Yf2Mb8RTdcFHBBJs0JS/I
         jLR8ACm69RNRxSitOos/81qsDSFGe6Rljlc1LPgBllBB+UoEyTmbQcsuAo5LiRszVJNG
         0lVrxfMzVcdRRKgiQ66SusiMAm19GDVkBFbGKOw83zd9uZiqNeV5AXo3wjfGqR8kySFq
         /p7Ij9uKdrjq6JrRakUSg51dC17hSq/fNDjMdyeCYDzlM73tPiS55+u/eHWivdVKSwYV
         6NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694274771; x=1694879571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgpa7ePPXDf81q5q2R0+qC0wZ59LoDUqcXyRaIm3KfE=;
        b=Z3JBVMxMfaLLWjqL0MysnioCOe9gql6xk5o2slv0nQw6JaclQHTZcB6ykDgrT800iE
         U1et8KnEjXzuuaQJzGDfsPI4wUP29lauAc0KIXmbkVg4wAf2BmDifHTjGrCL6b0c+XAe
         HEA4pt6PcGzlf1LBMfTi0meTcIEaLkG2DsHDc/6y01jY2zjo4xa2Le8s8f8vvGUXiqPR
         CHs2CLxVlLjUKnGIUqirhJ5bhNk9QLMLhR2nP2amX2zxepp7AXZIKXQavj9boxR1sM6q
         oIsZ6MUJXevHYPpeO26tqxH6RkSqXLHebxWvYKxWgXy/+F3/S4KTrVlJAfj8xaZcjVPM
         t3RA==
X-Gm-Message-State: AOJu0Yx0FjUsdc8sqlhbnntJBM5yQn3l2+Yo8su4FGKfhWmFZjXGlx1p
        8FKp/26nnpWzbjOPC7NpoqZunds7bPrlCQ==
X-Google-Smtp-Source: AGHT+IHjDCzUL7bJiz6mFbSIE+EIH00p+G4f05fHtvMlNGOTIzh0y+NyM9MBHYLBf8fAqRHqNqAwIQ==
X-Received: by 2002:a17:90a:4e47:b0:26b:2f9:a898 with SMTP id t7-20020a17090a4e4700b0026b02f9a898mr4980514pjl.47.1694274771484;
        Sat, 09 Sep 2023 08:52:51 -0700 (PDT)
Received: from VERNHAO-MC1.tencent.com ([111.197.253.118])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090a72c200b0025bd4db25f0sm2894612pjk.53.2023.09.09.08.52.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 Sep 2023 08:52:51 -0700 (PDT)
From:   Xin Hao <haoxing990@gmail.com>
X-Google-Original-From: Xin Hao <vernhao@tencent.com>
To:     hannes@cmpxchg.org
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        haoxing990@gmail.com
Subject: [PATCH] mm: memcg: add THP swap out info for anonymous reclaim
Date:   Sat,  9 Sep 2023 23:52:41 +0800
Message-ID: <20230909155242.22767-1-vernhao@tencent.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

At present, we support per-memcg reclaim strategy, however we do not
know the number of transparent huge pages being reclaimed, as we know
the transparent huge pages need to be splited before reclaim them, and
they will bring some performance bottleneck effect. for example, when
two memcg (A & B) are doing reclaim for anonymous pages at same time,
and 'A' memcg is reclaiming a large number of transparent huge pages, we
can better analyze that the performance bottleneck will be caused by 'A'
memcg.  therefore, in order to better analyze such problems, there add
THP swap out info for per-memcg.

Signed-off-by: Xin Hao <vernhao@tencent.com>
---
 mm/memcontrol.c | 6 ++++++
 mm/page_io.c    | 4 +++-
 mm/vmscan.c     | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ecc07b47e813..a644f601e2ca 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -752,6 +752,8 @@ static const unsigned int memcg_vm_event_stat[] = {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	THP_FAULT_ALLOC,
 	THP_COLLAPSE_ALLOC,
+	THP_SWPOUT,
+	THP_SWPOUT_FALLBACK,
 #endif
 };
 
@@ -4131,6 +4133,10 @@ static const unsigned int memcg1_events[] = {
 	PGPGOUT,
 	PGFAULT,
 	PGMAJFAULT,
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	THP_SWPOUT,
+	THP_SWPOUT_FALLBACK,
+#endif
 };
 
 static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
diff --git a/mm/page_io.c b/mm/page_io.c
index fe4c21af23f2..008ada2e024a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -208,8 +208,10 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 static inline void count_swpout_vm_event(struct folio *folio)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (unlikely(folio_test_pmd_mappable(folio)))
+	if (unlikely(folio_test_pmd_mappable(folio))) {
+		count_memcg_events(folio_memcg(folio), THP_SWPOUT, 1);
 		count_vm_event(THP_SWPOUT);
+	}
 #endif
 	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ea57a43ebd6b..29a82b72345a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1928,6 +1928,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 								folio_list))
 						goto activate_locked;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+					count_memcg_events(folio_memcg(folio),
+							   THP_SWPOUT_FALLBACK, 1);
 					count_vm_event(THP_SWPOUT_FALLBACK);
 #endif
 					if (!add_to_swap(folio))
-- 
2.42.0


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CBF5AFB59
	for <lists+cgroups@lfdr.de>; Wed,  7 Sep 2022 06:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiIGEgY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Sep 2022 00:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIGEgT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Sep 2022 00:36:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB4F86069
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 21:36:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n17-20020a254011000000b006a90a92cf87so5805619yba.19
        for <cgroups@vger.kernel.org>; Tue, 06 Sep 2022 21:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=7xWB4XnyIc05hqp29+Ov/me4j17Vvs2h2ECTnGXauQA=;
        b=SDmUz9LkUVm/33cr2fKGG4SmxGsrw9fW609UlO1Lh2n9kJAvfCfnCBYoBieiLK1YI4
         MPXnoJKs7HxJOBMeo211kZrqk641hONA1Abc3kl7lVLPSE2aHCTST/ZAGe/af7Ia1j+Y
         HSkzyUCEB5QeLvw41TwrGd/TwUv4YIM4WP861pR3jQm7dOBwu7Q0zlxU3M2K1wwpBOpB
         CpJIkspZw9r5LITpRw9Xg679OMVQjNafq6M/iV99mdZ3p+Qr3ZpmS2S+7O4Mi0TM+q+w
         DxfU/ss15LI61VWwYkkQPDsa/qz7JkfaqkZ89EbLkvsgKRetTJhSaS1Vm/9WvgNffImX
         t82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=7xWB4XnyIc05hqp29+Ov/me4j17Vvs2h2ECTnGXauQA=;
        b=du/yetHiQb/cWS3aEY1JNR2qFBUzNUekSB4QYHsK4n+c2jNcyOFohYgrzutegsQRG5
         6MXKG46YMtJX/r5ugjGXyg8HJij4S4tOUkI8V74t1o2vuVasnDXJVoVvozNg5u8X5BDF
         SdQia0jYmXeB+4JPF3dMwLK6BYikEDtyCyGtWyqWPPNpJshCOH99BpXCkoSzgbC6lpMP
         7dJ+gFlUfVjRsrL0dmq2peYcDpp8Kfu1vwFW+KceaJHl1x8f8O0RL35WKZ/rKQaoS7kq
         EaXm6/OM0GMxyabKio+wEfvcsC5HT0p+UBhXwTEzT46minvK/ywcIv8TW2K519JZT/75
         WlKQ==
X-Gm-Message-State: ACgBeo2kL78K14IzHxskyBIHv307n81Hw9MCJOpjuBqu3azKkfo7AkjN
        DHO9xh41U3OtLQI/z9V9LXns7LU6+uepUg==
X-Google-Smtp-Source: AA6agR41qApOeAsNTHvyqJlEKDWWr4jqOOSYR9bBI0ISwpTGkM58sXdfS6K35j4AxALrx//Yb7zv/515y/Evow==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:bb44:0:b0:677:24c:308f with SMTP id
 b4-20020a25bb44000000b00677024c308fmr1554313ybk.433.1662525377841; Tue, 06
 Sep 2022 21:36:17 -0700 (PDT)
Date:   Wed,  7 Sep 2022 04:35:36 +0000
In-Reply-To: <20220907043537.3457014-1-shakeelb@google.com>
Mime-Version: 1.0
References: <20220907043537.3457014-1-shakeelb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907043537.3457014-3-shakeelb@google.com>
Subject: [PATCH 2/3] memcg: rearrange code
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is a preparatory patch for easing the review of the follow up patch
which will reduce the memory overhead of memory cgroups.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b195d4ca2a72..d0ccc16ed416 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -669,6 +669,29 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
+/* Subset of vm_event_item to report for memcg event stats */
+static const unsigned int memcg_vm_event_stat[] = {
+	PGSCAN_KSWAPD,
+	PGSCAN_DIRECT,
+	PGSTEAL_KSWAPD,
+	PGSTEAL_DIRECT,
+	PGFAULT,
+	PGMAJFAULT,
+	PGREFILL,
+	PGACTIVATE,
+	PGDEACTIVATE,
+	PGLAZYFREE,
+	PGLAZYFREED,
+#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+	ZSWPIN,
+	ZSWPOUT,
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	THP_FAULT_ALLOC,
+	THP_COLLAPSE_ALLOC,
+#endif
+};
+
 struct memcg_vmstats_percpu {
 	/* Local (CPU and cgroup) page state & events */
 	long			state[MEMCG_NR_STAT];
@@ -1501,29 +1524,6 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
 	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
 }
 
-/* Subset of vm_event_item to report for memcg event stats */
-static const unsigned int memcg_vm_event_stat[] = {
-	PGSCAN_KSWAPD,
-	PGSCAN_DIRECT,
-	PGSTEAL_KSWAPD,
-	PGSTEAL_DIRECT,
-	PGFAULT,
-	PGMAJFAULT,
-	PGREFILL,
-	PGACTIVATE,
-	PGDEACTIVATE,
-	PGLAZYFREE,
-	PGLAZYFREED,
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
-	ZSWPIN,
-	ZSWPOUT,
-#endif
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	THP_FAULT_ALLOC,
-	THP_COLLAPSE_ALLOC,
-#endif
-};
-
 static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
 {
 	struct seq_buf s;
-- 
2.37.2.789.g6183377224-goog


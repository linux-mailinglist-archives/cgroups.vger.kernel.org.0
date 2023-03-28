Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B01E6CCCEF
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 00:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjC1WRP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 18:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjC1WRN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 18:17:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575D1273E
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 15:16:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54161af1984so133955817b3.3
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 15:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680041814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpfCPbcrVlI467nPrWnClcfZlWEh8/oKLk4mWLWwJ5M=;
        b=aB5XInM5shRFEupjVRfOVTwIp8OT/8GOCdpf0mMVeXPooztYFeqB/4fTyYFky42c2L
         cHJL0WAYSCnTVIPjouGLoaqK+AnedliRs9QJra7EnwTz3y2TYL063GYspGDlo69C/aKX
         Q4WCP9t0FZSy4z5mYrJKLFahZFndlIErOfAb2mjxfSIGPKnJVKuUODD216rqjI4tCXyS
         D6OSq62KYNM8d3Y/gjIsH2sn135NHZXDjDoSFmzJ5ShWqmWT9/5W9qO3Eof0i2wwkL4l
         11B1AMdH7KMsOMtqPWcbVxPahm2yYwvYDsj0ARVEud+qGQ3Lehzgwg9PonWNXUtgVgTf
         eH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpfCPbcrVlI467nPrWnClcfZlWEh8/oKLk4mWLWwJ5M=;
        b=cZCf1KLycqrinFTNPFMT2c18owwbOmweDVZ9KP0Ob3+m2uP4wn4a3ca/lTuRKXfBnm
         4dAXXWR/i86/vHVgMenb9WM8NqLgnJ2F3gffTBT7hg+UoUMXGe7JmEEXTW2HD3WPb9EG
         fb6ywgTH9PKKVeCCZlowIp1f537zYBWGbv+E7mXHVvR7sLhwBig+X2O/mSbSuP2frG03
         S6M72TBAA9eOjawgw91T4HbI5KhaoqQudROaQ9/Xw9K+RKbXSaie8KaB2C87bAjwkxIl
         2PwnrpwnzR82O+vjB1wxvsf0NAGCOdqC46QhgIsZSh4p55uNOVtRaFYH/eHdLf8L6L5l
         MO/w==
X-Gm-Message-State: AAQBX9ee9ko2JWGVE4n/GYleqPFcNzfXOMa3UOt+kyOlAMP/adSfoSON
        2ZaqVgVOaXr0b267E4bwxQ6ev4lPxhpOuW4V
X-Google-Smtp-Source: AKy350a5zKI96b1WoEMsf2Uk1BbmTXMpgnT5uYIBtloHj2QDwXA1RiFaSK6WQDs33/Qs1TEwSL1tU23SVOrmYfBj
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1586:b0:b33:531b:3dd4 with
 SMTP id k6-20020a056902158600b00b33531b3dd4mr8636279ybu.1.1680041814635; Tue,
 28 Mar 2023 15:16:54 -0700 (PDT)
Date:   Tue, 28 Mar 2023 22:16:37 +0000
In-Reply-To: <20230328221644.803272-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328221644.803272-3-yosryahmed@google.com>
Subject: [PATCH v2 2/9] memcg: rename mem_cgroup_flush_stats_"delayed" to "ratelimited"
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

mem_cgroup_flush_stats_delayed() suggests his is using a delayed_work,
but this is actually sometimes flushing directly from the callsite.

What it's doing is ratelimited calls. A better name would be
mem_cgroup_flush_stats_ratelimited().

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 4 ++--
 mm/memcontrol.c            | 2 +-
 mm/workingset.c            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b6eda2ab205d..ac3f3b3a45e2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1037,7 +1037,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 }
 
 void mem_cgroup_flush_stats(void);
-void mem_cgroup_flush_stats_delayed(void);
+void mem_cgroup_flush_stats_ratelimited(void);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
@@ -1535,7 +1535,7 @@ static inline void mem_cgroup_flush_stats(void)
 {
 }
 
-static inline void mem_cgroup_flush_stats_delayed(void)
+static inline void mem_cgroup_flush_stats_ratelimited(void)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0205e58ea430..c3b6aae78901 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -653,7 +653,7 @@ void mem_cgroup_flush_stats(void)
 		__mem_cgroup_flush_stats();
 }
 
-void mem_cgroup_flush_stats_delayed(void)
+void mem_cgroup_flush_stats_ratelimited(void)
 {
 	if (time_after64(jiffies_64, flush_next_time))
 		mem_cgroup_flush_stats();
diff --git a/mm/workingset.c b/mm/workingset.c
index 00c6f4d9d9be..af862c6738c3 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -462,7 +462,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
-	mem_cgroup_flush_stats_delayed();
+	mem_cgroup_flush_stats_ratelimited();
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't activate pages that couldn't stay resident even if
-- 
2.40.0.348.gf938b09366-goog


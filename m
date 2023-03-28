Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB1A6CB6E1
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 08:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjC1GRq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 02:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjC1GRW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 02:17:22 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7C53A82
        for <cgroups@vger.kernel.org>; Mon, 27 Mar 2023 23:16:55 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id oa14-20020a17090b1bce00b0023d1b58d3baso2934846pjb.4
        for <cgroups@vger.kernel.org>; Mon, 27 Mar 2023 23:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xrFtgulASYXrMO3GaE6CpeYp9Puj0hiviKaUT94oIg=;
        b=qIxeFfAv7LZhUaMY9U0TvTtrAPX4wRqNbnIeY0Yrn/RnFRGntBTlu0hfuIAsMfAy2n
         1P28EpdkOB3njh6q599A6aRPcbQ+/6Ngp2xMzs6rBLHlr6vd8s4xgEvIn8RMUD6Mze8g
         o6DwJQ//Mohpbdf8YD2EiOxbMyBh8HdrF+/Yzlad7E0D+Fg0j+P6NKtF5T845D/HLRrp
         rP0WF5ztka030C2opL/oGdjy+y9vRWrHiXRiQXH/e0QgpKRtMDaGNueTHyNdIDcH2xFM
         Q3P8IwnLdzShQrK/qG/mnGtQghgE6XGNQRvgt1djyelN/qv5GiJdyRld4l0gXlsYj6Rl
         orEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xrFtgulASYXrMO3GaE6CpeYp9Puj0hiviKaUT94oIg=;
        b=0Cg7/udX1HgUDsl9+D4gGwodmS1c2kC38KfqcNYVeMpWo1Oz2PkGXc095pvrRQ6DFL
         rgGeOSydYsj4eNt+WVimZOQIprYTDNZExOpceOy/bZ4MFwIHBsGiVrjTpKq37S5nJH0I
         rpQpjpzJ2XiWBdymaDDgn+5HxxDK+JGMYRuM+7oifY1GdNTtTLMqeexrtmd37aLkcd9C
         Z+EfrA4QfYyY7KKRknLV4vSwlyRNAx7UhkVi5gi60aOLn/YpvulsQKE3qTCWNHxQaLPA
         dCNhkxO9vfehCgl3eMnBFN5g+k1r+lknOkmbagpC84Tc8mjUiDMQt1OluYbrChwBjMhj
         cl/w==
X-Gm-Message-State: AAQBX9c+Nqad8Mj/faro9zxRmy/sFvvtWq6e73bsTDzsEmes5+zc7q9S
        n0wUKAjX7cUtQSbgRU8XRW/BR7Jx8jGF1Act
X-Google-Smtp-Source: AKy350aBuKbfjhOAuCJYm2iwk4HKu8S/jfcCuw8uP63TY3FEEFp0rTq/+r6BOwoVOwDyCp4xkVINZeVu5jFTXH9F
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:115a:0:b0:50b:dfd4:b56f with SMTP
 id 26-20020a63115a000000b0050bdfd4b56fmr3747909pgr.5.1679984214584; Mon, 27
 Mar 2023 23:16:54 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:36 +0000
In-Reply-To: <20230328061638.203420-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-8-yosryahmed@google.com>
Subject: [PATCH v1 7/9] workingset: memcg: sleep when flushing stats in workingset_refault()
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

In workingset_refault(), we call mem_cgroup_flush_stats_ratelimited()
to flush stats within an RCU read section and with sleeping disallowed.
Move the call to mem_cgroup_flush_stats_ratelimited() above the RCU read
section and allow sleeping to avoid unnecessarily performing a lot of
work without sleeping.

Since workingset_refault() is the only caller of
mem_cgroup_flush_stats_ratelimited(), just make it call the non-atomic
mem_cgroup_flush_stats().

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 12 ++++++------
 mm/workingset.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 57e8cbf701f3..0c0e74188e90 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -674,12 +674,6 @@ void mem_cgroup_flush_stats_atomic(void)
 		__mem_cgroup_flush_stats_atomic();
 }
 
-void mem_cgroup_flush_stats_ratelimited(void)
-{
-	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
-		mem_cgroup_flush_stats_atomic();
-}
-
 /* non-atomic functions, only safe from sleepable contexts */
 static void __mem_cgroup_flush_stats(void)
 {
@@ -695,6 +689,12 @@ void mem_cgroup_flush_stats(void)
 		__mem_cgroup_flush_stats();
 }
 
+void mem_cgroup_flush_stats_ratelimited(void)
+{
+	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
+		mem_cgroup_flush_stats();
+}
+
 static void flush_memcg_stats_dwork(struct work_struct *w)
 {
 	__mem_cgroup_flush_stats();
diff --git a/mm/workingset.c b/mm/workingset.c
index af862c6738c3..7d7ecc46521c 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -406,6 +406,8 @@ void workingset_refault(struct folio *folio, void *shadow)
 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
 	eviction <<= bucket_order;
 
+	/* Flush stats (and potentially sleep) before holding RCU read lock */
+	mem_cgroup_flush_stats_ratelimited();
 	rcu_read_lock();
 	/*
 	 * Look up the memcg associated with the stored ID. It might
@@ -461,8 +463,6 @@ void workingset_refault(struct folio *folio, void *shadow)
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
-
-	mem_cgroup_flush_stats_ratelimited();
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't activate pages that couldn't stay resident even if
-- 
2.40.0.348.gf938b09366-goog


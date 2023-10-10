Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A2D7BF14D
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 05:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441955AbjJJDVZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 23:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441960AbjJJDVY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 23:21:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D429FA7
        for <cgroups@vger.kernel.org>; Mon,  9 Oct 2023 20:21:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a5a16fa94so175582276.0
        for <cgroups@vger.kernel.org>; Mon, 09 Oct 2023 20:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696908082; x=1697512882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Txx2Z/24+3F8Cj+NRtOMU7JL27MtRQwWcbI2dA3u7/E=;
        b=hy3FXdt8nWVJipZ9sJI1zwZLXulM+5YQg9PMfnYfavjXBk8VGzkYlmS8Qb125iXUSl
         g6PicacYZEPQwKF+4trujJz25wAL1a2U834PrTEI43SKtjX2DaT+cs90cca+vBxo38FB
         XJwsFsg1ORFgE/3KICaUNMJPqvUUqK/JIj4rzqC6C25SPFs6YxaNnkAPS/wD8H5mg136
         Gact1W1Mw5lNbkByEYOyHkmUSGkf48rQSS8cAbG3beVTSPuambGxRiojimDiYIrC39ZK
         YxiWLnPTQ3epuFWNhEfuQBxTVnsgl9KA1FUci227Sp3W9eafgObnJISqSVEzjP2/itYr
         HavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696908082; x=1697512882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Txx2Z/24+3F8Cj+NRtOMU7JL27MtRQwWcbI2dA3u7/E=;
        b=lslc+jGa8JoW3QJxJDWJEmcxgbar7NX6wiVllTuQ407bwUQ0L4Ixc/JRfeHCDtyDKb
         jqxGZUBJ9opsmrxja3qYzfOiRJSH6tE1Xr/xwBwjSEVPFSow30y0Q4rw3NN3oz9GI4dJ
         /osySHSoJYpfh1ZkTwLmbQxf+7jpc+QEBD+KNrElsV83+rL2alJ8Th5EfLGLrx0IRIuR
         MD9dSgn+cT4BI/ZjGk7S6ACjykJRmGForBS7MmcvXVngCxexhFrgw1oGi+YQXojusEA5
         MboaBAogc4WX3AvjoPxsy8DjcbBSHollMqE+2v3dW1WWHRc5dyYUKIMwjf3DPtAnZhcX
         JEDw==
X-Gm-Message-State: AOJu0YyrKIHSClmbKz634Wbrd8c/X7AAOVlHcRxHy1R9JIxfcBwp78+N
        FvWRDSsXwH7sXNOXsrg2SEnEHfsXOkmR9V1P
X-Google-Smtp-Source: AGHT+IHSbb76MuDQgDE4hYiCssfBhZ3erWto8iacOIEWAeUiJ3Vxcha6qRANQmltbAbW17YqbUuNXt2O9PobRH8R
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:824f:0:b0:d9a:66eb:b516 with SMTP
 id d15-20020a25824f000000b00d9a66ebb516mr1411ybn.6.1696908082104; Mon, 09 Oct
 2023 20:21:22 -0700 (PDT)
Date:   Tue, 10 Oct 2023 03:21:12 +0000
In-Reply-To: <20231010032117.1577496-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231010032117.1577496-2-yosryahmed@google.com>
Subject: [PATCH v2 1/5] mm: memcg: change flush_next_time to flush_last_time
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

flush_next_time is an inaccurate name. It's not the next time that
periodic flushing will happen, it's rather the next time that
ratelimited flushing can happen if the periodic flusher is late.

Simplify its semantics by just storing the timestamp of the last flush
instead, flush_last_time. Move the 2*FLUSH_TIME addition to
mem_cgroup_flush_stats_ratelimited(), and add a comment explaining it.
This way, all the ratelimiting semantics live in one place.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2fb30abaf267..4a194fcc9533 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -590,7 +590,7 @@ static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
 static DEFINE_PER_CPU(unsigned int, stats_updates);
 static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
 static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
-static u64 flush_next_time;
+static u64 flush_last_time;
 
 #define FLUSH_TIME (2UL*HZ)
 
@@ -650,7 +650,7 @@ static void do_flush_stats(void)
 	    atomic_xchg(&stats_flush_ongoing, 1))
 		return;
 
-	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
+	WRITE_ONCE(flush_last_time, jiffies_64);
 
 	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
 
@@ -666,7 +666,8 @@ void mem_cgroup_flush_stats(void)
 
 void mem_cgroup_flush_stats_ratelimited(void)
 {
-	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
+	/* Only flush if the periodic flusher is one full cycle late */
+	if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH_TIME))
 		mem_cgroup_flush_stats();
 }
 
-- 
2.42.0.609.gbb76f46606-goog


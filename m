Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD97A9E1A
	for <lists+cgroups@lfdr.de>; Thu, 21 Sep 2023 21:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjIUTz4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Sep 2023 15:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjIUTzm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Sep 2023 15:55:42 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B0C2DE84
        for <cgroups@vger.kernel.org>; Thu, 21 Sep 2023 12:05:03 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c443fdfedbso11587755ad.2
        for <cgroups@vger.kernel.org>; Thu, 21 Sep 2023 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695323103; x=1695927903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FIm0UyACNB+n/akQREWxQWjORl9GVEfiVT/RezLXAow=;
        b=o0WvARSm78ZHNoVIzoQy21+iNUit9PRwZX8aotevPUHejxCKR5BsEePG+Cq7tTnox8
         ncOJsOXv1vzb5xnheDUl401hpf0g2obzET7pqixy9HHTm/lulbrCEK+caZd/ZKL76SCz
         oujDGwDcAxgLeVX1L30kyp8WAqjeSoSN6hsRHET99YDQ5m5didQnk+EjZQqRzMAIOgko
         GOXLVz1oCEDHd9ldvboyEW7GtIG2GC/kzuOwYSbd7efapTjS+R+aY/3kTMZExvxJFMQY
         X7iiM5M4Sr0Fz2mTc3JR1N4JqkdRmRuLQKIlvPfxw2Za8tHw7oZ9hJVc73B8LFIlieXd
         TTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323103; x=1695927903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIm0UyACNB+n/akQREWxQWjORl9GVEfiVT/RezLXAow=;
        b=GrKZLoFOpUXmOtJg/vVbtSyQ3d7MNFK7QFPZeJykBUPVw/7vhdO8ZadknhcjTK+Tjj
         rkAEahDj40HyRyLujTv0HY/lfWI4HBOa2muahJWZvRf5KRx4MhnXVHS9wGQ3JodIrjvB
         CykSw6D7hpCuvDpcDfs2SDG2lZgk8fJFHHObGKQlKj9Rt7wHtDGH3fpzP0bIIOpTdBgd
         mMLev5jRRrZnxoU44g88OIQEY3oGnpBPYP5G0UYST7/KhaEV7Mduq7jNqBskkRPX+IoF
         3ft9reO/7yN5gOXp28JAF1RRSgp360ghdWkxDlr8D6n94XSxhCy/Lb2wdf4Ypfp0fMat
         3N+w==
X-Gm-Message-State: AOJu0YzBir9On4py7+/LmzGpvVWQ1JtM6/+2eFea1SV/pSRBhemis4dG
        D9XC8SJmdFUjl6OQjAW/no64kF5UDclPSh6X
X-Google-Smtp-Source: AGHT+IFPrnsBcOBrlhPC5hJYwVV2PE3AiCfsgKWx3CsvgDAaTduMINork77xXDD5F6NyG97FAk+4bBmhLTyqQlsm
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:4c8:0:b0:d0e:d67d:6617 with SMTP id
 191-20020a2504c8000000b00d0ed67d6617mr67400ybe.4.1695283863247; Thu, 21 Sep
 2023 01:11:03 -0700 (PDT)
Date:   Thu, 21 Sep 2023 08:10:53 +0000
In-Reply-To: <20230921081057.3440885-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230921081057.3440885-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921081057.3440885-2-yosryahmed@google.com>
Subject: [PATCH 1/5] mm: memcg: change flush_next_time to flush_last_time
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
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
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
index 927c64d3cbcb..49562dfdeab2 100644
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
2.42.0.459.ge4e396fd5e-goog


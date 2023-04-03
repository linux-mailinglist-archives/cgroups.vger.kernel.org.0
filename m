Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F096D5469
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 00:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjDCWDp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Apr 2023 18:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbjDCWDo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Apr 2023 18:03:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E6E26A1
        for <cgroups@vger.kernel.org>; Mon,  3 Apr 2023 15:03:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a25230b000000b00b6871c296bdso29757315ybj.5
        for <cgroups@vger.kernel.org>; Mon, 03 Apr 2023 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680559423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hf88QAEgRalaH3f7thcio7vExcVqqDxAYa/aCaE9Jc=;
        b=Qd1B7SbDQyGizezUFQyV/0tO/bOhj44AtZ1VKHtgOG9TbJavAnnMGZmO6zQIpqIoK7
         5cj24hiW5m5RcceJDQ1KEplDfhRxIe4M8gmfj3L+NZAuLHvyis3MtYjzW6MZhBerb1QT
         JbsSvLpI6syO5GW80nsYNqGOYj2kCCLCJxDrHY++EHRBCuORnOG3ZRIIIY9qF02f9mrK
         7QKQBjFz8zSpKFSQE5ME0/wr0Ah4Zv+Tdpoq6l9nLH2lZJPiIROIUeme5UI6HVL7rK6b
         PMhT9C0HP1QYba587rjt9xa6OsG8uX3e11ytS9ZKFnspyAhVnb6ce2SHS6u9IWMy0H74
         szug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680559423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hf88QAEgRalaH3f7thcio7vExcVqqDxAYa/aCaE9Jc=;
        b=Z7ZFCfF/boTW9LGxR5lkaNaNIW0gWK0dpIQv2p3Qbqv5kOG2iAdCMXi/kFLPI8Nb+L
         6c6ozzc6w4dGB+yVrCid02GHpnvi/Avwq1L4eXwuv+Xu0DpkUvP6WVa/eQWEOV+S1TZj
         pwZDjcA7VoOUrHGJZJcaD3GoInueUScrUpUtiPhCMoAVZ6hJKO4zwnyAIvZM7vwg4ein
         8r5z3F1lXfnkktdB2fau9OuOxVRW2BFPRyJgmmjtAHWRGlXUK6LKsnNrBVnJ2Uzw+jGa
         s/7GPkH9hhXhuElSs72VT5AQ+E3oWQ22cSLNs3/GqzOKXiaMz3W2gOXVMssGFJ871HRC
         so2Q==
X-Gm-Message-State: AAQBX9eoDKSiH8Je3al6VY6OdV2Ow2bHRTPX44byuP2+KibsGhxucsl2
        ILZfD4wwxTeA55hjiK70ld+3k3hBeRYeMUi5
X-Google-Smtp-Source: AKy350Yk7PN55oyTS/2Ex0GZoWZBdH4qO4jUdn7c2dJd2J2mTTnpo7+qXB1LBcPp06lmU8+Do/T+aXIn4r5a27Uq
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:b60f:0:b0:545:bade:c57e with SMTP
 id u15-20020a81b60f000000b00545badec57emr288637ywh.5.1680559422857; Mon, 03
 Apr 2023 15:03:42 -0700 (PDT)
Date:   Mon,  3 Apr 2023 22:03:34 +0000
In-Reply-To: <20230403220337.443510-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230403220337.443510-3-yosryahmed@google.com>
Subject: [PATCH mm-unstable RFC 2/5] memcg: flush stats non-atomically in mem_cgroup_wb_stats()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
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

The previous patch moved the wb_over_bg_thresh()->mem_cgroup_wb_stats()
code path in wb_writeback() outside the lock section. We no longer need
to flush the stats atomically. Flush the stats non-atomically.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3d040a5fa7a35..bdd52fe9e7e4b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4637,11 +4637,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	/*
-	 * wb_writeback() takes a spinlock and calls
-	 * wb_over_bg_thresh()->mem_cgroup_wb_stats(). Do not sleep.
-	 */
-	mem_cgroup_flush_stats_atomic();
+	mem_cgroup_flush_stats();
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
-- 
2.40.0.348.gf938b09366-goog


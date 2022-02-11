Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6124B1EC1
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 07:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiBKGt7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 01:49:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346439AbiBKGt7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 01:49:59 -0500
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD961120
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 22:49:59 -0800 (PST)
Received: by mail-ot1-x34a.google.com with SMTP id w25-20020a9d70d9000000b0059fa6c78406so4793348otj.22
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 22:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+8rN+YKf6ok+x08l31cPg9Z1f+kTrw1cXJDsx6RQzpQ=;
        b=BSR393aKc6QG8wWOZWMfrPQRJdGzUlEYw+Xm72Fj+l1HA0QTOlh+tjEKyBgFzMW5dh
         yMc5fn9Y/A3FfgNSdOvbIJTLWXMoYdbIp/vvqzQXMLbWsG9nJxhfo+fKE3NGJifj+L55
         3LoH8v37N4wzh6cZ6ZelxTm1tTnyY0hKMYUvTMKIKyIycqhn6OLw7MJT5WtKpDt36DPf
         wCMwOA8QiMTaXEP2zn6vCRFegcEHws0MuunzFrr6o1UAxCnt9V9kQaR9FJs/brjoGool
         gPl1ffvPeA1Ff7JE3BrPzFA4t8pldf9Fk2M0Op9O4qxcn/XyTm8w2rz+eUBX0/iLhkxa
         f4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+8rN+YKf6ok+x08l31cPg9Z1f+kTrw1cXJDsx6RQzpQ=;
        b=G2FeHsilz3zxNo82LZG1aCAhLUTrGWBos1qhMeFwwYOodw1u7gH/XbP4ntb3EYvBj6
         VfS0RfURC+UXTxtRz627amYyKu+g4c0XTS0tqrfFvT1d9xWqwcSyahyEa8ChbZULCt4Z
         LEpJ7jMzPwueOQXsn2togwG00GGWIlwrjHjwJfXFDBAe80Je8wIP2tKq6uzPaY/eFOad
         yXP0OgcGsef7zV63WBJRlqZGE3Zfzh1VUoSINk+x+AudIPyEFvh9EoIJpCg/qPESm3UZ
         29KWj/eXyBK+oRMdrnlVdnLtN2FtntZKlO2Tetylh5k417SX5c7/csG3KcNKHJlKGq9n
         bJiQ==
X-Gm-Message-State: AOAM5330LTLJxWmq/1KI318cT09pfu4iA7YE3Cyvl5MZXGRITQ91e99l
        hKM5syS+zglb8fLDj2E7s6JBcIWC1Jusrw==
X-Google-Smtp-Source: ABdhPJx+FPelF0U4y0S0ru7GypuLQN66L/vIwUT5nqHv0csa/+RSKZQiVXDUKNso1ijCAHAvOmABsg8qgMR59A==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:9a07:ef1a:2fee:57f1])
 (user=shakeelb job=sendgmr) by 2002:a05:6870:8682:: with SMTP id
 p2mr257108oam.205.1644562198389; Thu, 10 Feb 2022 22:49:58 -0800 (PST)
Date:   Thu, 10 Feb 2022 22:49:17 -0800
In-Reply-To: <20220211064917.2028469-1-shakeelb@google.com>
Message-Id: <20220211064917.2028469-5-shakeelb@google.com>
Mime-Version: 1.0
References: <20220211064917.2028469-1-shakeelb@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 4/4] memcg: synchronously enforce memory.high for large overcharges
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The high limit is used to throttle the workload without invoking the
oom-killer. Recently we tried to use the high limit to right size our
internal workloads. More specifically dynamically adjusting the limits
of the workload without letting the workload get oom-killed. However due
to the limitation of the implementation of high limit enforcement, we
observed the mechanism fails for some real workloads.

The high limit is enforced on return-to-userspace i.e. the kernel let
the usage goes over the limit and when the execution returns to
userspace, the high reclaim is triggered and the process can get
throttled as well. However this mechanism fails for workloads which do
large allocations in a single kernel entry e.g. applications that
mlock() a large chunk of memory in a single syscall. Such applications
bypass the high limit and can trigger the oom-killer.

To make high limit enforcement more robust, this patch makes the limit
enforcement synchronous only if the accumulated overcharge becomes
larger than MEMCG_CHARGE_BATCH. So, most of the allocations would still
be throttled on the return-to-userspace path but only the extreme
allocations which accumulates large amount of overcharge without
returning to the userspace will be throttled synchronously. The value
MEMCG_CHARGE_BATCH is a bit arbitrary but most of other places in the
memcg codebase uses this constant therefore for now uses the same one.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v1:
- Based on Roman's comment simply the sync enforcement and only target
  the extreme cases.

 mm/memcontrol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 292b0b99a2c7..0da4be4798e7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2703,6 +2703,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		}
 	} while ((memcg = parent_mem_cgroup(memcg)));
 
+	if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
+	    !(current->flags & PF_MEMALLOC) &&
+	    gfpflags_allow_blocking(gfp_mask)) {
+		mem_cgroup_handle_over_high();
+	}
 	return 0;
 }
 
-- 
2.35.1.265.g69c8d7142f-goog


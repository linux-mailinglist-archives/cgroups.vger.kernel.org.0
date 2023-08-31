Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D48678F188
	for <lists+cgroups@lfdr.de>; Thu, 31 Aug 2023 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346664AbjHaQ4a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Aug 2023 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjHaQ4Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Aug 2023 12:56:24 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3F6D1
        for <cgroups@vger.kernel.org>; Thu, 31 Aug 2023 09:56:21 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-26d49dd574aso1090857a91.1
        for <cgroups@vger.kernel.org>; Thu, 31 Aug 2023 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693500981; x=1694105781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJkwDc7Wxmywu9Yo0ZIK2ppmyNcYkDsKDS48R26U4fo=;
        b=onL+yixI1Hw0E45nLUTeAKG663+oWCI/D3IutTPmf516S6mKwzXdm4mDaMAodk1W6b
         pn7YH+wPBUVBEabXF7KYa+w3QY7DXyiviyVcEqCWY2muuS9/RrHv2ld43n7Sif8YE/i1
         z6bYsupweiuPGNaewF8ZMWmsE3tyCIkl1kV871VT9aqseA9ry3W2bUsRq9eSGs9mAt4o
         jMVD/ltODgDJ1HWQEWFhc4uCZW/kxy2mCyroQibAO/6/yXGXd4goPGDD5oebkowPsqyR
         v9ax0IHNnSt7UPX3WXpER33Lr6ZFY6BJzOdNTOgP2qw2dajW9JCIwWLLnvCl8Df+S8xA
         XNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693500981; x=1694105781;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dJkwDc7Wxmywu9Yo0ZIK2ppmyNcYkDsKDS48R26U4fo=;
        b=guAfQc7voFpVGX0g2FA/sde3ojt8I6/NoaI590pwM6bzrDly6iSDG3yENJOrir6hlD
         mS209BEiaqQDMO33piUu6Qix8uci33+OIjoEEtPs4mDMe4EgzIm7C+jJn3Axag/hPPj5
         yRb9bDZKM6YAJnd5IMdLzgRu2K5ATaMnTRMpKBvWjZ1f9zOvuDGzXpaVyhJO7+5MJBik
         CWYUd1TnS70fQsnIGC9rvUbkou7SG+3FzVJR/2cTf22FZ1nhwimy8XU3acLK5dlCP4Zs
         oZlVYVHyEjbeCYgsJ0vNiBwKyaXfYK3k2Ig9JUIQJR2zeHPPnV/vs50mDvp3Jy1b/yGd
         kEvQ==
X-Gm-Message-State: AOJu0YxGO1T3K9MuBgeRK793HUbCqxTm/dGxLO6XPzT4y1TzpB9xyiMB
        qt+7jq4muA+LFhXntPp8Eyyf66RVVGgIXWpp
X-Google-Smtp-Source: AGHT+IGBXws1kwasa2qMZ2oV47hWaKQbyN2jJKglhtHqwCQYSWOwpg/OejdryTSoKa2sWR5HEgqm/Qoc3DqRPg8i
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:c68c:b0:268:9cfa:171c with SMTP
 id n12-20020a17090ac68c00b002689cfa171cmr61794pjt.4.1693500980771; Thu, 31
 Aug 2023 09:56:20 -0700 (PDT)
Date:   Thu, 31 Aug 2023 16:56:10 +0000
In-Reply-To: <20230831165611.2610118-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831165611.2610118-4-yosryahmed@google.com>
Subject: [PATCH v4 3/4] mm: memcg: let non-unified root stats flushes help
 unified flushes
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Unified flushing of memcg stats keeps track of the magnitude of pending
updates, and only allows a flush if that magnitude exceeds a threshold.
It also keeps track of the time at which ratelimited flushing should be
allowed as flush_next_time.

A non-unified flush on the root memcg has the same effect as a unified
flush, so let it help unified flushing by resetting pending updates and
kicking flush_next_time forward. Move the logic into the common
do_stats_flush() helper, and do it for all root flushes, unified or
not.

There is a subtle change here, we reset stats_flush_threshold before a
flush rather than after a flush. This probably okay because:

(a) For flushers: only unified flushers check stats_flush_threshold, and
those flushers skip anyway if there is another unified flush ongoing.
Having them also skip if there is an ongoing non-unified root flush is
actually more consistent.

(b) For updaters: Resetting stats_flush_threshold early may lead to more
atomic updates of stats_flush_threshold, as we start updating it
earlier. This should not be significant in practice because we stop
updating stats_flush_threshold when it reaches the threshold anyway. If
we start early and stop early, the number of atomic updates remain the
same. The only difference is the scenario where we reset
stats_flush_threshold early, start doing atomic updates early, and then
the periodic flusher kicks in before we reach the threshold. In this
case, we will have done more atomic updates. However, since the
threshold wasn't reached, then we did not do a lot of updates anyway.

Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c046feeaae7..94d5a6751a9e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -647,6 +647,11 @@ static inline void memcg_rstat_updated(struct mem_cgro=
up *memcg, int val)
  */
 static void do_stats_flush(struct mem_cgroup *memcg)
 {
+	/* for unified flushing, root non-unified flushing can help as well */
+	if (mem_cgroup_is_root(memcg)) {
+		WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
+		atomic_set(&stats_flush_threshold, 0);
+	}
 	cgroup_rstat_flush(memcg->css.cgroup);
 }
=20
@@ -665,11 +670,8 @@ static void do_unified_stats_flush(void)
 	    atomic_xchg(&stats_unified_flush_ongoing, 1))
 		return;
=20
-	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
-
 	do_stats_flush(root_mem_cgroup);
=20
-	atomic_set(&stats_flush_threshold, 0);
 	atomic_set(&stats_unified_flush_ongoing, 0);
 }
=20
--=20
2.42.0.rc2.253.gd59a3bf2b4-goog


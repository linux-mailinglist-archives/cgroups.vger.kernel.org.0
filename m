Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5107B78DE09
	for <lists+cgroups@lfdr.de>; Wed, 30 Aug 2023 20:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343658AbjH3S47 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Aug 2023 14:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343994AbjH3Rxu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Aug 2023 13:53:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB560193
        for <cgroups@vger.kernel.org>; Wed, 30 Aug 2023 10:53:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7814efcccbso6954174276.0
        for <cgroups@vger.kernel.org>; Wed, 30 Aug 2023 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693418027; x=1694022827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJkwDc7Wxmywu9Yo0ZIK2ppmyNcYkDsKDS48R26U4fo=;
        b=4CrOY4QoRdDND9dvtODbK5A0YV+U7OqLoXHtqOIWs/OOn9gFjSvSGgqEgH/7NojirA
         DKpcmlIM2km86Z188faUY9lxCDvPOKKUAQHL6K5vdoF8AFL3jxEgLsAV20tuivA8Xncc
         eBJZD78LArPrzqy86bUAMmZU2ZTK3uVC521Ga5mTpUi6PTjlNYZzGHZ0GxSiWBnfnlxM
         ZUi5DajEwAxX5eT63OEz3v91aFqgovVcCpjlMkQs5X5AV652PIPYZa7fgZgSEydQE0yl
         AtVJRe3aEg/Z29/Uk5I/C2Ip6wnI2n3DQH8MUCzvSuEPwFbp8b9OZlMQbSlW7nJImWb1
         /QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693418027; x=1694022827;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dJkwDc7Wxmywu9Yo0ZIK2ppmyNcYkDsKDS48R26U4fo=;
        b=Uh0SVmF6mP+KCsqPqRC0NAvSDHzrg5PChVo+4CLbSGk+SZ3li7q5SsQE/xT+bw1bvB
         ep3mRCvf0X8b9maWlo2ED6aJpVQxEq4803tqEpB4eOvkfaB4j8ECe+dn/I+oRHkCFUt1
         LoKfekphT9bXOv+oTyaOgL2WvoziuNjmePfOAJpDt9le9YRojPjw3Tx0UwY1joozZq4O
         HpEstdGqNHf07JOKXjj4j+YT9Ybd56FoCZEVeiKhgwbs+hq3YJKuc24q+fZoaZrnIEHr
         ftGK1LKHi3GR8pjgYb3+s1cLGs6gaRJDboQHwXbABCOpCM31NoSHGtdJ0xeQ+EmAtBpS
         b/hg==
X-Gm-Message-State: AOJu0Yxty8mTi3KE4J2T9Noo3HijEa2fUP5mime4DnOrXEMc3Gy1cLfI
        xolzhB78YssFvQmlhJ6qFJR4ERTT5gJIFgS+
X-Google-Smtp-Source: AGHT+IHXnF9jvMD/mtx9ACW7hIsA0mNc+2Mr0ZRpNzXABR3y52qvrgvfvPCgY3NH51AIMzA3Xb4AWwsKCWuq7vsA
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:e7d1:0:b0:d07:7001:495b with SMTP
 id e200-20020a25e7d1000000b00d077001495bmr79671ybh.11.1693418026898; Wed, 30
 Aug 2023 10:53:46 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:53:34 +0000
In-Reply-To: <20230830175335.1536008-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230830175335.1536008-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230830175335.1536008-4-yosryahmed@google.com>
Subject: [PATCH v3 3/4] mm: memcg: let non-unified root stats flushes help
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1554679E112
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 09:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbjIMHpf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 03:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjIMHpf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 03:45:35 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408261729
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 00:45:31 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1d593b2dd5bso4660624fac.3
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 00:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694591129; x=1695195929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JvedlnHbJ7Xvblewl93Q0+oTKItg5cpjvq/m6HrJuqg=;
        b=E6YfUakV7w6M2u/r0jr2OyHqrJHxxlNM3xYYDwoQ+8RhkVLMVSdhBOl30Sglf4XZpd
         dvZxdJdhkNMkt0xIfVjqWYXU81HoZyGSU3oOq/mVp6pVBFIOlqGevcbRPBpNCVJDqn7Q
         pZpj2MLNHT5vGwL0xuHkGZcW6y+rEOR+hLyF+kcBExgOjpzCtPIQwbFKXsEhzpybHb/h
         9r96t+2Yx1TdEG2RaQo66UyRvZI8sHtRkjnFKNy4YwJx5Wh8kUrD+cOJdlQA8q3+qS1t
         zQw2++vjjxWIXUNhy3O85l/2wBHO5PxLWHUf3k2DHif7hz/WqUwNLzQ9fK8aWAwBTJlc
         axTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694591129; x=1695195929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvedlnHbJ7Xvblewl93Q0+oTKItg5cpjvq/m6HrJuqg=;
        b=CBIZCtrpSnxDmZw3B26eI+rghYg91jSH0UnufxchNE8spSeOIjJSrPftHME1FGBw5g
         rEMSpKw/+WLde3zF2RkVzVYtDTqaxCAYO2A/iQMbuEs+flZQ2ikhFPdR/w3YmEDtqP/I
         xrPock3LS8O1mbr53n+1VWerTfgBecSXoPvwVEPnJ+dAVK0kEz/X4bOl87j8PGGIFwch
         bEAqdotS+QQWXdrUN/DPCPQZx2sjrUv3qe4lhNLk9rHfbFSOVoS/a0zvM27gwIIBaVmp
         MaWM76ojbo1ZWcfQvTG8rbN5as9Sfz8AaJ0BYc6FfMWwlTYoNv4ZBzmqzm+pGRG0AVxY
         hpKg==
X-Gm-Message-State: AOJu0YytzsRhwHdZvOD32sX2kbLZAW9C5Yx8Ue+HlTkBZPByFS7Ag83B
        QC7ZbcGNb1A/iIKBobs3JA5V9LAiwpEGWMmb
X-Google-Smtp-Source: AGHT+IHlBNs2Mx/ZSSb+5tjW06WVFGJiIVkb2ZqOrPE3dU6m0k0diTK/q/q6GD3+gQB+u8r6mi7KeG2OWdyZrcyi
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:d393:0:b0:d7e:dff4:b0fe with SMTP
 id e141-20020a25d393000000b00d7edff4b0femr32185ybf.7.1694590732515; Wed, 13
 Sep 2023 00:38:52 -0700 (PDT)
Date:   Wed, 13 Sep 2023 07:38:44 +0000
In-Reply-To: <20230913073846.1528938-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913073846.1528938-2-yosryahmed@google.com>
Subject: [PATCH 1/3] mm: memcg: change flush_next_time to flush_last_time
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
index b29b850cf399..35a9c013d755 100644
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
2.42.0.283.g2d96d420d3-goog


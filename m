Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3F25A04EC
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 02:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiHYAFZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 20:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiHYAFY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 20:05:24 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEE761D75
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 17:05:22 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id i3-20020aa78b43000000b005320ac5b724so8087539pfd.4
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 17:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=vgA35UGCl2OHwAbiBhc19zCa8HdxydG1D9TkQ3os1vo=;
        b=Ge7brMIDek9qbeisJgfHL6rmBn4FcJKYA9NOFZ0ssAyFWYzyQc4kXS30ZHP2em4Z1h
         P3TuTjpB+zzcwiH6oROwzlRsWero2l5QxfYmurrc9hJBSB8kUcwtU4kRAIqOTRDxWiI9
         FnZosPt+RBbfPjyDFj14FpKbfQ3sV+YnH3jHUhIvfJSXyA0AUA63cdDg11e8xX4/Myfg
         EqjDHsQ+yqVJdJoUnYtFmb24rYbR/drHoWA/7uWQxfNfnukE7muUDFSfj7q7MxclK3cA
         TIrcuHrDD3wmMumrUkRreEIKBtZbjTxfTYXMiVtJ9KUxV0mLM3E70ZKhnC+Rx7IbBro5
         vwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=vgA35UGCl2OHwAbiBhc19zCa8HdxydG1D9TkQ3os1vo=;
        b=43nNYoEIhwnGSdLAIm7UmHZK8zYx+y5Ekb1Bc1cYVzxAP214pMQ3c1tmytxXchzYxr
         lpCI1RERtwuJMrfuoo/+lcogDq2/UsWirR4+Ak7J+9wkOrf/LB2wbualJy8O2ldU74kR
         thg79IyJHIJGe7nkKnumvBeMPpj+m6xmMoSKazg8bjsAVGVl6fnj7V+UVZsVjqZH93f9
         m3kR6ZX8QI/bwv8FsegxKfUZDfdzE+r42HrZmI9oa7VVYysCCRCETluxcc5Fejz0nSn4
         TE/EKmh6+0y9pO+GPfaY/hO7N+U0oVX+8k7OyTnBr7ddfbRuo/KVje6ZDq2S1kdfc+oQ
         BPDw==
X-Gm-Message-State: ACgBeo2T6tluG6ckp80F/c3cI+1XfArsaubIbczn3VgU3PSiMqpRQiMN
        9v1WJu3szyI3bryIZ8op2WUnzeTpp9Ns7g==
X-Google-Smtp-Source: AA6agR5vxD4a6lk0t3+yzAUH5cJA/JPFjfgrM6SCBQZtySgZ/O1uGCyw+sNky8HbtNAzJypX4vfHs61I5v+CXw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a62:1649:0:b0:536:55af:1f4d with SMTP id
 70-20020a621649000000b0053655af1f4dmr1405863pfw.61.1661385921563; Wed, 24 Aug
 2022 17:05:21 -0700 (PDT)
Date:   Thu, 25 Aug 2022 00:05:03 +0000
Message-Id: <20220825000506.239406-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2 0/3] memcg: optimize charge codepath
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, lkp@lists.01.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
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

Recently Linux networking stack has moved from a very old per socket
pre-charge caching to per-cpu caching to avoid pre-charge fragmentation
and unwarranted OOMs. One impact of this change is that for network
traffic workloads, memcg charging codepath can become a bottleneck. The
kernel test robot has also reported this regression[1]. This patch
series tries to improve the memcg charging for such workloads.

This patch series implement three optimizations:
(A) Reduce atomic ops in page counter update path.
(B) Change layout of struct page_counter to eliminate false sharing
    between usage and high.
(C) Increase the memcg charge batch to 64.

To evaluate the impact of these optimizations, on a 72 CPUs machine, we
ran the following workload in root memcg and then compared with scenario
where the workload is run in a three level of cgroup hierarchy with top
level having min and low setup appropriately.

 $ netserver -6
 # 36 instances of netperf with following params
 $ netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K

Results (average throughput of netperf):
1. root memcg		21694.8 Mbps
2. 6.0-rc1		10482.7 Mbps (-51.6%)
3. 6.0-rc1 + (A)	14542.5 Mbps (-32.9%)
4. 6.0-rc1 + (B)	12413.7 Mbps (-42.7%)
5. 6.0-rc1 + (C)	17063.7 Mbps (-21.3%)
6. 6.0-rc1 + (A+B+C)	20120.3 Mbps (-7.2%)

With all three optimizations, the memcg overhead of this workload has
been reduced from 51.6% to just 7.2%.

[1] https://lore.kernel.org/linux-mm/20220619150456.GB34471@xsang-OptiPlex-9020/

Changes since v1:
- Commit message updates
- Instead of explicit padding add align compiler option with struct

Shakeel Butt (3):
  mm: page_counter: remove unneeded atomic ops for low/min
  mm: page_counter: rearrange struct page_counter fields
  memcg: increase MEMCG_CHARGE_BATCH to 64

 include/linux/memcontrol.h   |  7 ++++---
 include/linux/page_counter.h | 34 +++++++++++++++++++++++-----------
 mm/page_counter.c            | 13 ++++++-------
 3 files changed, 33 insertions(+), 21 deletions(-)

-- 
2.37.1.595.g718a3a8f04-goog


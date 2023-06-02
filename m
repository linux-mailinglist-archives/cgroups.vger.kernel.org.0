Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A52C71FB94
	for <lists+cgroups@lfdr.de>; Fri,  2 Jun 2023 10:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjFBIL4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jun 2023 04:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFBILz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Jun 2023 04:11:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121421A1
        for <cgroups@vger.kernel.org>; Fri,  2 Jun 2023 01:11:51 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so1352396a12.0
        for <cgroups@vger.kernel.org>; Fri, 02 Jun 2023 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685693510; x=1688285510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nur6fiyrastSwwCwpQExcSI9pgOK9W9Z+VV8HK2n14M=;
        b=VVYcn4qb4m4BBjjU1OqbWu9isMdf6dKAQt2DkTglCHPvT5kgJVRIAYh30oCaKj34fT
         C/2s8l3IhGKbfYwf7kXNJcabKl6BG/7QQ2hKcuBWjZcC/NBx+GpHv970DZGlf0rqirKJ
         D7n8YrNlKMnqxA1ke34M7zxmxn4C9+Qn0Z5Hc3rawR6y92QnyALiE5Yc8tkDeRFvI93a
         Yv/ppH0/JDtd+mLbEt017F6Y4eBJdF5dPvivP1GVpuI4HO/uXLzpAqUICkWCBvvM4Vsx
         /gcD8XRUNsy/QAoL/V149OOwIo2UjOQNsVuTAdbQhfCzP1ZHlfT9tMv5Qgk3yAD2Y06G
         Ap+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685693510; x=1688285510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nur6fiyrastSwwCwpQExcSI9pgOK9W9Z+VV8HK2n14M=;
        b=dZFTJdSa3MrGKek3RJZrKf9D9KYFxeBEyw6F1PC0AcIgRkW+MQFRmks/veQJdSsRj+
         DPV2usSWjB5y/X2lT0uaFaWGOKE3YPzOuQI5hKsR8Zqs1Sr/6BFjol2vrZP8Z/DPSjUI
         RMUjFkGhdcfUsi0GG44Uubny0LW8RKa/hbPeSCnZAvuNF6OkcBF/N1isL6nzuzBGdeg8
         fkjGNuBECAQ3MaPk74rzcnfTeQAh2gjmTnaHmVDZ9OPT6H7aIucISES04mkakXNAuBdZ
         ENn1s9SahE9kYewN+niOM4fT8sFGi+GiczqtSJFyJKkdMloGeSwOsaftiuAgTuOEf9fB
         i8GA==
X-Gm-Message-State: AC+VfDyhy28vEXNWfCA4cGcZayQZd44139Z7GA1F1ZuFpWY7sRFM0ekt
        IpP9imMp52CP3l9SSMMO8VztvA==
X-Google-Smtp-Source: ACHHUZ6IbvEAvHIdEdk4ES8Xs3Ug7g4/LgG16jrRVRs89Fx2lowC+FDeC/Tt3m7JEYz9iQuejo3txg==
X-Received: by 2002:a17:902:e54d:b0:1ac:6fc3:6beb with SMTP id n13-20020a170902e54d00b001ac6fc36bebmr1931935plf.9.1685693510452;
        Fri, 02 Jun 2023 01:11:50 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001b025aba9edsm703570plb.220.2023.06.02.01.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:11:49 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH net-next v5 0/3] sock: Improve condition on sockmem pressure
Date:   Fri,  2 Jun 2023 16:11:32 +0800
Message-Id: <20230602081135.75424-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently the memcg's status is also accounted into the socket's
memory pressure to alleviate the memcg's memstall. But there are
still cases that can be improved. Please check the patches for
detailed info.

Tested on Intel Xeon(R) Platinum 8260, a dual socket machine
containing 2 NUMA nodes each of which has 24C/48T. All the benchmarks
are done inside a separate 5-level depth memcg in a clean host.
Below shows the result of tbench4 and netperf:

tbench4 Throughput (misleading but traditional)
                            baseline               patchset
Hmean     1        357.14 (   0.00%)      360.31 *   0.89%*
Hmean     2        716.66 (   0.00%)      724.57 *   1.10%*
Hmean     4       1408.82 (   0.00%)     1424.31 *   1.10%*
Hmean     8       2826.02 (   0.00%)     2832.64 *   0.23%*
Hmean     16      5413.68 (   0.00%)     5347.72 *  -1.22%*
Hmean     32      8692.74 (   0.00%)     8684.26 (  -0.10%)
Hmean     64     10180.12 (   0.00%)    10377.41 *   1.94%*
Hmean     128    22905.53 (   0.00%)    22959.73 *   0.24%*
Hmean     256    22935.78 (   0.00%)    23103.81 *   0.73%*
Hmean     384    22605.36 (   0.00%)    22747.53 *   0.63%*

netperf-udp
                                   baseline               patchset
Hmean     send-64         278.42 (   0.00%)      277.05 (  -0.49%)
Hmean     send-128        552.18 (   0.00%)      553.51 (   0.24%)
Hmean     send-256       1096.38 (   0.00%)     1095.84 (  -0.05%)
Hmean     send-1024      4102.79 (   0.00%)     4086.06 (  -0.41%)
Hmean     send-2048      7727.20 (   0.00%)     7769.95 (   0.55%)
Hmean     send-3312     11927.57 (   0.00%)    11966.36 (   0.33%)
Hmean     send-4096     14218.54 (   0.00%)    14193.51 (  -0.18%)
Hmean     send-8192     23903.60 (   0.00%)    24205.35 *   1.26%*
Hmean     send-16384    39600.11 (   0.00%)    39372.47 (  -0.57%)
Hmean     recv-64         278.42 (   0.00%)      277.05 (  -0.49%)
Hmean     recv-128        552.18 (   0.00%)      553.51 (   0.24%)
Hmean     recv-256       1096.38 (   0.00%)     1095.84 (  -0.05%)
Hmean     recv-1024      4102.79 (   0.00%)     4086.06 (  -0.41%)
Hmean     recv-2048      7727.19 (   0.00%)     7769.94 (   0.55%)
Hmean     recv-3312     11927.57 (   0.00%)    11966.36 (   0.33%)
Hmean     recv-4096     14218.45 (   0.00%)    14193.50 (  -0.18%)
Hmean     recv-8192     23903.45 (   0.00%)    24205.21 *   1.26%*
Hmean     recv-16384    39599.53 (   0.00%)    39372.28 (  -0.57%)

netperf-tcp
                              baseline               patchset
Hmean     64        1756.32 (   0.00%)     1808.43 *   2.97%*
Hmean     128       3393.47 (   0.00%)     3421.99 *   0.84%*
Hmean     256       6464.04 (   0.00%)     6459.72 (  -0.07%)
Hmean     1024     19050.99 (   0.00%)    19036.21 (  -0.08%)
Hmean     2048     26107.88 (   0.00%)    26185.44 (   0.30%)
Hmean     3312     30770.77 (   0.00%)    30834.78 (   0.21%)
Hmean     4096     32523.50 (   0.00%)    32609.77 (   0.27%)
Hmean     8192     40180.74 (   0.00%)    39632.41 *  -1.36%*
Hmean     16384    46117.02 (   0.00%)    46259.69 (   0.31%)

Seems no obvious regression.

v5:
  - As Paolo pointed out, the cleanup paired with the patch that
    removed in v4 should also be removed.

v4:
  - Per Shakeel's suggestion, removed the patch that suppresses
    allocation under net-memcg pressure to avoid further keeping
    the senders waiting if SACKed segments get dropped from the
    OFO queue.

v3:
  - Fixed some coding style issues pointed out by Simon
  - Fold dependency into memcg pressure func to improve readability

v2:
  - Splited into several patches and modified commit log for
    better readability.
  - Make memcg's pressure consideration function-wide in
    __sk_mem_raise_allocated().

v1: https://lore.kernel.org/lkml/20230506085903.96133-1-wuyun.abel@bytedance.com/
v2: https://lore.kernel.org/lkml/20230522070122.6727-1-wuyun.abel@bytedance.com/
v3: https://lore.kernel.org/lkml/20230523094652.49411-1-wuyun.abel@bytedance.com/
v4: https://lore.kernel.org/lkml/20230530114011.13368-1-wuyun.abel@bytedance.com/

Abel Wu (3):
  net-memcg: Fold dependency into memcg pressure cond
  sock: Always take memcg pressure into consideration
  sock: Fix misuse of sk_under_memory_pressure()

 include/linux/memcontrol.h |  2 ++
 include/net/sock.h         | 14 ++++++++------
 include/net/tcp.h          |  3 +--
 net/core/sock.c            |  2 +-
 4 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.37.3


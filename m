Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951967A696D
	for <lists+cgroups@lfdr.de>; Tue, 19 Sep 2023 19:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjISROz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Sep 2023 13:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjISROy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Sep 2023 13:14:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B270DDC;
        Tue, 19 Sep 2023 10:14:48 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-690d2e13074so407675b3a.1;
        Tue, 19 Sep 2023 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695143688; x=1695748488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Va9ct3om+RUZ45gwrdFa1vNPGMkYE9KP43+unVd5xH8=;
        b=YbqAIZ2XvBpacIxOXb/34q1DD5JXDy4fT0RVThhCMoNJovljplytU8uG5O3ZaQiBAA
         h0rmWDCxLiBEfXugKLKppx7DzSaieb7xyeqbqJmyO2tBVc7tjlTM3jfEQhH6Pyej4v1H
         r+kfuefss6duWfUWfb8FRRYanp2S1SIHNDixeI+ALIwSsHwt3X9LzYc+WV95wXjBatHQ
         +VqiS36iF6856x8gcHxIiCJBvHN18GU85nbQfQaCmVnmHwn9qp78QzXZQkhgcbYej6Fy
         bmWtpumONRQRl+N+zAcYqTGUBr0azcnY/C3txNFZRl57PxbyRuEiTRLZ2DGnZNNHgBqS
         ORHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695143688; x=1695748488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Va9ct3om+RUZ45gwrdFa1vNPGMkYE9KP43+unVd5xH8=;
        b=HGqTmp/YIDQnC+I/rPRW4uoMpN21THBPGYol348cdjnzZ4vmphbx4I+1eLPWTZEopl
         aTjhmPUB4Ab1f/3D5Fa3mV7ewV2n7XwnCM7KhX9PF8JFBvr3WTUv8NOoJB6AW0ZX7Gm5
         8OFYjeE/kim9rVBMuQ6FdOXnj5GOS4HHCtlHg61OHj27lfhnYSE6QiWIb/k24RmLdqnT
         +GG4latBRDKrnXt0XQZ6JXKj6vTpxPcbGA6O95QjM9ilyHJP4QbpDjHjMhW/ZH484GSO
         uBEGqHy7Yu0wz6jlFDWABKXPrp356wmv7Mb2GrJCthb2lQktGWbyV6dCu2GBYTiKQasu
         r94Q==
X-Gm-Message-State: AOJu0YwnRtfHRT710VimFLoVwrtb5o1WtbkxYj4cFRS9tHGWUPZJRfYw
        b9a6X7d2GkrXsk5pn/5tY9E=
X-Google-Smtp-Source: AGHT+IG2PgnEQbQKlMZX3kplRTiPT30A7w6wESPlIGK1vXmPLPorShdYz0qk6ThmL+4QKPjDW/QSYA==
X-Received: by 2002:a05:6a21:3d8b:b0:137:3c67:85d7 with SMTP id bj11-20020a056a213d8b00b001373c6785d7mr196099pzc.16.1695143687894;
        Tue, 19 Sep 2023 10:14:47 -0700 (PDT)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001bb988ac243sm10248337plg.297.2023.09.19.10.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:14:47 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v2 0/2] workload-specific and memory pressure-driven zswap writeback
Date:   Tue, 19 Sep 2023 10:14:45 -0700
Message-Id: <20230919171447.2712746-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Changelog:
v2:
   * Fix loongarch compiler errors
   * Use pool stats instead of memcg stats when !CONFIG_MEMCG_KEM

There are currently several issues with zswap writeback:

1. There is only a single global LRU for zswap. This makes it impossible
   to perform worload-specific shrinking - an memcg under memory
   pressure cannot determine which pages in the pool it owns, and often
   ends up writing pages from other memcgs. This issue has been
   previously observed in practice and mitigated by simply disabling
   memcg-initiated shrinking:

   https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.com/T/#u

   But this solution leaves a lot to be desired, as we still do not have an
   avenue for an memcg to free up its own memory locked up in zswap.

2. We only shrink the zswap pool when the user-defined limit is hit.
   This means that if we set the limit too high, cold data that are
   unlikely to be used again will reside in the pool, wasting precious
   memory. It is hard to predict how much zswap space will be needed
   ahead of time, as this depends on the workload (specifically, on
   factors such as memory access patterns and compressibility of the
   memory pages).

This patch series solves these issues by separating the global zswap
LRU into per-memcg and per-NUMA LRUs, and performs workload-specific
(i.e memcg- and NUMA-aware) zswap writeback under memory pressure. The
new shrinker does not have any parameter that must be tuned by the
user, and can be opted in or out on a per-memcg basis.

On a benchmark that we have run:

(without the shrinker)
real -- mean: 153.27s, median: 153.199s
sys -- mean: 541.652s, median: 541.903s
user -- mean: 4384.9673999999995s, median: 4385.471s

(with the shrinker)
real -- mean: 151.4956s, median: 151.456s
sys -- mean: 461.14639999999997s, median: 465.656s
user -- mean: 4384.7118s, median: 4384.675s

We observed a 14-15% reduction in kernel CPU time, which translated to
over 1% reduction in real time.

On another benchmark, where there was a lot more cold memory residing in
zswap, we observed even more pronounced gains:

(without the shrinker)
real -- mean: 157.52519999999998s, median: 157.281s
sys -- mean: 769.3082s, median: 780.545s
user -- mean: 4378.1622s, median: 4378.286s

(with the shrinker)
real -- mean: 152.9608s, median: 152.845s
sys -- mean: 517.4446s, median: 506.749s
user -- mean: 4387.694s, median: 4387.935s

Here, we saw around 32-35% reduction in kernel CPU time, which
translated to 2.8% reduction in real time. These results confirm our
hypothesis that the shrinker is more helpful the more cold memory we
have.

Domenico Cerasuolo (1):
  zswap: make shrinking memcg-aware

Nhat Pham (1):
  zswap: shrinks zswap pool based on memory pressure

 Documentation/admin-guide/mm/zswap.rst |  12 +
 include/linux/list_lru.h               |  39 +++
 include/linux/memcontrol.h             |   6 +
 include/linux/mmzone.h                 |  14 +
 include/linux/zswap.h                  |   9 +
 mm/list_lru.c                          |  46 ++-
 mm/memcontrol.c                        |  33 ++
 mm/swap_state.c                        |  50 +++-
 mm/zswap.c                             | 397 ++++++++++++++++++++++---
 9 files changed, 548 insertions(+), 58 deletions(-)

-- 
2.34.1

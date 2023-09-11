Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3821279B6FD
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 02:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbjIKW0K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242989AbjIKQkb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 12:40:31 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE5FD3;
        Mon, 11 Sep 2023 09:40:25 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5657add1073so3098543a12.0;
        Mon, 11 Sep 2023 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694450425; x=1695055225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dUHQDB4Hx3nVk2JA0BFztp/V0stKrR8xG6ZBM2hfeU=;
        b=HIsBfoT5AAzUOsamF3QtCn7eQcOVUxpYT8pHhzwO0dFI5q2ib5/NxTlZtokp+6eVNq
         +trZbvBHFvVBcDZS37J5bCL/m8rSFoOseCsVUQYlAxWHgd7KJMcJbAXh/RoNf4sziHsG
         n0TV7jCTgXsJO01VjQXF5l2d53TmBieQYj5QgDm9kDUx5NkY2EG+03VY46ZewKrGESx7
         9HOGpDu3b6ZpSYZyfqp53JXS0DmVvawByeZWwvFbcPWrnQGHhELxCL2TYddS8q6JIhTB
         rt522JFTpf0H8U/uwx8A4aUFDDy3Us0QaCwsnBvsH6sSe5vd5WP39tBshCBnpG3LjPrg
         OfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694450425; x=1695055225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dUHQDB4Hx3nVk2JA0BFztp/V0stKrR8xG6ZBM2hfeU=;
        b=E3OzgI9ssHhChRqpb4Bla71BSxcVnMDjUvhpVVkXM/+aMKE25emP6EEQ92nXbdOe2b
         8OkRowEgH4Wc0++Pw8gjbbuohmrlLAe5TmmjqQLGKNglyVmCtuUkhYFZTvtiIH3lNd2F
         vRtAjRLPFjLGGHx3hlz9koW0k7vwHtbJDPkezTrzSkMiMEXBCJjk7tJaA8wpDbYoj0iz
         gQwwhnfgWG9zfK+8U7waPxqWZGJql3xwcKlqjB2s/hHSlmcQO0HslgG1wFfhwW3Is2BY
         XxH+JTsN8mA1C6edgm4EpxgASjN0yJjD2TIFwIPYfx0mltU8ikJhAsF7AFuSc1BSOIC2
         m8FA==
X-Gm-Message-State: AOJu0YwG36sTAtWba5rT6/gUAxTmhQ2xEajYaB2Q2zaQ7s1FggH0HzRi
        FV0+z6hG8G3vJi066mvj/vg=
X-Google-Smtp-Source: AGHT+IH/zKG57DJyRWj53arZp0pE9/Mo0fA5xhe/Yh+pYSzhEr861yCpA92LlXhBwSEJ6QO9cu4qsA==
X-Received: by 2002:a17:90b:118d:b0:268:2af6:e48c with SMTP id gk13-20020a17090b118d00b002682af6e48cmr173907pjb.4.1694450425086;
        Mon, 11 Sep 2023 09:40:25 -0700 (PDT)
Received: from localhost (fwdproxy-prn-008.fbsv.net. [2a03:2880:ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a194c00b0026f90d7947csm6396955pjh.34.2023.09.11.09.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:40:24 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 0/2] workload-specific and memory pressure-driven zswap writeback
Date:   Mon, 11 Sep 2023 09:40:22 -0700
Message-Id: <20230911164024.2541401-1-nphamcs@gmail.com>
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
 include/linux/memcontrol.h             |   1 +
 include/linux/mmzone.h                 |  14 +
 include/linux/zswap.h                  |   9 +
 mm/list_lru.c                          |  46 ++-
 mm/memcontrol.c                        |  33 +++
 mm/swap_state.c                        |  50 +++-
 mm/zswap.c                             | 369 ++++++++++++++++++++++---
 9 files changed, 518 insertions(+), 55 deletions(-)

-- 
2.34.1

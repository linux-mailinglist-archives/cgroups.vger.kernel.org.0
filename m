Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A630079E115
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 09:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbjIMHqX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbjIMHqW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 03:46:22 -0400
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E61729
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 00:46:18 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id 71dfb90a1353d-48d112a5031so596122e0c.1
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694591177; x=1695195977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TER8l9tb6XZzOMFgeFSUUqc1AW9x7/45uI22fSAHiTA=;
        b=07+WdqIaZ62bL1NR1/jE36y+R6Hf/helqNcR3uGo7SuO1VsW4bk07+04+I2141ONOy
         v5T3VOIwl07mW8M9f4gJcv04NyN/BdgAWnNfoGKXBuIQoHU+0BxOGLMaLMj15HgW5d3M
         hqY/fgwZmPa7ialtDk26Fl58B+4OCbztA6dnxa/sP/a5RNbb3NBbgezNNxXFW7e3mcjo
         cT99d/UPFGRumc7X/fkt45ypieoe87aCv3tfuwa7MohZJt7mValPcYaLLy7T+9U/4cpF
         pkUMgKklCgNx0vnjf6jhyZdn9JdK4jdTorOD/x5PWKhPMhbVzXULGh3PEQW/KL6S8iqo
         OfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694591177; x=1695195977;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TER8l9tb6XZzOMFgeFSUUqc1AW9x7/45uI22fSAHiTA=;
        b=pZIQMp/1RPpDdnGju704rmGbDH+mdLe/k1kGtyUM9kOs4tXmn6R/A1jXuRFRQf5Gtf
         tK/Xz/10sEeIDBsfmTJHuCUJj1nI1127i1LrnNS8bVwVaarNhUvLBCcyRv2L1o7+sJH6
         A2sAk2RFq26G64HenfGlKvEw1GflW77KXqHRg00xMYFp3FciMZV9IIlKQxqYGgq3rVUC
         PhFR/nPjye7Gt1uutoEgVI+d42Wto0gm8JoTrbajU04GWbmCcpL8KqYbb0DG3zNOemX9
         RnqobDEvf6xVS4qHY1ZBr0R0qo7Ak1Yf/zNwAa7P+9j8c8zroZ/zpSTBpmXst1rmDe74
         8mgg==
X-Gm-Message-State: AOJu0YydGkWhUHIh7xh2ei/Rpa4URoDX2jSLkQsVlMByHTt58oYn23eP
        EqrlmsE7J5FDeQ1gtp713a0Q4mBwFc1pG5dM
X-Google-Smtp-Source: AGHT+IHQp+PFu+njnT1p9w3nSNET2cy8Iap1HxbLqu81ziIGR3gt50Y0BFxbflp2TpmdmnhV8RihdoKxxpXNaGXb
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:dad2:0:b0:d81:5c03:df99 with SMTP
 id n201-20020a25dad2000000b00d815c03df99mr18096ybf.3.1694590730421; Wed, 13
 Sep 2023 00:38:50 -0700 (PDT)
Date:   Wed, 13 Sep 2023 07:38:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913073846.1528938-1-yosryahmed@google.com>
Subject: [PATCH 0/3] memcg: more sophisticated stats flushing
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

The current stats flushing approach is very simple. Everyone tries to
flush the entire tree, and only a single flusher is allowed. Concurrent
flushers just skip the flush completely. This approach has problems that
manifest in both flushing latency and stats accuracy (or freshness).
This series introduces a more sophisticated approach that aims to find a
better trade-off between accuracy and performance. Essentially we try to
get the best accuracy with the minimal amount of work done when possible
(fast path), and we fallback to more expensive or less accurate flushes
only when necessary. Details are in the commit message of patch 3, which
is really the core of this series.

Patches 1 & 2 are just cleanups with no functional change intended.

This series replaces v4 of "memcg: non-unified flushing for userspace
stats" series [1]. I did not send this as v5 as it completely deviates
from what that patchset is doing (but still trying to solve the same
problem). The approach followed in this series attempts to provide a
more generic framework for flushing for both userspace readers and
in-kernel flushers, to avoid having a lot of different flushing flavors.
It also benefits in-kernel flushers as well as userspace readers.

This series is a result of the discussions held in [1], and various
suggestions by Wei Xu <weixugc@google.com>.

[1] https://lore.kernel.org/lkml/20230831165611.2610118-1-yosryahmed@google.com/

Yosry Ahmed (3):
  mm: memcg: change flush_next_time to flush_last_time
  mm: memcg: rename stats_flush_threshold to stats_updates_order
  mm: memcg: optimize stats flushing for latency and accuracy

 include/linux/memcontrol.h |   4 +-
 mm/memcontrol.c            | 125 ++++++++++++++++++++++++++-----------
 mm/vmscan.c                |   2 +-
 mm/workingset.c            |   8 ++-
 4 files changed, 98 insertions(+), 41 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog


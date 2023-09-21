Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29B47A9EDE
	for <lists+cgroups@lfdr.de>; Thu, 21 Sep 2023 22:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjIUUNp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Sep 2023 16:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjIUUNa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Sep 2023 16:13:30 -0400
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717C340646
        for <cgroups@vger.kernel.org>; Thu, 21 Sep 2023 10:25:29 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6c0dc76e736so1541851a34.1
        for <cgroups@vger.kernel.org>; Thu, 21 Sep 2023 10:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317128; x=1695921928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mOW1s/LOhiEKmGFQGGQ/gb7iNiCsFWbcKv8d4ZT/dpI=;
        b=CjJ5DEmctwvJmDivlGOZayu69dVslBOYB8GS02XumWAWtE/qbYB1LwhIY2JTvPcMoS
         2owXtm1ci+xfViV2S4eg0C9davVlZoJ6Xb48fOyMmeEXtD9K/sMBcs+cqmyuSf+CcLOB
         3aG6XTpQNU7Tn9sVR/09W4N4l8cgpG/Nsy7WPN6CdDQJ5ee+Rev9iDsJlSfhKHlrPKDz
         KFZqit/YC11Uwa3ESxYOf7OwccbPF167rX6y0bY/fBs0UQO5/uHgJ2BGESj4UPiEianJ
         PXU3kLxI5drqlD2CFpHn2HajA2MSwIRL9RC44i8890RvLMO684knJwXf1vdZpH1qk+7A
         ye6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317128; x=1695921928;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOW1s/LOhiEKmGFQGGQ/gb7iNiCsFWbcKv8d4ZT/dpI=;
        b=EOXcdf0CDbBKUsb4Uoxtv08I2T5rfEYHqjcW2sycgVwD0GO88bvPmgVGiMXfoPtRGE
         AEIv8yy0V0kzVvslhWESMrgTAw0Xn25Zbr65f9RMq/J6YYzIo+gy7nUuWnv8zKfeavZe
         3l1lvh6Rexu+7zW5EYZhgieNYiYIiSdxQ/2f//x32lYaTgoCFTsAteXSdj2zcxa9PUGo
         KaOupGwzEX5S8I9rKM+hfa0Cyqvzgg9u3TUNATiZSKBHeZvxdcvtNV3H7nd/563ruple
         8GlUrwN71u4Z9KXeb3egnXm62dwfp3Eh1qDwFhjORtNoGSCQM1+IQxyd2wd1b2pAGOOh
         x0Bw==
X-Gm-Message-State: AOJu0YzPp9TBNfyZl6SnCTqS/V4lHbLGpcRYBqepRPDFV2CI2Mtoq1hX
        A+RJGJXNjTvrchb5u59paWlXUq5hqAvChAK4
X-Google-Smtp-Source: AGHT+IFTPKV8hb5qPNKFt3PlKNQhm1PDDliL803lQAuNf6oYVsKA/DfLdwy4CO7/lb7z+piXyQB3c4gswMGqoV1s
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:ae59:0:b0:59b:ebe0:9fcd with SMTP
 id g25-20020a81ae59000000b0059bebe09fcdmr73922ywk.7.1695283861434; Thu, 21
 Sep 2023 01:11:01 -0700 (PDT)
Date:   Thu, 21 Sep 2023 08:10:52 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921081057.3440885-1-yosryahmed@google.com>
Subject: [PATCH 0/5] mm: memcg: subtree stats flushing and thresholds
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
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This series attempts to address shortages in today's approach for memcg
stats flushing, namely occasionally stale or expensive stat reads. The
series does so by changing the threshold that we use to decide whether
to trigger a flush to be per memcg instead of global (patch 3), and then
changing flushing to be per memcg (i.e. subtree flushes) instead of
global (patch 5).

Patch 3 & 5 are the core of the series, and they include more details
and testing results. The rest are either cleanups or prep work.

This series replaces the "memcg: more sophisticated stats flushing"
series [1], which also replaces another series, in a long list of
attempts to improve memcg stats flushing. It is not a v2 as it is a
completely different approach. This is based on collected feedback from
discussions on lkml in all previous attempts. Hopefully, this is the
final attempt.

[1]https://lore.kernel.org/lkml/20230913073846.1528938-1-yosryahmed@google.com/

Yosry Ahmed (5):
  mm: memcg: change flush_next_time to flush_last_time
  mm: memcg: move vmstats structs definition above flushing code
  mm: memcg: make stats flushing threshold per-memcg
  mm: workingset: move the stats flush into workingset_test_recent()
  mm: memcg: restore subtree stats flushing

 include/linux/memcontrol.h |   8 +-
 mm/memcontrol.c            | 269 +++++++++++++++++++++----------------
 mm/vmscan.c                |   2 +-
 mm/workingset.c            |  37 +++--
 4 files changed, 181 insertions(+), 135 deletions(-)

-- 
2.42.0.459.ge4e396fd5e-goog


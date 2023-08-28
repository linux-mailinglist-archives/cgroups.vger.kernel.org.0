Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F25578BB8E
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 01:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjH1Xdv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Aug 2023 19:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjH1XdZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Aug 2023 19:33:25 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE0F129
        for <cgroups@vger.kernel.org>; Mon, 28 Aug 2023 16:33:22 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-68bee0c327eso4584019b3a.1
        for <cgroups@vger.kernel.org>; Mon, 28 Aug 2023 16:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693265602; x=1693870402;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQTsLL1n7cCq71JxJGUMYc54rEwbEyB3OuO4iu2aarw=;
        b=UPEryLU2GgdQoGyZh3R8dc8akU7NKnHSY8YQq196qyPn5q7YC7C+9h8N9EB+FtnlHs
         GZNJt9Hw1VKSRbB9r4AqsYFwfY7d/dbJ7z8C6CKrqsjGtNdWtPLvVLEh8T4Ivzysl93l
         qSxDurpdYj2UpjTQUnZw48OSObetl2LyyihLIiPl83eIL29OfNsAXdhOFvI+Vzuqkgl9
         tGLw3ltaCZA7nrlI4vfrJ8x3Bf7bbke3gB/moM8qrDVrz1N2z7p8VThO+vxf8IiIezzq
         repAHOCi/EM9d70gn4esvBCcaVXNySYPtOU1gg/KTODmwhL7fgqK2QcyXNaFrtoP8gsq
         hpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693265602; x=1693870402;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQTsLL1n7cCq71JxJGUMYc54rEwbEyB3OuO4iu2aarw=;
        b=SZXuyGgeyP1FPHlHCO5ghkf5FBcpm10oLxKReawdLsOv3qd2bpFKyRWZTunrY+h/xg
         q0jcqnyZR4wirfsh1dRyJAbnUPZ5vEYWNu/6vxBUY6P+gAMLvuSgv2VM5/UVE9DWLKKt
         uBIHMMyxjXDADlKE4UuA/MhXBgxnn9sKx+bnoWolqtnNYVEj9aQt9Hb7SBVIut380YYn
         w6+l1O/U9CYYykprH7X6xJ9eSKzt35m0tbSIz/2egx6/TWb44ROKiUFUgvwnTV2vCzLQ
         1fX9wiAQzhfgWSyWTrbGKNSE4372cBzPU7mQKD53D5vGiN4MpWgfcUGa35mY/GhtUidH
         i/aQ==
X-Gm-Message-State: AOJu0Yz7N145nlmICqsW8/yxYiq0Fl26bCs1m9xUr1kQXLZZzKld0ye8
        E8+d5PFgZ3PkpABjxdLMvtcdvEdWLqN30nmX
X-Google-Smtp-Source: AGHT+IHu5D1vnZqc5tr+eCDW6Mg43DzP7XlEkCvF+uj4cjZd1gRalpgdfoQt2IB2rrSWuVezWxIGvc2DWu9WCeYf
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:189f:b0:68c:1004:1fd7 with
 SMTP id x31-20020a056a00189f00b0068c10041fd7mr2726364pfh.6.1693265602247;
 Mon, 28 Aug 2023 16:33:22 -0700 (PDT)
Date:   Mon, 28 Aug 2023 23:33:14 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230828233319.340712-1-yosryahmed@google.com>
Subject: [PATCH v2 0/4] memcg: non-unified flushing for userspace stats
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

Most memcg flushing contexts using "unified" flushing, where only one
flusher is allowed at a time (others skip), and all flushers need to
flush the entire tree. This works well with high concurrency, which
mostly comes from in-kernel flushers (e.g. reclaim, refault, ..).

For userspace reads, unified flushing leads to non-deterministic stats
staleness and reading cost. This series clarifies and documents the
differences between unified and non-unified flushing (patches 1 & 2),
then opts userspace reads out of unified flushing (patch 3).

This patch series is a follow up on the discussion in [1]. That was a
patch that proposed that userspace reads wait for ongoing unified
flushers to complete before returning. There were concerns about the
latency that this introduces to userspace reads, especially with ongoing
reports of expensive stat reads even with unified flushing. Hence, this
series follows a different approach, by opting userspace reads out of
unified flushing completely. The cost of userspace reads are now
determinstic, and depend on the size of the subtree being read. This
should fix both the *sometimes* expensive reads (due to flushing the
entire tree) and occasional staless (due to skipping flushing).

I attempted to remove unified flushing completely, but noticed that
in-kernel flushers with high concurrency (e.g. hundreds of concurrent
reclaimers). This sort of concurrency is not expected from userspace
reads. More details about testing and some numbers in the last patch's
changelog.

v1 -> v2:
- Added patch 3 to help unified stats with non-unified root flushes
  as suggested by Michal Koutn=C3=BD.
- Updated the last patch changelog after discussions with Michal Hocko,
  Shakeel Butt, and Waiman Long.

Yosry Ahmed (4):
  mm: memcg: properly name and document unified stats flushing
  mm: memcg: add a helper for non-unified stats flushing
  mm: memcg: let non-unified root stats flushes help unified flushes
  mm: memcg: use non-unified stats flushing for userspace reads

 include/linux/memcontrol.h |  8 ++--
 mm/memcontrol.c            | 83 ++++++++++++++++++++++++++------------
 mm/vmscan.c                |  2 +-
 mm/workingset.c            |  4 +-
 4 files changed, 65 insertions(+), 32 deletions(-)

--=20
2.42.0.rc2.253.gd59a3bf2b4-goog


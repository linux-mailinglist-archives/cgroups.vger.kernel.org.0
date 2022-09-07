Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8518C5AFB55
	for <lists+cgroups@lfdr.de>; Wed,  7 Sep 2022 06:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIGEf6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Sep 2022 00:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIGEf5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Sep 2022 00:35:57 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F32983F12
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 21:35:56 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x6-20020a170902ec8600b001754410b6d0so9148985plg.10
        for <cgroups@vger.kernel.org>; Tue, 06 Sep 2022 21:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=ARY6z7c/YNSdIuDysr3yMfPrF2u31pVSHbSH5GcWfeE=;
        b=q9iz05jUj6H8xeR7Sm+d7zjR+v2lZM1+/kobuusBNoE0JoCXsnK5bvzGtwyNvIi+8U
         GH0rPOO/xKYtM5rIULeimIKEZZVJeN/gEjimKq/+hEkeS7sgv9BRF1RCpPU7KRJNQYSM
         /IzUDL95+VcFL2q0Hl1EA+8A4hiMO8I4UOYJkfJk31lHrFMFpY3kU6ZhV5p0RvFXs2Fc
         UlZLfi/vZLQbZVH2VXXNbSO7/GoY43Xu+6nJQn00xcfl2xayw4LodDd3F6zHSD8U1xOT
         jmaT8lo9ciYyboax/cu4Uy4QhBL7yP5SMSve8KtYnM2oG0G9+Ws+S3Z7uRssba6RB5BT
         8dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ARY6z7c/YNSdIuDysr3yMfPrF2u31pVSHbSH5GcWfeE=;
        b=08J74EkXqJjEm6a0IFim6jbU3g+LhfgXEkL75oUSW3dEp9FnbsFYcxp07mG6By622w
         H2p+3mtkYqP225OrF/9e9Ea8olXImjlAs8mQUoPrQXDbtqovMTSHSGponv+8SEDVmh4X
         wAX2ljSpdR/OJE1vQHRbL+9sVKR8Vmt/e6pIWi6ndgi/wgWcLiJN7L3B7rczXY+K1vvI
         Qqki1/nG34EC8yLbtb4/LXHLP5fPr1qRDXBnV/ZFa86iEtqwtUu/85S245husrfR0sb4
         xmeOWffq0OY6o89rJbeBCZmkOek+uTunSEBqDlUstUexPSZDAsWCVSNZ7un8Ml7suo7b
         MUCA==
X-Gm-Message-State: ACgBeo3Gv3DXSKq+agvqoP1lF9Nkk/eq7rojR/j7M6V6Dcce0EuKA76R
        sHMMa8CGFWDGPXdHYWczw6QN7Wcm77j7fA==
X-Google-Smtp-Source: AA6agR4RN/+AWtypu7tKu3vEW1cNt2tGz6dzgwmT/rIEWRZ6fGu1/x0neVk1AwsgO1V3Ikni4DvzdVJzEwX3Vg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:525a:0:b0:42b:28a9:8a34 with SMTP id
 s26-20020a63525a000000b0042b28a98a34mr1724012pgl.269.1662525356139; Tue, 06
 Sep 2022 21:35:56 -0700 (PDT)
Date:   Wed,  7 Sep 2022 04:35:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907043537.3457014-1-shakeelb@google.com>
Subject: [PATCH 0/3] memcg: reduce memory overhead of memory cgroups
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently a lot of memory is wasted to maintain the vmevents for memory
cgroups as we have multiple arrays of size NR_VM_EVENT_ITEMS which can
be as large as 110. However memcg code uses small portion of those
entries. This patch series eliminate this overhead by removing the
unneeded vmevent entries from memory cgroup data structures.

Shakeel Butt (3):
  memcg: extract memcg_vmstats from struct mem_cgroup
  memcg: rearrange code
  memcg: reduce size of memcg vmstats structures

 include/linux/memcontrol.h |  37 +---------
 mm/memcontrol.c            | 145 ++++++++++++++++++++++++++++---------
 2 files changed, 113 insertions(+), 69 deletions(-)

-- 
2.37.2.789.g6183377224-goog


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457FC531F53
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 01:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiEWXo4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 May 2022 19:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiEWXoz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 May 2022 19:44:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7690F880F8;
        Mon, 23 May 2022 16:44:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m1so14431189plx.3;
        Mon, 23 May 2022 16:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pDcZJaTRyOHg9w4kEsRf2ua14bTPNjwhSlPe2z4tQPk=;
        b=CTemy5RVJvKRYgzwSyQkolRT2ww2JNpWblhiywZ240VM/rYlcYZWwuLZ2mgYm9ZBbt
         sUFV3gAtRxEeJWf4zH8Mff7XREsuIkAVugVgRP9sU2XeiQ1ZTlbCFIx+pGRYO6UmiFfX
         tHgGHdOcKBcGrbB7aR6DKnckb6aLNlr0VtikD8owymd3x/JF0yIp5VlE9Tin0HvOvTrD
         IkgZfIyUXN4pthTV3uhJiU6PexhFvvaKLR7jfIsEintpD/feIYaVwxVZ833D8fHbR7zU
         cvqE8ayRigy0aL8qo9cfJLMT9/DJl8dOjiWXhN9Bb1AEGT7waxhBSR5XX+uZvzBUE+3Q
         VXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=pDcZJaTRyOHg9w4kEsRf2ua14bTPNjwhSlPe2z4tQPk=;
        b=XHqNn/S8mKFoMvoY34aH9U3Qd3wIvjyXX4FLY3isV96GdWgsURmmy/7fRlVVYcPk+Q
         XEgIROt7ePSGbDu6mxN9OelWccO4PkcOvM9uLetST0oa2DOg9KSa/KOYj/yJIFAeFAG+
         LoFfIcTd2RhCFyZO8SNv99K643kaT1E855QGIhr/R0BU0s6l28+qCS5PXRb/kSrDrPsV
         qD/CFEHUGHAW/fpx4WwAkq4OUMSVVR9TKTBt8mPT78w4xDokLPR/V7YnCH96wJWFxM9L
         3lMYU0LUjgravwlJgMECURnfERRGT3lnrYs2CVREGtjpPKPKyh1KLHhJd9uNVf7OweTJ
         Fjhg==
X-Gm-Message-State: AOAM531rxQ6uWmFhAFO6WfXnsCiafIjiN8yisTT+ZvE+BqfXXiGSXsSk
        LLZ4VVUoT6jgn7VwbxkRee75dSbri4g=
X-Google-Smtp-Source: ABdhPJzoze2yJLj0jTXZYxl+m+cQH13aKN7jR9tpW0tP0PfQ9eU7hapRL9Txe6WJ7t5gLNVGsQ+/Ug==
X-Received: by 2002:a17:90a:7349:b0:1dc:9314:8699 with SMTP id j9-20020a17090a734900b001dc93148699mr1512468pjs.184.1653349493776;
        Mon, 23 May 2022 16:44:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:aafd])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0050dc7628196sm7703839pfo.112.2022.05.23.16.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 16:44:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 23 May 2022 13:44:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.19-rc1
Message-ID: <Yowcc/ZOBIIs2JtZ@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

Nothing too interesting. It adds cpu controller selftests and there are a
couple code cleanup patches.

Thanks.

The following changes since commit 281b9d9a4b02229b602a14f7540206b0fbe4134f:

  Merge branch 'akpm' (patches from Andrew) (2022-04-22 10:10:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.19

for you to fetch changes up to b154a017c92011d8f71ce804583e5f9c3d90bb9a:

  cgroup: remove the superfluous judgment (2022-05-19 21:49:45 -1000)

----------------------------------------------------------------
David Vernet (9):
      cgroup: Add new test_cpu.c test suite in cgroup selftests
      cgroup: Add test_cpucg_stats() testcase to cgroup cpu selftests
      cgroup: Add test_cpucg_weight_overprovisioned() testcase
      cgroup: Add test_cpucg_weight_underprovisioned() testcase
      cgroup: Adding test_cpucg_nested_weight_overprovisioned() testcase
      cgroup: Add test_cpucg_nested_weight_underprovisioned() testcase
      cgroup: Add test_cpucg_max() testcase
      cgroup: Add test_cpucg_max_nested() testcase
      cgroup: Add config file to cgroup selftest suite

Phil Auld (1):
      kselftest/cgroup: fix test_stress.sh to use OUTPUT dir

Shida Zhang (1):
      cgroup: remove the superfluous judgment

Waiman Long (1):
      kseltest/cgroup: Make test_stress.sh work if run interactively

Xiu Jianfeng (1):
      cgroup: Make cgroup_debug static

 kernel/cgroup/cgroup-internal.h               |   1 -
 kernel/cgroup/cgroup.c                        |   4 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  12 +
 tools/testing/selftests/cgroup/cgroup_util.h  |   4 +
 tools/testing/selftests/cgroup/config         |   8 +
 tools/testing/selftests/cgroup/test_cpu.c     | 726 ++++++++++++++++++++++++++
 tools/testing/selftests/cgroup/test_stress.sh |   2 +-
 9 files changed, 756 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/config
 create mode 100644 tools/testing/selftests/cgroup/test_cpu.c

-- 
tejun

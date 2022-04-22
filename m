Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF2450BC4E
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 17:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390909AbiDVQAo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388249AbiDVQAk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 12:00:40 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723B15DA63;
        Fri, 22 Apr 2022 08:57:47 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id b17so6327866qvp.6;
        Fri, 22 Apr 2022 08:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xndd22pRCbxHKJgUFMYpySvXlLsTmNU6TAEv5LDON7Y=;
        b=1tuY6z4SxGSp1pg3P3ZJWCs1u7QqvRSpaeCDfjvAgWo9/HmUuLKCYCz6ufxSwWfnJh
         zbJuT6XyE3jTnCZFUFGsugcVtSH6kxd0lz1+b8rWlWjkQ/ha01VP0L8GZzP47wENsdNc
         j78Ucdg+d+eXjOk5sQHJmrzLpLf5vH1PK8Ef3u+L7gnDP1DGwLMgTSdejbO3kMeedpij
         8efIRMsCBycyOV5fQ/9X2zanaOiaE+iJ8EdKWPqRj8+F6Kl7FrP3Kz8acf3ZJT0Ybq39
         jxiVLB7mzmO5apBCcH2XxH5IruFgHmdi0Y2PFHeIKeo+k36u4hPssECvx13F5fkQZxfL
         kzUw==
X-Gm-Message-State: AOAM531sdXEipjAx9dq0uYGMBV1z+kIRywQUuEnuVW5fuxJSK0MpO9G/
        r+YT7T36rdcCssijVvVqZl0=
X-Google-Smtp-Source: ABdhPJz8vekvOIGYSvs4ljIiWGq3glYsC/ZEz2KOr8vJEqLWuuy+8QCTERQpL+9QQabTtDiEH93L8g==
X-Received: by 2002:a05:6214:23cc:b0:44f:4974:4c1c with SMTP id hr12-20020a05621423cc00b0044f49744c1cmr4022837qvb.116.1650643066441;
        Fri, 22 Apr 2022 08:57:46 -0700 (PDT)
Received: from localhost (fwdproxy-ash-020.fbsv.net. [2a03:2880:20ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id f11-20020ac859cb000000b002f3438493a5sm1382061qtf.27.2022.04.22.08.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:57:46 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com, void@manifault.com
Subject: [PATCH 0/5] Fix bugs in memcontroller cgroup tests
Date:   Fri, 22 Apr 2022 08:57:24 -0700
Message-Id: <20220422155728.3055914-1-void@manifault.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tools/testing/selftests/cgroup/test_memcontrol.c contains a set of
testcases which validate expected behavior of the cgroup memory controller.
Roman Gushchin recently sent out a patchset that fixed a few issues in the
test. This patchset continues that effort by fixing a few more issues that
were causing non-deterministic failures in the suite. With this patchset,
I'm unable to reproduce any more errors after running the tests in a
continuous loop for many iterations. Before, I was able to reproduce at
least one of the errors fixed in this patchset with just one or two runs.

David Vernet (5):
  cgroups: Refactor children cgroups in memcg tests
  cgroup: Account for memory_recursiveprot in test_memcg_low()
  cgroup: Account for memory_localevents in
    test_memcg_oom_group_leaf_events()
  cgroup: Removing racy check in test_memcg_sock()
  cgroup: Fix racy check in alloc_pagecache_max_30M() helper function

 tools/testing/selftests/cgroup/cgroup_util.c  | 12 ++++
 tools/testing/selftests/cgroup/cgroup_util.h  |  1 +
 .../selftests/cgroup/test_memcontrol.c        | 69 +++++++++++++------
 3 files changed, 61 insertions(+), 21 deletions(-)

-- 
2.30.2


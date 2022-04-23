Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE550CC09
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 17:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiDWP7w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 11:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiDWP7s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 11:59:48 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C75E9B;
        Sat, 23 Apr 2022 08:56:50 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id o18so7600383qtk.7;
        Sat, 23 Apr 2022 08:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYSyRCk38u4G2hktKJeu3gAfTkZxhlPFYSytt9pTpIw=;
        b=OrAsGGvI7KVsuFC7+m+H5y48lbisyzgehwBNVCgYJMw4teiiGO5nYN2dzcuLDISM9C
         rMZYJYOSSIjKACCcP3SFwlo0EQ4YQxQMOtHLBJkeg20NM4KUkc6eWrI1tFcit6KPRBjH
         ptWxTsC04zq7qh6UC9SnB+Cy7zZWcQf+JiBuv/UVQzgx47GyeV1vMqZ8N9FHMts74Qwv
         p4m36gammhz1if0uu5HicciF586qjGGNUu/rFZzYoUm/SgevG6fwXqR5t1rcTwg2OaB7
         VPC7lAcPhZP0QzOdHfsa4Pl6mYjrb1rgfw+ghAla0h5WICVS67GbyhbD5zgHun72fu4y
         RhAw==
X-Gm-Message-State: AOAM533gLFfUFp7NbUaCPBgpFnfUg6RNsTADhU4+VkRwtzs55twpdURe
        h7yQbuqt8SfsdkBSe0HI9jY=
X-Google-Smtp-Source: ABdhPJwMzqu+MSfBXkoJcYYp/xxZpV8JWGg4fm1DIKo3/DT++ZvLT7JwV9+hqT59/UZrCpyeL1m+zw==
X-Received: by 2002:ac8:5f06:0:b0:2f1:f657:eb3a with SMTP id x6-20020ac85f06000000b002f1f657eb3amr6846295qta.151.1650729409102;
        Sat, 23 Apr 2022 08:56:49 -0700 (PDT)
Received: from localhost (fwdproxy-ash-022.fbsv.net. [2a03:2880:20ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id n11-20020a05622a11cb00b002f344f11849sm2967490qtk.71.2022.04.23.08.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:56:48 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com, void@manifault.com
Subject: [PATCH v2 0/5] Fix bugs in memcontroller cgroup tests
Date:   Sat, 23 Apr 2022 08:56:15 -0700
Message-Id: <20220423155619.3669555-1-void@manifault.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

Changelog:
v2:
  - Fixed the comment headers in test_memcg_min() and test_memcg_low() to
    reflect the new ordering of child cgroups in those tests.
  - Fixed the comment I added in test_memcg_oom_group_leaf_events() to use /* */
    for multiline comments, as is the norm according to the kernel style guide.
  - Changed some of the conditional logic in test_memcg_oom_group_leaf_events()
    that checks for OOM event counts based on memory_localevents to be more
    intuitive.

David Vernet (5):
  cgroups: Refactor children cgroups in memcg tests
  cgroup: Account for memory_recursiveprot in test_memcg_low()
  cgroup: Account for memory_localevents in
    test_memcg_oom_group_leaf_events()
  cgroup: Removing racy check in test_memcg_sock()
  cgroup: Fix racy check in alloc_pagecache_max_30M() helper function

 tools/testing/selftests/cgroup/cgroup_util.c  | 12 +++
 tools/testing/selftests/cgroup/cgroup_util.h  |  1 +
 .../selftests/cgroup/test_memcontrol.c        | 77 ++++++++++++-------
 3 files changed, 64 insertions(+), 26 deletions(-)

-- 
2.30.2


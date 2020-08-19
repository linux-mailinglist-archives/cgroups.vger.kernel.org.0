Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17F3249405
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 06:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgHSE1C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 00:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSE1B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 00:27:01 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92310C061389;
        Tue, 18 Aug 2020 21:27:01 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x69so20536122qkb.1;
        Tue, 18 Aug 2020 21:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6h612JI2s0g5y4Ra24/kFs/yiArKTc1sB1o5qgaZ/yA=;
        b=LNxAKNkPYb4d+9N1/y9oUHLhX61kCIDjUBthQJ7A+5jMmKKB0C+Lv50He4t5SJQZTy
         L2JVj53G4ItXbzZAJpmXd2RUU4bNLcRG7dT4aMeHwMd/LhrckJ4LxNKRoNAYQNchSUrd
         ngQlflwv1GSSfQiAmYTIwGlUiHdbt1Y9eyam0cCfh5xO756GrdchR4hinz2jWLBHHwMy
         UPZCJp2C9hGe5uxoIyI39NAt1X8qOQu7qibpJ+lfUO4DsinFdI3vOgjN0pBE1U8ZYXAS
         tD7jnvOY6pm6XVJFFrpNdi28Jgihb4pRUESe4xonX7brqf6enMEk4Xy5GJgPavb/eEZT
         8G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=6h612JI2s0g5y4Ra24/kFs/yiArKTc1sB1o5qgaZ/yA=;
        b=iL9B/h0IMpy5+os/KyvZdVg4rgm3LHaFhld52VbYo4a76Lnv6NFx7lAwnm26hi+yrg
         4HDedM3V9uz50rSzR3y/v0lMrRKMPF3irpbz/0ARXPkrcih5Z6fJ3uKnObHJTgBUV5AP
         8ejr6NyRC1Ha4neCbLyxxm9MXs2qxMPR6j0Ohs7cIaaTYuTuBrryEOKIsxWj/qe1YsSt
         qM6HIr+V0JvBov3WR7gWNOhECkzL7QxMwVMBFYkwWPZpsF3H5UHlbCEb/zUNrR+8Ap7U
         6b/iITKgJqg071tiWHjGYE10DMbfpLOJ1Re9BwIwTYXnz+Q8SQtaoY2M56uV6A/vbZOX
         ATSA==
X-Gm-Message-State: AOAM533PutsdK0K9TFrVKSoYgelHVx6lLgsbE0ZPKBRKo/MBEgDUTvkf
        3csmaNq3WZhI2fo6Jb3ZFPk=
X-Google-Smtp-Source: ABdhPJylEsOCdjZdF2eeYykig8JI40Wf/lz3GHwFqsez2w2N902LfrVnwird2UDZxzuMrxfmvnRANw==
X-Received: by 2002:a37:68c1:: with SMTP id d184mr20369324qkc.62.1597811220457;
        Tue, 18 Aug 2020 21:27:00 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id q68sm22892666qke.123.2020.08.18.21.26.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 21:27:00 -0700 (PDT)
Subject: [RFC PATCH v2 0/5] Minor cleanups and performance optimizations for
 LRU rework
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     alex.shi@linux.alibaba.com
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        daniel.m.jordan@oracle.com, linux-mm@kvack.org,
        shakeelb@google.com, willy@infradead.org, hannes@cmpxchg.org,
        tj@kernel.org, cgroups@vger.kernel.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com
Date:   Tue, 18 Aug 2020 21:26:57 -0700
Message-ID: <20200819041852.23414.95939.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

So this patch set addresses a few minor issues I have found and is based on
the lrunext branch of the tree at:
https://github.com/alexshi/linux.git

The first three patches address various issues if ound with the patch set
such as the fact that we were skipping non-LRU compound pages one 4K page
at a time, the fact that test_and_set_skip had been made redundant by the
fact that the LRU bit made the setting of the bit exclusive per pageblock,
and the fact that we were using put_page while holding the LRU lock.

The last two patches are some patches I have been experimenting with.
Basically trying to reduce the number of times the LRU lock has to be
released and reacquired by batching LRU work together, or deferring the
freeing/returning of pages to LRU in the case of move_pages_to_lru. I am
still working on generating data but for the fourth patch I have seen an
improvement of about 5% on the will-it-scale/page_fault2 test with THP
enabled by default, however that is just some preliminary data and I still
have a number of tests left to run.

---

Alexander Duyck (5):
      mm: Identify compound pages sooner in isolate_migratepages_block
      mm: Drop use of test_and_set_skip in favor of just setting skip
      mm: Add explicit page decrement in exception path for isolate_lru_pages
      mm: Split release_pages work into 3 passes
      mm: Split move_pages_to_lru into 3 separate passes


 mm/compaction.c |   84 +++++++++++++++---------------------------
 mm/swap.c       |  109 ++++++++++++++++++++++++++++++++++---------------------
 mm/vmscan.c     |   77 +++++++++++++++++++++++----------------
 3 files changed, 142 insertions(+), 128 deletions(-)

--

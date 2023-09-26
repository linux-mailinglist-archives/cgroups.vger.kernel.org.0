Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58DE7AF466
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 21:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjIZTt7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 15:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjIZTt5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 15:49:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D5EA3;
        Tue, 26 Sep 2023 12:49:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5db4925f9so69183375ad.1;
        Tue, 26 Sep 2023 12:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695757790; x=1696362590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eOqgy57dPqf5vnOZG5GluAdrnFdDMotUGmbkzIntuoI=;
        b=cMi+dVzCMxIl5V8uHyvS0g5XJQjv84d7ORx2jDwmbZGm5d/Dh0wN4LHeABFPxL6j0J
         sn0V2L+U9z3ximkOu90jAKlf1gDY1vAS5AtmutwaMgcnZFS2DZSUhNNNsqknK1Dz8Hwq
         Nr0M07VEoJAa9WXm5jTgqKJ1OHP3kSd+xwSyp1iyxSpcU9kowTnOcGStIFnbDmTucmBB
         aDkSF2evrajTYxnaOYjOSaczWpTBdA8u4cBUh9/RFcNs2BBRcFjSrOjhxY0tO5vg26Lb
         vXh+w8dV9di5NXW8cSkn5cwxNjckk74gf563c4Nh6/EgBQLcM67Yg5vtNd8Wl1it9M02
         VnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695757790; x=1696362590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOqgy57dPqf5vnOZG5GluAdrnFdDMotUGmbkzIntuoI=;
        b=eLQI97AHPv0RUsNdJrdeKyWomvWzmoF19qvqxEHL3QjzjdqEltpN3Q+rXLAMTBl/Be
         uECiGE8DujKaCMvlJo4MXIStv37P0oKTrWz3u0mU9kcKySG3pTjUw3L9x7mYap8ZxXbW
         fM77oHiiD2DwQ5x/6KlWbnxP+oFFCKaBoGVCCvEigRi2rH5mwIc2ZFnjeX/LMmRN4yoq
         +k8UhcTrKH6aSbMxQ8iZTc/JEmzMYHZVebp/K5mu/MJM79VWFORgEksJz1o7yBGjBe6h
         2wDHBC/5U9NWfG91NztJG6rCHwvepTb9RFlE3YQKaltqK30jy43EYvUyYDzkyNY3I98H
         JZxg==
X-Gm-Message-State: AOJu0Ywhm/WJ7aa/lpEN9UCuEGmsl4skCfVAXyHuN9iZNbXONp+nmETT
        FwvmwL7syYHoQaTK8hy2vTs=
X-Google-Smtp-Source: AGHT+IFQfxmqpXOGPhPftE1Oew2BkuLJR/1RBVCaXchkMkCZp8u2HGDbytSnuJCV42SIu1TGzStKUw==
X-Received: by 2002:a17:902:ecca:b0:1c3:432f:9f69 with SMTP id a10-20020a170902ecca00b001c3432f9f69mr5532611plh.23.1695757790307;
        Tue, 26 Sep 2023 12:49:50 -0700 (PDT)
Received: from localhost (fwdproxy-prn-007.fbsv.net. [2a03:2880:ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id o3-20020a170902d4c300b001b8622c1ad2sm11395931plg.130.2023.09.26.12.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 12:49:49 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 0/2] hugetlb memcg accounting
Date:   Tue, 26 Sep 2023 12:49:47 -0700
Message-Id: <20230926194949.2637078-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, hugetlb memory usage is not acounted for in the memory
controller, which could lead to memory overprotection for cgroups with
hugetlb-backed memory. This has been observed in our production system.

This patch series rectifies this issue by charging the memcg when the
hugetlb folio is allocated, and uncharging when the folio is freed. In
addition, a new selftest is added to demonstrate and verify this new
behavior.

Nhat Pham (2):
  hugetlb: memcg: account hugetlb-backed memory in memory controller
  selftests: add a selftest to verify hugetlb usage in memcg

 MAINTAINERS                                   |   2 +
 fs/hugetlbfs/inode.c                          |   2 +-
 include/linux/hugetlb.h                       |   6 +-
 include/linux/memcontrol.h                    |   8 +
 mm/hugetlb.c                                  |  23 +-
 mm/memcontrol.c                               |  40 ++++
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 .../selftests/cgroup/test_hugetlb_memcg.c     | 222 ++++++++++++++++++
 9 files changed, 297 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_hugetlb_memcg.c

-- 
2.34.1

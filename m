Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812717B1029
	for <lists+cgroups@lfdr.de>; Thu, 28 Sep 2023 02:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjI1A50 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 20:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI1A50 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 20:57:26 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3CEBF;
        Wed, 27 Sep 2023 17:57:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5827f6d60aaso5115715a12.3;
        Wed, 27 Sep 2023 17:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695862644; x=1696467444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sD2wWZIfPcmHhJT+GMtj+x1EEBi2NflbeYV6Occ/i+c=;
        b=FVveHHzXpfOjGV2H1qN7CkdbKSJAZobytc4P6O3U2rvYHA4ei2/j4Zk3+rehgivJUM
         /l9CR6unAngMyhGrfjVubf51UatzVmj9TF7qpsHzqr63X2VJv6ARMThjv1Af3X63ZsLH
         YZEMMNq5BszHFA1rC3dIvAACk2jGKOmCoPZCt1bjb0Qv6JwiHj5/VEnh+pseeTNwk5WG
         gcjroof8llK7wzNEtrcAFwJQe7p/ObmihT56Qnmo6lWW+NoXRBZi3dXjhLTmKQs1Jd3+
         0tBsUjZWps+eD0CbyjeFS5ON77Xq8HN+9SwqgMf3Pb82NC6dGBlGiu8nr/pMKS2FlGLP
         2Zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695862644; x=1696467444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sD2wWZIfPcmHhJT+GMtj+x1EEBi2NflbeYV6Occ/i+c=;
        b=MpktOFvW71H+ZW4flGIy8atFUxuaqCttBmY/fEHXavQFxCUJbMbeLObrED4vqrKGJe
         bFBWsEWTf6g5nY6oANd24aMJZDcrPfUCVUhxL+YA/O3p+RJ+ggoUP8WlSLlbT/cFSz0V
         56LCj6e1iNdhTsdMhT18bMax7mqhdzjXZH9CLrdFB6ouG9ZYmuS0NsOI1kE4zwN374SJ
         tIEDr7TgXMnU5mG6GjpmLx2yJ5EqF2dYpIh1J2dXnn2ZnAsfqYoo3F9MGe8ZoOKK9D0y
         MQGS5VMWhNSzHv4490KNpnwVU7KX0wgeQMbGc+12lCn/3gZZrEkaT6+aOQ4bj9UaVr7c
         s8WQ==
X-Gm-Message-State: AOJu0YzqOaQ6Kp67kZwzZKcKkiFMfu2MBubXggCCLg3qqd8b8w8+v0Ab
        t1Zul7h7GyHSdrOYROOCNG8=
X-Google-Smtp-Source: AGHT+IEWHDi0IEBItUnMQNx/EOdHh7CuSW8OO48aHoTeVlPy/2yXozxQpgYza/XqHCnFi1KAOM7Ayg==
X-Received: by 2002:a05:6a20:9147:b0:160:c1b9:a759 with SMTP id x7-20020a056a20914700b00160c1b9a759mr4043353pzc.20.1695862644240;
        Wed, 27 Sep 2023 17:57:24 -0700 (PDT)
Received: from localhost (fwdproxy-prn-003.fbsv.net. [2a03:2880:ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902708100b001bb0eebd90asm13684774plk.245.2023.09.27.17.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 17:57:23 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v2 0/2] hugetlb memcg accounting
Date:   Wed, 27 Sep 2023 17:57:21 -0700
Message-Id: <20230928005723.1709119-1-nphamcs@gmail.com>
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

Changelog:
v2:
	* Add a cgroup mount option to enable/disable the new hugetlb memcg
	  accounting behavior (patch 1) (suggested by Johannes Weiner).
	* Add a couple more ksft_print_msg() on error to aid debugging when
	  the selftest fails. (patch 2)

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

 Documentation/admin-guide/cgroup-v2.rst       |   9 +
 MAINTAINERS                                   |   2 +
 fs/hugetlbfs/inode.c                          |   2 +-
 include/linux/cgroup-defs.h                   |   5 +
 include/linux/hugetlb.h                       |   6 +-
 include/linux/memcontrol.h                    |   8 +
 kernel/cgroup/cgroup.c                        |  15 +-
 mm/hugetlb.c                                  |  23 +-
 mm/memcontrol.c                               |  41 +++
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 .../selftests/cgroup/test_hugetlb_memcg.c     | 234 ++++++++++++++++++
 12 files changed, 338 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_hugetlb_memcg.c

-- 
2.34.1

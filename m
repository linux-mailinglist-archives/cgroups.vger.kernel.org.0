Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C39B7B5E0A
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 02:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbjJCASf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 20:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJCASf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 20:18:35 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E96ECC;
        Mon,  2 Oct 2023 17:18:30 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-578d0d94986so189221a12.2;
        Mon, 02 Oct 2023 17:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696292310; x=1696897110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/BmJv0MBfIMWl5p2QDJcq2KnxKw0Xqy0pinCaSmlKA0=;
        b=VD9NIKD452HLZ8DEp455A/rYwZAkoO1wiQWV7kqhlsLGYWzgiESZ7D7T6Ah3Iw+I+A
         7fQXwfHHEBM+D0rWLiG1oqXaCBG3oVFzzj+AUvItsvQZ/u2YltsTKK0A06+61eDpoDH+
         8m8XMasPr8Uo0oOU5ZlpsxGa9n6QoXGoLAHVuUjkHYhnsMU5cunoiPwLS9b/T0o0tYME
         rGAmdAoucOx9Shdldo29QZ+HeGeCVYB+Ohc2CEuJnaaaDLDVF0dKlP95jutJYhZyqzwN
         HXuSSdQbCWqXaPUC4baQansXOBYZUoDj92COSiHmBs+BghclVGkgrQD0c/sSpgPAAhXH
         0kqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696292310; x=1696897110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BmJv0MBfIMWl5p2QDJcq2KnxKw0Xqy0pinCaSmlKA0=;
        b=OXrPWmD4pdUb6cmZe5cI31TJOSIcmj6PzU7NCBbOHHhOw11NxXhhja6M2enRm/NfZP
         t4J0eI+UT2Q0LfWjbyOUhHhW+wxVl2g//lpWS8aYH8+drWt1BuidmABstK2PncLsbreT
         mL+2X43SVr7nObqDDcTnWlCANgJ8mUkqdqCkWYJLozK3zlVZ7V6T/CTElI879WgccY16
         zvDvzdpd864tkOXgGCEcShkXtAN6OG4sJhxHy2G9fR5drrush7uRJ2alf0RSktDraMH6
         KIUYEh/saBXNiBv3BHpfULsADSzYKiqwqutno4PFTzeY7mr/MC9hxRyvhg2hIQddhZ57
         2jig==
X-Gm-Message-State: AOJu0YwLlbfMqkLZyB7kYPwZsKfYKmPHzxFub6TuphzJw5P8dJwdJ0LH
        re7CzGzyV90G3RAl4HLmLy2w8TozhjqPHQ==
X-Google-Smtp-Source: AGHT+IEtRLbmYGNzQPbUlvZunesWVPYxVjxoOOuUZUSuJa0fiHw8kPNU15WfO3xHatmOWY85p7O+XQ==
X-Received: by 2002:a05:6a20:9719:b0:162:6588:7174 with SMTP id hr25-20020a056a20971900b0016265887174mr11557807pzc.28.1696292309933;
        Mon, 02 Oct 2023 17:18:29 -0700 (PDT)
Received: from localhost (fwdproxy-prn-018.fbsv.net. [2a03:2880:ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id g7-20020aa78187000000b00688435a9915sm73158pfi.189.2023.10.02.17.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:18:29 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v3 0/3] hugetlb memcg accounting
Date:   Mon,  2 Oct 2023 17:18:25 -0700
Message-Id: <20231003001828.2554080-1-nphamcs@gmail.com>
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
v3:
	* Add a prep patch at the start of the series to extend the memory
	  controller interface with new helper functions for hugetlb
	  accounting.
	* Do not account hugetlb memory for memcontroller in cgroup v1
	  (patch 2) (suggested by Johannes Weiner).
	* Change the gfp flag passed to mem cgroup charging (patch 2)
	  (suggested by Michal Hocko).
	* Add caveats to cgroup admin guide and commit changelog
	  (patch 2) (suggested by Michal Hocko).
v2:
	* Add a cgroup mount option to enable/disable the new hugetlb memcg
	  accounting behavior (patch 1) (suggested by Johannes Weiner).
	* Add a couple more ksft_print_msg() on error to aid debugging when
	  the selftest fails. (patch 2)

Currently, hugetlb memory usage is not acounted for in the memory
controller, which could lead to memory overprotection for cgroups with
hugetlb-backed memory. This has been observed in our production system.

For instance, here is one of our usecases: suppose there are two 32G
containers. The machine is booted with hugetlb_cma=6G, and each 
container may or may not use up to 3 gigantic page, depending on the 
workload within it. The rest is anon, cache, slab, etc. We can set the
hugetlb cgroup limit of each cgroup to 3G to enforce hugetlb fairness. 
But it is very difficult to configure memory.max to keep overall 
consumption, including anon, cache, slab etc. fair.
 
What we have had to resort to is to constantly poll hugetlb usage and
readjust memory.max. Similar procedure is done to other memory limits
(memory.low for e.g). However, this is rather cumbersome and buggy.
Furthermore, when there is a delay in memory limits correction, (for
e.g when hugetlb usage changes within consecutive runs of the userspace
agent), the system could be in an over/underprotected state.

This patch series rectifies this issue by charging the memcg when the
hugetlb folio is allocated, and uncharging when the folio is freed. In
addition, a new selftest is added to demonstrate and verify this new
behavior.

Nhat Pham (3):
  memcontrol: add helpers for hugetlb memcg accounting
  hugetlb: memcg: account hugetlb-backed memory in memory controller
  selftests: add a selftest to verify hugetlb usage in memcg

 Documentation/admin-guide/cgroup-v2.rst       |  29 +++
 MAINTAINERS                                   |   2 +
 include/linux/cgroup-defs.h                   |   5 +
 include/linux/memcontrol.h                    |  30 +++
 kernel/cgroup/cgroup.c                        |  15 +-
 mm/hugetlb.c                                  |  35 ++-
 mm/memcontrol.c                               |  94 ++++++-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 .../selftests/cgroup/test_hugetlb_memcg.c     | 234 ++++++++++++++++++
 10 files changed, 427 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_hugetlb_memcg.c

-- 
2.34.1

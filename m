Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE297BBEE2
	for <lists+cgroups@lfdr.de>; Fri,  6 Oct 2023 20:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjJFSqd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Oct 2023 14:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjJFSqc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Oct 2023 14:46:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D91C6;
        Fri,  6 Oct 2023 11:46:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-69af8a42066so1392393b3a.1;
        Fri, 06 Oct 2023 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617991; x=1697222791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2s4i0NFYgIBv1cJZUrejLYvQnyIri0mts0GvRI59+ZQ=;
        b=m71AVx5Asuo1MG15b1CAY92Bhkf80JrPz70M8VdbrR6q2eu/Nf+Q8q7i3cyG5ow4eb
         8+ukgjpTzNxPPwHBg6wgKZ0zA2hFtF0D7ddIE/gORHKxSSpYIiauq+O12WQawBwVLnc3
         SKoOIfjBoUkbylxSveZOEnwbIX2Bo7Kgp3u95WMV9UHe4773EEStyjV4E/mqkBBR3y3m
         zK2bSxLX7YC2IgRJBpLLZsQmfRYYdMhiNrOaNK6QUKSFzugiRQzZ6S1bN4EVZtHovqlF
         CnVKzAIBoFiCQ1/kYBbgl+02l0s8YHz/I4zps/W0YcdaLjmDLYzTqCO++nSg5XuLbaWp
         XL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617991; x=1697222791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2s4i0NFYgIBv1cJZUrejLYvQnyIri0mts0GvRI59+ZQ=;
        b=qfO56BxcXoiv4E5JNfUbhHfmx+TUReqLOqfjctBbDtUI9/9fjew02nnGdjMsv+S2ap
         G9Cqj+duq7zMosMPfpAvi3w9lcP9D26aIICD4jiLLGmTYFgma0LChLSj+/YTqJU8h3m9
         0mBf8wYtj35VEkdqgDoH5Hn36XZSg7aFIYokZ9oZj1O4I7z6Sx5tRifWwSMJGbHOr/Y9
         hlrorw71b+15PtJ3rrIR0RYgtPUv5dGD6kzaRM/9l0caJvzbFhs7q7LCMYEzR15EVfsM
         7K9yvykKs40sgT+0Z5IFo+ohov1HLc7UlHqdEjBipi1sM+OahlwUJiP8ZAgdmfq8NkKU
         PbPg==
X-Gm-Message-State: AOJu0YxneR69uGhJY/Q2r8DLScsuyYwK1luBCqIn26HAYANxmIb1ZvpO
        HLozRSkHMcx9vpYrxxprKfA=
X-Google-Smtp-Source: AGHT+IFh2JBtLTorBxbati1NWKp48DoHPTohn7WHY69D8nGHAnt4czmX5CCj+n6BTX0EGyhcAYyzdw==
X-Received: by 2002:a05:6a20:841b:b0:137:2f8c:fab0 with SMTP id c27-20020a056a20841b00b001372f8cfab0mr10387583pzd.49.1696617990622;
        Fri, 06 Oct 2023 11:46:30 -0700 (PDT)
Received: from localhost (fwdproxy-prn-000.fbsv.net. [2a03:2880:ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id v13-20020aa7808d000000b0068ffd4eb66dsm1812830pff.35.2023.10.06.11.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:46:30 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH v4 0/4] hugetlb memcg accounting
Date:   Fri,  6 Oct 2023 11:46:25 -0700
Message-Id: <20231006184629.155543-1-nphamcs@gmail.com>
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
v4:
	* Add another prep patch to clean up memory controller migration
	  logic.
	* Fix an issue in hugetlb folio migration where the new folio
	  is not properly charged (patch 3) (reported by Mike Kravetz)
	  (suggested by Johannes Weiner).
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

Nhat Pham (4):
  memcontrol: add helpers for hugetlb memcg accounting
  memcontrol: only transfer the memcg data for migration
  hugetlb: memcg: account hugetlb-backed memory in memory controller
  selftests: add a selftest to verify hugetlb usage in memcg

 Documentation/admin-guide/cgroup-v2.rst       |  29 +++
 MAINTAINERS                                   |   2 +
 include/linux/cgroup-defs.h                   |   5 +
 include/linux/memcontrol.h                    |  37 +++
 kernel/cgroup/cgroup.c                        |  15 +-
 mm/filemap.c                                  |   2 +-
 mm/hugetlb.c                                  |  35 ++-
 mm/memcontrol.c                               | 139 +++++++++--
 mm/migrate.c                                  |   3 +-
 tools/testing/selftests/cgroup/.gitignore     |   1 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 .../selftests/cgroup/test_hugetlb_memcg.c     | 234 ++++++++++++++++++
 12 files changed, 478 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_hugetlb_memcg.c

-- 
2.34.1

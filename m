Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55982D6F23
	for <lists+cgroups@lfdr.de>; Fri, 11 Dec 2020 05:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395351AbgLKEYN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Dec 2020 23:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731917AbgLKEXn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Dec 2020 23:23:43 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78AFC0613CF
        for <cgroups@vger.kernel.org>; Thu, 10 Dec 2020 20:23:03 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id l23so1679246pjg.1
        for <cgroups@vger.kernel.org>; Thu, 10 Dec 2020 20:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JadMn18aCnIs/6Vjw45Dh3eAfbEtua6oaOg4kdj6BCQ=;
        b=eCkNBMu8UVMzizfhgKu+N0keqKcYMkDxoJqXSjBAJuVT24Zx4JcNlyj0zk9vCTikLs
         lmzn027hZix4kWPCyIGZc1e46yyFv/eFpJz+1yi15kgG+bSNG+uyewJKh+89avQLygjj
         rQMrtG67rImSPoJJ9pa7mEwIZ4pF1N+8l2eozAfJ5BAejTuj052QDZOo2I0PvwKCgYqx
         OtShU6qB3lCEaj6fqfhCiiYnLMKVF/kLzQV8XXJ/Pmt+NTyUYCgSL4ZHiYXjxhf5hiLY
         41wf3VKfjPgBY/IGXC7MWQBe/DOuf1DDWIrxCUjdMiZHSI3AcnQitgBRtjadqjT0bNko
         W6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JadMn18aCnIs/6Vjw45Dh3eAfbEtua6oaOg4kdj6BCQ=;
        b=HI0lK0pSnRatojl5REPT9nBtFDAlTa+YuxUUxWIMGNu03mgIJz7vdK3tYL7e0Y4pxq
         dVroWAGvEFOzdoEAqIbyQI03cr0OVqfmRTgJAPh1vQ5BX4JINZLUenp4wE4yZfso0BLI
         ISCKs9Dn+ayYo3LEWXXZ8PkL7+Gr+yK/PM10O6KyEjcKdCoanqFWa64Mgc2sPkhuyZ4w
         vFcudE20oyeS7CbVXMM8TYyZc40DTssowWptBtA5b8cBOUJmB6/lDbru/L2vhfVz9tsa
         I4JEjddVC002uh+gL/fEl14uel3wO664IeEUNhA7wrLglh/R0fNqAgYz4iS/gUHh+8uk
         HTOA==
X-Gm-Message-State: AOAM53233tYYNWcCLIOCX29goODZwbUv80tMAxSiWoPG1KSUJr14WbmD
        HcRmaKgTVcReJx7zjw9hBcrg8w==
X-Google-Smtp-Source: ABdhPJyjs37u4Khap3K42fbJclkpOu+lkUmwWGHiGDK8D2XhmsaFMZHcC5foQkbHXZA+aC4clu6KhQ==
X-Received: by 2002:a17:902:9a90:b029:da:ba07:efdc with SMTP id w16-20020a1709029a90b02900daba07efdcmr9255576plp.1.1607660583024;
        Thu, 10 Dec 2020 20:23:03 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id 19sm8623352pfu.85.2020.12.10.20.22.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 20:23:02 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 0/7] Convert all THP vmstat counters to pages
Date:   Fri, 11 Dec 2020 12:19:47 +0800
Message-Id: <20201211041954.79543-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

This patch series is aimed to convert all THP vmstat counters to pages.

The unit of some vmstat counters are pages, some are bytes, some are
HPAGE_PMD_NR, and some are KiB. When we want to expose these vmstat
counters to the userspace, we have to know the unit of the vmstat counters
is which one. When the unit is bytes or kB, both clearly distinguishable
by the B/KB suffix. But for the THP vmstat counters, we may make mistakes.

For example, the below is some bug fix for the THP vmstat counters:

  - 7de2e9f195b9 ("mm: memcontrol: correct the NR_ANON_THPS counter of hierarchical memcg")
  - The first commit in this series ("fix NR_ANON_THPS accounting in charge moving")

This patch series can make the code clear. And make all the unit of the THP
vmstat counters in pages. Finally, the unit of the vmstat counters are
pages, kB and bytes. The B/KB suffix can tell us that the unit is bytes
or kB. The rest which is without suffix are pages.

In this series, I changed the following vmstat counters unit from HPAGE_PMD_NR
to pages. However, there is no change to the print format of output to user
space.

  - NR_ANON_THPS
  - NR_FILE_THPS
  - NR_SHMEM_THPS
  - NR_SHMEM_PMDMAPPED
  - NR_FILE_PMDMAPPED

Although every THP stats update overflows the per-cpu counter, resorting to
atomic global updates.

But this change is consistent with 4.7's 8f182270dfec ("mm/swap.c: flush
lru pvecs on compound page arrival"): we accepted greater overhead for
greater accuracy back then, so I think it's okay to do so for THP stats.
Thanks Hugh for mentioning this.

This was inspired by Johannes and Roman. Thanks to them.

Changes in v3 -> v4:
  - Rename the first commit subject to "mm: memcontrol: fix NR_ANON_THPS
    accounting in charge moving".
  - Fix /proc/vmstat printing. Thanks to Johannes points out that.

Changes in v2 -> v3:
  - Change the series subject from "Convert all vmstat counters to pages or bytes"
    to "Convert all THP vmstat counters to pages".
  - Remove convert of KB to B.

Changes in v1 -> v2:
  - Change the series subject from "Convert all THP vmstat counters to pages"
    to "Convert all vmstat counters to pages or bytes".
  - Convert NR_KERNEL_SCS_KB account to bytes.
  - Convert vmstat slab counters to bytes.
  - Remove {global_}node_page_state_pages.

Muchun Song (7):
  mm: memcontrol: fix NR_ANON_THPS accounting in charge moving
  mm: memcontrol: convert NR_ANON_THPS account to pages
  mm: memcontrol: convert NR_FILE_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
  mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
  mm: memcontrol: make the slab calculation consistent

 drivers/base/node.c    |  27 +++++-----
 fs/proc/meminfo.c      |  10 ++--
 include/linux/mmzone.h |  13 +++++
 mm/filemap.c           |   4 +-
 mm/huge_memory.c       |   9 ++--
 mm/khugepaged.c        |   4 +-
 mm/memcontrol.c        | 132 +++++++++++++++++++++++--------------------------
 mm/page_alloc.c        |   7 ++-
 mm/rmap.c              |  19 ++++---
 mm/shmem.c             |   3 +-
 mm/vmstat.c            |  11 ++++-
 11 files changed, 130 insertions(+), 109 deletions(-)

-- 
2.11.0


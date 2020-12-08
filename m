Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC912D21FB
	for <lists+cgroups@lfdr.de>; Tue,  8 Dec 2020 05:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgLHEVi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Dec 2020 23:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgLHEVi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Dec 2020 23:21:38 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458DBC061749
        for <cgroups@vger.kernel.org>; Mon,  7 Dec 2020 20:20:52 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 131so12622739pfb.9
        for <cgroups@vger.kernel.org>; Mon, 07 Dec 2020 20:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=INwAUa8avMAOYbaB9rtoZiE/Uy1WuPgrXID/tKq7Y4o=;
        b=h/6saWcxTLU/DKFG4oIjuuEDovFaZD1Ql3H24mQ6ZWdxdgezFfyhebiqTeFEKAN3Tl
         En+Ha/3H7N2CkoQD6qgmYoM/vrvVSNRjDmmsaVrJDh4wkkCNV6OOZCERX4tO5/u3g2Tz
         d7YAzvkgah5iQyIP3ylMC62iw7/Y3NPAhGBMnlBQ58mB9zlkWhPTclA3CuPDSbnlXSc7
         9WCjSpbQgg1FBySH7zUl9Dnrh4UF2wRMw34n+1CsWqJChlCjwVWi7Rgz0V+nli8AHDW8
         n4KJWsxHERxQ0QGjcsNOdDjH2hjXp2mZhsBTJkMe+Dzhho2XWjyUNIBrnxu9VyX71VBT
         wFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=INwAUa8avMAOYbaB9rtoZiE/Uy1WuPgrXID/tKq7Y4o=;
        b=XfngDaCu2qZLhB1SWNRUk1HaHFUM/iyunyMRVg8ZevPA3FkVMVKVU1U4yV5S3A9xBp
         slZPdrVkYFWAXusyOLRxayi/6/Pl0Wjd6ZMkCkICEmZbE06ClnFw2X0Hbnz04WkRQ29B
         CdJltztSXeXSBcwl+S27mcodwq9zFyleRcgzZ2X3e056+6sU1rbFIPkzDvBnf/ktT3vr
         xvtmjzgs6mqm+jIjKF/OIxAzdE1oXUtSf5TubKeXwh7x0AM1oNJFD6jBU8exedfXHiuE
         acLMuT4E7jy2ea1GHSCJxP6vDeRRFIYRlC/DWB32Bwf684cnia95vsa5S89KI/Pa9GTq
         TI3Q==
X-Gm-Message-State: AOAM530lNQBduQcIzmXl41Sw8Umrp/4CbF8SIX3RI9LrS6hh3/4bVn3S
        ZBunqE1pBHDvnqO5G+w0MWca4Q==
X-Google-Smtp-Source: ABdhPJwg6s8o790FlKSFquJnMGwqcffA65CpEykidVkNyFYWLAYFLP1GVkP70naEE9TEtRS09jE/VA==
X-Received: by 2002:a17:90a:6fc7:: with SMTP id e65mr2280093pjk.116.1607401251862;
        Mon, 07 Dec 2020 20:20:51 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id mr7sm1031166pjb.31.2020.12.07.20.20.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:20:51 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/7] Convert all THP vmstat counters to pages
Date:   Tue,  8 Dec 2020 12:18:40 +0800
Message-Id: <20201208041847.72122-1-songmuchun@bytedance.com>
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
by the B/KB suffix. But for the THP vmstat counters, We may make mistakes.

For example, the below is some bug fix for the THP vmstat counters:
  - 7de2e9f195b9 ("mm: memcontrol: correct the NR_ANON_THPS counter of hierarchical memcg")
  - Not committed which is the first commit in this series ("mm: memcontrol: fix NR_ANON_THPS account")

This patch series can make the code clear. And make all the unit of the THP
vmstat counters in pages. Finally, the unit of the vmstat counters are
pages, kB and bytes. The B/KB suffix can tell us that the unit is bytes
or kB. The rest which is without suffix are pages.

As Hugh said, "It does need to be recognized that, with these changes, every
THP stats update overflows the per-cpu counter, resorting to atomic global
updates.

But this change is consistent with 4.7's 8f182270dfec ("mm/swap.c: flush
lru pvecs on compound page arrival"): we accepted greater overhead for
greater accuracy back then, so I think it's okay to do so for THP stats."

This was inspired by Johannes and Roman. Thanks to them.

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
  mm: memcontrol: fix NR_ANON_THPS account
  mm: memcontrol: convert NR_ANON_THPS account to pages
  mm: memcontrol: convert NR_FILE_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
  mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
  mm: memcontrol: make the slab calculation consistent

 drivers/base/node.c |  15 ++----
 fs/proc/meminfo.c   |  10 ++--
 mm/filemap.c        |   4 +-
 mm/huge_memory.c    |   9 ++--
 mm/khugepaged.c     |   4 +-
 mm/memcontrol.c     | 139 ++++++++++++++++++++++++++--------------------------
 mm/page_alloc.c     |   7 ++-
 mm/rmap.c           |  19 ++++---
 mm/shmem.c          |   3 +-
 9 files changed, 107 insertions(+), 103 deletions(-)

-- 
2.11.0


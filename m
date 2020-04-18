Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167351AECC7
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2020 15:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDRNpt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Apr 2020 09:45:49 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:54131 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbgDRNps (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Apr 2020 09:45:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TvvMGTO_1587217544;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TvvMGTO_1587217544)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Apr 2020 21:45:45 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: [PATCH v2 0/2] always record memcg id for swapped memcg pages 
Date:   Sat, 18 Apr 2020 21:33:07 +0800
Message-Id: <1587216789-42342-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Johannes,

2 patches fold MEMCG_SWAP feature into kernel as default. I don't know if
they could fit your new solution.

But just in case if they can save you some typing. :)

Thanks
Alex
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
---
Alex Shi (2):
  memcg: folding CONFIG_MEMCG_SWAP as default
  mm/memcg: remove swapaccount kernel parameter

 Documentation/admin-guide/kernel-parameters.txt |  5 --
 arch/arm/configs/omap2plus_defconfig            |  1 -
 arch/arm64/configs/defconfig                    |  1 -
 arch/mips/configs/db1xxx_defconfig              |  1 -
 arch/mips/configs/generic_defconfig             |  1 -
 arch/mips/configs/loongson3_defconfig           |  1 -
 arch/parisc/configs/generic-64bit_defconfig     |  1 -
 arch/powerpc/configs/powernv_defconfig          |  1 -
 arch/powerpc/configs/pseries_defconfig          |  1 -
 arch/s390/configs/debug_defconfig               |  1 -
 arch/s390/configs/defconfig                     |  1 -
 arch/sh/configs/sdk7786_defconfig               |  1 -
 arch/sh/configs/urquell_defconfig               |  1 -
 include/linux/memcontrol.h                      |  4 --
 include/linux/swap.h                            | 27 ----------
 include/linux/swap_cgroup.h                     | 30 -----------
 init/Kconfig                                    | 20 --------
 mm/Makefile                                     |  4 +-
 mm/memcontrol.c                                 | 68 ++++++-------------------
 mm/swap_cgroup.c                                |  7 ---
 20 files changed, 17 insertions(+), 160 deletions(-)

-- 
1.8.3.1


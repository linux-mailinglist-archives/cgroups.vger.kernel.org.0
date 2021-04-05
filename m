Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D367735468E
	for <lists+cgroups@lfdr.de>; Mon,  5 Apr 2021 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhDESJB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 14:09:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:44452 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhDESJB (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Apr 2021 14:09:01 -0400
IronPort-SDR: lm1VF58yJx/j1qK/PIRxDOza5W5ETxeMJIMtf0RsEM+c70RsIF4gEa6l9o0n4dmJujdT8LKn6Y
 kgKFtUJw5HdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193010906"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="193010906"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 11:08:54 -0700
IronPort-SDR: ppiyaFDCkV1nQdzghDpl80nb90mpZhmi6TgJsW2rkqmdwWxiXUl22phoUg7/f7tWWO10yOkN98
 DIg4+Pw449TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="448153854"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2021 11:08:53 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Michal Hocko <mhocko@suse.cz>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 00/11] Manage the top tier memory in a tiered memory
Date:   Mon,  5 Apr 2021 10:08:24 -0700
Message-Id: <cover.1617642417.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Traditionally, all memory is DRAM.  Some DRAM might be closer/faster than
others NUMA wise, but a byte of media has about the same cost whether it
is close or far.  But, with new memory tiers such as Persistent Memory
(PMEM).  there is a choice between fast/expensive DRAM and slow/cheap
PMEM.

The fast/expensive memory lives in the top tier of the memory hierachy.

Previously, the patchset
[PATCH 00/10] [v7] Migrate Pages in lieu of discard
https://lore.kernel.org/linux-mm/20210401183216.443C4443@viggo.jf.intel.com/
provides a mechanism to demote cold pages from DRAM node into PMEM.

And the patchset
[PATCH 0/6] [RFC v6] NUMA balancing: optimize memory placement for memory tiering system
https://lore.kernel.org/linux-mm/20210311081821.138467-1-ying.huang@intel.com/
provides a mechanism to promote hot pages in PMEM to the DRAM node
leveraging autonuma.

The two patchsets together keep the hot pages in DRAM and colder pages
in PMEM.

To make fine grain cgroup based management of the precious top tier
DRAM memory possible, this patchset adds a few new features:
1. Provides memory monitors on the amount of top tier memory used per cgroup 
   and by the system as a whole.
2. Applies soft limits on the top tier memory each cgroup uses 
3. Enables kswapd to demote top tier pages from cgroup with excess top
   tier memory usages.

This allows us to provision different amount of top tier memory to each
cgroup according to the cgroup's latency need.

The patchset is based on cgroup v1 interface. One shortcoming of the v1
interface is the limit on the cgroup is a soft limit, so a cgroup can
exceed the limit quite a bit before reclaim before page demotion reins
it in. 

We are also working on a cgroup v2 interface control interface that will will
have a max limit on the top tier memory per cgroup but requires much
additional logic to fall back and allocate from non top tier memory when a
cgroup reaches the maximum limit.  This simpler cgroup v1 implementation
with all its warts is used to illustrate the concept of cgroup based
top tier memory management and serves as a starting point of discussions.

The soft limit and soft reclaim logic in this patchset will be similar for what
we would do for a cgroup v2 interface when we reach the high watermark
for top tier usage in a cgroup v2 interface. 

This patchset is applied on top of 
[PATCH 00/10] [v7] Migrate Pages in lieu of discard
and
[PATCH 0/6] [RFC v6] NUMA balancing: optimize memory placement for memory tiering system

It is part of a larger patchset.  You can play with the complete set of patches
using the tree:
https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git/log/?h=tiering-0.71

Tim Chen (11):
  mm: Define top tier memory node mask
  mm: Add soft memory limit for mem cgroup
  mm: Account the top tier memory usage per cgroup
  mm: Report top tier memory usage in sysfs
  mm: Add soft_limit_top_tier tree for mem cgroup
  mm: Handle top tier memory in cgroup soft limit memory tree utilities
  mm: Account the total top tier memory in use
  mm: Add toptier option for mem_cgroup_soft_limit_reclaim()
  mm: Use kswapd to demote pages when toptier memory is tight
  mm: Set toptier_scale_factor via sysctl
  mm: Wakeup kswapd if toptier memory need soft reclaim

 Documentation/admin-guide/sysctl/vm.rst |  12 +
 drivers/base/node.c                     |   2 +
 include/linux/memcontrol.h              |  20 +-
 include/linux/mm.h                      |   4 +
 include/linux/mmzone.h                  |   7 +
 include/linux/nodemask.h                |   1 +
 include/linux/vmstat.h                  |  18 ++
 kernel/sysctl.c                         |  10 +
 mm/memcontrol.c                         | 303 +++++++++++++++++++-----
 mm/memory_hotplug.c                     |   3 +
 mm/migrate.c                            |   1 +
 mm/page_alloc.c                         |  36 ++-
 mm/vmscan.c                             |  73 +++++-
 mm/vmstat.c                             |  22 +-
 14 files changed, 444 insertions(+), 68 deletions(-)

-- 
2.20.1


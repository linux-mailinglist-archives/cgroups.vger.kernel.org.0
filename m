Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEFD31E191
	for <lists+cgroups@lfdr.de>; Wed, 17 Feb 2021 22:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhBQVni (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Feb 2021 16:43:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:37244 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231451AbhBQVnh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 17 Feb 2021 16:43:37 -0500
IronPort-SDR: yu291xXaxY5Dor40gJOxhsgKQgZYON/6qXrTnKBr2z0cqLUPvbK5hsb7Azq86gW5AqAH5+lFKv
 849pHoaOL6bQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="182538747"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="182538747"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 13:41:51 -0800
IronPort-SDR: C5zPdU0ypt0CzkHpRKqWVQAn/4XnOcOue0274V7GzSAICfx7mPoouoSEDbHqqA44qoYQTQd/kt
 9ElDZzelpGGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="401430698"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2021 13:41:51 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Soft limit memory management bug fixes 
Date:   Wed, 17 Feb 2021 12:41:33 -0800
Message-Id: <cover.1613584277.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During testing of tiered memory management based on memory soft limit,
I found three issues with memory management using cgroup based soft
limit in the mainline code.  Fix the issues with the three patches in
this series.  Also updated patch 3 per Johannes' comments on the first
version of this patch.

Thanks.

Tim

Changelog:
v2
1. Do soft limit tree uncharge update in batch of the same node only
for v1 cgroups that have a soft limit.  Batching in nodes is only
relevant for cgroup v1 that has per node soft limit tree. 

Tim Chen (3):
  mm: Fix dropped memcg from mem cgroup soft limit tree
  mm: Force update of mem cgroup soft limit tree on usage excess
  mm: Fix missing mem cgroup soft limit tree updates

 mm/memcontrol.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

-- 
2.20.1


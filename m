Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C013A354696
	for <lists+cgroups@lfdr.de>; Mon,  5 Apr 2021 20:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhDESJX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Apr 2021 14:09:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:44460 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233234AbhDESJK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 5 Apr 2021 14:09:10 -0400
IronPort-SDR: AsaJdjHlvXYMgWXK5OUDsiH9eD71N5kP3ciF1LceCvf9YweW5XeB/oKyPCPvb5HIjXNi55JinL
 YwJ3e0krMljg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="193010919"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="193010919"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 11:09:03 -0700
IronPort-SDR: +VoR0p/UgOe2wYsmoXbNkTgi4fj3Sr4bGRZZcdv98Loe80ptqI4Vscp6yUH/RbLdEo6Zw+pzm4
 zinar7ufsiag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="448153903"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Apr 2021 11:09:03 -0700
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
Subject: [RFC PATCH v1 04/11] mm: Report top tier memory usage in sysfs
Date:   Mon,  5 Apr 2021 10:08:28 -0700
Message-Id: <1196182bf902e36c8ecbf2afb7dd570e96c99ff4.1617642417.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617642417.git.tim.c.chen@linux.intel.com>
References: <cover.1617642417.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In memory cgroup's sysfs, report the memory cgroup's usage
of top tier memory in a new field: "toptier_usage_in_bytes".

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 mm/memcontrol.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fe7bb8613f5a..68590f46fa76 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3631,6 +3631,7 @@ enum {
 	RES_FAILCNT,
 	RES_SOFT_LIMIT,
 	RES_TOPTIER_SOFT_LIMIT,
+	RES_TOPTIER_USAGE,
 };
 
 static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
@@ -3673,6 +3674,8 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 		return (u64)memcg->soft_limit * PAGE_SIZE;
 	case RES_TOPTIER_SOFT_LIMIT:
 		return (u64)memcg->toptier_soft_limit * PAGE_SIZE;
+	case RES_TOPTIER_USAGE:
+		return (u64)page_counter_read(&memcg->toptier) * PAGE_SIZE;
 	default:
 		BUG();
 	}
@@ -5073,6 +5076,11 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.write = mem_cgroup_write,
 		.read_u64 = mem_cgroup_read_u64,
 	},
+	{
+		.name = "toptier_usage_in_bytes",
+		.private = MEMFILE_PRIVATE(_MEM, RES_TOPTIER_USAGE),
+		.read_u64 = mem_cgroup_read_u64,
+	},
 	{
 		.name = "failcnt",
 		.private = MEMFILE_PRIVATE(_MEM, RES_FAILCNT),
-- 
2.20.1


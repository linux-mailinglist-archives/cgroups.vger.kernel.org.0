Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5AD315951
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 23:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhBIWVK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 17:21:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:10455 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231511AbhBIWJy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Feb 2021 17:09:54 -0500
IronPort-SDR: 8zlkrScCsAQhacyynrfrjmh//azBrS5Kf9WEhIT/+vAQj8kVBWMumBMH1DUkNhdGVnUhPVaD/0
 bYhch1QYZUCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="161113136"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="161113136"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 13:30:31 -0800
IronPort-SDR: uVa6Dfz4NKU6ISgPucULeMoww2SrWWBz8mm7mxm0p9FJWj7wp9318uC7eGLDt02Eh/mX2n0Gfw
 +gX7rofdiYgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="361952999"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2021 13:30:31 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Soft limit memory management bug fixes 
Date:   Tue,  9 Feb 2021 12:29:44 -0800
Message-Id: <cover.1612902157.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During testing of tiered memory management based on memory soft limit, I found three 
issues with memory management using cgroup based soft limit in the mainline code.
Fix the issues with the three patches in this series.

Tim Chen (3):
  mm: Fix dropped memcg from mem cgroup soft limit tree
  mm: Force update of mem cgroup soft limit tree on usage excess
  mm: Fix missing mem cgroup soft limit tree updates

 mm/memcontrol.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

-- 
2.20.1


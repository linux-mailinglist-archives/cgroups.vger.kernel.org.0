Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF35D72E041
	for <lists+cgroups@lfdr.de>; Tue, 13 Jun 2023 13:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbjFMLAQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Jun 2023 07:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239863AbjFMLAO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Jun 2023 07:00:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5960410E3;
        Tue, 13 Jun 2023 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686654012; x=1718190012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+ZwgnbFFD4kVifWi7M+EUMUQ3jIqdujOFhEyYhD1S1c=;
  b=JTBAaG0sOv1Rby/6HF+IuXtyI7O/r3jO6PWtFjAzUfgCPnOb/ig9O4HQ
   2otyuLjRVO/WnotEshFmJnJIpwOdmh/uPOUjrrFuM3QKDsAqAUkrx0jZV
   /Iiv+116SrixI792ecN5psBfkg5gY3GIBwOZMf4DnamGqmAqBgBJ1YBFF
   4LVMxXrCEYAiiJTEkf2QyejGmWB1ca9+Nbgzj5nggmFyoxnmu8xtGG+wU
   5hRn2gBmyPgPPZSZNgz/x+nHMWCKTlpeY77L9qLHwIzFc3lI2nTQzLMNh
   hrYU78CXIw8Ptdks6PGh4f2C85vVcfSRwGUgvB+wHlFLo2hLNDYMafu1P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="338657979"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="338657979"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 04:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="1041726585"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="1041726585"
Received: from css-dev-lei.sh.intel.com ([10.239.153.153])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2023 04:00:03 -0700
From:   LeiZhou-97 <lei.zhou@intel.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        lei.zhou@intel.com
Subject: [PATCH] cgroup/misc: Expose misc.current on cgroup v2 root
Date:   Tue, 13 Jun 2023 18:59:29 +0800
Message-Id: <20230613105929.269318-1-lei.zhou@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

This patch is to expose misc.current on cgroup v2 root for tracking
how much of the resource has been consumed in total on the system.

Most of the cloud infrastucture use cgroup to fetch the host
information for scheduling purpose.

Currently, the misc controller can be used by Intel TDX HKIDs and
AMD SEV ASIDs, which are both used for creating encrypted VMs.
Intel TDX and AMD SEV are mostly be used by the cloud providers
for providing confidential VMs.

In actual use of a server, these confidential VMs may be launched
in different ways. For the cloud solution, there are kubvirt and
coco (tracked by kubepods.slice); on host, they can be booted
directly through qemu by end user (tracked by user.slice), etc.

In this complex environment, when wanting to know how many resource
is used in total it has to iterate through all existing slices to
get the value of each misc.current and add them up to calculate
the total number of consumed keys.

So exposing misc.current to root cgroup tends to give much easier
when calculates how much resource has been used in total, which
helps to schedule and count resources for the cloud infrastucture.

Signed-off-by: LeiZhou-97 <lei.zhou@intel.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 2 +-
 kernel/cgroup/misc.c                    | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f67c0829350b..d9f3768a10db 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2439,7 +2439,7 @@ Miscellaneous controller provides 3 interface files. If two misc resources (res_
 	  res_b 10
 
   misc.current
-        A read-only flat-keyed file shown in the non-root cgroups.  It shows
+        A read-only flat-keyed file shown in the all cgroups.  It shows
         the current usage of the resources in the cgroup and its children.::
 
 	  $ cat misc.current
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index fe3e8a0eb7ed..ae2f4dd47508 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -357,7 +357,6 @@ static struct cftype misc_cg_files[] = {
 	{
 		.name = "current",
 		.seq_show = misc_cg_current_show,
-		.flags = CFTYPE_NOT_ON_ROOT,
 	},
 	{
 		.name = "capacity",
-- 
2.40.1


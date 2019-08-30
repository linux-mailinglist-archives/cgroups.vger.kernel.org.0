Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFA57A2CB1
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2019 04:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfH3CRL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 22:17:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:19851 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfH3CRL (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Aug 2019 22:17:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 19:17:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,445,1559545200"; 
   d="scan'208";a="183662280"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Aug 2019 19:17:09 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i3WTN-0003aA-98; Fri, 30 Aug 2019 10:17:09 +0800
Date:   Fri, 30 Aug 2019 10:16:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     kbuild-all@01.org, cgroups@vger.kernel.org
Subject: [cgroup:review-iocost-v2 8/12] block/blk-iocost.c:1866
 ioc_cpd_alloc() error: potential null dereference 'iocc'.  (kzalloc returns
 null)
Message-ID: <201908301034.mK1ucDIL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/tj/cgroup.git review-iocost-v2
head:   deaaabcc443b8e576ad5a9cde55e87f67e5ae467
commit: d1409e6f65e258920b2a935a937a3761de2971a0 [8/12] blkcg: implement blk-iocost

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

New smatch warnings:
block/blk-iocost.c:1866 ioc_cpd_alloc() error: potential null dereference 'iocc'.  (kzalloc returns null)

Old smatch warnings:
include/linux/compiler.h:226 __write_once_size() warn: potential memory corrupting cast 8 vs 4 bytes

vim +/iocc +1866 block/blk-iocost.c

  1860	
  1861	static struct blkcg_policy_data *ioc_cpd_alloc(gfp_t gfp)
  1862	{
  1863		struct ioc_cgrp *iocc;
  1864	
  1865		iocc = kzalloc(sizeof(struct ioc_cgrp), gfp);
> 1866		iocc->dfl_weight = CGROUP_WEIGHT_DFL;
  1867	
  1868		return &iocc->cpd;
  1869	}
  1870	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 606CA45A24
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 12:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfFNKOU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jun 2019 06:14:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:55501 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbfFNKOU (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 14 Jun 2019 06:14:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 03:14:19 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Jun 2019 03:14:18 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hbjDt-0008py-Ic; Fri, 14 Jun 2019 18:14:17 +0800
Date:   Fri, 14 Jun 2019 18:13:49 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     kbuild-all@01.org, cgroups@vger.kernel.org
Subject: [cgroup:review-iow 15/17] block/blk-ioweight.c:614:17: sparse:
 sparse: symbol 'iowg_to_blkg' was not declared. Should it be static?
Message-ID: <201906141828.vHqYOehI%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-iow
head:   e2209ac1daf46cd980f6b912c30a910a78f7da24
commit: 3ddd9fc7fba6e817f95c3baa7731826a3e6cbd2c [15/17] blkcg: implement blk-ioweight
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout 3ddd9fc7fba6e817f95c3baa7731826a3e6cbd2c
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> block/blk-ioweight.c:614:17: sparse: sparse: symbol 'iowg_to_blkg' was not declared. Should it be static?
>> block/blk-ioweight.c:2232:9: sparse: sparse: symbol 'iow_cost_model_write' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

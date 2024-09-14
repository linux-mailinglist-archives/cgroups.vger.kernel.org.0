Return-Path: <cgroups+bounces-4881-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9855A9792EC
	for <lists+cgroups@lfdr.de>; Sat, 14 Sep 2024 20:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB33281407
	for <lists+cgroups@lfdr.de>; Sat, 14 Sep 2024 18:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CB91D1301;
	Sat, 14 Sep 2024 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUmI7Zay"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8356D1CF5DB
	for <cgroups@vger.kernel.org>; Sat, 14 Sep 2024 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726337899; cv=none; b=qlP8fh8sxb66Ok0RmHw/htDGxCTnk38y7hG8i6cLwNqgniw1T8il1Wbqt65oQ/iuaWIUIbp1tuLPakv2jUeZGDUvgSNjHa1eGBrleG3XKxw+iycKks3hvk8peZW/Pyre5lefeUC3VXXHRxZu5CpiBgBeIvnuTdBKdnfm1miDxxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726337899; c=relaxed/simple;
	bh=TGcEVMV7r5XnqHiafCACgIBzKSRqkKzpG6M4N3x1U00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEhPISewYwrGZ4pn5URH/SCTuiXNu6Vu3J7CK4i+F1P2npYf/p+IWDhaksqaF5TqvWTP6HhCPQHJTA+J6GaXsbmp8FFkQ6RaoWpPib/uGTO1gcIJjYlHhc3R4w/TEqiVkXbeltRtooja1h2R4dYVWpa/hi7hzAt93SCZ6LBOFE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUmI7Zay; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726337898; x=1757873898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TGcEVMV7r5XnqHiafCACgIBzKSRqkKzpG6M4N3x1U00=;
  b=NUmI7Zayg/KfBmMWN6Rf/Hv72iri6mwbh9oUmsCqju+6NqeTW7vvEZ72
   uX/px9wNbbFG9reV5Uw849R/mHV0Jvfsa3TvH5Eu8+ZT6hecSxw8lgmA4
   I1cJ9rt87Vs/XQ3TmYRZ1GEKkPLaQEisJEPpxjOzABoQpDeGczpeK2lSY
   ok64PofnG4G3mn4safQL2yVDZkf5S9J7R4W+v8OoXO9wWKKxwR5QWOM5Y
   r+vzpKM6HYifNIo4w5uV19g3uATN82hrzUyI3x7ArFx7LmjI/9+6IJ4PB
   7LHMrWCHcE7mH+fd0T7JsclYx426QHeU01FCsDlQQoNztP8xoUpE1u9hB
   A==;
X-CSE-ConnectionGUID: gzIsJBv0SgW+aACsemQs+Q==
X-CSE-MsgGUID: Tfsmbk1fQ3Ke3OkDRznI0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25050970"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="25050970"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 11:18:18 -0700
X-CSE-ConnectionGUID: puOLOI6bQ7yF62JQ38Mh9w==
X-CSE-MsgGUID: pmJaEjG1T7OKjkiTuxEfvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="68399445"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Sep 2024 11:18:15 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spXLY-00083C-02;
	Sat, 14 Sep 2024 18:18:12 +0000
Date: Sun, 15 Sep 2024 02:18:07 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	adityakali@google.com, sergeh@kernel.org, mkoutny@suse.com,
	guro@fb.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 -next 3/3] cgroup/freezer: Reduce redundant
 propagation for cgroup_propagate_frozen
Message-ID: <202409150216.INlNatES-lkp@intel.com>
References: <20240912012037.1324165-4-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912012037.1324165-4-chenridong@huawei.com>

Hi Chen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240911]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Ridong/cgroup-freezer-Reduce-redundant-traversal-for-cgroup_freeze/20240912-093141
base:   next-20240911
patch link:    https://lore.kernel.org/r/20240912012037.1324165-4-chenridong%40huawei.com
patch subject: [PATCH v2 -next 3/3] cgroup/freezer: Reduce redundant propagation for cgroup_propagate_frozen
config: i386-defconfig (https://download.01.org/0day-ci/archive/20240915/202409150216.INlNatES-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240915/202409150216.INlNatES-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409150216.INlNatES-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/cgroup/freezer.c:46:12: warning: explicitly assigning value of variable of type 'struct cgroup *' to itself [-Wself-assign]
      46 |         for (cgrp = cgrp; cgrp; cgrp = cgroup_parent(cgrp)) {
         |              ~~~~ ^ ~~~~
   1 warning generated.


vim +46 kernel/cgroup/freezer.c

    32	
    33	/*
    34	 * Propagate the cgroup frozen state upwards by the cgroup tree.
    35	 */
    36	static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
    37	{
    38		int deta;
    39		struct cgroup *parent;
    40		/*
    41		 * If the new state is frozen, some freezing ancestor cgroups may change
    42		 * their state too, depending on if all their descendants are frozen.
    43		 *
    44		 * Otherwise, all ancestor cgroups are forced into the non-frozen state.
    45		 */
  > 46		for (cgrp = cgrp; cgrp; cgrp = cgroup_parent(cgrp)) {
    47			if (frozen) {
    48				/* If freezer is not set, or cgrp has descendants
    49				 * that are not frozen, cgrp can't be frozen
    50				 */
    51				if (!test_bit(CGRP_FREEZE, &cgrp->flags) ||
    52				    (cgrp->freezer.nr_frozen_descendants !=
    53				     cgrp->nr_descendants))
    54					break;
    55				deta = cgrp->freezer.nr_frozen_descendants + 1;
    56			} else {
    57				deta = -(cgrp->freezer.nr_frozen_descendants + 1);
    58			}
    59	
    60			/* No change, stop propagate */
    61			if (!cgroup_update_frozen_flag(cgrp, frozen))
    62				break;
    63	
    64			parent = cgroup_parent(cgrp);
    65			parent->freezer.nr_frozen_descendants += deta;
    66		}
    67	}
    68	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


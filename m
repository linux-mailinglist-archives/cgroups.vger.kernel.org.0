Return-Path: <cgroups+bounces-5222-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B9E9AEAE9
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 17:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C597D1C20F4F
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8671EF958;
	Thu, 24 Oct 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GK78CX3Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C51F582F;
	Thu, 24 Oct 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784588; cv=none; b=FkzzRGxp8LyZ4P8LKpmE+XUkF/n6gRW5i+OubrHb3m1RGR1fMMV53sYusL2yEFbaqtFbX8LySJL0fGpHtk/DK5VPWYLL3NLhDdsZrGNndjzpj/8zfO4itntFprmt6rm394zFM+uyXggvQ34R5ki9hPuP/QItwcACGq9hfPXcJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784588; c=relaxed/simple;
	bh=5/nbDyWp7n6RsazCVVoeiVcKXifp+4+4MGYC6ov6BU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7XGDjiUTUeCeRmTlQ6dDEMPxA6C26UbLb5YCf4arMA0MgEkRQoWHJCicN5yMb8CwGVzW4J3n8fDEFI9RJfTcalvdUrOcBGX9/tQToaVxCauYY16BHphhCie1NYrkFlkYvYdRyqz0ThEVqzJYiVRKlJKOznZZHAPTHtlqvx67gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GK78CX3Y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729784587; x=1761320587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5/nbDyWp7n6RsazCVVoeiVcKXifp+4+4MGYC6ov6BU8=;
  b=GK78CX3YJoDFeA3n3tDLlB0UDKbPl6PINM6VxRYh6Z6ZyGSbauqTJIqC
   wUL0P0m7Ul/Cvtgh89Qdx0KN1yueCJMZ5F3kPy0+jWpOm/4GhxLGW6q0I
   ILg31ZcVJzLwudcd+aOyuvUH9UEW2OGIQHTnhp7FSuwI2036cvxPZWww7
   Jv7iR62D4GctJu/MARgOR3l49gvwjovcnpYb7RH0VFEJeACYmcQLMDPN4
   czuKvd/tq1bhGFHbPAytmoNrKV5eN+MMblrGC9AXvKOW/YLabDydk3KQ4
   KidbZS+0hQARYMC8ankEuXK9k6ZiqUr59bw66ErHFxgqzKSnvD2C4EE0y
   A==;
X-CSE-ConnectionGUID: Qe5Jwpk1SESmN/AArXMAIQ==
X-CSE-MsgGUID: 3chAKQNFTXCNfGPUBgeDpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29641273"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29641273"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 08:43:06 -0700
X-CSE-ConnectionGUID: TSI0KdEVRK2iC0jv2wV/5w==
X-CSE-MsgGUID: FMV5XWndQSSRW/r8/H+5iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="85735965"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2024 08:43:02 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3zzI-000Wc0-02;
	Thu, 24 Oct 2024 15:43:00 +0000
Date: Thu, 24 Oct 2024 23:42:06 +0800
From: kernel test robot <lkp@intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 2/7] drm/drv: Add drmm cgroup registration for dev
 cgroups.
Message-ID: <202410242324.adtg6g0w-lkp@intel.com>
References: <20241023075302.27194-3-maarten.lankhorst@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023075302.27194-3-maarten.lankhorst@linux.intel.com>

Hi Maarten,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on drm-exynos/exynos-drm-next next-20241024]
[cannot apply to tj-cgroup/for-next drm-xe/drm-xe-next akpm-mm/mm-everything drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v6.12-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maarten-Lankhorst/kernel-cgroup-Add-dev-memory-accounting-cgroup/20241023-155504
base:   git://anongit.freedesktop.org/drm/drm drm-next
patch link:    https://lore.kernel.org/r/20241023075302.27194-3-maarten.lankhorst%40linux.intel.com
patch subject: [PATCH 2/7] drm/drv: Add drmm cgroup registration for dev cgroups.
config: arm64-randconfig-002-20241024 (https://download.01.org/0day-ci/archive/20241024/202410242324.adtg6g0w-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241024/202410242324.adtg6g0w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410242324.adtg6g0w-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_drv.c:29:
   include/linux/cgroup_dev.h:61:12: error: two or more data types in declaration specifiers
      61 | static int int dev_cgroup_try_charge(struct dev_cgroup_device *cgdev,
         |            ^~~
   include/linux/cgroup_dev.h:65:1: error: expected identifier or '(' before '{' token
      65 | {
         | ^
>> include/linux/cgroup_dev.h:61:16: error: 'dev_cgroup_try_charge' declared 'static' but never defined [-Werror=unused-function]
      61 | static int int dev_cgroup_try_charge(struct dev_cgroup_device *cgdev,
         |                ^~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +61 include/linux/cgroup_dev.h

487073b1855ef4 Maarten Lankhorst 2024-10-23  60  
487073b1855ef4 Maarten Lankhorst 2024-10-23 @61  static int int dev_cgroup_try_charge(struct dev_cgroup_device *cgdev,
487073b1855ef4 Maarten Lankhorst 2024-10-23  62  				     u32 index, u64 size,
487073b1855ef4 Maarten Lankhorst 2024-10-23  63  				     struct dev_cgroup_pool_state **ret_pool,
487073b1855ef4 Maarten Lankhorst 2024-10-23  64  				     struct dev_cgroup_pool_state **ret_limit_pool);
487073b1855ef4 Maarten Lankhorst 2024-10-23  65  {
487073b1855ef4 Maarten Lankhorst 2024-10-23  66  	*ret_pool = NULL;
487073b1855ef4 Maarten Lankhorst 2024-10-23  67  
487073b1855ef4 Maarten Lankhorst 2024-10-23  68  	if (ret_limit_pool)
487073b1855ef4 Maarten Lankhorst 2024-10-23  69  		*ret_limit_pool = NULL;
487073b1855ef4 Maarten Lankhorst 2024-10-23  70  
487073b1855ef4 Maarten Lankhorst 2024-10-23  71  	return 0;
487073b1855ef4 Maarten Lankhorst 2024-10-23  72  }
487073b1855ef4 Maarten Lankhorst 2024-10-23  73  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


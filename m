Return-Path: <cgroups+bounces-5221-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D76C9AE2B4
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 12:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D316BB227E2
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 10:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466FD1C4A04;
	Thu, 24 Oct 2024 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdsGpxf4"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6F31C2DA2;
	Thu, 24 Oct 2024 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766154; cv=none; b=ZxmBpcVoAomBl3xBSMMuaE62juWhT8G2hmVTU3crWceda5mZyySKeY+M4LgHY7wOKR1vC9ZQsCoyt0mjsoBpmc3RVLiJvRg/mH3rgfDnFO2dYQJU4Haz9eBP7fJUCrY4mHdbX6qSsombiQadlpfKHbdZvnE4ksINQqk9n6aWlDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766154; c=relaxed/simple;
	bh=UW0hE31GGN8jgPgRZbodK9mIg08FV4Mhsd8DDDS0j2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRgV5Zl3xOzpO+E/4EyW59VxEIt1MqukQI2lI3InIH4VXGUGcx7+hdlmp81jLAe+zEBoE4syFBNTXYeSLtrZ2UJ1pqq5udxLSSGrNZAWOczjBu6v0EYhrZhDYRO6c1w+1PSbryV4YIgR6KVHs4tRo3BxBeRert8l/WzbZuwpHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdsGpxf4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729766151; x=1761302151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UW0hE31GGN8jgPgRZbodK9mIg08FV4Mhsd8DDDS0j2M=;
  b=AdsGpxf4ETpoHfJG0s4EV38xRdSG9cCZlMUTeAit8bg3y2PSwhdN6aSa
   4tjXzR6FX8I0o76n8mK4I9FqO7gccStWS3IEZtDcPlA349LKqYO0hEcgZ
   S6DXdtSN72jsud0qNg9no5BCrjRhO6z/qi7F8DXJowjddnxzX96eQybma
   Z+0WXxyKKfOrrkaIWeEkoGAb4Z2gY4q6T/OPoLBOCwUkx+LHOu8lEwELv
   tF8ITRiypzNR2MTyMQs5l/2fHUNAZW6Y/Jqyn5ymSP2qGDdSMUq3OUivT
   i6IuAxR8JRtmm6acgDEE9pl5Lbb4w1ztst3tDDGs8NCRZ+CK40UutrC8y
   w==;
X-CSE-ConnectionGUID: q5qfkmMZQGujZfY3AutvAg==
X-CSE-MsgGUID: CeOPuL/FSU+FqVr5ks2cIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="46879006"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="46879006"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 03:35:51 -0700
X-CSE-ConnectionGUID: X7Jcr4c5Q3mLZGLgDfcadA==
X-CSE-MsgGUID: ZHEPrOvDR4mIJDGgHS9iMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="111368091"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2024 03:35:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3vBx-000WH7-26;
	Thu, 24 Oct 2024 10:35:45 +0000
Date: Thu, 24 Oct 2024 18:35:27 +0800
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
Message-ID: <202410241806.p6u3FcGS-lkp@intel.com>
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
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241024/202410241806.p6u3FcGS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241024/202410241806.p6u3FcGS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410241806.p6u3FcGS-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_drv.c:29:
>> include/linux/cgroup_dev.h:61:12: error: two or more data types in declaration specifiers
      61 | static int int dev_cgroup_try_charge(struct dev_cgroup_device *cgdev,
         |            ^~~
>> include/linux/cgroup_dev.h:65:1: error: expected identifier or '(' before '{' token
      65 | {
         | ^
>> include/linux/cgroup_dev.h:61:16: warning: 'dev_cgroup_try_charge' declared 'static' but never defined [-Wunused-function]
      61 | static int int dev_cgroup_try_charge(struct dev_cgroup_device *cgdev,
         |                ^~~~~~~~~~~~~~~~~~~~~


vim +61 include/linux/cgroup_dev.h

487073b1855ef4 Maarten Lankhorst 2024-10-23  60  
487073b1855ef4 Maarten Lankhorst 2024-10-23 @61  static int int dev_cgroup_try_charge(struct dev_cgroup_device *cgdev,
487073b1855ef4 Maarten Lankhorst 2024-10-23  62  				     u32 index, u64 size,
487073b1855ef4 Maarten Lankhorst 2024-10-23  63  				     struct dev_cgroup_pool_state **ret_pool,
487073b1855ef4 Maarten Lankhorst 2024-10-23  64  				     struct dev_cgroup_pool_state **ret_limit_pool);
487073b1855ef4 Maarten Lankhorst 2024-10-23 @65  {
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


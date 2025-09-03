Return-Path: <cgroups+bounces-9633-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A11B41172
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 02:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027C1543088
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 00:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D717BA9;
	Wed,  3 Sep 2025 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmAZ4Asf"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52B9179BD
	for <cgroups@vger.kernel.org>; Wed,  3 Sep 2025 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860370; cv=none; b=J+/CG8HVd3qXjEoJ1iJvlv8ippNPOmiUFxR7UJlNBT944cBSOf0V7hvhIOSsFQMrawFOdiuJhi3E+EnfWTXky+6yve4F+mlVbEVQBoSIgTUfgYhTdxiJBxbAc9fjz4zVop556atavapiWaxgTfZH2NqhyFyMIzlwdXX3Kr1FiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860370; c=relaxed/simple;
	bh=b5f4SPDgcSXeVH1wU9IYy52Ijhudx51cDLKHOZ9eYJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecbqmpK7Ve8aqLYELSBoltFPMgiuQK8hC6cfGAJ45Dio2r8vENcBFVMSO9hlwzSAzQdX+MIU7fn245498CB8kMfEHgoz2VDtC5mM3Zq0c5oq1SxhH6o1V/IUG5t+Vu50H2wg9fvIYK79thMJPT5iPJlKltnxdbK6OHfZkILWDEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmAZ4Asf; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756860367; x=1788396367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b5f4SPDgcSXeVH1wU9IYy52Ijhudx51cDLKHOZ9eYJ4=;
  b=CmAZ4AsfW0O4F5lRqxRIGbp6xz+fBFWNc/0Gob4Q3tWI5Q5wxvf1Og+0
   b47BBQSkxbgdAv39+zzeXWjMf9Ju5/oBhoupilR9wTcEA8mf8SWRHfBL5
   LQLQC163e0U8S0YAB9TB/F1KI674xLYIrqSmbQC4xOV/QWuAhN4syaJWW
   dxk3rBDjKDsoW1RbOgeCs1OAvdrbAclHHfeICCgjWISIqpmt39BNcqgo1
   ShX6kGJxkgr6pgPxe2JQQHfT8FPTEux3DcLT0jbxyAuzrKdIkDCC0KZ7o
   vo4+1EJx0h7tQtMFZo/SsfbWmJFw4anZRww5d7Uj1yWmViQ2v5JTVDfhb
   w==;
X-CSE-ConnectionGUID: cpzBMo4bR1W/brBedTVRAA==
X-CSE-MsgGUID: bC/8H6ntTUaBWJ6Or3IMMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58376820"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="58376820"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 17:46:06 -0700
X-CSE-ConnectionGUID: CaRhma6qRIea23WPV102FA==
X-CSE-MsgGUID: 5C/ig5cgRUWHP+URkF25gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="170717073"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Sep 2025 17:46:03 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utbdF-0003Bb-0R;
	Wed, 03 Sep 2025 00:45:54 +0000
Date: Wed, 3 Sep 2025 08:44:53 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	tj@kernel.org, christian.koenig@amd.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>,
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Subject: Re: [PATCH 03/15] ttm/pool: port to list_lru. (v2)
Message-ID: <202509030849.OExBO13p-lkp@intel.com>
References: <20250902041024.2040450-4-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902041024.2040450-4-airlied@gmail.com>

Hi Dave,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-cgroup/for-next]
[also build test ERROR on linus/master v6.17-rc4]
[cannot apply to akpm-mm/mm-everything next-20250902]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Airlie/drm-ttm-use-gpu-mm-stats-to-track-gpu-memory-allocations-v4/20250902-130646
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/20250902041024.2040450-4-airlied%40gmail.com
patch subject: [PATCH 03/15] ttm/pool: port to list_lru. (v2)
config: i386-buildonly-randconfig-002-20250903 (https://download.01.org/0day-ci/archive/20250903/202509030849.OExBO13p-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509030849.OExBO13p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509030849.OExBO13p-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/drm/ttm/ttm_device.h:31,
                    from drivers/gpu/drm/ttm/ttm_range_manager.c:32:
>> include/drm/ttm/ttm_pool.h:57:25: error: field 'pages' has incomplete type
      57 |         struct list_lru pages;
         |                         ^~~~~


vim +/pages +57 include/drm/ttm/ttm_pool.h

    40	
    41	/**
    42	 * struct ttm_pool_type - Pool for a certain memory type
    43	 *
    44	 * @pool: the pool we belong to, might be NULL for the global ones
    45	 * @order: the allocation order our pages have
    46	 * @caching: the caching type our pages have
    47	 * @shrinker_list: our place on the global shrinker list
    48	 * @pages: the lru_list of pages in the pool
    49	 */
    50	struct ttm_pool_type {
    51		struct ttm_pool *pool;
    52		unsigned int order;
    53		enum ttm_caching caching;
    54	
    55		struct list_head shrinker_list;
    56	
  > 57		struct list_lru pages;
    58	};
    59	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


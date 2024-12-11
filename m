Return-Path: <cgroups+bounces-5820-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981D9ED63D
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 20:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC61928456E
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 19:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C25D2594BC;
	Wed, 11 Dec 2024 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yx1BLb2o"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933C62594A0;
	Wed, 11 Dec 2024 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944484; cv=none; b=kcNdowJ+hbKdAy3E6r2eMGtFjHTwI2EgsuxS01W/k1EVpFpeKHmPw/FhPmncAgW2k2GQc6usQsmUgfioJzWUb13GTgBsBdtgT3jJsJsboUjU0EhDmMpVpgsO1K6zvVSibfdViGvMpI7JRD1ZZtkSBxQQanTsHhQpLpsz+aroKb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944484; c=relaxed/simple;
	bh=LoelWbPE6h3w4ImeyPrWnS2h7HbJfCpr6GMroutnPZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP1J5hNUrw/qsNiC/4BjjuY5aP2FEo3rxY4mXE5xEbFnuNozwIuG1qtq7dsxLFxvG8cotE8nXhZ7cf4KoanhGb3CUxuW1K4BP87vs+nbGdY3xquEvvDGa+HiDemqZLuuM3fsNacUXeYg6kixxou1C9eo/RU/b2VGljvaaGcm6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yx1BLb2o; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733944482; x=1765480482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LoelWbPE6h3w4ImeyPrWnS2h7HbJfCpr6GMroutnPZA=;
  b=Yx1BLb2ofx0E3274bjC65kGYWWJ2Y0ZLoNT4Za/i66i3WDAKgGCdNtiw
   atx7sLcsX7WclQnJ1/bPtb7iv+4kRffI9TuOO8gebxVefy2uvxEHsZRkC
   9eysCcX2VLNb9NRpDKWWqWHnqPvp79kPR4n7DqoL948U6XqGKNA/r8Co/
   MwGlwe1ewFy20Pbjd/vKa75MB+1DaavUL7T4g51A1AZk9QQoBqu+5hBY0
   R7NQF/50BXW/WF2En69xiA/P5vtlDMJRAigNvJcra/IkBuGz6pxaGr870
   B0jlLBigAu+q1KMI8NXnrGxXc5/NB6T1hil+yjhCloFIfYLz+rvlHHc6M
   Q==;
X-CSE-ConnectionGUID: zA7CRa0JR3WGx0j5IEMO0g==
X-CSE-MsgGUID: NNXzXKSSRuKhtsuheGUCUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="38126369"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="38126369"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 11:14:42 -0800
X-CSE-ConnectionGUID: YHlGPK9VQ0mHlUtTTtXhmg==
X-CSE-MsgGUID: f01i83YnQVOVZnfG0fSYdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100014301"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Dec 2024 11:14:39 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLSAO-00070r-2U;
	Wed, 11 Dec 2024 19:14:36 +0000
Date: Thu, 12 Dec 2024 03:14:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] vmalloc: Move memcg logic into memcg code
Message-ID: <202412120251.VSLmEgIe-lkp@intel.com>
References: <20241210193035.2667005-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210193035.2667005-1-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.13-rc2 next-20241211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/vmalloc-Move-memcg-logic-into-memcg-code/20241211-033214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241210193035.2667005-1-willy%40infradead.org
patch subject: [PATCH] vmalloc: Move memcg logic into memcg code
config: arm-randconfig-001-20241211 (https://download.01.org/0day-ci/archive/20241212/202412120251.VSLmEgIe-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120251.VSLmEgIe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120251.VSLmEgIe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: obj_cgroup_uncharge_vmalloc
   >>> referenced by vmalloc.c
   >>>               mm/vmalloc.o:(vfree) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: obj_cgroup_charge_vmalloc
   >>> referenced by vmalloc.c
   >>>               mm/vmalloc.o:(__vmalloc_node_range_noprof) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


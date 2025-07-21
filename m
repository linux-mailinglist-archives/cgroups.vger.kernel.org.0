Return-Path: <cgroups+bounces-8794-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38289B0C74C
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 17:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EA04E432D
	for <lists+cgroups@lfdr.de>; Mon, 21 Jul 2025 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4368E2989B4;
	Mon, 21 Jul 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4i2/fe0"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4952DEA66;
	Mon, 21 Jul 2025 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110829; cv=none; b=IQ4rHZ9KUUitYJaqCRcqcIfqspU5VNLgTAuEFKqerGJFdf+25SPbKrzLzWt1Z43F1XaoMwe7UN/MQRXBHJBeELfBvfrcmEDw4WUBIk7IUj6j7B09PhxiODE14Mmlw7QkBXjn17nB5IwZiticmy4h9GkMV3w6qcRr/nHm9mqsWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110829; c=relaxed/simple;
	bh=7p5feEnSZgKWMQ5RGkpU1rou+ucez0lt3Bdawv+W/rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pobx5oQckPpZggwmakkMLpkdxYfGpJMF6XliZ25AJzUtIstHyRQTHXl5Kv0dRdsm6sIkxQDdd1mCKNcyJfiNYj6/joETIV0P3gmBu8HjPQZ/PVtzjGaKGln+apVsk5Dj2F6Wi/UdfXMhCvsRkchP4aCE1vN5RSY+RYD4tcYDblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4i2/fe0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753110828; x=1784646828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7p5feEnSZgKWMQ5RGkpU1rou+ucez0lt3Bdawv+W/rE=;
  b=B4i2/fe0D9Fn1h5MtBpo9PC4HC6k96DK9b6MI2Wmqy5qfBSne78teDFN
   0NJnxSa+1Ius8zZ+o+K977BYht0n5fXzSeY9cWuBuSzt2pItoRND1KDvr
   K0SaZ0EZzLvb0cGanHuAgAeliNNoHlXqokfS60tDcb3ZTGHR6J4EfIK1Y
   YmIKsqAV2x39QdIs8bKHZB4TYpZuIlk7U6Pg+jWsLIhKLpkKFFWSOj7fR
   8nRTf4EE+IAYPhrtw3DVMw0eLPIK25rwMVszyux3DrP97ZpOXnkWxoGht
   7+7VGnpHuQM4+i/uQ6MTImJDIZVtR1ofo7cSY0w8YOtY4zIoNKnA1xoPT
   A==;
X-CSE-ConnectionGUID: /2A52ywOQVWNNhDozaBrGA==
X-CSE-MsgGUID: Vqve3BIlSvGbQjBci60Pmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="66018731"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="66018731"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 08:13:47 -0700
X-CSE-ConnectionGUID: tWpQV+jnSkqFiGW4o2w4aQ==
X-CSE-MsgGUID: OLI2gGAHSfShQmFVU8YyoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="189856365"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Jul 2025 08:13:41 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udsCw-000Guj-1z;
	Mon, 21 Jul 2025 15:13:38 +0000
Date: Mon, 21 Jul 2025 23:13:24 +0800
From: kernel test robot <lkp@intel.com>
To: Youngjun Park <youngjun.park@lge.com>, akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: oe-kbuild-all@lists.linux.dev, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com,
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chrisl@kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com,
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com,
	Youngjun Park <youngjun.park@lge.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
Message-ID: <202507212243.Lf8fSo0T-lkp@intel.com>
References: <20250716202006.3640584-2-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716202006.3640584-2-youngjun.park@lge.com>

Hi Youngjun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 347e9f5043c89695b01e66b3ed111755afcf1911]

url:    https://github.com/intel-lab-lkp/linux/commits/Youngjun-Park/mm-swap-memcg-Introduce-infrastructure-for-cgroup-based-swap-priority/20250717-042648
base:   347e9f5043c89695b01e66b3ed111755afcf1911
patch link:    https://lore.kernel.org/r/20250716202006.3640584-2-youngjun.park%40lge.com
patch subject: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for cgroup-based swap priority
config: loongarch-randconfig-r123-20250721 (https://download.01.org/0day-ci/archive/20250721/202507212243.Lf8fSo0T-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce: (https://download.01.org/0day-ci/archive/20250721/202507212243.Lf8fSo0T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507212243.Lf8fSo0T-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/swap_cgroup_priority.c:115:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/swap_cgroup_priority.c:115:16: sparse:    struct swap_cgroup_priority [noderef] __rcu *
   mm/swap_cgroup_priority.c:115:16: sparse:    struct swap_cgroup_priority *
   mm/swap_cgroup_priority.c:729:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/swap_cgroup_priority.c:729:9: sparse:    struct swap_cgroup_priority [noderef] __rcu *
   mm/swap_cgroup_priority.c:729:9: sparse:    struct swap_cgroup_priority *
   mm/swap_cgroup_priority.c:638:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/swap_cgroup_priority.c:638:25: sparse:    struct swap_cgroup_priority [noderef] __rcu *
   mm/swap_cgroup_priority.c:638:25: sparse:    struct swap_cgroup_priority *

vim +115 mm/swap_cgroup_priority.c

   108	
   109	static struct swap_cgroup_priority *get_swap_cgroup_priority(
   110		struct mem_cgroup *memcg)
   111	{
   112		if (!memcg)
   113			return NULL;
   114	
 > 115		return rcu_dereference(memcg->swap_priority);
   116	}
   117	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


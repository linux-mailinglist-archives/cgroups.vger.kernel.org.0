Return-Path: <cgroups+bounces-12781-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3789ACE4845
	for <lists+cgroups@lfdr.de>; Sun, 28 Dec 2025 03:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4E503002A65
	for <lists+cgroups@lfdr.de>; Sun, 28 Dec 2025 02:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124A5205E25;
	Sun, 28 Dec 2025 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MA0AW7J+"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197B013D539;
	Sun, 28 Dec 2025 02:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766887372; cv=none; b=dsmB3IYvK1H5zV37NbJYG3oCg8JDVrK23GJJhchN3gqisa7bscFS3uSbp9NstZPmi2d6tRcUATWyEDeyiSURVk+OEoRvl6LhlplMP9BzIVzUqPpU7DfLl+a9KziMX9crrFV3KdmULGdVMtDxEEyrl6KLTyrN4PGl/pIvDtPpDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766887372; c=relaxed/simple;
	bh=z2IaYp58Msew3QS/60tkLCoX0j0xeHozTFQSPz4iw2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ael9reSkr/btyYbahpGZT15iqH8cGvXPlxE78Xiq7iRJJtNVO/Qfid7BNfKmOGi8rmnIP0ZFNgDum3S1nzb00irm6aPiITPQYJU0ybldWH45kRKmkfAORrEOQBlrEGkA+xu5a/uT7XMkN9q08w/Y3cacWoGiz359ZTqWRcSkp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MA0AW7J+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766887371; x=1798423371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z2IaYp58Msew3QS/60tkLCoX0j0xeHozTFQSPz4iw2E=;
  b=MA0AW7J+b6y/BXMEqcxfoNatQk2VGoY4Twl6BYvnDJmfFL1lkmoLAgYr
   QNQW0tpSoxfwIBrsuI4R6BEMyB2iO12WddX36Mw3iGsV3YEJ70hOewsph
   QyvcDkqPbfjGKPi5iZ94Haxc8iKq/zvF0iCf049xC2mWkNHYSSTEDlFGU
   Haa+s5Ro5SrZqHPNmEyTxlwgIcdkb9nxMSSOjq5caFOaFCKzkOxe74lh/
   Fw9Wd80Y11CC6MmBQWDcqBuH0NuTy/SEJtezJQOe0o68HZjjgOGvEkMgu
   NMEMjtes6UuUtBsIyk+OZzJutmmW8c1P0Zjv/WlOxQ40hPZbsy5GPvY0s
   A==;
X-CSE-ConnectionGUID: Qvz/T0tSRFmaGsdvWL0VkQ==
X-CSE-MsgGUID: ZGTyvElcTTSF4Ce28+gnow==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="80008890"
X-IronPort-AV: E=Sophos;i="6.21,182,1763452800"; 
   d="scan'208";a="80008890"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 18:02:50 -0800
X-CSE-ConnectionGUID: fId7WcIxQQ6EbFuYnqCJNg==
X-CSE-MsgGUID: 21J7Q3W4Q/6LKmiB1y74FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,182,1763452800"; 
   d="scan'208";a="200936737"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 27 Dec 2025 18:02:45 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vZg7H-000000006Bx-07Jm;
	Sun, 28 Dec 2025 02:02:43 +0000
Date: Sun, 28 Dec 2025 10:02:18 +0800
From: kernel test robot <lkp@intel.com>
To: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, corbet@lwn.net,
	hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	zhengqi.arch@bytedance.com, mkoutny@suse.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: Re: [PATCH -next v2 7/7] mm/mglru: remove memcg disable handling
 from lru_gen_shrink_node
Message-ID: <202512280931.jlaLW51Y-lkp@intel.com>
References: <20251224073032.161911-8-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224073032.161911-8-chenridong@huaweicloud.com>

Hi Chen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.19-rc2]
[also build test WARNING on linus/master next-20251219]
[cannot apply to akpm-mm/mm-everything rppt-memblock/for-next rppt-memblock/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Ridong/mm-mglru-use-mem_cgroup_iter-for-global-reclaim/20251224-154725
base:   v6.19-rc2
patch link:    https://lore.kernel.org/r/20251224073032.161911-8-chenridong%40huaweicloud.com
patch subject: [PATCH -next v2 7/7] mm/mglru: remove memcg disable handling from lru_gen_shrink_node
config: x86_64-randconfig-001-20251228 (https://download.01.org/0day-ci/archive/20251228/202512280931.jlaLW51Y-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251228/202512280931.jlaLW51Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512280931.jlaLW51Y-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/vmscan.o: warning: objtool: shrink_node_memcgs+0xc16: sibling call from callable instruction with modified stack frame

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


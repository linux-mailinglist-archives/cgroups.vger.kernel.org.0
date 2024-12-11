Return-Path: <cgroups+bounces-5838-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5489ED974
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 23:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E433C167207
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 22:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371E01F03E4;
	Wed, 11 Dec 2024 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B4TRUplw"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FED1C304A;
	Wed, 11 Dec 2024 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955503; cv=none; b=OB5o/k/RTIU4NeDCYExh+01aWBIdXarKKAJZkXwLgoSRvTaoJUSzLAqTfvrCSWUiDUG9d5fLYeBr99/5FANQG/wb3/6nTDIrXk6iEmgXISFUtIQvXg4H17GTQrIxCg3EGViIkbsIQbKS4PBc/3K5MuUHcUsJdcZ9/HxjlhibxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955503; c=relaxed/simple;
	bh=E+QYoRGzPL4X7gdsvb1ITu5CM2i+QHJCh3NZ2O5NqhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjQSCydw6yjdp0XNWBn986S10/9pEJIj6g/EtIMncm2Lw4vyFyQlepUPZE3WncbKCNC3zs/f7SQxIfjci2VNyDUcR5KKjTBhAel/rdaRVOK88a9QiMMqQUNEvP/DYFrLEitWLy/o1JnWdMEDU7WqNfq9ZixttHrWtPAmo6s5qr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B4TRUplw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733955501; x=1765491501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E+QYoRGzPL4X7gdsvb1ITu5CM2i+QHJCh3NZ2O5NqhE=;
  b=B4TRUplwg+wGekaxbkCNAYiCQNM/zZ9YgIvqTb+0pfyBFsAyilVzHegQ
   fyDbv8/BRkO/KC0p1CidlTYsQbEpxTeK1Eo+ndzRCVID7kphmipNagmLw
   k9KBiZlZJIg2RKpKQKFCCMxqwI8WIjaOE+R7b2D9Ot2OOD2FTqM2d6iHJ
   //+FLSMtE9n2o6BeTzGKM6wzFj+lyfUbsJjimQmxjNFe95fm7YZHiBqx1
   Cm+5lWURDjfgSMrBUmXveo4wjZSIodfuUQx2dEYIy4MkSBThNwP3XVLa5
   qofObX2HRGMX5QEdlWADN/zh1Jk8Fm4YcX5R26kaqaG0ltLKfSXGYMUU1
   g==;
X-CSE-ConnectionGUID: xfUA3YPTQEOaiBTdfFzoxw==
X-CSE-MsgGUID: iuC0m2FBQYyEp3AtDdX3bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="59753006"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="59753006"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 14:18:20 -0800
X-CSE-ConnectionGUID: 7RJFx0GoQMmeTEC5KmT2zA==
X-CSE-MsgGUID: oqwtLZIESCqp4curxxtVWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="96186440"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Dec 2024 14:18:17 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLV26-00079R-1f;
	Wed, 11 Dec 2024 22:18:14 +0000
Date: Thu, 12 Dec 2024 06:17:35 +0800
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
Subject: Re: [PATCH 2/2] vmalloc: Account memcg per vmalloc
Message-ID: <202412120605.mggOamQB-lkp@intel.com>
References: <20241211043252.3295947-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211043252.3295947-2-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.13-rc2 next-20241211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/vmalloc-Account-memcg-per-vmalloc/20241211-123433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241211043252.3295947-2-willy%40infradead.org
patch subject: [PATCH 2/2] vmalloc: Account memcg per vmalloc
config: s390-randconfig-001-20241212 (https://download.01.org/0day-ci/archive/20241212/202412120605.mggOamQB-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120605.mggOamQB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120605.mggOamQB-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390x-linux-ld: mm/vmalloc.o: in function `vfree':
>> vmalloc.c:(.text+0xb040): undefined reference to `obj_cgroup_uncharge_vmalloc'
   s390x-linux-ld: mm/vmalloc.o: in function `__vmalloc_node_range_noprof':
>> vmalloc.c:(.text+0xc5ec): undefined reference to `obj_cgroup_charge_vmalloc'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


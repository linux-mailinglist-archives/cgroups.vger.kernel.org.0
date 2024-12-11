Return-Path: <cgroups+bounces-5841-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEBC9EDB1F
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 00:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD98B16853A
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 23:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCC21F2C3C;
	Wed, 11 Dec 2024 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWUHQaLJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF041F2C2C;
	Wed, 11 Dec 2024 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959609; cv=none; b=O2rqpUmUn61HfIhd0Vd4TMJKQY3H5IRt7uUqlbAygBD+YyJzO8TdUKQkDJGCy8fy025DO7uRhIocDiLMM6/Gy+mwfjlbd8LGu2OBtXsFeUVi0cnI33FdGh1zNRFcpGYOR8N2qILh0zD8h4UVdUoQEx2YUUjgn/9fEKz8oKbNKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959609; c=relaxed/simple;
	bh=WaIZVOk/x5E7nAhR7pVqKSX0Mhw+HVXboHst1Elwgjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9NRp24X65XR1dnXHLhLVoBPg8gh5tsXGbuKvmzRS0Koup+C9ivPecFa48iKZmbYN0rkG0xZ+6rHFQZKfhvZyyL27Vny0Ri91GgnMfkOAH1ibiIjoOpaQbTuqhIXYXxNAF5yR4+ZHGH9qYDvAe968t+T54/yhdUf6rvtg6lv3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWUHQaLJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733959607; x=1765495607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WaIZVOk/x5E7nAhR7pVqKSX0Mhw+HVXboHst1Elwgjg=;
  b=nWUHQaLJeQKJxqUjhsefkz3aI+RVmHvbQA1p8GaVjBeR4C91bJQOh/g8
   +gYmYmt2oQsDvvtdGgeVhH7GxxwQjIUAwWV9T+4idtfHWNesMzxDSlg7h
   glavVHECO6rjVp5MIMbWuIWsZf3pmA+fy09n4izIfePSGEgyGUIl3XBNq
   DzmN9RZcu50vqDSqWfX7YKKoqYdgLUhR0XmPMA2xfpUHI/Ik/O1Eu6yfJ
   rqXGA7EnlvZb/VeeKBva+qAK+O1s+y/XyTuIX1hp93+eRfRq6r6Kwm2cc
   6ffKdtg/a2gX+0b0RcgUxS4An/Qius2KykjaQCPxusnvc2B5C/hNeeFE1
   w==;
X-CSE-ConnectionGUID: oXkNqzsoSsaTT7+Pq0XM2g==
X-CSE-MsgGUID: pMojP5PTSYaXt/NhMVSr1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="37198587"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="37198587"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 15:26:47 -0800
X-CSE-ConnectionGUID: f8Io+3V2RSmuj8Q7nJymPg==
X-CSE-MsgGUID: oVUWZbP+Svee9N2p2yLQ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100954359"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 Dec 2024 15:26:29 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLW66-0007Cj-1M;
	Wed, 11 Dec 2024 23:26:26 +0000
Date: Thu, 12 Dec 2024 07:26:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202412120752.71x951px-lkp@intel.com>
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
config: alpha-randconfig-r063-20241211 (https://download.01.org/0day-ci/archive/20241212/202412120752.71x951px-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120752.71x951px-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120752.71x951px-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: mm/vmalloc.o: in function `vfree':
>> (.text+0x66b0): undefined reference to `obj_cgroup_uncharge_vmalloc'
>> alpha-linux-ld: (.text+0x66b4): undefined reference to `obj_cgroup_uncharge_vmalloc'
   alpha-linux-ld: mm/vmalloc.o: in function `__vmalloc_area_node.constprop.0':
>> (.text+0x6fa0): undefined reference to `obj_cgroup_charge_vmalloc'
>> alpha-linux-ld: (.text+0x6fac): undefined reference to `obj_cgroup_charge_vmalloc'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


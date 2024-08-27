Return-Path: <cgroups+bounces-4510-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FFB961392
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 18:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A471F22CED
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE0B1C93B9;
	Tue, 27 Aug 2024 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iyrynehh"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB581C6F79;
	Tue, 27 Aug 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774645; cv=none; b=XKySBrwl/prbNkwibhWtORRHcZ6F50pEQK490zmkZG34dp28REUDmgG2SYvTinId6jt0molW/NipfeAA1wdGExDBhIy2QNuivBA0kOWyhJIgTuP/Iw7wk4CXOwDoR/u2x3YrkbGake6xnJ4vFNurWaVRQvR8jaaH62SAI+H3z80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774645; c=relaxed/simple;
	bh=ao0RX5ro/6ez3vKUPCpFiFkR1VW7QTBa5WWL6WRZhY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7/ZSrL9IqiNxZYJ/6DOC25s2jtHGlG91uNXNKjo4vqWRzE3xil+WOvnPgHLyBXd6wghPLWwos1pCYpjvRhssQDcBmFYC0XaDnOF0iHbZXEb+Rs9vQDCt9En1gIIQITT1Grucd1X2fePXVxzIbNy6a42lEKDH+Nxb2Jbv55GbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iyrynehh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724774644; x=1756310644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ao0RX5ro/6ez3vKUPCpFiFkR1VW7QTBa5WWL6WRZhY8=;
  b=IyrynehhF4iOHzd+aSPbBRfBpQp/oVRfzYQTGP6EaRhnkt/mKBA8ZqpU
   FtqIfxjCntCzaFEU2nOfYUSwAETJzzs/F7hVjvQDLmbc1CF2GxP1adVkH
   Mh9Yn6O8gDcoR0X//mLJuLKdUItw3DIpMJ5R3wFuJpzF6eI3Ls6L25nde
   qKbi+DZ3MADji0e3Gnkluz0Un+Aemrye31/APKyG4UuglIjkaajxfmsPg
   5uehnnmEkex5HjqP4rd5ejno2zmU5Bu4+Mv+F1ALT99T8FSgQkqI46Han
   52aZ+8LWehC3Wfm7iNJLrF6a0qmWC5D5nX8+pJFCJ5lkJcwARdM5quWsw
   w==;
X-CSE-ConnectionGUID: gu6LCfjBRcKvRrdvdhW8+A==
X-CSE-MsgGUID: qRdXlZpFTeSCGI023EIvtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="40736293"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="40736293"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 09:04:03 -0700
X-CSE-ConnectionGUID: tzVhxsI0SNCeFoPEq+h/sw==
X-CSE-MsgGUID: QS6uijy3TGulNDeXCOoRGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="93634623"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Aug 2024 09:03:59 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siyfj-000Jny-1n;
	Tue, 27 Aug 2024 16:03:55 +0000
Date: Wed, 28 Aug 2024 00:03:19 +0800
From: kernel test robot <lkp@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Rientjes <rientjes@google.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1] memcg: add charging of already allocated slab objects
Message-ID: <202408272341.k4cl3jz0-lkp@intel.com>
References: <20240826232908.4076417-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826232908.4076417-1-shakeel.butt@linux.dev>

Hi Shakeel,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.11-rc5 next-20240827]
[cannot apply to vbabka-slab/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shakeel-Butt/memcg-add-charging-of-already-allocated-slab-objects/20240827-073150
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240826232908.4076417-1-shakeel.butt%40linux.dev
patch subject: [PATCH v1] memcg: add charging of already allocated slab objects
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240827/202408272341.k4cl3jz0-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408272341.k4cl3jz0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408272341.k4cl3jz0-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/slub.c:13:
   In file included from include/linux/mm.h:2198:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/slub.c:49:
   In file included from mm/internal.h:13:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>> mm/slub.c:4115:31: error: no member named 'objcg' in 'struct slabobj_ext'
    4115 |                 if (unlikely(slab_exts[off].objcg))
         |                              ~~~~~~~~~~~~~~ ^
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   3 warnings and 1 error generated.


vim +4115 mm/slub.c

  4085	
  4086	#define KMALLOC_TYPE (SLAB_KMALLOC | SLAB_CACHE_DMA | \
  4087			      SLAB_ACCOUNT | SLAB_RECLAIM_ACCOUNT)
  4088	
  4089	bool kmem_cache_charge(void *objp, gfp_t gfpflags)
  4090	{
  4091		struct slabobj_ext *slab_exts;
  4092		struct kmem_cache *s;
  4093		struct folio *folio;
  4094		struct slab *slab;
  4095		unsigned long off;
  4096	
  4097		if (!memcg_kmem_online())
  4098			return true;
  4099	
  4100		folio = virt_to_folio(objp);
  4101		if (unlikely(!folio_test_slab(folio)))
  4102			return false;
  4103	
  4104		slab = folio_slab(folio);
  4105		s = slab->slab_cache;
  4106	
  4107		/* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
  4108		if ((s->flags & KMALLOC_TYPE) == SLAB_KMALLOC)
  4109			return true;
  4110	
  4111		/* Ignore already charged objects. */
  4112		slab_exts = slab_obj_exts(slab);
  4113		if (slab_exts) {
  4114			off = obj_to_index(s, slab, objp);
> 4115			if (unlikely(slab_exts[off].objcg))
  4116				return true;
  4117		}
  4118	
  4119		return memcg_slab_post_charge(s, objp, gfpflags);
  4120	}
  4121	EXPORT_SYMBOL(kmem_cache_charge);
  4122	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


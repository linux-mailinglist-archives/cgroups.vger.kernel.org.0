Return-Path: <cgroups+bounces-4509-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1BE960C68
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 15:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575411C22E8D
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0521C2DD7;
	Tue, 27 Aug 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxxH/jFA"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0A1C1729;
	Tue, 27 Aug 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766092; cv=none; b=CBncZURCfuOCQxnRb0OvdmY7KqnOhczpYyODiSvtlxKcMsLsH4+1Nu27nc9SOwdR82RyS/f9sxUxKHke/fteEiknuG9ierMoe4uHZBFxwiqBwnL1uOl1BXmctskWI0K5ggLt+PKeq44JxeksTq+KQA3grY7bAme9HikpM9UHozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766092; c=relaxed/simple;
	bh=U7jlPpHqXBl4HV4XuzMC0RMz+LSPT7aClOWD+Th3CoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glLYummD94NIvB5tBO1MwHWzryZ2Xl+D9Cb33fKQlf7ZFl3yZGO1UtHICXD7+wr/QyhEKJV/fndhqnE7Erz0vPAKyTsLWIJfxjGH0rabUzsWhHv/9WfM+Vlyx22Z0lcYvnYlwy8ROIUdyuIgJ/mSvDSaWoW+PWPl00LAf1l8KUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxxH/jFA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724766090; x=1756302090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U7jlPpHqXBl4HV4XuzMC0RMz+LSPT7aClOWD+Th3CoE=;
  b=AxxH/jFA8PZ92SNwS9sR2tRh3+AiaHN/RtchTyNECD9eOLkxSmyxGxYF
   72ZFtt30sw2MZ1A59ZiMuLpg0Y4VviNEtnVlPT6iRsbv30f9pISmAVDrz
   NXmeOCIefDVhxZZRvzFUeNkXGD9MtCfGOTOZn7CHw/SNw9ojN3riyCY0H
   KwaVoXP2fVb7yd3eg9j4gqOc1FYso/uawhYJlbQEfY5a9m0qk16RX4vi1
   8HkwjkqN7TWgAcmrY1D9599K1vUi+oENs61739snKtIWdyEb5qkzQ60XR
   MsMJ2JUa8C44sBLf0yr95vyoaTr0/OBojFtEa2rXM2IonWSxTzh+D6sIB
   g==;
X-CSE-ConnectionGUID: +ccZ5rAkTEOHGXQFmjHUSw==
X-CSE-MsgGUID: 0ELZmLKATRWPKuwdM1el7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23419545"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23419545"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:41:25 -0700
X-CSE-ConnectionGUID: W1apEhwKSGmNNLyQayeLSQ==
X-CSE-MsgGUID: Z0N4/UqFQ1C3dS2rbcQ+hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67727828"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 27 Aug 2024 06:41:21 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siwRj-000Ih8-0F;
	Tue, 27 Aug 2024 13:41:19 +0000
Date: Tue, 27 Aug 2024 21:40:19 +0800
From: kernel test robot <lkp@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202408272111.T6bMZmU9-lkp@intel.com>
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
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240827/202408272111.T6bMZmU9-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408272111.T6bMZmU9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408272111.T6bMZmU9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:5,
                    from arch/openrisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from mm/slub.c:13:
   mm/slub.c: In function 'kmem_cache_charge':
>> mm/slub.c:4115:44: error: 'struct slabobj_ext' has no member named 'objcg'
    4115 |                 if (unlikely(slab_exts[off].objcg))
         |                                            ^
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^


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


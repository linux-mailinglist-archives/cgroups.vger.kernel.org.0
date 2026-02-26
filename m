Return-Path: <cgroups+bounces-14450-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IYbMxfMoGmlmgQAu9opvQ
	(envelope-from <cgroups+bounces-14450-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 23:41:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCCE1B07AE
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 23:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0F0F302BBB7
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 22:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4937C3D6693;
	Thu, 26 Feb 2026 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/lx2YUJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688DB3939B3;
	Thu, 26 Feb 2026 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145669; cv=none; b=D35l7Gc8YkASVaWW7BJ2R8OFNwJMkjZy9bd3LyCRr5kywpOC/m25IAO4z/t334IaU9E8/Y1Q01qgzZhw3UfVdwmWp9pysVVjK8OpjhF9XdAe7hhQ4M3cRL44ji4KrOgVDoiUhxdv0IMs43VTOBts4oc9ZywBOTsV7kOZqmkzteg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145669; c=relaxed/simple;
	bh=d/6m10PYexKC1cVhq0Hde/ttL8fwWTtpBRAU/d9YlHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eo99DOd+UyOAb+sJgumYusFhWRNRhjxZuPK6bb8K8LN49zaWQnQwPnviOqBD5DxT9IUO4OQbuPRJ2zzHUoSbIUZ+spBarJsdfRbcS0JOpmnEGV8HUYsqmZ2JsalAAfq5cW2I8adD8lUkiEe4CdbVI7BduMOlrkuGSRw9im1GnnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/lx2YUJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772145666; x=1803681666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d/6m10PYexKC1cVhq0Hde/ttL8fwWTtpBRAU/d9YlHc=;
  b=c/lx2YUJTNbl2OlR/CS+OZSDMcCfgmq6QgdiQ9XXI2TEIGiYzAeeQhQf
   mzX7h4ttGRFq/WWP8ohbftf1DPuiGJ3wWT+PdmJfglzs4D5/yHT7g8yNo
   L8A29UXo1xuYKsfmMJXLfZ8OmNYd5GOoX6oaTKOug3HOy3LI/6RjzaN8g
   gSHxilh8KZymv1/zOpHNthcUyWHwP4FMeVBPUbhfD8tQE069bdi0cySxM
   EpgtFqBGm03Fj6CIaVbGYkNNmo6Io44OcOahb/T534R0KGnkrjs33QnQf
   1RVkug3voVrwEvQINTebaPdnCRRxBVWybCGIMqmivydkoSi36j/f52KGW
   A==;
X-CSE-ConnectionGUID: VKFihECGS1S8pa9cE4VbGA==
X-CSE-MsgGUID: cJ9uKbGFSDmj4vD6lfmVhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84684597"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="84684597"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 14:41:06 -0800
X-CSE-ConnectionGUID: 0Ew5H71QQsm/kaO3gZMK8w==
X-CSE-MsgGUID: NPS72Xj+SEqml45ybSgtXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="216833273"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 26 Feb 2026 14:41:01 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvk2T-000000009x9-42O4;
	Thu, 26 Feb 2026 22:40:57 +0000
Date: Fri, 27 Feb 2026 06:40:18 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 8/8] mm/vmstat, memcontrol: Track ZSWAP_B, ZSWAPPED_B
 per-memcg-lruvec
Message-ID: <202602270607.dJP65LGH-lkp@intel.com>
References: <20260226192936.3190275-9-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226192936.3190275-9-joshua.hahnjy@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14450-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,chromium.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:mid,intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: EBCCE1B07AE
X-Rspamd-Action: no action

Hi Joshua,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on linus/master v7.0-rc1]
[cannot apply to akpm-mm/mm-everything next-20260226]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Hahn/mm-zsmalloc-Rename-zs_object_copy-to-zs_obj_copy/20260227-033239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20260226192936.3190275-9-joshua.hahnjy%40gmail.com
patch subject: [PATCH 8/8] mm/vmstat, memcontrol: Track ZSWAP_B, ZSWAPPED_B per-memcg-lruvec
config: powerpc64-randconfig-r072-20260227 (https://download.01.org/0day-ci/archive/20260227/202602270607.dJP65LGH-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602270607.dJP65LGH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602270607.dJP65LGH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/zsmalloc.c:813:17: error: call to undeclared function 'zpdesc_objcgs'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     813 |         bool objcg = !!zpdesc_objcgs(zspage->first_zpdesc);
         |                        ^
   1 error generated.


vim +/zpdesc_objcgs +813 mm/zsmalloc.c

   808	
   809	static void __free_zspage(struct zs_pool *pool, struct size_class *class,
   810					struct zspage *zspage)
   811	{
   812		struct zpdesc *zpdesc, *next;
 > 813		bool objcg = !!zpdesc_objcgs(zspage->first_zpdesc);
   814	
   815		assert_spin_locked(&class->lock);
   816	
   817		VM_BUG_ON(get_zspage_inuse(zspage));
   818		VM_BUG_ON(zspage->fullness != ZS_INUSE_RATIO_0);
   819	
   820		next = zpdesc = get_first_zpdesc(zspage);
   821		do {
   822			VM_BUG_ON_PAGE(!zpdesc_is_locked(zpdesc), zpdesc_page(zpdesc));
   823			next = get_next_zpdesc(zpdesc);
   824			reset_zpdesc(zpdesc);
   825			zpdesc_unlock(zpdesc);
   826			zpdesc_dec_zone_page_state(zpdesc);
   827			if (objcg)
   828				dec_node_page_state(zpdesc_page(zpdesc), NR_ZSWAP_B);
   829			zpdesc_put(zpdesc);
   830			zpdesc = next;
   831		} while (zpdesc != NULL);
   832	
   833		cache_free_zspage(zspage);
   834	
   835		class_stat_sub(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
   836		atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
   837	}
   838	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


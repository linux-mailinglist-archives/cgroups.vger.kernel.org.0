Return-Path: <cgroups+bounces-4878-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F01C978AE2
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 23:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA101F232AE
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 21:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88B433A9;
	Fri, 13 Sep 2024 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElPd+2ko"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F4154BEC;
	Fri, 13 Sep 2024 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726264475; cv=none; b=JA9zoRUZbQ8bM2Aprldlf6NmhQePE61vbp2bTvIS7CCHWU2sr0CmxmeXsdNieNNiVXyBN8UqaGQPbH8G8GW0CxQKoiKZi/xLbcflfiAfp6eZA0bd+b65M7sS/CTH88PQYIGF6dPSo+upWWwrqCMy7gk8pthvS5pPbuBNKtj6ceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726264475; c=relaxed/simple;
	bh=3lZUdhEvXyxFpVtcD0HH4jrUJUk05bEvQqokX6JrCz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQDyHm6ZcsNWnINGY0hvCipxQ5sjAs79lqJm3JI5NHixvfREHrb5eB8YcH6dCZXEyR/jzVZsCnoysvaMVbZyEI8U6zH1c+OxWUyQyGbxFwzn++swgo6Q2wJ+pGKk5fsevbXtf6ZR43kUYbaCp1lS+ZNZ5n9XFC2ZlC9nplGucNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElPd+2ko; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726264475; x=1757800475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3lZUdhEvXyxFpVtcD0HH4jrUJUk05bEvQqokX6JrCz4=;
  b=ElPd+2koc8YuwJQX8CUsp/A6xT4jSljKoWNpDTzzGmfdwJpFheAY3VXG
   qk7BOT12nZ7mBVG6FwIA/Qj4V+RwCkoSA7JuRJr1x5Aa8IrZFlmRzqaVX
   1awTZ9BMCDhFAMW3la11qhxu+7PWxZAhni9mnsMYLx2C6KGLkMy/uWFn/
   s3gh0mbU/dLoXDOQg3R121CD2JIiRCP9dSeJLSKAYIGr7wJd0u+NIBki8
   GJms7vQJr3BWWB8NRLRMNoj2MWPzcPOLUVVSkvBpDeILqvQWQWmHYtIeR
   bBLi2DLKEfX4OVoV/Iotapo/3EbtNhoZu2EoKwKCFQHLGGTslC+JH5dkW
   w==;
X-CSE-ConnectionGUID: hYiEnINYTpCNfCjdBoGBxg==
X-CSE-MsgGUID: 4xgU9nOoRA+K1pnmkUVJTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28964273"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="28964273"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 14:54:31 -0700
X-CSE-ConnectionGUID: Gt72Uv39TH+t4tZEuHFxyQ==
X-CSE-MsgGUID: L8tABuovQbKL349MY0ASiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="72802513"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 13 Sep 2024 14:54:28 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spEFF-00074Y-1n;
	Fri, 13 Sep 2024 21:54:25 +0000
Date: Sat, 14 Sep 2024 05:54:03 +0800
From: kernel test robot <lkp@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org,
	cgroups@vger.kernel.org, yosryahmed@google.com,
	shakeel.butt@linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Jesper Dangaard Brouer <hawk@kernel.org>,
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
	kernel-team@cloudflare.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
Message-ID: <202409140533.XqO09tth-lkp@intel.com>
References: <172616070094.2055617.17676042522679701515.stgit@firesoul>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172616070094.2055617.17676042522679701515.stgit@firesoul>

Hi Jesper,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-cgroup/for-next]
[also build test ERROR on axboe-block/for-next linus/master v6.11-rc7]
[cannot apply to akpm-mm/mm-everything next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesper-Dangaard-Brouer/cgroup-rstat-Avoid-flushing-if-there-is-an-ongoing-root-flush/20240913-010800
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
patch link:    https://lore.kernel.org/r/172616070094.2055617.17676042522679701515.stgit%40firesoul
patch subject: [PATCH V11] cgroup/rstat: Avoid flushing if there is an ongoing root flush
config: i386-randconfig-141-20240914 (https://download.01.org/0day-ci/archive/20240914/202409140533.XqO09tth-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409140533.XqO09tth-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409140533.XqO09tth-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/zswap.c: In function 'zswap_shrinker_count':
>> mm/zswap.c:1225:17: error: implicit declaration of function 'mem_cgroup_flush_stats_relaxed'; did you mean 'mem_cgroup_flush_stats_ratelimited'? [-Werror=implicit-function-declaration]
    1225 |                 mem_cgroup_flush_stats_relaxed(memcg);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 mem_cgroup_flush_stats_ratelimited
   cc1: some warnings being treated as errors


vim +1225 mm/zswap.c

  1197	
  1198	static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
  1199			struct shrink_control *sc)
  1200	{
  1201		struct mem_cgroup *memcg = sc->memcg;
  1202		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(sc->nid));
  1203		unsigned long nr_backing, nr_stored, nr_freeable, nr_protected;
  1204	
  1205		if (!zswap_shrinker_enabled || !mem_cgroup_zswap_writeback_enabled(memcg))
  1206			return 0;
  1207	
  1208		/*
  1209		 * The shrinker resumes swap writeback, which will enter block
  1210		 * and may enter fs. XXX: Harmonize with vmscan.c __GFP_FS
  1211		 * rules (may_enter_fs()), which apply on a per-folio basis.
  1212		 */
  1213		if (!gfp_has_io_fs(sc->gfp_mask))
  1214			return 0;
  1215	
  1216		/*
  1217		 * For memcg, use the cgroup-wide ZSWAP stats since we don't
  1218		 * have them per-node and thus per-lruvec. Careful if memcg is
  1219		 * runtime-disabled: we can get sc->memcg == NULL, which is ok
  1220		 * for the lruvec, but not for memcg_page_state().
  1221		 *
  1222		 * Without memcg, use the zswap pool-wide metrics.
  1223		 */
  1224		if (!mem_cgroup_disabled()) {
> 1225			mem_cgroup_flush_stats_relaxed(memcg);
  1226			nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
  1227			nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
  1228		} else {
  1229			nr_backing = zswap_total_pages();
  1230			nr_stored = atomic_read(&zswap_stored_pages);
  1231		}
  1232	
  1233		if (!nr_stored)
  1234			return 0;
  1235	
  1236		nr_protected =
  1237			atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
  1238		nr_freeable = list_lru_shrink_count(&zswap_list_lru, sc);
  1239		/*
  1240		 * Subtract the lru size by an estimate of the number of pages
  1241		 * that should be protected.
  1242		 */
  1243		nr_freeable = nr_freeable > nr_protected ? nr_freeable - nr_protected : 0;
  1244	
  1245		/*
  1246		 * Scale the number of freeable pages by the memory saving factor.
  1247		 * This ensures that the better zswap compresses memory, the fewer
  1248		 * pages we will evict to swap (as it will otherwise incur IO for
  1249		 * relatively small memory saving).
  1250		 *
  1251		 * The memory saving factor calculated here takes same-filled pages into
  1252		 * account, but those are not freeable since they almost occupy no
  1253		 * space. Hence, we may scale nr_freeable down a little bit more than we
  1254		 * should if we have a lot of same-filled pages.
  1255		 */
  1256		return mult_frac(nr_freeable, nr_backing, nr_stored);
  1257	}
  1258	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


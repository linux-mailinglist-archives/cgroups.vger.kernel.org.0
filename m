Return-Path: <cgroups+bounces-277-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E13D7E6931
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 12:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1DA7B20D75
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71537199A6;
	Thu,  9 Nov 2023 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DElB3MFN"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4ED19456;
	Thu,  9 Nov 2023 11:08:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD63A271F;
	Thu,  9 Nov 2023 03:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699528135; x=1731064135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R01ca81ioNmZ4Qa0/4lDzRiUdDaqgXI8cjnkTR00Rw4=;
  b=DElB3MFN2FJ0w5VEC68PbqjQQkjJ8UtpA++35HiuDXiRQ2bP9e8gpvhI
   3LvI7O8kTLedlkJgr2638v7M3hEilsP4YHTP8X1uu4iQWpAzvr2JK9qiz
   jN5el7c06TiBP9y3wXKr8WAfge4uEg5TwZ742w9oywXGj/ZBAc7J4mquA
   0mbaoObKRZuGXgBQ2BWa8qGOB0sIQZSmPKgqDC566p/DjOmuYe5GwuGfs
   zdW5j6phSvFYRaT6kGU9XbCoOyyewVL2dZcTnIxl26m7Eqpa9ltBQsvOZ
   a0xEP7xHoTPAdG/ol8Ce8Hq7fYdyLm3rFC1Q2NESVGk4QJOb41+tnfyX7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="387129127"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="387129127"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 03:08:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="4509037"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Nov 2023 03:08:50 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r12ty-0008g8-00;
	Thu, 09 Nov 2023 11:08:46 +0000
Date: Thu, 9 Nov 2023 19:08:12 +0800
From: kernel test robot <lkp@intel.com>
To: Huan Yang <link@vivo.com>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Liu Shixin <liushixin2@huawei.com>, Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	opensource.kernel@vivo.com, Huan Yang <link@vivo.com>
Subject: Re: [PATCH 2/4] mm: multi-gen LRU: MGLRU unbalance reclaim
Message-ID: <202311091842.AqdVBQwL-lkp@intel.com>
References: <20231108065818.19932-3-link@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108065818.19932-3-link@vivo.com>

Hi Huan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on tj-cgroup/for-next linus/master v6.6 next-20231109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huan-Yang/mm-vmscan-LRU-unbalance-cgroup-reclaim/20231108-151757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231108065818.19932-3-link%40vivo.com
patch subject: [PATCH 2/4] mm: multi-gen LRU: MGLRU unbalance reclaim
config: x86_64-randconfig-013-20231108 (https://download.01.org/0day-ci/archive/20231109/202311091842.AqdVBQwL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311091842.AqdVBQwL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311091842.AqdVBQwL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/vmscan.c: In function 'isolate_folios':
>> mm/vmscan.c:4518:15: warning: 'unbalance' is used uninitialized in this function [-Wuninitialized]
    4518 |   if (scanned || unbalance)
         |       ~~~~~~~~^~~~~~~~~~~~


vim +/unbalance +4518 mm/vmscan.c

  4480	
  4481	static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness,
  4482				  int *type_scanned, struct list_head *list)
  4483	{
  4484		int i;
  4485		int type;
  4486		int scanned;
  4487		int tier = -1;
  4488		bool unbalance;
  4489		DEFINE_MIN_SEQ(lruvec);
  4490	
  4491		/*
  4492		 * Try to make the obvious choice first. When anon and file are both
  4493		 * available from the same generation, interpret swappiness 1 as file
  4494		 * first and 200 as anon first.
  4495		 */
  4496		if (unlikely(unbalance_file_reclaim(sc, swappiness))) {
  4497			unbalance = true;
  4498			type = LRU_GEN_FILE;
  4499		} else if (unlikely(unbalance_anon_reclaim(sc, swappiness))) {
  4500			unbalance = true;
  4501			type = LRU_GEN_ANON;
  4502		} else if (!swappiness)
  4503			type = LRU_GEN_FILE;
  4504		else if (min_seq[LRU_GEN_ANON] < min_seq[LRU_GEN_FILE])
  4505			type = LRU_GEN_ANON;
  4506		else if (swappiness == 1)
  4507			type = LRU_GEN_FILE;
  4508		else if (swappiness == 200)
  4509			type = LRU_GEN_ANON;
  4510		else
  4511			type = get_type_to_scan(lruvec, swappiness, &tier);
  4512	
  4513		for (i = !swappiness; i < ANON_AND_FILE; i++) {
  4514			if (tier < 0)
  4515				tier = get_tier_idx(lruvec, type);
  4516	
  4517			scanned = scan_folios(lruvec, sc, type, tier, list);
> 4518			if (scanned || unbalance)
  4519				break;
  4520	
  4521			type = !type;
  4522			tier = -1;
  4523		}
  4524	
  4525		*type_scanned = type;
  4526	
  4527		return scanned;
  4528	}
  4529	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6FE77CF8B
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 17:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjHOPtF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Aug 2023 11:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238292AbjHOPsm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Aug 2023 11:48:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58C210C;
        Tue, 15 Aug 2023 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692114521; x=1723650521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vYKwY7fJgB/Wm+pd7ZCVNTiQ6KYMZdtBO/eDX6RYb2U=;
  b=QJrrj3FYYKbrCJ8QF1XpccPrQB8Oktb10v8hHapkHp1uP2rNY9yMy013
   6v97QGrnnMTAHDYJ5QmuTIc0vby2+RPKyTLBjFGFRfss/HXkC53lx8Tfr
   lgpmAgYchxmS0719ULNM8lZj9y1YbwCCO1UoZtT/XfIktle3aRupsmFeW
   emdTTHrqJBwl0apcfG3xbkCBfCIottRWG2DT36dMZLoeFBvaWwn4e7dKx
   e7OZ8zu5o7bNn/n473ywuKpeQo6VBDvWKwIWtcKmxdgJDaChyu63tH6Rm
   yOpwOpm4ktJ5OSdesmlQAS8jgD5W8WVaE8bls2hUtE2eeTFd/XGVNd5zZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="351898548"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="351898548"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:48:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="727408116"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="727408116"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Aug 2023 08:48:38 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVwHa-00013d-2I;
        Tue, 15 Aug 2023 15:48:35 +0000
Date:   Tue, 15 Aug 2023 23:48:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
        mkoutny@suse.com
Cc:     oe-kbuild-all@lists.linux.dev, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 3/4] blk-throttle: use calculate_io/bytes_allowed()
 for throtl_trim_slice()
Message-ID: <202308152351.JdDlpV4Q-lkp@intel.com>
References: <20230815014123.368929-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815014123.368929-4-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230809]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/blk-throttle-print-signed-value-carryover_bytes-ios-for-user/20230815-095025
base:   next-20230809
patch link:    https://lore.kernel.org/r/20230815014123.368929-4-yukuai1%40huaweicloud.com
patch subject: [PATCH -next 3/4] blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230815/202308152351.JdDlpV4Q-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308152351.JdDlpV4Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308152351.JdDlpV4Q-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from block/blk-throttle.c:12:
   block/blk-throttle.c: In function 'throtl_trim_slice':
>> block/blk-throttle.c:780:44: error: 'nr_slices' undeclared (first use in this function)
     780 |                    rw == READ ? 'R' : 'W', nr_slices, bytes_trim, io_trim,
         |                                            ^~~~~~~~~
   include/linux/blktrace_api.h:56:66: note: in definition of macro 'blk_add_cgroup_trace_msg'
      56 |                         __blk_trace_note_message(bt, css, fmt, ##__VA_ARGS__);\
         |                                                                  ^~~~~~~~~~~
   block/blk-throttle.c:778:9: note: in expansion of macro 'throtl_log'
     778 |         throtl_log(&tg->service_queue,
         |         ^~~~~~~~~~
   block/blk-throttle.c:780:44: note: each undeclared identifier is reported only once for each function it appears in
     780 |                    rw == READ ? 'R' : 'W', nr_slices, bytes_trim, io_trim,
         |                                            ^~~~~~~~~
   include/linux/blktrace_api.h:56:66: note: in definition of macro 'blk_add_cgroup_trace_msg'
      56 |                         __blk_trace_note_message(bt, css, fmt, ##__VA_ARGS__);\
         |                                                                  ^~~~~~~~~~~
   block/blk-throttle.c:778:9: note: in expansion of macro 'throtl_log'
     778 |         throtl_log(&tg->service_queue,
         |         ^~~~~~~~~~


vim +/nr_slices +780 block/blk-throttle.c

1a46ae7773b475 Yu Kuai     2023-08-15  728  
e43473b7f223ec Vivek Goyal 2010-09-15  729  /* Trim the used slices and adjust slice start accordingly */
0f3457f60edc57 Tejun Heo   2013-05-14  730  static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
e43473b7f223ec Vivek Goyal 2010-09-15  731  {
1a46ae7773b475 Yu Kuai     2023-08-15  732  	unsigned long time_elapsed, io_trim;
1a46ae7773b475 Yu Kuai     2023-08-15  733  	u64 bytes_trim;
e43473b7f223ec Vivek Goyal 2010-09-15  734  
e43473b7f223ec Vivek Goyal 2010-09-15  735  	BUG_ON(time_before(tg->slice_end[rw], tg->slice_start[rw]));
e43473b7f223ec Vivek Goyal 2010-09-15  736  
e43473b7f223ec Vivek Goyal 2010-09-15  737  	/*
e43473b7f223ec Vivek Goyal 2010-09-15  738  	 * If bps are unlimited (-1), then time slice don't get
e43473b7f223ec Vivek Goyal 2010-09-15  739  	 * renewed. Don't try to trim the slice if slice is used. A new
e43473b7f223ec Vivek Goyal 2010-09-15  740  	 * slice will start when appropriate.
e43473b7f223ec Vivek Goyal 2010-09-15  741  	 */
0f3457f60edc57 Tejun Heo   2013-05-14  742  	if (throtl_slice_used(tg, rw))
e43473b7f223ec Vivek Goyal 2010-09-15  743  		return;
e43473b7f223ec Vivek Goyal 2010-09-15  744  
d1ae8ffdfaa16b Vivek Goyal 2010-12-01  745  	/*
d1ae8ffdfaa16b Vivek Goyal 2010-12-01  746  	 * A bio has been dispatched. Also adjust slice_end. It might happen
d1ae8ffdfaa16b Vivek Goyal 2010-12-01  747  	 * that initially cgroup limit was very low resulting in high
b53b072c4bb579 Baolin Wang 2020-09-07  748  	 * slice_end, but later limit was bumped up and bio was dispatched
d1ae8ffdfaa16b Vivek Goyal 2010-12-01  749  	 * sooner, then we need to reduce slice_end. A high bogus slice_end
d1ae8ffdfaa16b Vivek Goyal 2010-12-01  750  	 * is bad because it does not allow new slice to start.
d1ae8ffdfaa16b Vivek Goyal 2010-12-01  751  	 */
d1ae8ffdfaa16b Vivek Goyal 2010-12-01  752  
297e3d85478482 Shaohua Li  2017-03-27  753  	throtl_set_slice_end(tg, rw, jiffies + tg->td->throtl_slice);
d1ae8ffdfaa16b Vivek Goyal 2010-12-01  754  
1a46ae7773b475 Yu Kuai     2023-08-15  755  	time_elapsed = rounddown(jiffies - tg->slice_start[rw],
1a46ae7773b475 Yu Kuai     2023-08-15  756  				 tg->td->throtl_slice);
1a46ae7773b475 Yu Kuai     2023-08-15  757  	if (!time_elapsed)
e43473b7f223ec Vivek Goyal 2010-09-15  758  		return;
e43473b7f223ec Vivek Goyal 2010-09-15  759  
1a46ae7773b475 Yu Kuai     2023-08-15  760  	bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
1a46ae7773b475 Yu Kuai     2023-08-15  761  					     time_elapsed);
1a46ae7773b475 Yu Kuai     2023-08-15  762  	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed);
8e89d13f4ede24 Vivek Goyal 2010-09-15  763  	if (!bytes_trim && !io_trim)
e43473b7f223ec Vivek Goyal 2010-09-15  764  		return;
e43473b7f223ec Vivek Goyal 2010-09-15  765  
e43473b7f223ec Vivek Goyal 2010-09-15  766  	if (tg->bytes_disp[rw] >= bytes_trim)
e43473b7f223ec Vivek Goyal 2010-09-15  767  		tg->bytes_disp[rw] -= bytes_trim;
e43473b7f223ec Vivek Goyal 2010-09-15  768  	else
e43473b7f223ec Vivek Goyal 2010-09-15  769  		tg->bytes_disp[rw] = 0;
e43473b7f223ec Vivek Goyal 2010-09-15  770  
8e89d13f4ede24 Vivek Goyal 2010-09-15  771  	if (tg->io_disp[rw] >= io_trim)
8e89d13f4ede24 Vivek Goyal 2010-09-15  772  		tg->io_disp[rw] -= io_trim;
8e89d13f4ede24 Vivek Goyal 2010-09-15  773  	else
8e89d13f4ede24 Vivek Goyal 2010-09-15  774  		tg->io_disp[rw] = 0;
8e89d13f4ede24 Vivek Goyal 2010-09-15  775  
1a46ae7773b475 Yu Kuai     2023-08-15  776  	tg->slice_start[rw] += time_elapsed;
e43473b7f223ec Vivek Goyal 2010-09-15  777  
fda6f272c77a7a Tejun Heo   2013-05-14  778  	throtl_log(&tg->service_queue,
fda6f272c77a7a Tejun Heo   2013-05-14  779  		   "[%c] trim slice nr=%lu bytes=%llu io=%lu start=%lu end=%lu jiffies=%lu",
8e89d13f4ede24 Vivek Goyal 2010-09-15 @780  		   rw == READ ? 'R' : 'W', nr_slices, bytes_trim, io_trim,
e43473b7f223ec Vivek Goyal 2010-09-15  781  		   tg->slice_start[rw], tg->slice_end[rw], jiffies);
e43473b7f223ec Vivek Goyal 2010-09-15  782  }
e43473b7f223ec Vivek Goyal 2010-09-15  783  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

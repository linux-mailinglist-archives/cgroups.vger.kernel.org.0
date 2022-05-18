Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8846052BF42
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbiERPxo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbiERPxo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 11:53:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2021C9676;
        Wed, 18 May 2022 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652889223; x=1684425223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LUhPeqjotO22QnvrKw6uAmvTIAIIFtxOBffN4kFBcJk=;
  b=PSqmKRK63MeJcbJWIT0401dHmGFwTnRMMR825mAW8S/lqQm6mNAINJ0I
   r9ckH318i7jG6E9BEl6s7td3mYtTK+K29x+eGcDDYd8ygm+3YgEaJvsX7
   fgnQup0X+TrbqWlQ7HpxIpkgYdD8idEwpN6fiKfS+4+i7MGjPBhibEjLd
   1FKhpIWRjoh/46yamk3Wre38OTdwLRZli++Kc22MrkB4v9ZW/TkSvLUDc
   1tS4SrBA4cQzKBgHz37ByrhbbiNj5urbnFzOyHI3OdXnVjOO7mJ6Cb9OA
   Dt3cNoTOanLBQ07i9ElMxyovsvdFtyC+VQvtO0/X9X+rN9rzJkEN0l9ez
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="271434264"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="271434264"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 08:53:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="556384353"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2022 08:53:39 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrLzW-0002MX-Ha;
        Wed, 18 May 2022 15:53:38 +0000
Date:   Wed, 18 May 2022 23:52:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Kuai <yukuai3@huawei.com>, tj@kernel.org, axboe@kernel.dk,
        ming.lei@redhat.com
Cc:     kbuild-all@lists.01.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 2/2] blk-throttle: fix io hung due to
 configuration updates
Message-ID: <202205182347.tMOOqyfL-lkp@intel.com>
References: <20220518072751.1188163-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518072751.1188163-3-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Yu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220517]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/bugfix-for-blk-throttle/20220518-151713
base:    47c1c54d1bcd0a69a56b49473bc20f17b70e5242
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220518/202205182347.tMOOqyfL-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f8345dbaf4ed491742aab29834aff66b4930c087
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yu-Kuai/bugfix-for-blk-throttle/20220518-151713
        git checkout f8345dbaf4ed491742aab29834aff66b4930c087
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: block/blk-throttle.o: in function `tg_conf_updated':
>> blk-throttle.c:(.text+0x25bc): undefined reference to `__udivdi3'
>> m68k-linux-ld: blk-throttle.c:(.text+0x2626): undefined reference to `__udivdi3'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

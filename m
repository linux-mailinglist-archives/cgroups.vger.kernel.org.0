Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506AF52C9F7
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 05:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiESDB0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 23:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiESDBZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 23:01:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8825F25286;
        Wed, 18 May 2022 20:01:22 -0700 (PDT)
Received: from kwepemi100015.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3ZNr3Q4TzhZDS;
        Thu, 19 May 2022 11:00:44 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100015.china.huawei.com (7.221.188.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 11:01:20 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 11:01:20 +0800
Subject: Re: [PATCH -next v2 2/2] blk-throttle: fix io hung due to
 configuration updates
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     kernel test robot <lkp@intel.com>, <tj@kernel.org>,
        <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <kbuild-all@lists.01.org>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220518072751.1188163-3-yukuai3@huawei.com>
 <202205182347.tMOOqyfL-lkp@intel.com>
 <84fe296e-6e56-3ca9-73a8-357beb675c6e@huawei.com>
Message-ID: <3d6878f4-1902-633d-0af2-276831364a4f@huawei.com>
Date:   Thu, 19 May 2022 11:01:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <84fe296e-6e56-3ca9-73a8-357beb675c6e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/05/19 10:11, yukuai (C) 写道:
> 
> 
> 在 2022/05/18 23:52, kernel test robot 写道:
>> Hi Yu,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on next-20220517]
>>
>> url:    
>> https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/bugfix-for-blk-throttle/20220518-151713 
>>
>> base:    47c1c54d1bcd0a69a56b49473bc20f17b70e5242
>> config: m68k-allyesconfig 
>> (https://download.01.org/0day-ci/archive/20220518/202205182347.tMOOqyfL-lkp@intel.com/config) 
>>
>> compiler: m68k-linux-gcc (GCC) 11.3.0
>> reproduce (this is a W=1 build):
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # 
>> https://github.com/intel-lab-lkp/linux/commit/f8345dbaf4ed491742aab29834aff66b4930c087 
>>
>>          git remote add linux-review 
>> https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review 
>> Yu-Kuai/bugfix-for-blk-throttle/20220518-151713
>>          git checkout f8345dbaf4ed491742aab29834aff66b4930c087
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 
>> make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     m68k-linux-ld: block/blk-throttle.o: in function `tg_conf_updated':
>>>> blk-throttle.c:(.text+0x25bc): undefined reference to `__udivdi3'
>>>> m68k-linux-ld: blk-throttle.c:(.text+0x2626): undefined reference to 
>>>> `__udivdi3'
> Hi,
> 
> I'm confused here, the only place that I can relate to this:
> 
>      return dispatched * new_limit / old_limit;
> 
I understand it now. I'm doing (u64 / u64), I should use div64_u64
> However, I don't understand yet why this is problematic...
>>     `.exit.text' referenced in section `.data' of 
>> sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section 
>> `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o
>>

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788C87349BB
	for <lists+cgroups@lfdr.de>; Mon, 19 Jun 2023 03:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjFSBi4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Jun 2023 21:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFSBiz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Jun 2023 21:38:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC3B1B6;
        Sun, 18 Jun 2023 18:38:50 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QksqR4xdpzqTQJ;
        Mon, 19 Jun 2023 09:38:43 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 19 Jun 2023 09:38:47 +0800
Subject: Re: [PATCH] memcg: remove unneeded header files
To:     kernel test robot <lkp@intel.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <muchun.song@linux.dev>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>, <akpm@linux-foundation.org>
References: <20230617072658.1826560-1-linmiaohe@huawei.com>
 <202306171649.O90yt13M-lkp@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1b7ef52f-bf7b-692f-d906-288c8a64f37c@huawei.com>
Date:   Mon, 19 Jun 2023 09:38:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <202306171649.O90yt13M-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/6/17 17:12, kernel test robot wrote:
> Hi Miaohe,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on linus/master v6.4-rc6 next-20230616]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Miaohe-Lin/memcg-remove-unneeded-header-files/20230617-152922
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230617072658.1826560-1-linmiaohe%40huawei.com
> patch subject: [PATCH] memcg: remove unneeded header files
> config: nios2-randconfig-r004-20230617 (https://download.01.org/0day-ci/archive/20230617/202306171649.O90yt13M-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230617/202306171649.O90yt13M-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306171649.O90yt13M-lkp@intel.com/

Many thanks for report. Will fix it.


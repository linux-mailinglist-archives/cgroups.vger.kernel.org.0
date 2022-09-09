Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF55B317F
	for <lists+cgroups@lfdr.de>; Fri,  9 Sep 2022 10:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiIIIPN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Sep 2022 04:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiIIIPJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Sep 2022 04:15:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4EF6BCCE;
        Fri,  9 Sep 2022 01:15:07 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MP7z83tTQzHngR;
        Fri,  9 Sep 2022 16:13:08 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 16:15:05 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 16:15:04 +0800
Subject: Re: [PATCH] mm/memcontrol: use kstrtobool for swapaccount param
 parsing
To:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220908083452.2844125-1-liushixin2@huawei.com>
 <20220908150248.85fff32bf275844f0927a856@linux-foundation.org>
 <YxrtODqHhdEkW2Lx@dhcp22.suse.cz>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <ee96ad93-e40b-6614-6cf7-b64bbc78ebc2@huawei.com>
Date:   Fri, 9 Sep 2022 16:15:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YxrtODqHhdEkW2Lx@dhcp22.suse.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2022/9/9 15:37, Michal Hocko wrote:
> On Thu 08-09-22 15:02:48, Andrew Morton wrote:
>> On Thu, 8 Sep 2022 16:34:52 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>>
>>> --- a/mm/swap_cgroup.c
>>> +++ b/mm/swap_cgroup.c
>>> @@ -194,7 +194,7 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
>>>  	return 0;
>>>  nomem:
>>>  	pr_info("couldn't allocate enough memory for swap_cgroup\n");
>>> -	pr_info("swap_cgroup can be disabled by swapaccount=0 boot option\n");
>>> +	pr_info("swap_cgroup can be disabled by swapaccount=[oO][Ff]/N/n/0 boot option\n");
>> I'm not sure this really needed changing.  "=0" was OK and the message
>> now looks rather silly.
> Agreed. While swapaccount=0 is clear the extended form, even if correct,
> might just confuse some admins.
Thanks, the previous info is more appropriate, I will update the patch.


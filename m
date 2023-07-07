Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C1C74A8BF
	for <lists+cgroups@lfdr.de>; Fri,  7 Jul 2023 04:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjGGCGy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jul 2023 22:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGGCGy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jul 2023 22:06:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD1510EA;
        Thu,  6 Jul 2023 19:06:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QxxWq4x28zMqMj;
        Fri,  7 Jul 2023 10:03:35 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 10:06:49 +0800
Subject: Re: [PATCH] mm/memcg: remove definition of MEM_CGROUP_ID_MAX when
 !CONFIG_MEMCG
To:     Muchun Song <muchun.song@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20230706112820.2393447-1-linmiaohe@huawei.com>
 <892B507C-CFE8-4792-BA5F-3C698290A8EE@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <61ce2910-f3de-cfb7-bdd3-546ade0cb6f3@huawei.com>
Date:   Fri, 7 Jul 2023 10:06:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <892B507C-CFE8-4792-BA5F-3C698290A8EE@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/7/7 9:47, Muchun Song wrote:
> 
> 
>> On Jul 6, 2023, at 19:28, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> MEM_CGROUP_ID_MAX is only used when CONFIG_MEMCG is configured. Remove
>> unneeded !CONFIG_MEMCG variant.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> MEM_CGROUP_ID_MAX is also only used in mem_cgroup_alloc(), maybe you also
> could move it from memcontrol.h to memcontrol.c. And define it as:
> 
> #define MEM_CGROUP_ID_MAX ((1U << MEM_CGROUP_ID_SHIFT) - 1)
> 
> I am not suggesting defining it as USHRT_MAX, because if someone changes
> MEM_CGROUP_ID_SHIFT in the future, then MEM_CGROUP_ID_MAX will not updated
> accordingly.

Looks sensible to me. Do you suggest squashing above changes into the current patch
or a separate patch is preferred?

> 
> For this patch, LGTM.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks for review and suggestion.



Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AC05FAA01
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 03:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJKBY6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 21:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJKBY2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 21:24:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593A2855B8;
        Mon, 10 Oct 2022 18:23:49 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MmdGp3Zg9z1M8h6;
        Tue, 11 Oct 2022 09:19:14 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 09:23:46 +0800
Subject: Re: [PATCH 3/4] blk-cgroup: Add NULL check of pd_alloc_fn in
 blkcg_activate_policy
To:     Tejun Heo <tj@kernel.org>
CC:     <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221010023859.11896-1-shikemeng@huawei.com>
 <20221010023859.11896-4-shikemeng@huawei.com>
 <Y0SAneaJadYJwAkr@slm.duckdns.org>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <c62a8944-093f-8534-106c-51b159696008@huawei.com>
Date:   Tue, 11 Oct 2022 09:23:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y0SAneaJadYJwAkr@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



on 10/11/2022 4:29 AM, Tejun Heo wrote:
> On Mon, Oct 10, 2022 at 10:38:58AM +0800, Kemeng Shi wrote:
>> Function blkcg_policy_register only make sure pd_alloc_fn and pd_free_fn in
>> pairs, so pd_alloc_fn could be NULL in registered blkcg_policy. Check NULL
>> before use for pd_alloc_fn in blkcg_activate_policy to avoid protential
>> NULL dereference.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
>> ---
>>  block/blk-cgroup.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 463c568d3e86..fc083c35dc42 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1404,6 +1404,9 @@ int blkcg_activate_policy(struct request_queue *q,
>>  	if (blkcg_policy_enabled(q, pol))
>>  		return 0;
>>  
>> +	if (pol->pd_alloc_fn == NULL)
>> +		return -EINVAL;
> 
> This isn't the only place this function is called, so the above won't
> achieve much. Given that this is rather trivially noticeable and all the
> current users do implement pd_alloc_fn, I'm not sure we need to update this
> now.
Thanks for review. The rest call of this function will always protect by
blkcg_policy_enabled while policy only can be enabled if new added NULL
check is passed. So the new added NULL check enough.

By the way, the policy enable/disable work is direct call to
__set_bit(pol->plid, q->blkcg_pols) in blkcg_policy_enabled
and __clear_bit(pol->plid, q->blkcg_pols) in blkcg_deactivate_policy
which is not intuitive. Is it a good idea to add function
blkcg_policy_enable and blkcg_policy_disable to improve readability?

> 
> Thanks.
> 

-- 
Best wishes
Kemeng Shi

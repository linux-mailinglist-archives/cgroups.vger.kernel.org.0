Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73728429B17
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 03:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhJLBl2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Oct 2021 21:41:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14329 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhJLBl2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Oct 2021 21:41:28 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HSyrW6m9wz907W;
        Tue, 12 Oct 2021 09:34:35 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 09:39:22 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 12 Oct 2021 09:39:21 +0800
Subject: Re: [PATCH] blk-cgroup: check blkcg policy is enabled in
 blkg_create()
To:     Tejun Heo <tj@kernel.org>
CC:     <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20211008072720.797814-1-yukuai3@huawei.com>
 <YWRxi2OaIHhG9rOc@slm.duckdns.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <9d9ac88b-43e6-5b50-bc0b-98ad4704eca5@huawei.com>
Date:   Tue, 12 Oct 2021 09:39:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YWRxi2OaIHhG9rOc@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/10/12 1:16, Tejun Heo wrote:
> On Fri, Oct 08, 2021 at 03:27:20PM +0800, Yu Kuai wrote:
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index eb48090eefce..00e1d97621ea 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -226,6 +226,20 @@ struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
>>   }
>>   EXPORT_SYMBOL_GPL(blkg_lookup_slowpath);
>>   
>> +static void blkg_check_pd(struct request_queue *q, struct blkcg_gq *blkg)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < BLKCG_MAX_POLS; i++) {
>> +		struct blkcg_policy *pol = blkcg_policy[i];
>> +
>> +		if (blkg->pd[i] && !blkcg_policy_enabled(q, pol)) {
>> +			pol->pd_free_fn(blkg->pd[i]);
>> +			blkg->pd[i] = NULL;
>> +		}
>> +	}
>> +}
>> +
>>   /*
>>    * If @new_blkg is %NULL, this function tries to allocate a new one as
>>    * necessary using %GFP_NOWAIT.  @new_blkg is always consumed on return.
>> @@ -252,6 +266,9 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>>   		goto err_free_blkg;
>>   	}
>>   
>> +	if (new_blkg)
>> +		blkg_check_pd(q, new_blkg);
>> +
> 
> Can't this happen the other way around too? ie. Linking a pd which doesn't
> have an entry for a policy which got enabled inbetween? And what if an
> existing policy was de-registered and another policy got the policy id
> inbetween? I think the correct solution here would be synchronizing alloc -
> create blocks against policy deactivation rather than trying to patch an
> allocated blkg later. Deactivation being a really slow path, there are
> plenty of options. The main challenge would making it difficult to make
> mistakes with, I guess.

For the case policy was de-registered, I think there won't be a problem
because pd_init_fn() is not called yet, and the blkg is not at
blkg_list, it's fine to use this blkg for the new policy.

For the case policy got enabled inbetween, the problem is that the pd
still doesn't have an entry for the policy, perhaps we can call
pd_alloc_fn() additionally in blkg_create?

If checking the blkg in blkg_create() is not a good solution, and we
decide to synchronize alloc-create blkg against policy deactivation.
Since only bfq policy can be deactivated or activated while queue is
not dying, and queue is freezed during activation and deactivation,
can we get a q->q_usage_counter and put it after blkg_create() is done
to prevent concurrent bfq policy activation and deactivation?

Thanks,
Kuai
> 
> Thanks.
> 

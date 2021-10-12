Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE6B429ACA
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 03:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhJLBLN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Oct 2021 21:11:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28919 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbhJLBLN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Oct 2021 21:11:13 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HSy9x4t66zbn4y;
        Tue, 12 Oct 2021 09:04:37 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 09:09:04 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 12 Oct 2021 09:09:03 +0800
Subject: Re: [PATCH] blk-cgroup: check blkcg policy is enabled in
 blkg_create()
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20211008072720.797814-1-yukuai3@huawei.com>
 <20211011152318.GA61605@blackbody.suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <93193221-fbad-444f-c325-9f19d4c5931b@huawei.com>
Date:   Tue, 12 Oct 2021 09:09:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211011152318.GA61605@blackbody.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/10/11 23:23, Michal Koutný wrote:
> Hello.
> 
> On Fri, Oct 08, 2021 at 03:27:20PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
>> This is because blkg_alloc() is called from blkg_conf_prep() without
>> holding 'q->queue_lock', and elevator is exited before blkg_create():
>   
> IIUC the problematic interleaving is this one (I've noticed `blkg->pd[i]
> = NULL` to thread 2 call trace):

The new blkg will not add to blkg_list untill pd_init_fn() is done in
blkg_create(), thus blkcg_deactivate_policy() can't access this blkg.
> 
>> thread 1                            thread 2
>> blkg_conf_prep
>>   spin_lock_irq(&q->queue_lock);
>>   blkg_lookup_check -> return NULL
>>   spin_unlock_irq(&q->queue_lock);
>>
>>   blkg_alloc
>>    blkcg_policy_enabled -> true
>>    pd = ->pd_alloc_fn
>>                                     blk_mq_exit_sched
>>                                      bfq_exit_queue
>>                                       blkcg_deactivate_policy
>>                                        spin_lock_irq(&q->queue_lock);
>>                                        __clear_bit(pol->plid, q->blkcg_pols);
>>
>                                          pol->pd_free_fn(blkg->pd[i]);
>                                          blkg->pd[i] = NULL;
>>
>>                                        spin_unlock_irq(&q->queue_lock);
>>                                      q->elevator = NULL;
>      blkg->pd[i] = pd
>>    spin_lock_irq(&q->queue_lock);
>>     blkg_create
>>      if (blkg->pd[i])
>>       ->pd_init_fn -> q->elevator is NULL
>>    spin_unlock_irq(&q->queue_lock);
> 
> In high-level terms, is this a race between (blk)io controller attribute
> write and a device scheduler (elevator) switch?
> If so, I'd add it to the commit message.
> 
>> Fix the problem by checking that policy is still enabled in
>> blkg_create().
> 
> Is this sufficient wrt some other q->elevator users later?
> 
>> @@ -252,6 +266,9 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>>   		goto err_free_blkg;
>>   	}
>>   
> 
> I'd add a comment here like:
> 
>> Re-check policies are still enabled, since the caller blkg_conf_prep()
>> temporarily drops q->queue_lock and we can race with
>> blk_mq_exit_sched() removing policies.

Thanks for your advice.

Best regards,
Kuai
> 
>> +	if (new_blkg)
>> +		blkg_check_pd(q, new_blkg);
>> +
> 
> Thanks,
> Michal
> .
> 

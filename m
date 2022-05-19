Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A9E52D3D6
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 15:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiESNVh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 09:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbiESNVc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 09:21:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2CB22289;
        Thu, 19 May 2022 06:21:29 -0700 (PDT)
Received: from kwepemi100026.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3r8L64NhzhZH8;
        Thu, 19 May 2022 21:20:50 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100026.china.huawei.com (7.221.188.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 21:21:27 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 21:21:26 +0800
Subject: Re: [PATCH -next 7/8] block, bfq: cleanup
 bfq_bfqq_update_budg_for_activation()
To:     Jan Kara <jack@suse.cz>
CC:     <paolo.valente@linaro.org>, <axboe@kernel.dk>, <tj@kernel.org>,
        <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220514090522.1669270-1-yukuai3@huawei.com>
 <20220514090522.1669270-8-yukuai3@huawei.com>
 <20220519111856.wvk4oetm7odnkg3w@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <6de25fae-7d36-c31c-a045-4f1668ef4ee5@huawei.com>
Date:   Thu, 19 May 2022 21:21:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220519111856.wvk4oetm7odnkg3w@quack3.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/05/19 19:18, Jan Kara Ð´µÀ:
> On Sat 14-05-22 17:05:21, Yu Kuai wrote:
>> It will only be called from bfq_bfqq_handle_idle_busy_switch() in
>> specific code branch, there is no need to precaculate
>> 'bfqq_wants_to_preempt' each time bfq_bfqq_handle_idle_busy_switch()
>> is caleld.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> Please see below:
> 
>> @@ -1816,14 +1807,6 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>>   		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
>>   		   (*interactive || soft_rt)));
>>   
>> -	/*
>> -	 * Using the last flag, update budget and check whether bfqq
>> -	 * may want to preempt the in-service queue.
>> -	 */
>> -	bfqq_wants_to_preempt =
>> -		bfq_bfqq_update_budg_for_activation(bfqd, bfqq,
>> -						    arrived_in_time);
>> -
>>   	/*
>>   	 * If bfqq happened to be activated in a burst, but has been
>>   	 * idle for much more than an interactive queue, then we
> ...
>> @@ -1918,7 +1900,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>>   	 * (2) this switch of bfqq to busy changes the scenario.
>>   	 */
>>   	if (bfqd->in_service_queue &&
>> -	    ((bfqq_wants_to_preempt &&
>> +	    ((bfq_bfqq_update_budg_for_activation(bfqd, bfqq) &&
>>   	      bfqq->wr_coeff >= bfqd->in_service_queue->wr_coeff) ||
>>   	     bfq_bfqq_higher_class_or_weight(bfqq, bfqd->in_service_queue) ||
>>   	     !bfq_better_to_idle(bfqd->in_service_queue)) &&
> 
> So these changes are actually wrong because
> bfq_bfqq_update_budg_for_activation() relies on
> bfq_bfqq_non_blocking_wait_rq() but bfq_add_bfqq_busy() clears that. And
> bfq_add_bfqq_busy() is called between the place where
> bfq_bfqq_update_budg_for_activation() was called previously and now so your
> patch breaks this logic.

Hi,

You are right, thanks for the explanation, I'll remove this patch and
the next patch in next version.

Kuai
> 
> 								Honza
> 

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711AD51287E
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 03:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiD1BLc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 21:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiD1BLb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 21:11:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F020772457;
        Wed, 27 Apr 2022 18:08:17 -0700 (PDT)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KpcnV2knLzCs7X;
        Thu, 28 Apr 2022 09:03:42 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 09:08:15 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 09:08:14 +0800
Subject: Re: [PATCH -next v3 1/3] block, bfq: record how many queues are busy
 in bfq_group
To:     Jan Kara <jack@suse.cz>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220427124722.48465-1-yukuai3@huawei.com>
 <20220427124722.48465-2-yukuai3@huawei.com>
 <20220427125251.yl7ff4ti33w6ktrf@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <4c783fa9-f01b-1f9e-9bcb-0e26431d0d24@huawei.com>
Date:   Thu, 28 Apr 2022 09:08:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220427125251.yl7ff4ti33w6ktrf@quack3.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/04/27 20:52, Jan Kara Ð´µÀ:
> On Wed 27-04-22 20:47:20, Yu Kuai wrote:
>> Prepare to refactor the counting of 'num_groups_with_pending_reqs'.
>>
>> Add a counter 'busy_queues' in bfq_group, and update it in
>> bfq_add/del_bfqq_busy().
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> ...
> 
>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>> index f8eb340381cf..53826797430f 100644
>> --- a/block/bfq-wf2q.c
>> +++ b/block/bfq-wf2q.c
>> @@ -218,6 +218,14 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
>>   	return false;
>>   }
>>   
>> +static void bfq_update_busy_queues(struct bfq_queue *bfqq, bool is_add)
>> +{
>> +	if (is_add)
>> +		bfqq_group(bfqq)->busy_queues++;
>> +	else
>> +		bfqq_group(bfqq)->busy_queues--;
>> +}
>> +
>>   #else /* CONFIG_BFQ_GROUP_IOSCHED */
> 
> I think the bool argument here unnecessarily hurts readability (it's
> difficult to see what the argument means without looking into the
> implementation). I'd rather create two functions bfq_{inc,dec}_busy_queues()
> or if you really insist on a single function, we can have
> bfq_add_busy_queues() and have 'int' argument that will be +1 or -1.

Thanks for the suggestion, I'll create two functions in next iteration.
> 
> 								Honza
> 

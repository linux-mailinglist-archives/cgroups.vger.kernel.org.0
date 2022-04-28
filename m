Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE74513272
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 13:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiD1Lar (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 07:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiD1Laq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 07:30:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6AE5BD0E;
        Thu, 28 Apr 2022 04:27:32 -0700 (PDT)
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kptct3NzszhYj9;
        Thu, 28 Apr 2022 19:27:10 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 19:27:30 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 19:27:29 +0800
Subject: Re: [PATCH -next v4 1/3] block, bfq: record how many queues are busy
 in bfq_group
To:     Jan Kara <jack@suse.cz>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <paolo.valente@linaro.org>,
        <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220428111907.3635820-1-yukuai3@huawei.com>
 <20220428111907.3635820-2-yukuai3@huawei.com>
 <20220428111800.aqfzwwii5dabx3ko@quack3.lan>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <00fafd9e-5433-70d8-6493-46a2cc78ec97@huawei.com>
Date:   Thu, 28 Apr 2022 19:27:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220428111800.aqfzwwii5dabx3ko@quack3.lan>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/04/28 19:18, Jan Kara Ð´µÀ:
> On Thu 28-04-22 19:19:05, Yu Kuai wrote:
>> Prepare to refactor the counting of 'num_groups_with_pending_reqs'.
>>
>> Add a counter 'busy_queues' in bfq_group, and update it in
>> bfq_add/del_bfqq_busy().
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> Just two nits below:
> 
>> --- a/block/bfq-wf2q.c
>> +++ b/block/bfq-wf2q.c
>> @@ -218,6 +218,16 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
>>   	return false;
>>   }
>>   
>> +static void bfq_add_busy_queues(struct bfq_queue *bfqq)
>> +{
>> +	bfqq_group(bfqq)->busy_queues++;
>> +}
>> +
>> +static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
>> +{
>> +	bfqq_group(bfqq)->busy_queues--;
>> +}
>> +
> 
> An opposite from "decrement" is "increment", not "add". So
> bfq_add_busy_queues() should be bfq_inc_busy_queues().

You are right
> 
>> @@ -230,6 +240,14 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
>>   	return true;
>>   }
>>   
>> +static void bfq_add_busy_queues(struct bfq_queue *bfqq)
>> +{
>> +}
>> +
>> +static void bfq_add_busy_queues(struct bfq_queue *bfqq)
>> +{
>> +}
>> +
> 
> You have two times the same function here and you miss the other one...

oops, I forgot to compile without CONFIG_BFQ_GROUP_IOSCHED...

Thanks a lot to spolt this.
Kuai
> 
> 								Honza
> 

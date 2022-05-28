Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F3536BAE
	for <lists+cgroups@lfdr.de>; Sat, 28 May 2022 10:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiE1IhO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 28 May 2022 04:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiE1IhN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 28 May 2022 04:37:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186FD19012;
        Sat, 28 May 2022 01:37:11 -0700 (PDT)
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L9FPd30RSzjX8C;
        Sat, 28 May 2022 16:36:05 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 16:37:09 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 16:37:08 +0800
Subject: Re: [PATCH -next v6 1/3] block, bfq: record how many queues are busy
 in bfq_group
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220523131818.2798712-1-yukuai3@huawei.com>
 <20220523131818.2798712-2-yukuai3@huawei.com>
 <8D29A46A-4B8A-4F05-BCE3-D9D0F0D2DD5A@linaro.org>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <7628f927-7131-5e7f-33d9-6029dada57fe@huawei.com>
Date:   Sat, 28 May 2022 16:37:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8D29A46A-4B8A-4F05-BCE3-D9D0F0D2DD5A@linaro.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ÔÚ 2022/05/28 16:18, Paolo Valente Ð´µÀ:
> 

>> /*
>> @@ -1660,6 +1678,7 @@ void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>> 	bfq_clear_bfqq_busy(bfqq);
>>
>> 	bfqd->busy_queues[bfqq->ioprio_class - 1]--;
>> +	bfq_inc_busy_queues(bfqq);
>>
> 
> Why do you increment the number of busy queues for the group on a
> del_bfqq_busy, instead of an add_bfqq_busy?
Hi, Paolo

You'are right, here should be bfq_dec_busy_queues()...
> 
> Besides, the name of the function bfq_inc_busy_queues does not mention
> the target of the update, namely the group.  This creates a little
> confusion at a first sight, as one sees this function invoked right
> after the update of a field with the same name: bfqd->busy_queues.
Ok, that make sense, I'll move the update of 'bfqd->busy_queues' into
the new api as well.

Thanks,
Kuai
> 
>> 	if (bfqq->wr_coeff > 1)
>> 		bfqd->wr_busy_queues--;
>> @@ -1683,6 +1702,7 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>>
>> 	bfq_mark_bfqq_busy(bfqq);
>> 	bfqd->busy_queues[bfqq->ioprio_class - 1]++;
>> +	bfq_dec_busy_queues(bfqq);
> 
> Same pair of comments as above.
> 
> Thanks,
> Paolo
> 
>>
>> 	if (!bfqq->dispatched)
>> 		if (bfqq->wr_coeff == 1)
>> -- 
>> 2.31.1
>>
> 
> .
> 

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6114B69DDE4
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 11:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjBUK3c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 05:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjBUK3c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 05:29:32 -0500
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D41DE11E81
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 02:29:28 -0800 (PST)
Received: from tux.applied-asynchrony.com (p5b2e8d56.dip0.t-ipconnect.de [91.46.141.86])
        by mail.itouring.de (Postfix) with ESMTPSA id 0C56CCF1AAE;
        Tue, 21 Feb 2023 11:19:25 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id A6BE8F01602;
        Tue, 21 Feb 2023 11:19:21 +0100 (CET)
Subject: Re: [PATCH] block, bfq: fix uaf for bfqq in bic_set_bfqq()
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk, paolo.valente@linaro.org,
        shinichiro.kawasaki@wdc.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
References: <20230113094410.2907223-1-yukuai3@huawei.com>
 <ca9fefd4-7109-042c-3b25-9eb795141145@huaweicloud.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <3e8c8567-f41d-66ae-0633-dcdbed007228@applied-asynchrony.com>
Date:   Tue, 21 Feb 2023 11:19:21 +0100
MIME-Version: 1.0
In-Reply-To: <ca9fefd4-7109-042c-3b25-9eb795141145@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023-02-21 08:04, Yu Kuai wrote:
> Hi, Jens
> 
> 在 2023/01/13 17:44, Yu Kuai 写道:
>> After commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'"),
>> bic->bfqq will be accessed in bic_set_bfqq(), however, in some context
>> bic->bfqq will be freed first, and bic_set_bfqq() is called with the freed
>> bic->bfqq.
>>
>> Fix the problem by always freeing bfqq after bic_set_bfqq().
>>
>> Fixes: 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
>> Reported-and-tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/bfq-cgroup.c  | 2 +-
>>   block/bfq-iosched.c | 4 +++-
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>> index a6e8da5f5cfd..feb13ac25557 100644
>> --- a/block/bfq-cgroup.c
>> +++ b/block/bfq-cgroup.c
>> @@ -749,8 +749,8 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
>>            * old cgroup.
>>            */
>>           bfq_put_cooperator(sync_bfqq);
>> -        bfq_release_process_ref(bfqd, sync_bfqq);
>>           bic_set_bfqq(bic, NULL, true, act_idx);
>> +        bfq_release_process_ref(bfqd, sync_bfqq);
>>       }
>>   }
>>
> 
> It seems this change is missed in GIT PULL for-6.3. I'll send a seperate
> patch to fix this...
> 

It was already applied in time for 6.2 as b600de2d7d3a16f9007fad1bdae82a3951a26af2
and also already merged to 6.1-stable.

cheers
Holger

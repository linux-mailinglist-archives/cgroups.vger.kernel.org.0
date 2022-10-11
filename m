Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FC75FA9B8
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 03:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJKBIE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 21:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJKBHs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 21:07:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF73C82766;
        Mon, 10 Oct 2022 18:07:41 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MmcyC6vYgzwPTf;
        Tue, 11 Oct 2022 09:04:51 +0800 (CST)
Received: from [10.174.178.129] (10.174.178.129) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 09:07:21 +0800
Subject: Re: [PATCH 2/4] blk-cgroup: correct comment for blk_alloc_queue and
 blk_exit_queue
To:     Tejun Heo <tj@kernel.org>
CC:     <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221010023859.11896-1-shikemeng@huawei.com>
 <20221010023859.11896-3-shikemeng@huawei.com>
 <Y0SACpAv4+ETrS6Z@slm.duckdns.org>
From:   Kemeng Shi <shikemeng@huawei.com>
Message-ID: <da6d7a9a-49a8-0116-2507-f5c8057eaf42@huawei.com>
Date:   Tue, 11 Oct 2022 09:07:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <Y0SACpAv4+ETrS6Z@slm.duckdns.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.129]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



on 10/11/2022 4:26 AM, Tejun Heo wrote:
> On Mon, Oct 10, 2022 at 10:38:57AM +0800, Kemeng Shi wrote:
>> Since commit 1059699f87eb("block: move blkcg initialization/destroy into
>> disk allocation/release handler"), blk_alloc_queue and blk_exit_queue is
>> called directly from gendisk. Update the corresponding comment.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
>> ---
>>  block/blk-cgroup.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index bc4dec705572..463c568d3e86 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1259,7 +1259,7 @@ static int blkcg_css_online(struct cgroup_subsys_state *css)
>>   * blkcg_init_queue - initialize blkcg part of request queue
>>   * @q: request_queue to initialize
>>   *
>> - * Called from blk_alloc_queue(). Responsible for initializing blkcg
>> + * Called from gendisk. Responsible for initializing blkcg
> 
> Maybe be a bit more specific and say blk_alloc_disk()?
Thanks for review. I will update this in next version.
> 
>>   * part of new request_queue @q.
>>   *
>>   * RETURNS:
>> @@ -1321,7 +1321,7 @@ int blkcg_init_queue(struct request_queue *q)
>>   * blkcg_exit_queue - exit and release blkcg part of request_queue
>>   * @q: request_queue being released
>>   *
>> - * Called from blk_exit_queue().  Responsible for exiting blkcg part.
>> + * Called from gendisk.  Responsible for exiting blkcg part.
> 
> Ditto.
> 

-- 
Best wishes
Kemeng Shi

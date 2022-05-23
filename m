Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E16530FD1
	for <lists+cgroups@lfdr.de>; Mon, 23 May 2022 15:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiEWM7E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 May 2022 08:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiEWM66 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 May 2022 08:58:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9018353A74;
        Mon, 23 May 2022 05:58:57 -0700 (PDT)
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L6HT95KyrzDqLt;
        Mon, 23 May 2022 20:58:53 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 20:58:55 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 20:58:54 +0800
Subject: Re: [PATCH -next v5 0/3] support concurrent sync io for bfq on a
 specail occasion
To:     Jens Axboe <axboe@kernel.dk>, <paolo.valente@linaro.org>
CC:     <jack@suse.cz>, <tj@kernel.org>, <linux-block@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220428120837.3737765-1-yukuai3@huawei.com>
 <d50df657-d859-79cf-c292-412eaa383d2c@huawei.com>
 <61b67d5e-829c-8130-7bda-81615d654829@huawei.com>
 <81411289-e13c-20f5-df63-c059babca57a@huawei.com>
 <d5a90a08-1ac6-587a-e900-0436bd45543a@kernel.dk>
 <55919e29-1f22-e8aa-f3d2-08c57d9e1c22@huawei.com>
 <b32ed748-a141-862c-ed35-debb474962ed@kernel.dk>
 <1172d00f-0843-1d7c-721f-fdb60a0945cb@huawei.com>
 <dfd2ac0b-74da-85f4-ff66-2eb307578d93@kernel.dk>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <8f0b5115-6a96-d5eb-5243-0be832cf121b@huawei.com>
Date:   Mon, 23 May 2022 20:58:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dfd2ac0b-74da-85f4-ff66-2eb307578d93@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

在 2022/05/23 20:36, Jens Axboe 写道:
> On 5/23/22 2:18 AM, Yu Kuai wrote:
>> ? 2022/05/23 9:24, Jens Axboe ??:
>>> On 5/22/22 7:10 PM, yukuai (C) wrote:
>>>> ? 2022/05/21 20:21, Jens Axboe ??:
>>>>> On 5/21/22 1:22 AM, yukuai (C) wrote:
>>>>>> ? 2022/05/14 17:29, yukuai (C) ??:
>>>>>>> ? 2022/05/05 9:00, yukuai (C) ??:
>>>>>>>> Hi, Paolo
>>>>>>>>
>>>>>>>> Can you take a look at this patchset? It has been quite a long time
>>>>>>>> since we spotted this problem...
>>>>>>>>
>>>>>>>
>>>>>>> friendly ping ...
>>>>>> friendly ping ...
>>>>>
>>>>> I can't speak for Paolo, but I've mentioned before that the majority
>>>>> of your messages end up in my spam. That's still the case, in fact
>>>>> I just marked maybe 10 of them as not spam.
>>>>>
>>>>> You really need to get this issued sorted out, or you will continue
>>>>> to have patches ignore because folks may simply not see them.
>>>>>
>>>> Hi,
>>>>
>>>> Thanks for your notice.
>>>>
>>>> Is it just me or do you see someone else's messages from *huawei.com
>>>> end up in spam? I tried to seek help from our IT support, however, they
>>>> didn't find anything unusual...
>>>
>>> Not sure, I think it's just you. It may be the name as well "yukuai (C)"
>> Hi, Jens
>>
>> I just change this default name "yukuai (C)" to "Yu Kuai", can you
>> please have a check if following emails still go to spam?
>>
>> https://lore.kernel.org/all/20220523082633.2324980-1-yukuai3@huawei.com/
> 
> These did not go into spam, were delivered just fine.
> 
Cheers for solving this, I'll resend this patchset just in case they are
in spam for Paolo...

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC93473F06
	for <lists+cgroups@lfdr.de>; Tue, 14 Dec 2021 10:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhLNJMx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Dec 2021 04:12:53 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32917 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhLNJMu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Dec 2021 04:12:50 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JCt1q6nyJzcbvP;
        Tue, 14 Dec 2021 17:12:31 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 17:12:48 +0800
Received: from [10.174.177.69] (10.174.177.69) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 17:12:48 +0800
Message-ID: <8c87a712-93fb-d794-6d08-cadf6452efc3@huawei.com>
Date:   Tue, 14 Dec 2021 17:12:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH -next] blk-throttle: Set BIO_THROTTLED when bio has been
 throttled
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
CC:     <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211118131551.810931-1-qiulaibin@huawei.com>
 <YaUZExR6v8IdZUeM@slm.duckdns.org>
 <03964258-10ff-7f19-10cb-ca4eccf72848@huawei.com>
 <YbepLpyMPqP2ao3J@slm.duckdns.org>
From:   QiuLaibin <qiulaibin@huawei.com>
In-Reply-To: <YbepLpyMPqP2ao3J@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.69]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2021/12/14 4:12, Tejun Heo wrote:
> On Mon, Dec 13, 2021 at 05:24:00PM +0800, QiuLaibin wrote:
>>> * This function is called synchronously on the issue path. The bio isn't
>>>     seen by the queue and device driver yet and nothing can race to issue it
>>>     before this function returns.
>>>
>>
>> The bio is under throttle here, this submit_bio return directly. And
>> current process will queue a dispatch work by
>> throtl_schedule_pending_timer() to submit this bio before BIO_THROTTLED flag
>> set. If the bio is completed quickly after the dispatch work is queued, UAF
>> of bio will happen.
> 
> You are right, the timer can get to it. Can't it be solved by just
> reordering spin_unlock and setting BIO_THROTTLED?
> 

I think it can be solved by setting BIO_THROTTLED before queue dispatch 
work.

>>> * Now we're not setting BIO_THROTTLED when we're taking a different return
>>>     path through the out_unlock label and risks calling back into blk_throtl
>>>     again on the same bio.
>>>
>>
>> In my opinion, This flag can prevent the request from being throttled
>> multiple times. If the request itself does not need to be throttled, the
>> result of repeated entry will be the same.
>> If necessary, I think we can use other methods to achieve this effect for
>> request does not need to be throttled.
> 
> So that we don't change anything regarding this?
> 

I am thinking of adding a new bio tag (like BIO_THROTTLE_BYPASS) to 
avoid those requests which do not need to be throttled to enter the 
throttle multiple times.
> Thanks.
> 

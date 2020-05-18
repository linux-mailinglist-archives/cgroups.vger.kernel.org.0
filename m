Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BA41D7739
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2020 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgERLej (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 May 2020 07:34:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51082 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbgERLej (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 18 May 2020 07:34:39 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D496DEC4CE1912E258A9;
        Mon, 18 May 2020 19:34:34 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.100) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 18 May 2020
 19:34:28 +0800
Subject: Re: [PATCH] blkcg: Fix memory leak in blkg_conf_prep()
To:     Markus Elfring <Markus.Elfring@web.de>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Feilong Lin" <linfeilong@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
References: <4c670a6c-98c3-2b14-7438-09199506d92f@web.de>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <5cfba9c1-675d-d4e8-65bf-746712ae32e5@huawei.com>
Date:   Mon, 18 May 2020 19:34:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4c670a6c-98c3-2b14-7438-09199506d92f@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.100]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2020/5/15 23:08, Markus Elfring wrote:
> …
>> new_blkg = blkg_alloc(pos, q, GFP_KERNEL);
> …
> 
> I suggest to omit the source code quotation from the change description.
> 
> 
>> if calling blkg_lookup_check() failed, at the IS_ERR block,
>> the new_blkg should be free before goto lable fail_unlock
>> in blkg_conf_prep() function.
> 
> How do you think about a wording variant like the following?
> 
>    If a call of the function “blkg_lookup_check” failed,
>    release the previously allocated block group before jumping
>    to the target “fail_unlock” in the implementation of
>    the function “blkg_conf_prep”.
> 

Thanks for your suggestion. omit the source code quotation from the 
description is more friendly. I will modify the description in V2 patch.

Thanks,
Wu Bo

> 
> Would you like to add the tag “Fixes” to the commit message?
> 
> Regards,
> Markus
> 



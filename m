Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5FD68AEAB
	for <lists+cgroups@lfdr.de>; Sun,  5 Feb 2023 08:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjBEHRM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Feb 2023 02:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBEHRM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Feb 2023 02:17:12 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7020F1DB8E;
        Sat,  4 Feb 2023 23:17:10 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P8ggg0HDDz4f3pG6;
        Sun,  5 Feb 2023 15:17:03 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgBHOObtV99jCvL6Cw--.47221S2;
        Sun, 05 Feb 2023 15:17:05 +0800 (CST)
Subject: Re: [PATCH] blk-ioprio: Introduce promote-to-rt policy
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
References: <20230201045227.2203123-1-houtao@huaweicloud.com>
 <a2d8d491-7410-2dd8-cc11-a0519e2025b6@acm.org>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <933b39ce-888b-e799-2f49-661356ac50fd@huaweicloud.com>
Date:   Sun, 5 Feb 2023 15:17:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a2d8d491-7410-2dd8-cc11-a0519e2025b6@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgBHOObtV99jCvL6Cw--.47221S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy8ZFWkZr1rArW5trW5Jrb_yoW5ur1kpF
        4fJF9xCFykXF1ftF17Jw1UXry8tryfKa1UJFnFgFy8ur1UZr1qvr1jgry0gFyxArWkXr45
        XrW3AryDuF15ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 2/4/2023 3:51 AM, Bart Van Assche wrote:
> On 1/31/23 20:52, Hou Tao wrote:
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst
>> b/Documentation/admin-guide/cgroup-v2.rst
>> index c8ae7c897f14..e0b9f73ef62a 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -2038,17 +2038,27 @@ that attribute:
>>       Change the I/O priority class of all requests into IDLE, the lowest
>>       I/O priority class.
>>   +  promote-to-rt
>> +    For requests that have I/O priority class BE or that have I/O priority
>> +        class IDLE, change it into RT. Do not modify the I/O priority class
>> +        of requests that have priority class RT.
>
> Please document whether or not this policy modifies the I/O priority
> (IOPRIO_PRIO_DATA()). Do you agree that the I/O priority should be preserved
> when promoting from BE to RT and that only the I/O priority class should be
> modified for such promotions?
I don't think it is a good idea to keep priority data for BE and IDLE class,
else after the override of bi_ioprio, a priority with IDLE class and high
priority data (e.g., 0) will have higher priority than BE class with low
priority data (e.g., 7). So maybe we should assign the lowest priority data to
the promoted io priority.
>
>>   The following numerical values are associated with the I/O priority policies:
>>   -+-------------+---+
>> -| no-change   | 0 |
>> -+-------------+---+
>> -| none-to-rt  | 1 |
>> -+-------------+---+
>> -| rt-to-be    | 2 |
>> -+-------------+---+
>> -| all-to-idle | 3 |
>> -+-------------+---+
>> +
>> ++---------------+---------+-----+
>> +| policy        | inst    | num |
>> ++---------------+---------+-----+
>> +| no-change     | demote  | 0   |
>> ++---------------+---------+-----+
>> +| none-to-rt    | demote  | 1   |
>> ++---------------+---------+-----+
>> +| rt-to-be      | demote  | 2   |
>> ++---------------+---------+-----+
>> +| idle          | demote  | 3   |
>> ++---------------+---------+-----+
>> +| promote-to-rt | promote | 1   |
>> ++---------------+---------+-----+
>
> I prefer that this table is not modified. The numerical values associated with
> policies only matters for none-to-rt, rt-to-be and all-to-idle but not for
> promote-to-rt. So I don't think that it is necessary to mention a numerical
> value for the promote-to-rt policy. Additionally, "none-to-rt" is not a policy
> that demotes the I/O priority but a policy that may promote the I/O priority.
Yes, this is no need to associate a number with promote-rt policy. Will fix in
v2. "none-to-rt" may promote io priority when the priority if NONE, although for
now bi_ioprio will never be NONE when blkcg_set_ioprio() is called.
>
>> +-- If the instruction is promotion, change the request I/O priority class
>> +-  into the minimum of the I/O priority class policy number and the numerical
>> +-  I/O priority class.
>
> Using the minimum value seems wrong to me because that will change
> IOPRIO_VALUE(IOPRIO_CLASS_RT, 1) into IOPRIO_VALUE(IOPRIO_CLASS_RT, 0).
Yes, you are right. Will fix in v2.
>
> Thanks,
>
> Bart.


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014D96A006D
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 02:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjBWBIQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Feb 2023 20:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjBWBIP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Feb 2023 20:08:15 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B8059DC;
        Wed, 22 Feb 2023 17:08:13 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PMZdh47Yrz4f3jpw;
        Thu, 23 Feb 2023 09:08:08 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgAXyq12vPZjgS+OEA--.62409S2;
        Thu, 23 Feb 2023 09:08:10 +0800 (CST)
Subject: Re: [PATCH v2] blk-ioprio: Introduce promote-to-rt policy
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
References: <20230220135428.2632906-1-houtao@huaweicloud.com>
 <5ff2b68a-a8fb-7901-2c38-1056a2c59f70@gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <48349bb4-68f1-365a-0556-742546d6dd68@huaweicloud.com>
Date:   Thu, 23 Feb 2023 09:08:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5ff2b68a-a8fb-7901-2c38-1056a2c59f70@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgAXyq12vPZjgS+OEA--.62409S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4xuw4rWw48ZF17Jr48Crg_yoW5Cr45pF
        4fAFW7ur1kXF17tF17Jr4qqFy0y3s2k3y7uFsrKFy09ryDAw1DZF1jyr18WFWxA397Xw45
        XrZIyFyvkrn0vrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
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

On 2/22/2023 3:38 PM, Bagas Sanjaya wrote:
> On 2/20/23 20:54, Hou Tao wrote:
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 74cec76be9f2..ccfb9fdfbc16 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -2021,31 +2021,33 @@ that attribute:
>>    no-change
>>  	Do not modify the I/O priority class.
>>  
>> -  none-to-rt
>> -	For requests that do not have an I/O priority class (NONE),
>> -	change the I/O priority class into RT. Do not modify
>> -	the I/O priority class of other requests.
>> +  promote-to-rt
>> +	For requests that have a no-RT I/O priority class, change it into RT.
> "non-RT" maybe? Or the original wording is better?
Because promote-to-rt doesn't work like none-to-rt, so using the original word
is incorrect. Will fix it to non-RT in v3.
>> +	Also change the priority level of these requests to 4. Do not modify
>> +	the I/O priority of requests that have priority class RT.>  
>>    restrict-to-be
>>  	For requests that do not have an I/O priority class or that have I/O
>> -	priority class RT, change it into BE. Do not modify the I/O priority
>> -	class of requests that have priority class IDLE.
>> +	priority class RT, change it into BE. Also change the priority level
>> +	of these requests to 0. Do not modify the I/O priority class of
>> +	requests that have priority class IDLE.
>>  
>>    idle
>>  	Change the I/O priority class of all requests into IDLE, the lowest
>>  	I/O priority class.
>>  
>> +  none-to-rt
>> +	Deprecated. Just an alias for promote-to-rt.
>> +
>>  The following numerical values are associated with the I/O priority policies:
>>  
>> -+-------------+---+
>> -| no-change   | 0 |
>> -+-------------+---+
>> -| none-to-rt  | 1 |
>> -+-------------+---+
>> -| rt-to-be    | 2 |
>> -+-------------+---+
>> -| all-to-idle | 3 |
>> -+-------------+---+
>> ++----------------+---+
>> +| no-change      | 0 |
>> ++----------------+---+
>> +| rt-to-be       | 2 |
>> ++----------------+---+
>> +| all-to-idle    | 3 |
>> ++----------------+---+
>>  
>>  The numerical value that corresponds to each I/O priority class is as follows:
>>  
>> @@ -2061,9 +2063,13 @@ The numerical value that corresponds to each I/O priority class is as follows:
>>  
>>  The algorithm to set the I/O priority class for a request is as follows:
>>  
>> -- Translate the I/O priority class policy into a number.
>> -- Change the request I/O priority class into the maximum of the I/O priority
>> -  class policy number and the numerical I/O priority class.
>> +- If I/O priority class policy is promote-to-rt, change the request I/O
>> +  priority class to IOPRIO_CLASS_RT and change the request I/O priority
>> +  level to 4.
>> +- If I/O priorityt class is not promote-to-rt, translate the I/O priority
>> +  class policy into a number, then change the request I/O priority class
>> +  into the maximum of the I/O priority class policy number and the numerical
>> +  I/O priority class.
>>  
>>  PID
>>  ---
> The rest is LGTM.
Thanks for you review.
>


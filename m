Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4A5687B7E
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 12:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBBLHN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 06:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBBLHM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 06:07:12 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAFF19F2F;
        Thu,  2 Feb 2023 03:06:40 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P6wXx17xLz4f3kKj;
        Thu,  2 Feb 2023 18:50:09 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgBXSOZfldtjVrZKCw--.49617S2;
        Thu, 02 Feb 2023 18:50:11 +0800 (CST)
Subject: Re: [PATCH] blk-ioprio: Introduce promote-to-rt policy
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
References: <20230201045227.2203123-1-houtao@huaweicloud.com>
 <Y9or5PkdXj/D94fR@debian.me>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <336ed542-6b73-0f69-a4ee-4119e73ddb1d@huaweicloud.com>
Date:   Thu, 2 Feb 2023 18:50:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y9or5PkdXj/D94fR@debian.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgBXSOZfldtjVrZKCw--.49617S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1fCry3XFWxGFWxKw17ZFb_yoWrGw1UpF
        s3AFWxW3Z7Xr15Kr17Jw4qqryxt34rKw47tFsrKFy09w1DAr1DXr1UXr18WFyxArW8Xw45
        XrZIyr1kCr1jvr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 2/1/2023 5:07 PM, Bagas Sanjaya wrote:
> On Wed, Feb 01, 2023 at 12:52:27PM +0800, Hou Tao wrote:
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
>> +
>> ++---------------+---------+-----+
>> +| policy        | inst    | num |
>> ++---------------+---------+-----+
>> +| no-change     | demote  | 0   |
>> ++---------------+---------+-----+
>> +| none-to-rt    | demote  | 1   |
>> ++---------------+---------+-----+
>> +| rt-to-be      | demote  | 2   |
>> ++---------------+---------+-----+
>> +| idle          | demote  | 3   |
>> ++---------------+---------+-----+
>> +| promote-to-rt | promote | 1   |
>> ++---------------+---------+-----+
>>  
> The first row should have been header row:
>
> ---- >8 ----
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index e0b9f73ef62a9e..55f9b579716564 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2048,7 +2048,7 @@ The following numerical values are associated with the I/O priority policies:
>  
>  +---------------+---------+-----+
>  | policy        | inst    | num |
> -+---------------+---------+-----+
> ++===============+=========+=====+
>  | no-change     | demote  | 0   |
>  +---------------+---------+-----+
>  | none-to-rt    | demote  | 1   |
>
>> @@ -2064,9 +2074,13 @@ The numerical value that corresponds to each I/O priority class is as follows:
>>  
>>  The algorithm to set the I/O priority class for a request is as follows:
>>  
>> -- Translate the I/O priority class policy into a number.
>> -- Change the request I/O priority class into the maximum of the I/O priority
>> -  class policy number and the numerical I/O priority class.
>> +-- Translate the I/O priority class policy into an instruction and a number
>> +-- If the instruction is demotion, change the request I/O priority class
>> +-  into the maximum of the I/O priority class policy number and the numerical
>> +-  I/O priority class.
>> +-- If the instruction is promotion, change the request I/O priority class
>> +-  into the minimum of the I/O priority class policy number and the numerical
>> +-  I/O priority class.
>>  
> Remove the excessive bullet list marker or the list above become paragraph
> instead:
>
> ---- >8 ----
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 55f9b579716564..c3f16386c47bdf 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2074,12 +2074,12 @@ The numerical value that corresponds to each I/O priority class is as follows:
>  
>  The algorithm to set the I/O priority class for a request is as follows:
>  
> --- Translate the I/O priority class policy into an instruction and a number
> --- If the instruction is demotion, change the request I/O priority class
> --  into the maximum of the I/O priority class policy number and the numerical
> --  I/O priority class.
> --- If the instruction is promotion, change the request I/O priority class
> --  into the minimum of the I/O priority class policy number and the numerical
> +- Translate the I/O priority class policy into an instruction-number pair.
> +- If the instruction is demotion, change the request I/O priority class
> +  into the maximum of the I/O priority class policy number and the numerical
> +  I/O priority class.
> +- If the instruction is promotion, change the request I/O priority class
> +  into the minimum of the I/O priority class policy number and the numerical
>  -  I/O priority class.
>  
>  PID
>
> Thanks.
Thanks for your comments. Will fix in v2.
>


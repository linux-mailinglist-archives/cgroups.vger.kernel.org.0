Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B89688CBE
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 02:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjBCBsd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 20:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBCBsd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 20:48:33 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B7D885FF;
        Thu,  2 Feb 2023 17:48:30 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P7JTP2M99z4f3p0S;
        Fri,  3 Feb 2023 09:48:25 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgAnFuTnZ9xjCTNxCw--.41037S2;
        Fri, 03 Feb 2023 09:48:27 +0800 (CST)
Subject: Re: [PATCH] blk-ioprio: Introduce promote-to-rt policy
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
References: <20230201045227.2203123-1-houtao@huaweicloud.com>
 <8c068af3-7199-11cf-5c69-a523c7c22d9a@acm.org>
 <4f7dcb3e-2d5a-cae3-0e1c-a82bcc3d2217@huaweicloud.com>
 <b6b3c498-e90b-7d1f-6ad5-a31334e433ae@acm.org>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <beb7782e-72a4-c350-3750-23a767c88753@huaweicloud.com>
Date:   Fri, 3 Feb 2023 09:48:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b6b3c498-e90b-7d1f-6ad5-a31334e433ae@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgAnFuTnZ9xjCTNxCw--.41037S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1UWF15XrW7tw4rAr13urg_yoW5AF4kpF
        4kCFyDArZ0qry8Jr1vq3W8urW8t3y3J3WUJF1FqF95ua1xtwnYgr4IqFn2gFyfGr4kXFnx
        Xw4UJrW8uFy5Aw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

Hi Bart,

On 2/3/2023 2:05 AM, Bart Van Assche wrote:
> On 2/2/23 03:09, Hou Tao wrote:
>> Hi,
>>
>> On 2/2/2023 1:33 AM, Bart Van Assche wrote:
>>> On 1/31/23 20:52, Hou Tao wrote:
>>>>    /**
>>>>     * enum prio_policy - I/O priority class policy.
>>>>     * @POLICY_NO_CHANGE: (default) do not modify the I/O priority class.
>>>> @@ -27,21 +34,30 @@
>>>>     * @POLICY_RESTRICT_TO_BE: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_RT
>>>> into
>>>>     *        IOPRIO_CLASS_BE.
>>>>     * @POLICY_ALL_TO_IDLE: change the I/O priority class into
>>>> IOPRIO_CLASS_IDLE.
>>>> - *
>>>> + * @POLICY_PROMOTE_TO_RT: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_BE into
>>>> + *         IOPRIO_CLASS_RT.
>>>>     * See also <linux/ioprio.h>.
>>>>     */
>>>>    enum prio_policy {
>>>> -    POLICY_NO_CHANGE    = 0,
>>>> -    POLICY_NONE_TO_RT    = 1,
>>>> -    POLICY_RESTRICT_TO_BE    = 2,
>>>> -    POLICY_ALL_TO_IDLE    = 3,
>>>> +    POLICY_NO_CHANGE    = IOPRIO_CLASS_NONE,
>>>> +    POLICY_NONE_TO_RT    = IOPRIO_CLASS_RT,
>>>> +    POLICY_RESTRICT_TO_BE    = IOPRIO_CLASS_BE,
>>>> +    POLICY_ALL_TO_IDLE    = IOPRIO_CLASS_IDLE,
>>>> +    POLICY_PROMOTE_TO_RT    = IOPRIO_CLASS_RT | IOPRIO_POL_PROMOTION,
>>>> +};
>>>
>>> The above change complicates the ioprio code. Additionally, I'm concerned that
>>> it makes the ioprio code slower. Has it been considered to keep the numerical
>>> values for the existing policies, to assign the number 4 to
>>> POLICY_PROMOTE_TO_RT and to use a lookup-array in blkcg_set_ioprio() to
>>> convert the policy number into an IOPRIO_CLASS value?
>> For the slowness, do you meaning the extra dereference of blkcg->ioprio->policy
>> when policy is no-change or the handle of IOPRIO_POL_PROMOTION in
>> blkcg_set_ioprio()? It seems other functions (e.g., ioprio_show_prio_policy()
>> and ioprio_set_prio_policy()) are not on the hot path. Using a lookup array in
>> blkcg_set_ioprio() to do the conversion will also be OK, although it will
>> introduce an extra lookup each time when policy is not no-change. I don't have
>> strong preference. If you are OK with lookup array in blkcg_set_ioprio(), will
>> do it in v2.
>
> Hi Hou,
>
> I prefer the lookup array because with the lookup array approach the
> IOPRIO_POL_PROMOTION constant is no longer needed and because I expect that
> this will result in code that is easier to read. Additionally, the lookup
> array will be small so the compiler may be clever enough to optimize it away.
I don't get it on how to remove IOPRIO_POL_PROMOTION when calculating the final
ioprio for bio. IOPRIO_POL_PROMOTION is not used for IOPRIO_CLASS values but
used to determinate on how to calculate the final ioprio for bio: choosing the
maximum or minimum between blkcg ioprio and original bio bi_ioprio.
>
> Thanks,
>
> Bart.
>
>
> .


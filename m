Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE021687BAD
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 12:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjBBLKO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 06:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjBBLKA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 06:10:00 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494591631D;
        Thu,  2 Feb 2023 03:09:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4P6wzB22gGz4f3kp4;
        Thu,  2 Feb 2023 19:09:26 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgDHd6vkmdtjMDR2Cw--.56257S2;
        Thu, 02 Feb 2023 19:09:28 +0800 (CST)
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
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <4f7dcb3e-2d5a-cae3-0e1c-a82bcc3d2217@huaweicloud.com>
Date:   Thu, 2 Feb 2023 19:09:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <8c068af3-7199-11cf-5c69-a523c7c22d9a@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgDHd6vkmdtjMDR2Cw--.56257S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr47Kr4DAFWrKFW8AFy8Grg_yoW8uFy3pF
        48CFykJrZYqFy8Jr1kXa18GrWUA3y3J3WUJF1FqF98uw48Kw10gw4FqFn2gFyfGa1kXrn8
        Jw4DJrWUua45Aw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 2/2/2023 1:33 AM, Bart Van Assche wrote:
> On 1/31/23 20:52, Hou Tao wrote:
>>   /**
>>    * enum prio_policy - I/O priority class policy.
>>    * @POLICY_NO_CHANGE: (default) do not modify the I/O priority class.
>> @@ -27,21 +34,30 @@
>>    * @POLICY_RESTRICT_TO_BE: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_RT into
>>    *        IOPRIO_CLASS_BE.
>>    * @POLICY_ALL_TO_IDLE: change the I/O priority class into IOPRIO_CLASS_IDLE.
>> - *
>> + * @POLICY_PROMOTE_TO_RT: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_BE into
>> + *         IOPRIO_CLASS_RT.
>>    * See also <linux/ioprio.h>.
>>    */
>>   enum prio_policy {
>> -    POLICY_NO_CHANGE    = 0,
>> -    POLICY_NONE_TO_RT    = 1,
>> -    POLICY_RESTRICT_TO_BE    = 2,
>> -    POLICY_ALL_TO_IDLE    = 3,
>> +    POLICY_NO_CHANGE    = IOPRIO_CLASS_NONE,
>> +    POLICY_NONE_TO_RT    = IOPRIO_CLASS_RT,
>> +    POLICY_RESTRICT_TO_BE    = IOPRIO_CLASS_BE,
>> +    POLICY_ALL_TO_IDLE    = IOPRIO_CLASS_IDLE,
>> +    POLICY_PROMOTE_TO_RT    = IOPRIO_CLASS_RT | IOPRIO_POL_PROMOTION,
>> +};
>
> The above change complicates the ioprio code. Additionally, I'm concerned that
> it makes the ioprio code slower. Has it been considered to keep the numerical
> values for the existing policies, to assign the number 4 to
> POLICY_PROMOTE_TO_RT and to use a lookup-array in blkcg_set_ioprio() to
> convert the policy number into an IOPRIO_CLASS value?
For the slowness, do you meaning the extra dereference of blkcg->ioprio->policy
when policy is no-change or the handle of IOPRIO_POL_PROMOTION in
blkcg_set_ioprio()? It seems other functions (e.g., ioprio_show_prio_policy()
and ioprio_set_prio_policy()) are not on the hot path. Using a lookup array in
blkcg_set_ioprio() to do the conversion will also be OK, although it will
introduce an extra lookup each time when policy is not no-change. I don't have
strong preference. If you are OK with lookup array in blkcg_set_ioprio(), will
do it in v2.
>
> Thanks,
>
> Bart.
>
>
> .


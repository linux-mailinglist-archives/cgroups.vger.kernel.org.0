Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1D16A4374
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 14:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjB0N4g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 08:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjB0N4f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 08:56:35 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AD11F4B2;
        Mon, 27 Feb 2023 05:56:33 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PQMVL6W5Yz4f3l81;
        Mon, 27 Feb 2023 21:56:26 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgAXB+WJtvxjUNV0EQ--.30054S2;
        Mon, 27 Feb 2023 21:56:28 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH v2] blk-ioprio: Introduce promote-to-rt policy
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
References: <20230220135428.2632906-1-houtao@huaweicloud.com>
 <20230227130305.2idxwmz2kdnacolc@quack3>
Message-ID: <05eafc4f-2d60-b7e6-1d5d-9a08709916e8@huaweicloud.com>
Date:   Mon, 27 Feb 2023 21:56:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230227130305.2idxwmz2kdnacolc@quack3>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgAXB+WJtvxjUNV0EQ--.30054S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4kJF1UAF4UGryrKrykZrb_yoW8CrW5pF
        4fWas3WryktF4fCF1DXF48AFW8t397Jw1UJr1YqrWru3y3Ar9xKw12gayfXFW5CrWkGr4Y
        q3W5ZrWvkF4UZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi

On 2/27/2023 9:03 PM, Jan Kara wrote:
> On Mon 20-02-23 21:54:28, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Since commit a78418e6a04c ("block: Always initialize bio IO priority on
>> submit"), bio->bi_ioprio will never be IOPRIO_CLASS_NONE when calling
>> blkcg_set_ioprio(), so there will be no way to promote the io-priority
>> of one cgroup to IOPRIO_CLASS_RT, because bi_ioprio will always be
>> greater than or equals to IOPRIO_CLASS_RT.
>>
>> It seems possible to call blkcg_set_ioprio() first then try to
>> initialize bi_ioprio later in bio_set_ioprio(), but this doesn't work
>> for bio in which bi_ioprio is already initialized (e.g., direct-io), so
>> introduce a new ioprio policy to promote the iopriority of bio to
>> IOPRIO_CLASS_RT if the ioprio is not already RT.
>>
>> So introduce a new promote-to-rt policy to achieve this. For none-to-rt
>> policy, although it doesn't work now, but considering that its purpose
>> was also to override the io-priority to RT and allow for a smoother
>> transition, just keep it and treat it as an alias of the promote-to-rt
>> policy.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Looks good to me. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
Thanks for the review.
>
> Just one question regarding doc below:
>
>> ++----------------+---+
>> +| no-change      | 0 |
>> ++----------------+---+
>> +| rt-to-be       | 2 |
>> ++----------------+---+
>> +| all-to-idle    | 3 |
>> ++----------------+---+
> Shouldn't there be preempt-to-rt somewhere in this table as well? Or why
> this this in the doc at all? I'd consider the numbers to be kernel internal
> thing?
These numbers are used in the algorithm paragraph below to explain how the final
ioprio is calculated. For prompt-to-rt policy, the algorithm is different and
the number is unnecessary.

> 								Honza


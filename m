Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3B70D448
	for <lists+cgroups@lfdr.de>; Tue, 23 May 2023 08:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjEWGsg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 May 2023 02:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjEWGse (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 May 2023 02:48:34 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CCF130;
        Mon, 22 May 2023 23:48:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QQPzF1JvHz4f41VZ;
        Tue, 23 May 2023 14:48:25 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgAXx6q0YWxkEesbKA--.16454S2;
        Tue, 23 May 2023 14:48:24 +0800 (CST)
Subject: Re: [PATCH v4] blk-ioprio: Introduce promote-to-rt policy
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Chaitanya Kulkarni <kch@nvidia.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "houtao1@huawei.com" <houtao1@huawei.com>
References: <20230428074404.280532-1-houtao@huaweicloud.com>
 <1db53a95-46d3-c906-31a1-0be4992a4b8d@huaweicloud.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <bff92f4c-0f21-9cf2-7135-812a184716b3@huaweicloud.com>
Date:   Tue, 23 May 2023 14:48:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1db53a95-46d3-c906-31a1-0be4992a4b8d@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgAXx6q0YWxkEesbKA--.16454S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1ftF1fWF4xtr4kZw13Arb_yoW3JrykpF
        4fAFZxur9YqF1xtFnrX3WkXrW8t3s7tw17WFnxKFyF934qyw1DuF4jyF18WFWfArWDXrZx
        Xr98JFWvkF98Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

ping ?

On 5/8/2023 8:08 PM, Hou Tao wrote:
> ping ?
>
> On 4/28/2023 3:44 PM, Hou Tao wrote:
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
>> introduce a new promote-to-rt policy to promote the iopriority of bio to
>> IOPRIO_CLASS_RT if the ioprio is not already RT.
>>
>> For none-to-rt policy, although it doesn't work now, but considering
>> that its purpose was also to override the io-priority to RT and allowing
>> for a smoother transition, just keep it and treat it as an alias of
>> the promote-to-rt policy.
>>
>> Acked-by: Tejun Heo <tj@kernel.org>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>> v4:
>>  * rebased on 33afd4b76393
>>  * Add Reviewed-by from Jan Kara
>>
>> v3: https://lore.kernel.org/linux-block/20230223135154.3749088-1-houtao@huaweicloud.com
>>  * Use 'non-RT' instead of 'no-RT' in document (from Bagas)
>>  * Remove repeated sentence in commit message
>>  * Add Reviewed-by and Acked-by tags
>>  
>> v2: https://lore.kernel.org/linux-block/20230220135428.2632906-1-houtao@huaweicloud.com
>>
>>  * Simplify the implementation of promote-to-rt (from Bart)
>>  * Make none-to-rt to work again by treating it as an alias of
>>    the promote-to-rt policy (from Bart & Jan)
>>  * fix the style of new content in cgroup-v2.rst (from Bagas)
>>  * set the default priority level to 4 instead of 0 for promote-to-rt
>>
>> v1: https://lore.kernel.org/linux-block/20230201045227.2203123-1-houtao@huaweicloud.com
>>
>>  Documentation/admin-guide/cgroup-v2.rst | 42 ++++++++++++++-----------
>>  block/blk-ioprio.c                      | 23 ++++++++++++--
>>  2 files changed, 44 insertions(+), 21 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index f67c0829350b..7544ce00e0cb 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -2024,31 +2024,33 @@ that attribute:
>>    no-change
>>  	Do not modify the I/O priority class.
>>  
>> -  none-to-rt
>> -	For requests that do not have an I/O priority class (NONE),
>> -	change the I/O priority class into RT. Do not modify
>> -	the I/O priority class of other requests.
>> +  promote-to-rt
>> +	For requests that have a non-RT I/O priority class, change it into RT.
>> +	Also change the priority level of these requests to 4. Do not modify
>> +	the I/O priority of requests that have priority class RT.
>>  
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
>> @@ -2064,9 +2066,13 @@ The numerical value that corresponds to each I/O priority class is as follows:
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
>> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
>> index 055529b9b92b..4051fada01f1 100644
>> --- a/block/blk-ioprio.c
>> +++ b/block/blk-ioprio.c
>> @@ -23,25 +23,28 @@
>>  /**
>>   * enum prio_policy - I/O priority class policy.
>>   * @POLICY_NO_CHANGE: (default) do not modify the I/O priority class.
>> - * @POLICY_NONE_TO_RT: modify IOPRIO_CLASS_NONE into IOPRIO_CLASS_RT.
>> + * @POLICY_PROMOTE_TO_RT: modify no-IOPRIO_CLASS_RT to IOPRIO_CLASS_RT.
>>   * @POLICY_RESTRICT_TO_BE: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_RT into
>>   *		IOPRIO_CLASS_BE.
>>   * @POLICY_ALL_TO_IDLE: change the I/O priority class into IOPRIO_CLASS_IDLE.
>> + * @POLICY_NONE_TO_RT: an alias for POLICY_PROMOTE_TO_RT.
>>   *
>>   * See also <linux/ioprio.h>.
>>   */
>>  enum prio_policy {
>>  	POLICY_NO_CHANGE	= 0,
>> -	POLICY_NONE_TO_RT	= 1,
>> +	POLICY_PROMOTE_TO_RT	= 1,
>>  	POLICY_RESTRICT_TO_BE	= 2,
>>  	POLICY_ALL_TO_IDLE	= 3,
>> +	POLICY_NONE_TO_RT	= 4,
>>  };
>>  
>>  static const char *policy_name[] = {
>>  	[POLICY_NO_CHANGE]	= "no-change",
>> -	[POLICY_NONE_TO_RT]	= "none-to-rt",
>> +	[POLICY_PROMOTE_TO_RT]	= "promote-to-rt",
>>  	[POLICY_RESTRICT_TO_BE]	= "restrict-to-be",
>>  	[POLICY_ALL_TO_IDLE]	= "idle",
>> +	[POLICY_NONE_TO_RT]	= "none-to-rt",
>>  };
>>  
>>  static struct blkcg_policy ioprio_policy;
>> @@ -189,6 +192,20 @@ void blkcg_set_ioprio(struct bio *bio)
>>  	if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)
>>  		return;
>>  
>> +	if (blkcg->prio_policy == POLICY_PROMOTE_TO_RT ||
>> +	    blkcg->prio_policy == POLICY_NONE_TO_RT) {
>> +		/*
>> +		 * For RT threads, the default priority level is 4 because
>> +		 * task_nice is 0. By promoting non-RT io-priority to RT-class
>> +		 * and default level 4, those requests that are already
>> +		 * RT-class but need a higher io-priority can use ioprio_set()
>> +		 * to achieve this.
>> +		 */
>> +		if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) != IOPRIO_CLASS_RT)
>> +			bio->bi_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_RT, 4);
>> +		return;
>> +	}
>> +
>>  	/*
>>  	 * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
>>  	 * correspond to a lower priority. Hence, the max_t() below selects
> .


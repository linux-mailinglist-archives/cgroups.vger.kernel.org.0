Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C093268AEA3
	for <lists+cgroups@lfdr.de>; Sun,  5 Feb 2023 08:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjBEHEa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Feb 2023 02:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBEHE3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Feb 2023 02:04:29 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2489722DFC;
        Sat,  4 Feb 2023 23:04:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P8gNz3DH7z4f3k6H;
        Sun,  5 Feb 2023 15:04:19 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP2 (Coremail) with SMTP id Syh0CgC3zuzxVN9jlGf6Cw--.32719S2;
        Sun, 05 Feb 2023 15:04:21 +0800 (CST)
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
 <beb7782e-72a4-c350-3750-23a767c88753@huaweicloud.com>
 <aedc240d-7c9e-248a-52d2-c9775f3e8ca1@acm.org>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <ffcf2d84-7f0a-21b7-8840-433227bc6afb@huaweicloud.com>
Date:   Sun, 5 Feb 2023 15:04:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <aedc240d-7c9e-248a-52d2-c9775f3e8ca1@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: Syh0CgC3zuzxVN9jlGf6Cw--.32719S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryfur1UZF48Jw1Dtw1UZFb_yoWrJFWrpF
        18JF98AryFqF1xJr1UX3W8Jry8t347J3WUJF1rXFy5Wr1Utr1jgw1jqF92gF1fJr4kXrsx
        Jw1UJrW8uFW5ArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2/4/2023 3:45 AM, Bart Van Assche wrote:
> On 2/2/23 17:48, Hou Tao wrote:
>> I don't get it on how to remove IOPRIO_POL_PROMOTION when calculating the final
>> ioprio for bio. IOPRIO_POL_PROMOTION is not used for IOPRIO_CLASS values but
>> used to determinate on how to calculate the final ioprio for bio: choosing the
>> maximum or minimum between blkcg ioprio and original bio bi_ioprio.
>
> Do the block layer code changes shown below implement the functionality that you
> need?
Yes, something like that. The reason for introducing IOPRIO_POL_PROMOTION is to
support other promotion policy (e.g., promote-to-be), but now I think the
possibility of adding other promotion policies is low, so the code below is fine
to me.
>
> Thanks,
>
> Bart.
>
>
>
> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
> index 8bb6b8eba4ce..4a56da95168e 100644
> --- a/block/blk-ioprio.c
> +++ b/block/blk-ioprio.c
> @@ -27,6 +27,8 @@
>   * @POLICY_RESTRICT_TO_BE: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_RT into
>   *        IOPRIO_CLASS_BE.
>   * @POLICY_ALL_TO_IDLE: change the I/O priority class into IOPRIO_CLASS_IDLE.
> + * @POLICY_PROMOTE_TO_RT: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_BE into
> + *         IOPRIO_CLASS_RT.
>   *
>   * See also <linux/ioprio.h>.
>   */
> @@ -35,6 +37,7 @@ enum prio_policy {
>      POLICY_NONE_TO_RT    = 1,
>      POLICY_RESTRICT_TO_BE    = 2,
>      POLICY_ALL_TO_IDLE    = 3,
> +    POLICY_PROMOTE_TO_RT,
>  };
>
>  static const char *policy_name[] = {
> @@ -42,6 +45,7 @@ static const char *policy_name[] = {
>      [POLICY_NONE_TO_RT]    = "none-to-rt",
>      [POLICY_RESTRICT_TO_BE]    = "restrict-to-be",
>      [POLICY_ALL_TO_IDLE]    = "idle",
> +    [POLICY_PROMOTE_TO_RT]    = "promote-to-rt",
>  };
>
>  static struct blkcg_policy ioprio_policy;
> @@ -189,17 +193,23 @@ void blkcg_set_ioprio(struct bio *bio)
>      if (!blkcg || blkcg->prio_policy == POLICY_NO_CHANGE)
>          return;
>
> -    /*
> -     * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
> -     * correspond to a lower priority. Hence, the max_t() below selects
> -     * the lower priority of bi_ioprio and the cgroup I/O priority class.
> -     * If the bio I/O priority equals IOPRIO_CLASS_NONE, the cgroup I/O
> -     * priority is assigned to the bio.
> -     */
> -    prio = max_t(u16, bio->bi_ioprio,
> -            IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));
> -    if (prio > bio->bi_ioprio)
> -        bio->bi_ioprio = prio;
> +    if (blkcg->prio_policy == PROMOTE_TO_RT) {
> +        if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) != IOPRIO_CLASS_RT)
> +            bio->bi_ioprio = IOPRIO_CLASS_RT;
> +    } else {
> +        /*
> +         * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
> +         * correspond to a lower priority. Hence, the max_t() below
> +         * selects the lower priority of bi_ioprio and the cgroup I/O
> +         * priority class.  If the bio I/O priority equals
> +         * IOPRIO_CLASS_NONE, the cgroup I/O priority is assigned to the
> +         * bio.
> +         */
> +        prio = max_t(u16, bio->bi_ioprio,
> +                 IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));
> +        if (prio > bio->bi_ioprio)
> +            bio->bi_ioprio = prio;
> +    }
>  }
>
>  void blk_ioprio_exit(struct gendisk *disk)
>


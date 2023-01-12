Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60DD6670B5
	for <lists+cgroups@lfdr.de>; Thu, 12 Jan 2023 12:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjALLRC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Jan 2023 06:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbjALLQ3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Jan 2023 06:16:29 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC50413D01;
        Thu, 12 Jan 2023 03:09:18 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Nt1yb0Y19z4f3mST;
        Thu, 12 Jan 2023 19:09:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R9W6r9jyxjFBQ--.28741S3;
        Thu, 12 Jan 2023 19:09:12 +0800 (CST)
Subject: Re: [PATCH] block: bfq fix null pointer dereference of bfqg in
 bfq_bio_bfqg()
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Anton Fadeev <anton.fadeev@red-soft.ru>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230112094358.451029-1-artem.chernyshev@red-soft.ru>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c72f2e00-1bd8-213c-585d-d465d6c34a14@huaweicloud.com>
Date:   Thu, 12 Jan 2023 19:09:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230112094358.451029-1-artem.chernyshev@red-soft.ru>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R9W6r9jyxjFBQ--.28741S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWryfZw47tFyfCr4fuF1kuFg_yoWrJr1UpF
        47Jr4qkr4xtr1DZa1UA3W7X340qan7AFnrWr12vry3tF1vgw1DJFn5Ar4UJrykKw15uF13
        Jw1DX348tr1qkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

ÔÚ 2023/01/12 17:43, Artem Chernyshev Ð´µÀ:
> It is possible for bfqg to be NULL after being initialized as result of
> blkg_to_bfqg() function.
> 
> That was achieved on kernel 5.15.78, but should exist in mainline as
> well

The problem is already fixed in mainline by following patch:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f02be9002c480cd3ec0fcf184ad27cf531bd6ece

Thanks,
Kuai
> 
> host1 login: [ 460.855794] watchdog: watchdog0: watchdog did not stop!
> [  898.944512] BUG: kernel NULL pointer dereference, address: 0000000000000094
> [  899.285776] #PF: supervisor read access in kernel mode
> [  899.536511] #PF: error_code(0x0000) - not-present page
> [  899.647305]  connection4:0: detected conn error (1020)
> [  899.786794] PGD 0 P4D 0
> [  899.786799] Oops: 0000 [#1] SMP PTI
> [  899.786802] CPU: 15 PID: 6073 Comm: ID iothread1 Not tainted 5.15.78-1.el7virt.x86_64 #1
> [  899.786804] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 10/21/2019
> [  899.786806] RIP: 0010:bfq_bio_bfqg+0x26/0x80
> [  901.325944] Code: 0f 1f 40 00 0f 1f 44 00 00 55 48 89 fd 48 89 f7 53 48 8b 56 48 48 85 d2
> 74 32 48 63 05 83 7f 35 01 48 83 c0 16 48 8b 5c c2 08 <80> bb 94 00 00 00 00 00
> [  902.237825] RSP: 0018:ffffae2649437688 EFLAGS: 00010002
> [  902.493396] RAX: 0000000000000019 RBX: 0000000000000000 RCX: dead000000000122
> [  902.841529] RDX: ffff8b6012cb3a00 RSI: ffff8b71002bbed0 RDI: ffff8b71002bbed0
> [  903.189374] RBP: ffff8b601c46e800 R08: ffffae26494377c8 R09: 0000000000000000
> [  903.532985] R10: 0000000000000001 R11: 0000000000000008 R12: ffff8b6f844c5b30
> [  903.880809] R13: ffff8b601c46e800 R14: ffffae2649437760 R15: ffff8b601c46e800
> [  904.220054] FS:  00007fec2fc4a700(0000) GS:ffff8b7f7f640000(0000) kn1GS:00000000000000000
> [  904.614349] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  904.894717] CR2: 0000000000000094 CR3: 0000000111fd8002 CR4: 00000000003726e0
> [  905.243702] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  905.592493] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  905.936859] Call Trace:
> [  906.055955] <TASK>
> [  906.158109] bfq_bic_update_cgroup+0x2c/0x1f0
> [  906.371057] bfq_insert_requests+0x2c2/0x1fb0
> [  906.579207] blk_mq_sched_insert_request+0xc2/0x140
> [  906.817640] __blk_mq_try_issue_directly+0xe0/0x1f0
> [  907.055737] blk_mq_request_issue_directly+0x4e/0xa0
> [  907.298547] dm_mq_queue_rq+0x217/0x3e0
> [  907.485935] blk_mq_dispatch_rq_list+0x14b/0x860
> [  907.711973] ? sbitmap_get+0x87/0x1a0
> [  907.890370] blk_mq_do_dispatch_sched+0x350/0x3b0
> [  908.074869] NMI watchdog: Watchdog detected hard LOCKUP on cpu 40
> 
> Fixes: 075a53b78b81 ("bfq: Make sure bfqg for which we are queueing requests is online")
> Co-developed-by: Anton Fadeev <anton.fadeev@red-soft.ru>
> Signed-off-by: Anton Fadeev <anton.fadeev@red-soft.ru>
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> ---
>   block/bfq-cgroup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 1b2829e99dad..d4e9428cdbe5 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -616,7 +616,7 @@ struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
>   			continue;
>   		}
>   		bfqg = blkg_to_bfqg(blkg);
> -		if (bfqg->online) {
> +		if (bfqg && bfqg->online) {
>   			bio_associate_blkg_from_css(bio, &blkg->blkcg->css);
>   			return bfqg;
>   		}
> 


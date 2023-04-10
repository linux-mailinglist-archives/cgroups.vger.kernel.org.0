Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099EA6DC276
	for <lists+cgroups@lfdr.de>; Mon, 10 Apr 2023 03:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDJB56 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 9 Apr 2023 21:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDJB56 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 9 Apr 2023 21:57:58 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5C9358D;
        Sun,  9 Apr 2023 18:57:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PvsYm20NLz4f4Nt5;
        Mon, 10 Apr 2023 09:57:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDHcyEbbTNkJq3_GQ--.14009S3;
        Mon, 10 Apr 2023 09:57:49 +0800 (CST)
Subject: Re: [PATCH v2 0/3] blk-cgroup: some cleanup
To:     Bart Van Assche <bvanassche@acm.org>,
        Chengming Zhou <zhouchengming@bytedance.com>, axboe@kernel.dk,
        tj@kernel.org
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20230406145050.49914-1-zhouchengming@bytedance.com>
 <cab869b1-1cba-5698-55eb-a93d0596c869@acm.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d23a6891-96f0-2ee0-70c7-869123d85362@huaweicloud.com>
Date:   Mon, 10 Apr 2023 09:57:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cab869b1-1cba-5698-55eb-a93d0596c869@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDHcyEbbTNkJq3_GQ--.14009S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4fCr4xAr1kXw43AF1DJrb_yoW8ur4rpa
        15KFZxCr48Gryqqa1rZanrWF18Ga9IkasrAr93Kr43Zas8uw48JF1kJF9FvryUGFWkZFyx
        WFyDGFZ5XF4jq37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Bart

在 2023/04/08 2:41, Bart Van Assche 写道:
> On 4/6/23 07:50, Chengming Zhou wrote:
>> These are some cleanup patches of blk-cgroup. Thanks for review.
> 
> With these patches applied, my kernel test VM crashes during boot. The 
> following crash disappears if I revert these patches:
> 
> BUG: KASAN: null-ptr-deref in bio_associate_blkg_from_css+0x83/0x240
> Read of size 8 at addr 0000000000000518 by task blkid/5885
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> 1.16.0-debian-1.16.0-5 04/01/2014
> Call Trace:
>   dump_stack_lvl+0x4a/0x80
>   print_report+0x21e/0x260
>   kasan_report+0xc2/0xf0
>   __asan_load8+0x69/0x90
>   bio_associate_blkg_from_css+0x83/0x240
>   bfq_bio_bfqg+0xce/0x120 [bfq]
>   bfq_bic_update_cgroup+0x2f/0x3c0 [bfq]
>   bfq_init_rq+0x1e8/0xb10 [bfq]
>   bfq_insert_request.isra.0+0xa3/0x420 [bfq]
>   bfq_insert_requests+0xca/0xf0 [bfq]
>   blk_mq_dispatch_rq_list+0x4c0/0xb00

I found this call trace quite weird, I can't figure out how
bfq_insert_requests can be called from blk_mq_dispatch_rq_list,
can you show the add2line result?

Thanks,
Kuai
>   __blk_mq_sched_dispatch_requests+0x15e/0x200
>   blk_mq_sched_dispatch_requests+0x8b/0xc0
>   __blk_mq_run_hw_queue+0x3ff/0x500
>   __blk_mq_delay_run_hw_queue+0x23a/0x300
>   blk_mq_run_hw_queue+0x14e/0x350
>   blk_mq_sched_insert_request+0x181/0x1f0
>   blk_execute_rq+0xf4/0x300
>   scsi_execute_cmd+0x23e/0x350
>   sr_do_ioctl+0x173/0x3d0 [sr_mod]
>   sr_packet+0x60/0x90 [sr_mod]
>   cdrom_get_track_info.constprop.0+0x125/0x170 [cdrom]
>   cdrom_get_last_written+0x1d4/0x2d0 [cdrom]
>   mmc_ioctl_cdrom_last_written+0x85/0x120 [cdrom]
>   mmc_ioctl+0x10b/0x1d0 [cdrom]
>   cdrom_ioctl+0xa66/0x1270 [cdrom]
>   sr_block_ioctl+0xee/0x130 [sr_mod]
>   blkdev_ioctl+0x1bb/0x3f0
>   __x64_sys_ioctl+0xc7/0xe0
>   do_syscall_64+0x34/0x80
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Bart.
> 
> .
> 


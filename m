Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0896E63BFE5
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 13:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbiK2MTC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Nov 2022 07:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiK2MTB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Nov 2022 07:19:01 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF156D6D;
        Tue, 29 Nov 2022 04:19:00 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NM1bK3TcZz4f3mVv;
        Tue, 29 Nov 2022 20:18:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBniteu+IVjypZsBQ--.28234S3;
        Tue, 29 Nov 2022 20:18:56 +0800 (CST)
Subject: Re: [PATCH -next 7/8] blk-iocost: fix possible UAF in ioc_pd_free
To:     Li Nan <linan122@huawei.com>, tj@kernel.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221128154434.4177442-1-linan122@huawei.com>
 <20221128154434.4177442-8-linan122@huawei.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <265d253a-15c2-ead4-da94-8915454bcca4@huaweicloud.com>
Date:   Tue, 29 Nov 2022 20:18:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221128154434.4177442-8-linan122@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBniteu+IVjypZsBQ--.28234S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4rCw48uF4fur13KF43trb_yoWrGr4rpF
        4fGry3u34DWrnFga13J3W2kryrCF4Fg34rurs3KwnIka1fAr92qF18AryY9FWrGrW7ZFW5
        ZF92grW8XF4DAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2022/11/28 23:44, Li Nan Ð´µÀ:
> Our test found the following problem in kernel 5.10, and the same problem
> should exist in mainline:
> 
>    BUG: KASAN: use-after-free in _raw_spin_lock_irqsave+0x71/0xe0
>    Write of size 4 at addr ffff8881432000e0 by task swapper/4/0
>    ...
>    Call Trace:
>     <IRQ>
>     dump_stack+0x9c/0xd3
>     print_address_description.constprop.0+0x19/0x170
>     __kasan_report.cold+0x6c/0x84
>     kasan_report+0x3a/0x50
>     check_memory_region+0xfd/0x1f0
>     _raw_spin_lock_irqsave+0x71/0xe0
>     ioc_pd_free+0x9d/0x250
>     blkg_free.part.0+0x80/0x100
>     __blkg_release+0xf3/0x1c0
>     rcu_do_batch+0x292/0x700
>     rcu_core+0x270/0x2d0
>     __do_softirq+0xfd/0x402
>      </IRQ>
>     asm_call_irq_on_stack+0x12/0x20
>     do_softirq_own_stack+0x37/0x50
>     irq_exit_rcu+0x134/0x1a0
>     sysvec_apic_timer_interrupt+0x36/0x80
>     asm_sysvec_apic_timer_interrupt+0x12/0x20
> 
>     Freed by task 57:
>     kfree+0xba/0x680
>     rq_qos_exit+0x5a/0x80
>     blk_cleanup_queue+0xce/0x1a0
>     virtblk_remove+0x77/0x130 [virtio_blk]
>     virtio_dev_remove+0x56/0xe0
>     __device_release_driver+0x2ba/0x450
>     device_release_driver+0x29/0x40
>     bus_remove_device+0x1d8/0x2c0
>     device_del+0x333/0x7e0
>     device_unregister+0x27/0x90
>     unregister_virtio_device+0x22/0x40
>     virtio_pci_remove+0x53/0xb0
>     pci_device_remove+0x7a/0x130
>     __device_release_driver+0x2ba/0x450
>     device_release_driver+0x29/0x40
>     pci_stop_bus_device+0xcf/0x100
>     pci_stop_and_remove_bus_device+0x16/0x20
>     disable_slot+0xa1/0x110
>     acpiphp_disable_and_eject_slot+0x35/0xe0
>     hotplug_event+0x1b8/0x3c0
>     acpiphp_hotplug_notify+0x37/0x70
>     acpi_device_hotplug+0xee/0x320
>     acpi_hotplug_work_fn+0x69/0x80
>     process_one_work+0x3c5/0x730
>     worker_thread+0x93/0x650
>     kthread+0x1ba/0x210
>     ret_from_fork+0x22/0x30
> 
> It happened as follow:
> 
> 	T1		    T2			T3
>    //rmdir cgroup
>    blkcg_destroy_blkgs
>     blkg_destroy
>      percpu_ref_kill
>       blkg_release
>        call_rcu
> 			//delete device
> 			del_gendisk

del_gendisk will synchronize_rcu, hence this is wrong.

call_rcu from blkcg_destroy_blkgs should be called after
synchronize_rcu.

Thanks,
Kuai
> 			 rq_qos_exit
> 			  ioc_rqos_exit
> 			   kfree(ioc)
> 					   __blkg_release
> 					    blkg_free
> 					     blkg_free_workfn
> 					      pd_free_fn
> 					       ioc_pd_free
> 						spin_lock_irqsave
> 						 ->ioc is freed
> 
> Fix the problem by moving the operation on ioc in ioc_pd_free() to
> ioc_pd_offline(), and just free resource in ioc_pd_free() like iolatency
> and throttle.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   block/blk-iocost.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 03977385449f..1b855babfc35 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2978,7 +2978,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
>   	spin_unlock_irqrestore(&ioc->lock, flags);
>   }
>   
> -static void ioc_pd_free(struct blkg_policy_data *pd)
> +static void ioc_pd_offline(struct blkg_policy_data *pd)
>   {
>   	struct ioc_gq *iocg = pd_to_iocg(pd);
>   	struct ioc *ioc = iocg->ioc;
> @@ -3002,6 +3002,12 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
>   
>   		hrtimer_cancel(&iocg->waitq_timer);
>   	}
> +}
> +
> +static void ioc_pd_free(struct blkg_policy_data *pd)
> +{
> +	struct ioc_gq *iocg = pd_to_iocg(pd);
> +
>   	free_percpu(iocg->pcpu_stat);
>   	kfree(iocg);
>   }
> @@ -3488,6 +3494,7 @@ static struct blkcg_policy blkcg_policy_iocost = {
>   	.cpd_free_fn	= ioc_cpd_free,
>   	.pd_alloc_fn	= ioc_pd_alloc,
>   	.pd_init_fn	= ioc_pd_init,
> +	.pd_offline_fn	= ioc_pd_offline,
>   	.pd_free_fn	= ioc_pd_free,
>   	.pd_stat_fn	= ioc_pd_stat,
>   };
> 


Return-Path: <cgroups+bounces-5647-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF439D318A
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 01:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403C61F2356A
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 00:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B636CA932;
	Wed, 20 Nov 2024 00:56:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1D17F7;
	Wed, 20 Nov 2024 00:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732064214; cv=none; b=KTxyBV6GWgGpuRfyBPXmtB4zeVrS9fcj3AV/zX06ktkb6kCvdEuY4WF1vDNiKwQEGkaqNqi+hAOA5m3UIK7Vs4QeAH0EjbDjpN79+GOnI9Wmvidcu/A8rABFlxiTERLIaGRs+/xzWu2sWm7M3bOnMI5/8LmHr7D2bUFzCYQ78jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732064214; c=relaxed/simple;
	bh=y6nY4il7pvYAVZByBzwvlvx9Y/rEsE/Rgek8Mcxjurc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K6MQnw1aQVf97kjmxQre871KcQ/VAmlu77mXPcDHvD7gdV/bGQQ9x9bu4yk6QZZa0AwK4biQ4VmbjYIAb3qnN3RyBiamp4iaGIDTTcNDvxuz68NVHfKRVCJQnGge6dyXqznREoT+yAn/t3moj1abXlyBET0nqfW+SwPwH1Bgseo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XtNGh1vp1z4f3kF4;
	Wed, 20 Nov 2024 08:56:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BDB161A0197;
	Wed, 20 Nov 2024 08:56:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDHo4fMMz1n1p0hCQ--.55723S3;
	Wed, 20 Nov 2024 08:56:46 +0800 (CST)
Subject: Re: [PATCH] Revert "block, bfq: merge bfq_release_process_ref() into
 bfq_put_cooperator()"
To: Zach Wade <zachwade.k@gmail.com>, tj@kernel.org, josef@toxicpanda.com,
 axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ding Hui <dinghui@sangfor.com.cn>, "yukuai (C)" <yukuai3@huawei.com>
References: <20241119153410.2546-1-zachwade.k@gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <07acc3f6-7926-790b-d888-19b303e137e3@huaweicloud.com>
Date: Wed, 20 Nov 2024 08:56:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241119153410.2546-1-zachwade.k@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHo4fMMz1n1p0hCQ--.55723S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuw1xXF1DZFWkWrykZryrJFb_yoWfCw4Dpr
	nFyFWxCr4rKryUZrsrGw18XFyxJrW8C3WjqrWIyw1xJ348WasIqFyDKF1UX3Wqkw1kurya
	q3WDGws0qF1UGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/11/19 23:34, Zach Wade Ð´µÀ:
> This reverts commit bc3b1e9e7c50e1de0f573eea3871db61dd4787de.
> 
> The bic is associated with sync_bfqq, and bfq_release_process_ref cannot
> be put into bfq_put_cooperator.

This descrption is not clear to me.
> 
> kasan report:
> [  400.347277] ==================================================================
> [  400.347287] BUG: KASAN: slab-use-after-free in bic_set_bfqq+0x200/0x230
> [  400.347420] Read of size 8 at addr ffff88881cab7d60 by task dockerd/5800
> [  400.347430]
> [  400.347436] CPU: 24 UID: 0 PID: 5800 Comm: dockerd Kdump: loaded Tainted: G E 6.12.0 #32
> [  400.347450] Tainted: [E]=UNSIGNED_MODULE
> [  400.347454] Hardware name: VMware, Inc. VMware20,1/440BX Desktop Reference Platform, BIOS VMW201.00V.20192059.B64.2207280713 07/28/2022
> [  400.347460] Call Trace:
> [  400.347464]  <TASK>
> [  400.347468]  dump_stack_lvl+0x5d/0x80
> [  400.347490]  print_report+0x174/0x505
> [  400.347521]  kasan_report+0xe0/0x160
> [  400.347541]  bic_set_bfqq+0x200/0x230
> [  400.347549]  bfq_bic_update_cgroup+0x419/0x740
> [  400.347560]  bfq_bio_merge+0x133/0x320
> [  400.347584]  blk_mq_submit_bio+0x1761/0x1e20
> [  400.347625]  __submit_bio+0x28b/0x7b0
> [  400.347664]  submit_bio_noacct_nocheck+0x6b2/0xd30
> [  400.347690]  iomap_readahead+0x50c/0x680
> [  400.347731]  read_pages+0x17f/0x9c0
> [  400.347785]  page_cache_ra_unbounded+0x366/0x4a0
> [  400.347795]  filemap_fault+0x83d/0x2340
> [  400.347819]  __xfs_filemap_fault+0x11a/0x7d0 [xfs]
> [  400.349256]  __do_fault+0xf1/0x610
> [  400.349270]  do_fault+0x977/0x11a0
> [  400.349281]  __handle_mm_fault+0x5d1/0x850
> [  400.349314]  handle_mm_fault+0x1f8/0x560
> [  400.349324]  do_user_addr_fault+0x324/0x970
> [  400.349337]  exc_page_fault+0x76/0xf0
> [  400.349350]  asm_exc_page_fault+0x26/0x30
> [  400.349360] RIP: 0033:0x55a480d77375
> [  400.349384] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 49 3b 66 10 0f 86 ae 02 00 00 55 48 89 e5 48 83 ec 58 48 8b 10 <83> 7a 10 00 0f 84 27 02 00 00 44 0f b6 42 28 44 0f b6 4a 29 41 80
> [  400.349392] RSP: 002b:00007f18c37fd8b8 EFLAGS: 00010216
> [  400.349401] RAX: 00007f18c37fd9d0 RBX: 0000000000000000 RCX: 0000000000000000
> [  400.349407] RDX: 000055a484407d38 RSI: 000000c000e8b0c0 RDI: 0000000000000000
> [  400.349412] RBP: 00007f18c37fd910 R08: 000055a484017f60 R09: 000055a484066f80
> [  400.349417] R10: 0000000000194000 R11: 0000000000000005 R12: 0000000000000008
> [  400.349422] R13: 0000000000000000 R14: 000000c000476a80 R15: 0000000000000000
> [  400.349430]  </TASK>
> [  400.349452]
> [  400.349454] Allocated by task 5800:
> [  400.349459]  kasan_save_stack+0x30/0x50
> [  400.349469]  kasan_save_track+0x14/0x30
> [  400.349475]  __kasan_slab_alloc+0x89/0x90
> [  400.349482]  kmem_cache_alloc_node_noprof+0xdc/0x2a0
> [  400.349492]  bfq_get_queue+0x1ef/0x1100
> [  400.349502]  __bfq_get_bfqq_handle_split+0x11a/0x510
> [  400.349511]  bfq_insert_requests+0xf55/0x9030
> [  400.349519]  blk_mq_flush_plug_list+0x446/0x14c0
> [  400.349527]  __blk_flush_plug+0x27c/0x4e0
> [  400.349534]  blk_finish_plug+0x52/0xa0
> [  400.349540]  _xfs_buf_ioapply+0x739/0xc30 [xfs]
> [  400.350246]  __xfs_buf_submit+0x1b2/0x640 [xfs]
> [  400.350967]  xfs_buf_read_map+0x306/0xa20 [xfs]
> [  400.351672]  xfs_trans_read_buf_map+0x285/0x7d0 [xfs]
> [  400.352386]  xfs_imap_to_bp+0x107/0x270 [xfs]
> [  400.353077]  xfs_iget+0x70d/0x1eb0 [xfs]
> [  400.353786]  xfs_lookup+0x2ca/0x3a0 [xfs]
> [  400.354506]  xfs_vn_lookup+0x14e/0x1a0 [xfs]
> [  400.355197]  __lookup_slow+0x19c/0x340
> [  400.355204]  lookup_one_unlocked+0xfc/0x120
> [  400.355211]  ovl_lookup_single+0x1b3/0xcf0 [overlay]
> [  400.355255]  ovl_lookup_layer+0x316/0x490 [overlay]
> [  400.355295]  ovl_lookup+0x844/0x1fd0 [overlay]
> [  400.355351]  lookup_one_qstr_excl+0xef/0x150
> [  400.355357]  do_unlinkat+0x22a/0x620
> [  400.355366]  __x64_sys_unlinkat+0x109/0x1e0
> [  400.355375]  do_syscall_64+0x82/0x160
> [  400.355384]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  400.355393]
> [  400.355395] Freed by task 5800:
> [  400.355400]  kasan_save_stack+0x30/0x50
> [  400.355407]  kasan_save_track+0x14/0x30
> [  400.355413]  kasan_save_free_info+0x3b/0x70
> [  400.355422]  __kasan_slab_free+0x4f/0x70
> [  400.355429]  kmem_cache_free+0x176/0x520
> [  400.355438]  bfq_put_queue+0x67e/0x980
> [  400.355447]  bfq_bic_update_cgroup+0x407/0x740
> [  400.355454]  bfq_bio_merge+0x133/0x320
> [  400.355460]  blk_mq_submit_bio+0x1761/0x1e20
> [  400.355467]  __submit_bio+0x28b/0x7b0
> [  400.355473]  submit_bio_noacct_nocheck+0x6b2/0xd30
> [  400.355480]  iomap_readahead+0x50c/0x680
> [  400.355490]  read_pages+0x17f/0x9c0
> [  400.355498]  page_cache_ra_unbounded+0x366/0x4a0
> [  400.355505]  filemap_fault+0x83d/0x2340
> [  400.355514]  __xfs_filemap_fault+0x11a/0x7d0 [xfs]
> [  400.356204]  __do_fault+0xf1/0x610
> [  400.356213]  do_fault+0x977/0x11a0
> [  400.356221]  __handle_mm_fault+0x5d1/0x850
> [  400.356230]  handle_mm_fault+0x1f8/0x560
> [  400.356238]  do_user_addr_fault+0x324/0x970
> [  400.356248]  exc_page_fault+0x76/0xf0
> [  400.356258]  asm_exc_page_fault+0x26/0x30

I get it now, the root cause is that bfqq is freed by
bfq_release_process_ref(), and later bic_set_bfqq() will trigger
above uaf.

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> [  400.356266]
> [  400.356269] The buggy address belongs to the object at ffff88881cab7bc0
>                  which belongs to the cache bfq_queue of size 576
> [  400.356276] The buggy address is located 416 bytes inside of
>                  freed 576-byte region [ffff88881cab7bc0, ffff88881cab7e00)
> [  400.356285]
> [  400.356287] The buggy address belongs to the physical page:
> [  400.356292] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88881cab0b00 pfn:0x81cab0
> [  400.356300] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [  400.356323] flags: 0x50000000000040(head|node=1|zone=2)
> [  400.356331] page_type: f5(slab)
> [  400.356340] raw: 0050000000000040 ffff88880a00c280 dead000000000122 0000000000000000
> [  400.356347] raw: ffff88881cab0b00 00000000802e0025 00000001f5000000 0000000000000000
> [  400.356354] head: 0050000000000040 ffff88880a00c280 dead000000000122 0000000000000000
> [  400.356359] head: ffff88881cab0b00 00000000802e0025 00000001f5000000 0000000000000000
> [  400.356365] head: 0050000000000003 ffffea002072ac01 ffffffffffffffff 0000000000000000
> [  400.356370] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> [  400.356378] page dumped because: kasan: bad access detected
> [  400.356381]
> [  400.356383] Memory state around the buggy address:
> [  400.356387]  ffff88881cab7c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  400.356392]  ffff88881cab7c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  400.356397] >ffff88881cab7d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  400.356400]                                                        ^
> [  400.356405]  ffff88881cab7d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  400.356409]  ffff88881cab7e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [  400.356413] ==================================================================
> 
> Fixes: bc3b1e9e7c50 ("block, bfq: merge bfq_release_process_ref() into bfq_put_cooperator()")
> Signed-off-by: Zach Wade <zachwade.k@gmail.com>
> Cc: Ding Hui <dinghui@sangfor.com.cn>
> ---
>   block/bfq-cgroup.c  | 1 +
>   block/bfq-iosched.c | 6 ++++--
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index e831aedb4643..9fb9f3533150 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -736,6 +736,7 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
>   		 */
>   		bfq_put_cooperator(sync_bfqq);
>   		bic_set_bfqq(bic, NULL, true, act_idx);
> +		bfq_release_process_ref(bfqd, sync_bfqq);
>   	}
>   }
>   
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0747d9d0e48c..28c2bb06e859 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5434,8 +5434,6 @@ void bfq_put_cooperator(struct bfq_queue *bfqq)
>   		bfq_put_queue(__bfqq);
>   		__bfqq = next;
>   	}
> -
> -	bfq_release_process_ref(bfqq->bfqd, bfqq);
>   }
>   
>   static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
> @@ -5448,6 +5446,8 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>   	bfq_log_bfqq(bfqd, bfqq, "exit_bfqq: %p, %d", bfqq, bfqq->ref);
>   
>   	bfq_put_cooperator(bfqq);
> +
> +	bfq_release_process_ref(bfqd, bfqq);
>   }
>   
>   static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync,
> @@ -6734,6 +6734,8 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq)
>   	bic_set_bfqq(bic, NULL, true, bfqq->actuator_idx);
>   
>   	bfq_put_cooperator(bfqq);
> +
> +	bfq_release_process_ref(bfqq->bfqd, bfqq);
>   	return NULL;
>   }
>   
> 



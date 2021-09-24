Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EE9416999
	for <lists+cgroups@lfdr.de>; Fri, 24 Sep 2021 03:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243785AbhIXBvM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Sep 2021 21:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243774AbhIXBvM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Sep 2021 21:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632448179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DL1+kESrk1j8K5IwTf6rhTlHGoskKagkfZx81J+DjeU=;
        b=GfTdN8HunUUtSohKOT5pe56KZBOU9+lJSNUMZUVSzV541bS3Z7u3qrI3RYa3QvyUJu8LcM
        Z0Kr8gXo3IRpWzQPb2MR9aia+3HnPSwqmyCwq21qzF60KHkhA5U0aen82ZTba4nP0C0VBe
        tmTLjh7pe6yB5D9mmMKRqkHiGaZcank=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-mpwajqDfOTa1PG3dsUcorw-1; Thu, 23 Sep 2021 21:49:38 -0400
X-MC-Unique: mpwajqDfOTa1PG3dsUcorw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36E941084684;
        Fri, 24 Sep 2021 01:49:37 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1777F19733;
        Fri, 24 Sep 2021 01:49:29 +0000 (UTC)
Date:   Fri, 24 Sep 2021 09:49:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH 6/6] rq-qos: fix uaf in rq_qos_done_io()
Message-ID: <YU0utuB17kA+wcON@T590>
References: <20210923134631.105719-1-yukuai3@huawei.com>
 <20210923134631.105719-7-yukuai3@huawei.com>
 <YU0epdo2khkNmJTN@T590>
 <a33376ce-6f23-89be-ac77-454b9227b62d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a33376ce-6f23-89be-ac77-454b9227b62d@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 24, 2021 at 09:23:42AM +0800, yukuai (C) wrote:
> On 2021/09/24 8:41, Ming Lei wrote:
> > On Thu, Sep 23, 2021 at 09:46:31PM +0800, Yu Kuai wrote:
> > > our test report a uaf:
> > > 
> > > [  142.925504] ==================================================================
> > > [  142.929084] BUG: KASAN: use-after-free in __rq_qos_done_bio+0x57/0x90
> > > [  142.931131] Read of size 8 at addr ffff88810306d858 by task blkdiscard/858
> > > [  142.933289]
> > > [  142.933798] CPU: 1 PID: 858 Comm: blkdiscard Not tainted 5.15.0-rc1-00004-g18bc2dec41ab-d4
> > > [  142.936580] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_0738364
> > > [  142.939318] Call Trace:
> > > [  142.939662]  ? dump_stack_lvl+0x73/0x9f
> > > [  142.940197]  ? print_address_description.constprop.0+0x2f/0x250
> > > [  142.941004]  ? __rq_qos_done_bio+0x57/0x90
> > > [  142.941564]  ? __rq_qos_done_bio+0x57/0x90
> > > [  142.942132]  ? kasan_report.cold+0x81/0x165
> > > [  142.942710]  ? __rq_qos_done_bio+0x57/0x90
> > > [  142.943282]  ? __asan_load8+0x74/0x110
> > > [  142.943798]  ? __rq_qos_done_bio+0x57/0x90
> > > [  142.944365]  ? bio_endio+0x142/0x430
> > > [  142.944864]  ? submit_bio_checks+0x178/0xef0
> > > [  142.945456]  ? trace_event_raw_event_block_rq_requeue+0x300/0x300
> > > [  142.946283]  ? mempool_alloc+0xe9/0x2f0
> > > [  142.946812]  ? remove_element+0x130/0x130
> > > [  142.947371]  ? init_timer_key+0x83/0x1b0
> > > [  142.947917]  ? submit_bio_noacct+0x86/0x9c0
> > > [  142.948496]  ? blk_queue_enter+0x6d0/0x6d0
> > > [  142.949066]  ? bio_alloc_bioset+0x1b2/0x3a0
> > > [  142.949649]  ? __rcu_read_unlock+0x45/0x370
> > > [  142.950227]  ? bvec_alloc+0x120/0x120
> > > [  142.950732]  ? submit_bio+0x60/0x230
> > > [  142.951230]  ? blk_next_bio+0x4f/0x70
> > > [  142.951740]  ? __blkdev_issue_discard+0x257/0x520
> > > [  142.952387]  ? __blkdev_issue_write_zeroes+0x270/0x270
> > > [  142.953089]  ? bd_abort_claiming+0x70/0x70
> > > [  142.953652]  ? __kasan_check_write+0x20/0x30
> > > [  142.954236]  ? _raw_spin_lock+0xaf/0x130
> > > [  142.954769]  ? _raw_read_lock_bh+0xa0/0xa0
> > > [  142.955328]  ? __get_locked_pte+0x1b3/0x310
> > > [  142.955897]  ? _raw_spin_unlock+0x3b/0x80
> > > [  142.956444]  ? blkdev_issue_discard+0xd3/0x1a0
> > > [  142.957051]  ? blkdev_issue_write_same+0x540/0x540
> > > [  142.957708]  ? _raw_spin_lock+0xaf/0x130
> > > [  142.958244]  ? bd_abort_claiming+0x70/0x70
> > > [  142.958805]  ? wake_up_bit+0x46/0x50
> > > [  142.959302]  ? preempt_count_sub+0x14/0x160
> > > [  142.959877]  ? _raw_spin_unlock+0x3b/0x80
> > > [  142.960428]  ? bd_abort_claiming+0x65/0x70
> > > [  142.960993]  ? blk_ioctl_discard+0x1bd/0x240
> > > [  142.961582]  ? blkdev_bszset+0x1c0/0x1c0
> > > [  142.962118]  ? special_mapping_fault+0x6f/0x200
> > > [  142.962743]  ? __do_fault+0x80/0x410
> > > [  142.963241]  ? blkdev_common_ioctl+0x6c9/0x1190
> > > [  142.963877]  ? ioctl_file_clone+0x110/0x110
> > > [  142.964457]  ? blk_ioctl_discard+0x240/0x240
> > > [  142.965038]  ? copy_page_range+0x2b60/0x2b60
> > > [  142.965623]  ? vfs_getattr_nosec+0x177/0x190
> > > [  142.966214]  ? __ia32_compat_sys_newfstat+0x40/0x40
> > > [  142.966885]  ? blkdev_ioctl+0x180/0x4b0
> > > [  142.967409]  ? blkdev_common_ioctl+0x1190/0x1190
> > > [  142.968033]  ? handle_mm_fault+0x3c2/0x660
> > > [  142.968590]  ? __kasan_check_write+0x20/0x30
> > > [  142.969172]  ? block_ioctl+0x7d/0xa0
> > > [  142.969666]  ? __x64_sys_ioctl+0xd5/0x150
> > > [  142.970224]  ? do_syscall_64+0x35/0x80
> > > [  142.970733]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [  142.971441]
> > > [  142.971653] Allocated by task 283:
> > > [  142.972117]  kasan_save_stack+0x23/0x60
> > > [  142.972637]  set_alloc_info+0x46/0x70
> > > [  142.973136]  __kasan_kmalloc+0x8d/0xd0
> > > [  142.973639]  kmem_cache_alloc_trace+0x3e7/0x820
> > > [  142.974254]  wbt_init+0x40/0x430
> > > [  142.974694]  wbt_enable_default+0xbb/0x100
> > > [  142.975248]  blk_register_queue+0x216/0x3e0
> > > [  142.975812]  device_add_disk+0x4ac/0x880
> > > [  142.976358]  sd_probe+0x690/0x910
> > > [  142.976809]  really_probe+0x5c3/0x800
> > > [  142.977306]  __driver_probe_device+0x233/0x330
> > > [  142.977907]  driver_probe_device+0x69/0x140
> > > [  142.978466]  __device_attach_driver+0x125/0x210
> > > [  142.979081]  bus_for_each_drv+0x10e/0x1b0
> > > [  142.979615]  __device_attach_async_helper+0x175/0x230
> > > [  142.980302]  async_run_entry_fn+0x7b/0x310
> > > [  142.980859]  process_one_work+0x46a/0xa80
> > > [  142.981400]  worker_thread+0x33d/0x8d0
> > > [  142.981917]  kthread+0x282/0x300
> > > [  142.982363]  ret_from_fork+0x1f/0x30
> > > [  142.982862]
> > > [  142.983077] Freed by task 863:
> > > [  142.983501]  kasan_save_stack+0x23/0x60
> > > [  142.984029]  kasan_set_track+0x24/0x40
> > > [  142.984547]  kasan_set_free_info+0x30/0x60
> > > [  142.985115]  __kasan_slab_free+0x137/0x210
> > > [  142.985678]  kfree+0x10b/0x570
> > > [  142.986106]  wbt_exit+0x68/0x80
> > > [  142.986535]  rq_qos_exit+0x5f/0x80
> > > [  142.987002]  blk_cleanup_queue+0xdb/0x250
> > > [  142.987546]  __scsi_remove_device+0xb1/0x2e0
> > > [  142.988131]  scsi_remove_device+0x38/0x60
> > > [  142.988676]  sdev_store_delete+0x73/0x100
> > > [  142.989230]  dev_attr_store+0x40/0x70
> > > [  142.989730]  sysfs_kf_write+0x89/0xc0
> > > [  142.990233]  kernfs_fop_write_iter+0x21d/0x340
> > > [  142.990839]  new_sync_write+0x27e/0x3a0
> > > [  142.991362]  vfs_write+0x46e/0x630
> > > [  142.991834]  ksys_write+0xcd/0x1e0
> > > [  142.992300]  __x64_sys_write+0x46/0x60
> > > [  142.992814]  do_syscall_64+0x35/0x80
> > > [  142.993311]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [  142.994213] The buggy address belongs to the object at ffff88810306d800
> > > [  142.994213]  which belongs to the cache kmalloc-256 of size 256
> > > [  142.995889] The buggy address is located 88 bytes inside of
> > > [  142.995889]  256-byte region [ffff88810306d800, ffff88810306d900)
> > > [  142.997448] The buggy address belongs to the page:
> > > [  142.998102] page:0000000069471149 refcount:1 mapcount:0 mapping:0000000000000000 index:0xc
> > > [  142.999372] head:0000000069471149 order:2 compound_mapcount:0 compound_pincount:0
> > > [  143.000375] flags: 0x2fffff80010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> > > [  143.001403] raw: 002fffff80010200 0000000000000000 0000000100000001 ffff88810004cb40
> > > [  143.002455] raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
> > > [  143.003477] page dumped because: kasan: bad access detected
> > > [  143.004222]
> > > [  143.004433] Memory state around the buggy address:
> > > [  143.005077]  ffff88810306d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > [  143.006040]  ffff88810306d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > [  143.007012] >ffff88810306d800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > [  143.007981]                                                     ^
> > > [  143.008795]  ffff88810306d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > [  143.009764]  ffff88810306d900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > [  143.010731] ==================================================================
> > > 
> > > This is because 'q_usage_counter' will not hold when bio_endio() is
> > > called from error path, thus bio_endio() can concurrent with
> > > blk_cleanup_queue():
> > 
> > What is the exact error path? We actually grabs one ref of q_usage_counter
> > during submitting bio, so the issue should have been fixed by not
> > releasing the refcount early in the error path? Or the refcnt isn't grabbed
> > yet when handling the error?
> > 
> 
> Hi,
> 
> We found at least two places:
> 
> The first is error path from submit_bio_checks(), and we succeed to
> construct repoducer here.
> 
> The second is from bio_queue_enter(), bio_endio() will be called if
> blk_queue_enter() failed.

OK, both should be addressed by the following simple patch:


diff --git a/block/bio.c b/block/bio.c
index 5df3dd282e40..a6fb6a0b4295 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1466,7 +1466,7 @@ void bio_endio(struct bio *bio)
 	if (!bio_integrity_endio(bio))
 		return;
 
-	if (bio->bi_bdev)
+	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACKED))
 		rq_qos_done_bio(bio->bi_bdev->bd_disk->queue, bio);
 
 	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION)) {

-- 
Ming


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7357123DC
	for <lists+cgroups@lfdr.de>; Fri, 26 May 2023 11:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243250AbjEZJjU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 May 2023 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242719AbjEZJiy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 May 2023 05:38:54 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B510D1;
        Fri, 26 May 2023 02:38:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QSKbl2h7sz4f403M;
        Fri, 26 May 2023 17:38:11 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rECfnBk1Jn9KA--.30169S3;
        Fri, 26 May 2023 17:38:12 +0800 (CST)
Subject: Re: [PATCH -next v2 6/6] blk-sysfs: add a new attr_group for blk_mq
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk
Cc:     lukas.bulwahn@gmail.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230512093554.911753-1-yukuai1@huaweicloud.com>
 <20230512093554.911753-7-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8cafbd02-182a-4071-7e04-cc6f96045852@huaweicloud.com>
Date:   Fri, 26 May 2023 17:38:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230512093554.911753-7-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rECfnBk1Jn9KA--.30169S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF47tw4rGF1fKrW8ZFyxKrg_yoWrAF4kpF
        4DAFy8Zw10q3y7GayxJw4UXwsa9ryF9r43Xr97Kwn2kF12qw4fWryjy34UXrWxArWkWw43
        ZF4DtrZ8ArZ3ZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, Christoph

ÔÚ 2023/05/12 17:35, Yu Kuai Ð´µÀ:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently wbt sysfs entry is created for bio based device, and wbt can
> be enabled for such device through sysfs while it doesn't make sense
> because wbt can only work for rq based device. In the meantime, there
> are other similar sysfs entries.
> 
> Fix this by adding a new attr_group for blk_mq, and sysfs entries will
> only be created when the device is rq based.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Any comments about this patch?

Thanks,
Kuai
> ---
>   block/blk-sysfs.c | 42 +++++++++++++++++++++++++++++++-----------
>   1 file changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 6c1c4ba66bc0..afc797fb0dfc 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -621,7 +621,6 @@ QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
>   #endif
>   
>   static struct attribute *queue_attrs[] = {
> -	&queue_requests_entry.attr,
>   	&queue_ra_entry.attr,
>   	&queue_max_hw_sectors_entry.attr,
>   	&queue_max_sectors_entry.attr,
> @@ -629,7 +628,6 @@ static struct attribute *queue_attrs[] = {
>   	&queue_max_discard_segments_entry.attr,
>   	&queue_max_integrity_segments_entry.attr,
>   	&queue_max_segment_size_entry.attr,
> -	&elv_iosched_entry.attr,
>   	&queue_hw_sector_size_entry.attr,
>   	&queue_logical_block_size_entry.attr,
>   	&queue_physical_block_size_entry.attr,
> @@ -650,7 +648,6 @@ static struct attribute *queue_attrs[] = {
>   	&queue_max_open_zones_entry.attr,
>   	&queue_max_active_zones_entry.attr,
>   	&queue_nomerges_entry.attr,
> -	&queue_rq_affinity_entry.attr,
>   	&queue_iostats_entry.attr,
>   	&queue_stable_writes_entry.attr,
>   	&queue_random_entry.attr,
> @@ -658,11 +655,7 @@ static struct attribute *queue_attrs[] = {
>   	&queue_wc_entry.attr,
>   	&queue_fua_entry.attr,
>   	&queue_dax_entry.attr,
> -#ifdef CONFIG_BLK_WBT
> -	&queue_wb_lat_entry.attr,
> -#endif
>   	&queue_poll_delay_entry.attr,
> -	&queue_io_timeout_entry.attr,
>   #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>   	&blk_throtl_sample_time_entry.attr,
>   #endif
> @@ -671,16 +664,23 @@ static struct attribute *queue_attrs[] = {
>   	NULL,
>   };
>   
> +static struct attribute *blk_mq_queue_attrs[] = {
> +	&queue_requests_entry.attr,
> +	&elv_iosched_entry.attr,
> +	&queue_rq_affinity_entry.attr,
> +	&queue_io_timeout_entry.attr,
> +#ifdef CONFIG_BLK_WBT
> +	&queue_wb_lat_entry.attr,
> +#endif
> +	NULL,
> +};
> +
>   static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
>   				int n)
>   {
>   	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
>   	struct request_queue *q = disk->queue;
>   
> -	if (attr == &queue_io_timeout_entry.attr &&
> -		(!q->mq_ops || !q->mq_ops->timeout))
> -			return 0;
> -
>   	if ((attr == &queue_max_open_zones_entry.attr ||
>   	     attr == &queue_max_active_zones_entry.attr) &&
>   	    !blk_queue_is_zoned(q))
> @@ -689,11 +689,30 @@ static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
>   	return attr->mode;
>   }
>   
> +static umode_t blk_mq_queue_attr_visible(struct kobject *kobj,
> +					 struct attribute *attr, int n)
> +{
> +	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
> +	struct request_queue *q = disk->queue;
> +
> +	if (!queue_is_mq(q))
> +		return 0;
> +
> +	if (attr == &queue_io_timeout_entry.attr && !q->mq_ops->timeout)
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
>   static struct attribute_group queue_attr_group = {
>   	.attrs = queue_attrs,
>   	.is_visible = queue_attr_visible,
>   };
>   
> +static struct attribute_group blk_mq_queue_attr_group = {
> +	.attrs = blk_mq_queue_attrs,
> +	.is_visible = blk_mq_queue_attr_visible,
> +};
>   
>   #define to_queue(atr) container_of((atr), struct queue_sysfs_entry, attr)
>   
> @@ -738,6 +757,7 @@ static const struct sysfs_ops queue_sysfs_ops = {
>   
>   static const struct attribute_group *blk_queue_attr_groups[] = {
>   	&queue_attr_group,
> +	&blk_mq_queue_attr_group,
>   	NULL
>   };
>   
> 


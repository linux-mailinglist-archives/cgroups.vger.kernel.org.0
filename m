Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8EB562CD3
	for <lists+cgroups@lfdr.de>; Fri,  1 Jul 2022 09:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiGAHjm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Jul 2022 03:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiGAHjm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Jul 2022 03:39:42 -0400
X-Greylist: delayed 175 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Jul 2022 00:39:39 PDT
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5971409D;
        Fri,  1 Jul 2022 00:39:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LZ6Wr2ln6zKHsB;
        Fri,  1 Jul 2022 15:38:48 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgB32mm3pL5ivND3AA--.34284S3;
        Fri, 01 Jul 2022 15:39:37 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: fix io hung due to config updates
To:     Yu Kuai <yukuai3@huawei.com>, tj@kernel.org, mkoutny@suse.com,
        axboe@kernel.dk, ming.lei@redhat.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220701074923.657426-1-yukuai3@huawei.com>
 <20220701074923.657426-2-yukuai3@huawei.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <028fe809-3902-059f-586e-a3119ea63891@huaweicloud.com>
Date:   Fri, 1 Jul 2022 15:39:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220701074923.657426-2-yukuai3@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgB32mm3pL5ivND3AA--.34284S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4kZryUAFy8Jr4UJFW3GFg_yoWxury7pr
        W8AF4jqa1Yq3WSgFsxXwnIyFWFvws7ZFy3Jw43G3WrCFs8Wr1ktr1DZrW5tay8AF97ua1x
        ZwnFqF9IkF4jvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
        CF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1E1v3UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/07/01 15:49, Yu Kuai wrote:

Please ignore this patch, it's been sent by mistake.

Kuai

> If new configuration is submitted while a bio is throttled, then new
> waiting time is recalculated regardless that the bio might aready wait
> for some time:
>
> tg_conf_updated
>   throtl_start_new_slice
>    tg_update_disptime
>    throtl_schedule_next_dispatch
>
> Then io hung can be triggered by always submmiting new configuration
> before the throttled bio is dispatched.
>
> Fix the problem by respecting the time that throttled bio aready waited.
> In order to do that, add new fields to record how many bytes/io already
> waited, and use it to calculate wait time for throttled bio under new
> configuration.
>
> Some simple test:
> 1)
> cd /sys/fs/cgroup/blkio/
> echo $$ > cgroup.procs
> echo "8:0 2048" > blkio.throttle.write_bps_device
> {
>          sleep 2
>          echo "8:0 1024" > blkio.throttle.write_bps_device
> } &
> dd if=/dev/zero of=/dev/sda bs=8k count=1 oflag=direct
>
> 2)
> cd /sys/fs/cgroup/blkio/
> echo $$ > cgroup.procs
> echo "8:0 1024" > blkio.throttle.write_bps_device
> {
>          sleep 4
>          echo "8:0 2048" > blkio.throttle.write_bps_device
> } &
> dd if=/dev/zero of=/dev/sda bs=8k count=1 oflag=direct
>
> test results: io finish time
> 	before this patch	with this patch
> 1)	10s			6s
> 2)	8s			6s
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/blk-throttle.c | 51 ++++++++++++++++++++++++++++++++++++++------
>   block/blk-throttle.h |  9 ++++++++
>   2 files changed, 54 insertions(+), 6 deletions(-)
>
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 8612a071305e..8178ef278e7a 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -639,6 +639,8 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
>   {
>   	tg->bytes_disp[rw] = 0;
>   	tg->io_disp[rw] = 0;
> +	tg->bytes_skipped[rw] = 0;
> +	tg->io_skipped[rw] = 0;
>   
>   	/*
>   	 * Previous slice has expired. We must have trimmed it after last
> @@ -656,12 +658,17 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
>   		   tg->slice_end[rw], jiffies);
>   }
>   
> -static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw)
> +static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw,
> +					  bool clear_skipped)
>   {
>   	tg->bytes_disp[rw] = 0;
>   	tg->io_disp[rw] = 0;
>   	tg->slice_start[rw] = jiffies;
>   	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
> +	if (clear_skipped) {
> +		tg->bytes_skipped[rw] = 0;
> +		tg->io_skipped[rw] = 0;
> +	}
>   
>   	throtl_log(&tg->service_queue,
>   		   "[%c] new slice start=%lu end=%lu jiffies=%lu",
> @@ -783,6 +790,34 @@ static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
>   	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
>   }
>   
> +static void __tg_update_skipped(struct throtl_grp *tg, bool rw)
> +{
> +	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
> +	u64 bps_limit = tg_bps_limit(tg, rw);
> +	u32 iops_limit = tg_iops_limit(tg, rw);
> +
> +	if (bps_limit != U64_MAX)
> +		tg->bytes_skipped[rw] +=
> +			calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
> +			tg->bytes_disp[rw];
> +	if (iops_limit != UINT_MAX)
> +		tg->io_skipped[rw] +=
> +			calculate_io_allowed(iops_limit, jiffy_elapsed) -
> +			tg->io_disp[rw];
> +}
> +
> +static void tg_update_skipped(struct throtl_grp *tg)
> +{
> +	if (tg->service_queue.nr_queued[READ])
> +		__tg_update_skipped(tg, READ);
> +	if (tg->service_queue.nr_queued[WRITE])
> +		__tg_update_skipped(tg, WRITE);
> +
> +	throtl_log(&tg->service_queue, "%s: %llu %llu %u %u\n", __func__,
> +		   tg->bytes_skipped[READ], tg->bytes_skipped[WRITE],
> +		   tg->io_skipped[READ], tg->io_skipped[WRITE]);
> +}
> +
>   static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
>   				  u32 iops_limit, unsigned long *wait)
>   {
> @@ -800,7 +835,8 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
>   
>   	/* Round up to the next throttle slice, wait time must be nonzero */
>   	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
> -	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd);
> +	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd) +
> +		     tg->io_skipped[rw];
>   	if (tg->io_disp[rw] + 1 <= io_allowed) {
>   		if (wait)
>   			*wait = 0;
> @@ -837,7 +873,8 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
>   		jiffy_elapsed_rnd = tg->td->throtl_slice;
>   
>   	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
> -	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
> +	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd) +
> +			tg->bytes_skipped[rw];
>   	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed) {
>   		if (wait)
>   			*wait = 0;
> @@ -898,7 +935,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>   	 * slice and it should be extended instead.
>   	 */
>   	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
> -		throtl_start_new_slice(tg, rw);
> +		throtl_start_new_slice(tg, rw, true);
>   	else {
>   		if (time_before(tg->slice_end[rw],
>   		    jiffies + tg->td->throtl_slice))
> @@ -1327,8 +1364,8 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
>   	 * that a group's limit are dropped suddenly and we don't want to
>   	 * account recently dispatched IO with new low rate.
>   	 */
> -	throtl_start_new_slice(tg, READ);
> -	throtl_start_new_slice(tg, WRITE);
> +	throtl_start_new_slice(tg, READ, false);
> +	throtl_start_new_slice(tg, WRITE, false);
>   
>   	if (tg->flags & THROTL_TG_PENDING) {
>   		tg_update_disptime(tg);
> @@ -1356,6 +1393,7 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
>   		v = U64_MAX;
>   
>   	tg = blkg_to_tg(ctx.blkg);
> +	tg_update_skipped(tg);
>   
>   	if (is_u64)
>   		*(u64 *)((void *)tg + of_cft(of)->private) = v;
> @@ -1542,6 +1580,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
>   		return ret;
>   
>   	tg = blkg_to_tg(ctx.blkg);
> +	tg_update_skipped(tg);
>   
>   	v[0] = tg->bps_conf[READ][index];
>   	v[1] = tg->bps_conf[WRITE][index];
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index c1b602996127..371d624af845 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -115,6 +115,15 @@ struct throtl_grp {
>   	uint64_t bytes_disp[2];
>   	/* Number of bio's dispatched in current slice */
>   	unsigned int io_disp[2];
> +	/*
> +	 * The following two fields are used to calculate new wait time for
> +	 * throttled bio when new configuration is submmited.
> +	 *
> +	 * Number of bytes will be skipped in current slice
> +	 */
> +	uint64_t bytes_skipped[2];
> +	/* Number of bio will be skipped in current slice */
> +	unsigned int io_skipped[2];
>   
>   	unsigned long last_low_overflow_time[2];
>   


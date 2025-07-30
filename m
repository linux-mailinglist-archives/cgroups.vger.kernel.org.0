Return-Path: <cgroups+bounces-8942-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 974D9B16642
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 20:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1148D1AA789D
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165CE27A93D;
	Wed, 30 Jul 2025 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lyq4mJKF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5B6198E9B;
	Wed, 30 Jul 2025 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900211; cv=none; b=KNbrnWNKFhzmNe4cPP2+0ki2CiEoWAbkOy1oEabrY2omlgJs0T7Q60EmtN8tOBXI3Z/bLP+b48P6MKXAG/fD75vK8n8j5xBHDpxSg4YhjbpvFtgmrdAPaHM6LYAZLtGAcHE81pNMXOYE0K6j2j0qX4KTHbTFeUdn9s+YkUtBdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900211; c=relaxed/simple;
	bh=mBBE1GbJZP5xEjvANSJFvb0+ELOI64V2uh/Mm6Ose5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHxkA1+6JkdahruYwKwa5cvnfpB9bHhR/QFcNzCTeRdBE0c039Xa1l5x6ir3Am8QngzqLZrZwR64H1Tu62+7x0Ojg2wtrXOqCdq8SJ65O0I5h5vW5uVfi+sM2UPGP9D044zh/e93BbJ/UAM9IeoN131RMoGJDlWm0lkhmt0ujUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lyq4mJKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00DDC4CEE3;
	Wed, 30 Jul 2025 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753900211;
	bh=mBBE1GbJZP5xEjvANSJFvb0+ELOI64V2uh/Mm6Ose5s=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lyq4mJKFhlvgMGrX0pzGrOkKsrdfH31ADKVpDosbvsODa5ciQV7k/0oyxkuSxcyWk
	 dSO8Q9BvnrznwMpCmI6/aESJ6Y4O29DAIPj2mykiscqzeDab3IK3LohY/GMidDznZg
	 1QQSyDinx56n5e8VZ8Du//yeTA0gtjkYRp7F25R8CuE6Tu50LnevxpRB3fGwgF+u6X
	 PGTLXipzGETt245JTeGiky63c8Oa5AANqXqkJ3fGO5KvTQxHgGR4zx5Rj/8GwqoXcu
	 9rXLDZYB3TxajUtSL2VPEPrxZsj9z6P1GKyI0x65TuEDkdcV8RJlXG0C3gPQ0OoAlp
	 2uHWmxPl29Jiw==
Message-ID: <1a1fe348-9ae5-4f3e-be9e-19fa88af513c@kernel.org>
Date: Thu, 31 Jul 2025 02:30:05 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH 1/2] block/blk-throttle: Fix throttle slice time for SSDs
To: Guenter Roeck <linux@roeck-us.net>, Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
 Yu Kuai <yukuai3@huawei.com>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730164832.1468375-1-linux@roeck-us.net>
 <20250730164832.1468375-2-linux@roeck-us.net>
Content-Language: en-US
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <20250730164832.1468375-2-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/7/31 0:48, Guenter Roeck 写道:
> Commit d61fcfa4bb18 ("blk-throttle: choose a small throtl_slice for SSD")
> introduced device type specific throttle slices if BLK_DEV_THROTTLING_LOW
> was enabled. Commit bf20ab538c81 ("blk-throttle: remove
> CONFIG_BLK_DEV_THROTTLING_LOW") removed support for BLK_DEV_THROTTLING_LOW,
> but left the device type specific throttle slices in place. This
> effectively changed throttling behavior on systems with SSD which now use
> a different and non-configurable slice time compared to non-SSD devices.
> Practical impact is that throughput tests with low configured throttle
> values (65536 bps) experience less than expected throughput on SSDs,
> presumably due to rounding errors associated with the small throttle slice
> time used for those devices. The same tests pass when setting the throttle
> values to 65536 * 4 = 262144 bps.
>
> The original code sets the throttle slice time to DFL_THROTL_SLICE_HD if
> CONFIG_BLK_DEV_THROTTLING_LOW is disabled. Restore that code to fix the
> problem. With that, DFL_THROTL_SLICE_SSD is no longer necessary. Revert to
> the original code and re-introduce DFL_THROTL_SLICE to replace both
> DFL_THROTL_SLICE_HD and DFL_THROTL_SLICE_SSD. This effectively reverts
> commit d61fcfa4bb18 ("blk-throttle: choose a small throtl_slice for SSD").
>
> After the removal of CONFIG_BLK_DEV_THROTTLING_LOW, it is no longer
> necessary to enable block accounting, so remove the call to
> blk_stat_enable_accounting(). With that, the track_bio_latency variable
> is no longer used and can be deleted from struct throtl_data. Also,
> including blk-stat.h is no longer necessary.
>
> While at it, also remove MAX_THROTL_SLICE since it is not used anymore.
>
> Fixes: bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
> Cc: Yu Kuai <yukuai3@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   block/blk-throttle.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 397b6a410f9e..924d09b51b69 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -12,7 +12,6 @@
>   #include <linux/blktrace_api.h>
>   #include "blk.h"
>   #include "blk-cgroup-rwstat.h"
> -#include "blk-stat.h"
>   #include "blk-throttle.h"
>   
>   /* Max dispatch from a group in 1 round */
> @@ -22,9 +21,7 @@
>   #define THROTL_QUANTUM 32
>   
>   /* Throttling is performed over a slice and after that slice is renewed */
> -#define DFL_THROTL_SLICE_HD (HZ / 10)
> -#define DFL_THROTL_SLICE_SSD (HZ / 50)
> -#define MAX_THROTL_SLICE (HZ)
> +#define DFL_THROTL_SLICE (HZ / 10)
>   
>   /* A workqueue to queue throttle related work */
>   static struct workqueue_struct *kthrotld_workqueue;
> @@ -45,8 +42,6 @@ struct throtl_data
>   
>   	/* Work for dispatching throttled bios */
>   	struct work_struct dispatch_work;
> -
> -	bool track_bio_latency;
>   };
>   
>   static void throtl_pending_timer_fn(struct timer_list *t);
> @@ -1345,13 +1340,7 @@ static int blk_throtl_init(struct gendisk *disk)
>   		goto out;
>   	}
>   
> -	if (blk_queue_nonrot(q))
> -		td->throtl_slice = DFL_THROTL_SLICE_SSD;
> -	else
> -		td->throtl_slice = DFL_THROTL_SLICE_HD;
> -	td->track_bio_latency = !queue_is_mq(q);
> -	if (!td->track_bio_latency)
> -		blk_stat_enable_accounting(q);
> +	td->throtl_slice = DFL_THROTL_SLICE;
>   
>   out:
>   	blk_mq_unquiesce_queue(disk->queue);
This looks correct, I do missed the throtl_slice for ssd is only used with
BLK_DEV_THROTTLING_LOW. However, I think it's better to factor the
track_bio_latency changes into a separate patch.

Thanks,
Kuai


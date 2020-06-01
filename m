Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98D31EA73A
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2020 17:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFAPn5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Jun 2020 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPn4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Jun 2020 11:43:56 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56459C05BD43;
        Mon,  1 Jun 2020 08:43:55 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k22so8010413qtm.6;
        Mon, 01 Jun 2020 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G2ppN+SO01U35andcJx4wK7uE7Y/yhFiQ+1V3mTLz5k=;
        b=g9LHrVyOk4LXkO1djAdvgd7CoGtQeMTrsqvothE6BTPFJHbZe1UYxFWaj2XyM5+u2v
         mIzUJNAuuxFS1k6lMjA0i5s4/9jM45hbiIf8z0Dygga25k5k+7D6d43ZbgDv61GZdkPh
         vtRTrhph/+vvVXh6nvvH+GMtH5KdVjeQ4IMvg4ZWEu6I8tvl7HMF0VBK9vUfvMOEtC1T
         ePkoMQeqZDC5D6jatZ0EUQgWuhwlYGRn+qhPlayT98/jFKvUdkeIJQQSSs5ZuvYtZDk3
         ZGD5JVvRxwXieZvNhlpPZ9Dq0UEmyVz4cRGWwiGy4h/S27RV5TUM1ECVgCN1RejuUZcC
         S2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=G2ppN+SO01U35andcJx4wK7uE7Y/yhFiQ+1V3mTLz5k=;
        b=MObsS8hEysDZU4yvVP1/Xn1fUJier66htWgTaqi1EgPc5owkgEAvMg+ZeOVM6Bhvdx
         Z5mzcvONSJWPH7WtNer6S2IF8qTcQj0PoXgY51ASwrZU/2kdAyBkxem9Ft/mDpidjNT1
         Bcen3dnMyrKy42uQQPory8Wzrg8nRgCUqi2TuVZ7njlrtjmK/ZCajXdy+9a6r2dO25jQ
         x+V6B9s+zEIhv+nfHwoRlar0MoF0okpmeCTK2i/8zVrU654XGGCywT32qEYAiVqPBT0L
         xEWtuasXMaxWlIdYSEsVGsih9ojO/iUBJxcQUSwqIouAc6wqAlOu5D9KpPeax3rOq+9a
         jR5w==
X-Gm-Message-State: AOAM530P/hGqzsqtmBiemIXPfVrcJqliyRhtKNeLtc2R9ZzFWxo9ke2s
        hCR9CblDgn8hc/6rtbWIYvjtlBJQ
X-Google-Smtp-Source: ABdhPJydDc8pxC/hzfQQ5LLSzEsme2ZF1n790P7xvYsqHZEpPm8tvZgc/1nkS1CWxoo8SriQV8AQ0g==
X-Received: by 2002:ac8:221a:: with SMTP id o26mr9593551qto.88.1591026234387;
        Mon, 01 Jun 2020 08:43:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:eb8b])
        by smtp.gmail.com with ESMTPSA id k43sm18081584qtk.67.2020.06.01.08.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:43:53 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:43:51 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH blk-cgroup/for-5.8] blk-cgroup: show global disk stats in
 root cgroup io.stat
Message-ID: <20200601154351.GD31548@mtj.thefacebook.com>
References: <20200529232017.1795920-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529232017.1795920-1-boris@bur.io>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Boris.

On Fri, May 29, 2020 at 04:20:17PM -0700, Boris Burkov wrote:
> In order to improve consistency and usability in cgroup stat accounting,
> we would like to support the root cgroup's io.stat.
> 
> Since the root cgroup has processes doing io even if the system has no
> explicitly created cgroups, we need to be careful to avoid overhead in
> that case.  For that reason, the rstat algorithms don't handle the root
> cgroup, so just turning the file on wouldn't give correct statistics.
> 
> To get around this, we simulate flushing the iostat struct by filling it
> out directly from global disk stats. The result is a root cgroup io.stat
> file consistent with both /proc/diskstats and io.stat.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> Suggested-by: Tejun Heo <tj@kernel.org>
...
> +static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
> +{

Can you please separate out code reorganization to a separate patch so that
the actual change can be reviewed clearly?

> +/*
> + * The rstat algorithms intentionally don't handle the root cgroup to avoid
> + * incurring overhead when no cgroups are defined. For that reason,
> + * cgroup_rstat_flush in blkcg_print_stat does not actually fill out the
> + * iostat in the root cgroup's blkcg_gq.
> + *
> + * However, we would like to re-use the printing code between the root and
> + * non-root cgroups to the extent possible. For that reason, we simulate
> + * flushing the root cgroup's stats by explicitly filling in the iostat
> + * with disk level statistics.
> + */

This is clever and neat.

> +static void blkcg_fill_root_iostats(void)
> +{
> +	struct class_dev_iter iter;
> +	struct device *dev;
> +
> +	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
> +	while ((dev = class_dev_iter_next(&iter))) {
> +		struct gendisk *disk = dev_to_disk(dev);
> +		struct hd_struct *part = disk_get_part(disk, 0);
> +		struct blkcg_gq *blkg = blk_queue_root_blkg(disk->queue);
> +		struct blkg_iostat tmp;
> +		int cpu;
> +
> +		memset(&tmp, 0, sizeof(tmp));
> +		for_each_possible_cpu(cpu) {
> +			struct disk_stats *cpu_dkstats;
> +
> +			cpu_dkstats = per_cpu_ptr(part->dkstats, cpu);
> +			tmp.ios[BLKG_IOSTAT_READ] +=
> +				cpu_dkstats->ios[STAT_READ];
> +			tmp.ios[BLKG_IOSTAT_WRITE] +=
> +				cpu_dkstats->ios[STAT_WRITE];
> +			tmp.ios[BLKG_IOSTAT_DISCARD] +=
> +				cpu_dkstats->ios[STAT_DISCARD];
> +			// convert sectors to bytes
> +			tmp.bytes[BLKG_IOSTAT_READ] +=
> +				cpu_dkstats->sectors[STAT_READ] << 9;
> +			tmp.bytes[BLKG_IOSTAT_WRITE] +=
> +				cpu_dkstats->sectors[STAT_WRITE] << 9;
> +			tmp.bytes[BLKG_IOSTAT_DISCARD] +=
> +				cpu_dkstats->sectors[STAT_DISCARD] << 9;
> +
> +			u64_stats_update_begin(&blkg->iostat.sync);
> +			blkg_iostat_set(&blkg->iostat.cur, &tmp);
> +			u64_stats_update_end(&blkg->iostat.sync);
> +		}
> +	}
> +}
...
> diff --git a/block/genhd.c b/block/genhd.c
> index afdb2c3e5b22..4f5f4590517c 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -38,8 +38,6 @@ static struct kobject *block_depr;
>  static DEFINE_SPINLOCK(ext_devt_lock);
>  static DEFINE_IDR(ext_devt_idr);
>  
> -static const struct device_type disk_type;
> -
>  static void disk_check_events(struct disk_events *ev,
>  			      unsigned int *clearing_ptr);
>  static void disk_alloc_events(struct gendisk *disk);
> @@ -1566,7 +1564,7 @@ static char *block_devnode(struct device *dev, umode_t *mode,
>  	return NULL;
>  }
>  
> -static const struct device_type disk_type = {
> +const struct device_type disk_type = {
>  	.name		= "disk",
>  	.groups		= disk_attr_groups,
>  	.release	= disk_release,
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index a9384449465a..ea38bc36bc6d 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -26,6 +26,7 @@
>  #define disk_to_dev(disk)	(&(disk)->part0.__dev)
>  #define part_to_dev(part)	(&((part)->__dev))
>  
> +extern const struct device_type disk_type;

So, this is fine but I'd explicitly mention it in the patch description.

Thanks.

-- 
tejun

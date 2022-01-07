Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5554874A7
	for <lists+cgroups@lfdr.de>; Fri,  7 Jan 2022 10:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiAGJ2v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jan 2022 04:28:51 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106]:35294 "EHLO
        proxmox-new.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiAGJ2v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jan 2022 04:28:51 -0500
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jan 2022 04:28:51 EST
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
        by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7707146BF2;
        Fri,  7 Jan 2022 10:20:25 +0100 (CET)
Date:   Fri, 7 Jan 2022 10:20:23 +0100
From:   Wolfgang Bumiller <w.bumiller@proxmox.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, tj@kernel.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-cgroup: stop using seq_get_buf
Message-ID: <20220107092023.iaz57fai5kj47fqf@olga.proxmox.com>
References: <20210810152623.1796144-1-hch@lst.de>
 <20210810152623.1796144-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810152623.1796144-2-hch@lst.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Sorry for the late noise, but now when there are no stats, the name has
still been printed out without adding a new line, which doesn't seem to
be inline with the documented 'nested keyed' file format.

in particular, I'm now seeing this line with 2 keys:

    253:10 253:5 rbytes=0 wbytes=0 rios=0 wios=1 dbytes=0 dios=0
    ^~~~~~ ^~~~~

I'm not sure if a separate temporary buffer would make more sense or
switching back to seq_get_buf?
Figuring out `has_stats` first doesn't seem to be trivial due to the
`pd_stat_fn` calls.

Or of course, just include the newlines unconditionally?

Unless seq_file has/gets another way to roll back the buffer?

On Tue, Aug 10, 2021 at 05:26:23PM +0200, Christoph Hellwig wrote:
> seq_get_buf is a crutch that undoes all the memory safety of the
> seq_file interface.  Use the normal seq_printf interfaces instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c         | 30 ++++++------------------------
>  block/blk-iocost.c         | 23 +++++++++--------------
>  block/blk-iolatency.c      | 38 +++++++++++++++++++-------------------
>  block/mq-deadline-cgroup.c |  8 +++-----
>  include/linux/blk-cgroup.h |  4 ++--
>  5 files changed, 39 insertions(+), 64 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 52aa0540ccaf..b8ec47dcce42 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -877,8 +877,6 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
>  	bool has_stats = false;
>  	const char *dname;
>  	unsigned seq;
> -	char *buf;
> -	size_t size = seq_get_buf(s, &buf), off = 0;
>  	int i;
>  
>  	if (!blkg->online)
> @@ -888,13 +886,7 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
>  	if (!dname)
>  		return;
>  
> -	/*
> -	 * Hooray string manipulation, count is the size written NOT
> -	 * INCLUDING THE \0, so size is now count+1 less than what we
> -	 * had before, but we want to start writing the next bit from
> -	 * the \0 so we only add count to buf.
> -	 */
> -	off += scnprintf(buf+off, size-off, "%s ", dname);
> +	seq_printf(s, "%s ", dname);
>  
>  	do {
>  		seq = u64_stats_fetch_begin(&bis->sync);
> @@ -909,40 +901,30 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
>  
>  	if (rbytes || wbytes || rios || wios) {
>  		has_stats = true;
> -		off += scnprintf(buf+off, size-off,
> -			"rbytes=%llu wbytes=%llu rios=%llu wios=%llu dbytes=%llu dios=%llu",
> +		seq_printf(s, "rbytes=%llu wbytes=%llu rios=%llu wios=%llu dbytes=%llu dios=%llu",
>  			rbytes, wbytes, rios, wios,
>  			dbytes, dios);
>  	}
>  
>  	if (blkcg_debug_stats && atomic_read(&blkg->use_delay)) {
>  		has_stats = true;
> -		off += scnprintf(buf+off, size-off, " use_delay=%d delay_nsec=%llu",
> +		seq_printf(s, " use_delay=%d delay_nsec=%llu",
>  			atomic_read(&blkg->use_delay),
>  			atomic64_read(&blkg->delay_nsec));
>  	}
>  
>  	for (i = 0; i < BLKCG_MAX_POLS; i++) {
>  		struct blkcg_policy *pol = blkcg_policy[i];
> -		size_t written;
>  
>  		if (!blkg->pd[i] || !pol->pd_stat_fn)
>  			continue;
>  
> -		written = pol->pd_stat_fn(blkg->pd[i], buf+off, size-off);
> -		if (written)
> +		if (pol->pd_stat_fn(blkg->pd[i], s))
>  			has_stats = true;
> -		off += written;
>  	}
>  
> -	if (has_stats) {
> -		if (off < size - 1) {
> -			off += scnprintf(buf+off, size-off, "\n");
> -			seq_commit(s, off);
> -		} else {
> -			seq_commit(s, -1);
> -		}
> -	}
> +	if (has_stats)
> +		seq_printf(s, "\n");
>  }
>  
>  static int blkcg_print_stat(struct seq_file *sf, void *v)
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 5fac3757e6e0..89b21a360b2c 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2988,34 +2988,29 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
>  	kfree(iocg);
>  }
>  
> -static size_t ioc_pd_stat(struct blkg_policy_data *pd, char *buf, size_t size)
> +static bool ioc_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
>  {
>  	struct ioc_gq *iocg = pd_to_iocg(pd);
>  	struct ioc *ioc = iocg->ioc;
> -	size_t pos = 0;
>  
>  	if (!ioc->enabled)
> -		return 0;
> +		return false;
>  
>  	if (iocg->level == 0) {
>  		unsigned vp10k = DIV64_U64_ROUND_CLOSEST(
>  			ioc->vtime_base_rate * 10000,
>  			VTIME_PER_USEC);
> -		pos += scnprintf(buf + pos, size - pos, " cost.vrate=%u.%02u",
> -				  vp10k / 100, vp10k % 100);
> +		seq_printf(s, " cost.vrate=%u.%02u", vp10k / 100, vp10k % 100);
>  	}
>  
> -	pos += scnprintf(buf + pos, size - pos, " cost.usage=%llu",
> -			 iocg->last_stat.usage_us);
> +	seq_printf(s, " cost.usage=%llu", iocg->last_stat.usage_us);
>  
>  	if (blkcg_debug_stats)
> -		pos += scnprintf(buf + pos, size - pos,
> -				 " cost.wait=%llu cost.indebt=%llu cost.indelay=%llu",
> -				 iocg->last_stat.wait_us,
> -				 iocg->last_stat.indebt_us,
> -				 iocg->last_stat.indelay_us);
> -
> -	return pos;
> +		seq_printf(s, " cost.wait=%llu cost.indebt=%llu cost.indelay=%llu",
> +			iocg->last_stat.wait_us,
> +			iocg->last_stat.indebt_us,
> +			iocg->last_stat.indelay_us);
> +	return true;
>  }
>  
>  static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index d8b0d8bd132b..c0545f9da549 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -890,8 +890,7 @@ static int iolatency_print_limit(struct seq_file *sf, void *v)
>  	return 0;
>  }
>  
> -static size_t iolatency_ssd_stat(struct iolatency_grp *iolat, char *buf,
> -				 size_t size)
> +static bool iolatency_ssd_stat(struct iolatency_grp *iolat, struct seq_file *s)
>  {
>  	struct latency_stat stat;
>  	int cpu;
> @@ -906,39 +905,40 @@ static size_t iolatency_ssd_stat(struct iolatency_grp *iolat, char *buf,
>  	preempt_enable();
>  
>  	if (iolat->rq_depth.max_depth == UINT_MAX)
> -		return scnprintf(buf, size, " missed=%llu total=%llu depth=max",
> -				 (unsigned long long)stat.ps.missed,
> -				 (unsigned long long)stat.ps.total);
> -	return scnprintf(buf, size, " missed=%llu total=%llu depth=%u",
> -			 (unsigned long long)stat.ps.missed,
> -			 (unsigned long long)stat.ps.total,
> -			 iolat->rq_depth.max_depth);
> +		seq_printf(s, " missed=%llu total=%llu depth=max",
> +			(unsigned long long)stat.ps.missed,
> +			(unsigned long long)stat.ps.total);
> +	else
> +		seq_printf(s, " missed=%llu total=%llu depth=%u",
> +			(unsigned long long)stat.ps.missed,
> +			(unsigned long long)stat.ps.total,
> +			iolat->rq_depth.max_depth);
> +	return true;
>  }
>  
> -static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
> -				size_t size)
> +static bool iolatency_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
>  {
>  	struct iolatency_grp *iolat = pd_to_lat(pd);
>  	unsigned long long avg_lat;
>  	unsigned long long cur_win;
>  
>  	if (!blkcg_debug_stats)
> -		return 0;
> +		return false;
>  
>  	if (iolat->ssd)
> -		return iolatency_ssd_stat(iolat, buf, size);
> +		return iolatency_ssd_stat(iolat, s);
>  
>  	avg_lat = div64_u64(iolat->lat_avg, NSEC_PER_USEC);
>  	cur_win = div64_u64(iolat->cur_win_nsec, NSEC_PER_MSEC);
>  	if (iolat->rq_depth.max_depth == UINT_MAX)
> -		return scnprintf(buf, size, " depth=max avg_lat=%llu win=%llu",
> -				 avg_lat, cur_win);
> -
> -	return scnprintf(buf, size, " depth=%u avg_lat=%llu win=%llu",
> -			 iolat->rq_depth.max_depth, avg_lat, cur_win);
> +		seq_printf(s, " depth=max avg_lat=%llu win=%llu",
> +			avg_lat, cur_win);
> +	else
> +		seq_printf(s, " depth=%u avg_lat=%llu win=%llu",
> +			iolat->rq_depth.max_depth, avg_lat, cur_win);
> +	return true;
>  }
>  
> -
>  static struct blkg_policy_data *iolatency_pd_alloc(gfp_t gfp,
>  						   struct request_queue *q,
>  						   struct blkcg *blkcg)
> diff --git a/block/mq-deadline-cgroup.c b/block/mq-deadline-cgroup.c
> index 3b4bfddec39f..b48a4b962f90 100644
> --- a/block/mq-deadline-cgroup.c
> +++ b/block/mq-deadline-cgroup.c
> @@ -52,7 +52,7 @@ struct dd_blkcg *dd_blkcg_from_bio(struct bio *bio)
>  	return dd_blkcg_from_pd(pd);
>  }
>  
> -static size_t dd_pd_stat(struct blkg_policy_data *pd, char *buf, size_t size)
> +static bool dd_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
>  {
>  	static const char *const prio_class_name[] = {
>  		[IOPRIO_CLASS_NONE]	= "NONE",
> @@ -61,12 +61,10 @@ static size_t dd_pd_stat(struct blkg_policy_data *pd, char *buf, size_t size)
>  		[IOPRIO_CLASS_IDLE]	= "IDLE",
>  	};
>  	struct dd_blkcg *blkcg = dd_blkcg_from_pd(pd);
> -	int res = 0;
>  	u8 prio;
>  
>  	for (prio = 0; prio < ARRAY_SIZE(blkcg->stats->stats); prio++)
> -		res += scnprintf(buf + res, size - res,
> -			" [%s] dispatched=%u inserted=%u merged=%u",
> +		seq_printf(s, " [%s] dispatched=%u inserted=%u merged=%u",
>  			prio_class_name[prio],
>  			ddcg_sum(blkcg, dispatched, prio) +
>  			ddcg_sum(blkcg, merged, prio) -
> @@ -75,7 +73,7 @@ static size_t dd_pd_stat(struct blkg_policy_data *pd, char *buf, size_t size)
>  			ddcg_sum(blkcg, completed, prio),
>  			ddcg_sum(blkcg, merged, prio));
>  
> -	return res;
> +	return true;
>  }
>  
>  static struct blkg_policy_data *dd_pd_alloc(gfp_t gfp, struct request_queue *q,
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index 37048438872c..b4de2010fba5 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -152,8 +152,8 @@ typedef void (blkcg_pol_online_pd_fn)(struct blkg_policy_data *pd);
>  typedef void (blkcg_pol_offline_pd_fn)(struct blkg_policy_data *pd);
>  typedef void (blkcg_pol_free_pd_fn)(struct blkg_policy_data *pd);
>  typedef void (blkcg_pol_reset_pd_stats_fn)(struct blkg_policy_data *pd);
> -typedef size_t (blkcg_pol_stat_pd_fn)(struct blkg_policy_data *pd, char *buf,
> -				      size_t size);
> +typedef bool (blkcg_pol_stat_pd_fn)(struct blkg_policy_data *pd,
> +				struct seq_file *s);
>  
>  struct blkcg_policy {
>  	int				plid;
> -- 
> 2.30.2
> 
> 


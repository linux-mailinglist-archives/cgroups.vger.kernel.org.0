Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE1338425
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2019 08:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfFGGIG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jun 2019 02:08:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52285 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfFGGH4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jun 2019 02:07:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so693270wms.2
        for <cgroups@vger.kernel.org>; Thu, 06 Jun 2019 23:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=IIA75kq91Zu4Z2I3ADyla7BV6P2MHjcybBjFYh4X/pw=;
        b=y6kFSr+fRAcPJMtd8zafcaptGWdCnGzacyO9stc+DCMvKq4itWSAjxDIasZKk1TT7G
         vadSoYC7J/JhExzu9tY6qz3LP3f9BltgDYaQHArxg4Rs+gEcMbm8TZ0QcWI096ML9mfc
         RUCBFhJYMoyJhtCsfH3qgeFzGLSR9/TdYO4gnlNKsbbR9o0KnifpelOdoRx4PsXA9oDv
         BvAzVk+5b0NQxsekPiJEfRAXePyfdHA51bjS88bIj9sjMV/y9CuBpykJMVsoSvxUumsh
         0iq8ii4ISNuO9JNdTLXYu2RncfB4Z60GBujwXzkBqmmFRxgw74UDjmnPgXCfhtsQ29TM
         Zqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=IIA75kq91Zu4Z2I3ADyla7BV6P2MHjcybBjFYh4X/pw=;
        b=KqEPBWIsOKqRAYnDwM/2B4HZB+HUYZsdNh6mxYY/QWZacCaA7kvbEjPEFylTuhHFLX
         GyWb/HlltEngkE0Jns65MeDN6ON6Oe6wSh27yPoaoxMuem+aKaYka5ALuQ+VD92Whac5
         oNeXx4TPwYrW1lVOb1FvEX1E1PhX3u4ZrjsJogtO3fBVpxMN8IMW+9/CIMgy2M3Ney0S
         LbtMTbLlcQLGeACBM74tDF/bkcjqBl6EaS2VsSjUBK+NQmP5Pif1ocrlD+Dee5r7/pRY
         Hdd2hvrZMIlAsKJS3AOWy5TjOu+e22YR4w78a2oss4+WZ568nkmpy0AVniXDNdAWxP07
         REYA==
X-Gm-Message-State: APjAAAXEikKDok/DoRmas5LGM6nDdElg3OyQoR4zWjFblgKTB5GX+Dt9
        XeIYUjfQTsLwN0NxbuurS8sOKp1w+Ls=
X-Google-Smtp-Source: APXvYqzES8VSFPqN9KTd9wIJx9wM3RQC3NvTS9E8pWmRqPC4aHj9PAtt/kP5+uhbWbcQQyi7YjKasA==
X-Received: by 2002:a05:600c:2116:: with SMTP id u22mr2492454wml.90.1559887673417;
        Thu, 06 Jun 2019 23:07:53 -0700 (PDT)
Received: from [192.168.0.102] (88-147-34-172.dyn.eolo.it. [88.147.34.172])
        by smtp.gmail.com with ESMTPSA id n7sm787465wrw.64.2019.06.06.23.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 23:07:52 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <08BE9ED6-813E-4FB6-A110-1407D8EA13D2@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_8B8DB3FA-1283-4A7B-AFE7-CB71AA948C9A";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 4/6] blk-cgroup: move struct blkg_stat to bfq
Date:   Fri, 7 Jun 2019 08:07:51 +0200
In-Reply-To: <20190606102624.3847-5-hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Christoph Hellwig <hch@lst.de>
References: <20190606102624.3847-1-hch@lst.de>
 <20190606102624.3847-5-hch@lst.de>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--Apple-Mail=_8B8DB3FA-1283-4A7B-AFE7-CB71AA948C9A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 6 giu 2019, alle ore 12:26, Christoph Hellwig <hch@lst.de> =
ha scritto:
>=20
> This structure and assorted infrastructure is only used by the bfq I/O
> scheduler.  Move it there instead of bloating the common code.
>=20

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> block/bfq-cgroup.c         | 192 ++++++++++++++++++++++++++++++-------
> block/bfq-iosched.h        |  19 ++--
> block/blk-cgroup.c         |  56 -----------
> include/linux/blk-cgroup.h |  71 --------------
> 4 files changed, 167 insertions(+), 171 deletions(-)
>=20
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 624374a99c6e..a691dca7e966 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -17,6 +17,124 @@
>=20
> #if defined(CONFIG_BFQ_GROUP_IOSCHED) &&  =
defined(CONFIG_DEBUG_BLK_CGROUP)
>=20
> +static int bfq_stat_init(struct bfq_stat *stat, gfp_t gfp)
> +{
> +	int ret;
> +
> +	ret =3D percpu_counter_init(&stat->cpu_cnt, 0, gfp);
> +	if (ret)
> +		return ret;
> +
> +	atomic64_set(&stat->aux_cnt, 0);
> +	return 0;
> +}
> +
> +static void bfq_stat_exit(struct bfq_stat *stat)
> +{
> +	percpu_counter_destroy(&stat->cpu_cnt);
> +}
> +
> +/**
> + * bfq_stat_add - add a value to a bfq_stat
> + * @stat: target bfq_stat
> + * @val: value to add
> + *
> + * Add @val to @stat.  The caller must ensure that IRQ on the same =
CPU
> + * don't re-enter this function for the same counter.
> + */
> +static inline void bfq_stat_add(struct bfq_stat *stat, uint64_t val)
> +{
> +	percpu_counter_add_batch(&stat->cpu_cnt, val, =
BLKG_STAT_CPU_BATCH);
> +}
> +
> +/**
> + * bfq_stat_read - read the current value of a bfq_stat
> + * @stat: bfq_stat to read
> + */
> +static inline uint64_t bfq_stat_read(struct bfq_stat *stat)
> +{
> +	return percpu_counter_sum_positive(&stat->cpu_cnt);
> +}
> +
> +/**
> + * bfq_stat_reset - reset a bfq_stat
> + * @stat: bfq_stat to reset
> + */
> +static inline void bfq_stat_reset(struct bfq_stat *stat)
> +{
> +	percpu_counter_set(&stat->cpu_cnt, 0);
> +	atomic64_set(&stat->aux_cnt, 0);
> +}
> +
> +/**
> + * bfq_stat_add_aux - add a bfq_stat into another's aux count
> + * @to: the destination bfq_stat
> + * @from: the source
> + *
> + * Add @from's count including the aux one to @to's aux count.
> + */
> +static inline void bfq_stat_add_aux(struct bfq_stat *to,
> +				     struct bfq_stat *from)
> +{
> +	atomic64_add(bfq_stat_read(from) + =
atomic64_read(&from->aux_cnt),
> +		     &to->aux_cnt);
> +}
> +
> +/**
> + * bfq_stat_recursive_sum - collect hierarchical bfq_stat
> + * @blkg: blkg of interest
> + * @pol: blkcg_policy which contains the bfq_stat
> + * @off: offset to the bfq_stat in blkg_policy_data or @blkg
> + *
> + * Collect the bfq_stat specified by @blkg, @pol and @off and all its
> + * online descendants and their aux counts.  The caller must be =
holding the
> + * queue lock for online tests.
> + *
> + * If @pol is NULL, bfq_stat is at @off bytes into @blkg; otherwise, =
it is
> + * at @off bytes into @blkg's blkg_policy_data of the policy.
> + */
> +static u64 bfq_stat_recursive_sum(struct blkcg_gq *blkg,
> +			    struct blkcg_policy *pol, int off)
> +{
> +	struct blkcg_gq *pos_blkg;
> +	struct cgroup_subsys_state *pos_css;
> +	u64 sum =3D 0;
> +
> +	lockdep_assert_held(&blkg->q->queue_lock);
> +
> +	rcu_read_lock();
> +	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
> +		struct bfq_stat *stat;
> +
> +		if (!pos_blkg->online)
> +			continue;
> +
> +		if (pol)
> +			stat =3D (void *)blkg_to_pd(pos_blkg, pol) + =
off;
> +		else
> +			stat =3D (void *)blkg + off;
> +
> +		sum +=3D bfq_stat_read(stat) + =
atomic64_read(&stat->aux_cnt);
> +	}
> +	rcu_read_unlock();
> +
> +	return sum;
> +}
> +
> +/**
> + * blkg_prfill_stat - prfill callback for bfq_stat
> + * @sf: seq_file to print to
> + * @pd: policy private data of interest
> + * @off: offset to the bfq_stat in @pd
> + *
> + * prfill callback for printing a bfq_stat.
> + */
> +static u64 blkg_prfill_stat(struct seq_file *sf, struct =
blkg_policy_data *pd,
> +		int off)
> +{
> +	return __blkg_prfill_u64(sf, pd, bfq_stat_read((void *)pd + =
off));
> +}
> +
> /* bfqg stats flags */
> enum bfqg_stats_flags {
> 	BFQG_stats_waiting =3D 0,
> @@ -53,7 +171,7 @@ static void =
bfqg_stats_update_group_wait_time(struct bfqg_stats *stats)
>=20
> 	now =3D ktime_get_ns();
> 	if (now > stats->start_group_wait_time)
> -		blkg_stat_add(&stats->group_wait_time,
> +		bfq_stat_add(&stats->group_wait_time,
> 			      now - stats->start_group_wait_time);
> 	bfqg_stats_clear_waiting(stats);
> }
> @@ -82,14 +200,14 @@ static void bfqg_stats_end_empty_time(struct =
bfqg_stats *stats)
>=20
> 	now =3D ktime_get_ns();
> 	if (now > stats->start_empty_time)
> -		blkg_stat_add(&stats->empty_time,
> +		bfq_stat_add(&stats->empty_time,
> 			      now - stats->start_empty_time);
> 	bfqg_stats_clear_empty(stats);
> }
>=20
> void bfqg_stats_update_dequeue(struct bfq_group *bfqg)
> {
> -	blkg_stat_add(&bfqg->stats.dequeue, 1);
> +	bfq_stat_add(&bfqg->stats.dequeue, 1);
> }
>=20
> void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg)
> @@ -119,7 +237,7 @@ void bfqg_stats_update_idle_time(struct bfq_group =
*bfqg)
> 		u64 now =3D ktime_get_ns();
>=20
> 		if (now > stats->start_idle_time)
> -			blkg_stat_add(&stats->idle_time,
> +			bfq_stat_add(&stats->idle_time,
> 				      now - stats->start_idle_time);
> 		bfqg_stats_clear_idling(stats);
> 	}
> @@ -137,9 +255,9 @@ void bfqg_stats_update_avg_queue_size(struct =
bfq_group *bfqg)
> {
> 	struct bfqg_stats *stats =3D &bfqg->stats;
>=20
> -	blkg_stat_add(&stats->avg_queue_size_sum,
> +	bfq_stat_add(&stats->avg_queue_size_sum,
> 		      blkg_rwstat_total(&stats->queued));
> -	blkg_stat_add(&stats->avg_queue_size_samples, 1);
> +	bfq_stat_add(&stats->avg_queue_size_samples, 1);
> 	bfqg_stats_update_group_wait_time(stats);
> }
>=20
> @@ -279,13 +397,13 @@ static void bfqg_stats_reset(struct bfqg_stats =
*stats)
> 	blkg_rwstat_reset(&stats->merged);
> 	blkg_rwstat_reset(&stats->service_time);
> 	blkg_rwstat_reset(&stats->wait_time);
> -	blkg_stat_reset(&stats->time);
> -	blkg_stat_reset(&stats->avg_queue_size_sum);
> -	blkg_stat_reset(&stats->avg_queue_size_samples);
> -	blkg_stat_reset(&stats->dequeue);
> -	blkg_stat_reset(&stats->group_wait_time);
> -	blkg_stat_reset(&stats->idle_time);
> -	blkg_stat_reset(&stats->empty_time);
> +	bfq_stat_reset(&stats->time);
> +	bfq_stat_reset(&stats->avg_queue_size_sum);
> +	bfq_stat_reset(&stats->avg_queue_size_samples);
> +	bfq_stat_reset(&stats->dequeue);
> +	bfq_stat_reset(&stats->group_wait_time);
> +	bfq_stat_reset(&stats->idle_time);
> +	bfq_stat_reset(&stats->empty_time);
> #endif
> }
>=20
> @@ -300,14 +418,14 @@ static void bfqg_stats_add_aux(struct bfqg_stats =
*to, struct bfqg_stats *from)
> 	blkg_rwstat_add_aux(&to->merged, &from->merged);
> 	blkg_rwstat_add_aux(&to->service_time, &from->service_time);
> 	blkg_rwstat_add_aux(&to->wait_time, &from->wait_time);
> -	blkg_stat_add_aux(&from->time, &from->time);
> -	blkg_stat_add_aux(&to->avg_queue_size_sum, =
&from->avg_queue_size_sum);
> -	blkg_stat_add_aux(&to->avg_queue_size_samples,
> +	bfq_stat_add_aux(&from->time, &from->time);
> +	bfq_stat_add_aux(&to->avg_queue_size_sum, =
&from->avg_queue_size_sum);
> +	bfq_stat_add_aux(&to->avg_queue_size_samples,
> 			  &from->avg_queue_size_samples);
> -	blkg_stat_add_aux(&to->dequeue, &from->dequeue);
> -	blkg_stat_add_aux(&to->group_wait_time, &from->group_wait_time);
> -	blkg_stat_add_aux(&to->idle_time, &from->idle_time);
> -	blkg_stat_add_aux(&to->empty_time, &from->empty_time);
> +	bfq_stat_add_aux(&to->dequeue, &from->dequeue);
> +	bfq_stat_add_aux(&to->group_wait_time, &from->group_wait_time);
> +	bfq_stat_add_aux(&to->idle_time, &from->idle_time);
> +	bfq_stat_add_aux(&to->empty_time, &from->empty_time);
> #endif
> }
>=20
> @@ -360,13 +478,13 @@ static void bfqg_stats_exit(struct bfqg_stats =
*stats)
> 	blkg_rwstat_exit(&stats->service_time);
> 	blkg_rwstat_exit(&stats->wait_time);
> 	blkg_rwstat_exit(&stats->queued);
> -	blkg_stat_exit(&stats->time);
> -	blkg_stat_exit(&stats->avg_queue_size_sum);
> -	blkg_stat_exit(&stats->avg_queue_size_samples);
> -	blkg_stat_exit(&stats->dequeue);
> -	blkg_stat_exit(&stats->group_wait_time);
> -	blkg_stat_exit(&stats->idle_time);
> -	blkg_stat_exit(&stats->empty_time);
> +	bfq_stat_exit(&stats->time);
> +	bfq_stat_exit(&stats->avg_queue_size_sum);
> +	bfq_stat_exit(&stats->avg_queue_size_samples);
> +	bfq_stat_exit(&stats->dequeue);
> +	bfq_stat_exit(&stats->group_wait_time);
> +	bfq_stat_exit(&stats->idle_time);
> +	bfq_stat_exit(&stats->empty_time);
> #endif
> }
>=20
> @@ -377,13 +495,13 @@ static int bfqg_stats_init(struct bfqg_stats =
*stats, gfp_t gfp)
> 	    blkg_rwstat_init(&stats->service_time, gfp) ||
> 	    blkg_rwstat_init(&stats->wait_time, gfp) ||
> 	    blkg_rwstat_init(&stats->queued, gfp) ||
> -	    blkg_stat_init(&stats->time, gfp) ||
> -	    blkg_stat_init(&stats->avg_queue_size_sum, gfp) ||
> -	    blkg_stat_init(&stats->avg_queue_size_samples, gfp) ||
> -	    blkg_stat_init(&stats->dequeue, gfp) ||
> -	    blkg_stat_init(&stats->group_wait_time, gfp) ||
> -	    blkg_stat_init(&stats->idle_time, gfp) ||
> -	    blkg_stat_init(&stats->empty_time, gfp)) {
> +	    bfq_stat_init(&stats->time, gfp) ||
> +	    bfq_stat_init(&stats->avg_queue_size_sum, gfp) ||
> +	    bfq_stat_init(&stats->avg_queue_size_samples, gfp) ||
> +	    bfq_stat_init(&stats->dequeue, gfp) ||
> +	    bfq_stat_init(&stats->group_wait_time, gfp) ||
> +	    bfq_stat_init(&stats->idle_time, gfp) ||
> +	    bfq_stat_init(&stats->empty_time, gfp)) {
> 		bfqg_stats_exit(stats);
> 		return -ENOMEM;
> 	}
> @@ -927,7 +1045,7 @@ static int bfqg_print_rwstat(struct seq_file *sf, =
void *v)
> static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
> 				      struct blkg_policy_data *pd, int =
off)
> {
> -	u64 sum =3D blkg_stat_recursive_sum(pd_to_blkg(pd),
> +	u64 sum =3D bfq_stat_recursive_sum(pd_to_blkg(pd),
> 					  &blkcg_policy_bfq, off);
> 	return __blkg_prfill_u64(sf, pd, sum);
> }
> @@ -996,11 +1114,11 @@ static u64 bfqg_prfill_avg_queue_size(struct =
seq_file *sf,
> 				      struct blkg_policy_data *pd, int =
off)
> {
> 	struct bfq_group *bfqg =3D pd_to_bfqg(pd);
> -	u64 samples =3D =
blkg_stat_read(&bfqg->stats.avg_queue_size_samples);
> +	u64 samples =3D =
bfq_stat_read(&bfqg->stats.avg_queue_size_samples);
> 	u64 v =3D 0;
>=20
> 	if (samples) {
> -		v =3D blkg_stat_read(&bfqg->stats.avg_queue_size_sum);
> +		v =3D bfq_stat_read(&bfqg->stats.avg_queue_size_sum);
> 		v =3D div64_u64(v, samples);
> 	}
> 	__blkg_prfill_u64(sf, pd, v);
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index c2faa77824f8..aef4fa0046b8 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -777,6 +777,11 @@ enum bfqq_expiration {
> 	BFQQE_PREEMPTED		/* preemption in progress */
> };
>=20
> +struct bfq_stat {
> +	struct percpu_counter		cpu_cnt;
> +	atomic64_t			aux_cnt;
> +};
> +
> struct bfqg_stats {
> #if defined(CONFIG_BFQ_GROUP_IOSCHED) && =
defined(CONFIG_DEBUG_BLK_CGROUP)
> 	/* number of ios merged */
> @@ -788,19 +793,19 @@ struct bfqg_stats {
> 	/* number of IOs queued up */
> 	struct blkg_rwstat		queued;
> 	/* total disk time and nr sectors dispatched by this group */
> -	struct blkg_stat		time;
> +	struct bfq_stat		time;
> 	/* sum of number of ios queued across all samples */
> -	struct blkg_stat		avg_queue_size_sum;
> +	struct bfq_stat		avg_queue_size_sum;
> 	/* count of samples taken for average */
> -	struct blkg_stat		avg_queue_size_samples;
> +	struct bfq_stat		avg_queue_size_samples;
> 	/* how many times this group has been removed from service tree =
*/
> -	struct blkg_stat		dequeue;
> +	struct bfq_stat		dequeue;
> 	/* total time spent waiting for it to be assigned a timeslice. =
*/
> -	struct blkg_stat		group_wait_time;
> +	struct bfq_stat		group_wait_time;
> 	/* time spent idling for this blkcg_gq */
> -	struct blkg_stat		idle_time;
> +	struct bfq_stat		idle_time;
> 	/* total time with empty current active q with other requests =
queued */
> -	struct blkg_stat		empty_time;
> +	struct bfq_stat		empty_time;
> 	/* fields after this shouldn't be cleared on stat reset */
> 	u64				start_group_wait_time;
> 	u64				start_idle_time;
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index aad0f5d9a2ea..1aa5c64675d6 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -577,20 +577,6 @@ u64 __blkg_prfill_rwstat(struct seq_file *sf, =
struct blkg_policy_data *pd,
> }
> EXPORT_SYMBOL_GPL(__blkg_prfill_rwstat);
>=20
> -/**
> - * blkg_prfill_stat - prfill callback for blkg_stat
> - * @sf: seq_file to print to
> - * @pd: policy private data of interest
> - * @off: offset to the blkg_stat in @pd
> - *
> - * prfill callback for printing a blkg_stat.
> - */
> -u64 blkg_prfill_stat(struct seq_file *sf, struct blkg_policy_data =
*pd, int off)
> -{
> -	return __blkg_prfill_u64(sf, pd, blkg_stat_read((void *)pd + =
off));
> -}
> -EXPORT_SYMBOL_GPL(blkg_prfill_stat);
> -
> /**
>  * blkg_prfill_rwstat - prfill callback for blkg_rwstat
>  * @sf: seq_file to print to
> @@ -692,48 +678,6 @@ int blkg_print_stat_ios_recursive(struct seq_file =
*sf, void *v)
> }
> EXPORT_SYMBOL_GPL(blkg_print_stat_ios_recursive);
>=20
> -/**
> - * blkg_stat_recursive_sum - collect hierarchical blkg_stat
> - * @blkg: blkg of interest
> - * @pol: blkcg_policy which contains the blkg_stat
> - * @off: offset to the blkg_stat in blkg_policy_data or @blkg
> - *
> - * Collect the blkg_stat specified by @blkg, @pol and @off and all =
its
> - * online descendants and their aux counts.  The caller must be =
holding the
> - * queue lock for online tests.
> - *
> - * If @pol is NULL, blkg_stat is at @off bytes into @blkg; otherwise, =
it is
> - * at @off bytes into @blkg's blkg_policy_data of the policy.
> - */
> -u64 blkg_stat_recursive_sum(struct blkcg_gq *blkg,
> -			    struct blkcg_policy *pol, int off)
> -{
> -	struct blkcg_gq *pos_blkg;
> -	struct cgroup_subsys_state *pos_css;
> -	u64 sum =3D 0;
> -
> -	lockdep_assert_held(&blkg->q->queue_lock);
> -
> -	rcu_read_lock();
> -	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
> -		struct blkg_stat *stat;
> -
> -		if (!pos_blkg->online)
> -			continue;
> -
> -		if (pol)
> -			stat =3D (void *)blkg_to_pd(pos_blkg, pol) + =
off;
> -		else
> -			stat =3D (void *)blkg + off;
> -
> -		sum +=3D blkg_stat_read(stat) + =
atomic64_read(&stat->aux_cnt);
> -	}
> -	rcu_read_unlock();
> -
> -	return sum;
> -}
> -EXPORT_SYMBOL_GPL(blkg_stat_recursive_sum);
> -
> /**
>  * blkg_rwstat_recursive_sum - collect hierarchical blkg_rwstat
>  * @blkg: blkg of interest
> diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> index e4a81767e111..33f23a858438 100644
> --- a/include/linux/blk-cgroup.h
> +++ b/include/linux/blk-cgroup.h
> @@ -65,11 +65,6 @@ struct blkcg {
>  * blkg_[rw]stat->aux_cnt is excluded for local stats but included for
>  * recursive.  Used to carry stats of dead children.
>  */
> -struct blkg_stat {
> -	struct percpu_counter		cpu_cnt;
> -	atomic64_t			aux_cnt;
> -};
> -
> struct blkg_rwstat {
> 	struct percpu_counter		cpu_cnt[BLKG_RWSTAT_NR];
> 	atomic64_t			aux_cnt[BLKG_RWSTAT_NR];
> @@ -217,7 +212,6 @@ void blkcg_print_blkgs(struct seq_file *sf, struct =
blkcg *blkcg,
> u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data =
*pd, u64 v);
> u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data =
*pd,
> 			 const struct blkg_rwstat_sample *rwstat);
> -u64 blkg_prfill_stat(struct seq_file *sf, struct blkg_policy_data =
*pd, int off);
> u64 blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data =
*pd,
> 		       int off);
> int blkg_print_stat_bytes(struct seq_file *sf, void *v);
> @@ -225,8 +219,6 @@ int blkg_print_stat_ios(struct seq_file *sf, void =
*v);
> int blkg_print_stat_bytes_recursive(struct seq_file *sf, void *v);
> int blkg_print_stat_ios_recursive(struct seq_file *sf, void *v);
>=20
> -u64 blkg_stat_recursive_sum(struct blkcg_gq *blkg,
> -			    struct blkcg_policy *pol, int off);
> void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct =
blkcg_policy *pol,
> 		int off, struct blkg_rwstat_sample *sum);
>=20
> @@ -579,69 +571,6 @@ static inline void blkg_put(struct blkcg_gq =
*blkg)
> 		if (((d_blkg) =3D __blkg_lookup(css_to_blkcg(pos_css),	=
\
> 					      (p_blkg)->q, false)))
>=20
> -static inline int blkg_stat_init(struct blkg_stat *stat, gfp_t gfp)
> -{
> -	int ret;
> -
> -	ret =3D percpu_counter_init(&stat->cpu_cnt, 0, gfp);
> -	if (ret)
> -		return ret;
> -
> -	atomic64_set(&stat->aux_cnt, 0);
> -	return 0;
> -}
> -
> -static inline void blkg_stat_exit(struct blkg_stat *stat)
> -{
> -	percpu_counter_destroy(&stat->cpu_cnt);
> -}
> -
> -/**
> - * blkg_stat_add - add a value to a blkg_stat
> - * @stat: target blkg_stat
> - * @val: value to add
> - *
> - * Add @val to @stat.  The caller must ensure that IRQ on the same =
CPU
> - * don't re-enter this function for the same counter.
> - */
> -static inline void blkg_stat_add(struct blkg_stat *stat, uint64_t =
val)
> -{
> -	percpu_counter_add_batch(&stat->cpu_cnt, val, =
BLKG_STAT_CPU_BATCH);
> -}
> -
> -/**
> - * blkg_stat_read - read the current value of a blkg_stat
> - * @stat: blkg_stat to read
> - */
> -static inline uint64_t blkg_stat_read(struct blkg_stat *stat)
> -{
> -	return percpu_counter_sum_positive(&stat->cpu_cnt);
> -}
> -
> -/**
> - * blkg_stat_reset - reset a blkg_stat
> - * @stat: blkg_stat to reset
> - */
> -static inline void blkg_stat_reset(struct blkg_stat *stat)
> -{
> -	percpu_counter_set(&stat->cpu_cnt, 0);
> -	atomic64_set(&stat->aux_cnt, 0);
> -}
> -
> -/**
> - * blkg_stat_add_aux - add a blkg_stat into another's aux count
> - * @to: the destination blkg_stat
> - * @from: the source
> - *
> - * Add @from's count including the aux one to @to's aux count.
> - */
> -static inline void blkg_stat_add_aux(struct blkg_stat *to,
> -				     struct blkg_stat *from)
> -{
> -	atomic64_add(blkg_stat_read(from) + =
atomic64_read(&from->aux_cnt),
> -		     &to->aux_cnt);
> -}
> -
> static inline int blkg_rwstat_init(struct blkg_rwstat *rwstat, gfp_t =
gfp)
> {
> 	int i, ret;
> --
> 2.20.1
>=20


--Apple-Mail=_8B8DB3FA-1283-4A7B-AFE7-CB71AA948C9A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlz5/zcACgkQOAkCLQGo
9oMuORAApZWMpxf5ygoQDxfwqDxCiXtnIu9Nl/eV8TriEhQi1ofsR8cQk8XvTaaM
WycU3invU/8fl0UysWPxnyzvj/9fizsIHH6gcvIEVify11i0R9H1Ct0OQozG1dPF
p3FZ6W/B3eWeLoL9m4Ao/a4zduRTugmzLgImFxAqOzwIqZwHus65c8bSPDmAi5/W
e1zrISXaQr+/SfE1puH0fkwYbqgjoFrDwbeVWxKmisRqXUGWz0oUHUCZJqlhLEWz
yIz2pgfBNhh077CKFTGabSyfyihUJNumgdTntVBhT46JrPXsuKZwzQHsrswpyhrb
i5Of36kfNOgfNNqNBRrdGPL9wp2IekoNtXhatYPvJUg5BQxgltTj6GZhdNtvz8/o
QGHfIykgmYNcI6xc9g/cbIU2TvhHC362MYZB3bsNLtvSj2Qr6XnVYAqrCHJXvAUd
qJDE/EmbTdmViUWX28YfZRzCUuWRVKuRTvHvoR13t71mo1I57IAXVq90Qf7LvyIB
CaJfXdI5a4KsBbGNDJgXwwS2hi5u39aCk9Qb5/MOg4FPPDa9ztBw8h0WC4w2D32h
JEkpNHCtgw4zzjSCIqnhd5qbfer+Gp35HvM2pzNXSLIesRuJcLQ8HU4lZ0eS7oln
7ABPxId3aFp+YlIKO/OyquqGbmHBunLgsFDPYH8g5pgyk4zMo/U=
=9joj
-----END PGP SIGNATURE-----

--Apple-Mail=_8B8DB3FA-1283-4A7B-AFE7-CB71AA948C9A--

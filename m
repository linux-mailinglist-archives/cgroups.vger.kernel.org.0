Return-Path: <cgroups+bounces-6651-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30080A413FE
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 04:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE6516DA92
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2025 03:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5901A3176;
	Mon, 24 Feb 2025 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DARoXfyO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B31F60A
	for <cgroups@vger.kernel.org>; Mon, 24 Feb 2025 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740367719; cv=none; b=qqEI1emZSfFPAj70WjEg+XqGG+kpixbov/Evc6QyVtjTQDPrKyUGJxVOBgdCINl6p5SGyyWmRiA2TywwUJMLQkxHpQpdiD1ZcCJNL9YnFt2GWG4GphAPfEpQ+/db0H6y9bM6jijfOLRFradHYPEFoG2x7O8X37+4ntlDW15ogtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740367719; c=relaxed/simple;
	bh=Q4FSVu6jUyT1kY2R+LJKOebYCDa7zGKm2uwTxpzLdjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTbq5xVf59lrd3kH8VLHdeJNCbm/D0pUGjvrSON9CstINGWETP71XDHjY8XsnfFbjeUV05fU7c3z4nvFk8VrbTd7stFTUwYAKT+VeRsdAdotEuwcVuchO/AqK4zBgBFKoPOxE24x0OecoSxqSGepLbPrrWjlJ8QrXX13G4FIrZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DARoXfyO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740367714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01SlYQwVpThtAextzuIZDhJWnhAEwR2pf3Jnf5JXgXI=;
	b=DARoXfyOLMRbcUIX3Hx7uB+RhHxnmE7SNFB9S4kwrPJF47PhMifqJA5XHYR4mFcFEBwInY
	tOsZqkTRCQ1ZptgMD0My5XS6NAE8Zzp0R9AprrmdH6h9wjnW1RFlY+uMGBjKIbVa2k6+Fb
	Wf1zurDDNyvKt8Hc51qYJrPH3HZwKnE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-Su_tnlnjPsCFVvRNlFV5Hg-1; Sun,
 23 Feb 2025 22:28:31 -0500
X-MC-Unique: Su_tnlnjPsCFVvRNlFV5Hg-1
X-Mimecast-MFC-AGG-ID: Su_tnlnjPsCFVvRNlFV5Hg_1740367709
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1D061800873;
	Mon, 24 Feb 2025 03:28:28 +0000 (UTC)
Received: from fedora (unknown [10.72.120.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FD6819560AD;
	Mon, 24 Feb 2025 03:28:20 +0000 (UTC)
Date: Mon, 24 Feb 2025 11:28:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] blk-throttle: fix off-by-one jiffies wait_time
Message-ID: <Z7vnTyk6Y6X4JWQB@fedora>
References: <20250222092823.210318-1-yukuai1@huaweicloud.com>
 <20250222092823.210318-3-yukuai1@huaweicloud.com>
 <Z7nAJSKGANoC0Glb@fedora>
 <f2f54206-b5c0-7486-d607-337d29e9c145@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2f54206-b5c0-7486-d607-337d29e9c145@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Feb 24, 2025 at 10:39:13AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/02/22 20:16, Ming Lei 写道:
> > Hi Yukuai,
> > 
> > On Sat, Feb 22, 2025 at 05:28:23PM +0800, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > wait_time is based on jiffies, and the calculation is:
> > > 
> > > wait_time = extra_bytes * HZ / bps_limit;
> > > 
> > > If wait time is not zero, the remainder is ignored, means wait time is
> > > short by at most 1 jiffes; On the other hand, if wait time is zero, it
> > > will be used as 1 jiffies, means it's excessive by at most 1 jiffes.
> > > 
> > > This way causes blktests throtl/001 failure in case of CONFIG_HZ_100=y,
> > > fix the problem by recording remainder as debt, and repay the debt
> > > later.
> > 
> > After further analysis, I figured out that this one extra jiffy isn't the
> > only reason for throtl/001 failure.
> > 
> > In blktests throtl/001, bps_limit is 1MB/sec, and BS is 4k, and
> > COFIG_HZ=100, and default throttle slice is 2 jiffies(20ms):
> > 
> > - 20ms can submit 5 bios: 1024K/50(5*4k=20KB)
> > 
> > - the 6th bio is throttled, and the calculated wait is 1 jiffy from
> > tg_within_bps_limit()
> > 
> > - given all the 6 bios are handled in the time of jiffies A, so A + 1(wait) + 2(slice)
> > is programmed to start pending timer for scheduling dispatch
> > 
> > - when the pending timer is expired, the 6th bio is submitted, then the
> >    current slice is trim/reset since the throttled 6th bio is dispatched.
> > 
> > Now in the whole throttle slice period, 6 bios(24KB) are submitted, and 3
> > jiffies are taken, so 256 bios will take (256/6) * 30ms = 1.3sec.
> > 
> > But blktests throtl/001 still should pass since the allowed deviation is 0.5sec,
> > and 1.3 < 1.5.
> > 
> > Actually there is another reason of timer delay, looks one extra jiffy is
> > delayed when the timer is triggered, which can be observed reliably by:
> > 
> > bpftrace -e 'kfunc:throtl_pending_timer_fn { @timer_expire_delay = lhist(jiffies - args->t->expires, 0, 16, 1);}'
> > 
> > Then 256 bios will take (256/6) * 40ms = 1.7sec, which does match with
> > observation in throtl/001.
> 
> Thanks for the detailed explanation.
> > 
> > Yeah, killing one jiffy may pass blktests throtl/001, but, ...
> > 
> > > 
> > > Reported-and-tested-by: Ming Lei <ming.lei@redhat.com>
> > > Closes: https://lore.kernel.org/all/20250220111735.1187999-1-ming.lei@redhat.com/
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   block/blk-throttle.c | 24 +++++++++++++++++-------
> > >   block/blk-throttle.h | 12 ++++++++----
> > >   2 files changed, 25 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > > index 0096e486b1e3..3828c6535605 100644
> > > --- a/block/blk-throttle.c
> > > +++ b/block/blk-throttle.c
> > > @@ -703,9 +703,10 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
> > >   }
> > >   static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
> > > -				u64 bps_limit)
> > > +				u64 bps_limit, bool *has_debt)
> > >   {
> > >   	bool rw = bio_data_dir(bio);
> > > +	long long carryover_bytes;
> > >   	long long bytes_allowed;
> > >   	u64 extra_bytes;
> > >   	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
> > > @@ -730,10 +731,16 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
> > >   	/* Calc approx time to dispatch */
> > >   	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
> > > -	jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
> > > -
> > > -	if (!jiffy_wait)
> > > -		jiffy_wait = 1;
> > > +	jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit, &carryover_bytes);
> > > +	if (carryover_bytes) {
> > > +		/*
> > > +		 * If extra_bytes is not divisible, the remainder is recorded as
> > > +		 * debt. Caller must ensure the current slice has at least 1
> > > +		 * more jiffies to repay the debt.
> > > +		 */
> > > +		*has_debt = true;
> > > +		tg->carryover_bytes[rw] -= div64_u64(carryover_bytes, HZ);
> > > +	}
> > 
> > Thinking of further, it may not be good to use ->carryover_bytes[]:
> > 
> > - if tg_within_bps_limit() returns 0 and the bio is dispatched
> >    immediately, throtl_trim_slice() is called and ->carryover_bytes[]
> >    is cleared.
> > 
> I think this should not happen, because:
> 
> If the slice is extended in consideration of carryover_bytes,
> throtl_slice_used() is checked first in throtl_trim_slice().

throtl_trim_slice() returns immediately if throtl_slice_used()
is true.

And throtl_slice_used() checks jiffies in [start, end] via time_in_range(),
so if `start <= jiffies <= end', it still returns false.

So if the 6 bio comes at the end of the slice exactly:

- tg_within_bps_limit() returns 0 from tg_within_bps_limit() with your
patch

- the bio is dispatched

- throtl_trim_slice() still clears ->carryover_bytes[] since
  throtl_slice_used() returns false.


> 
> > - if tg_within_bps_limit() returns >0, this bio will be throttled, and
> >    tg_within_bps_limit() may be called more than one time, so
> >    tg->carryover_bytes[] could be over-counted.
> > 
> Yes, carryover_bytes can be over-counted with this patch. For now, the
> only way that I can think of to fix this is to handle carryover_bytes
> from the caller of tg_may_dispatch():

As I explained, there are two reason which contributes to throtl/001,
and the throttle algorithm needn't to take the single time delay into
account, and it can dispatch more if less bytes are dispatched in
previous period of this slice because of either jiffy_wait roundup or
timer expire delay.

The opposite, probably carryover_bytes[] could be killed in future.


>  - tg_within_limit(), only handle if bio is dispatched directly;
>  - tg_update_disptime(), never handle;
>  - throtl_dispatch_tg(), always handle;
> 
> The idea is that only handle when bio is dispatched, like following
> patch(not tested yet):
> 
> [yukuai@localhost linux-next]$ git diff
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 3828c6535605..20f6bab07960 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -703,10 +703,9 @@ static unsigned long tg_within_iops_limit(struct
> throtl_grp *tg, struct bio *bio
>  }
> 
>  static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio
> *bio,
> -                               u64 bps_limit, bool *has_debt)
> +                               u64 bps_limit, long long *carryover_bytes)
>  {
>         bool rw = bio_data_dir(bio);
> -       long long carryover_bytes;
>         long long bytes_allowed;
>         u64 extra_bytes;
>         unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
> @@ -731,16 +730,7 @@ static unsigned long tg_within_bps_limit(struct
> throtl_grp *tg, struct bio *bio,
> 
>         /* Calc approx time to dispatch */
>         extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
> -       jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit,
> &carryover_bytes);
> -       if (carryover_bytes) {
> -               /*
> -                * If extra_bytes is not divisible, the remainder is
> recorded as
> -                * debt. Caller must ensure the current slice has at least 1
> -                * more jiffies to repay the debt.
> -                */
> -               *has_debt = true;
> -               tg->carryover_bytes[rw] -= div64_u64(carryover_bytes, HZ);
> -       }
> +       jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit,
> carryover_bytes);
> 
>         /*
>          * This wait time is without taking into consideration the rounding
> @@ -755,13 +745,12 @@ static unsigned long tg_within_bps_limit(struct
> throtl_grp *tg, struct bio *bio,
>   * of jiffies to wait before this bio is with-in IO rate and can be
> dispatched
>   */
>  static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
> -                           unsigned long *wait)
> +                           unsigned long *wait, long long *carryover_bytes)
>  {
>         bool rw = bio_data_dir(bio);
>         unsigned long bps_wait = 0, iops_wait = 0, max_wait = 0;
>         u64 bps_limit = tg_bps_limit(tg, rw);
>         u32 iops_limit = tg_iops_limit(tg, rw);
> -       bool has_debt = false;
> 
>         /*
>          * Currently whole state machine of group depends on first bio
> @@ -792,20 +781,18 @@ static bool tg_may_dispatch(struct throtl_grp *tg,
> struct bio *bio,
>         else
>                 throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
> 
> -       bps_wait = tg_within_bps_limit(tg, bio, bps_limit, &has_debt);
> +       bps_wait = tg_within_bps_limit(tg, bio, bps_limit, carryover_bytes);
>         iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
>         if (bps_wait + iops_wait == 0) {
>                 if (wait)
>                         *wait = 0;
> -               if (has_debt)
> -                       throtl_extend_slice(tg, rw, jiffies + 1);
>                 return true;
>         }
> 
>         max_wait = max(bps_wait, iops_wait);
>         if (wait)
>                 *wait = max_wait;
> -       throtl_extend_slice(tg, rw, jiffies + max_wait + has_debt);
> +       throtl_extend_slice(tg, rw, jiffies + max_wait);
> 
>         return false;
>  }
> @@ -858,19 +845,33 @@ static void throtl_add_bio_tg(struct bio *bio, struct
> throtl_qnode *qn,
>         throtl_enqueue_tg(tg);
>  }
> 
> +static void handle_tg_carryover_bytes(struct throtl_grp *tg,
> +                                     long long carryover_bytes, int rw)
> +{
> +       if (carryover_bytes == 0)
> +               return;
> +       /*
> +        * IO is dispatched without waiting for @carryover_bytes, make sure
> +        * current slice has 1 more jiffies to repay the debt.
> +        */
> +       tg->carryover_bytes[rw] -= carryover_bytes;
> +       throtl_extend_slice(tg, rw, tg->slice_end[rw] + 1);
> +}
> +
>  static void tg_update_disptime(struct throtl_grp *tg)
>  {
>         struct throtl_service_queue *sq = &tg->service_queue;
>         unsigned long read_wait = -1, write_wait = -1, min_wait = -1,
> disptime;
> +       long long carryover_bytes = 0;
>         struct bio *bio;
> 
>         bio = throtl_peek_queued(&sq->queued[READ]);
>         if (bio)
> -               tg_may_dispatch(tg, bio, &read_wait);
> +               tg_may_dispatch(tg, bio, &read_wait, &carryover_bytes);
> 
>         bio = throtl_peek_queued(&sq->queued[WRITE]);
>         if (bio)
> -               tg_may_dispatch(tg, bio, &write_wait);
> +               tg_may_dispatch(tg, bio, &write_wait, &carryover_bytes);
> 
>         min_wait = min(read_wait, write_wait);
>         disptime = jiffies + min_wait;
> @@ -943,12 +944,15 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
>         unsigned int nr_reads = 0, nr_writes = 0;
>         unsigned int max_nr_reads = THROTL_GRP_QUANTUM * 3 / 4;
>         unsigned int max_nr_writes = THROTL_GRP_QUANTUM - max_nr_reads;
> +       long long carryover_bytes = 0;
>         struct bio *bio;
> 
>         /* Try to dispatch 75% READS and 25% WRITES */
> 
>         while ((bio = throtl_peek_queued(&sq->queued[READ])) &&
> -              tg_may_dispatch(tg, bio, NULL)) {
> +              tg_may_dispatch(tg, bio, NULL, &carryover_bytes)) {
> +               handle_tg_carryover_bytes(tg, carryover_bytes, READ);
> +               carryover_bytes = 0;
> 
>                 tg_dispatch_one_bio(tg, READ);
>                 nr_reads++;
> @@ -958,7 +962,9 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
>         }
> 
>         while ((bio = throtl_peek_queued(&sq->queued[WRITE])) &&
> -              tg_may_dispatch(tg, bio, NULL)) {
> +              tg_may_dispatch(tg, bio, NULL, &carryover_bytes)) {
> +               handle_tg_carryover_bytes(tg, carryover_bytes, WRITE);
> +               carryover_bytes = 0;
> 
>                 tg_dispatch_one_bio(tg, WRITE);
>                 nr_writes++;
> @@ -1613,11 +1619,18 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
> 
>  static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool
> rw)
>  {
> +       long long carryover_bytes = 0;
> +
>         /* throtl is FIFO - if bios are already queued, should queue */
>         if (tg->service_queue.nr_queued[rw])
>                 return false;
> 
> -       return tg_may_dispatch(tg, bio, NULL);
> +       if (tg_may_dispatch(tg, bio, NULL, &carryover_bytes)) {
> +               handle_tg_carryover_bytes(tg, carryover_bytes, rw);
> +               return true;
> +       }
> +
> +       return false;
>  }
> 
>  static void tg_dispatch_in_debt(struct throtl_grp *tg, struct bio *bio,
> bool rw)
> 
> 
> > Actually this patch changes tg_within_bps_limit() to one stateful function...
> > 
> > >   	/*
> > >   	 * This wait time is without taking into consideration the rounding
> > > @@ -754,6 +761,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
> > >   	unsigned long bps_wait = 0, iops_wait = 0, max_wait = 0;
> > >   	u64 bps_limit = tg_bps_limit(tg, rw);
> > >   	u32 iops_limit = tg_iops_limit(tg, rw);
> > > +	bool has_debt = false;
> > >   	/*
> > >    	 * Currently whole state machine of group depends on first bio
> > > @@ -784,18 +792,20 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
> > >   	else
> > >   		throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
> > > -	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
> > > +	bps_wait = tg_within_bps_limit(tg, bio, bps_limit, &has_debt);
> > >   	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
> > >   	if (bps_wait + iops_wait == 0) {
> > >   		if (wait)
> > >   			*wait = 0;
> > > +		if (has_debt)
> > > +			throtl_extend_slice(tg, rw, jiffies + 1);
> > >   		return true;
> > >   	}
> > >   	max_wait = max(bps_wait, iops_wait);
> > >   	if (wait)
> > >   		*wait = max_wait;
> > > -	throtl_extend_slice(tg, rw, jiffies + max_wait);
> > > +	throtl_extend_slice(tg, rw, jiffies + max_wait + has_debt);
> > >   	return false;
> > >   }
> > > diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> > > index 1a36d1278eea..56dcb5ce412f 100644
> > > --- a/block/blk-throttle.h
> > > +++ b/block/blk-throttle.h
> > > @@ -110,10 +110,14 @@ struct throtl_grp {
> > >   	unsigned int last_io_disp[2];
> > >   	/*
> > > -	 * The following two fields are updated when new configuration is
> > > -	 * submitted while some bios are still throttled, they record how many
> > > -	 * bytes/ios are waited already in previous configuration, and they will
> > > -	 * be used to calculate wait time under new configuration.
> > > +	 * The following two fields are updated when:
> > > +	 * 1) new configuration is submitted while some bios are still
> > > +	 * throttled, they record how many bytes/ios are waited already in
> > > +	 * previous configuration;
> > > +	 * 2) IOs which may cause priority inversions are dispatched while tg is
> > > +	 * over limit, these IOs will be dispatched directly;
> > > +	 * 3) While calculating wait_time for IO, extra_bytes * HZ is not
> > > +	 * divisible by bps_limit, the remainder will be recorded;
> > >   	 */
> > 
> > blk-throttle takes token bucket algorithm, and the implementation
> > shouldn't be sensitive with the above two factors, because the bps
> > rate is controlled over the whole bucket(slice). Meantime it is still
> > tricky to maintain ->carryover_bytes during slice cycle, which can't
> > cover timer delay too.
> > 
> > Another way is to avoid to trim slice too soon in case of owning too
> > much debt, something like the following does avoid this issue:
> 
> 
> > 
> > 
> > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > index 8d149aff9fd0..a778ebbb6887 100644
> > --- a/block/blk-throttle.c
> > +++ b/block/blk-throttle.c
> > @@ -615,6 +615,14 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
> >   	if (bytes_trim <= 0 && io_trim <= 0)
> >   		return;
> > +	if (tg_bps_limit(tg, rw) != U64_MAX) {
> > +		long long disp = tg->bytes_disp[rw];
> > +
> > +		if (bytes_trim > disp && (bytes_trim - disp) > disp / 2 && time_elapsed <
> > +				8 * tg->td->throtl_slice)
> > +			return;
> > +	}
> 
> I'm not sure why we need this, why will there be too much debt? debt
> from remainder should be at most 1 jiffies, new debt can only happen
> when old debt is paid.

Maybe term of `debt` is not accurate.

In throtl_trim_slice(), if we dispatched much less bytes than expected(bytes_trim),
there should be extra delay introduced, such as, extra one jiffy because
of roundup(), or timer expire delay, we shouldn't reset the slice because actual
rate(bps here) is much less than bps_limit.

> 
> If you mean we don't clear debt in time, and the historical debt
> accumulated too much, then we might want to trim slice sooner and a new
> branch try to clear historical debt.
> 
> BTW, throtl_trim_slice() looks like problematic:
> 
> -       if (bytes_trim <= 0 && io_trim <= 0)
> +       if (bytes_trim <= 0 || io_trim <= 0 ||
> +           tg->bytes_disp[rw] < bytes_trim || tg->io_disp[rw] < io_trim)
>                 return;

That is exactly what my patch is doing, just taking deviation and
timeout into account, also U64_MAX limit has to be excluded.

If you test the patch, it works just fine. My patch controls bytes_exp 
<= 1.5 * disp, then throtl/001 can be completed in 1.5sec, and if it is
changed to 1.25 * disp, the test can be completed in 1.25sec.

With this fix, why do we have to play the complicated carryover
trick?


Thanks,
Ming



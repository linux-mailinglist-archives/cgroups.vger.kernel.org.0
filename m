Return-Path: <cgroups+bounces-6647-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA61A40845
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2025 13:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAF819C6547
	for <lists+cgroups@lfdr.de>; Sat, 22 Feb 2025 12:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28692080EE;
	Sat, 22 Feb 2025 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDmq1Geq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D52063DC
	for <cgroups@vger.kernel.org>; Sat, 22 Feb 2025 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740226622; cv=none; b=GAAb22Hgyw+GJf+obu+mh5BNsNQlbNrynqK20B8UVVfFXkqpZlAJEkm19pgcixi6/wMLmjvoMp35VQxIbR72LjlDDYczx1ZloyDDrRw235rX0AjCQVFCZspoSxaeh/rmOAeWZqUkmdtFVJ+u+ZEG2E6TVEAMF6XNS6QxkEMAFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740226622; c=relaxed/simple;
	bh=uEFkS5f4I1pkgXfi+lR9dCubxCkxmZemaOLaMMW1bBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn2zTvhhAYSot98FBAwteGxYxBg+puMUguwtiFqDMHAR5Flgsls5Bd1EH4lqvspUtpDKVnUhRpaQg0cax4Es4tX6Hhvh3o+B522wVpJgzxp5qP6Mh1xU6f8UbJc/LQDmNiw8hQU6UHDSX2HTOTsatOKuHGrv59UyTAD+8OyJuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDmq1Geq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740226619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bTUI9x2p0yOdOJ1ZQhAAeGjQUlFKi+22DsGpMCU78nI=;
	b=EDmq1Geq6iaYDkkGNt2MMOGJJHC0hWd5CwKrlYeO7AzNF6nf1SCEonJvzpaqR0bmor59ek
	9k2uNuS3Tik4hAPt+lKhJRZMnUM7QeMaCvBvUlpPD99NywRMoiuQh3woaR4CJdCR0owJEL
	N44698Dq01uRgNhMu0BFV/uuZKXkhAY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-kTktK0WFPHWBxD4dtR_D2g-1; Sat,
 22 Feb 2025 07:16:54 -0500
X-MC-Unique: kTktK0WFPHWBxD4dtR_D2g-1
X-Mimecast-MFC-AGG-ID: kTktK0WFPHWBxD4dtR_D2g_1740226612
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A83B41800878;
	Sat, 22 Feb 2025 12:16:51 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20D5119412A3;
	Sat, 22 Feb 2025 12:16:43 +0000 (UTC)
Date: Sat, 22 Feb 2025 20:16:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 2/2] blk-throttle: fix off-by-one jiffies wait_time
Message-ID: <Z7nAJSKGANoC0Glb@fedora>
References: <20250222092823.210318-1-yukuai1@huaweicloud.com>
 <20250222092823.210318-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222092823.210318-3-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Yukuai,

On Sat, Feb 22, 2025 at 05:28:23PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> wait_time is based on jiffies, and the calculation is:
> 
> wait_time = extra_bytes * HZ / bps_limit;
> 
> If wait time is not zero, the remainder is ignored, means wait time is
> short by at most 1 jiffes; On the other hand, if wait time is zero, it
> will be used as 1 jiffies, means it's excessive by at most 1 jiffes.
> 
> This way causes blktests throtl/001 failure in case of CONFIG_HZ_100=y,
> fix the problem by recording remainder as debt, and repay the debt
> later.

After further analysis, I figured out that this one extra jiffy isn't the
only reason for throtl/001 failure.

In blktests throtl/001, bps_limit is 1MB/sec, and BS is 4k, and
COFIG_HZ=100, and default throttle slice is 2 jiffies(20ms):

- 20ms can submit 5 bios: 1024K/50(5*4k=20KB)

- the 6th bio is throttled, and the calculated wait is 1 jiffy from
tg_within_bps_limit()

- given all the 6 bios are handled in the time of jiffies A, so A + 1(wait) + 2(slice)
is programmed to start pending timer for scheduling dispatch

- when the pending timer is expired, the 6th bio is submitted, then the
  current slice is trim/reset since the throttled 6th bio is dispatched.

Now in the whole throttle slice period, 6 bios(24KB) are submitted, and 3
jiffies are taken, so 256 bios will take (256/6) * 30ms = 1.3sec.

But blktests throtl/001 still should pass since the allowed deviation is 0.5sec,
and 1.3 < 1.5.

Actually there is another reason of timer delay, looks one extra jiffy is
delayed when the timer is triggered, which can be observed reliably by:

bpftrace -e 'kfunc:throtl_pending_timer_fn { @timer_expire_delay = lhist(jiffies - args->t->expires, 0, 16, 1);}'

Then 256 bios will take (256/6) * 40ms = 1.7sec, which does match with
observation in throtl/001.

Yeah, killing one jiffy may pass blktests throtl/001, but, ...

> 
> Reported-and-tested-by: Ming Lei <ming.lei@redhat.com>
> Closes: https://lore.kernel.org/all/20250220111735.1187999-1-ming.lei@redhat.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-throttle.c | 24 +++++++++++++++++-------
>  block/blk-throttle.h | 12 ++++++++----
>  2 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 0096e486b1e3..3828c6535605 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -703,9 +703,10 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
>  }
>  
>  static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
> -				u64 bps_limit)
> +				u64 bps_limit, bool *has_debt)
>  {
>  	bool rw = bio_data_dir(bio);
> +	long long carryover_bytes;
>  	long long bytes_allowed;
>  	u64 extra_bytes;
>  	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
> @@ -730,10 +731,16 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>  
>  	/* Calc approx time to dispatch */
>  	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
> -	jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
> -
> -	if (!jiffy_wait)
> -		jiffy_wait = 1;
> +	jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit, &carryover_bytes);
> +	if (carryover_bytes) {
> +		/*
> +		 * If extra_bytes is not divisible, the remainder is recorded as
> +		 * debt. Caller must ensure the current slice has at least 1
> +		 * more jiffies to repay the debt.
> +		 */
> +		*has_debt = true;
> +		tg->carryover_bytes[rw] -= div64_u64(carryover_bytes, HZ);
> +	}

Thinking of further, it may not be good to use ->carryover_bytes[]:

- if tg_within_bps_limit() returns 0 and the bio is dispatched
  immediately, throtl_trim_slice() is called and ->carryover_bytes[]
  is cleared.

- if tg_within_bps_limit() returns >0, this bio will be throttled, and
  tg_within_bps_limit() may be called more than one time, so
  tg->carryover_bytes[] could be over-counted.

Actually this patch changes tg_within_bps_limit() to one stateful function...

>  
>  	/*
>  	 * This wait time is without taking into consideration the rounding
> @@ -754,6 +761,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>  	unsigned long bps_wait = 0, iops_wait = 0, max_wait = 0;
>  	u64 bps_limit = tg_bps_limit(tg, rw);
>  	u32 iops_limit = tg_iops_limit(tg, rw);
> +	bool has_debt = false;
>  
>  	/*
>   	 * Currently whole state machine of group depends on first bio
> @@ -784,18 +792,20 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>  	else
>  		throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
>  
> -	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
> +	bps_wait = tg_within_bps_limit(tg, bio, bps_limit, &has_debt);
>  	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
>  	if (bps_wait + iops_wait == 0) {
>  		if (wait)
>  			*wait = 0;
> +		if (has_debt)
> +			throtl_extend_slice(tg, rw, jiffies + 1);
>  		return true;
>  	}
>  
>  	max_wait = max(bps_wait, iops_wait);
>  	if (wait)
>  		*wait = max_wait;
> -	throtl_extend_slice(tg, rw, jiffies + max_wait);
> +	throtl_extend_slice(tg, rw, jiffies + max_wait + has_debt);
>  
>  	return false;
>  }
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 1a36d1278eea..56dcb5ce412f 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -110,10 +110,14 @@ struct throtl_grp {
>  	unsigned int last_io_disp[2];
>  
>  	/*
> -	 * The following two fields are updated when new configuration is
> -	 * submitted while some bios are still throttled, they record how many
> -	 * bytes/ios are waited already in previous configuration, and they will
> -	 * be used to calculate wait time under new configuration.
> +	 * The following two fields are updated when:
> +	 * 1) new configuration is submitted while some bios are still
> +	 * throttled, they record how many bytes/ios are waited already in
> +	 * previous configuration;
> +	 * 2) IOs which may cause priority inversions are dispatched while tg is
> +	 * over limit, these IOs will be dispatched directly;
> +	 * 3) While calculating wait_time for IO, extra_bytes * HZ is not
> +	 * divisible by bps_limit, the remainder will be recorded;
>  	 */

blk-throttle takes token bucket algorithm, and the implementation
shouldn't be sensitive with the above two factors, because the bps
rate is controlled over the whole bucket(slice). Meantime it is still
tricky to maintain ->carryover_bytes during slice cycle, which can't
cover timer delay too.

Another way is to avoid to trim slice too soon in case of owning too
much debt, something like the following does avoid this issue:


diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8d149aff9fd0..a778ebbb6887 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -615,6 +615,14 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	if (bytes_trim <= 0 && io_trim <= 0)
 		return;
 
+	if (tg_bps_limit(tg, rw) != U64_MAX) {
+		long long disp = tg->bytes_disp[rw];
+
+		if (bytes_trim > disp && (bytes_trim - disp) > disp / 2 && time_elapsed <
+				8 * tg->td->throtl_slice)
+			return;
+	}
+
 	tg->carryover_bytes[rw] = 0;
 	if ((long long)tg->bytes_disp[rw] >= bytes_trim)
 		tg->bytes_disp[rw] -= bytes_trim;


Thanks,
Ming



Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DCA52D15C
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 13:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbiESLXN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 07:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiESLXM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 07:23:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F63A43ACE;
        Thu, 19 May 2022 04:23:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DEC2A1F86B;
        Thu, 19 May 2022 11:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652959389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4XMs2PfJJxMSCtw3+dlKPeSG6t2757cBDz7HszTEFRA=;
        b=Jfd0Hdx/+XAXVGBIGSB71o9MzgnDAVNawEmkvzsB+T+4qZBDUKedP7NIIsH/f3dlDVkAL9
        V/d9Hwzc6lNyQPPI4k4iGdz2i6MYwcLv7yT0IzvKj8xYVgbCBi7jlxsExccAVSguYk/Tf7
        KT+eG/HIcFZjZQPogPiJhFuV8M8Wk9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652959389;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4XMs2PfJJxMSCtw3+dlKPeSG6t2757cBDz7HszTEFRA=;
        b=vjAt2hndsGH5SowgV5vGFGaa5KhU4Trw/9za9vF1e6TlWkxcbRvX5cjD6/s8b6s0zFdx8F
        0gfrocjMErZCROAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C87A02C141;
        Thu, 19 May 2022 11:23:09 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 841EEA062F; Thu, 19 May 2022 13:23:09 +0200 (CEST)
Date:   Thu, 19 May 2022 13:23:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 8/8] block, bfq: cleanup
 bfq_bfqq_handle_idle_busy_switch()
Message-ID: <20220519112309.nhbulnc5iz424ohl@quack3.lan>
References: <20220514090522.1669270-1-yukuai3@huawei.com>
 <20220514090522.1669270-9-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514090522.1669270-9-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 14-05-22 17:05:22, Yu Kuai wrote:
> 'wr_or_deserves_wr' is only used in bfq_update_bfqq_wr_on_rq_arrival(),
> which is only called from bfq_bfqq_handle_idle_busy_switch() in specific
> code branch, thus there is no need to precaculate 'wr_or_deserves_wr'
> each time bfq_bfqq_handle_idle_busy_switch() is called.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

With this patch there's the same problem as with the previous one. Some of
the variables passed to bfq_update_bfqq_wr_on_rq_arrival() (in_burst,
soft_rt) would actually evaluate differently later in the function.

								Honza

> ---
>  block/bfq-iosched.c | 110 +++++++++++++++++++++++++-------------------
>  1 file changed, 62 insertions(+), 48 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 1e57d76c8dd3..cea8cb3f5ee2 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -1624,15 +1624,65 @@ static unsigned long bfq_smallest_from_now(void)
>  	return jiffies - MAX_JIFFY_OFFSET;
>  }
>  
> +/*
> + * bfqq deserves to be weight-raised if:
> + * - it is sync,
> + * - it does not belong to a large burst,
> + * - it has been idle for enough time or is soft real-time,
> + * - is linked to a bfq_io_cq (it is not shared in any sense),
> + * - has a default weight (otherwise we assume the user wanted
> + *   to control its weight explicitly)
> + *
> + * Merged bfq_queues are kept out of weight-raising
> + * (low-latency) mechanisms. The reason is that these queues
> + * are usually created for non-interactive and
> + * non-soft-real-time tasks. Yet this is not the case for
> + * stably-merged queues. These queues are merged just because
> + * they are created shortly after each other. So they may
> + * easily serve the I/O of an interactive or soft-real time
> + * application, if the application happens to spawn multiple
> + * processes. So let also stably-merged queued enjoy weight
> + * raising.
> + */
> +static bool bfqq_wr_or_deserves_wr(struct bfq_data *bfqd,
> +				   struct bfq_queue *bfqq,
> +				   struct request *rq,
> +				   bool interactive, bool soft_rt)
> +{
> +	if (!bfqd->low_latency)
> +		return false;
> +
> +	if (bfqq->wr_coeff > 1)
> +		return true;
> +
> +	if (!bfq_bfqq_sync(bfqq))
> +		return false;
> +
> +	if (!bfqq->bic && !RQ_BIC(rq)->stably_merged)
> +		return false;
> +
> +	if (!interactive && !soft_rt)
> +		return false;
> +
> +	return true;
> +}
> +
>  static void bfq_update_bfqq_wr_on_rq_arrival(struct bfq_data *bfqd,
>  					     struct bfq_queue *bfqq,
>  					     unsigned int old_wr_coeff,
> -					     bool wr_or_deserves_wr,
> -					     bool interactive,
> -					     bool in_burst,
> -					     bool soft_rt)
> -{
> -	if (old_wr_coeff == 1 && wr_or_deserves_wr) {
> +					     struct request *rq,
> +					     bool interactive)
> +{
> +	bool in_burst = bfq_bfqq_in_large_burst(bfqq);
> +	bool soft_rt = bfqd->bfq_wr_max_softrt_rate > 0 &&
> +		       !BFQQ_TOTALLY_SEEKY(bfqq) &&
> +		       !in_burst &&
> +		       time_is_before_jiffies(bfqq->soft_rt_next_start) &&
> +		       bfqq->dispatched == 0 &&
> +		       bfqq->entity.new_weight == 40;
> +
> +	if (old_wr_coeff == 1 &&
> +	    bfqq_wr_or_deserves_wr(bfqd, bfqq, rq, interactive, soft_rt)) {
>  		/* start a weight-raising period */
>  		if (interactive) {
>  			bfqq->service_from_wr = 0;
> @@ -1674,9 +1724,9 @@ static void bfq_update_bfqq_wr_on_rq_arrival(struct bfq_data *bfqd,
>  		if (interactive) { /* update wr coeff and duration */
>  			bfqq->wr_coeff = bfqd->bfq_wr_coeff;
>  			bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
> -		} else if (in_burst)
> +		} else if (in_burst) {
>  			bfqq->wr_coeff = 1;
> -		else if (soft_rt) {
> +		} else if (soft_rt) {
>  			/*
>  			 * The application is now or still meeting the
>  			 * requirements for being deemed soft rt.  We
> @@ -1768,44 +1818,11 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>  					     struct request *rq,
>  					     bool *interactive)
>  {
> -	bool soft_rt, in_burst,	wr_or_deserves_wr,
> -		idle_for_long_time = bfq_bfqq_idle_for_long_time(bfqd, bfqq);
> +	bool in_burst = bfq_bfqq_in_large_burst(bfqq);
> +	bool idle_for_long_time = bfq_bfqq_idle_for_long_time(bfqd, bfqq);
>  
> -	/*
> -	 * bfqq deserves to be weight-raised if:
> -	 * - it is sync,
> -	 * - it does not belong to a large burst,
> -	 * - it has been idle for enough time or is soft real-time,
> -	 * - is linked to a bfq_io_cq (it is not shared in any sense),
> -	 * - has a default weight (otherwise we assume the user wanted
> -	 *   to control its weight explicitly)
> -	 */
> -	in_burst = bfq_bfqq_in_large_burst(bfqq);
> -	soft_rt = bfqd->bfq_wr_max_softrt_rate > 0 &&
> -		!BFQQ_TOTALLY_SEEKY(bfqq) &&
> -		!in_burst &&
> -		time_is_before_jiffies(bfqq->soft_rt_next_start) &&
> -		bfqq->dispatched == 0 &&
> -		bfqq->entity.new_weight == 40;
>  	*interactive = !in_burst && idle_for_long_time &&
>  		bfqq->entity.new_weight == 40;
> -	/*
> -	 * Merged bfq_queues are kept out of weight-raising
> -	 * (low-latency) mechanisms. The reason is that these queues
> -	 * are usually created for non-interactive and
> -	 * non-soft-real-time tasks. Yet this is not the case for
> -	 * stably-merged queues. These queues are merged just because
> -	 * they are created shortly after each other. So they may
> -	 * easily serve the I/O of an interactive or soft-real time
> -	 * application, if the application happens to spawn multiple
> -	 * processes. So let also stably-merged queued enjoy weight
> -	 * raising.
> -	 */
> -	wr_or_deserves_wr = bfqd->low_latency &&
> -		(bfqq->wr_coeff > 1 ||
> -		 (bfq_bfqq_sync(bfqq) &&
> -		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
> -		   (*interactive || soft_rt)));
>  
>  	/*
>  	 * If bfqq happened to be activated in a burst, but has been
> @@ -1840,11 +1857,8 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>  		if (time_is_before_jiffies(bfqq->split_time +
>  					   bfqd->bfq_wr_min_idle_time)) {
>  			bfq_update_bfqq_wr_on_rq_arrival(bfqd, bfqq,
> -							 old_wr_coeff,
> -							 wr_or_deserves_wr,
> -							 *interactive,
> -							 in_burst,
> -							 soft_rt);
> +							 old_wr_coeff, rq,
> +							 *interactive);
>  
>  			if (old_wr_coeff != bfqq->wr_coeff)
>  				bfqq->entity.prio_changed = 1;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

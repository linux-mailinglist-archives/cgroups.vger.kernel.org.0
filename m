Return-Path: <cgroups+bounces-9447-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C345B389F4
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 20:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F004517C0B2
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B892E5B11;
	Wed, 27 Aug 2025 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9dGK90d"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531D276048
	for <cgroups@vger.kernel.org>; Wed, 27 Aug 2025 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756321102; cv=none; b=j8pDRtlprs6rjYcaKUnmOONQnnDaWg9OvymGELMyT6cf6HuhwA3i2qf4jePxD/3OEuUcF2VngW0YqjMtI5plYPbnr+PUIcOJg6KW192vH6vQnEgdJ2w97CDMu72PidO8UNjGcYDRv4+VfI6S2DyVpFhIXq8B2v7gs/cBWna/vIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756321102; c=relaxed/simple;
	bh=5Gyv4X1Tqg+4AnDyOQUvhP/AeCmJe0OWG5RaUTEjY1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+SnPPdGQ8xGBWOyTFh6j+r7Q3dbkd6lEo8AUVgfkjqcIGDt6ZK7nJlsl1nnLrhJlKk2c4JjjM5xcKf0BJ3Yr008EYI0Qu3daBFr5QKjopDt9Ridr1+krKF06qA1C3dczaV6Enlg0KSHSWJRtCAIZIyqv2DaxyOKOKmBOpz1Nqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9dGK90d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821B0C4CEEB;
	Wed, 27 Aug 2025 18:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756321101;
	bh=5Gyv4X1Tqg+4AnDyOQUvhP/AeCmJe0OWG5RaUTEjY1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9dGK90d9raYoU61eopREmg/6Q8VwGy1GFyM3/EiASEqRn32FBngL1hxSLw3SslED
	 DYpM5Q4fCrJAuIPdeEsdXgaY2pFoRa8dmt9z9BgoMiVYul7fWta2pYVwzVQAeEfiPX
	 fYrSLbBQ6xpchUjv6ZtNUIYJzuU1ChYSlvofjkOmemD0B+uOiul+cFjXiYFLWTIkIf
	 QwI0cz3L7NPcBooRz9oV7+ko8EOmqvmdukO0xV4MlZbPLNbsS+EX2MHwEchquCeepo
	 MFevgwQQiKMZpJa+iGp2o+rU/xXkjlxrDwP0xFzyvuH8hEG64D1Lzlf4Vpyvu9cOaD
	 CLupkoqSIISOw==
Date: Wed, 27 Aug 2025 08:58:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
	muchun.song@linux.dev
Subject: Re: [PATCH v3] memcg: Don't wait writeback completion when release
 memcg.
Message-ID: <aK9VTIQDA8I2vvNi@slm.duckdns.org>
References: <20250827181356.40971-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827181356.40971-1-sunjunchao@bytedance.com>

Hello,

On Thu, Aug 28, 2025 at 02:13:56AM +0800, Julian Sun wrote:
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 2ad261082bba..6c1ed286da6a 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -65,6 +65,13 @@ struct wb_completion {
>  	wait_queue_head_t	*waitq;
>  };
>  
> +static inline void wb_completion_init(struct wb_completion *done,
> +									  struct wait_queue_head *waitq)

Indentation.

> +{
> +	atomic_set(&done->cnt, 1);
> +	done->waitq = waitq;
> +}
> +
>  #define __WB_COMPLETION_INIT(_waitq)	\
>  	(struct wb_completion){ .cnt = ATOMIC_INIT(1), .waitq = (_waitq) }
>  
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 785173aa0739..24e881ce4909 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -157,11 +157,17 @@ struct mem_cgroup_thresholds {
>   */
>  #define MEMCG_CGWB_FRN_CNT	4
>  
> +struct cgwb_frn_wait {
> +	struct wb_completion done;
> +	struct wait_queue_entry wq_entry;
> +};
> +
>  struct memcg_cgwb_frn {
>  	u64 bdi_id;			/* bdi->id of the foreign inode */
>  	int memcg_id;			/* memcg->css.id of foreign inode */
>  	u64 at;				/* jiffies_64 at the time of dirtying */
> -	struct wb_completion done;	/* tracks in-flight foreign writebacks */
> +	struct wb_completion *done;	/* tracks in-flight foreign writebacks */
> +	struct cgwb_frn_wait *wait;	/* used to free resources when release memcg */

Is ->done still needed? Can't it just do frn->wait.done?

> +#ifdef CONFIG_CGROUP_WRITEBACK
> +static int memcg_cgwb_waitq_callback_fn(struct wait_queue_entry *wq_entry, unsigned int mode,
> +					int flags, void *key)
> +{
> +	struct cgwb_frn_wait *frn_wait = container_of(wq_entry,
> +						      struct cgwb_frn_wait, wq_entry);
> +
> +	list_del(&wq_entry->entry);
> +	kfree(frn_wait);
> +
> +	return 0;
> +}
> +#endif

Note that the above will be called for all queued waits when any one entry
triggers. It'd need to check whether done is zero before self-deleting and
freeing.

> @@ -3912,8 +3938,18 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>  	int __maybe_unused i;
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> -	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
> -		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> +	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> +		struct memcg_cgwb_frn *frn = &memcg->cgwb_frn[i];
> +
> +		if (atomic_dec_and_test(&frn->done->cnt))
> +			kfree(frn->wait);
> +		else
> +			/*
> +			 * Not necessary to wait for wb completion which might cause task hung,
> +			 * only used to free resources. See memcg_cgwb_waitq_callback_fn().
> +			 */
> +			__add_wait_queue_entry_tail(frn->done->waitq, &frn->wait->wq_entry);
> +	}

And then, this can probably be simplified to sth like:

        __add_wait_queue_entry_tail(...);
        if (atomic_dec_and_test(&frn->done->dnt);
                wake_up_all(waitq);

Thanks.

-- 
tejun


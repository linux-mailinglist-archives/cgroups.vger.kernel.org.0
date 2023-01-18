Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E961867246B
	for <lists+cgroups@lfdr.de>; Wed, 18 Jan 2023 18:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjARRFZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Jan 2023 12:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjARRFX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Jan 2023 12:05:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E96A56ED4;
        Wed, 18 Jan 2023 09:05:23 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 7-20020a17090a098700b002298931e366so2804857pjo.2;
        Wed, 18 Jan 2023 09:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxdDRugRMl6w2Hk+hXG/ZT8UvsTDOnHjgkdiS6Eozqs=;
        b=mcQGELIQeyEZdbxZ9QQ3xRdRMXlxomQd5A4kxDz83vli8N9Oz8WhYw33KOwkt7MsYl
         8BXVjSzh1nc1MBHLhCkZ0OYk3iwTIZB0TLynjsIdbHz2vk3rT+BX6/BSfhXtePgitmbW
         3x6Xg/dj8QvZtO+N/MjX6tUcHhPYlIcB6D8o/RPFakPQPHMz26aFb/+iAxcyJc5TdbU1
         5eGWtIsBjxvkyTXtbYTy866KlKxe6aIzJ2zZLyUkUQgN5XCwZmVthS5E8nV0Lb9YfqYz
         CGFQE0giXRJ5RAa7jVSulNnZUEV0qGBOBVo7F1NVyv+sEOoJ2l6OrU6EkI/kIQkYbD/n
         nlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxdDRugRMl6w2Hk+hXG/ZT8UvsTDOnHjgkdiS6Eozqs=;
        b=P7J6K83KBe5nBC+8Z+aWwFSMz5R9UzPtzuRJ5kFg7N59TrclI34wj9p859EwL20r+i
         jMhhfl5SyY8XansXCm9cA6kP/A2Npi1GBDHDWyUfQfPeRjmr14JiaMWHpvJnDj+uWlG5
         JSrR/NwVcCgwP1bIEJwY5Ia3QQJDHyTqhQTC6T4sHFaiUVxz5j1AWorXB8AXSfaQ2TJv
         A7ETZYGyx7R9bJT/pfS41JmtFniAAEswjxQsJXpCTqsb6HDzfTpPRkybfLQ8gpwwbRZ6
         4fmJLMSa2qKzhvYEfkIUBKrGs/GIjl3Um3INXe8RMiLWvdKGMnm5GHG49/Y2r7eUUbS4
         /hNQ==
X-Gm-Message-State: AFqh2kqj4EPbNWE/6HTypnFREm0HOQO06JKnX8TrLzUu7LWp3FNJDYws
        aHley4/TYNrescmfonCAYVo=
X-Google-Smtp-Source: AMrXdXu4/TmlWD+3RN7Qu59GSXLsA5Ii/qYatnxiIF7/9gyQ2VPBduYu1IAzuCjkUHs7/T+6hBrOwQ==
X-Received: by 2002:a05:6a21:918a:b0:b8:7bfc:7a32 with SMTP id tp10-20020a056a21918a00b000b87bfc7a32mr7327780pzb.2.1674061522555;
        Wed, 18 Jan 2023 09:05:22 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b00188ea79fae0sm23449241plx.48.2023.01.18.09.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:05:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 18 Jan 2023 07:05:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v2 3/3] blk-cgroup: synchronize pd_free_fn() from
 blkg_free_workfn() and blkcg_deactivate_policy()
Message-ID: <Y8gm0BVh5d83lVXN@slm.duckdns.org>
References: <20230118123152.1926314-1-yukuai1@huaweicloud.com>
 <20230118123152.1926314-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118123152.1926314-4-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Jan 18, 2023 at 08:31:52PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently parent pd can be freed before child pd:
> 
> t1: remove cgroup C1
> blkcg_destroy_blkgs
>  blkg_destroy
>   list_del_init(&blkg->q_node)
>   // remove blkg from queue list
>   percpu_ref_kill(&blkg->refcnt)
>    blkg_release
>     call_rcu
> 
> t2: from t1
> __blkg_release
>  blkg_free
>   schedule_work
> 			t4: deactivate policy
> 			blkcg_deactivate_policy
> 			 pd_free_fn
> 			 // parent of C1 is freed first
> t3: from t2
>  blkg_free_workfn
>   pd_free_fn
> 
> If policy(for example, ioc_timer_fn() from iocost) access parent pd from
> child pd after pd_offline_fn(), then UAF can be triggered.
> 
> Fix the problem by delaying 'list_del_init(&blkg->q_node)' from
> blkg_destroy() to blkg_free_workfn(), and use a new disk level mutex to
                                            ^
                                            using

> protect blkg_free_workfn() and blkcg_deactivate_policy).
  ^                                                     ^
  synchronize?                                          ()

> @@ -118,16 +118,26 @@ static void blkg_free_workfn(struct work_struct *work)
>  {
>  	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
>  					     free_work);
> +	struct request_queue *q = blkg->q;
>  	int i;
>  
> +	if (q)
> +		mutex_lock(&q->blkcg_mutex);

A comment explaining what the above is synchronizing would be useful.

> +
>  	for (i = 0; i < BLKCG_MAX_POLS; i++)
>  		if (blkg->pd[i])
>  			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
>  
>  	if (blkg->parent)
>  		blkg_put(blkg->parent);
> -	if (blkg->q)
> -		blk_put_queue(blkg->q);
> +
> +	if (q) {
> +		if (!list_empty(&blkg->q_node))

We can drop the above if.

> +			list_del_init(&blkg->q_node);
> +		mutex_unlock(&q->blkcg_mutex);
> +		blk_put_queue(q);
> +	}
> +
>  	free_percpu(blkg->iostat_cpu);
>  	percpu_ref_exit(&blkg->refcnt);
>  	kfree(blkg);
> @@ -462,9 +472,14 @@ static void blkg_destroy(struct blkcg_gq *blkg)
>  	lockdep_assert_held(&blkg->q->queue_lock);
>  	lockdep_assert_held(&blkcg->lock);
>  
> -	/* Something wrong if we are trying to remove same group twice */
> -	WARN_ON_ONCE(list_empty(&blkg->q_node));
> -	WARN_ON_ONCE(hlist_unhashed(&blkg->blkcg_node));
> +	/*
> +	 * blkg is removed from queue list in blkg_free_workfn(), hence this
> +	 * function can be called from blkcg_destroy_blkgs() first, and then
> +	 * before blkg_free_workfn(), this function can be called again in
> +	 * blkg_destroy_all().

How about?

	 * blkg stays on the queue list until blkg_free_workfn(), hence this
	 * function can be called from blkcg_destroy_blkgs() first and again
	 * from blkg_destroy_all() before blkg_free_workfn().

> +	 */
> +	if (hlist_unhashed(&blkg->blkcg_node))
> +		return;
>  
>  	for (i = 0; i < BLKCG_MAX_POLS; i++) {
>  		struct blkcg_policy *pol = blkcg_policy[i];
> @@ -478,8 +493,11 @@ static void blkg_destroy(struct blkcg_gq *blkg)
>  
>  	blkg->online = false;
>  
> +	/*
> +	 * Delay deleting list blkg->q_node to blkg_free_workfn() to synchronize
> +	 * pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy().
> +	 */

So, it'd be better to add a more comprehensive comment in blkg_free_workfn()
explaining why we need this synchronization and how it works and then point
to it from here.

Other than comments, it looks great to me. Thanks a lot for your patience
and seeing it through.

-- 
tejun

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA2647BF1B
	for <lists+cgroups@lfdr.de>; Tue, 21 Dec 2021 12:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbhLULuE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Dec 2021 06:50:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48512 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhLULuD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Dec 2021 06:50:03 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 44B5D1F388;
        Tue, 21 Dec 2021 11:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640087401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2yJGv6PwZm+h69bbWkMgkF4JmLNrbjM8paByqi7U7s=;
        b=Ldra7s7/Icdw9g8CqDMD3k3J3YgK4h6W7Qje+x/Ww9btS1KinZLnrOEVjzvErpZKzO/VUw
        X+HcP7Kq5ZJp6wKuExHsWxy7hE1bu5VIKC/0geH8VJ/BrmYaNd1q4siTHvgr7b4vNXm28j
        sx5B0TPLBkLYMOQlRVgOv5ekBjuvwZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640087401;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2yJGv6PwZm+h69bbWkMgkF4JmLNrbjM8paByqi7U7s=;
        b=2GsGrTbs8ZAXcwBiofE2gvBx/6TAWxMhJc3fTTPTvOzF0jU7NxZ8+ePErKlD9OEeTnvDF8
        IkLTLI/AhTf/M6Bw==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 2E557A3B81;
        Tue, 21 Dec 2021 11:50:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 090CF1F2CEA; Tue, 21 Dec 2021 12:50:01 +0100 (CET)
Date:   Tue, 21 Dec 2021 12:50:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        jack@suse.cz, fchecconi@gmail.com, avanzini.arianna@gmail.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH 4/4] block, bfq: update pos_root for idle bfq_queue in
 bfq_bfqq_move()
Message-ID: <20211221115001.GD24748@quack2.suse.cz>
References: <20211221032135.878550-1-yukuai3@huawei.com>
 <20211221032135.878550-5-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221032135.878550-5-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 21-12-21 11:21:35, Yu Kuai wrote:
> During code review, we found that if bfqq is not busy in
> bfq_bfqq_move(), bfq_pos_tree_add_move() won't be called for the bfqq,
> thus bfqq->pos_root still points to the old bfqg. However, the ref
> that bfqq hold for the old bfqg will be released, so it's possible
> that the old bfqg can be freed. This is problematic because the freed
> bfqg can still be accessed by bfqq->pos_root.
> 
> Fix the problem by calling bfq_pos_tree_add_move() for idle bfqq
> as well.
> 
> Fixes: e21b7a0b9887 ("block, bfq: add full hierarchical scheduling and cgroups support")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

I'm just wondering, how can it happen that !bfq_bfqq_busy() queue is in
pos_tree? Because bfq_remove_request() takes care to remove bfqq from the
pos_tree...

								Honza

> ---
>  block/bfq-cgroup.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 8e8cf6b3d946..822dd28ecf53 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -677,7 +677,6 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
>  	else if (entity->on_st_or_in_serv)
>  		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
> -	bfqg_and_blkg_put(old_parent);
>  
>  	if (entity->parent &&
>  	    entity->parent->last_bfqq_created == bfqq)
> @@ -690,11 +689,16 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  	/* pin down bfqg and its associated blkg  */
>  	bfqg_and_blkg_get(bfqg);
>  
> -	if (bfq_bfqq_busy(bfqq)) {
> -		if (unlikely(!bfqd->nonrot_with_queueing))
> -			bfq_pos_tree_add_move(bfqd, bfqq);
> +	/*
> +	 * Don't leave the pos_root to old bfqg, since the ref to old bfqg will
> +	 * be released and the bfqg might be freed.
> +	 */
> +	if (unlikely(!bfqd->nonrot_with_queueing))
> +		bfq_pos_tree_add_move(bfqd, bfqq);
> +	bfqg_and_blkg_put(old_parent);
> +
> +	if (bfq_bfqq_busy(bfqq))
>  		bfq_activate_bfqq(bfqd, bfqq);
> -	}
>  
>  	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
>  		bfq_schedule_dispatch(bfqd);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

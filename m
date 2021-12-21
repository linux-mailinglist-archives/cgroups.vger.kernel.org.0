Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD2847BE0C
	for <lists+cgroups@lfdr.de>; Tue, 21 Dec 2021 11:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhLUKRA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Dec 2021 05:17:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41436 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhLUKRA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Dec 2021 05:17:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 57E8C1F388;
        Tue, 21 Dec 2021 10:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640081819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DwlLWjduFMONq98dJAYAgeIdej/YjReYCrkxEXLrVeA=;
        b=gTM2jBePOjSM4DDR4GxbKx29ve2KrQJ/s6U6GOPwbNhu/MovBndTVqvLoiJhslnliZDvRP
        id/HKrlPLQxnxYP+Kk3Jdc1ZfeoeUIA9i+7NiEGE9oE3VYYovO9Egtc0Xjt76+rc3Ccefu
        fSKCI6wX5T38bhTNJrEkHgPpk6qlQ1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640081819;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DwlLWjduFMONq98dJAYAgeIdej/YjReYCrkxEXLrVeA=;
        b=EFBZzDXhptWBR7NjK8IO6gJJwX6pwu7jcO4h2NUDvhHwr4Pc3I537H7C3jdEdxNWz7N7oj
        eSd0GrSYrlNPueDA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 46D5DA3B87;
        Tue, 21 Dec 2021 10:16:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2D0871E14A1; Tue, 21 Dec 2021 11:16:59 +0100 (CET)
Date:   Tue, 21 Dec 2021 11:16:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        jack@suse.cz, fchecconi@gmail.com, avanzini.arianna@gmail.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH 2/4] block, bfq: avoid moving bfqq to it's parent bfqg
Message-ID: <20211221101659.GB24748@quack2.suse.cz>
References: <20211221032135.878550-1-yukuai3@huawei.com>
 <20211221032135.878550-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221032135.878550-3-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 21-12-21 11:21:33, Yu Kuai wrote:
> Moving bfqq to it's parent bfqg is pointless.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Did you notice that this is happening often enough that the check is worth
it? Where do we do this?

								Honza

> ---
>  block/bfq-cgroup.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 24a5c5329bcd..0f62546a72d4 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -645,6 +645,11 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		   struct bfq_group *bfqg)
>  {
>  	struct bfq_entity *entity = &bfqq->entity;
> +	struct bfq_group *old_parent = bfq_group(bfqq);
> +
> +	/* No point to move bfqq to the same group */
> +	if (old_parent == bfqg)
> +		return;
>  
>  	/*
>  	 * Get extra reference to prevent bfqq from being freed in
> @@ -666,7 +671,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
>  	else if (entity->on_st_or_in_serv)
>  		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
> -	bfqg_and_blkg_put(bfqq_group(bfqq));
> +	bfqg_and_blkg_put(old_parent);
>  
>  	if (entity->parent &&
>  	    entity->parent->last_bfqq_created == bfqq)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

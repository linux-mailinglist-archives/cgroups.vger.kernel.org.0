Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079C6674FDE
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 09:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjATIyc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 03:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjATIyb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 03:54:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891525B9A;
        Fri, 20 Jan 2023 00:54:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 399E2221B8;
        Fri, 20 Jan 2023 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674204869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QuC6EoxQ4hc8vHSLJ5TANMxoXRQ/KJ+BoF6V1R8R+Q=;
        b=wfzYjETl0eSPnWzDeUhCgwd7MFHL6Zq2+3rV3B3vstHYF/RKsAeGV0knGV7W52L9MqcuGP
        JJj6RVthgdWIvYGOLGEvvy3KeqA9VOHUhWo4FqQjLeW2zHLcNe5d27a0Zm0J0eeE94W2CR
        nQzc6yvTYeLY24WDVwKP5eiuftyanuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674204869;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QuC6EoxQ4hc8vHSLJ5TANMxoXRQ/KJ+BoF6V1R8R+Q=;
        b=I61ICZaKx514MlB9T1yJylPrN3JxBItqqZmAXlAtNDeKec02MCH9hHjVXWI2xdoJYSsfZJ
        HTG/GIrvPzBUbvDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C012013251;
        Fri, 20 Jan 2023 08:54:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xnYoKsRWymPtHgAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 20 Jan 2023 08:54:28 +0000
Date:   Fri, 20 Jan 2023 09:54:27 +0100
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 01/15] blk-cgroup: don't defer blkg_free to a workqueue
Message-ID: <Y8pWw3JGAh0olxBp@suselix>
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117081257.3089859-2-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 09:12:43AM +0100, Christoph Hellwig wrote:
> Now that blk_put_queue can be called from process context, ther is no
                                                             ^^^^
							     there
> need for the asynchronous execution.
> 
> This effectively reverts commit d578c770c85233af592e54537f93f3831bde7e9a.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c | 32 ++++++++++----------------------
>  block/blk-cgroup.h |  5 +----
>  2 files changed, 11 insertions(+), 26 deletions(-)

Looks good to me. Feel free to add
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index ce6a2b7d3dfb2b..30d493b43f9272 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -114,12 +114,19 @@ static bool blkcg_policy_enabled(struct request_queue *q,
>  	return pol && test_bit(pol->plid, q->blkcg_pols);
>  }
>  
> -static void blkg_free_workfn(struct work_struct *work)
> +/**
> + * blkg_free - free a blkg
> + * @blkg: blkg to free
> + *
> + * Free @blkg which may be partially allocated.
> + */
> +static void blkg_free(struct blkcg_gq *blkg)
>  {
> -	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
> -					     free_work);
>  	int i;
>  
> +	if (!blkg)
> +		return;
> +
>  	for (i = 0; i < BLKCG_MAX_POLS; i++)
>  		if (blkg->pd[i])
>  			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
> @@ -131,25 +138,6 @@ static void blkg_free_workfn(struct work_struct *work)
>  	kfree(blkg);
>  }
>  
> -/**
> - * blkg_free - free a blkg
> - * @blkg: blkg to free
> - *
> - * Free @blkg which may be partially allocated.
> - */
> -static void blkg_free(struct blkcg_gq *blkg)
> -{
> -	if (!blkg)
> -		return;
> -
> -	/*
> -	 * Both ->pd_free_fn() and request queue's release handler may
> -	 * sleep, so free us by scheduling one work func
> -	 */
> -	INIT_WORK(&blkg->free_work, blkg_free_workfn);
> -	schedule_work(&blkg->free_work);
> -}
> -
>  static void __blkg_release(struct rcu_head *rcu)
>  {
>  	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index 1e94e404eaa80a..f126fe36001eb3 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -75,10 +75,7 @@ struct blkcg_gq {
>  
>  	spinlock_t			async_bio_lock;
>  	struct bio_list			async_bios;
> -	union {
> -		struct work_struct	async_bio_work;
> -		struct work_struct	free_work;
> -	};
> +	struct work_struct		async_bio_work;
>  
>  	atomic_t			use_delay;
>  	atomic64_t			delay_nsec;
> -- 
> 2.39.0
> 

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)

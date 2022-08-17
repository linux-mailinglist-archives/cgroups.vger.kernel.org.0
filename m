Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87756596DD8
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 13:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiHQLzH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 07:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbiHQLzG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 07:55:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A3461B18;
        Wed, 17 Aug 2022 04:55:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 23203201C4;
        Wed, 17 Aug 2022 11:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660737303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GO5Pl2p51jwCdZ3qSxxX8zQ5xuKpuTPAsF36LK0rcTM=;
        b=itipK7raRMIbg7s8zVjuY/dZ+Cyi833cvu2pTQ6EGXur2Rkn77oLFbYHQUk7E5Y9EXVGjb
        O/XtXYvwvOAZphPy43oC+7NPEW9rjIXP59KIJUra/Kfqga+xk7lVFIMS+WpskLO2r86KYI
        XqVVOWiwFiYGGJ3LjS0Kh+yoUa4shpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660737303;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GO5Pl2p51jwCdZ3qSxxX8zQ5xuKpuTPAsF36LK0rcTM=;
        b=OCt1Zp3eRLoyfBZNtDxXMQ8dtyiNz/h8rCO7CC5k/3cwXqqJhgglaCwGLvlxewLXk3ruI+
        hEvUtzsrwFye6YCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E81ED2C178;
        Wed, 17 Aug 2022 11:55:02 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DFC08A066B; Wed, 17 Aug 2022 13:55:01 +0200 (CEST)
Date:   Wed, 17 Aug 2022 13:55:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, axboe@kernel.dk, paolo.valente@linaro.org,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 1/3] block, bfq: remove unused functions
Message-ID: <20220817115501.bwfpvdgppwd4p55y@quack3>
References: <20220816015631.1323948-1-yukuai1@huaweicloud.com>
 <20220816015631.1323948-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816015631.1323948-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 16-08-22 09:56:29, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> While doing code coverage testing(CONFIG_BFQ_CGROUP_DEBUG is disabled), we
> found that some functions doesn't have caller, thus remove them.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-cgroup.c  |  5 -----
>  block/bfq-iosched.h | 13 ++++++++-----
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 30b15a9a47c4..144bca006463 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -254,17 +254,12 @@ void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
>  
>  #else /* CONFIG_BFQ_CGROUP_DEBUG */
>  
> -void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
> -			      blk_opf_t opf) { }
>  void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t opf) { }
>  void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t opf) { }
>  void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
>  				  u64 io_start_time_ns, blk_opf_t opf) { }
>  void bfqg_stats_update_dequeue(struct bfq_group *bfqg) { }
> -void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg) { }
> -void bfqg_stats_update_idle_time(struct bfq_group *bfqg) { }
>  void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg) { }
> -void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg) { }
>  
>  #endif /* CONFIG_BFQ_CGROUP_DEBUG */
>  
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index ad8e513d7e87..f81ab3c8fa3c 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -993,20 +993,23 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
>  /* ---------------- cgroups-support interface ---------------- */
>  
>  void bfqg_stats_update_legacy_io(struct request_queue *q, struct request *rq);
> -void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
> -			      blk_opf_t opf);
>  void bfqg_stats_update_io_remove(struct bfq_group *bfqg, blk_opf_t opf);
>  void bfqg_stats_update_io_merged(struct bfq_group *bfqg, blk_opf_t opf);
>  void bfqg_stats_update_completion(struct bfq_group *bfqg, u64 start_time_ns,
>  				  u64 io_start_time_ns, blk_opf_t opf);
>  void bfqg_stats_update_dequeue(struct bfq_group *bfqg);
> -void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg);
> -void bfqg_stats_update_idle_time(struct bfq_group *bfqg);
>  void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg);
> -void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg);
>  void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		   struct bfq_group *bfqg);
>  
> +#ifdef CONFIG_BFQ_CGROUP_DEBUG
> +void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
> +			      blk_opf_t opf);
> +void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg);
> +void bfqg_stats_update_idle_time(struct bfq_group *bfqg);
> +void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg);
> +#endif
> +
>  void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg);
>  void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio);
>  void bfq_end_wr_async(struct bfq_data *bfqd);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

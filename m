Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0E4539F97
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 10:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350728AbiFAIff (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 04:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350823AbiFAIfc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 04:35:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E82B5A2C1;
        Wed,  1 Jun 2022 01:35:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0304B1F8C2;
        Wed,  1 Jun 2022 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654072530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZgDe2eXlhB42LN+QI5BZWIRc4kyPQuFvdb59+D3ByMQ=;
        b=bV70JBnMBSgY94pQahRNjPumE6SgHGja6J+fLoGZJ9eClDYKyM6NQvJD0tf0hovyu6n+BB
        /ivw96PkjmnPwGablQxiwPnrsd/LeMcmKhvDePXVtA+PSK+pqm1YExM+ZtznQ7+cyGiBB+
        U2JqupjlBJ3c+xiH9bgd5t4wukBQxCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654072530;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZgDe2eXlhB42LN+QI5BZWIRc4kyPQuFvdb59+D3ByMQ=;
        b=rHP/WFvK2JmjuczkrX0+8NAVEE++a9lq4iv8fPBYMTFjHZdt9JXZydlvUU34LsCarDNPTm
        2y9AXdwb/V2MZaCA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E91AE2C142;
        Wed,  1 Jun 2022 08:35:29 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B021CA0633; Wed,  1 Jun 2022 10:35:29 +0200 (CEST)
Date:   Wed, 1 Jun 2022 10:35:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     paolo.valente@linaro.org, jack@suse.cz, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v8 2/4] block, bfq: record how many queues have
 pending requests
Message-ID: <20220601083529.oz26s6jefxz6fnyg@quack3.lan>
References: <20220531140858.3324294-1-yukuai3@huawei.com>
 <20220531140858.3324294-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531140858.3324294-3-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 31-05-22 22:08:56, Yu Kuai wrote:
> Prepare to refactor the counting of 'num_groups_with_pending_reqs'.
> 
> Add a counter in bfq_group, and update it while tracking if bfqq have
> pending requests.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good, except I think that we also need to update the counters
'num_groups_with_pending_reqs' in bfq_move_bfqq()?

								Honza

> ---
>  block/bfq-cgroup.c  |  1 +
>  block/bfq-iosched.h |  1 +
>  block/bfq-wf2q.c    | 12 ++++++++++--
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 09574af83566..0954a258a107 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -557,6 +557,7 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
>  				   */
>  	bfqg->bfqd = bfqd;
>  	bfqg->active_entities = 0;
> +	bfqg->num_queues_with_pending_reqs = 0;
>  	bfqg->online = true;
>  	bfqg->rq_pos_tree = RB_ROOT;
>  }
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 3b9b1a0e7c1c..a5f7c0c1a3b3 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -943,6 +943,7 @@ struct bfq_group {
>  	struct bfq_entity *my_entity;
>  
>  	int active_entities;
> +	int num_queues_with_pending_reqs;
>  
>  	struct rb_root rq_pos_tree;
>  
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index 12d20f26ad69..b533e17e9f0c 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -1651,16 +1651,24 @@ static void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>  {
>  	struct bfq_entity *entity = &bfqq->entity;
>  
> -	if (!entity->in_groups_with_pending_reqs)
> +	if (!entity->in_groups_with_pending_reqs) {
>  		entity->in_groups_with_pending_reqs = true;
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> +		bfqq_group(bfqq)->num_queues_with_pending_reqs++;
> +#endif
> +	}
>  }
>  
>  void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq)
>  {
>  	struct bfq_entity *entity = &bfqq->entity;
>  
> -	if (entity->in_groups_with_pending_reqs)
> +	if (entity->in_groups_with_pending_reqs) {
>  		entity->in_groups_with_pending_reqs = false;
> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
> +		bfqq_group(bfqq)->num_queues_with_pending_reqs--;
> +#endif
> +	}
>  }
>  
>  /*
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

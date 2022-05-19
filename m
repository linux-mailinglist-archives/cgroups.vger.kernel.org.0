Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7883852D100
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 12:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbiESK7k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 06:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbiESK7i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 06:59:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A191FAF32E;
        Thu, 19 May 2022 03:59:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 54EBB21B54;
        Thu, 19 May 2022 10:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652957976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jMNnoNJa2b5+2J40iT0inx4nRccR2PWVfWoFKpUpFbQ=;
        b=K1to2AvtMDvcqfY6d7f+MZRQJg3j3EXLUKbxDk6DGYgfAw1IOz8sRKa18OWNCDddxM+pRQ
        ME9XP51iug2ximVhum/LXib4aNLUI5yRyZ3znHP11+0Xo/hKd4fgugpQ73F9O4FU9kVlRH
        fItMSip5j6K1dCMw5fjDRNeG/EyBHQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652957976;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jMNnoNJa2b5+2J40iT0inx4nRccR2PWVfWoFKpUpFbQ=;
        b=Uwk9F1qU36LD4onNKj6zYEBLXpB+98fUh2gawQ0ywGOSkaGSF2HGAgb28Y5vczg6cnAcys
        I/UTEJuR8PjjFGDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3DAB32C141;
        Thu, 19 May 2022 10:59:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B499BA062F; Thu, 19 May 2022 12:59:35 +0200 (CEST)
Date:   Thu, 19 May 2022 12:59:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 1/8] block, bfq: cleanup bfq_weights_tree
 add/remove apis
Message-ID: <20220519105935.psejehys7uwlzmmk@quack3.lan>
References: <20220514090522.1669270-1-yukuai3@huawei.com>
 <20220514090522.1669270-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514090522.1669270-2-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 14-05-22 17:05:15, Yu Kuai wrote:
> They already pass 'bfqd' as the first parameter, there is no need to
> pass 'bfqd->queue_weights_tree' as another parameter.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Just one nit below:

> @@ -945,12 +945,13 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>   * about overhead.
>   */
>  void __bfq_weights_tree_remove(struct bfq_data *bfqd,
> -			       struct bfq_queue *bfqq,
> -			       struct rb_root_cached *root)
> +			       struct bfq_queue *bfqq)
>  {
> +	struct rb_root_cached *root;

Add empty line here please.

>  	if (!bfqq->weight_counter)
>  		return;
>  
> +	root = &bfqd->queue_weights_tree;
>  	bfqq->weight_counter->num_active--;
>  	if (bfqq->weight_counter->num_active > 0)
>  		goto reset_entity_pointer;

Otherwise the patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

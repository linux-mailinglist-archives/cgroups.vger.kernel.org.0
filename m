Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011DF52D14D
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 13:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiESLTL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 07:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiESLTG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 07:19:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2C8B2250;
        Thu, 19 May 2022 04:18:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5FA8B21B3F;
        Thu, 19 May 2022 11:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652959137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlBHEoYBfb1KPuoHgDe8/xW0NmuRzgrxMjHDSq311m8=;
        b=lVsFJVjM95QAf8BtL2346JAPhSEU0ZwWFI66R9OjINDXQSXzGoBgpeOgojzS6pe9iJFQhk
        vMysbdethLL2TQnCDPjVo0QErCXwHGYaUz+A2RJ5GpzT16ASSsydPX6tsgGIG2GitRVZvO
        v+t8IfUpmda/FmG9Yn1DNTPfH/LYEZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652959137;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xlBHEoYBfb1KPuoHgDe8/xW0NmuRzgrxMjHDSq311m8=;
        b=/mxkD//r/VYRBbyN6BYdva8Vo/reEZ1vWzfK8sTnpO84rr7WI0znDyAtaqAyCfa5hBRXUW
        D1fISg9+R2VKrBCQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4C2A32C141;
        Thu, 19 May 2022 11:18:57 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F3780A062F; Thu, 19 May 2022 13:18:56 +0200 (CEST)
Date:   Thu, 19 May 2022 13:18:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 7/8] block, bfq: cleanup
 bfq_bfqq_update_budg_for_activation()
Message-ID: <20220519111856.wvk4oetm7odnkg3w@quack3.lan>
References: <20220514090522.1669270-1-yukuai3@huawei.com>
 <20220514090522.1669270-8-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514090522.1669270-8-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 14-05-22 17:05:21, Yu Kuai wrote:
> It will only be called from bfq_bfqq_handle_idle_busy_switch() in
> specific code branch, there is no need to precaculate
> 'bfqq_wants_to_preempt' each time bfq_bfqq_handle_idle_busy_switch()
> is caleld.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Please see below:

> @@ -1816,14 +1807,6 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>  		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
>  		   (*interactive || soft_rt)));
>  
> -	/*
> -	 * Using the last flag, update budget and check whether bfqq
> -	 * may want to preempt the in-service queue.
> -	 */
> -	bfqq_wants_to_preempt =
> -		bfq_bfqq_update_budg_for_activation(bfqd, bfqq,
> -						    arrived_in_time);
> -
>  	/*
>  	 * If bfqq happened to be activated in a burst, but has been
>  	 * idle for much more than an interactive queue, then we
...
> @@ -1918,7 +1900,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
>  	 * (2) this switch of bfqq to busy changes the scenario.
>  	 */
>  	if (bfqd->in_service_queue &&
> -	    ((bfqq_wants_to_preempt &&
> +	    ((bfq_bfqq_update_budg_for_activation(bfqd, bfqq) &&
>  	      bfqq->wr_coeff >= bfqd->in_service_queue->wr_coeff) ||
>  	     bfq_bfqq_higher_class_or_weight(bfqq, bfqd->in_service_queue) ||
>  	     !bfq_better_to_idle(bfqd->in_service_queue)) &&

So these changes are actually wrong because
bfq_bfqq_update_budg_for_activation() relies on
bfq_bfqq_non_blocking_wait_rq() but bfq_add_bfqq_busy() clears that. And
bfq_add_bfqq_busy() is called between the place where
bfq_bfqq_update_budg_for_activation() was called previously and now so your
patch breaks this logic.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

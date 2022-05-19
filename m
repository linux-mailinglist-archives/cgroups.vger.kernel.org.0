Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B8952D120
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 13:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiESLGm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 07:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbiESLGc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 07:06:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AFA5BD03;
        Thu, 19 May 2022 04:06:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9853121B4F;
        Thu, 19 May 2022 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652958385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HlX9V2kwUqlaTsfZgmTmF/cQ1kOaxEblkPsnhaP8BrY=;
        b=olR7yqt0ft1lzAE1gwqNyfTmGtnFtFtRSjRvkUF3E6Ut7hmVkuBz0wC79JhPZdqeg2+H7+
        /TyFDuv+pK3/NMJFxtq2yDM3L2y6jXlRetJyHeyWg04/U8/AdwafzGZ/t0+3WsPMojNdSo
        P+L4qbOVar0XTxvqYapGj6VzAkx0X4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652958385;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HlX9V2kwUqlaTsfZgmTmF/cQ1kOaxEblkPsnhaP8BrY=;
        b=vNtlrNDpXGIB8zsDZfps405lLXcZvWHrBaQs8DAw0zwMWjvbAsqTA45KPJ4JJjTg/FhLAs
        B4leCEXQDxMUu0BQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 814242C141;
        Thu, 19 May 2022 11:06:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 394FAA062F; Thu, 19 May 2022 13:06:25 +0200 (CEST)
Date:   Thu, 19 May 2022 13:06:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 6/8] block, bfq: remove dead code for updating
 'rq_in_driver'
Message-ID: <20220519110625.wobgihgbtyadgykp@quack3.lan>
References: <20220514090522.1669270-1-yukuai3@huawei.com>
 <20220514090522.1669270-7-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514090522.1669270-7-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 14-05-22 17:05:20, Yu Kuai wrote:
> Such code are not even compiled since they are inside marco "#if 0".
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 1d0141c450c0..e36a16684fb4 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2322,22 +2322,6 @@ static sector_t get_sdist(sector_t last_pos, struct request *rq)
>  	return 0;
>  }
>  
> -#if 0 /* Still not clear if we can do without next two functions */
> -static void bfq_activate_request(struct request_queue *q, struct request *rq)
> -{
> -	struct bfq_data *bfqd = q->elevator->elevator_data;
> -
> -	bfqd->rq_in_driver++;
> -}
> -
> -static void bfq_deactivate_request(struct request_queue *q, struct request *rq)
> -{
> -	struct bfq_data *bfqd = q->elevator->elevator_data;
> -
> -	bfqd->rq_in_driver--;
> -}
> -#endif
> -
>  static void bfq_remove_request(struct request_queue *q,
>  			       struct request *rq)
>  {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

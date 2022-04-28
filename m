Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE651326D
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 13:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiD1L17 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 07:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiD1L16 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 07:27:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D873F5D65B;
        Thu, 28 Apr 2022 04:24:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C49C210EC;
        Thu, 28 Apr 2022 11:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651145082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eskgHgHhEq1Wx+VmExpxr/07kCvTFnpRTsUSvj7Vrk4=;
        b=QSbzbmYJDo3PGNt6gMolptedWIYKl/qUh7pJJNT0xu14YEN3XIwbwXAFlBLh0ibgUCEhm2
        /YnT5BLZALgeRjUv2RBQ0PGtuVD6V3M8fF83cyKK8Wf9xjgqS1NP3Jm610ub8t/9GTpvoq
        DsEaE3EY5PtGePslTBbBqpWurhHjh38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651145082;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eskgHgHhEq1Wx+VmExpxr/07kCvTFnpRTsUSvj7Vrk4=;
        b=N97sJgAS8Z3gNWh1Y5NqmLhE0sT0yAxga8mT+3HsUDKkfQ9mdBavXUQ4KpL5kDK3pzKCnx
        wHBpG3IOJkUjr8Cg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 69FCB2C141;
        Thu, 28 Apr 2022 11:24:42 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 29813A061A; Thu, 28 Apr 2022 13:24:42 +0200 (CEST)
Date:   Thu, 28 Apr 2022 13:24:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v4 3/3] block, bfq: do not idle if only one group
 is activated
Message-ID: <20220428112442.m4cx6uc6f4qaicby@quack3.lan>
References: <20220428111907.3635820-1-yukuai3@huawei.com>
 <20220428111907.3635820-4-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428111907.3635820-4-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 28-04-22 19:19:07, Yu Kuai wrote:
> Now that root group is counted into 'num_groups_with_busy_queues',
> 'num_groups_with_busy_queues > 0' is always true in
> bfq_asymmetric_scenario(). Thus change the condition to '> 1'.
> 
> On the other hand, this change can enable concurrent sync io if only
> one group is activated.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 609b4e894684..aeba9001da0b 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -844,7 +844,7 @@ static bool bfq_asymmetric_scenario(struct bfq_data *bfqd,
>  
>  	return varied_queue_weights || multiple_classes_busy
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> -	       || bfqd->num_groups_with_busy_queues > 0
> +	       || bfqd->num_groups_with_busy_queues > 1
>  #endif
>  		;
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDEF513249
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 13:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243653AbiD1LVS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 07:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiD1LVS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 07:21:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD80A88A1;
        Thu, 28 Apr 2022 04:18:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A70091F37F;
        Thu, 28 Apr 2022 11:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651144682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oTrnvMpAhjSGeg1gbv33jLZDolAkh8q0+zNQ815xKlQ=;
        b=u/MaWQyAW2WWLjnSuO7VRXh2tbAm8BiWtFpc6daZUTVzIaWYKwFlx01h1w+nw4vs52VB8E
        FiEZAmdelzrw+GfHEPtQdL5J5Fq02eMk7mYvyRoGQRjqM9whOKLIbb/W6YAU0pWbWTllJX
        V+9rqJVoqyrkpjBK7QPyFBMp0SpODyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651144682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oTrnvMpAhjSGeg1gbv33jLZDolAkh8q0+zNQ815xKlQ=;
        b=sQOtrYhIKz01UuNxtkiMhUrfGvIlrtZgRKSHw0Qr/9X8S0UTvFRvWkUKZ22FzRc6nV8GEW
        JLpypogPB1UaJGDg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2F89D2C142;
        Thu, 28 Apr 2022 11:18:02 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7F55FA061A; Thu, 28 Apr 2022 13:18:00 +0200 (CEST)
Date:   Thu, 28 Apr 2022 13:18:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v4 1/3] block, bfq: record how many queues are busy
 in bfq_group
Message-ID: <20220428111800.aqfzwwii5dabx3ko@quack3.lan>
References: <20220428111907.3635820-1-yukuai3@huawei.com>
 <20220428111907.3635820-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428111907.3635820-2-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 28-04-22 19:19:05, Yu Kuai wrote:
> Prepare to refactor the counting of 'num_groups_with_pending_reqs'.
> 
> Add a counter 'busy_queues' in bfq_group, and update it in
> bfq_add/del_bfqq_busy().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Just two nits below:

> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -218,6 +218,16 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
>  	return false;
>  }
>  
> +static void bfq_add_busy_queues(struct bfq_queue *bfqq)
> +{
> +	bfqq_group(bfqq)->busy_queues++;
> +}
> +
> +static void bfq_dec_busy_queues(struct bfq_queue *bfqq)
> +{
> +	bfqq_group(bfqq)->busy_queues--;
> +}
> +

An opposite from "decrement" is "increment", not "add". So
bfq_add_busy_queues() should be bfq_inc_busy_queues().

> @@ -230,6 +240,14 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
>  	return true;
>  }
>  
> +static void bfq_add_busy_queues(struct bfq_queue *bfqq)
> +{
> +}
> +
> +static void bfq_add_busy_queues(struct bfq_queue *bfqq)
> +{
> +}
> +

You have two times the same function here and you miss the other one...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

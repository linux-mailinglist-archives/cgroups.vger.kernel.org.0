Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06E8511B50
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbiD0M4F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 08:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiD0M4E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 08:56:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749893BA5F;
        Wed, 27 Apr 2022 05:52:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 30C3C210F4;
        Wed, 27 Apr 2022 12:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651063972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yhhsQZ/apy3ajEmL5BMkQH4udIsKMO/zX6YXUvskbjo=;
        b=HKwz9nxCbcYcqN9QwfH1r/OK8igSL7ddbDwQPY0FTJ9uWwqeDCyym37BrWo7AuYPgFyIfr
        ZZUi0JysOo5F8s8wa3Efo0O62vpkwufpcdX5yjShpE8Nb6w+Qo8LJrQ/J/IQwp1cmsbITY
        30oslwuMsB2FRM+EppyUlA2FiA7c9DM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651063972;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yhhsQZ/apy3ajEmL5BMkQH4udIsKMO/zX6YXUvskbjo=;
        b=HMVy/XOhIcTAl6OpMei3jxWEDWxT8+4SiZ5FoEVgdmSiCFbi8a8tlLNJLhHJTzd2g71rRw
        2X9PmFajXjj4N0Cw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1FD2B2C141;
        Wed, 27 Apr 2022 12:52:51 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 718DBA0620; Wed, 27 Apr 2022 14:52:51 +0200 (CEST)
Date:   Wed, 27 Apr 2022 14:52:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 1/3] block, bfq: record how many queues are busy
 in bfq_group
Message-ID: <20220427125251.yl7ff4ti33w6ktrf@quack3.lan>
References: <20220427124722.48465-1-yukuai3@huawei.com>
 <20220427124722.48465-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427124722.48465-2-yukuai3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 27-04-22 20:47:20, Yu Kuai wrote:
> Prepare to refactor the counting of 'num_groups_with_pending_reqs'.
> 
> Add a counter 'busy_queues' in bfq_group, and update it in
> bfq_add/del_bfqq_busy().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

...

> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index f8eb340381cf..53826797430f 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -218,6 +218,14 @@ static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
>  	return false;
>  }
>  
> +static void bfq_update_busy_queues(struct bfq_queue *bfqq, bool is_add)
> +{
> +	if (is_add)
> +		bfqq_group(bfqq)->busy_queues++;
> +	else
> +		bfqq_group(bfqq)->busy_queues--;
> +}
> +
>  #else /* CONFIG_BFQ_GROUP_IOSCHED */

I think the bool argument here unnecessarily hurts readability (it's
difficult to see what the argument means without looking into the
implementation). I'd rather create two functions bfq_{inc,dec}_busy_queues()
or if you really insist on a single function, we can have
bfq_add_busy_queues() and have 'int' argument that will be +1 or -1.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59555669350
	for <lists+cgroups@lfdr.de>; Fri, 13 Jan 2023 10:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbjAMJw0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Jan 2023 04:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjAMJv7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Jan 2023 04:51:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B565465AF2;
        Fri, 13 Jan 2023 01:46:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 755A0221F8;
        Fri, 13 Jan 2023 09:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673603189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wuNY130VcsaJBRLFnePwzZuLqGqTZv2d6U87GrUaNAQ=;
        b=hgoGZy+TXMw0Ixd2Wx2SrsMRpA8HVurYPTWkvMq3oFytcppYp8DBAU2G2wYaxZVbpeEdtA
        IlCXuLkTK1IsWsySsb2YNY9XQmgAHknmcO6wQoRCaSBIXfWXe5S8/m6OMf407WttQPct57
        J87uoo4ZwLiGvpIRr3XffsCPEVQdGkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673603189;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wuNY130VcsaJBRLFnePwzZuLqGqTZv2d6U87GrUaNAQ=;
        b=IgP2UMdc5EjtUBbApQmhvYatY+seHiqNjbAUkIBBeS8d53XQXHP/orci1x1jWSNtM0p7PV
        395NK7p3ubUm7vCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 630CB1358A;
        Fri, 13 Jan 2023 09:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QfohGHUowWP8fgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 13 Jan 2023 09:46:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D66A0A0744; Fri, 13 Jan 2023 10:46:28 +0100 (CET)
Date:   Fri, 13 Jan 2023 10:46:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        paolo.valente@linaro.org, shinichiro.kawasaki@wdc.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] block, bfq: fix uaf for bfqq in bic_set_bfqq()
Message-ID: <20230113094628.foepphisccxjligo@quack3>
References: <20230113094410.2907223-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113094410.2907223-1-yukuai3@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 13-01-23 17:44:10, Yu Kuai wrote:
> After commit 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'"),
> bic->bfqq will be accessed in bic_set_bfqq(), however, in some context
> bic->bfqq will be freed first, and bic_set_bfqq() is called with the freed
> bic->bfqq.
> 
> Fix the problem by always freeing bfqq after bic_set_bfqq().
> 
> Fixes: 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
> Reported-and-tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good, thanks for the fix! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-cgroup.c  | 2 +-
>  block/bfq-iosched.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index a6e8da5f5cfd..feb13ac25557 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -749,8 +749,8 @@ static void bfq_sync_bfqq_move(struct bfq_data *bfqd,
>  		 * old cgroup.
>  		 */
>  		bfq_put_cooperator(sync_bfqq);
> -		bfq_release_process_ref(bfqd, sync_bfqq);
>  		bic_set_bfqq(bic, NULL, true, act_idx);
> +		bfq_release_process_ref(bfqd, sync_bfqq);
>  	}
>  }
>  
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 815b884d6c5a..2ddf831221c4 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5581,9 +5581,11 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
>  
>  	bfqq = bic_to_bfqq(bic, false, bfq_actuator_index(bfqd, bio));
>  	if (bfqq) {
> -		bfq_release_process_ref(bfqd, bfqq);
> +		struct bfq_queue *old_bfqq = bfqq;
> +
>  		bfqq = bfq_get_queue(bfqd, bio, false, bic, true);
>  		bic_set_bfqq(bic, bfqq, false, bfq_actuator_index(bfqd, bio));
> +		bfq_release_process_ref(bfqd, old_bfqq);
>  	}
>  
>  	bfqq = bic_to_bfqq(bic, true, bfq_actuator_index(bfqd, bio));
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

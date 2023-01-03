Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8D665BE16
	for <lists+cgroups@lfdr.de>; Tue,  3 Jan 2023 11:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjACKaj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Jan 2023 05:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjACKai (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Jan 2023 05:30:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E4FF5BD;
        Tue,  3 Jan 2023 02:30:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C4F6361233;
        Tue,  3 Jan 2023 10:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672741835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S0fpHD/aVGPATEkhmOtr6aAZx/NtaItvDcnKgARuLII=;
        b=H4mcgN5iwaCxNhoNI3/q08ZUacejngcauGzDH+dk+dpcF9FQBIIsXzQV1LrxwH0/ku6gAM
        pddlOUcy2LO9usoiT+Aw339rgv7i5minKnyUKngRPN7YVjuSwB59vodu9U9GcxjlitZdxA
        OJM8wz/kcVDn+sgiPbxZfzoVc3PjGYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672741835;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S0fpHD/aVGPATEkhmOtr6aAZx/NtaItvDcnKgARuLII=;
        b=JkKdihtsGYCvv+QGCsisIZsWGCg6twEmkStVBFoz31bLwCuwwwCMa76eH88Tlt4BZ06zYd
        SuInez8hHXd36TAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD5971392B;
        Tue,  3 Jan 2023 10:30:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GUhPKssDtGOHRAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Jan 2023 10:30:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8AFEBA0742; Tue,  3 Jan 2023 11:30:34 +0100 (CET)
Date:   Tue, 3 Jan 2023 11:30:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        tj@kernel.org, josef@toxicpanda.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] block, bfq: switch 'bfqg->ref' to use atomic refcount
 apis
Message-ID: <20230103103034.6wtj7fzyoqdsqdqy@quack3>
References: <20230103084755.1256479-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103084755.1256479-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 03-01-23 16:47:55, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The updating of 'bfqg->ref' should be protected by 'bfqd->lock', however,
> during code review, we found that bfq_pd_free() update 'bfqg->ref'
> without holding the lock, which is problematic:
> 
> 1) bfq_pd_free() triggered by removing cgroup is called asynchronously;
> 2) bfqq will grab bfqg reference, and exit bfqq will drop the reference,
> which can concurrent with 1).
> 
> Unfortunately, 'bfqd->lock' can't be held here because 'bfqd' might already
> be freed in bfq_pd_free(). Fix the problem by using atomic refcount apis.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes from RFC:
>  - refcount_dec_and_test(bfqg->ref) -> refcount_dec_and_test(&bfqg->ref)
> 
>  block/bfq-cgroup.c  | 8 +++-----
>  block/bfq-iosched.h | 2 +-
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 1b2829e99dad..7d9b15f0dbd5 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -316,14 +316,12 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
>  
>  static void bfqg_get(struct bfq_group *bfqg)
>  {
> -	bfqg->ref++;
> +	refcount_inc(&bfqg->ref);
>  }
>  
>  static void bfqg_put(struct bfq_group *bfqg)
>  {
> -	bfqg->ref--;
> -
> -	if (bfqg->ref == 0)
> +	if (refcount_dec_and_test(&bfqg->ref))
>  		kfree(bfqg);
>  }
>  
> @@ -530,7 +528,7 @@ static struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, struct request_queue *q,
>  	}
>  
>  	/* see comments in bfq_bic_update_cgroup for why refcounting */
> -	bfqg_get(bfqg);
> +	refcount_set(&bfqg->ref, 1);
>  	return &bfqg->pd;
>  }
>  
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 41aa151ccc22..466e4865ace6 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -928,7 +928,7 @@ struct bfq_group {
>  	char blkg_path[128];
>  
>  	/* reference counter (see comments in bfq_bic_update_cgroup) */
> -	int ref;
> +	refcount_t ref;
>  	/* Is bfq_group still online? */
>  	bool online;
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

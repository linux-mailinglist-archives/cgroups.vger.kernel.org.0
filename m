Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A676F1E89
	for <lists+cgroups@lfdr.de>; Fri, 28 Apr 2023 21:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjD1TFP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Apr 2023 15:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346106AbjD1TFP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Apr 2023 15:05:15 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64192109
        for <cgroups@vger.kernel.org>; Fri, 28 Apr 2023 12:05:12 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 055F93F22C
        for <cgroups@vger.kernel.org>; Fri, 28 Apr 2023 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682708711;
        bh=5xdGcBrePTmDfHc6Jzw3JTLHbSAztKlpGArx8vpNt2k=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=YeivsCR9ABeWXCF7A/G3oxLR0USMKMmYOUuyhMJBNMswVSc8CkQ3d5S6UTtzRxDxL
         aNZ9+4gTQpZbOOhgsG/Ynw8boH9S6Tru3y6nFub6d/botfSRKTPTvabyMipb8POibp
         xPdHAFqP+sAvYtDQL1ViuPuU4bo8G6TICq1jaWoP0WYEAic+FnkuChvlYhIdSIZ886
         Uin+h6gwi5ZkJOY2GLHLgu5EgNOZGytM3Kj5tj+ZTAlmzg2K2CBVEZLfs5RYnxy+eF
         yAEVY1g7/U1kw/XGcG8OIMWMUtCWgRe05vaEO1fz7BSjZjEe9lgCpAX1oxyPUMtRPR
         VlN/kjUVHRP5w==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-95376348868so17722466b.2
        for <cgroups@vger.kernel.org>; Fri, 28 Apr 2023 12:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682708710; x=1685300710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xdGcBrePTmDfHc6Jzw3JTLHbSAztKlpGArx8vpNt2k=;
        b=YY9hVswungPBRU56N0FX8NRS/kdkZjniPsHlQtaSypbDo7eg86seileqV0LNyvvTG0
         DgDBAkvNT8x6VL1rK5W3AqsqhKn7vzEQfz5T8tXsHuUUeSiA5qBVGibzt7TA+w44u1kb
         NeUEl46FWVpPa1XDxH2yPYkuNoApBCaWiYzX/TjDPQefvWX0Gt96EYZT3Cq5LI5zFQCD
         FOLxyiS5PqbcvDShdbc9EzSJCFSOQRC1w8aWmEKS9BgNtpKB5DgmllKQlDaHxIZM2FIs
         XkC5lHFcIrR+wbkLyGbtf9LVfOMRAnyp+jUcuX1R1UJp8dLdYQzZZO2OVe4TsDqCsyS2
         j/iw==
X-Gm-Message-State: AC+VfDxxPP8dgHCzcC19NxQjfN+slEguI9RCoz70/hSOpGaBnpAE08C9
        nZDAz6/Gl+oorR1QvkaDP3j6pX8WmZJeYLN4nVKNC2ds4BdKDE5dERjpqkMV6/tNbHfOAjYSxbN
        GR3mxrLIAJM6yyguwtnZRSwfMqhQJe4dUxoo=
X-Received: by 2002:a17:907:16aa:b0:94f:9f76:c74f with SMTP id hc42-20020a17090716aa00b0094f9f76c74fmr7738592ejc.52.1682708710276;
        Fri, 28 Apr 2023 12:05:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Pi57scEQWERlmKMoLu2PGjbl7zecivIyoR8ReiRJEuRABO1ah119lQPAYBiWFcA3rwjRQeg==
X-Received: by 2002:a17:907:16aa:b0:94f:9f76:c74f with SMTP id hc42-20020a17090716aa00b0094f9f76c74fmr7738571ejc.52.1682708709893;
        Fri, 28 Apr 2023 12:05:09 -0700 (PDT)
Received: from localhost (host-87-1-129-21.retail.telecomitalia.it. [87.1.129.21])
        by smtp.gmail.com with ESMTPSA id wy12-20020a170906fe0c00b0095f07223918sm4265757ejb.138.2023.04.28.12.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 12:05:09 -0700 (PDT)
Date:   Fri, 28 Apr 2023 21:05:08 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-throttle: Fix io statistics for cgroup v1
Message-ID: <ZEwY5Oo+5inO9UFf@righiandr-XPS-13-7390>
References: <20230401094708.77631-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401094708.77631-1-hanjinke.666@bytedance.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Apr 01, 2023 at 05:47:08PM +0800, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
> blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
> the only stable io stats interface of cgroup v1, and these statistics
> are done in the blk-throttle code. But the current code only counts the
> bios that are actually throttled. When the user does not add the throttle
> limit, the io stats for cgroup v1 has nothing. I fix it according to the
> statistical method of v2, and made it count all ios accurately.
> 
> Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>

Thanks for fixing this!

The code looks correct to me, but this seems to report io statistics
only if at least one throttling limit is defined. IIRC with cgroup v1 it
was possible to see the io statistics inside a cgroup also with no
throttling limits configured.

Basically to restore the old behavior we would need to drop the
cgroup_subsys_on_dfl() check, something like the following (on top of
your patch).

But I'm not sure if we're breaking other behaviors in this way...
opinions?

 block/blk-cgroup.c   |  3 ---
 block/blk-throttle.h | 12 +++++-------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 79138bfc6001..43af86db7cf3 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2045,9 +2045,6 @@ void blk_cgroup_bio_start(struct bio *bio)
 	struct blkg_iostat_set *bis;
 	unsigned long flags;
 
-	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
-		return;
-
 	/* Root-level stats are sourced from system-wide IO stats */
 	if (!cgroup_parent(blkcg->css.cgroup))
 		return;
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index d1ccbfe9f797..bcb40ee2eeba 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -185,14 +185,12 @@ static inline bool blk_should_throtl(struct bio *bio)
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 	int rw = bio_data_dir(bio);
 
-	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
-		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
-			bio_set_flag(bio, BIO_CGROUP_ACCT);
-			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
-					bio->bi_iter.bi_size);
-		}
-		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
+	if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
+		bio_set_flag(bio, BIO_CGROUP_ACCT);
+		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
+				bio->bi_iter.bi_size);
 	}
+	blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
 
 	/* iops limit is always counted */
 	if (tg->has_rules_iops[rw])

> ---
>  block/blk-cgroup.c   | 6 ++++--
>  block/blk-throttle.c | 6 ------
>  block/blk-throttle.h | 9 +++++++++
>  3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index bd50b55bdb61..33263d0d0e0f 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -2033,6 +2033,9 @@ void blk_cgroup_bio_start(struct bio *bio)
>  	struct blkg_iostat_set *bis;
>  	unsigned long flags;
>  
> +	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
> +		return;
> +
>  	/* Root-level stats are sourced from system-wide IO stats */
>  	if (!cgroup_parent(blkcg->css.cgroup))
>  		return;
> @@ -2064,8 +2067,7 @@ void blk_cgroup_bio_start(struct bio *bio)
>  	}
>  
>  	u64_stats_update_end_irqrestore(&bis->sync, flags);
> -	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
> -		cgroup_rstat_updated(blkcg->css.cgroup, cpu);
> +	cgroup_rstat_updated(blkcg->css.cgroup, cpu);
>  	put_cpu();
>  }
>  
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 47e9d8be68f3..2be66e9430f7 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2174,12 +2174,6 @@ bool __blk_throtl_bio(struct bio *bio)
>  
>  	rcu_read_lock();
>  
> -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
> -		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
> -				bio->bi_iter.bi_size);
> -		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
> -	}
> -
>  	spin_lock_irq(&q->queue_lock);
>  
>  	throtl_update_latency_buckets(td);
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index ef4b7a4de987..d1ccbfe9f797 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -185,6 +185,15 @@ static inline bool blk_should_throtl(struct bio *bio)
>  	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
>  	int rw = bio_data_dir(bio);
>  
> +	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
> +		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
> +			bio_set_flag(bio, BIO_CGROUP_ACCT);
> +			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
> +					bio->bi_iter.bi_size);
> +		}
> +		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
> +	}
> +
>  	/* iops limit is always counted */
>  	if (tg->has_rules_iops[rw])
>  		return true;
> -- 
> 2.20.1

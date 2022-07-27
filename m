Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4815832CD
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 21:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiG0TEu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 15:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiG0TER (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 15:04:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39EC558D1;
        Wed, 27 Jul 2022 11:27:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y141so16787327pfb.7;
        Wed, 27 Jul 2022 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=epPjtN4wCIaFRIOaZPdFKvlDUTQEZpKeGhh4HLykvnw=;
        b=VdemlUi3yoDyBLRyuRAKSV/EqdNPyL80KIWvp5r0gjhfr2t+20gST0YEokL+zm8RIg
         iUfMskLvEBSnrC+fr0V4fF/4zKbnTbPDECt038Z8tWHKq/vxUIHkR5bBCnKGE1osHK+S
         Jbaqo8cVOqbSDuYjODlyVe+bMQ5WCiwyaNH7bhuTHpFHU00fLlhK/Wn4TYO+foGqIWLw
         D/dONyACF7EvEbyI0QbQyqpan3kQ77LaeKlKAgvwEXxLbEiTIzuNwmWbyzr7zWkGSVFK
         Ssd9IkY/ZDcyuQvTti3OT6Mt+aeOwUyGqoxzmWVWraMzcMBzNkqVEBpi0InPVbwdcCAl
         Fn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=epPjtN4wCIaFRIOaZPdFKvlDUTQEZpKeGhh4HLykvnw=;
        b=2+PgY0+/p9FA1uDRHj8dOcHxn3daY0FTUGJpcsrnJsyt0SjyfWm0nRa72x2pupN4QN
         3nHj7K0xcQaX7ktXqh+uN3Ggh99TZCRj1pGMOnsBZ1303F7vPsLDNoErLo/jM2Q084EL
         WnggY3iRE2+MBCsd1EE1BS6Db2ncSriYr8P6BKUqb1F0nDVUQH2r4JcB3KDpB2TxkuBk
         VhEXnq7eO3R7TFLcAW4c4lKVmpGzSbwGVvP7gbayttMD83zTGUEZ6SPE7BzfcxCDK2LG
         hxbVqh0oo6jMaSk1zYttt8WblZ44FiZdZ5VECAAEc0IYPTQWf3JlLl9FEsqLBD1irgtt
         FCjg==
X-Gm-Message-State: AJIora9ZHijuvC2309fUxKUnScT7r14tGTRDM+tigj2N/vRa4CesKYLf
        fMOAzgkKa8LrYIVGY7VlhUs=
X-Google-Smtp-Source: AGRyM1vyL7zJPphkIWuwDHPJv7y2makdkihmCp6bfYo7xi7XlNGRRk6+w1ZeJDhQs+64gWceuISyNA==
X-Received: by 2002:a63:3181:0:b0:417:b4b5:df09 with SMTP id x123-20020a633181000000b00417b4b5df09mr20426470pgx.398.1658946447042;
        Wed, 27 Jul 2022 11:27:27 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5a55])
        by smtp.gmail.com with ESMTPSA id f5-20020aa79d85000000b00525161431f5sm14082289pfq.36.2022.07.27.11.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 11:27:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jul 2022 08:27:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH RESEND v6 1/8] blk-throttle: fix that io throttle can
 only work for single bio
Message-ID: <YuGDjFkxDSsVrcRw@slm.duckdns.org>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
 <20220701093441.885741-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701093441.885741-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Sorry about the long delay.

So, the code looks nice but I have a difficult time following the logic.

On Fri, Jul 01, 2022 at 05:34:34PM +0800, Yu Kuai wrote:
> @@ -811,7 +811,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
>  	unsigned int bio_size = throtl_bio_data_size(bio);
>  
>  	/* no need to throttle if this bio's bytes have been accounted */
> -	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_THROTTLED)) {
> +	if (bps_limit == U64_MAX) {
>  		if (wait)
>  			*wait = 0;
>  		return true;
> @@ -921,11 +921,8 @@ static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
>  	unsigned int bio_size = throtl_bio_data_size(bio);
>  
>  	/* Charge the bio to the group */
> -	if (!bio_flagged(bio, BIO_THROTTLED)) {
> -		tg->bytes_disp[rw] += bio_size;
> -		tg->last_bytes_disp[rw] += bio_size;
> -	}
> -
> +	tg->bytes_disp[rw] += bio_size;
> +	tg->last_bytes_disp[rw] += bio_size;
>  	tg->io_disp[rw]++;
>  	tg->last_io_disp[rw]++;

So, we're charging and controlling whether it has already been throttled or
not.

> @@ -2121,6 +2118,21 @@ bool __blk_throtl_bio(struct bio *bio)
>  			tg->last_low_overflow_time[rw] = jiffies;
>  		throtl_downgrade_check(tg);
>  		throtl_upgrade_check(tg);
> +
> +		/*
> +		 * re-entered bio has accounted bytes already, so try to
> +		 * compensate previous over-accounting. However, if new
> +		 * slice is started, just forget it.
> +		 */
> +		if (bio_flagged(bio, BIO_THROTTLED)) {
> +			unsigned int bio_size = throtl_bio_data_size(bio);
> +
> +			if (tg->bytes_disp[rw] >= bio_size)
> +				tg->bytes_disp[rw] -= bio_size;
> +			if (tg->last_bytes_disp[rw] >= bio_size)
> +				tg->last_bytes_disp[rw] -= bio_size;
> +		}

and trying to restore the overaccounting. However, it's not clear why this
helps with the problem you're describing. The comment should be clearly
spelling out why it's done this way and how this works.

Also, blk_throttl_bio() doesn't call into __blk_throtl_bio() at all if
THROTTLED is set and HAS_IOPS_LIMIT is not, so if there are only bw limits,
we end up accounting these IOs twice?

Thanks.

-- 
tejun

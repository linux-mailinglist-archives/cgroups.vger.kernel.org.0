Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6996159636E
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 22:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbiHPUBX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 16:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiHPUBV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 16:01:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC2B7E830;
        Tue, 16 Aug 2022 13:01:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 20so1564618plo.10;
        Tue, 16 Aug 2022 13:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=K42L4KCO1sgIeNmpAei/7oCMFvHrjQlmlJv8IWh4Cio=;
        b=XTE98oivpUy8raqPHCxrdCxnNP92kcl56buMLJhnV1Nzdxws1MCR/I0ho+oW0z8GqA
         3NLg1YsoiNJWUtZzWkHwXppSRC1bGxvkr0y+8eVo6cEfdSKiBqpQQui9wODshUtzOLDC
         LfD8/zt3wYE746uwdiBXb5gDneEPVmFOUV7udMFPYWSelcypZePSVEJOAseLQ3i0xn+q
         zVe5xhkvCOVnx5U3OFkXqsqZ0DWc6DjTaY5C1+ylvXVfRbw22nQ4TvccawVCJCCsVdvr
         DaFwcmBqIF/Pv/sJI21eIHasrbFfICrgQ/jppdYxMXTZevcn2aJQa2QR3ASqtXP5t4JE
         TMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=K42L4KCO1sgIeNmpAei/7oCMFvHrjQlmlJv8IWh4Cio=;
        b=L7vx4cuNVMdxlpyA97y543LMDLQnEdTchBAuKEGXZDu92Gf2+AlRQOTfsYWai7qkVo
         w3FbD3N/Yo6InIbBc8tADss1QbQO9jvmFbU09/+8/vtkHZw9RZ/b5PK5BLsUa/1TL1O9
         s2sC49ESqM8L9/H59TzTgX5BmrHWqmZAvwzJFCe3QgaIS77Dq49JfOFXz9Kbdk+629bx
         GwyzTk/CEI4vtPcoL4a3nk3DaFl9sj1MP5nzaGzFxFYukoS13W2dAGlrfjExeG8gLCee
         MFh4f2y8IboSGCaiU7jxILcKsGJ7likLlMzBJDo2Zh9LtbOsBSyWMrPoI0Ky9XTV2heg
         RFDg==
X-Gm-Message-State: ACgBeo1kiYq4q0KExCsQkQZsFNhPkbHnMxyAi1ccMkmQ93beS1G6HRJQ
        GENd53n3ie0R9aFCnoGMIok=
X-Google-Smtp-Source: AA6agR60ephta0Kh5xEb6rw2YoNF6zZYSQQQiSIkC0juLtTmCTdLNG8uzVCK4O1nbqcVszP9CbvVxg==
X-Received: by 2002:a17:902:ebd2:b0:172:8eee:80f5 with SMTP id p18-20020a170902ebd200b001728eee80f5mr2569581plg.9.1660680079637;
        Tue, 16 Aug 2022 13:01:19 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id 5-20020a631145000000b00429b6e6c539sm897146pgr.61.2022.08.16.13.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 13:01:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 10:01:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH v7 4/9] blk-throttle: fix io hung due to configuration
 updates
Message-ID: <Yvv3jcycOguuEbA3@slm.duckdns.org>
References: <20220802140415.2960284-1-yukuai1@huaweicloud.com>
 <20220802140415.2960284-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802140415.2960284-5-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 02, 2022 at 10:04:10PM +0800, Yu Kuai wrote:
...
> +static void __tg_update_skipped(struct throtl_grp *tg, bool rw)
> +{
> +	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
> +	u64 bps_limit = tg_bps_limit(tg, rw);
> +	u32 iops_limit = tg_iops_limit(tg, rw);
> +
> +	/*
> +	 * If config is updated while bios are still throttled, calculate and
> +	 * accumulate how many bytes/io are waited across changes. And
> +	 * bytes/io_skipped will be used to calculate new wait time under new
> +	 * configuration.
> +	 *
> +	 * Following calculation won't overflow as long as bios that are
> +	 * dispatched later won't preempt already throttled bios. Even if such
> +	 * overflow do happen, there should be no problem because unsigned is
> +	 * used here, and bytes_skipped/io_skipped will be updated correctly.
> +	 */

Would it be easier if the fields were signed? It's fragile and odd to
explain "these are unsigned but if they underflow they behave just like
signed when added" when they can just be signed. Also, I have a hard time
understand what "preempt" means above.

> +	if (bps_limit != U64_MAX)
> +		tg->bytes_skipped[rw] +=
> +			calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
> +			tg->bytes_disp[rw];
> +	if (iops_limit != UINT_MAX)
> +		tg->io_skipped[rw] +=
> +			calculate_io_allowed(iops_limit, jiffy_elapsed) -
> +			tg->io_disp[rw];

So, this is calculating the budgets to carry over. Can we name them
accordingly? I don't know what "skipped" means.

> @@ -115,6 +115,17 @@ struct throtl_grp {
>  	uint64_t bytes_disp[2];
>  	/* Number of bio's dispatched in current slice */
>  	unsigned int io_disp[2];
> +	/*
> +	 * The following two fields are updated when new configuration is
> +	 * submitted while some bios are still throttled, they record how many
> +	 * bytes/io are waited already in previous configuration, and they will
> +	 * be used to calculate wait time under new configuration.
> +	 *
> +	 * Number of bytes will be skipped in current slice
> +	 */
> +	uint64_t bytes_skipped[2];
> +	/* Number of bio will be skipped in current slice */
> +	unsigned int io_skipped[2];

So, the code seems to make sense but the field names and comments don't
really, at least to me. I can't find an intuitive understanding of what's
being skipped. Can you please take another stab at making this more
understandable?

Thanks.

-- 
tejun

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39C564AA87
	for <lists+cgroups@lfdr.de>; Mon, 12 Dec 2022 23:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiLLWot (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 17:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLLWor (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 17:44:47 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC04BF9;
        Mon, 12 Dec 2022 14:44:47 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d15so4025769pls.6;
        Mon, 12 Dec 2022 14:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VOrhnDaJPP4RQqpd0yn3MDNObHRe5gWELFMKh7qM4U=;
        b=K7K+mAD97aLDIIC1hy4vdLBoNY+c97ZElXwCxgTOIojifLfLg41cVFoKvqLr/yVhk1
         Xjldnx46lS/tylmHuKBWVwZ4D2U9l+GT8F8s5UI32yHMzoFMkM7mUs9Da4pv87Zjqse+
         2XJ024MHSpu/PdMqoKQdEYibBrmPF9lU87wV/19tl80ThgAB4NAKl7C78NjLLiURkI2R
         q6nYnOOfA1EHzCb+N7RDZMNuR64hObK8l7uk/2pBvB20VhAEr1bw+sta4cxC9pmnD0Pm
         QaFK4ty88+u2jOBWDw5jxivjEMqNbOwhW9on44uPbvbxURNAWHDnSOnjjF4rz4m+f2d/
         RcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VOrhnDaJPP4RQqpd0yn3MDNObHRe5gWELFMKh7qM4U=;
        b=FSc1/fdV1pF0tbANdMiZFNWpG1uSVHNlBCTA3DaYdfuki2eoomnZH5/lsUgLBS9lJC
         6KCkGCipE+JS7wGUntS+fw37N5CRexqC+CWWRiwdyStIQ4sfkxo0t0FtABhRA68Q9qyy
         fSOR+908Scsy9S53tWs5tLWq5UzVa5PWSvgRGQyfyBlNKgB862yt8VHPbo2HMQ94yXeu
         aMxvY5ENBDbk61KAyPr+ikACuKUXvc+ih+mK2n3lXEGmXglRWflttsiuvBoSRrtbiv40
         8WNWrQPBa7X+iHabt0AHWZukH8/mGwTmzAAVkU1DsH4Utz05OIrc/zWyPLpr60qdQe3j
         NDUA==
X-Gm-Message-State: ANoB5pk9b16FGF5Ugd8Foh/fxuAAq5tamt82MnNRuW+GelUO2wDhwuhi
        MpadQou08C+2tXOl+FuZT2w=
X-Google-Smtp-Source: AA0mqf7HeEv0d0+GUfis9eEUGo1YJql6GcPjPVYiMZyz1n16fxMybBfGOkj9SzniPi4PflAEuI3YBw==
X-Received: by 2002:a17:902:bb8b:b0:188:760f:d831 with SMTP id m11-20020a170902bb8b00b00188760fd831mr16961830pls.7.1670885086528;
        Mon, 12 Dec 2022 14:44:46 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902f68b00b00188fdae6e0esm6928483plg.44.2022.12.12.14.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 14:44:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 12:44:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, darklight2357@icloud.com,
        Josef Bacik <josef@toxicpanda.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 2/2 block/for-6.2] blk-iolatency: Make initialization lazy
Message-ID: <Y5eu3A3TMWRUYd+N@slm.duckdns.org>
References: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
 <Y5TRU2+s379DhUbj@slm.duckdns.org>
 <Y5bsBuwjcbHEjhIw@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5bsBuwjcbHEjhIw@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Christoph.

On Mon, Dec 12, 2022 at 12:53:26AM -0800, Christoph Hellwig wrote:
> > +static int blk_iolatency_try_init(char *input)
> > +{
> > +	static DEFINE_MUTEX(init_mutex);
> > +	struct block_device *bdev;
> > +	int ret = 0;
> > +
> > +	bdev = blkcg_conf_open_bdev(&input);
> > +	if (IS_ERR(bdev))
> > +		return PTR_ERR(bdev);
> 
> > +retry:
> >  	ret = blkg_conf_prep(blkcg, &blkcg_policy_iolatency, buf, &ctx);
> > +	if (ret == -EOPNOTSUPP) {
> > +		ret = blk_iolatency_try_init(buf);
> 
> It's a little sad to do two block device lookups here (even if it
> obviously doesn't matter for performance).  I wonder if it would
> make sense to explicitly support the lazy init pattern
> in blkg_conf_prep somehow.
> 
> Otherwise I'm all for the lazy init.

Yeah, I thought about separating out open_bdev from blkg_conf_prep() but the
added complexity didn't feel very attractive given the usage pattern. Lemme
take a stab at it. Maybe it won't look too bad.

Thanks.

-- 
tejun

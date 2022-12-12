Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA764A9B3
	for <lists+cgroups@lfdr.de>; Mon, 12 Dec 2022 22:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiLLVrI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 16:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiLLVrD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 16:47:03 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8711C192A4;
        Mon, 12 Dec 2022 13:47:02 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c13so872065pfp.5;
        Mon, 12 Dec 2022 13:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qiAQ7WTwZr4dVTtMKJayehUb8HIRKe6ZlI8Mkp+Y78=;
        b=bQdgiHkGAhLziF8YrE6lY1CbCjAd+Q93tt3s7B8OuQurw+fBLJSpXapeoQaWoGZaCu
         pW23g/hLxu3YE+Ri3icoxByE0NpQbPuYRKm0O44+zvDAKNWI4dZPRINx9W16HsUoSdCB
         mDygSc6MDZPTYGJWHfRTLiZugJJLsljMh9rjcxrw5rIm3xd4N2+rOrwUJVhkj4WFAt9O
         ps7VSjNuawEnABvIeNBm++nfKVPatwvO+Yt/cH+xxUCqdqlwTio2ARN+cmMZ3TnCRgL8
         HMNsEYRtDBw2k4+p9EeEBSbg9SZxYykoFL4ShGXYiCZ683mFThj8DLxwmff6vHfGqwzS
         q1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qiAQ7WTwZr4dVTtMKJayehUb8HIRKe6ZlI8Mkp+Y78=;
        b=LJpHuVbzmpDI31qWHHKvkR7wWWLgpHMBkZu7chjcMt4xULpJVSIGXwfevS6ptZkUyi
         44HXF4JW53DeHRdK4Y+XFscTWzN0PYVetDtwD3+jynGuTdQH5ksw1vOMm8KFx4AQnQWd
         O4rfTYtoKe5eajmYzpMwwNqscnNRdqCAUlWWHIl+J6u9IKNZgdD4S1FO0BeOAvg+KP74
         ivs2CZNPL9R5gKzLF61ZUty/cZGOgp2xKrVtLH3cf4LwWBFPB+xVBPrOAbycdtTy4ORv
         VsRAieBWHq98GhO5QduIZmR7/8DNK7wRHwqNOsmAOEnhJPtlqpgQeZSSmHsyoQC80dfX
         HunQ==
X-Gm-Message-State: ANoB5plY+PXTXqR9WyqOjYPsa3ipjKVSn9NQWmgL4C7S2BFvWhA4wUgs
        uNFVZ5MLmAYWT1Oj7R4wDIc=
X-Google-Smtp-Source: AA0mqf6FYZFa62ntzOFykUefdpR0zUL84rPMRalzLreyTNxWJpv2jD0oJuR8N24+bpAwNeG7dA7ydg==
X-Received: by 2002:a05:6a00:1411:b0:574:a541:574a with SMTP id l17-20020a056a00141100b00574a541574amr20784128pfu.0.1670881621860;
        Mon, 12 Dec 2022 13:47:01 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id o24-20020aa79798000000b005745eb7eccasm6236062pfp.112.2022.12.12.13.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:47:01 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 11:46:59 -1000
From:   'Tejun Heo' <tj@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
Message-ID: <Y5ehU524daymEKgf@slm.duckdns.org>
References: <20221031114520.10518-1-jirislaby@kernel.org>
 <Y1++fLJXkeZgtXR2@infradead.org>
 <Y2AMcSPAJpj6obSA@slm.duckdns.org>
 <d833ad15-f458-d43d-cab7-de62ff54a939@kernel.org>
 <Y2FNa4bGhJoevRKT@slm.duckdns.org>
 <2b975ee3117e45aaa7882203cf9a4db8@AcuMS.aculab.com>
 <Y2Kaghnu/sPvl0+g@slm.duckdns.org>
 <Y2KePvYRRMOrqzOe@slm.duckdns.org>
 <320c939e-a3f0-1b1e-77e4-f3ecca00465d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <320c939e-a3f0-1b1e-77e4-f3ecca00465d@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 12, 2022 at 01:14:31PM +0100, Jiri Slaby wrote:
> > If so, my suggestion is just sticking with the old behavior until we switch
> > to --std=g2x and then make one time adjustment at that point.
> 
> So is the enum split OK under these circumstances?

Oh man, it's kinda crazy that the compiler is changing in a way that the
same piece of code can't be compiled the same way across two adjoining
versions of the same compiler. But, yeah, if that's what gcc is gonna do and
splitting enums is the only way to be okay across the compiler versions,
there isn't any other choice we can make.

Thanks.

-- 
tejun

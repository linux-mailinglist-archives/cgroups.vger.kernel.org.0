Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F88661699A
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 17:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiKBQrT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 12:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiKBQrB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 12:47:01 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88063881;
        Wed,  2 Nov 2022 09:43:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so2384353pjd.4;
        Wed, 02 Nov 2022 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjILPpgQCkdJ4ZJ00jqJd+jDzKRU2FaGMqk858NL3dc=;
        b=dmYqXsN8lNSxDB0uXZQ6rsGrA/k+VAfEyFqeOxCavCTGaiakcfSobJRaJXd2d44clP
         vePC8myNAyorRGZlHkyKFDWfDtHP5piVxFEmd2RIXh2alwwo5zzXbMM0gVYAB240ufeC
         BgwRQpvEbW5ci641cMKU9oeO0uy5YHwABAcwhS+tW9+uFasjdpHBw5kBn4hlu+yvhexy
         zYdekQFPfwwqLUoR4mMgJ+pjdSLT6VTwv8IL2TQMfn6TVQtNqv5voIx3cG1/YBxQ60Xo
         X1/4W/XW8zPw9QTSfFsoZeywYppP3uQCxwbKM76sSytyCSMZqvIX5bYdoFsGDSQ29g0O
         OSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjILPpgQCkdJ4ZJ00jqJd+jDzKRU2FaGMqk858NL3dc=;
        b=t1ITDUzOMVHsvvyGgYCQEGMAJ0L2ozLZlQviJdvdHBh4f/PAsOIhafxkBic1SdjE9l
         fLEFaphEbZwRobikOgk/qRpUZo9m52ZWz2t3R+nZh3dRTnHXVCc/tLPo3uCBLvD6FFFn
         juiDQIXTYuu9WPQ6c3KxL6i4Z6CErQQjZOhnU5AooWDdDrFFJ6IQM+/n4bA5UiEDxkw1
         RPAhmdV6diBTlgWcK+2rLrx5CutVFupsMpgQ6k7CAbBemwyAGUpivQ/LytH4r+1ECbGb
         pVpvIE81iNXNYwRkrg/FMsbj2rXyCwn51qGN8G6snSqHeQn3hEnaQrNlWx2bo/bRXVMK
         tNng==
X-Gm-Message-State: ACrzQf1xVQMtOmscxorfIKyOrjP2k3QwS7yt/fhiCe43uUABPY1PZzCV
        QAj2TrxH0BsoIIVFZn+cnPM=
X-Google-Smtp-Source: AMsMyM5+2h1g5QncFyVKf/9QXnl3us6XD14UDGR0pb/Wvj24kswOJM73+P7ddL0Enyhat7ZA1AAn4A==
X-Received: by 2002:a17:902:da8a:b0:187:3d6:4c60 with SMTP id j10-20020a170902da8a00b0018703d64c60mr25714581plx.117.1667407424152;
        Wed, 02 Nov 2022 09:43:44 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b001784a45511asm8591248plf.79.2022.11.02.09.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:43:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Nov 2022 06:43:42 -1000
From:   'Tejun Heo' <tj@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
Message-ID: <Y2KePvYRRMOrqzOe@slm.duckdns.org>
References: <20221031114520.10518-1-jirislaby@kernel.org>
 <Y1++fLJXkeZgtXR2@infradead.org>
 <Y2AMcSPAJpj6obSA@slm.duckdns.org>
 <d833ad15-f458-d43d-cab7-de62ff54a939@kernel.org>
 <Y2FNa4bGhJoevRKT@slm.duckdns.org>
 <2b975ee3117e45aaa7882203cf9a4db8@AcuMS.aculab.com>
 <Y2Kaghnu/sPvl0+g@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Kaghnu/sPvl0+g@slm.duckdns.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 02, 2022 at 06:27:46AM -1000, 'Tejun Heo' wrote:
> On Wed, Nov 02, 2022 at 08:35:34AM +0000, David Laight wrote:
> > I think the enums have to be split.
> > There will be other side effects of promoting the constants to 64bit
> > that are much more difficult to detect than the warnings from printf.
> 
> idk, I think I can just add LLU to everything and it should be fine.
> 
> > I'm also not sure whether the type is even consistent for 32bit
> > and 64bit builds.
> > Casts are (sort of) horrid.
> 
> Yeah, I don't think casts are the solution either. Lemme add LLU to
> everything and see how it works.

So adding LLU to initializers don't make the specific enum's type follow
suit. I guess type determination is really based on the value range. Oh man,
what a mess.

If we end up having to split the enum defs, that's what we'll do but this
doesn't sense to me. It's one thing to make one time adjustment when we
adopt -std=g2x. That's fine, but it makes no sense for the compiler to
change type behavior underneath existing code bases in a way that prevents
the same code to mean the same thing in adjacent and recent compiler
versions. Even if gcc goes for that for whatever reason, there gotta be an
option to keep the original behavior, right?

If so, my suggestion is just sticking with the old behavior until we switch
to --std=g2x and then make one time adjustment at that point.

Thanks.

-- 
tejun

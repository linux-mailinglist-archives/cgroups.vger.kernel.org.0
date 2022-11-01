Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E9D614FA1
	for <lists+cgroups@lfdr.de>; Tue,  1 Nov 2022 17:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKAQqk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 12:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKAQqj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 12:46:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD49712A95;
        Tue,  1 Nov 2022 09:46:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso13375477pjc.5;
        Tue, 01 Nov 2022 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NNV/E5PvWzmIXNGvDSWT/6GgvR8jci+9gjd8ctauYo=;
        b=LEL4GYFUmS8dUOAT/5nK1/KYd+ZwtOmK9IedlMya1qlOZRx+FuuuuA/CtLRS+eCLRz
         Nsz6Dr/k/g6GAPFyavmARI1wuovp24HHeB6HGw0lS3IQv+qRkvB0JZ1gKMbi/FLWoeYh
         H2hrCDdMs7KYEipsyf2LL7i2N5mYxjOCRDArSv1s0QSKfzMKIORCDRuOqdmBpwsohacW
         6QuUicBqOf+POhLdqmHX7PXtL0vRcyB4s4VBHQpx3CLs1uS4Aad6MGQMTANTDZpWbGKo
         YyQDpVTaEkJBqnArwECrk8uywmNczFnR0FTUAaZWfA8KK93xKlpBmR2J0DO1TKHyVw0i
         qwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NNV/E5PvWzmIXNGvDSWT/6GgvR8jci+9gjd8ctauYo=;
        b=XbGmplaJ1I/m10NJJcKSkxbtUGeBcdIwhBOKutqwaMyMsQFi5CBBBcvZscFsW+ffGK
         Q+tM79u8utZ8kTZdDSZbfBfSdrvAhiuU6uWtC5fVAPP9744hrmbWj+0bImT+rYGd8+T+
         /SriZiKZ7su6NzVby42YH9GFZyeY8m/1QXP7Xs4p3buxl2tCyhgr7pJpqT2jMnn/7PdF
         ftDdt40eqbQ11w8C6BzVjVGJ9Ga6KkdnEESvyVgJY+9ZyYFu7k2H0SyhMCK8kSDsDhOK
         7PcLnXM40INTFl+YLjsZ8TvzPVCepgxJ9wzeHe34OJrk0YFPRsUH2jPyC9CNs/2mucXY
         GxcA==
X-Gm-Message-State: ACrzQf2QTJ36zMvC8dkXEsULgwHt5wvP+Aeh+zuodziSRvuKJDmnqyCW
        zZ6Z7vZW19t+l78hQ8dmUmaEE7RPKLC71A==
X-Google-Smtp-Source: AMsMyM7gRgdNVhhxA9mKmp7nYeepdqg6rs0kbUI0glNDKNRPfKqztAuA7caGIiSRhU54fNwxObiiuQ==
X-Received: by 2002:a17:902:d4ce:b0:187:17bd:44d7 with SMTP id o14-20020a170902d4ce00b0018717bd44d7mr14164487plg.84.1667321197086;
        Tue, 01 Nov 2022 09:46:37 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7984f000000b0055f209690c0sm6748817pfq.50.2022.11.01.09.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:46:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 1 Nov 2022 06:46:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
Message-ID: <Y2FNa4bGhJoevRKT@slm.duckdns.org>
References: <20221031114520.10518-1-jirislaby@kernel.org>
 <Y1++fLJXkeZgtXR2@infradead.org>
 <Y2AMcSPAJpj6obSA@slm.duckdns.org>
 <d833ad15-f458-d43d-cab7-de62ff54a939@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d833ad15-f458-d43d-cab7-de62ff54a939@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Nov 01, 2022 at 06:46:56AM +0100, Jiri Slaby wrote:
> Yes. The real problem is that using anything else then an INT_MIN <= x <=
> INT_MAX _constant_ in an enum is undefined in ANSI C < 2x (in particular, 1
> << x is undefined too). gcc manual defines unsigned int on the top of that
> as defined too (so this holds for our -std=g*).
> 
> > I suppose the most reasonable thing to do here is just splitting them into
> > separate enum definitions. Does anyone know how this behavior change came to
> > be?
> 
> C2x which introduces un/signed long enums. See the bug I linked in the
> commit log:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36113

I see. So, it was an extension but the new standard is defined differently
and we're gonna end up with that behavior.

> The change is also turned on in < C2x on purpose. AIUI, unless there is too
> much breakage. So we'd need to sort it out in (rather distant) future anyway
> (when we come up to -std=g2x).

The part that the new behavior applying to <C2x feels like an odd decision.
I'm having a hard time seeing the upsides in doing so but maybe that's just
me not knowing the area well enough.

> > Do we know whether clang is gonna be changed the same way?
> 
> In C2x, Likely. In < C2x, dunno what'd be the default.

It looks like we can do one of the following two:

* If gcc actually changes the behavior for <c2x, split the enums according
  to their sizes. This feels rather silly but I can't think of a better way
  to cater to divergent compiler behaviors.

* If gcc doesn't change the behavior for <c2x, there's nothing to do for the
  time being. Later when we switch to -std=g2x, we can just change the
  format strings to use the now larger types.

Does the above make sense?

Thanks.

-- 
tejun

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D19D75B881
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 22:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjGTUG6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 16:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGTUG5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 16:06:57 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453842118;
        Thu, 20 Jul 2023 13:06:57 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8b4749013so8939045ad.2;
        Thu, 20 Jul 2023 13:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689883617; x=1690488417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRzMPL6a/BSNtiQ7PJzND7IfnG5RjjKshq+ayDJRwvE=;
        b=kZIq9ybemRD+z70zrt95FXrBHFPHV9z/ZL6uhkUy+NMiMeb1ftSsvyQesVG3rung/8
         StKvGhzKm87e0EmDAArGi/OpQRYaBX+ijkyxRDwREw4WO3X3HDnALsNzYZqcx5Sd6QOc
         iWEVrUthWYQCvOKLAo3ODL8Pl9vUglt3E4qiHVwNbLXnFmj8aJCwpmZaaWZLoKn/mJiB
         Ovi+Zy45y62uqB0h4m29zNjzHs7UitPpt+kYNHyLYVEIJAvO3JuTUzbjSB/BaEeodbnI
         Zj/AeMIOXUGtWYEs/nE8rLZUXzAEfnHm7xpk1IuVAsdG5NsWCk5BwlL0fo+ioKeQuWY5
         1yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883617; x=1690488417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRzMPL6a/BSNtiQ7PJzND7IfnG5RjjKshq+ayDJRwvE=;
        b=GjcV4kZ+kivLH130KjDnCbB0IHe/Fppd1Hj1xcNKv6jxDaoRR3w46Ny3I91nbQ26yM
         gIpshXPJRbZEbTFhqvMITiRSI6ndkaWJLFZN9GNZOpEwxcj9DiIGYKkuAJlA/zl6ZsHa
         nNYSmIX2tYVU7Ph6vOluwxD5nIvYJtxdGHv1+Vc9DL+hxjBPS5Qe7G6ope2zPx2c0evE
         wZlQdmZnXElKHrTkoqPXCVc9jfQcJnn25nhOPV0qoBDqHOJLEPoOPgaYf6o/trOHxt+1
         7xOZ7Y2VJM9Rpcnnmm7Fl+bkubwm3I42MNdX2RkcQaWEDSR7mLWAp9+zzYWFkwT1KhLZ
         ixlw==
X-Gm-Message-State: ABy/qLbkrh8h+YmD5a+6wBDrsActp1MuL1HJCk2DKQc3I9BmxaUw2d+k
        DvIb5dhYhYfGTfE9u5zXuzQ=
X-Google-Smtp-Source: APBJJlHRyNzSlmZk1gO0I4KgaFJfKwcCiGrlMaE9Y6r8Y2/J8zvtUfOH8dB947pcEUNUBxJs0cIa6g==
X-Received: by 2002:a17:903:22c4:b0:1b6:6b03:10cd with SMTP id y4-20020a17090322c400b001b66b0310cdmr4453plg.67.1689883616584;
        Thu, 20 Jul 2023 13:06:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id jh6-20020a170903328600b001aad714400asm1795608plb.229.2023.07.20.13.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:06:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 Jul 2023 10:06:54 -1000
From:   'Tejun Heo' <tj@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        amd <amd@localhost.localdomain>
Subject: Re: [PATCH] blk-iocost: fix seq_printf compile type mismatch error
Message-ID: <ZLmT3mXuDlYY61w0@slm.duckdns.org>
References: <20230717141852.153965-1-carlos.bilbao@amd.com>
 <ZLWNHuTGk0fy8pjE@slm.duckdns.org>
 <2b4540aadc3c4449a192aeed6211f232@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b4540aadc3c4449a192aeed6211f232@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 19, 2023 at 08:57:32AM +0000, David Laight wrote:
> From: Tejun Heo
> > Sent: 17 July 2023 19:49
> > 
> > On Mon, Jul 17, 2023 at 09:18:52AM -0500, Carlos Bilbao wrote:
> > > From: amd <amd@localhost.localdomain>
> > >
> > > Fix two type mismatch errors encountered while compiling blk-iocost.c with
> > > GCC version 13.1.1 that involved constant operator WEIGHT_ONE. Cast the
> > > result of the division operation to (unsigned int) to match the expected
> > > format specifier %u in two seq_printf invocations.
> > 
> > Can you detail the warnings? Was that on 32bit compiles?
> 
> The problem is caused by gcc 13 changing the types of the
> constants inside an enum to be all the same.
> 
> The best fix is (probably) to replace all the enum used to
> define unrelated constants with #defines.

Yeah, but then you end up without any way to read that value from outside
the kernel for BPF, drgn or any other tools which use debug info. That
actually matters.

Thanks.

-- 
tejun

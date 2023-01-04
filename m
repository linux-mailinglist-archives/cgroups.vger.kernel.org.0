Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907E465DFBF
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 23:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240503AbjADWRQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 17:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbjADWRQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 17:17:16 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5381F65F8;
        Wed,  4 Jan 2023 14:17:15 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 36so23234446pgp.10;
        Wed, 04 Jan 2023 14:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBdR1OYvv5zIjW+hrNHEjqsBYdzTVZarSCYttdRP9P0=;
        b=QMHC+W+cPdzEvzu7OmXQnPcvd3ozAn24UBAx+NJZqCwKaCIFamFDpMO5+0fusnSF32
         7rMEcXxCkh4xwbepxkxjCAqOfToVfBsCo5T4Zhh1dfX2BqcKbKxuLLFRvRk+KozCh6mx
         PiCfloJVXYuGwuqkgKdvzg966p0QrHBmHM/DBZD5gJ4Ko0FRf6GQKmkum04ZTwYAA9cE
         driK/F8H6DubpL+VDkSG5dj/M2uRgMqzRORN7tTGUotYlF33zztJk2LStCylCgiyWQTH
         E2UEA+UtPJK0jAs+7pXInfPnzlYTC2Q7qiiRVolqUUgI1DbrVvUN8MvIboES+bgyLdJg
         tq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBdR1OYvv5zIjW+hrNHEjqsBYdzTVZarSCYttdRP9P0=;
        b=EFryHCV7JWZRztQ1l6im6JTuZjHo6Qyu1Hm56+O+Tt6uLRsG6awVGDOHz3h23RFLJu
         Uq6ReGIgZLOx850KXd4GdEXoy/V03Xb78NQ4Uo5BB8M/+M9oKRqNYa1vAdLnVlOBFYRb
         lhkiyaNHQGQYdB5f1IHNE+eG5kqRV18g6U5EGKDK9qUMfKUxqd2cjFMa6mYlghdQzK/I
         uRhPWB/WQkMDS/69FtciLXWd7h58MGnaT9S+w87pxwmXUmMHUKoljhB+7qhzC7FZ2ctw
         JPaCFw6pDb5Sm71iq4YPX2rDk5n7W6GMjO9dIric10MvdjK/n5qPhU3sxLQPYbYzB8Kq
         WvyQ==
X-Gm-Message-State: AFqh2krBaUgmiHoc5OE+n8Fmh8JdSQau4vpQMsg7NK2X/Fqq9dvonMG/
        RBp65VVpXZEYJxlGYLiM/fs=
X-Google-Smtp-Source: AMrXdXtp1FOgKJapFay7R/Uc+L09gGitWWTApSjT57fgZ9XZutFON8Lz6yWq6yuVU18c/qzHQWw+pw==
X-Received: by 2002:a62:cf42:0:b0:581:a004:3f36 with SMTP id b63-20020a62cf42000000b00581a0043f36mr26189605pfg.25.1672870634700;
        Wed, 04 Jan 2023 14:17:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b27-20020aa78edb000000b0056b9ec7e2desm23036966pfr.125.2023.01.04.14.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:17:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 12:17:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-iocost: don't make all constants unsigned long long
Message-ID: <Y7X66RDNGhB45rzZ@slm.duckdns.org>
References: <20221220201819.1497577-1-ydroneaud@opteya.com>
 <20221222135855.GC20830@blackbody.suse.cz>
 <Y7X6ajqnPrtFAL0C@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7X6ajqnPrtFAL0C@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 04, 2023 at 12:15:06PM -1000, Tejun Heo wrote:
> On Thu, Dec 22, 2022 at 02:58:55PM +0100, Michal Koutný wrote:
> > On Tue, Dec 20, 2022 at 09:18:19PM +0100, Yann Droneaud <ydroneaud@opteya.com> wrote:
> > > +enum {
> > >  	/* switch iff the conditions are met for longer than this */
> > >  	AUTOP_CYCLE_NSEC	= 10LLU * NSEC_PER_SEC,
> > > +};
> > 
> > This looks gratuitous.
> > 
> > What about indivudial #defines with typed literals instead of the "lazy
> > splitting"?
> 
> enums are so much better for debugging and tracing. This is a gcc caused
> problem where there's no other way to generate the same code between two gcc
> versions without splitting the enum definitions. I'm kinda baffled that this
> is what they chose to do but can't think of a better way to work around it.

I thought this was the other patch addressing this issue. The proposed patch
is rather painful to look at. The other one splits it into two groups.

Thanks.

-- 
tejun

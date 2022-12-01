Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E3563ED1E
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 11:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLAKAp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 05:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiLAKAo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 05:00:44 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C50B1D1;
        Thu,  1 Dec 2022 02:00:42 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so1485970pjj.4;
        Thu, 01 Dec 2022 02:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvAcF4yt3U38ulka5v5lZO8tAA6N2kN/9W8fhnuQ3DA=;
        b=PthsZ+Q8Y6NJRwPCIBP8MuFSXijY5REyP5RtsSO9OPxZiWTEKKwFMOos6DjWLQvBKM
         9+68aLFA2KJibeLzcXKW+TRr0f8kBeVJPCy/2qKzfHy90Fie4M+cp5nPkc4pk11SeAia
         jH57uge2Q/jZXwDKyyUdiowPc6qMj7ayVGHpMarZsh6DN2oGN8wu5NKo3Iqfpk4ydUIY
         gmi0PquZQL7ahFmfCvPlElkpeJ25wvgTILpt2DQBpdv8azUNSn4Cu5/LBB5hDW8mQ6bU
         yoe5DDNTuabeiXazVGv43j+CRYcNSOCynorXMDyO4wEWc21G3Ob/mnt/+/tlpaqSP8bC
         8inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvAcF4yt3U38ulka5v5lZO8tAA6N2kN/9W8fhnuQ3DA=;
        b=KGQeTFmVefap1I1F7sL06aLc30TWe4O2+9GFZ9OinTb9IwPYT8SAkPFZubmSnEPpGK
         CeLVcsJTp3yhFsVJNdRk5un3j+iz2LK0ehiOpmPnjcX0kZ9fh8JHMDO2nR+MiIL4DI0N
         GCCCKH94/wsD5w7gs6hVIP+WK70ox5kqyuioagD6Y4zjf0bLgFy9yTNj0W6JrXVlYAtO
         GIoLO94QtXwsc3W97n61SAmBgyL/r3d/HlRM/Kj5VQAit5IjM+5YTqQSaJv6760K1OTR
         r5HxasWm9ZgfPtnRq3TBoH+entgf7FMoeVNgvVTG78QRDsal2ET3BYA8M9OVU2vR930n
         f/Gw==
X-Gm-Message-State: ANoB5pmjI+OwdBzoqBeuyxqsKdA4sVfPZ8/duxEhcAdtMqPV98kgT5Ju
        qe1eMc1ZnDnTNrxeNaWj85M=
X-Google-Smtp-Source: AA0mqf4q2CFgsKrPNGmoGiXBxaXgDpo6jm9FaGZY3ctXH6/vkBqjnYSGyNASdEdM2/KZINfk539FIw==
X-Received: by 2002:a17:902:ab89:b0:185:3659:1ce9 with SMTP id f9-20020a170902ab8900b0018536591ce9mr44744790plr.26.1669888841580;
        Thu, 01 Dec 2022 02:00:41 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902f64d00b001891ea4d133sm3185378plg.12.2022.12.01.02.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:00:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 1 Dec 2022 00:00:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan122@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next v2 9/9] blk-iocost: fix walk_list corruption
Message-ID: <Y4h7RxdT83g+zFN0@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-10-linan122@huawei.com>
 <Y4fEKZy4rTE5rG/5@slm.duckdns.org>
 <c028dd77-cabf-edd6-c893-8ee24762ac8c@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c028dd77-cabf-edd6-c893-8ee24762ac8c@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 01, 2022 at 09:19:54AM +0800, Yu Kuai wrote:
> > > diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> > > index 710cf63a1643..d2b873908f88 100644
> > > --- a/block/blk-iocost.c
> > > +++ b/block/blk-iocost.c
> > > @@ -2813,13 +2813,14 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
> > >   {
> > >   	struct ioc *ioc = rqos_to_ioc(rqos);
> > > +	del_timer_sync(&ioc->timer);
> > > +
> > >   	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
> > >   	spin_lock_irq(&ioc->lock);
> > >   	ioc->running = IOC_STOP;
> > >   	spin_unlock_irq(&ioc->lock);
> > > -	del_timer_sync(&ioc->timer);
> > 
> > I don't about this workaround. Let's fix properly?
> 
> Ok, and by the way, is there any reason to delete timer after
> deactivate policy? This seems a litter wreid to me.

ioc->running is what controls whether the timer gets rescheduled or not. If
we don't shut that down, the timer may as well get rescheduled after being
deleted. Here, the only extra activation point is IO issue which shouldn't
trigger during rq_qos_exit, so the ordering shouldn't matter but this is the
right order for anything which can get restarted.

Thanks.

-- 
tejun

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F3863EDC1
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 11:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiLAK3P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 05:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiLAK3O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 05:29:14 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A505B17E0D;
        Thu,  1 Dec 2022 02:29:13 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d3so1211744plr.10;
        Thu, 01 Dec 2022 02:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q0yvFuHBJfRIpQvKHdUxBRA6+MC7NXxIM6ZLed908Mg=;
        b=jnaT62SdRfAmhvoMq4Z06tsiQjuTmLKUVCirP+nkHORlRzdErj6ufu5pb0uIJJlIBD
         5odOKusGLj7GLS/2OGCFrwhOioJLUfiBcCj1gaaHRbSeSDYaoSmk3m0QhnQ/iuaa9Hzw
         M4x4WiPzAfdSzjuOz9v3FimEerbjpgfr3rGvV/ELh5MRcM5OgsVe948XKOI1yuJz63IC
         PyMgP2bncRqEdSJg/5CFrSn+Ogy9xdjWqcrIAlkZC7ohRK1PODJ4uegtDYSp9eJ/f10e
         /F+riMH2OzCXjsANfrNwW4UozF3v7RiHFrm55N7DuOLvOeUpc3vZJb4RWXAVQhQhLSQQ
         KGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0yvFuHBJfRIpQvKHdUxBRA6+MC7NXxIM6ZLed908Mg=;
        b=xIz3d1VULzNo8OWWeCOysYAmLQO52OyACm9fb6kzrHSu/xUFKhbqM2naBM/MMMrklk
         Gz3UaJfgux375lJnNvHpOR31GHU8Q/q6Fae0t6fizZYIbOHFuVXSAZ3vP/F7dFg+ybsS
         yMCEPoPlylUnrBq1Ws2ZbHIY9/+AyYYLGz3HOh+61laMLO3qDROPFvoSm7dADs5QTkYr
         HlxUcSrJMAwFU2AxvJpIsgXJYailvmc9tHzILqsMLXfMxnDQbnkYwKk1toL0CukpElES
         k57aChNZkcQjc+uPykXyikBd7AjKCD2QZqRf3WyagKlHLmdUq/gLAZhM9f6iaL7zRan+
         i04g==
X-Gm-Message-State: ANoB5pmMzWALE30DvOJZIP1gSgq4D3hnmdHUC5qxuo+F4AY343JoxdtN
        sOOOn6k+2bCD3cp05ATxC8g=
X-Google-Smtp-Source: AA0mqf53hZSK/PYK373YKoxAvojrzBvaeLJZSKxX1kP8zUZSia5yfWSDRNAC+4Gd8NOjdyCWpY/x9Q==
X-Received: by 2002:a17:90a:8c96:b0:218:7e9d:8d0a with SMTP id b22-20020a17090a8c9600b002187e9d8d0amr64650230pjo.41.1669890552940;
        Thu, 01 Dec 2022 02:29:12 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y13-20020aa79aed000000b0056b8b17f914sm2899710pfp.216.2022.12.01.02.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 02:29:12 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 1 Dec 2022 00:29:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan122@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next v2 9/9] blk-iocost: fix walk_list corruption
Message-ID: <Y4iB97kcdKHEQP86@slm.duckdns.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-10-linan122@huawei.com>
 <Y4fEKZy4rTE5rG/5@slm.duckdns.org>
 <c028dd77-cabf-edd6-c893-8ee24762ac8c@huaweicloud.com>
 <Y4h7RxdT83g+zFN0@slm.duckdns.org>
 <de04965e-1341-3053-0f4b-395b8390d00c@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de04965e-1341-3053-0f4b-395b8390d00c@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 01, 2022 at 06:14:32PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2022/12/01 18:00, Tejun Heo 写道:
> > On Thu, Dec 01, 2022 at 09:19:54AM +0800, Yu Kuai wrote:
> > > > > diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> > > > > index 710cf63a1643..d2b873908f88 100644
> > > > > --- a/block/blk-iocost.c
> > > > > +++ b/block/blk-iocost.c
> > > > > @@ -2813,13 +2813,14 @@ static void ioc_rqos_exit(struct rq_qos *rqos)
> > > > >    {
> > > > >    	struct ioc *ioc = rqos_to_ioc(rqos);
> > > > > +	del_timer_sync(&ioc->timer);
> > > > > +
> > > > >    	blkcg_deactivate_policy(rqos->q, &blkcg_policy_iocost);
> > > > >    	spin_lock_irq(&ioc->lock);
> > > > >    	ioc->running = IOC_STOP;
> > > > >    	spin_unlock_irq(&ioc->lock);
> > > > > -	del_timer_sync(&ioc->timer);
> > > > 
> > > > I don't about this workaround. Let's fix properly?
> > > 
> > > Ok, and by the way, is there any reason to delete timer after
> > > deactivate policy? This seems a litter wreid to me.
> > 
> > ioc->running is what controls whether the timer gets rescheduled or not. If
> > we don't shut that down, the timer may as well get rescheduled after being
> > deleted. Here, the only extra activation point is IO issue which shouldn't
> > trigger during rq_qos_exit, so the ordering shouldn't matter but this is the
> > right order for anything which can get restarted.
> 
> Thanks for the explanation.
> 
> I'm trying to figure out how to make sure child blkg pins it's parent,
> btw, do you think following cleanup make sense?

It's on you to explain why any change that you're suggesting is better and
safe. I know it's not intentional but you're repeatedly suggesting operation
reorderings in code paths which are really sensitive to ordering at least
seemingly without putting much effort into thinking through the side
effects. This costs disproportionate amount of review bandwidth, and
increases the chance of new subtle bugs. Can you please slow down a bit and
be more deliberate?

Thanks.

-- 
tejun

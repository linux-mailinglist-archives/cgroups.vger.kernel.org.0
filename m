Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8691866081D
	for <lists+cgroups@lfdr.de>; Fri,  6 Jan 2023 21:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjAFUTb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Jan 2023 15:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbjAFUTC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Jan 2023 15:19:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B88F3C71C;
        Fri,  6 Jan 2023 12:18:44 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id d10so1871727pgm.13;
        Fri, 06 Jan 2023 12:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pkeYcttUcyfVrFL8X+osrQ13cRbijdYYhUpcZOzwgVQ=;
        b=TVhIvkrP1GydF6XTEwRgMc0p7+PudExrV0d9GFdbYVxpNRsluyY1colI3e/NeKEtfU
         s/Eizxr1yYhXxQrAX9ywQiW2ITYXw49/JBSP2VERJMGlcIuUKEk1ZAQixCDviFa+0aZV
         6Bnr7lfzH1wm8zI4+lk+YeF2UM4Bh7q/ocrTurSu/Q6A/auHyG9ckPAKZh+NPzFvwsyM
         gGVsxz4EELJ58//kjaxDrXlLlZLupXJsVMzZLdK89y8YW/RoOJkHg+awQTiMxq6gpeyI
         mohFe/Ml0fFJ/oK6h0uGIv6bsMK7IvAQgRAcZuVCXQQ9eih1lSW7Qkp7rSHskDR0rpAn
         FD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkeYcttUcyfVrFL8X+osrQ13cRbijdYYhUpcZOzwgVQ=;
        b=Uchti6I3Ae7T7LoV5crkWVhEezXuwrYoQKDz6443tbkbG3wOh1Xs8Br1nh7Ij4+EnK
         5V/69SduuiVEFd/SEHg52ELsmxchA0sn5N17MnZ5nIcNVSRDwjvqi3dmvUPIyiFbpEZF
         m6j99kfi801bpyvzUlJc03tOtEhkdVrFopH47M9NcSH4J7ae5gpmpOVO3GAynl7gJMCd
         89PtrMyXrbX+LbOF94SI0F+vn5JcN4GsDMtz5o+NRQKHYFI58DDDA61YYzPfpdn9y/Xm
         WTijux+xjaB+WsE56QddM0AhnPhMPETArEoUVi92oQmLJxMa3uG/efbhFzrsNXoNRAb/
         QUmQ==
X-Gm-Message-State: AFqh2kolAS6OMokiyQpwSqXMhB5X44umMaCqhg+n8THmAswMRue80eHA
        FR4jhJMbpyCKd0grbyjN+uQ=
X-Google-Smtp-Source: AMrXdXt2A9473kqnImKIHqnN0Y3fAk6hSHiIirDvHd4RwRDUYPsDbcaw4Q3ijpC8TG3n3ohCfojBCw==
X-Received: by 2002:aa7:96f9:0:b0:582:7007:3fec with SMTP id i25-20020aa796f9000000b0058270073fecmr20068579pfq.11.1673036323362;
        Fri, 06 Jan 2023 12:18:43 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b29-20020a62a11d000000b005769ccca18csm1480351pff.85.2023.01.06.12.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:18:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 6 Jan 2023 10:18:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
Message-ID: <Y7iCId3pnEnLqY8G@slm.duckdns.org>
References: <20221227125502.541931-1-yukuai1@huaweicloud.com>
 <20221227125502.541931-2-yukuai1@huaweicloud.com>
 <Y7XzUee5Bq+DoIC1@slm.duckdns.org>
 <c63ee2ad-23d5-3be0-c731-28494398b391@huaweicloud.com>
 <Y7cX0SJ0y6+EIY5Q@slm.duckdns.org>
 <7dcdaef3-65c1-8175-fea7-53076f39697f@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dcdaef3-65c1-8175-fea7-53076f39697f@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 06, 2023 at 09:08:45AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/01/06 2:32, Tejun Heo 写道:
> > On Thu, Jan 05, 2023 at 09:14:07AM +0800, Yu Kuai wrote:
> > > 1) is related to blkg, while 2) is not, hence refcnting from blkg can't
> > > fix the problem. refcnting from blkcg_policy_data should be ok, but I
> > > see that bfq already has the similar refcnting, while other policy
> > > doesn't require such refcnting.
> > 
> > Hmm... taking a step back, wouldn't this be solved by moving the first part
> > of ioc_pd_free() to pd_offline_fn()? The ordering is strictly defined there,
> > right?
> > 
> 
> Moving first part to pd_offline_fn() has some requirements, like what I
> did in the other thread:
> 
> iocg can be activated again after pd_offline_fn(), which is possible
> because bio can be dispatched when cgroup is removed. I tried to avoid
> that by:
> 
> 1) dispatch all throttled bio io ioc_pd_offline()
> 2) don't throttle bio after ioc_pd_offline()
> 
> However, you already disagreed with that. 😔

Okay, I was completely wrong while I was replying to your original patch.
Should have looked at the code closer, my apologies.

What I missed is that pd_offline doesn't happen when the cgroup goes
offline. Please take a look at the following two commits:

 59b57717fff8 ("blkcg: delay blkg destruction until after writeback has finished")
 d866dbf61787 ("blkcg: rename blkcg->cgwb_refcnt to ->online_pin and always use it")

After the above two commits, ->pd_offline_fn() is called only after all
possible writebacks are complete, so it shouldn't allow mass escapes to
root. With writebacks out of the picture, it might be that there can be no
further IOs once ->pd_offline_fn() is called too as there can be no tasks
left in it and no dirty pages, but best to confirm that.

So, yeah, the original approach you took should work although I'm not sure
the patches that you added to make offline blkg to bypass are necessary
(that also contributed to my assumption that there will be more IOs on those
blkg's). Have you seen more IOs coming down the pipeline after offline? If
so, can you dump some backtraces and see where they're coming from?

Thanks.

-- 
tejun

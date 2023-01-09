Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC71662EF0
	for <lists+cgroups@lfdr.de>; Mon,  9 Jan 2023 19:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbjAIS0h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Jan 2023 13:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjAIS0T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Jan 2023 13:26:19 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5A8AE62;
        Mon,  9 Jan 2023 10:23:37 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 36so6459978pgp.10;
        Mon, 09 Jan 2023 10:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgVKC3NmcxxKrnQWmSerqqDaGhLOMoPMCbrmW5GVKVk=;
        b=qewQu0vk4Nwlo4LFhzKWR6EMnRJh/XhktdhcuuMLJzHXnLsWf8U7fgWVovAVzLQgLe
         DeAEVAeyCjNwGPETUlQL6Nb17w8G/1bsiS/0/qc7clbmBVPMWLaVQ9JljHwXzt5cJA2+
         aSxCPG8HvjEcZvwjL+wRu1fZKx1Qx/DpAB/9v4gjX+99NiJv/8/866g3KaKAM6DAehOY
         7TbHUhRsPDtNNqHcqjxNHyGFPqMQ6WIhMiuFxm0AjfzwupH8ibQAs/oPDTIPyoHYIMsx
         1GpJDL5vWZJu1nQq+wpHacVi3pRyjumovgtqe7jEPXeDvyWSmldn+4FUP6xZBBocggZx
         rWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgVKC3NmcxxKrnQWmSerqqDaGhLOMoPMCbrmW5GVKVk=;
        b=1kbkWecXl+EsNQfkkVYRjt6iDa6t4VpxEJUGAPPOHp3z29wUFuIrYR/hH4XbK8FhZ0
         JUibNrgrenh+djkNxp6Jv7hvGDeFuHm1U2RDGczaoBl6VLRZ66U60M5aky373NLZz8Yx
         i23No5we+DvUX/nJyGO4HJEz4UcTW9AS+WHhik5TRYB02GcsoMcpJ1tKbdhEmkA705+C
         fy66gPouTrpxcORD2kyGDXFcASYRPKO7amACJhZvDto4hfkeOaXFbpGDshdvIopRfbP7
         sM2x6C/6v1P9YKLds/bbFo82h/HRy2/G/B52pL/KxtZV9iBqS+GZoLxYR+G1i+xxxoZu
         mJwg==
X-Gm-Message-State: AFqh2kqpSqbwFjq6ZHbsWy72AifVNv/gj5JjtvBfGJG6KVRgZqMjpU8I
        L+UpmNCY1iWtIjcG8yCqTHM=
X-Google-Smtp-Source: AMrXdXvOjR1muOMTzKTpSNs8q23B3jzxSKkQCMOrD/PQtF3jc8DHE+U1ihL5Ojyfsr2lRaEQjCW/Mw==
X-Received: by 2002:a62:506:0:b0:56c:7216:fbc6 with SMTP id 6-20020a620506000000b0056c7216fbc6mr65035427pff.30.1673288616438;
        Mon, 09 Jan 2023 10:23:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79498000000b005821db4fd84sm6361045pfk.131.2023.01.09.10.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 10:23:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Jan 2023 08:23:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
Message-ID: <Y7xbpidpq7+DqJan@slm.duckdns.org>
References: <20221227125502.541931-1-yukuai1@huaweicloud.com>
 <20221227125502.541931-2-yukuai1@huaweicloud.com>
 <Y7XzUee5Bq+DoIC1@slm.duckdns.org>
 <c63ee2ad-23d5-3be0-c731-28494398b391@huaweicloud.com>
 <Y7cX0SJ0y6+EIY5Q@slm.duckdns.org>
 <7dcdaef3-65c1-8175-fea7-53076f39697f@huaweicloud.com>
 <Y7iCId3pnEnLqY8G@slm.duckdns.org>
 <875eb43e-202d-5b81-0bff-ef0434358d99@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875eb43e-202d-5b81-0bff-ef0434358d99@huaweicloud.com>
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

On Mon, Jan 09, 2023 at 09:32:46AM +0800, Yu Kuai wrote:
> >   59b57717fff8 ("blkcg: delay blkg destruction until after writeback has finished")
> >   d866dbf61787 ("blkcg: rename blkcg->cgwb_refcnt to ->online_pin and always use it")
> 
> These two commits are applied for three years, I don't check the details
> yet but they seem can't guarantee that no io will be handled by
> rq_qos_throttle() after pd_offline_fn(), because I just reproduced this
> in another problem:
> 
> f02be9002c48 ("block, bfq: fix null pointer dereference in bfq_bio_bfqg()")
> 
> User thread can issue async io, and io can be throttled by
> blk-throttle(not writeback), then user thread can exit and cgroup can be
> removed before such io is dispatched to rq_qos_throttle.

I see.

> > After the above two commits, ->pd_offline_fn() is called only after all
> > possible writebacks are complete, so it shouldn't allow mass escapes to
> > root. With writebacks out of the picture, it might be that there can be no
> > further IOs once ->pd_offline_fn() is called too as there can be no tasks
> > left in it and no dirty pages, but best to confirm that.
> > 
> > So, yeah, the original approach you took should work although I'm not sure
> > the patches that you added to make offline blkg to bypass are necessary
> > (that also contributed to my assumption that there will be more IOs on those
> > blkg's). Have you seen more IOs coming down the pipeline after offline? If
> > so, can you dump some backtraces and see where they're coming from?
> 
> Currently I'm sure such IOs can come from blk-throttle, and I'm not sure
> yet but I also suspect io_uring can do this.

Yeah, that's unfortunate. There are several options here:

1. Do what you originally suggested - bypass to root after offline. I feel
   uneasy about this. Both iolatency and throtl clear their configs on
   offline but that's punting to the parent. For iocost it'd be bypassing
   all controls, which can actually be exploited.

2. Make all possible IO issuers use blkcg_[un]pin_online() and shift the
   iocost shutdown to pd_offline_fn(). This likely is the most canonical
   solution given the current situation but it's kinda nasty to add another
   layer of refcnting all over the place.

3. Order blkg free so that parents are never freed before children. You did
   this by adding refcnts in iocost but shouldn't it be possible to simply
   shift blkg_put(blkg->parent) in __blkg_release() to blkg_free_workfn()?

#3 seems the most logical to me. What do you thinK?

Thanks.

-- 
tejun

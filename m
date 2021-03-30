Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D63734E975
	for <lists+cgroups@lfdr.de>; Tue, 30 Mar 2021 15:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhC3NnC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Mar 2021 09:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhC3Nmz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Mar 2021 09:42:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC7DC061762
        for <cgroups@vger.kernel.org>; Tue, 30 Mar 2021 06:42:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p19so8423783wmq.1
        for <cgroups@vger.kernel.org>; Tue, 30 Mar 2021 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pnUANKY68LFCHKnXAlNl92vZ5QNwZhc3rycWb9aJ4U4=;
        b=cXrleCcTe2edFKE7JXHrs9Bj1XROOQncYe9/RXuKuyYfg1oiY9hkloCupeUygrymIP
         9ayZSOUA/kzg9omudYLIbfliaSwzsF8t2WjsUk7aasxaQAZ65kiYcqVsJssvwnbqXWaQ
         7tP999kzGqM64anG+FHHGrYwPo3CD/MmoJSW67AsljQ3h4bpd7h5J0oHBBrJFcYhNPQZ
         jSvprN5HGew9kx/NPjUMKVuGbUtOweyWIunsFY/SwCVoa+64VGBhAnUWkD+o4ORO7eF3
         KDrvwGNAF2EaQH0lzuiBF6N51eP9jHBLGYuCYZ1yO4oXRNlIuT6R6Tj2RPOAmd0YGpIB
         8yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pnUANKY68LFCHKnXAlNl92vZ5QNwZhc3rycWb9aJ4U4=;
        b=kJ4vDJehQuImwx4j0j0tz/vrMZYNrKFyn8z8SxcT7S9JlDhAlktW4GgpDXKxS+BtFz
         N0qFzwwTjq/t63H8ECZSSaALI7YjBGekTLnwDeCg2tPAdy52YR64vT4eIu5TyLYB1zF2
         ZmL1g7yN4jBI1IAm2gUg3WVqplD74sk5M8EfuUOaAbKtR7zeKIHORz4w6dj4aknP5D/8
         9V+EIvPfhxs9IPWX9dyrXthG89gj0pI+jt5IDYpQacnZdifibinz9WzY2pgsNjj9CSwW
         WCA1BWwlqLZLCY3A86S/p5UTVjKc/ukASBFJGByb5Ql7RT9hthJu+cvkkeVEgdWe1jlu
         cuTw==
X-Gm-Message-State: AOAM533v2E7YboJI0vvIAvud7GE8BTi4UzgQmkjk0nBYoGTitIgSNL+1
        cHkAHvzUAFck9m1gwYJ/XL4Nvg==
X-Google-Smtp-Source: ABdhPJyEaNmHwXDqXeg3ddAYPI76jKgTBEKWlhppYOYHuQly+QNGJJ3PVIlHNTsLl1NMwgMgoe4Ywg==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr4234551wme.181.1617111762614;
        Tue, 30 Mar 2021 06:42:42 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u20sm36588716wru.6.2021.03.30.06.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:42:42 -0700 (PDT)
Date:   Tue, 30 Mar 2021 15:42:24 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YGMqwPnYjSfV+Cbr@myrica>
References: <20210319112221.5123b984@jacob-builder>
 <YFhiMLR35WWMW/Hu@myrica>
 <20210324100246.4e6b8aa1@jacob-builder>
 <20210324170338.GM2356281@nvidia.com>
 <20210324151230.466fd47a@jacob-builder>
 <YFxkNEz3THJKzW0b@myrica>
 <20210325100236.17241a1c@jacob-builder>
 <20210325171645.GF2356281@nvidia.com>
 <YF2WEmfXsXKCkCDb@myrica>
 <20210330130755.GN2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330130755.GN2356281@nvidia.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 30, 2021 at 10:07:55AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 26, 2021 at 09:06:42AM +0100, Jean-Philippe Brucker wrote:
> 
> > It's not inconceivable to have a control queue doing DMA tagged with
> > PASID. The devices I know either use untagged DMA, or have a choice to use
> > a PASID.
> 
> I don't think we should encourage that. A PASID and all the related is
> so expensive compared to just doing normal untagged kernel DMA.

How is it expensive?  Low number of PASIDs, or slowing down DMA
transactions?  PASIDs aren't a scarce resource on Arm systems, they have
almost 1M unused PASIDs per VM.

Thanks,
Jean

> I assume HW has these features because virtualization use cases might
> use them, eg by using mdev to assign a command queue - then it would
> need be be contained by a PASID.
> 
> Jason

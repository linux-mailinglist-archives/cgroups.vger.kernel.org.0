Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4FD613EDE
	for <lists+cgroups@lfdr.de>; Mon, 31 Oct 2022 21:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJaUUZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Oct 2022 16:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJaUUX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Oct 2022 16:20:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C489310546;
        Mon, 31 Oct 2022 13:20:20 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id g24so11744188plq.3;
        Mon, 31 Oct 2022 13:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLMtcHanAdWy+MQrFvmEE8PQyqd5prgM22zccOtSAJA=;
        b=iekiGuGz6jaaXaKT/D4NgTACCfKlHeHsUtTT9YZFSy65EUDIQrjjLW4SL+7L8zxHhc
         r5V6hZRyAhmCLVmXvn2KAQOsR/Am4N5n8hBQBUd+xJPLLDOaAsTjW36nRkvZC+ZKvYcN
         Ml1f8mrj3j9+MlAkdBtrACCVI6yIzd+TY8c8kFEgypNmQKqMwO9Gn0llxDUDMGhWfgvF
         WBX7SmQQ6/lvmlLlegW0Kz1bB4wKqS+eatPh+FK9CfJyihcmFl4Yah/MJgiR8QMxyZPB
         KhL6qleU+MHUJLAtN/NUUYRFr9h/1hmHvCi69+OdDhSIFlK6MxccICPf20AxMvkWw6A6
         rmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLMtcHanAdWy+MQrFvmEE8PQyqd5prgM22zccOtSAJA=;
        b=EEG45rzp4r9RRTbJAH+tP9re3Qzr2fEjH+B0pEQjJBjZMb9j2mIoRqByPYKi92ilTL
         pUJAZ37bxpsvvAv3QDvOxGcqjqgf8GSqwtLVmLgOAb0PR2aJVdaQEDuyZu6ZEBLMnhQ4
         8i0xHEMVGiFQU4I+T0EUK4/0iLxUgAD2hlnFiyHEW5vILl+o33oDdM8jkviQ/+foNfvN
         ucy7tsCOLW7y8FAiS65qmY7wIk4IoCYHWUxfI1tOhQcj+vX2QYe0OjAM50mP22wt8QNb
         2+rkHqqO9QicSVOvchLSYIp7eB4VS3mL6wHCjAWpGktbQmpbhnII+OarN2v9jmtz8jwt
         4Edg==
X-Gm-Message-State: ACrzQf3CkcY2P+lIFwHzBfcSVIGpTdYrw1niLzlxPrGQkwiJ4Cx36ZF4
        AWvR0uNutlXWk8sZ0a4BHJY=
X-Google-Smtp-Source: AMsMyM6lW4iVJ+i+7dePQXuPJa6aPsquojLbxIf2GDt2M4OqYL6F/fSyER0AoP7LwoZJMsjKy6N+jg==
X-Received: by 2002:a17:902:da8e:b0:186:9869:adfa with SMTP id j14-20020a170902da8e00b001869869adfamr16325861plx.57.1667247620081;
        Mon, 31 Oct 2022 13:20:20 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ba13])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0017300ec80b0sm4785022plk.308.2022.10.31.13.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:20:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Oct 2022 10:20:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [RFC 00/17] DRM scheduling cgroup controller
Message-ID: <Y2AuAtSmS8X7a1qC@slm.duckdns.org>
References: <20221019173254.3361334-1-tvrtko.ursulin@linux.intel.com>
 <Y1BFziiJdBzsIJWH@slm.duckdns.org>
 <908129fa-3ddc-0f62-18df-e318dc760955@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <908129fa-3ddc-0f62-18df-e318dc760955@linux.intel.com>
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

On Thu, Oct 27, 2022 at 03:32:00PM +0100, Tvrtko Ursulin wrote:
> Looking at what's available in cgroups world now, I have spotted the
> blkio.prio.class control. For my current use case (lower GPU scheduling of
> background/unfocused windows) that would also work. Even if starting with
> just two possible values - 'no-change' and 'idle' (to follow the IO
> controller naming).

I wouldn't follow that example. That's only meaningful within the context of
bfq and it probabaly shouldn't have been merged in the first place.

> How would you view that as a proposal? It would be a bit tougher "sell" to
> the DRM community, perhaps, given that many drivers do have scheduling
> priority, but the concept of scheduling class is not really there.
> Nevertheless a concept of normal-vs-background could be plausible in my
> mind. It could be easily implemented by using the priority controls
> available in many drivers.

I don't feel great about that.

* The semantics aren't clearly defined. While not immediately obvious in the
  interface, the task nice levels have definite mappings to weight values
  and thus clear meanings. I don't think it's a good idea to leave the
  interface semantics open to interpretation.

* Maybe GPUs are better but my experience with optional hardware features in
  the storage world has been that vendors diverge wildly and unexpectedly to
  the point many features are mostly useless. There are fewer GPU vendors
  and more software effort behind each, so maybe the situation is better but
  I think it'd be helpul to keep some skepticism.

* Even when per-vendor or per-driver features are consistent enough to be
  useful, they often aren't thought through enough to be truly useful. e.g.
  nvme has priority features but they aren't really that useful because they
  can't do much without congestion control on the issuer side and once you
  have congestion control on the issuer side which is usually a lot more
  complex (e.g. dealing with work-conserving hierarchical weight
  distributions, priority inversions and so on), you can achieve most of
  what you need in terms of resource control from the issuer side anyway.

So, I'd much prefer to have a fuller solution on the kernel side which
integrates per-vendor/driver features where they make sense.

> > >    drm.budget_supported
> > > 	One of:
> > > 	 1) 'yes' - when all DRM clients in the group support the functionality.
> > > 	 2) 'no' - when at least one of the DRM clients does not support the
> > > 		   functionality.
> > > 	 3) 'n/a' - when there are no DRM clients in the group.
> > 
> > Yeah, I'm not sure about this. This isn't a per-cgroup property to begin
> > with and I'm not sure 'no' meaning at least one device not supporting is
> > intuitive. The distinction between 'no' and 'n/a' is kinda weird too. Please
> > drop this.
> 
> The idea actually is for this to be per-cgroup and potentially change
> dynamically. It implements the concept of "observability", how I have,
> perhaps clumsily, named it.
> 
> This is because we can have a mix of DRM file descriptors in a cgroup, not
> all of which support the proposed functionality. So I wanted to have
> something by which the administrator can observe the status of the group.
> 
> For instance seeing some clients do not support the feature could be signal
> that things have been misconfigured, or that appeal needs to be made for
> driver X to start supporting the feature. Seeing a "no" there in other words
> is a signal that budgeting may not really work as expected and needs to be
> investigated.

I still don't see how this is per-cgroup given that it's indicating whether
the driver supports some feature. Also, the eventual goal would be
supporting the same control mechanisms across most (if not all) GPUs, right?

> > Rather than doing it hierarchically on the spot, it's usually a lot cheaper
> > and easier to calculate the flattened hierarchical weight per leaf cgroup
> > and divide the bandwidth according to the eventual portions. For an example,
> > please take a look at block/blk-iocost.c.
> 
> This seems exactly what I had in mind (but haven't implemented it yet). So
> in this RFC I have budget splitting per group where each tree level adds up
> to "100%" and the thing which I have not implemented is "borrowing" or
> yielding (how blk-iocost.c calls it, or donating) unused budgets to
> siblings.
> 
> I am very happy to hear my idea is the right one and someone already
> implemented it. Thanks for this pointer!

The budget donation thing in iocost is necessary only because it wants to
make the hot path local to the cgroup because io control has to support very
high decision rate. For time-slicing GPU, it's likely that following the
current hierarchical weight on the spot is enough.

Thanks.

-- 
tejun

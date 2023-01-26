Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501DD67D281
	for <lists+cgroups@lfdr.de>; Thu, 26 Jan 2023 18:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjAZREc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Jan 2023 12:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjAZREb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Jan 2023 12:04:31 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5DF7EE5;
        Thu, 26 Jan 2023 09:04:11 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id d10so1443298pgm.13;
        Thu, 26 Jan 2023 09:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2N5z7vm8wkipXchVo2DX0B/FIOfj1plPYH1BFui3jhE=;
        b=mT9+Y3uCrH/JgDR2rhlOog9/pF0Z2rxmXzu5MO7j8fBMR2bN/n7cXByNjpiUUFc1W1
         RaH0re/D97GeOb/sT4rwsrokz5YzDD9hsZ7BFTiV5qiXH4ar/yWa44IV3MUhMWaKO9XB
         zZZnOEPSzPTEK24UoQVOtdr/6MgDHTK6wQFKG1pwV/ZDiyBiQlUxjLoYsJ8Xw69DKkid
         ZjEq7NBwnlX5WnA9fSdQVXmdjrqXmab4/ksW01BSZWaczVBkAZTTeitU/kChCxObBz3T
         BSdl3jxXAtOoL4WoLqPjve1xQ+aPDBbn1ePQFmrJAFbI8mo37z/GXSdb4FtKAOHiUFc3
         lXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2N5z7vm8wkipXchVo2DX0B/FIOfj1plPYH1BFui3jhE=;
        b=dmBWYdq9cg+5jOoSiN2qJJorW8zGnGBelhCtT1sb57htFG4U+UGkkSXFLwB5GhkSwg
         3E4l9NjsQzm2hmv4JlUsKPunxB4ZuQhLmRdUVzB75LZrVM1D4ArQi9LOl1TzRF3weUIy
         hdJmVlanpfT3fSK74XTX6LHh+nOySnhrP9qZJEa/g1ATcNhGLV6ZPTuUzNrjUbnszoFh
         UApNO9pch2NA6Zya5o7+i6gvnzn+zttVBKDe+CKZ7arji7Ur0t17A6OtHQqDvwVg0t9q
         S5520TwL9LGww+4y+Krf8sXyNbZNbMTD+T3CeVlIjYmgxnbf4VtHIZ2LjrDg7flWlWUA
         1VAw==
X-Gm-Message-State: AO0yUKWbUQUmVkpD2cBE2cN0OGPIQLe4J73IgUv0ALMZ5SPL17+0dpfH
        FqIft+w0b5oF6aYRBV5iWj8=
X-Google-Smtp-Source: AK7set+OW19QX5gTvgZenLJimvmTD3xOJbHM7+LP8ZqA5b+N+DbMNuh7Ccw2hBkQZN9Qq61TVLNzYw==
X-Received: by 2002:aa7:9564:0:b0:590:72de:db46 with SMTP id x4-20020aa79564000000b0059072dedb46mr4171243pfq.13.1674752650779;
        Thu, 26 Jan 2023 09:04:10 -0800 (PST)
Received: from localhost ([2600:380:777f:b8fa:53b6:287e:1c75:589c])
        by smtp.gmail.com with ESMTPSA id cw19-20020a056a00451300b0058e23ca0de3sm1081441pfb.82.2023.01.26.09.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:04:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 26 Jan 2023 07:04:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "T . J . Mercier" <tjmercier@google.com>, Kenny.Ho@amd.com,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: Re: [RFC v3 00/12] DRM scheduling cgroup controller
Message-ID: <Y9KyiCPYj2Mzym3Z@slm.duckdns.org>
References: <20230112165609.1083270-1-tvrtko.ursulin@linux.intel.com>
 <20230123154239.GA24348@blackbody.suse.cz>
 <371f3ce5-3468-b91d-d688-7e89499ff347@linux.intel.com>
 <20230126130050.GA22442@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230126130050.GA22442@blackbody.suse.cz>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jan 26, 2023 at 02:00:50PM +0100, Michal Koutný wrote:
> On Wed, Jan 25, 2023 at 06:11:35PM +0000, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
> > I don't immediately see how you envisage the half-userspace implementation
> > would look like in terms of what functionality/new APIs would be provided by
> > the kernel?
> 
> Output:
> 	drm.stat (with consumed time(s))
> 
> Input:
> 	drm.throttle (alternatives)
> 	- a) writing 0,1 (in rough analogy to your proposed
> 	     notifications)
> 	- b) writing duration (in loose analogy to memory.reclaim)
> 	     - for how long GPU work should be backed off
> 
> An userspace agent sitting between these two and it'd do the measurement
> and calculation depending on given policies (weighting, throttling) and
> apply respective controls.
> 
> (In resemblance of e.g. https://denji.github.io/cpulimit/)

Yeah, things like this can be done from userspace but if we're gonna build
the infrastructure to allow that in gpu drivers and so on, I don't see why
we wouldn't add a generic in-kernel control layer if we can implement a
proper weight based control. We can of course also expose .max style
interface to allow userspace to do whatever they wanna do with it.

> > Problem there is to find a suitable point to charge at. If for a moment we
> > limit the discussion to i915, out of the box we could having charging
> > happening at several thousand times per second to effectively never. This is
> > to illustrate the GPU context execution dynamics which range from many small
> > packets of work to multi-minute, or longer. For the latter to be accounted
> > for we'd still need some periodic scanning, which would then perhaps go per
> > driver. For the former we'd have thousands of needless updates per second.
> > 
> > Hence my thinking was to pay both the cost of accounting and collecting the
> > usage data once per actionable event, where the latter is controlled by some
> > reasonable scanning period/frequency.
> > 
> > In addition to that, a few DRM drivers already support GPU usage querying
> > via fdinfo, so that being externally triggered, it is next to trivial to
> > wire all those DRM drivers into such common DRM cgroup controller framework.
> > All that every driver needs to implement on top is the "over budget"
> > callback.
> 
> I'd also like show comparison with CPU accounting and controller.
> There is tick-based (~sampling) measurement of various components of CPU
> time (task_group_account_field()). But the actual schedulling (weights)
> or throttling is based on precise accounting (update_curr()).
> 
> So, if the goal is to have precise and guaranteed limits, it shouldn't
> (cannot) be based on sampling. OTOH, if it must be sampling based due to
> variability of the device landscape, it could be advisory mechanism with
> the userspace component.

As for the specific control mechanism, yeah, charge based interface would be
more conventional and my suspicion is that transposing the current
implementation that way likely isn't too difficult. It just pushes "am I
over the limit?" decisions to the specific drivers with the core layer
telling them how much under/over budget they are. I'm curious what other gpu
driver folks think about the current RFC tho. Is at least AMD on board with
the approach?

Thanks.

-- 
tejun

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE31A7A93
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 14:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440033AbgDNMUk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 08:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440014AbgDNMUT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 08:20:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68965C061A0C
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 05:20:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o81so7165310wmo.2
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AVWsXI3MqWUjHSFF7fJc9dwzNvhf7xe+RbgEyfrAzNQ=;
        b=C5ErIHkCVZ6bwX/7a4Q98OMFyyzYOVUtlEGm/S86pHsNjUxpLifmMl0gwrR9FVv/eg
         DBy+1TWPtHW1UjmLp8i/0VBZqa61Ni68+/dmh6VPBNHlS0sr9ckMI+AXPa6Orp5wBgNR
         iuLNwnQ+2b6+dhu+W1zMJqdXAMgvSKHGlrWzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AVWsXI3MqWUjHSFF7fJc9dwzNvhf7xe+RbgEyfrAzNQ=;
        b=VWRN/Ff+chrk9YB2GjplQxU+oRmIicGzn0D65/8jPt/b1lLgK9/xZiJWap4H9+3UE5
         9kNB6SjzeJrMVrdxus9+YyWe5rE5aoxz74HoZPtXZRT9v8p3l5LeVHi9b80JZfngva91
         Y40102XWt5OFcoiSHkFwhH3shLvzsDKS5ryROUIX6Ycb51kyKJoY+qCXp7C6LxxI8sqZ
         QG0wGI7ZtF3+Xd0y3IB0dkWPyP+ZaZf5/tuwYi41rs8Sw9WCgzOZR225sAXGIpUHMrg4
         IpPe6PErG2Ac330N9AOhYg8WqxBQV/3R2h6Z0loAJC2hcrxfPVHezrSj4bkBXzzXs7rz
         fdUg==
X-Gm-Message-State: AGi0PuY318C2tg1IiJgAoXaoNzI4KhZozmvnb4+Z+uwGAkp429bvmNvq
        vF1urTpfVJwvYmXWMymSsqCVZA==
X-Google-Smtp-Source: APiQypLZMCXaWWcTpMokkYNn95QhGP8sokJ6ulB8VlThRzbMX0X+dbheLMI86kMWkSLw/6e6Ru2zvQ==
X-Received: by 2002:a1c:3985:: with SMTP id g127mr23823629wma.102.1586866818129;
        Tue, 14 Apr 2020 05:20:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w11sm18000879wmi.32.2020.04.14.05.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 05:20:17 -0700 (PDT)
Date:   Tue, 14 Apr 2020 14:20:15 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tejun Heo <tj@kernel.org>
Cc:     Kenny Ho <y2kenny@gmail.com>, Kenny Ho <Kenny.Ho@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>, jsparks@cray.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        cgroups@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
Message-ID: <20200414122015.GR3456981@phenom.ffwll.local>
References: <20200226190152.16131-1-Kenny.Ho@amd.com>
 <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org>
 <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
 <20200413191136.GI60335@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413191136.GI60335@mtj.duckdns.org>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 13, 2020 at 03:11:36PM -0400, Tejun Heo wrote:
> Hello, Kenny.
> 
> On Tue, Mar 24, 2020 at 02:49:27PM -0400, Kenny Ho wrote:
> > Can you elaborate more on what are the missing pieces?
> 
> Sorry about the long delay, but I think we've been going in circles for quite
> a while now. Let's try to make it really simple as the first step. How about
> something like the following?
> 
> * gpu.weight (should it be gpu.compute.weight? idk) - A single number
>   per-device weight similar to io.weight, which distributes computation
>   resources in work-conserving way.
> 
> * gpu.memory.high - A single number per-device on-device memory limit.
> 
> The above two, if works well, should already be plenty useful. And my guess is
> that getting the above working well will be plenty challenging already even
> though it's already excluding work-conserving memory distribution. So, let's
> please do that as the first step and see what more would be needed from there.

This agrees with my understanding of the consensus here and what's
reasonable possible across different gpus. And in case this isn't clear:
This is very much me talking with my drm co-maintainer hat on, not with a
gpu vendor hat on (since that's implied somewhere further down the
discussion). My understanding from talking with a few other folks is that
the cpumask-style CU-weight thing is not something any other gpu can
reasonably support (and we have about 6+ of those in-tree), whereas some
work-preserving computation resource thing should be doable for anyone
with a scheduler. +/- more or less the same issues as io devices, there
might be quite bit latencies involved from going from one client to the
other because gpu pipelines are deed and pre-emption for gpus rather slow.
And ofc not all gpu "requests" use equal amounts of resources (different
engines and stuff just to begin with), same way not all io requests are
made equal. Plus since we do have a shared scheduler used by at least most
drivers, this shouldn't be too hard to get done somewhat consistently
across drivers

tldr; Acked by me.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

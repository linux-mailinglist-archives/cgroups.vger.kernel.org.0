Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0301A6DA0
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 22:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbgDMUyl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 16:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388526AbgDMUyj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 16:54:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C9AC0A3BDC
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 13:54:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w70so6784441qkb.7
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2020 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CmUANt0t5HRisX+1yPc7U3xIxP+RuSCBBQhcshkOJkc=;
        b=LgJ7itCwDGKAQT06oAw2BcDstgGiPHC+qPyVPTx9ybSe4VOwbRJeEOlzNb6BvxDnOS
         2XgnpPZo/PeMNgs33VZjEjjFJrCjGMLq/LDmBeEoVsKRa/gYhqhVzdX6VpfV5c1WsdDb
         Aj/WTeawW/z2ZzlbQH+vu4WT9XoEiCbO8uKImj8xGcjacv4TtRF4ScJAKY19KIYAgdVo
         PzASu8J/wr4PPFlUFA8LHZ5GbuMxFN4sTCClw8xS9AlN9OrB6/B2YVsSXV7ZmardGUYh
         klTTzpuooyIxMkIHHmp5P1OpDDxjTJ/JG4/ujOLdOK9dYQLDp7enbLCZJhkbgUDfWnOG
         ENYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CmUANt0t5HRisX+1yPc7U3xIxP+RuSCBBQhcshkOJkc=;
        b=ZaIztvckq3K8HQb3tIvsolMBtMN60KHxEaD+q3LRR1PsxHjucLjUU/DCsDrdUYoFM8
         2ktZGFJw9Bz2LIrK4RBcGbFBrI2zRnNE0m+TL4cYnh5dpHhyfgmRb1Ys9u7gnvQPdD3z
         cVXxT3rv1Qhmkaq7R1WdbCREH9cd0iKynh3IPp5PcoiVGeWMvolibwUr8ylhRfAXle42
         F6do5m+dK/COum36trypEsGnlpiSn9wok+2fADQ8DwZxb/qU2oVmmzP8IJrSSocEho/0
         ZYX9gPp4i58I0JnTPSyB1xC0ydxmBgkuNT9qVQCJ18N3WU+oDRbZ2xcIRiAxiZJlQdez
         hSqQ==
X-Gm-Message-State: AGi0PuYHjL7lTRkwCdcw0t0FEEhIwuVnvfH83FPtq3qUxRGxsecUkmf0
        DrtYxpJUjucFuqNLHyLiAIM=
X-Google-Smtp-Source: APiQypIzzvZjRh+3uEsHBjkSiUmc3sI7rqlM0eWsVdJZctdk3taqOja42xDBh77J66TwtQR7pssH5Q==
X-Received: by 2002:a37:9145:: with SMTP id t66mr17886337qkd.314.1586811278746;
        Mon, 13 Apr 2020 13:54:38 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id d23sm8987665qtj.9.2020.04.13.13.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 13:54:37 -0700 (PDT)
Date:   Mon, 13 Apr 2020 16:54:36 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
Message-ID: <20200413205436.GM60335@mtj.duckdns.org>
References: <20200226190152.16131-1-Kenny.Ho@amd.com>
 <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org>
 <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
 <20200413191136.GI60335@mtj.duckdns.org>
 <CAOWid-dM=38faGOF9=-Pq=sxssaL+gm2umctyGVQWVx2etShyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-dM=38faGOF9=-Pq=sxssaL+gm2umctyGVQWVx2etShyQ@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Apr 13, 2020 at 04:17:14PM -0400, Kenny Ho wrote:
> Perhaps we can even narrow things down to just
> gpu.weight/gpu.compute.weight as a start?  In this aspect, is the key

That sounds great to me.

> objection to the current implementation of gpu.compute.weight the
> work-conserving bit?  This work-conserving requirement is probably
> what I have missed for the last two years (and hence going in circle.)
> 
> If this is the case, can you clarify/confirm the followings?
> 
> 1) Is resource scheduling goal of cgroup purely for the purpose of
> throughput?  (at the expense of other scheduling goals such as
> latency.)

It's not; however, work-conserving mechanisms are the easiest to use (cuz you
don't lose anything) while usually challenging to implement. It tends to
clarify how control mechanisms should be structured - even what resources are.

> 2) If 1) is true, under what circumstances will the "Allocations"
> resource distribution model (as defined in the cgroup-v2) be
> acceptable?

Allocations definitely are acceptable and it's not a pre-requisite to have
work-conserving control first either. Here, given the lack of consensus in
terms of what even constitute resource units, I don't think it'd be a good
idea to commit to the proposed interface and believe it'd be beneficial to
work on interface-wise simpler work conserving controls.

> 3) If 1) is true, are things like cpuset from cgroup v1 no longer
> acceptable going forward?

Again, they're acceptable.

> To be clear, while some have framed this (time sharing vs spatial
> sharing) as a partisan issue, it is in fact a technical one.  I have
> implemented the gpu cgroup support this way because we have a class of
> users that value low latency/low jitter/predictability/synchronicity.
> For example, they would like 4 tasks to share a GPU and they would
> like the tasks to start and finish at the same time.
> 
> What is the rationale behind picking the Weight model over Allocations
> as the first acceptable implementation?  Can't we have both
> work-conserving and non-work-conserving ways of distributing GPU
> resources?  If we can, why not allow non-work-conserving
> implementation first, especially when we have users asking for such
> functionality?

I hope the rationales are clear now. What I'm objecting is inclusion of
premature interface, which is a lot easier and more tempting to do for
hardware-specific limits and the proposals up until now have been showing
ample signs of that. I don't think my position has changed much since the
beginning - do the difficult-to-implement but easy-to-use weights first and
then you and everyone would have a better idea of what hard-limit or
allocation interfaces and mechanisms should look like, or even whether they're
needed.

Thanks.

-- 
tejun

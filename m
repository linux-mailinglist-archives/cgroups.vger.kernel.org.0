Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B000A72C5
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2019 20:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfICSuR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Sep 2019 14:50:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35656 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfICSuR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Sep 2019 14:50:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id d26so9436067qkk.2
        for <cgroups@vger.kernel.org>; Tue, 03 Sep 2019 11:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BDfBshMUzfkMYDP3YH1WRh6hiP2fR1TX24dTioUhIbQ=;
        b=NTSOQalIWGHMGNYP1d6ExwLAx6waOaiYDBcu+w1BHywazlCdIQhI0AlWRcLAb6lUY8
         W+kJWm2FvgFeCuzwaChDW69mva1GopmVd/jb/S65qOqf9t6BGHejfki1udqvY8AXLC7t
         a9D+Wad3HFd2GytQiMK+SLv3joJoF4F1T2Kmn97gv//vKLs0HMCF12FEE7UArVD5to+X
         8yWEGsmpcVGudEZvAiDtIT3OmnPV1ACvpGxI/b7phHe6icTpIgQxSKUC6Ia0PTr+eeIG
         emZNWocZOvntlJOiyfY3anzcUDsDEOdDPx5rj4MB7RWFUYe59BG+pJ9ulroB5diOXyHn
         t6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BDfBshMUzfkMYDP3YH1WRh6hiP2fR1TX24dTioUhIbQ=;
        b=Fr9vj6p1od8wkE3YIhtIa1+KNxrMqfGer0b6nSjJFbnrdofuJp09Y0ty/FqCaTzvko
         gVmySgcGJM5in46s1U3jlyRHdpu5D1nnEG+FxYdnn6PdYt5Hsfwn5a9Tzjb/ill2jIQo
         +7oli7mwjVLoJx0ie/OlEj2qZJHsuqsr/KTMcppZY5cWxj0dYGb4YcAhw7rA+Vc9ra+h
         I1OXBQ65eSskfe4voLUtDim9JJ9E3oNzI6ntx8leN8U6BUv4WIacUfuqisl9q2hxdFPN
         SDw8CBjqNRQr8zmbwO5z8rTR+KzBjIMeep3Wvn53NHuUVWFJJobgcJheqAGSe4Fo1jgp
         GQXQ==
X-Gm-Message-State: APjAAAUtcZCfHEl9JytGhK+SGtEvTM6qa7i+1w7n+zKkYSNCaVg16sQl
        Lb662rxTrS7H2sIl0T8EzSU=
X-Google-Smtp-Source: APXvYqzGfq/TdcKTRHxQF8pThh2LVU84/6JBMpDTx3YojkrUVzDJuWf5SwH5C2Mz7xoaMt6ezZ9P7g==
X-Received: by 2002:a37:4dc5:: with SMTP id a188mr37144637qkb.206.1567536616471;
        Tue, 03 Sep 2019 11:50:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:33b1])
        by smtp.gmail.com with ESMTPSA id z200sm5004754qkb.5.2019.09.03.11.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 11:50:15 -0700 (PDT)
Date:   Tue, 3 Sep 2019 11:50:13 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, y2kenny@gmail.com,
        cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [PATCH RFC v4 00/16] new cgroup controller for gpu/drm subsystem
Message-ID: <20190903185013.GI2263813@devbig004.ftw2.facebook.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190831042857.GD2263813@devbig004.ftw2.facebook.com>
 <20190903075550.GJ2112@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903075550.GJ2112@phenom.ffwll.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Daniel.

On Tue, Sep 03, 2019 at 09:55:50AM +0200, Daniel Vetter wrote:
> > * While breaking up and applying control to different types of
> >   internal objects may seem attractive to folks who work day in and
> >   day out with the subsystem, they aren't all that useful to users and
> >   the siloed controls are likely to make the whole mechanism a lot
> >   less useful.  We had the same problem with cgroup1 memcg - putting
> >   control of different uses of memory under separate knobs.  It made
> >   the whole thing pretty useless.  e.g. if you constrain all knobs
> >   tight enough to control the overall usage, overall utilization
> >   suffers, but if you don't, you really don't have control over actual
> >   usage.  For memcg, what has to be allocated and controlled is
> >   physical memory, no matter how they're used.  It's not like you can
> >   go buy more "socket" memory.  At least from the looks of it, I'm
> >   afraid gpu controller is repeating the same mistakes.
> 
> We do have quite a pile of different memories and ranges, so I don't
> thinkt we're doing the same mistake here. But it is maybe a bit too

I see.  One thing which caught my eyes was the system memory control.
Shouldn't that be controlled by memcg?  Is there something special
about system memory used by gpus?

> complicated, and exposes stuff that most users really don't care about.

Could be from me not knowing much about gpus but definitely looks too
complex to me.  I don't see how users would be able to alloate, vram,
system memory and GART with reasonable accuracy.  memcg on cgroup2
deals with just single number and that's already plenty challenging.

Thanks.

-- 
tejun

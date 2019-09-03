Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B09A5A73FB
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2019 21:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfICTsf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Sep 2019 15:48:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42877 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfICTsf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Sep 2019 15:48:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id o6so13793880oic.9
        for <cgroups@vger.kernel.org>; Tue, 03 Sep 2019 12:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0JqSY6FS+qoUeBELxlm0J6fJGbIPXpQfn6FWcb9lZU=;
        b=bLw2k2BWAGCYY5m1Dk5HLhU03BbDWM0aw2NM6kuXczyZEnXR1soZFS8Si4tYUke3h3
         CkoM6/UH5kO8NSk0rD3aePqKAFHBgSanrwjpmPgLXhJXTDZwUGxmpIDNtSOxITwpDKUY
         okKF+CoYqyQfOgu29h9bmpalMhVfCBOuaDk1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0JqSY6FS+qoUeBELxlm0J6fJGbIPXpQfn6FWcb9lZU=;
        b=TZ3PZU0bao0hpYfd+1DBgwqQG/GS+0OUKRBLhq0YGgfWuOlQlF+fDRCG4GhHgGsn2o
         D+G0g3wuWJNndKHm0b6OsYh+x1CJaSd2T5wIljumhK1K4E67e+n0K+3JbhE7SdK4LxEK
         ofoeDIcAKnsFMKizUJdfYk2wH+1PBtTnry54EXKe5hnoWaXJqGYIoBw7+XOIDvx5oAux
         DJuvbPPOrifdKUplI7KH9InTqzw2B9qqVhMBXnt1FQL2Xk7SLQTbcHqVqw4QUSXFyIny
         ka3P+iEX2o3+1Df6edqE91iIovSoHQ/vISFcdfFrH234nHI/YYJOCNgditXrK8lgf3yS
         5h9w==
X-Gm-Message-State: APjAAAWpeV780ZwFu1DD2d6SltLF9Biob4Lri67UY8yseDzoSwVzCYHa
        QsCPad2mm78fTOGWoVUh36Kv42ldJ66K7XckDUb6xQ==
X-Google-Smtp-Source: APXvYqzQIBRqGioPw9HMFuGJ4+7bDsXbRQOgTcZa/5i0aOH4BImk1tyr3mmO48j5l9mlF8ndWLTB8F1fPH0/vje2FnA=
X-Received: by 2002:aca:e182:: with SMTP id y124mr734117oig.132.1567540114369;
 Tue, 03 Sep 2019 12:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190831042857.GD2263813@devbig004.ftw2.facebook.com>
 <20190903075550.GJ2112@phenom.ffwll.local> <20190903185013.GI2263813@devbig004.ftw2.facebook.com>
In-Reply-To: <20190903185013.GI2263813@devbig004.ftw2.facebook.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 3 Sep 2019 21:48:22 +0200
Message-ID: <CAKMK7uE5Bj-3cJH895iqnLpwUV+GBDM1Y=n4Z4A3xervMdJKXg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 00/16] new cgroup controller for gpu/drm subsystem
To:     Tejun Heo <tj@kernel.org>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, Kenny Ho <y2kenny@gmail.com>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 3, 2019 at 8:50 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Daniel.
>
> On Tue, Sep 03, 2019 at 09:55:50AM +0200, Daniel Vetter wrote:
> > > * While breaking up and applying control to different types of
> > >   internal objects may seem attractive to folks who work day in and
> > >   day out with the subsystem, they aren't all that useful to users and
> > >   the siloed controls are likely to make the whole mechanism a lot
> > >   less useful.  We had the same problem with cgroup1 memcg - putting
> > >   control of different uses of memory under separate knobs.  It made
> > >   the whole thing pretty useless.  e.g. if you constrain all knobs
> > >   tight enough to control the overall usage, overall utilization
> > >   suffers, but if you don't, you really don't have control over actual
> > >   usage.  For memcg, what has to be allocated and controlled is
> > >   physical memory, no matter how they're used.  It's not like you can
> > >   go buy more "socket" memory.  At least from the looks of it, I'm
> > >   afraid gpu controller is repeating the same mistakes.
> >
> > We do have quite a pile of different memories and ranges, so I don't
> > thinkt we're doing the same mistake here. But it is maybe a bit too
>
> I see.  One thing which caught my eyes was the system memory control.
> Shouldn't that be controlled by memcg?  Is there something special
> about system memory used by gpus?

I think system memory separate from vram makes sense. For one, vram is
like 10x+ faster than system memory, so we definitely want to have
good control on that. But maybe we only want one vram bucket overall
for the entire system?

The trouble with system memory is that gpu tasks pin that memory to
prep execution. There's two solutions:
- i915 has a shrinker. Lots (and I really mean lots) of pain with
direct reclaim recursion, which often means we can't free memory, and
we're angering the oom killer a lot. Plus it introduces real bad
latency spikes everywhere (gpu workloads are occasionally really slow,
think "worse than pageout to spinning rust" to get memory freed).
- ttm just has a global limit, set to 50% of system memory.

I do think a global system memory limit to tame the shrinker, without
the ttm approach of possible just wasting half your memory, could be
useful.

> > complicated, and exposes stuff that most users really don't care about.
>
> Could be from me not knowing much about gpus but definitely looks too
> complex to me.  I don't see how users would be able to alloate, vram,
> system memory and GART with reasonable accuracy.  memcg on cgroup2
> deals with just single number and that's already plenty challenging.

Yeah, especially wrt GART and some of the other more specialized
things I don't think there's any modern gpu were you can actually run
out of that stuff. At least not before you run out of every other kind
of memory (GART is just a remapping table to make system memory
visible to the gpu).

I'm also not sure of the bw limits, given all the fun we have on the
block io cgroups side. Aside from that the current bw limit only
controls the bw the kernel uses, userspace can submit unlimited
amounts of copying commands that use the same pcie links directly to
the gpu, bypassing this cg knob. Also, controlling execution time for
gpus is very tricky, since they work a lot more like a block io device
or maybe a network controller with packet scheduling, than a cpu.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

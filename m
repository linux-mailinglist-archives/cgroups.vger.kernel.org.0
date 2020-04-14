Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FCC1A7E76
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 15:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502709AbgDNNOo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 09:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502701AbgDNNOk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 09:14:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF322C061A0F
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 06:14:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so7354559wrg.11
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ll4eqAKYtjTVgiWa+EM/tj8opR8soYnFbaqkSa8MX0w=;
        b=isQPS0YRieB7ch7fx9vRbFH6vVJ4/QFAfFtOxs7dl7WJwGeHCeTQS+qrGd9s7WRif5
         JqpVOBi2Cqe2E6ez62qE4/a7Sji/QthpWmK44OsPX7WYNXpcdiI2oOhmjb+4yRlXO5QK
         l23pyo3SDKhsQmdSNfmOZFuVUtenQdOdPK50FCKUU5z8N82ZFzdmWe+gVIcmuCw0h3Zn
         ArG3qdgBx2OhGRZcmg9uBy/DC+NSzJXr4coBZOznjpbpcYXf5kvVjA5L6qfe93w03on6
         O8wsBlWmpEmcZMWVG7vUxga9csu/DS5M8ieHTQ+WFXB78toa2EvqDVzMqTE5flLxLus+
         dqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ll4eqAKYtjTVgiWa+EM/tj8opR8soYnFbaqkSa8MX0w=;
        b=UVSbDU2CeAlR5OqUYs3lnBmPaVYndf1jToJrmqs2U4bEBNdFiUUoELwYBAJnQYz09o
         OAsCm9kVxPJ3jDh3iSNg4eE1KZU9o+IGQUNYiemx+bzkDJOglsMEY5hymlVNhjg6I8x3
         VUnoWIjGUIO7Hd37nzn15UV3LhrbrZ2yWXsUTaAONPrs1Hs186J6WzyVH9m2Ztmpd4xm
         VBUv+1rD+1SNAp+gXFz8wp4bSx9V/4MqvdaKK4kRfEixi1Sc6NeUFWxlbxXTQ9EfA9bj
         3hIFEhmHuKXDNCmzLpn97IfrsR8/xwBKFPFtMKY5yru1f/7r6w4Sng3dehVwFZ/a6yt5
         YTGA==
X-Gm-Message-State: AGi0PubbqppxyjZC8YQD2bwDXA2nq3+vmE4bhEeXDFQWHIC3gg9foVqu
        tUP6MV1viEIVT/H4V78h723uY4Qc2aTwSt1zhz0=
X-Google-Smtp-Source: APiQypKDWYE7ro/xZ4gZ+BUY0l4LRMksuXmT+3J4sb0z0oWxfdy2Qap6WOfuUwiVUau7i+EWwS9jFojCnbujMqGjuj0=
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr23399657wrw.402.1586870078292;
 Tue, 14 Apr 2020 06:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200226190152.16131-1-Kenny.Ho@amd.com> <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org> <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
 <20200413191136.GI60335@mtj.duckdns.org> <20200414122015.GR3456981@phenom.ffwll.local>
 <CAOWid-f-XWyg0o3znH28xYndZ0OMzWfv3OOuWw08iJDKjrqFGA@mail.gmail.com> <CAKMK7uEs5QvUrxKcTFksO30D+x=XJnV+_TA-ebawcihtLqDG0Q@mail.gmail.com>
In-Reply-To: <CAKMK7uEs5QvUrxKcTFksO30D+x=XJnV+_TA-ebawcihtLqDG0Q@mail.gmail.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Tue, 14 Apr 2020 09:14:27 -0400
Message-ID: <CAOWid-fwEOk+4CvUAumo=byWpq4vVUoCiwW1N6F-0aEd6G7d4A@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Tejun Heo <tj@kernel.org>, Kenny Ho <Kenny.Ho@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>, jsparks@cray.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        cgroups@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Ok.  I was hoping you can clarify the contradiction between the
existance of the spec below and your "not something any other gpu can
reasonably support" statement.  I mean, OneAPI is Intel's spec and
doesn't that at least make SubDevice support "reasonable" for one more
vendor?

Partisanship aside, as a drm co-maintainer, do you really not see the
need for non-work-conserving way of distributing GPU as a resource?
You recognized the latencies involved (although that's really just
part of the story... time sharing is never going to be good enough
even if your switching cost is zero.)  As a drm co-maintainer, are you
suggesting GPU has no place in the HPC use case?

Regards,
Kenny

On Tue, Apr 14, 2020 at 8:52 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Apr 14, 2020 at 2:47 PM Kenny Ho <y2kenny@gmail.com> wrote:
> > On Tue, Apr 14, 2020 at 8:20 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > My understanding from talking with a few other folks is that
> > > the cpumask-style CU-weight thing is not something any other gpu can
> > > reasonably support (and we have about 6+ of those in-tree)
> >
> > How does Intel plan to support the SubDevice API as described in your
> > own spec here:
> > https://spec.oneapi.com/versions/0.7/oneL0/core/INTRO.html#subdevice-support
>
> I can't talk about whether future products might or might not support
> stuff and in what form exactly they might support stuff or not support
> stuff. Or why exactly that's even in the spec there or not.
>
> Geez
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch

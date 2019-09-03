Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D186A73A8
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2019 21:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfICTaZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Sep 2019 15:30:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39996 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfICTaZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Sep 2019 15:30:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so18694496wrd.7
        for <cgroups@vger.kernel.org>; Tue, 03 Sep 2019 12:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUC9lNV3hiLQYYhK09gUGrdClqoIa3FcNpKkrkBFKUs=;
        b=dOiBwHRt8IrV+6hpNvTDbS6aoB5EH3z4mCO1RHw+JoOBM7t049RVg/ueYKwqsgHTev
         ndqWdh/yNmmbMXnYN9u9G8GfPKv4O5SxYLfTYCbcl6i0znIa1JI5c8Z3MlzTP2DvjM8R
         W+oY+f78T/859JA6GAgTcYYFeQpCAxXBtouSQQ0Q3zr6lrCe6ou6vxNHpP60V9IcAHH9
         JrQzUp1+bRg8vUoc8g0BzLEKDdidFpqPkrPoi81MdxjbT7tzJ8CXpsHXM4k7mE5uM7zD
         eeV+inQonK+lK/6woygeYQJlxePKYHm92EmzhNS3em0sGXi/m8BOseuywSmZvvvGkTs9
         wHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUC9lNV3hiLQYYhK09gUGrdClqoIa3FcNpKkrkBFKUs=;
        b=V15Hr52N9h4VvsC1qyR4dkmuqWGol8U5dxzojAyo6qLLRaUwqrYMXV9MppOcotvxaI
         nJsXwRCDPJAasgQxyGkqbmRKRyO5JG93R3r8BMnXa5aEQvmLIroepxFllP06tF9dnDJL
         F/9TsZCEwlDvldBpvIiTifcstCuF9/FlAZjcXlHKIxUouTheJgSxUQGZjcCWsGLLpvK+
         MLITRGNXgrnHo/m465k+oWBB4MJfzRG7tkghW0NGyEjTb5mg+z/fCeitSP7dtCsmvTTa
         CYE8N71tAmniJ3NeSPCtuf2e/vOrl+ERhskjjweStK1eCUjfEIF9autr4fEHmlRaTTDP
         u7ig==
X-Gm-Message-State: APjAAAVeEq9M+FbQdIooh/k9wn/p/CrZvKI2crcDEL7dSpjs0E81BoAB
        TkddaAIhO3DhA5Ba6VmBirFaGagiqeaV8IJI9nY=
X-Google-Smtp-Source: APXvYqwGtw3k06abnxnAPKVukQA7dOhMMxI8wqrOCiZub2liJlFPTERNxfiKu289CQ8PDUPntVyv2CnSIs5XpSTAGwc=
X-Received: by 2002:adf:ef44:: with SMTP id c4mr23938460wrp.216.1567539022320;
 Tue, 03 Sep 2019 12:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190903080217.GL2112@phenom.ffwll.local>
 <f8d561b9-091e-2f74-944f-38230195eea8@amd.com> <CAKMK7uGDs1fznj7PQytc7fAtBoSQ4VmW6D6UDqTgPxzgHOsC+Q@mail.gmail.com>
In-Reply-To: <CAKMK7uGDs1fznj7PQytc7fAtBoSQ4VmW6D6UDqTgPxzgHOsC+Q@mail.gmail.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Tue, 3 Sep 2019 15:30:11 -0400
Message-ID: <CAOWid-cgr3BuGzuxeGTmb_4jQXEy=GJVXR874iTz_kYRgRUqKA@mail.gmail.com>
Subject: Re: [PATCH RFC v4 00/16] new cgroup controller for gpu/drm subsystem
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Ho, Kenny" <Kenny.Ho@amd.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
        "jsparks@cray.com" <jsparks@cray.com>,
        "lkaplan@cray.com" <lkaplan@cray.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 3, 2019 at 5:20 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Sep 3, 2019 at 10:24 AM Koenig, Christian
> <Christian.Koenig@amd.com> wrote:
> >
> > Am 03.09.19 um 10:02 schrieb Daniel Vetter:
> > > On Thu, Aug 29, 2019 at 02:05:17AM -0400, Kenny Ho wrote:
> > >> With this RFC v4, I am hoping to have some consensus on a merge plan.  I believe
> > >> the GEM related resources (drm.buffer.*) introduced in previous RFC and,
> > >> hopefully, the logical GPU concept (drm.lgpu.*) introduced in this RFC are
> > >> uncontroversial and ready to move out of RFC and into a more formal review.  I
> > >> will continue to work on the memory backend resources (drm.memory.*).
> > >>
> > >> The cover letter from v1 is copied below for reference.
> > >>
> > >> [v1]: https://lists.freedesktop.org/archives/dri-devel/2018-November/197106.html
> > >> [v2]: https://www.spinics.net/lists/cgroups/msg22074.html
> > >> [v3]: https://lists.freedesktop.org/archives/amd-gfx/2019-June/036026.html
> > > So looking at all this doesn't seem to have changed much, and the old
> > > discussion didn't really conclude anywhere (aside from some details).
> > >
> > > One more open though that crossed my mind, having read a ton of ttm again
> > > recently: How does this all interact with ttm global limits? I'd say the
> > > ttm global limits is the ur-cgroups we have in drm, and not looking at
> > > that seems kinda bad.
> >
> > At least my hope was to completely replace ttm globals with those
> > limitations here when it is ready.
>
> You need more, at least some kind of shrinker to cut down bo placed in
> system memory when we're under memory pressure. Which drags in a
> pretty epic amount of locking lols (see i915's shrinker fun, where we
> attempt that). Probably another good idea to share at least some
> concepts, maybe even code.

I am still looking into your shrinker suggestion so the memory.*
resources are untouch from RFC v3.  The main change for the buffer.*
resources is the removal of buffer sharing restriction as you
suggested and additional documentation of that behaviour.  (I may have
neglected mentioning it in the cover.)  The other key part of RFC v4
is the "logical GPU/lgpu" concept.  I am hoping to get it out there
early for feedback while I continue to work on the memory.* parts.

Kenny

> -Daniel
>
> >
> > Christian.
> >
> > > -Daniel
> > >
> > >> v4:
> > >> Unchanged (no review needed)
> > >> * drm.memory.*/ttm resources (Patch 9-13, I am still working on memory bandwidth
> > >> and shrinker)
> > >> Base on feedbacks on v3:
> > >> * update nominclature to drmcg
> > >> * embed per device drmcg properties into drm_device
> > >> * split GEM buffer related commits into stats and limit
> > >> * rename function name to align with convention
> > >> * combined buffer accounting and check into a try_charge function
> > >> * support buffer stats without limit enforcement
> > >> * removed GEM buffer sharing limitation
> > >> * updated documentations
> > >> New features:
> > >> * introducing logical GPU concept
> > >> * example implementation with AMD KFD
> > >>
> > >> v3:
> > >> Base on feedbacks on v2:
> > >> * removed .help type file from v2
> > >> * conform to cgroup convention for default and max handling
> > >> * conform to cgroup convention for addressing device specific limits (with major:minor)
> > >> New function:
> > >> * adopted memparse for memory size related attributes
> > >> * added macro to marshall drmcgrp cftype private  (DRMCG_CTF_PRIV, etc.)
> > >> * added ttm buffer usage stats (per cgroup, for system, tt, vram.)
> > >> * added ttm buffer usage limit (per cgroup, for vram.)
> > >> * added per cgroup bandwidth stats and limiting (burst and average bandwidth)
> > >>
> > >> v2:
> > >> * Removed the vendoring concepts
> > >> * Add limit to total buffer allocation
> > >> * Add limit to the maximum size of a buffer allocation
> > >>
> > >> v1: cover letter

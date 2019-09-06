Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19245ABCA9
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2019 17:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404867AbfIFPgO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Sep 2019 11:36:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40364 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404801AbfIFPgO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Sep 2019 11:36:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id y39so6097156ota.7
        for <cgroups@vger.kernel.org>; Fri, 06 Sep 2019 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7uHQ4kMl6WZSyY7oAdRMYnb4CAlCS07EFriCepdN01o=;
        b=e9KDLutTmvRwTRVm/wqo5phcOLyAMasIS2Fn6cd3dKK1LPW9IM3AF2SPtYpxiSFu/l
         G6AT4dooGSXxZQEgT0pLtQlY0+CPzzw+pS+lFzqMZR1lZt/SZZ++MU2A88l5npA6/tPw
         7dPll1Sr6Kxh5j3AJIwimTv/PTXwXsTHrZ250=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uHQ4kMl6WZSyY7oAdRMYnb4CAlCS07EFriCepdN01o=;
        b=C+yFEnrJe/4FYX+HmoeKsYsFc0kYRUpLUhePZ/3pOkhb0fA4ZjS6phVvLvjKbV08Yh
         37fGOmxPXdY2mRTTNoDIdAeIKKTFcWd9tou8oKz/XmlDdKqf/L+buuPRvVaHQsPhUzJJ
         ivK21WyF26GrwMYhjUFtuiKjFZ9i5Eyz5/OiGc0Zz30j34c/Q4bzphskKwv15jXzcdLz
         jlFfYiVFEnQ9iq46b4TIJtneT4D1IxygFbl2L42EeiZj+Wdxp9+H9a7z3Yz158z0j72d
         Yp0da6aKLkW191wzDy7m6G0fjiPaFVv8IudPsVKP0Motg6WnYSj2KK1o100JXjtnQt0s
         Smng==
X-Gm-Message-State: APjAAAUj9fz01SSJUSG/ObRFPO0L+wFNWa5sDy9SAp92A3IEC1Zg/QfZ
        Dwiq+kjmD7wD0aZ+NN+C+qg5hfM09DVRMWm9hynggQ==
X-Google-Smtp-Source: APXvYqwZp3NJFwp6uzb8XlomfJTw7uMfJIW0JKdoayVi5f6h/5TyLqnw8Ny26XCTCP9zRkA67S0/sW80K2lE5ARGwMc=
X-Received: by 2002:a05:6830:1185:: with SMTP id u5mr7738954otq.106.1567784173479;
 Fri, 06 Sep 2019 08:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190829060533.32315-2-Kenny.Ho@amd.com>
 <20190903075719.GK2112@phenom.ffwll.local> <CAOWid-dxxDhyxP2+0R0oKAk29rR-1TbMyhshR1+gbcpGJCAW6g@mail.gmail.com>
 <CAKMK7uEofjdVURu+meonh_YdV5eX8vfNALkW3A_+kLapCV8j+w@mail.gmail.com>
 <CAOWid-eUVztW4hNVpznnJRcwHcjCirGL2aS75p4OY8XoGuJqUg@mail.gmail.com>
 <20190904085434.GF2112@phenom.ffwll.local> <20190906152925.GN2263813@devbig004.ftw2.facebook.com>
In-Reply-To: <20190906152925.GN2263813@devbig004.ftw2.facebook.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 6 Sep 2019 17:36:02 +0200
Message-ID: <CAKMK7uFQqAMB1DbiEy-o2bzr_F25My93imNcg1Qh9DHe=uWQug@mail.gmail.com>
Subject: Re: [PATCH RFC v4 01/16] drm: Add drm_minor_for_each
To:     Tejun Heo <tj@kernel.org>
Cc:     Kenny Ho <y2kenny@gmail.com>, Kenny Ho <Kenny.Ho@amd.com>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 6, 2019 at 5:29 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Sep 04, 2019 at 10:54:34AM +0200, Daniel Vetter wrote:
> > Anyway, I don't think reusing the drm_minor registration makes sense,
> > since we want to be on the drm_device, not on the minor. Which is a bit
> > awkward for cgroups, which wants to identify devices using major.minor
> > pairs. But I guess drm is the first subsystem where 1 device can be
> > exposed through multiple minors ...
> >
> > Tejun, any suggestions on this?
>
> I'm not extremely attached to maj:min.  It's nice in that it'd be
> consistent with blkcg but it already isn't the nicest of identifiers
> for block devices.  If using maj:min is reasonably straight forward
> for gpus even if not perfect, I'd prefer going with maj:min.
> Otherwise, please feel free to use the ID best for GPUs - hopefully
> something which is easy to understand, consistent with IDs used
> elsewhere and easy to build tooling around.

Block devices are a great example I think. How do you handle the
partitions on that? For drm we also have a main minor interface, and
then the render-only interface on drivers that support it. So if blkcg
handles that by only exposing the primary maj:min pair, I think we can
go with that and it's all nicely consistent.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

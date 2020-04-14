Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086211A7B54
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 14:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502177AbgDNMwa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 08:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730138AbgDNMwZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 08:52:25 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D25DC061A0C
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 05:52:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id j4so5993593otr.11
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idICXkJz74c7neHkFNePvVgcEywM92lHIYRxNNra+ik=;
        b=AysPXwu5jTUfa1VDz4/pasjtYQL4Ei1kOikX9A30tHaFk0XOjuonU//xrGlAiIcEPD
         CNktfG9lG9AnPftdTGEvxz5fY7N6jEWlt2I3stICIfIhscN2XWUwmiE5JBDtgAE+9nlG
         CEZFC/EdJVU2uAGihdcQvkCAuc3FFtMCuQUqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idICXkJz74c7neHkFNePvVgcEywM92lHIYRxNNra+ik=;
        b=hPwX0v9JenUrw3FI5R30VPobuXMnYEdNCeEziCFlLDXNriBrpOpQZbTVec8/6TkeSv
         NN8qQODp+um61tUHGr5bJXrvyDEGIwN/N7wExHP2zhkBYGVKwxXxEXa5fTzSGVqeNKwM
         0ZuYIbvgSvRg4vL7tuhrDW4yk4iuyJfLunkGllV5QsBa+U7a4K5T2p6DohYZu9TqlcFS
         8/ip/ZvHHBW+z9XmTaqNA1yXJy1J7Xh1eyIdCRoW8ksIcWjxhaJqDZbmV8TnPqh/XHMK
         supD+luodPriYbf8K1mtO3fSPjBSwvWwTv4+f1aJJTAuhCecHgVT4hZ+J22sZsUhQ9VW
         fSWw==
X-Gm-Message-State: AGi0PuYwr90bGOb1Eli6X9V3nibFPfypJpNTj0B5Mg0Ly/08ETFvX3ag
        D7T1HAY7E4NLTbPiSBaIXkUdVBoC51whjqHj98NI/g==
X-Google-Smtp-Source: APiQypIRhavDU8SB9YPvvZ0Vo+SQlCg+mOyD0qnxtqXhdtlpLUrrl6Hgm8wTyMthv444nZmNp8f+5IWiEIqgv4zy4Qc=
X-Received: by 2002:a9d:2056:: with SMTP id n80mr19284790ota.281.1586868743794;
 Tue, 14 Apr 2020 05:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200226190152.16131-1-Kenny.Ho@amd.com> <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org> <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
 <20200413191136.GI60335@mtj.duckdns.org> <20200414122015.GR3456981@phenom.ffwll.local>
 <CAOWid-f-XWyg0o3znH28xYndZ0OMzWfv3OOuWw08iJDKjrqFGA@mail.gmail.com>
In-Reply-To: <CAOWid-f-XWyg0o3znH28xYndZ0OMzWfv3OOuWw08iJDKjrqFGA@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 14 Apr 2020 14:52:12 +0200
Message-ID: <CAKMK7uEs5QvUrxKcTFksO30D+x=XJnV+_TA-ebawcihtLqDG0Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
To:     Kenny Ho <y2kenny@gmail.com>
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

On Tue, Apr 14, 2020 at 2:47 PM Kenny Ho <y2kenny@gmail.com> wrote:
> On Tue, Apr 14, 2020 at 8:20 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > My understanding from talking with a few other folks is that
> > the cpumask-style CU-weight thing is not something any other gpu can
> > reasonably support (and we have about 6+ of those in-tree)
>
> How does Intel plan to support the SubDevice API as described in your
> own spec here:
> https://spec.oneapi.com/versions/0.7/oneL0/core/INTRO.html#subdevice-support

I can't talk about whether future products might or might not support
stuff and in what form exactly they might support stuff or not support
stuff. Or why exactly that's even in the spec there or not.

Geez
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

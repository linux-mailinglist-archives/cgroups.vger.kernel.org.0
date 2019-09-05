Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2F08AADCD
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2019 23:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbfIEV0X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Sep 2019 17:26:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55780 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731418AbfIEV0W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Sep 2019 17:26:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id g207so4327853wmg.5
        for <cgroups@vger.kernel.org>; Thu, 05 Sep 2019 14:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TiQP/HRy1KyEEovXtGeKVJxMUd2ZLygvJYJZXQnSwBk=;
        b=ft6Q6+jSW1cfNGf+VwxxVSnR70P6Jv8Imf6TVo4WKM5GEVO7BvdTqflCRtFgf3iHj2
         ljvaDbdv4QEv/0cCrWAV9cxPPFvVm1dmo6FDlFmo2ZqS5KJgEUspz3sKtpouSEabI6oz
         b+0GGC8nQmNujXBtfVEtTjBjR0HudMuK962gt05YoW6ISE2ErGWDhfgVhwmpYRt07AK5
         r5sLKuaTP6qpAbg0pi/7y0TmmkiZNjfUCBQsiHElY+pJ/yjSLb33iMv+t03YA48lJ3bL
         DLGSOmHlqPP3n7CkO7O5H0m7x7P2VfmwWzzCKd88IR4UoOfmUVNpA1/BrK2uQs1TscHj
         D1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TiQP/HRy1KyEEovXtGeKVJxMUd2ZLygvJYJZXQnSwBk=;
        b=WPhGQkVNjoy3yUnsPgS74Ee7GeHZfwD+YM5p13qiXgRr63UHuZ3lz3vQDXzz7EQXcI
         jsCxRh8ETD5H/cC90XqZj3EzE8AftsQV90QAWyCrB2POt5W6hB0TndLzUBKpjV08s2bF
         MRFtKh73u4EM8i4F1sM9AIE+4fNl13GjresoycvA73oNrwQPfkfEf3wZldrsSKyBPLFu
         DfMdbpfD2OSD0QH+lCgG6ix7MnT/EuROY4QzsuBUT/lcm0cslgO4mv8yDrPOQtIMyh5n
         FH9bzfwVbuX/2FTDUkHd/Pj04/LL88Mjj5Rk0NcPWiQJveCaPm39+2VJJWNOF9Qja3Vs
         9zXw==
X-Gm-Message-State: APjAAAVIEfKlb7Rfuah89VL3Zns2OsKZ1+E3zTQ0IoNePl0wgNfYnUIq
        TOovJXwvwzMGCElYom4D5OOQ/zs8tPe5CZ2FnPI=
X-Google-Smtp-Source: APXvYqzlWem0DVjP+wkVUC4FU7g6ztTFxtTEHbFfN6we+q4MFZvbglSn2JlZ1xeJwjkWLqwJQQK80ahghWzIAOCSU4s=
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr2424145wmj.97.1567718780551;
 Thu, 05 Sep 2019 14:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190829060533.32315-2-Kenny.Ho@amd.com>
 <20190903075719.GK2112@phenom.ffwll.local> <CAOWid-dxxDhyxP2+0R0oKAk29rR-1TbMyhshR1+gbcpGJCAW6g@mail.gmail.com>
 <CAKMK7uEofjdVURu+meonh_YdV5eX8vfNALkW3A_+kLapCV8j+w@mail.gmail.com>
 <CAOWid-eUVztW4hNVpznnJRcwHcjCirGL2aS75p4OY8XoGuJqUg@mail.gmail.com>
 <20190904085434.GF2112@phenom.ffwll.local> <CAOWid-fiEOmPw1z=aF6E4VE03xikREKt-X8VVKGGUGBQd3i=Kw@mail.gmail.com>
 <CAKMK7uGSrscs-WAv0pYfcxaUGXvx7M6JYbiPHTY=1hxRbFK1sg@mail.gmail.com>
 <CAOWid-eRZGxWzHw4qFqtSOCixQXvY4bEP91QnVH0Nmm13J9F-g@mail.gmail.com> <CAKMK7uHy+GRAcpLDuz6STCBW+GNfNWr-i=ZERF3uqkO7jfynnQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHy+GRAcpLDuz6STCBW+GNfNWr-i=ZERF3uqkO7jfynnQ@mail.gmail.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 5 Sep 2019 17:26:08 -0400
Message-ID: <CAOWid-cRP1T2gr2U_ZN+QhS7jFM0kFTWiYy8JPPXXmGW7xBPzA@mail.gmail.com>
Subject: Re: [PATCH RFC v4 01/16] drm: Add drm_minor_for_each
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
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

On Thu, Sep 5, 2019 at 4:32 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
*snip*
> drm_dev_unregister gets called on hotunplug, so your cgroup-internal
> tracking won't get out of sync any more than the drm_minor list gets
> out of sync with drm_devices. The trouble with drm_minor is just that
> cgroup doesn't track allocations on drm_minor (that's just the uapi
> flavour), but on the underlying drm_device. So really doesn't make
> much sense to attach cgroup tracking to the drm_minor.

Um... I think I get what you are saying, but isn't this a matter of
the cgroup controller doing a drm_dev_get when using the drm_minor?
Or that won't work because it's possible to have a valid drm_minor but
invalid drm_device in it? I understand it's an extra level of
indirection but since the convention for addressing device in cgroup
is using $major:$minor I don't see a way to escape this.  (Tejun
actually already made a comment on my earlier RFC where I didn't
follow the major:minor convention strictly.)

Kenny

> > > Just doing a drm_cg_register/unregister pair that's called from
> > > drm_dev_register/unregister, and then if you want, looking up the
> > > right minor (I think always picking the render node makes sense for
> > > this, and skipping if there's no render node) would make most sense.
> > > At least for the basic cgroup controllers which are generic across
> > > drivers.
> >
> > Why do we want to skip drm devices that does not have a render node
> > and not just use the primary instead?
>
> I guess we could also take the primary node, but drivers with only
> primary node are generaly display-only drm drivers. Not sure we want
> cgroups on those (but I guess can't hurt, and more consistent). But
> then we'd always need to pick the primary node for cgroup
> identification purposes.
> -Daniel
>
> >
> > Kenny
> >
> >
> >
> > > -Daniel

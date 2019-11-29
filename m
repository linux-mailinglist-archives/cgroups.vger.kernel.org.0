Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7C10D12E
	for <lists+cgroups@lfdr.de>; Fri, 29 Nov 2019 07:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfK2GAt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Nov 2019 01:00:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34805 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfK2GAt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Nov 2019 01:00:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id j18so8898244wmk.1
        for <cgroups@vger.kernel.org>; Thu, 28 Nov 2019 22:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q6sEJMkRXu7hSu+qr1ZpIJGkAq9uE1tMvK5+NCK55eg=;
        b=nhHXPijILiV784INV/SjVLc2zu+3GpgU4p1vIxj4gYrjylVVlPKYMTFrH8pkMwKy86
         +raTzJbjpP7b1wjMtAr/GCUyIMfNzn0f3gLciIPmOBtGBYiTzjcC0L9P1Ils3y+Mi1ox
         UukcJYbKjryHaVKKx28Y5xTrA373pz4aifxWp6gHBGyFD93dk53YUSWEK5QD2jlmqJTn
         ou7J7C0kM6WfI4AoqUVhShtWCQmRxSr6jlVq8OIhe+AR0jfOs9vzHlSkc9riBJOfxqry
         Y5SeSb2vV6RQveP+mm19ynMIoiYHr0u0avDAeAKc5Gwdo4DRz2XvfRfn5KSNlcuMlIe8
         ZvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q6sEJMkRXu7hSu+qr1ZpIJGkAq9uE1tMvK5+NCK55eg=;
        b=g4YGKAY5Ohqdgck+mhsOTKrKT1P8KhijC76J/cD6ijXCv4PpGodgVOiEg2h5QilLuP
         BedzqcT3DwSURLrvRyWD8oOdOnA2v0CvTh9ge2375RWzAE6m1/sFMbtPQzj8ngkq8p0Z
         rR0VhNMBoM3jZjLSOrNWkGGDtjBro06nJuGe2osf3xfzjOqMbeb1VbWUXmVQbXiDC8qF
         cK6oCHxNTD743OHJDqsEDUFgTtVr9dokYSZAr+8Bi2yhfMYWvvUxclC0uT7fb58sPv2C
         CaeRN5Ptpz2qoEF0orcq6+e6FCYC6h2Z4haCTf7tnEIIZmsfvLEnr6hglREzZx3Tg1kN
         L2VQ==
X-Gm-Message-State: APjAAAXwEgKAEIj4UkXRRSBBbdigzds0bdsUXP1prGla3grXYW89Urhb
        pJpM1ZNgHmnzuzMDBxmag1lmSk2vdI7F6UvMit8=
X-Google-Smtp-Source: APXvYqzQY8nI5SjRf3vbkML66dR52hVRuAwaoIiPFMnxNz/dkE8c/gs6gZOSDIpGX+HePBykztRMnjcfBaBDWBidTGQ=
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr12371703wmk.18.1575007247161;
 Thu, 28 Nov 2019 22:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190829060533.32315-3-Kenny.Ho@amd.com>
 <20191001143106.GA4749@blackbody.suse.cz>
In-Reply-To: <20191001143106.GA4749@blackbody.suse.cz>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 29 Nov 2019 01:00:36 -0500
Message-ID: <CAOWid-ewvs-c-z_WW+Cx=Jaf0p8ZAwkWCkq2E8Xkj+2HvfNjaA@mail.gmail.com>
Subject: Re: [PATCH RFC v4 02/16] cgroup: Introduce cgroup for drm subsystem
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com, Daniel Vetter <daniel@ffwll.ch>,
        Tejun Heo <tj@kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 1, 2019 at 10:31 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
> On Thu, Aug 29, 2019 at 02:05:19AM -0400, Kenny Ho <Kenny.Ho@amd.com> wro=
te:
> > +struct cgroup_subsys drm_cgrp_subsys =3D {
> > +     .css_alloc      =3D drmcg_css_alloc,
> > +     .css_free       =3D drmcg_css_free,
> > +     .early_init     =3D false,
> > +     .legacy_cftypes =3D files,
> Do you really want to expose the DRM controller on v1 hierarchies (where
> threads of one process can be in different cgroups, or children cgroups
> compete with their parents)?

(Sorry for the delay, I have been distracted by something else.)
Yes, I am hoping to make the functionality as widely available as
possible since the ecosystem is still transitioning to v2.  Do you see
inherent problem with this approach?

Regards,
Kenny


>
> > +     .dfl_cftypes    =3D files,
> > +};
>
> Just asking,
> Michal

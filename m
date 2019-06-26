Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0245739D
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 23:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfFZV2B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 17:28:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40472 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZV2B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 17:28:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so4396899wre.7
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 14:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKPa1AsM7rfnwQnb1Ufx9QUB+dzAQ4Qp3sCYKeKlFpw=;
        b=ftA5X6EP5X9FO3Z/g4O6tC81NKR4qxvgjO0iEqlJkrant6fG49e8aXNYfAKxXWvC5s
         YEzjlIueeADKHfQ3cfkZiIxuwHylNsB5yHaBidw6MjkHRdFoYB4zlCDcZhmrPiz2J/c5
         b63Ns32h/HY4JYlnhmcy8oSICZkHUrxVnNG+fO8X0CFRHQGLXlD2JsMf0x2ewuVezVo9
         KyO9Z711WenXYbZFdEZbFqrBqtIM3cGBD+94uC1NL55UdaNoSo27SH46UhLmQQ9e4VPf
         HC+nYypRMZJ9cUcj/lIaQ5C4i4TpsYLqZ8khOE61RIgNyhLvpk1heX6QA46t6lzfPZIY
         76uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKPa1AsM7rfnwQnb1Ufx9QUB+dzAQ4Qp3sCYKeKlFpw=;
        b=NXpHxmaEIw9rtW7aIshyoTu64+TO0BQ4RuFt+qufJ2m4YExAkJIBeyCc9CstY1/BNr
         2doTxmFTx+CihK0Rn4BfZDfjQyS1mtSo5OP+nGFMUOBJLADLb9KOefcdtSkT89lqRr1H
         Kakbdm4OTRxc13sVQ11OnKul82Q3NfAxV/TAZpNBoUj8uvi0Yt3n3H37249HxuWnpZpB
         8cYA8CEI2Ugv2shuAiHqEm5MhINqwur+rQb+PmrdaUFDlCkch63y9rxQhOTFD2U2pGEy
         ShIZOEWFWvqCK/gu7cWIp7hIkofz70zU+WQW8y28W6BFG2CE9Nd0jM+Yorf+NQRQ3dMI
         g23w==
X-Gm-Message-State: APjAAAX79ssdElfpUh2gtjVWt3Yyd9OWoNbqOiTQakHZcd2GmgnZKn4p
        k6jGnjeaFbxOvuzsRM/g7u7SPslhtvsvEEgoOZM=
X-Google-Smtp-Source: APXvYqxUU3CG54iiQpahlIP3u7Svs62bElm/WYd6V3cDt0emTydXjWKulrSmoZCnJh2WYSszOGvx5EQlq964yw9/mb8=
X-Received: by 2002:adf:e442:: with SMTP id t2mr5288781wrm.286.1561584479326;
 Wed, 26 Jun 2019 14:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-5-Kenny.Ho@amd.com>
 <20190626160553.GR12905@phenom.ffwll.local>
In-Reply-To: <20190626160553.GR12905@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Wed, 26 Jun 2019 17:27:48 -0400
Message-ID: <CAOWid-eurCMx1F7ciUwx0e+p=s=NP8=UxQUhhF-hdK-iAna+fA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/11] drm, cgroup: Add total GEM buffer allocation limit
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 12:05 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> > drm.buffer.default
> >         A read-only flat-keyed file which exists on the root cgroup.
> >         Each entry is keyed by the drm device's major:minor.
> >
> >         Default limits on the total GEM buffer allocation in bytes.
>
> Don't we need a "0 means no limit" semantics here?

I believe the convention is to use the 'max' keyword.

>
> I think we need a new drm-cgroup.rst which contains all this
> documentation.

Yes I planned to do that when things are more finalized.  I am
actually writing the commit message following the current doc format
so I can reuse it in the rst.

>
> With multiple GPUs, do we need an overall GEM bo limit, across all gpus?
> For other stuff later on like vram/tt/... and all that it needs to be
> per-device, but I think one overall limit could be useful.

This one I am not sure but should be fairly straightforward to add.
I'd love to hear more feedbacks on this as well.

> >       if (!amdgpu_bo_validate_size(adev, size, bp->domain))
> >               return -ENOMEM;
> >
> > +     if (!drmcgrp_bo_can_allocate(current, adev->ddev, size))
> > +             return -ENOMEM;
>
> So what happens when you start a lot of threads all at the same time,
> allocating gem bo? Also would be nice if we could roll out at least the
> accounting part of this cgroup to all GEM drivers.

When there is a large number of allocation, the allocation will be
checked in sequence within a device (since I used a per device mutex
in the check.)  Are you suggesting the overhead here is significant
enough to be a bottleneck?  The accounting part should be available to
all GEM drivers (unless I missed something) since the chg and unchg
function is called via the generic drm_gem_private_object_init and
drm_gem_object_release.

> > +     /* only allow bo from the same cgroup or its ancestor to be imported */
> > +     if (drmcgrp != NULL &&
>
> Quite a serious limitation here ...
>
> > +                     !drmcgrp_is_self_or_ancestor(drmcgrp, obj->drmcgrp)) {
>
> Also what happens if you actually share across devices? Then importing in
> the 2nd group is suddenly possible, and I think will be double-counted.
>
> What's the underlying technical reason for not allowing sharing across
> cgroups?

With the current implementation, there shouldn't be double counting as
the counting is done during the buffer init.

To be clear, sharing across cgroup is allowed, the buffer just needs
to be allocated by a process that is parent to the cgroup.  So in the
case of xorg allocating buffer for client, the xorg would be in the
root cgroup and the buffer can be passed around by different clients
(in root or other cgroup.)  The idea here is to establish some form of
ownership, otherwise there wouldn't be a way to account for or limit
the usage.

Regards,
Kenny

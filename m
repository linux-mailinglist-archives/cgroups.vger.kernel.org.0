Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 065011A012
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2019 17:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfEJPZv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 11:25:51 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37672 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfEJPZu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 11:25:50 -0400
Received: by mail-oi1-f196.google.com with SMTP id 143so4821669oii.4
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 08:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lKwN54SK+W6O9fjruMh2Yrp66lpefmr9JPdcP+S36Vk=;
        b=MzkCyMwYP6vwvvOjpLsMr1FlOuh2aoSNNH4ivWkC7vz7RDHLCfPIa6PQ0cDphZUWli
         ZL4ccEZcjzcHxoez+sUBmG6KB3GXXo6JKartpZB87cBcQ3kEEBHNKbXgIfZ3004OvQmy
         aeFhzsmcxtQJxQgsfJzYXPiR5n/SS87g57B4ks4ruWHPckfFAYvCAWhuSUQzDOv7cENV
         /0tQoVOdezg84O2bBx67TFiOoYzHSIo7N0RHW8jpz4ernghPEO2tRCunQiLTevYRQAMt
         yXiaRGRB883oEV+r7F/D08/8ZuuSm9/z3uh+79uHZrXZPefFfMch+bQecK3Y4L1i1WTH
         TfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lKwN54SK+W6O9fjruMh2Yrp66lpefmr9JPdcP+S36Vk=;
        b=k3GB9+S5hCGutRhgyh77zN6nd60pZG5nu4H+Y81VK/fYPSX82yQgL2u14jq2o7K5UW
         tFEoy7lIny7oiqqG4WXiaXW/w2FJaBNhS8droAxsnZ0/S2Svab5uUO18DTPleEmb/MU6
         ntKMJzZvrOsIj2h9YOJg99AbynO+y/SvMAZCVmaEh3jyrcaWvhKSNQBFuq44ZdfgE2He
         WVTCzuHHrrvXgyjlojr40JYmfDwDghaMISsrqmy/brevqmjjZuiRefg0RZ+eYQZwYrzU
         rOETHGWoKudyuP9RN8VwIk+GrTxm/og08aTXIvSbOOq65RACLuzbW4HJkwgQ+i3KSKEU
         dZsQ==
X-Gm-Message-State: APjAAAWazkNzF1r2gUIIKDwf50ZEyULM8UinOJBH8M01qiEq7V6MXdUS
        R02VXoxGhGDOQEAytzRSwCUn7OOTMaAyBEfD+O4=
X-Google-Smtp-Source: APXvYqxMoxs8eeJi15rqKro5+GmOfVwMuCoN5hY4PYXTEvCmTRz9NKHdGZOHdS5/jU0ofKopRhRfCK6E+Z/P/ewrlO0=
X-Received: by 2002:aca:d90a:: with SMTP id q10mr4730169oig.65.1557501950024;
 Fri, 10 May 2019 08:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181120185814.13362-1-Kenny.Ho@amd.com> <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-5-Kenny.Ho@amd.com> <f63c8d6b-92a4-2977-d062-7e0b7036834e@gmail.com>
 <CAOWid-fpHqvq35C+gfHmLnuHM9Lj+iiHFXE=3RPrkAiFL2=wvQ@mail.gmail.com> <1ca1363e-b39c-c299-1d24-098b1059f7ff@amd.com>
In-Reply-To: <1ca1363e-b39c-c299-1d24-098b1059f7ff@amd.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 10 May 2019 11:25:38 -0400
Message-ID: <CAOWid-eVz4w-hN=4tPZ1AOu54xMH_2ztDDZaMEKRCAeBgt9Dyw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] drm, cgroup: Add total GEM buffer allocation limit
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "Ho, Kenny" <Kenny.Ho@amd.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Brian Welty <brian.welty@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 10, 2019 at 11:08 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
> Am 10.05.19 um 16:57 schrieb Kenny Ho:
> > On Fri, May 10, 2019 at 8:28 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >> Am 09.05.19 um 23:04 schrieb Kenny Ho:
> So the drm cgroup container is separate to other cgroup containers?
In cgroup-v1, which is most widely deployed currently, all controllers
have their own hierarchy (see /sys/fs/cgroup/).  In cgroup-v2, the
hierarchy is unified by individual controllers can be disabled (I
believe, I am not super familiar with v2.)

> In other words as long as userspace doesn't change, this wouldn't have
> any effect?
As far as things like docker and podman is concern, yes.  I am not
sure about the behaviour of others like lxc, lxd, etc. because I
haven't used those myself.

> Well that is unexpected cause then a processes would be in different
> groups for different controllers, but if that's really the case that
> would certainly work.
I believe this is a possibility for v1 and is why folks came up with
the unified hierarchy in v2 to solve some of the issues.
https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#issues-wi=
th-v1-and-rationales-for-v2

Regards,
Kenny

> > On the other hand, if there are expectations for resource management
> > between containers, I would like to know who is the expected manager
> > and how does it fit into the concept of container (which enforce some
> > level of isolation.)  One possible manager may be the display server.
> > But as long as the display server is in a parent cgroup of the apps'
> > cgroup, the apps can still import handles from the display server
> > under the current implementation.  My understanding is that this is
> > most likely the case, with the display server simply sitting at the
> > default/root cgroup.  But I certainly want to hear more about other
> > use cases (for example, is running multiple display servers on a
> > single host a realistic possibility?  Are there people running
> > multiple display servers inside peer containers?  If so, how do they
> > coordinate resources?)
>
> We definitely have situations with multiple display servers running
> (just think of VR).
>
> I just can't say if they currently use cgroups in any way.
>
> Thanks,
> Christian.
>
> >
> > I should probably summarize some of these into the commit message.
> >
> > Regards,
> > Kenny
> >
> >
> >
> >> Christian.
> >>
>

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1B15F7B3
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 21:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgBNU2y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 15:28:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51678 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNU2y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 15:28:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so11290016wmi.1
        for <cgroups@vger.kernel.org>; Fri, 14 Feb 2020 12:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7pGksv/syYfMklkQS/MIxpCbqI6gBoN9ooNLnkw1E8=;
        b=N1XKAjyzrOIL2WzL1i8osQZXd6YVKxqkJSXnzZnFBy1EQOWFgDBfiObxlJ6bu7mVat
         eUdmeSjiexNOP2Prvp/0vLY5h/yLiURfC8HoGpPbpMX54OZ8mr/dUR29OBSMivfWUWXn
         iyguSO0yZXfkaIQtW7BYfxWDSegl8iR5+RdQ82QsOBT8A8FoilCfgTKeFMSqVwieUMZi
         U8o4gtsr1gm5O6AvmypSDqY/hNM0Gcg7QWEJ2WD9fhHMcr7QyfNgEhkD1woTpTAfdwvQ
         Eb3cQ7NrGnGi9ubqbT2kUO6hU52AeCwU0WutSeAT4c8nD40tE5hqBlMSInEIdyFR905L
         EXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7pGksv/syYfMklkQS/MIxpCbqI6gBoN9ooNLnkw1E8=;
        b=Atzu5geTWsarQZ3RZEMRJwvvyoKRwUJAnGMMQvBGzWGrREDfB0PaAPPy36FiMDCwaw
         1+PW42iYZmBnK31cD/j9bn40pQ1WSRv2VAkxbBDFMMvcebDhOLI3E38XNruuNzJrDpEh
         SSnN7ue9ALDXclRt8cGblTC94Bl7KWIdposBb4uZ+V6HyWkE0h9R2jAV5E8RBoevPsAM
         Vjlc1fgLZ270H74C+Ya6lsRu9vfDiaGe3rDj7VfpEg4xoUTHzUUevFxMc5WHreDVfxAL
         mWN5Pgf4iiS8Z9xKKRgrR74y5z46jyFWaV6zUMmCx3//B/wFVM6eVsQ9UZosRMxfSCze
         63JQ==
X-Gm-Message-State: APjAAAXtMLm5uNAv2vdmLu+QvM94oE9rIbMLgKsWtN981BHEFCX2EiFz
        Pz1K3ux1llaAAnTvcdX05/VXltSVOqA5Lt73Vx0=
X-Google-Smtp-Source: APXvYqzQzqb+GYycoJ++mSYmrxDPTAkYNnz/M4iHUyk2dnbs4mPvr3G0FHTH7AAXaolWev+GH/6SQNwmuJwpuYt5d/E=
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr6419397wmm.143.1581712131806;
 Fri, 14 Feb 2020 12:28:51 -0800 (PST)
MIME-Version: 1.0
References: <20200214155650.21203-1-Kenny.Ho@amd.com> <20200214155650.21203-10-Kenny.Ho@amd.com>
 <CAOFGe96N5gG+08rQCRC+diHKDAfxPFYEnVxDS8_udvjcBYgsPg@mail.gmail.com>
 <CAOWid-f62Uv=GZXX2V2BsQGM5A1JJG_qmyrOwd=KwZBx_sr-bg@mail.gmail.com>
 <20200214183401.GY2363188@phenom.ffwll.local> <CAOWid-caJHeXUnQv3MOi=9U+vdBLfewN+CrA-7jRrz0VXqatbQ@mail.gmail.com>
 <20200214191754.GA218629@mtj.thefacebook.com>
In-Reply-To: <20200214191754.GA218629@mtj.thefacebook.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 14 Feb 2020 15:28:40 -0500
Message-ID: <CAOWid-dA2Ad-FTZDDLOs4pperYbsru9cknSuXo_2ajpPbQH0Xg@mail.gmail.com>
Subject: Re: [PATCH 09/11] drm, cgroup: Introduce lgpu as DRM cgroup resource
To:     Tejun Heo <tj@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com, nirmoy.das@amd.com, damon.mcdougall@amd.com,
        juan.zuniga-anaya@amd.com, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On Fri, Feb 14, 2020 at 2:17 PM Tejun Heo <tj@kernel.org> wrote:
>
> I have to agree with Daniel here. My apologies if I weren't clear
> enough. Here's one interface I can think of:
>
>  * compute weight: The same format as io.weight. Proportional control
>    of gpu compute.
>
>  * memory low: Please see how the system memory.low behaves. For gpus,
>    it'll need per-device entries.
>
> Note that for both, there one number to configure and conceptually
> it's pretty clear to everybody what that number means, which is not to
> say that it's clear to implement but it's much better to deal with
> that on this side of the interface than the other.

Can you elaborate, per your understanding, how the lgpu weight
attribute differ from the io.weight you suggested?  Is it merely a
formatting/naming issue or is it the implementation details that you
find troubling?  From my perspective, the weight attribute implements
as you suggested back in RFCv4 (proportional control on top of a unit
- either physical or time unit.)

Perhaps more explicit questions would help me understand what you
mean. If I remove the 'list' and 'count' attributes leaving just
weight, is that satisfactory?  Are you saying the idea of affinity or
named-resource is banned from cgroup entirely (even though it exists
in the form of cpuset already and users are interested in having such
options [i.e. userspace OpenCL] when needed?)

To be clear, I am not saying no proportional control.  I am saying
give the user the options, which is what has been implemented.

> cc'ing Johannes. Do you have anything on mind regarding how gpu memory
> configuration should look like? e.g. should it go w/ weights rather
> than absoulte units (I don't think so given that it'll most likely
> need limits at some point too but still and there are benefits from
> staying consistent with system memory).
>
> Also, a rather trivial high level question. Is drm a good controller
> name given that other controller names are like cpu, memory, io?

There was a discussion about naming early in the RFC (I believe
RFCv2), the consensuses then was to use drmcg to align with the drm
subsystem.  I have no problem renaming it to gpucg  or something
similar if that is the last thing that's blocking acceptance.  For
now, I would like to get some clarity on the implementation before
having more code churn.

Regards,
Kenny


> Thanks.
>
> --
> tejun

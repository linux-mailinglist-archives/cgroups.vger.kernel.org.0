Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 271D4166F62
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2020 07:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgBUGAJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Feb 2020 01:00:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51703 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgBUGAJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Feb 2020 01:00:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id t23so404792wmi.1
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2020 22:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7aXQTqmLNxvdPr5mBNnJfbo38LB1xJHVHK2rWbKEqw=;
        b=MOqfv/kaObHJEU4A0mnaFSEPVoAQ+XzGpPBw1qUzIDChC2bV5Xis329ghi0OSMUe2T
         YhVicpLrQndbQZs6riGjFqTmtdy+EMbG4jyCnKVus42lLRijK/C+rJhfwsU1A1+dZ2oq
         x9Iy53HEEPilEHf0enrdVhBui0Cuk44XNN8OwtHBWBHJG4b2EaSDPRDTxw6C8lUt5zYA
         mHMjTP2udC0KW3zyt6aJmu5BQahyQw6PpXAAISnMF6MG4/nYxe6+8f552zlV89Bl8i8e
         Rq9Iqy2Y+S2iwCZPuVrxEqWRujTeaoMDyqLddd6W1ztvZrcj+S68m6+yNug0QMoHvJop
         m+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7aXQTqmLNxvdPr5mBNnJfbo38LB1xJHVHK2rWbKEqw=;
        b=lDQkRoXbR1RNm7xbJY6n4hHqDfrVodbYfulQ2/viMDKI2rdYzBGBihNO+/kriGbWRh
         357wfZP9u5LJlIBjSXDj2GRvgJHo9Enbl0b5aypzsk2isn+R0Ek3mXbgNEvDUSOk6MtK
         T3Cfn2Ys1boA/5mhD1md00q+27f5sVVH1UnCdDRFCbHly5Qjf/VZFEkBsJBfd92uwnjM
         vBmCH8rrSWbbe2kmS5NIMZ5+2n7MdxCHtydIiMQkBuPDNfMFeI7WukRM+lis0AUdpnS6
         72HI7cJKA1rgMvPyfVN0Qj/vvRmZn/yIOtThqFX+wj0Lo4fkxzMrYxfNXyDr9+MyjkdE
         Rkqg==
X-Gm-Message-State: APjAAAVhFm3n0hE92gNvr/PiI5wLdpc2OakN5QIl7oX8ejzBVrHtZtMK
        XzIFziddPMrxYTmN6lQ3dAlDu98lHmeG/VjZWhs=
X-Google-Smtp-Source: APXvYqwUciNnVQPNEXNeyIwx5TVfT9GtH4vdeEDW/3kEC5yZ72E+38Ud0AgtP2twlUA6naX2Ps2iMF7lw5IFwrkqRMQ=
X-Received: by 2002:a1c:9602:: with SMTP id y2mr1420482wmd.23.1582264807381;
 Thu, 20 Feb 2020 22:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20200214155650.21203-1-Kenny.Ho@amd.com> <20200214155650.21203-10-Kenny.Ho@amd.com>
 <CAOFGe96N5gG+08rQCRC+diHKDAfxPFYEnVxDS8_udvjcBYgsPg@mail.gmail.com>
 <CAOWid-f62Uv=GZXX2V2BsQGM5A1JJG_qmyrOwd=KwZBx_sr-bg@mail.gmail.com>
 <20200214183401.GY2363188@phenom.ffwll.local> <CAOWid-caJHeXUnQv3MOi=9U+vdBLfewN+CrA-7jRrz0VXqatbQ@mail.gmail.com>
 <20200214191754.GA218629@mtj.thefacebook.com> <20200219161850.GB13406@cmpxchg.org>
 <CAOWid-e=7V4TUqK_h5Gs9dUXqH-Vgr-Go8c1dCkMux98Vdd1sQ@mail.gmail.com> <20200219183841.GA54486@cmpxchg.org>
In-Reply-To: <20200219183841.GA54486@cmpxchg.org>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 21 Feb 2020 00:59:55 -0500
Message-ID: <CAOWid-dLs079jHAVoDeJ2Ung1Tti0Jszhd-0D2RYPOjuWnTprQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] drm, cgroup: Introduce lgpu as DRM cgroup resource
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
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
        juan.zuniga-anaya@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thanks, I will take a look.

Regards,
Kenny

On Wed, Feb 19, 2020 at 1:38 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Feb 19, 2020 at 11:28:48AM -0500, Kenny Ho wrote:
> > On Wed, Feb 19, 2020 at 11:18 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > Yes, I'd go with absolute units when it comes to memory, because it's
> > > not a renewable resource like CPU and IO, and so we do have cliff
> > > behavior around the edge where you transition from ok to not-enough.
> > >
> > > memory.low is a bit in flux right now, so if anything is unclear
> > > around its semantics, please feel free to reach out.
> >
> > I am not familiar with the discussion, would you point me to a
> > relevant thread please?
>
> Here is a cleanup patch, not yet merged, that documents the exact
> semantics and behavioral considerations:
>
> https://lore.kernel.org/linux-mm/20191213192158.188939-3-hannes@cmpxchg.org/
>
> But the high-level idea is this: you assign each cgroup or cgroup
> subtree a chunk of the resource that it's guaranteed to be able to
> consume. It *can* consume beyond that threshold if available, but that
> overage may get reclaimed again if somebody else needs it instead.
>
> This allows you to do a ballpark distribution of the resource between
> different workloads, while the kernel retains the ability to optimize
> allocation of spare resources - because in practice, workload demand
> varies over time, workloads disappear and new ones start up etc.
>
> > In addition, is there some kind of order of preference for
> > implementing low vs high vs max?
>
> If you implement only one allocation model, the preference would be on
> memory.low. Limits are rigid and per definition waste resources, so in
> practice we're moving away from them.

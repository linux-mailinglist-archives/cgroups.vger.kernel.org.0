Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3CBCA7398
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2019 21:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfICTXc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Sep 2019 15:23:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37622 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfICTXc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Sep 2019 15:23:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so18682275wrt.4
        for <cgroups@vger.kernel.org>; Tue, 03 Sep 2019 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zc/lNm90ymDp4B8V4zTs798Pr6EV37dROBLhjTsTKSU=;
        b=Zc7zavcNQFU8ADTRgPlLMx6fLwaAKBQg/XRCu3VX8fbASXElwghl1EY9acOcIhq4aC
         CHv3/OPtaCODa9GlQ8nufy+2dQZc6QD2DMgudKiHDyZAVRQGaDYzuquFSVgf3M4W2uMS
         WgUpLLrLM59nINI+WNDFMettOWdQX7cjFOBnex9jp6TowcTQ9jARqAD/nno9YdGwZM/2
         zpdvdqZoA5GuwxaAyvRnYjoxtxflWh1YnrzQzUZuVOWByFLYQBx6DafiV45HUhNiiWit
         xc16ITDQmYSl1VDDhB+JzeKoiYQwb0ehOWY251tcl5EZlSLMB6TzU/1VChkGiROiOWt2
         Nd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zc/lNm90ymDp4B8V4zTs798Pr6EV37dROBLhjTsTKSU=;
        b=Q3zlux79pVyF8kPQ/vO0hW1q0S7qFk9bVSoCb7u2reB1iqoXknaN6C0FjOL0orQtff
         eXwHnJPXYFlvsJi4Piy/NnItx1u1S/k/G8aHhu+W7vc6LNPF8cuZ0cdKuYZJl07GELLe
         oqdYHokSm+0tCLBKgKs/+QThQuLmYyKI7nYkvKEyuK6mFaU+aoNn6YGUMNTalXlMtCZK
         k7CQbkIe7KxOtBETRctG4onqIpjJLsUO7uzNKwE8/PcSY5n6xRsUGViTmyuZ5hozzHWr
         tYFhuksSBAHDDbopOEKv0p5Mp/1uWPufl/6MOvg0cTzF0WoiT5mDNCW2QLIvU1hfp8yt
         752Q==
X-Gm-Message-State: APjAAAUSLLGqW5mNS0+sH/TTEQ+ptu+z66BkJE0YTDojJrrCbbqr6ke4
        +sQBd+MSSj0gp98J6ee9PwqVmnTskHTotw/u9MM=
X-Google-Smtp-Source: APXvYqyr2mZhE1m/H3NhFnFGjUP9uKQIx6KLt4cttEWmWseyiid/WgTmAoK3XiIIhJYzMsEGlSzfMwq4gzPujf8nE3s=
X-Received: by 2002:adf:ef44:: with SMTP id c4mr23908279wrp.216.1567538609007;
 Tue, 03 Sep 2019 12:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190831042857.GD2263813@devbig004.ftw2.facebook.com>
 <20190903075550.GJ2112@phenom.ffwll.local> <20190903185013.GI2263813@devbig004.ftw2.facebook.com>
In-Reply-To: <20190903185013.GI2263813@devbig004.ftw2.facebook.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Tue, 3 Sep 2019 15:23:17 -0400
Message-ID: <CAOWid-fvJHyX4+S3zt5rM6pfPWQYMoi=+xKmcbODcLdYpFXduQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 00/16] new cgroup controller for gpu/drm subsystem
To:     Tejun Heo <tj@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Kenny Ho <Kenny.Ho@amd.com>,
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

Hi Tejun,

Thanks for looking into this.  I can definitely help where I can and I
am sure other experts will jump in if I start misrepresenting the
reality :) (as Daniel already have done.)

Regarding your points, my understanding is that there isn't really a
TTM vs GEM situation anymore (there is an lwn.net article about that,
but it is more than a decade old.)  I believe GEM is the common
interface at this point and more and more features are being
refactored into it.  For example, AMD's driver uses TTM internally but
things are exposed via the GEM interface.

This GEM resource is actually the single number resource you just
referred to.  A GEM buffer (the drm.buffer.* resources) can be backed
by VRAM, or system memory or other type of memory.  The more fine
grain control is the drm.memory.* resources which still need more
discussion.  (As some of the functionalities in TTM are being
refactored into the GEM level.  I have seen some patches that make TTM
a subclass of GEM.)

This RFC can be grouped into 3 areas and they are fairly independent
so they can be reviewed separately: high level device memory control
(buffer.*), fine grain memory control and bandwidth (memory.*) and
compute resources (lgpu.*)  I think the memory.* resources are the
most controversial part but I think it's still needed.

Perhaps an analogy may help.  For a system, we have CPUs and memory.
And within memory, it can be backed by RAM or swap.  For GPU, each
device can have LGPUs and buffers.  And within the buffers, it can be
backed by VRAM, or system RAM or even swap.

As for setting the right amount, I think that's where the profiling
aspect of the *.stats comes in.  And while one can't necessary buy
more VRAM, it is still a useful knob to adjust if the intention is to
pack more work into a GPU device with predictable performance.  This
research on various GPU workload may be of interest:

A Taxonomy of GPGPU Performance Scaling
http://www.computermachines.org/joe/posters/iiswc2015_taxonomy.pdf
http://www.computermachines.org/joe/publications/pdfs/iiswc2015_taxonomy.pdf

(summary: GPU workload can be memory bound or compute bound.  So it's
possible to pack different workload together to improve utilization.)

Regards,
Kenny

On Tue, Sep 3, 2019 at 2:50 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Daniel.
>
> On Tue, Sep 03, 2019 at 09:55:50AM +0200, Daniel Vetter wrote:
> > > * While breaking up and applying control to different types of
> > >   internal objects may seem attractive to folks who work day in and
> > >   day out with the subsystem, they aren't all that useful to users and
> > >   the siloed controls are likely to make the whole mechanism a lot
> > >   less useful.  We had the same problem with cgroup1 memcg - putting
> > >   control of different uses of memory under separate knobs.  It made
> > >   the whole thing pretty useless.  e.g. if you constrain all knobs
> > >   tight enough to control the overall usage, overall utilization
> > >   suffers, but if you don't, you really don't have control over actual
> > >   usage.  For memcg, what has to be allocated and controlled is
> > >   physical memory, no matter how they're used.  It's not like you can
> > >   go buy more "socket" memory.  At least from the looks of it, I'm
> > >   afraid gpu controller is repeating the same mistakes.
> >
> > We do have quite a pile of different memories and ranges, so I don't
> > thinkt we're doing the same mistake here. But it is maybe a bit too
>
> I see.  One thing which caught my eyes was the system memory control.
> Shouldn't that be controlled by memcg?  Is there something special
> about system memory used by gpus?
>
> > complicated, and exposes stuff that most users really don't care about.
>
> Could be from me not knowing much about gpus but definitely looks too
> complex to me.  I don't see how users would be able to alloate, vram,
> system memory and GART with reasonable accuracy.  memcg on cgroup2
> deals with just single number and that's already plenty challenging.
>
> Thanks.
>
> --
> tejun

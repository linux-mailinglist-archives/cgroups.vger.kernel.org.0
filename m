Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6DE157BC3
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 08:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfF0GL6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 02:11:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39622 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0GL6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jun 2019 02:11:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so5873798edv.6
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 23:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zDIpKnvYiVCYTejTV37QRzi1CxIsLmfrZczH31ThNLQ=;
        b=li1ctxapcS+exZVZnmTZPY3ffXSkif3dqdeoEc1N+OG/3CeSucNO2/99/DeKWAtT7+
         btmMtY/d08vyrmNG/2cfBUlfF+xzX+tEzUQZ0YRdGoZyi8vL2ura8uacvfpCwVp/rIec
         5viyu0Wb9T4xbQzWorf/NvRaH9OMIiT2NrrZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zDIpKnvYiVCYTejTV37QRzi1CxIsLmfrZczH31ThNLQ=;
        b=qmB6Pcwn12mvY5ZjtjSrRPszcgXlE3pmKihcvsimVu9F4xXuOW2mcPXPgJ8viNuWqe
         3h6Ns1PYpKzxPzEIpOa2ChZfPO59NWdla9c10WHA1pSrCh+kZ8LJe9ATniel+w5tu2ZO
         YzpHYc5Amtr7p8MwXDpteeI3GzCT2xrnCW0w2VDePR99GB9TAZ5+qnM2OgrL1brFexka
         uQpcbCGDvDh2t7Pug8MS61m+GB+qeutaba94HnoEoZZztNVJj1DbnLiiO4nogYne8BOS
         u/1tw+q2nYXnOY+FB1XZhg0KNdF5c8rzZeIkaRaYOU0nHdoB15q11OgrFM4Bxa8A/GQ3
         Psig==
X-Gm-Message-State: APjAAAWFqQfKlpKESl0zSqj4yt+GWFFk+vTM8sZ91ClazpQYHhzHI/HA
        HeS8YY+EAnN+8CZP/DEqXbqm7Q==
X-Google-Smtp-Source: APXvYqwYdBqBILsPoUpP28pLBsiLfE0SukeJRv2ra43KJpvQDaTlcWtMAP7L/P/7mMHkwrWJbdpBkA==
X-Received: by 2002:aa7:d297:: with SMTP id w23mr1976958edq.128.1561615916302;
        Wed, 26 Jun 2019 23:11:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f24sm417863edf.30.2019.06.26.23.11.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 23:11:55 -0700 (PDT)
Date:   Thu, 27 Jun 2019 08:11:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Kenny Ho <Kenny.Ho@amd.com>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 09/11] drm, cgroup: Add per cgroup bw measure and
 control
Message-ID: <20190627061153.GD12905@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-10-Kenny.Ho@amd.com>
 <20190626162554.GU12905@phenom.ffwll.local>
 <CAOWid-dO5QH4wLyN_ztMaoZtLM9yzw-FEMgk3ufbh1ahHJ2vVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOWid-dO5QH4wLyN_ztMaoZtLM9yzw-FEMgk3ufbh1ahHJ2vVg@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 27, 2019 at 12:34:05AM -0400, Kenny Ho wrote:
> On Wed, Jun 26, 2019 at 12:25 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Jun 26, 2019 at 11:05:20AM -0400, Kenny Ho wrote:
> > > The bandwidth is measured by keeping track of the amount of bytes moved
> > > by ttm within a time period.  We defined two type of bandwidth: burst
> > > and average.  Average bandwidth is calculated by dividing the total
> > > amount of bytes moved within a cgroup by the lifetime of the cgroup.
> > > Burst bandwidth is similar except that the byte and time measurement is
> > > reset after a user configurable period.
> >
> > So I'm not too sure exposing this is a great idea, at least depending upon
> > what you're trying to do with it. There's a few concerns here:
> >
> > - I think bo movement stats might be useful, but they're not telling you
> >   everything. Applications can also copy data themselves and put buffers
> >   where they want them, especially with more explicit apis like vk.
> >
> > - which kind of moves are we talking about here? Eviction related bo moves
> >   seem not counted here, and if you have lots of gpus with funny
> >   interconnects you might also get other kinds of moves, not just system
> >   ram <-> vram.
> Eviction move is counted but I think I placed the delay in the wrong
> place (the tracking of byte moved is in previous patch in
> ttm_bo_handle_move_mem, which is common to all move as far as I can
> tell.)
> 
> > - What happens if we slow down, but someone else needs to evict our
> >   buffers/move them (ttm is atm not great at this, but Christian König is
> >   working on patches). I think there's lots of priority inversion
> >   potential here.
> >
> > - If the goal is to avoid thrashing the interconnects, then this isn't the
> >   full picture by far - apps can use copy engines and explicit placement,
> >   again that's how vulkan at least is supposed to work.
> >
> > I guess these all boil down to: What do you want to achieve here? The
> > commit message doesn't explain the intended use-case of this.
> Thrashing prevention is the intent.  I am not familiar with Vulkan so
> I will have to get back to you on that.  I don't know how those
> explicit placement translate into the kernel.  At this stage, I think
> it's still worth while to have this as a resource even if some
> applications bypass the kernel.  I certainly welcome more feedback on
> this topic.

The trouble with thrashing prevention like this is that either you don't
limit all the bo moves, and then you don't count everything. Or you limit
them all, and then you create priority inversions in the ttm eviction
handler, essentially rate-limiting everyone who's thrashing. Or at least
you run the risk of that happening.

Not what you want I think :-)

I also think that the blkcg people are still trying to figure out how to
make this work fully reliable (it's the same problem really), and a
critical piece is knowing/estimating the overall bandwidth. Without that
the admin can't really do something meaningful. The problem with that is
you don't know, not just because of vk, but any userspace that has buffers
in the pci gart uses the same interconnect just as part of its rendering
job. So if your goal is to guaranteed some minimal amount of bo move
bandwidth, then this wont work, because you have no idea how much bandwith
there even is for bo moves.

Getting thrashing limited is very hard.

I feel like a better approach would by to add a cgroup for the various
engines on the gpu, and then also account all the sdma (or whatever the
name of the amd copy engines is again) usage by ttm_bo moves to the right
cgroup. I think that's a more meaningful limitation. For direct thrashing
control I think there's both not enough information available in the
kernel (you'd need some performance counters to watch how much bandwidth
userspace batches/CS are wasting), and I don't think the ttm eviction
logic is ready to step over all the priority inversion issues this will
bring up. Managing sdma usage otoh will be a lot more straightforward (but
still has all the priority inversion problems, but in the scheduler that
might be easier to fix perhaps with the explicit dependency graph - in the
i915 scheduler we already have priority boosting afaiui).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

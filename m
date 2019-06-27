Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C126057BB1
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 08:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfF0GBU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 02:01:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43750 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0GBT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jun 2019 02:01:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id e3so5826872edr.10
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 23:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=25Oe2d3WCzWTQdi4EmaWIZ1elA6XVFDY/UbbQcTZPgA=;
        b=irh7a2Lcdij9HgxBwi7J2xacmCC+ceo+cVADHaIq5ovmq5GjpHlsm027Nuoo/2+KhJ
         MIupYJ3mCZA1W1B0Xa0w81Lq8qGVFCZ0HKCjKrOes8SE74v0+TQYSK9+vkGIZnEQZPNe
         xqBcnsigt4UTFpODPW6hWjkpjTSj3LRD0MkOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=25Oe2d3WCzWTQdi4EmaWIZ1elA6XVFDY/UbbQcTZPgA=;
        b=rWHPrmb9oox9BFmLYTWL3CDj9Rq17clvPtw4Vhwe5j6yckF7esxJ077/axy9jm4ZZd
         dtIYwigKU1DH2vDFkIaPFlmPq6UW9fp3YSbmGcix9WYtTTpMdHTI8bXEARL4kjIKnCO4
         laa/i5pNpUwsjtgANKdsu/isUuDmWjhjyegEuYHJ2dyoEuByjLWFkHWY+59KVlQtfA6X
         PR9D9mjWtaZ8HmzAhHKsVUsJMlHdScC5eiiBZtdyv/wu1CRYSwc+FXbJX8qG5Uh4Nydr
         ICJjWii3yZbhJOYx/0LBc2a7DI5kKF3VWxZFckyIcoEFhyXcvz9i+lfzd/W05IC3SMom
         lsZw==
X-Gm-Message-State: APjAAAXCu8toTiAzweQdTNG+tWwEog3D5Y2KxqQkLt3uv2HImpL9IFMA
        jMscIRL7jlKMv0goPEKwR3D9MA==
X-Google-Smtp-Source: APXvYqyERhsA6Z0GG7Jfi+y8iUQQTuScqGEt6KUNiq6nC8M0hV2GnIfWg1B8k2KCjGjx6Bk5Q7Uo/w==
X-Received: by 2002:a50:8dcb:: with SMTP id s11mr1908937edh.144.1561615277507;
        Wed, 26 Jun 2019 23:01:17 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g16sm395021edc.76.2019.06.26.23.01.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 23:01:16 -0700 (PDT)
Date:   Thu, 27 Jun 2019 08:01:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Brian Welty <brian.welty@intel.com>, kraxel@redhat.com,
        Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 07/11] drm, cgroup: Add TTM buffer allocation stats
Message-ID: <20190627060113.GC12905@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-8-Kenny.Ho@amd.com>
 <20190626161254.GS12905@phenom.ffwll.local>
 <CAOWid-f3kKnM=4oC5Bba5WW5WNV2MH5PvVamrhO6LBr5ydPJQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-f3kKnM=4oC5Bba5WW5WNV2MH5PvVamrhO6LBr5ydPJQg@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 27, 2019 at 12:06:13AM -0400, Kenny Ho wrote:
> On Wed, Jun 26, 2019 at 12:12 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Jun 26, 2019 at 11:05:18AM -0400, Kenny Ho wrote:
> > > drm.memory.stats
> > >         A read-only nested-keyed file which exists on all cgroups.
> > >         Each entry is keyed by the drm device's major:minor.  The
> > >         following nested keys are defined.
> > >
> > >           ======         =============================================
> > >           system         Host/system memory
> >
> > Shouldn't that be covered by gem bo stats already? Also, system memory is
> > definitely something a lot of non-ttm drivers want to be able to track, so
> > that needs to be separate from ttm.
> The gem bo stats covers all of these type.  I am treat the gem stats
> as more of the front end and a hard limit and this set of stats as the
> backing store which can be of various type.  How does non-ttm drivers
> identify various memory types?

Not explicitly, they generally just have one. I think i915 currently has
two, system and carveout (with vram getting added).

> > >           tt             Host memory used by the drm device (GTT/GART)
> > >           vram           Video RAM used by the drm device
> > >           priv           Other drm device, vendor specific memory
> >
> > So what's "priv". In general I think we need some way to register the
> > different kinds of memory, e.g. stuff not in your list:
> >
> > - multiple kinds of vram (like numa-style gpus)
> > - cma (for all those non-ttm drivers that's a big one, it's like system
> >   memory but also totally different)
> > - any carveouts and stuff
> privs are vendor specific, which is why I have truncated it.  For
> example, AMD has AMDGPU_PL_GDS, GWS, OA
> https://elixir.bootlin.com/linux/v5.2-rc6/source/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h#L30
> 
> Since we are using keyed file type, we should be able to support
> vendor specific memory type but I am not sure if this is acceptable to
> cgroup upstream.  This is why I stick to the 3 memory type that is
> common across all ttm drivers.

I think we'll need custom memory pools, not just priv, and I guess some
naming scheme for them. I think just exposing them as amd-gws, amd-oa,
amd-gds would make sense.

Another thing I wonder about is multi-gpu cards, with multiple gpus and
each their own vram and other device-specific resources. For those we'd
have node0.vram and node1.vram too (on top of maybe an overall vram node,
not sure).

> > I think with all the ttm refactoring going on I think we need to de-ttm
> > the interface functions here a bit. With Gerd Hoffmans series you can just
> > use a gem_bo pointer here, so what's left to do is have some extracted
> > structure for tracking memory types. I think Brian Welty has some ideas
> > for this, even in patch form. Would be good to keep him on cc at least for
> > the next version. We'd need to explicitly hand in the ttm_mem_reg (or
> > whatever the specific thing is going to be).
> 
> I assume Gerd Hoffman's series you are referring to is this one?
> https://www.spinics.net/lists/dri-devel/msg215056.html

There's a newer one, much more complete, but yes that's the work.

> I can certainly keep an eye out for Gerd's refactoring while
> refactoring other parts of this RFC.
> 
> I have added Brian and Gerd to the thread for awareness.

btw just realized that maybe building the interfaces on top of ttm_mem_reg
is maybe not the best. That's what you're using right now, but in a way
that's just the ttm internal detail of how the backing storage is
allocated. I think the structure we need to abstract away is
ttm_mem_type_manager, without any of the actual management details.

btw reminds me: I guess it would be good to have a per-type .total
read-only exposed, so that userspace has an idea of how much there is?
ttm is trying to be agnostic to the allocator that's used to manage a
memory type/resource, so doesn't even know that. But I think something we
need to expose to admins, otherwise they can't meaningfully set limits.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

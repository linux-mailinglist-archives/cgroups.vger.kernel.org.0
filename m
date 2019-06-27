Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960BB57A66
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 06:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfF0EG1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 00:06:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36114 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0EG1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jun 2019 00:06:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so760211wrs.3
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 21:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNi33UsrcZabG2rtkEFPJo5DLbTb5NiEUTMbPl3SZiY=;
        b=ZJKgpHwHD/1e5tsbu0ItQYlEY4jZC0lTNEz5tt6LD3YfMeKWvBbANkR/8canqSYoqp
         TjfUjPVh5FWrbTtsM/b3h80D49l8V6iOVnz8zbUnNNG+lb4o2zT7AjvU55CKOihBKAhI
         2xjFVH4s5eUPw8My4SajXq/O0bnynwOW2FaORTXMcSm/62fmDosRUYX0d4yx5PjZjK0L
         KmijQUGbTH7l4kVzavshTjq8Ec7FQyv2z2+nAcS6vMdvhutWiRiBFLlL6MO4ms+nbwyz
         chrubA4NhImXhZGg+1KIovgikA34eOUTuLWgJb2poqn6xr35Jm+D7jii/3C2jkVhhHE7
         O4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNi33UsrcZabG2rtkEFPJo5DLbTb5NiEUTMbPl3SZiY=;
        b=WfVJCH1PmWRNF2pQFxZWEgYIw706Udl6xKQebOavmZ2kM+EctSZOR6VAk6utSH9464
         X7PV8xqZFZlJXgQWASkM5WH8NOJe/QdVrxVVxOKthzSPGqct1nnTuxFhcdT+3cZRj/Va
         DETw1YLn9f39PwM3y8HvTVQhISBUCcshlGFqiWarT/wMUBXmSyIiXXzoJvfZubh9G7MJ
         5IUL9Xm8ewlz4bBtoa8U7ibGsq4X+p7Y0z7ivC1z0e23eWMcaY78e2VAHUGGXorrOLqR
         BDDXwud+jaS+1ByFgffGGhQ3dBCWGaUkMtKwh1W/PNRhmA/k7vsWOQ8ZSuvmQhLzv5NI
         rVmg==
X-Gm-Message-State: APjAAAXxZQ93hcVPL5qIcm/6dHuYhYj1rPdmo/cEH5PAMbSkezB95owH
        S3bZKa4iMgx4C6dNqQT3q2mrQwv91sHmaem0yn8=
X-Google-Smtp-Source: APXvYqw86bLPt4ODs+Zzk5ysYoOIt0guhmnBh3NUxccT3laCdm0JKQEWDvbao2XiWiRQ/jafWP1jF07OVnjQoqYa+94=
X-Received: by 2002:a05:6000:11cc:: with SMTP id i12mr1051293wrx.243.1561608384892;
 Wed, 26 Jun 2019 21:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-8-Kenny.Ho@amd.com>
 <20190626161254.GS12905@phenom.ffwll.local>
In-Reply-To: <20190626161254.GS12905@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 27 Jun 2019 00:06:13 -0400
Message-ID: <CAOWid-f3kKnM=4oC5Bba5WW5WNV2MH5PvVamrhO6LBr5ydPJQg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 07/11] drm, cgroup: Add TTM buffer allocation stats
To:     Daniel Vetter <daniel@ffwll.ch>,
        Brian Welty <brian.welty@intel.com>, kraxel@redhat.com
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 12:12 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Jun 26, 2019 at 11:05:18AM -0400, Kenny Ho wrote:
> > drm.memory.stats
> >         A read-only nested-keyed file which exists on all cgroups.
> >         Each entry is keyed by the drm device's major:minor.  The
> >         following nested keys are defined.
> >
> >           ======         =============================================
> >           system         Host/system memory
>
> Shouldn't that be covered by gem bo stats already? Also, system memory is
> definitely something a lot of non-ttm drivers want to be able to track, so
> that needs to be separate from ttm.
The gem bo stats covers all of these type.  I am treat the gem stats
as more of the front end and a hard limit and this set of stats as the
backing store which can be of various type.  How does non-ttm drivers
identify various memory types?

> >           tt             Host memory used by the drm device (GTT/GART)
> >           vram           Video RAM used by the drm device
> >           priv           Other drm device, vendor specific memory
>
> So what's "priv". In general I think we need some way to register the
> different kinds of memory, e.g. stuff not in your list:
>
> - multiple kinds of vram (like numa-style gpus)
> - cma (for all those non-ttm drivers that's a big one, it's like system
>   memory but also totally different)
> - any carveouts and stuff
privs are vendor specific, which is why I have truncated it.  For
example, AMD has AMDGPU_PL_GDS, GWS, OA
https://elixir.bootlin.com/linux/v5.2-rc6/source/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h#L30

Since we are using keyed file type, we should be able to support
vendor specific memory type but I am not sure if this is acceptable to
cgroup upstream.  This is why I stick to the 3 memory type that is
common across all ttm drivers.

> I think with all the ttm refactoring going on I think we need to de-ttm
> the interface functions here a bit. With Gerd Hoffmans series you can just
> use a gem_bo pointer here, so what's left to do is have some extracted
> structure for tracking memory types. I think Brian Welty has some ideas
> for this, even in patch form. Would be good to keep him on cc at least for
> the next version. We'd need to explicitly hand in the ttm_mem_reg (or
> whatever the specific thing is going to be).

I assume Gerd Hoffman's series you are referring to is this one?
https://www.spinics.net/lists/dri-devel/msg215056.html

I can certainly keep an eye out for Gerd's refactoring while
refactoring other parts of this RFC.

I have added Brian and Gerd to the thread for awareness.

Regards,
Kenny

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAA657AAD
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 06:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfF0EeS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 00:34:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35926 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfF0EeS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jun 2019 00:34:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so808395wrs.3
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 21:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E7QHphyO5PnY4i5UMFD/blTa6mTFJJf0E1PIuwNj1uo=;
        b=V5RV1ENXG2g7JfwKywkW8Gco79F4aTFWh0rqr8JLlEyOrDzXt4UYQd9iE0VWGxYInD
         pUEiUwKRnAL7Z8+f2IQy0w0v2K70595L62s/R/+3/SE3uAHPNnjm7SG79QGSvqg3hpn3
         YhNMG/cnXMMnptzlyW7wsjoQqt/2T5GpjIrldNXLaLsA1HtmkrCaqNZl9PE8H17bTNzD
         2auJQqGaGYXQ4kKivNt6lnAf4KvVf6oRfVQ5c8gF/Xfmo3K8TYE+6tAoajjphrUcr4Af
         swiqHK0zzEsteaufrOHOWQGzZ8RBIR6JhrH6StkkcgttRdlxcDC5V4+9FWx7Bop4MkF/
         a63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E7QHphyO5PnY4i5UMFD/blTa6mTFJJf0E1PIuwNj1uo=;
        b=cJgHL84hYEBR54ZmV6Ex0IDxTv+IPoyqCRfl6m8q/c3Lbfi+6OOB4t8vdweq6Mm7O6
         vyv6AK2NwIkddjNtikOyWuPeI44X+0gC2dFnmkwF3i3eL6wXDLJAB9IPkPJDKke3GkNW
         ib1F3AuAcyjJ6HfaXWLNaAPYMa8qtxpFoM4cRDWMnDZMnzXTySmHYWKZ63rtQVC0cuPj
         qSvYVc0egJYMdDVN9Ec302vBBYEYQT+BarjeDJMBq3+E5iIVb8GvXIgF61u7iamHmOc3
         ALO5D0j6as1l489AXdmin627tVphFxJs/qvOOFBOLyrAJ+o/XAr822bc6EG8ginhyr9u
         5llw==
X-Gm-Message-State: APjAAAWStyDkH53kBaN3lenO+w5AyY4zzwKbv1vk/hOW2xsrSrzDJ3A8
        HrCHdGmEtnaVFNK/GboXsj8NXMGirY30PdIMwnE=
X-Google-Smtp-Source: APXvYqxYLRW1sFcU9pZiZzP6dnH38+00jfMSQbSYnZSajM7ezaAYPUZ1yQkDPFs5Gjbay3iOHo9OdxuqZ9cwcxqjGJQ=
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr1183346wrn.216.1561610056661;
 Wed, 26 Jun 2019 21:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-10-Kenny.Ho@amd.com>
 <20190626162554.GU12905@phenom.ffwll.local>
In-Reply-To: <20190626162554.GU12905@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 27 Jun 2019 00:34:05 -0400
Message-ID: <CAOWid-dO5QH4wLyN_ztMaoZtLM9yzw-FEMgk3ufbh1ahHJ2vVg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/11] drm, cgroup: Add per cgroup bw measure and control
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 12:25 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Jun 26, 2019 at 11:05:20AM -0400, Kenny Ho wrote:
> > The bandwidth is measured by keeping track of the amount of bytes moved
> > by ttm within a time period.  We defined two type of bandwidth: burst
> > and average.  Average bandwidth is calculated by dividing the total
> > amount of bytes moved within a cgroup by the lifetime of the cgroup.
> > Burst bandwidth is similar except that the byte and time measurement is
> > reset after a user configurable period.
>
> So I'm not too sure exposing this is a great idea, at least depending upo=
n
> what you're trying to do with it. There's a few concerns here:
>
> - I think bo movement stats might be useful, but they're not telling you
>   everything. Applications can also copy data themselves and put buffers
>   where they want them, especially with more explicit apis like vk.
>
> - which kind of moves are we talking about here? Eviction related bo move=
s
>   seem not counted here, and if you have lots of gpus with funny
>   interconnects you might also get other kinds of moves, not just system
>   ram <-> vram.
Eviction move is counted but I think I placed the delay in the wrong
place (the tracking of byte moved is in previous patch in
ttm_bo_handle_move_mem, which is common to all move as far as I can
tell.)

> - What happens if we slow down, but someone else needs to evict our
>   buffers/move them (ttm is atm not great at this, but Christian K=C3=B6n=
ig is
>   working on patches). I think there's lots of priority inversion
>   potential here.
>
> - If the goal is to avoid thrashing the interconnects, then this isn't th=
e
>   full picture by far - apps can use copy engines and explicit placement,
>   again that's how vulkan at least is supposed to work.
>
> I guess these all boil down to: What do you want to achieve here? The
> commit message doesn't explain the intended use-case of this.
Thrashing prevention is the intent.  I am not familiar with Vulkan so
I will have to get back to you on that.  I don't know how those
explicit placement translate into the kernel.  At this stage, I think
it's still worth while to have this as a resource even if some
applications bypass the kernel.  I certainly welcome more feedback on
this topic.

Regards,
Kenny

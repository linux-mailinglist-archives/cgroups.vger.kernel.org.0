Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D9F15F6AB
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 20:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbgBNTR5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 14:17:57 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39072 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387603AbgBNTR4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 14:17:56 -0500
Received: by mail-qt1-f196.google.com with SMTP id c5so7690929qtj.6
        for <cgroups@vger.kernel.org>; Fri, 14 Feb 2020 11:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2bDv0jVyoaqUAZCYtXw4PRnG3vvu6ogXS+PiWyXVnGQ=;
        b=ogbXgW9ewuGmJIGKdp7mK1xwjaEV448C9wRMZUb/UpM2qUxfj6kQmQ8YI/6OYFAoQ1
         luR+o1V+KBIaQyMsIVJNs0bEdQ9gHJQmqWJLN2W6XvGxC3T1Z35sfCCMib3C/wFp3sdc
         9Zxk6HrtSWgYljyCwbvwgny/YallHX+aY27ZMvcxno9Ox80WA0Un+eIfVBjDFqHiWKli
         2Jnls9HUxdWYnq57CdVGXws1lZjKaPqhnYv/yqvp3BD/NRNVpfaItfjgME/elE4BRKHx
         WHJWRHi9qIM7yRhB+1p808k+sKqB/KTo7wZR+FVlSs2JDxfOvrErluaL32I9aia9AN3j
         GxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2bDv0jVyoaqUAZCYtXw4PRnG3vvu6ogXS+PiWyXVnGQ=;
        b=TP/s9iN2RR4BDpbyTIJHHMfBbijm0u3IJOzE2PMFJltQaTDSCW5/ojkgjwBa48KuUB
         laPhlpuh97QlFIGyedmSM51CEjafOgPMpaGyuwduZxd06uQ76oSBWATXaVv3j+wxXdMZ
         0pjmqDwG8HsZvNdOxO5iBeUkeKMPCKlYV4wyClb8tY4mWA71ZJ5kb1Hg1IlY00RQ0i5w
         EFaEsEHmOEYYx4l4sYvOzVZptoVvIzoPYPouKG14msHBaeH6aKlQxW3F0zCNOSSwQhou
         XPoYNaA64TrrFxeMOJSK0A2sgCWrPLN8giAqG0f3B4GfT/UCtTYGbf4+XCgraiVTDQGR
         W/TA==
X-Gm-Message-State: APjAAAVcLPP8pv+gGHLUDThi5Hirlexyhq6YhM5G10rZ8s+2uvgQJDCu
        bGv4Eb+eXtQxXkdUn/xUz34=
X-Google-Smtp-Source: APXvYqytUjdeIbKwbQxd6Th0soZnJasR/yjL1sgiAE3JeOhzZ+blcMoyfUQzZmkjOfux0H13K1BulQ==
X-Received: by 2002:ac8:4446:: with SMTP id m6mr3902660qtn.159.1581707875654;
        Fri, 14 Feb 2020 11:17:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::e8a3])
        by smtp.gmail.com with ESMTPSA id g11sm2293790qtc.48.2020.02.14.11.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 11:17:54 -0800 (PST)
Date:   Fri, 14 Feb 2020 14:17:54 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com, nirmoy.das@amd.com, damon.mcdougall@amd.com,
        juan.zuniga-anaya@amd.com, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 09/11] drm, cgroup: Introduce lgpu as DRM cgroup resource
Message-ID: <20200214191754.GA218629@mtj.thefacebook.com>
References: <20200214155650.21203-1-Kenny.Ho@amd.com>
 <20200214155650.21203-10-Kenny.Ho@amd.com>
 <CAOFGe96N5gG+08rQCRC+diHKDAfxPFYEnVxDS8_udvjcBYgsPg@mail.gmail.com>
 <CAOWid-f62Uv=GZXX2V2BsQGM5A1JJG_qmyrOwd=KwZBx_sr-bg@mail.gmail.com>
 <20200214183401.GY2363188@phenom.ffwll.local>
 <CAOWid-caJHeXUnQv3MOi=9U+vdBLfewN+CrA-7jRrz0VXqatbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-caJHeXUnQv3MOi=9U+vdBLfewN+CrA-7jRrz0VXqatbQ@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Kenny, Daniel.

(cc'ing Johannes)

On Fri, Feb 14, 2020 at 01:51:32PM -0500, Kenny Ho wrote:
> On Fri, Feb 14, 2020 at 1:34 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > I think guidance from Tejun in previos discussions was pretty clear that
> > he expects cgroups to be both a) standardized and c) sufficient clear
> > meaning that end-users have a clear understanding of what happens when
> > they change the resource allocation.
> >
> > I'm not sure lgpu here, at least as specified, passes either.
> 
> I disagree (at least on the characterization of the feedback
> provided.)  I believe this series satisfied the sprite of Tejun's
> guidance so far (the weight knob for lgpu, for example, was
> specifically implemented base on his input.)  But, I will let Tejun
> speak for himself after he considered the implementation in detail.

I have to agree with Daniel here. My apologies if I weren't clear
enough. Here's one interface I can think of:

 * compute weight: The same format as io.weight. Proportional control
   of gpu compute.

 * memory low: Please see how the system memory.low behaves. For gpus,
   it'll need per-device entries.

Note that for both, there one number to configure and conceptually
it's pretty clear to everybody what that number means, which is not to
say that it's clear to implement but it's much better to deal with
that on this side of the interface than the other.

cc'ing Johannes. Do you have anything on mind regarding how gpu memory
configuration should look like? e.g. should it go w/ weights rather
than absoulte units (I don't think so given that it'll most likely
need limits at some point too but still and there are benefits from
staying consistent with system memory).

Also, a rather trivial high level question. Is drm a good controller
name given that other controller names are like cpu, memory, io?

Thanks.

-- 
tejun

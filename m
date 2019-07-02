Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 259AA5D05B
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2019 15:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfGBNRC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Jul 2019 09:17:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34698 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfGBNRC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Jul 2019 09:17:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id s49so27311831edb.1
        for <cgroups@vger.kernel.org>; Tue, 02 Jul 2019 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GjTPDe0xOLXCQ42kjksJhMQtbr7e/gOnvxffBVj5VYM=;
        b=SfkZ75kt4gYBpIqvUdeGKW/La+OD9o3pkBi2szmvwtNdrpFbBFUsOCFi3juAg1Bkqd
         nLpqW5wngRazdSCLVAeSksqThkNT5+8quj2tXn9MCNAPe1roBunYJLBd2mbzkjs7AYwk
         5wrZG2AG5O69LENVr18Ynb/lTPygEBYUM3gcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GjTPDe0xOLXCQ42kjksJhMQtbr7e/gOnvxffBVj5VYM=;
        b=nTEF4QvMTNXQ0JhBxfLzNM4O1SWQIRD1c+BTIWWGnPwRswHaNAxfWVttz2uqeGXYaM
         ihjaW+QX/32T1QZRLXk9YxPc3RIlt6rF6Zifq/yG/tfQJMr9D++xDo74fueUK9AZvAgV
         7zaH1SltIkDPNvzOjRg0G00ThuFYeKITA6Zy4IhH8ZytEtUPJSi2tkzRf8nIqjVM5spG
         juc7M89YoZu2+ma0VbDx5hmSXcWnlLgJgEocN6BIo/AbJD1A8D9k0t+93wPK7kv54i/V
         immrwZLARwPDaIPlN8OOH8VoGgbcOLapOc0oPC6zHugH0p1tc7+CsDQdf/yHqXq7iUmY
         cVRA==
X-Gm-Message-State: APjAAAVhFlwUn5HxBr9fgTNmFW7JCGSNOkA4o/roBGwaGHBnCW2wb/OY
        ZCJZJQchoV5/4KVmMltKLLddIw==
X-Google-Smtp-Source: APXvYqwROZlY4NhAUER24ig3V40kY5agwqbJ1sX3D63fvIeUb5fnhe+PrRVXP4NrOQjSehPxanpEtg==
X-Received: by 2002:a50:9157:: with SMTP id f23mr34902455eda.79.1562073420063;
        Tue, 02 Jul 2019 06:17:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a3sm2736724ejn.64.2019.07.02.06.16.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 06:16:58 -0700 (PDT)
Date:   Tue, 2 Jul 2019 15:16:51 +0200
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
Subject: Re: [RFC PATCH v3 04/11] drm, cgroup: Add total GEM buffer
 allocation limit
Message-ID: <20190702131651.GA15868@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-5-Kenny.Ho@amd.com>
 <20190626160553.GR12905@phenom.ffwll.local>
 <CAOWid-eurCMx1F7ciUwx0e+p=s=NP8=UxQUhhF-hdK-iAna+fA@mail.gmail.com>
 <20190626214113.GA12905@phenom.ffwll.local>
 <CAOWid-egYGijS0a6uuG4mPUmOWaPwF-EKokR=LFNJ=5M+akVZw@mail.gmail.com>
 <20190627054320.GB12905@phenom.ffwll.local>
 <CAOWid-cT4TQ7HGzcSWjmLGjAW_D1hRrkNguEiV8N+baNiKQm_A@mail.gmail.com>
 <20190627212401.GO12905@phenom.ffwll.local>
 <CAOWid-dZQhpKHxYEFn+X+WSep+B66M_LtN6v0=4-uO3ecZ0pcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-dZQhpKHxYEFn+X+WSep+B66M_LtN6v0=4-uO3ecZ0pcg@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 28, 2019 at 02:43:18PM -0400, Kenny Ho wrote:
> On Thu, Jun 27, 2019 at 5:24 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Thu, Jun 27, 2019 at 02:42:43PM -0400, Kenny Ho wrote:
> > > Um... I am going to get a bit philosophical here and suggest that the
> > > idea of sharing (especially uncontrolled sharing) is inherently at odd
> > > with containment.  It's like, if everybody is special, no one is
> > > special.  Perhaps an alternative is to make this configurable so that
> > > people can allow sharing knowing the caveat?  And just to be clear,
> > > the current solution allows for sharing, even between cgroup.
> >
> > The thing is, why shouldn't we just allow it (with some documented
> > caveat)?
> >
> > I mean if all people do is share it as your current patches allow, then
> > there's nothing funny going on (at least if we go with just leaking the
> > allocations). If we allow additional sharing, then that's a plus.
> Um... perhaps I was being overly conservative :).  So let me
> illustrate with an example to add more clarity and get more comments
> on it.
> 
> Let say we have the following cgroup hierarchy (The letters are
> cgroups with R being the root cgroup.  The numbers in brackets are
> processes.  The processes are placed with the 'No Internal Process
> Constraint' in mind.)
> R (4, 5) ------ A (6)
>   \
>     B ---- C (7,8)
>      \
>        D (9)
> 
> Here is a list of operation and the associated effect on the size
> track by the cgroups (for simplicity, each buffer is 1 unit in size.)
> With current implementation (charge on buffer creation with
> restriction on sharing.)
> R   A   B   C   D   |Ops
> ================
> 1   0   0   0   0   |4 allocated a buffer
> 1   0   0   0   0   |4 shared a buffer with 5
> 1   0   0   0   0   |4 shared a buffer with 9
> 2   0   1   0   1   |9 allocated a buffer
> 3   0   2   1   1   |7 allocated a buffer
> 3   0   2   1   1   |7 shared a buffer with 8
> 3   0   2   1   1   |7 sharing with 9 (not allowed)
> 3   0   2   1   1   |7 sharing with 4 (not allowed)
> 3   0   2   1   1   |7 release a buffer
> 2   0   1   0   1   |8 release a buffer from 7

This is your current implementation, right? Let's call it A.

> The suggestion as I understand it (charge per buffer reference with
> unrestricted sharing.)
> R   A   B   C   D   |Ops
> ================
> 1   0   0   0   0   |4 allocated a buffer
> 2   0   0   0   0   |4 shared a buffer with 5
> 3   0   0   0   1   |4 shared a buffer with 9
> 4   0   1   0   2   |9 allocated a buffer
> 5   0   2   1   1   |7 allocated a buffer
> 6   0   3   2   1   |7 shared a buffer with 8
> 7   0   4   2   2   |7 sharing with 9
> 8   0   4   2   2   |7 sharing with 4
> 7   0   3   1   2   |7 release a buffer
> 6   0   2   0   2   |8 release a buffer from 7
> 
> Is this a correct understanding of the suggestion?

Yup that's one option I think. The other option (and it's probably
simpler), is to go with your current accounting, but drop the sharing
restriction. I.e. buffers are accounting to whomever allocates them first,
not who's all using them. For memcg this has some serious trouble with
cgroups not getting cleaned up due to leaked refrences. But for gem bo we
spread the references in a lot more controlled manner, and all the
long-lived references are under control of userspace.

E.g. if Xorg fails to clean up bo references of clients that dead, that's
clearly an Xorg bug and needs to be fixed there. But not something we need
to allow as a valid use-cases. For page references/accounting in memcg
this is totally different, since pages can survive in the pagecache
forever. No such bo-cache or anything similar exists for gem_bo.

Personally I prefer option A, but on sharing restriction. If you want that
sharing restriction, we need to figure out how to implement it using
something else. Plus we need to make sure all possible ways to share a bo
are covered (and there are many).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

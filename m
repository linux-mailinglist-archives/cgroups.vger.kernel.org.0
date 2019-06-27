Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7843558CF7
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 23:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfF0VYI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 17:24:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36944 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0VYH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jun 2019 17:24:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so8514487eds.4
        for <cgroups@vger.kernel.org>; Thu, 27 Jun 2019 14:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=otHtNJ6XLOlqZhPeIZirZt2keyMHruR4+iS1eoOobto=;
        b=kNeFqqMqfMBdZri2sH0kJAocN+E8lfihTK+M/U6SK0NgfxgWCK1SGsCZ4fGLjuhBhM
         CHFMqqyUM1a/5FkmRyVjoS2DoMw/tRhLIR6a4dZTa6EKC0M3keg3WYaJr4D2GtBNN4Xi
         iuYeXFVjumXstv1Zal9DgGXumRSGIczDQjHyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=otHtNJ6XLOlqZhPeIZirZt2keyMHruR4+iS1eoOobto=;
        b=IGJjrFT23Bb0u64u0ZzkeercXIhlReYneEpASVojZruJ5F5ygg4EuLV5GIjXWXOlx/
         PCni8P9sWX1Wqf4iK6qsHqLdK9KNr4Ze3wP3LxlV5WFD/rn7oiRpiwIfyTsdQ7B/oU3e
         2jHfInu4llmsih0LER4NoIDCdBksendEdGWBNZ6c30aflLy7ySR3KraHDf9Lfld+CFAO
         mDjGQGluQMYVKwhQPjTWXKg10/VnA0oEH3US4U9yG38BEbEAdbcK1zus/8Cp4Z3bqtrU
         +jBsingPQx42m7h3ZtnAZebOPGaUxOyacOq0GGPXXl5OIQmzO16cTz24Wlba5lSCgdZj
         97CQ==
X-Gm-Message-State: APjAAAVvtcK3dJVXmaVqkXbba3iS56o9f1zDmp4ixEo68K2n8WclHVzh
        tZYOQPbXnpc8jP2UKApfBg07qQ==
X-Google-Smtp-Source: APXvYqwETNiiTdBZaXEw5ryKHJMyMo/RQ0qQf1JQcQ5BdUaLTPDJWjFxLeItoJluUCiMfYYwkZHHzQ==
X-Received: by 2002:a50:b13b:: with SMTP id k56mr7312607edd.192.1561670644991;
        Thu, 27 Jun 2019 14:24:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id dc1sm40327ejb.39.2019.06.27.14.24.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 14:24:04 -0700 (PDT)
Date:   Thu, 27 Jun 2019 23:24:01 +0200
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
Message-ID: <20190627212401.GO12905@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-5-Kenny.Ho@amd.com>
 <20190626160553.GR12905@phenom.ffwll.local>
 <CAOWid-eurCMx1F7ciUwx0e+p=s=NP8=UxQUhhF-hdK-iAna+fA@mail.gmail.com>
 <20190626214113.GA12905@phenom.ffwll.local>
 <CAOWid-egYGijS0a6uuG4mPUmOWaPwF-EKokR=LFNJ=5M+akVZw@mail.gmail.com>
 <20190627054320.GB12905@phenom.ffwll.local>
 <CAOWid-cT4TQ7HGzcSWjmLGjAW_D1hRrkNguEiV8N+baNiKQm_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-cT4TQ7HGzcSWjmLGjAW_D1hRrkNguEiV8N+baNiKQm_A@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 27, 2019 at 02:42:43PM -0400, Kenny Ho wrote:
> On Thu, Jun 27, 2019 at 1:43 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Jun 26, 2019 at 06:41:32PM -0400, Kenny Ho wrote:
> > > So without the sharing restriction and some kind of ownership
> > > structure, we will have to migrate/change the owner of the buffer when
> > > the cgroup that created the buffer die before the receiving cgroup(s)
> > > and I am not sure how to do that properly at the moment.  1) Should
> > > each cgroup keep track of all the buffers that belongs to it and
> > > migrate?  (Is that efficient?)  2) which cgroup should be the new
> > > owner (and therefore have the limit applied?)  Having the creator
> > > being the owner is kind of natural, but let say the buffer is shared
> > > with 5 other cgroups, which of these 5 cgroups should be the new owner
> > > of the buffer?
> >
> > Different answers:
> >
> > - Do we care if we leak bos like this in a cgroup, if the cgroup
> >   disappears before all the bo are cleaned up?
> >
> > - Just charge the bo to each cgroup it's in? Will be quite a bit more
> >   tracking needed to get that done ...
> That seems to be the approach memcg takes, but as shown by the lwn
> link you sent me from the last rfc (talk from Roman Gushchin), that
> approach is not problem free either.  And wouldn't this approach
> disconnect resource management from the underlying resource one would
> like to control?  For example, if you have 5 MB of memory, you can
> have 5 users using 1 MB each.  But in the charge-everybody approach, a
> 1 MB usage shared 4 times will make it looks like 5MB is used.  So the
> resource being control is no longer 'real' since the amount of
> resource you have is now dynamic and depends on the amount of sharing
> one does.

The problem with memcg is that it's not just the allocation, but a ton of
memory allocated to track these allocations. At least that's my
understanding of the nature of the memcg leak. Made a lot worse by pages
being small and plentiful and shared extremely widely (e.g. it's really
hard to control who gets charged for pagecache allocations, so those
pagecache entries might outlive the memcg forever if you're unlucky).

For us it's just a counter, plus bo sharing is a lot more controlled: On
any reasonable system if you do kill the compositor, then all the clients
go down. And when you do kill a client, the compositor will release all
the shared buffers (and any other resources).

So I think for drmcg we won't have anything near the same resource leak
problem even in theory, and in practice I think the issue is none.

> > - Also, there's the legacy way of sharing a bo, with the FLINK and
> >   GEM_OPEN ioctls. We need to plug these holes too.
> >
> > Just feels like your current solution is technically well-justified, but
> > it completely defeats the point of cgroups/containers and buffer sharing
> > ...
> Um... I am going to get a bit philosophical here and suggest that the
> idea of sharing (especially uncontrolled sharing) is inherently at odd
> with containment.  It's like, if everybody is special, no one is
> special.  Perhaps an alternative is to make this configurable so that
> people can allow sharing knowing the caveat?  And just to be clear,
> the current solution allows for sharing, even between cgroup.

The thing is, why shouldn't we just allow it (with some documented
caveat)?

I mean if all people do is share it as your current patches allow, then
there's nothing funny going on (at least if we go with just leaking the
allocations). If we allow additional sharing, then that's a plus.

And if you want additional containment, that's a different thing: The
entire linux architecture for containers is that a container doesn't
exist. Instead you get a pile of building blocks that all solve different
aspects of what a container needs to do:
- cgroups for resource limits
- namespaces for resource visibility
- selinux/secomp/lsm for resource isolation and access rights

Let's not try to build a drm cgroup control that tries to do more than
what cgroups are meant to solve. If you have a need to restrict the
sharing, imo that should be done with an lsm security hook.

btw for bo sharing, I've found a 3rd sharing path (besides dma-buf and gem
flink): GETCRTC ioctl can also be used (it's the itended goal actually) to
share buffers across processes.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

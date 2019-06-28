Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E44B5A461
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2019 20:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF1Snd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jun 2019 14:43:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34958 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF1Snd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jun 2019 14:43:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so9900705wml.0
        for <cgroups@vger.kernel.org>; Fri, 28 Jun 2019 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQUhM9r4CIKRmotw4FR58r0gyvTp++xsA9JoTrGG8Uc=;
        b=Qy9LZUw5CE9q0OFvHGXplF7+5qpKs00X0FyzY3jtZrUagXfDwwdTcYnVBTglDSOji2
         WMGjVKa9BGZEuhPRNYvBSw618iq62H+vcVWW/ojjh4jFoUMLAKtXHl3lJoYmR0Vb9IlC
         nFW6+ARqt7D+4yDnoK8LcMZtyEJf2zf9GuexUTVaZzZ/j1hYF3aJJL657WTs1tFLPuYN
         V+/fLYtX9BzAOiHs6zFeYbgKC25GG4Zb2aLrK5bqxUXl0acGG6r0DUi2GESA/Hk9Amu3
         aDclm7HuDZ0yTA4twM3k7Pbe8G7sJG5v72n4jdkqMUVbUY24AqjnHLrcU0kg5G9TwkM2
         Pjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQUhM9r4CIKRmotw4FR58r0gyvTp++xsA9JoTrGG8Uc=;
        b=h12CDFezHHxSPcnIYrR0RsnVgCGyd5JxPBo3CNrVNNFgLOGUJoEo1JNIE9/DdfL5D1
         Mv4oH0ODb3wkIAHlgNhrkdpayHbX4VpV+pHCBIXT6qIzWgUh1e/AO4F0pJn38BLU7khZ
         zDW7KJd1UhPNkQHyWTnLimC9pW647euAL6fpzTuP0WibOPW/0l/jug8FCNdDPvo1qbWg
         XTf/tJ8Nli+aua+xsIxT04Qcp+sPxpg6RqyxnYYXjwctEjPdoIJlrgtdMN4a48x/NUih
         SJwbK4oR8iKn2dz1+0y6fOXjzGS0W4B9Tw6xJ9VdOvftPJEV8xhrVsyu3sS/EeDI4LfF
         4ksg==
X-Gm-Message-State: APjAAAV/eeYMtQBwWme5Lw5NPf2jJv5LaC29d7j5suMmwwhF6nsIHB8M
        GZaZq0dOt2D48Z7Y4lT9Y51Wvsebw+zKnQb09lyt6tHZS1/JvA==
X-Google-Smtp-Source: APXvYqyBJS1+omg7dVNURS337DZRB0h4Ovl7L3QvhyX2PrqzTwpRSQ3xy8VbXVr+cmFFUxnh3zcWJGf7Qhp9jaQYhYE=
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr8096000wme.29.1561747410274;
 Fri, 28 Jun 2019 11:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-5-Kenny.Ho@amd.com>
 <20190626160553.GR12905@phenom.ffwll.local> <CAOWid-eurCMx1F7ciUwx0e+p=s=NP8=UxQUhhF-hdK-iAna+fA@mail.gmail.com>
 <20190626214113.GA12905@phenom.ffwll.local> <CAOWid-egYGijS0a6uuG4mPUmOWaPwF-EKokR=LFNJ=5M+akVZw@mail.gmail.com>
 <20190627054320.GB12905@phenom.ffwll.local> <CAOWid-cT4TQ7HGzcSWjmLGjAW_D1hRrkNguEiV8N+baNiKQm_A@mail.gmail.com>
 <20190627212401.GO12905@phenom.ffwll.local>
In-Reply-To: <20190627212401.GO12905@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 28 Jun 2019 14:43:18 -0400
Message-ID: <CAOWid-dZQhpKHxYEFn+X+WSep+B66M_LtN6v0=4-uO3ecZ0pcg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/11] drm, cgroup: Add total GEM buffer allocation limit
To:     Daniel Vetter <daniel@ffwll.ch>
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

On Thu, Jun 27, 2019 at 5:24 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Jun 27, 2019 at 02:42:43PM -0400, Kenny Ho wrote:
> > Um... I am going to get a bit philosophical here and suggest that the
> > idea of sharing (especially uncontrolled sharing) is inherently at odd
> > with containment.  It's like, if everybody is special, no one is
> > special.  Perhaps an alternative is to make this configurable so that
> > people can allow sharing knowing the caveat?  And just to be clear,
> > the current solution allows for sharing, even between cgroup.
>
> The thing is, why shouldn't we just allow it (with some documented
> caveat)?
>
> I mean if all people do is share it as your current patches allow, then
> there's nothing funny going on (at least if we go with just leaking the
> allocations). If we allow additional sharing, then that's a plus.
Um... perhaps I was being overly conservative :).  So let me
illustrate with an example to add more clarity and get more comments
on it.

Let say we have the following cgroup hierarchy (The letters are
cgroups with R being the root cgroup.  The numbers in brackets are
processes.  The processes are placed with the 'No Internal Process
Constraint' in mind.)
R (4, 5) ------ A (6)
  \
    B ---- C (7,8)
     \
       D (9)

Here is a list of operation and the associated effect on the size
track by the cgroups (for simplicity, each buffer is 1 unit in size.)
With current implementation (charge on buffer creation with
restriction on sharing.)
R   A   B   C   D   |Ops
================
1   0   0   0   0   |4 allocated a buffer
1   0   0   0   0   |4 shared a buffer with 5
1   0   0   0   0   |4 shared a buffer with 9
2   0   1   0   1   |9 allocated a buffer
3   0   2   1   1   |7 allocated a buffer
3   0   2   1   1   |7 shared a buffer with 8
3   0   2   1   1   |7 sharing with 9 (not allowed)
3   0   2   1   1   |7 sharing with 4 (not allowed)
3   0   2   1   1   |7 release a buffer
2   0   1   0   1   |8 release a buffer from 7

The suggestion as I understand it (charge per buffer reference with
unrestricted sharing.)
R   A   B   C   D   |Ops
================
1   0   0   0   0   |4 allocated a buffer
2   0   0   0   0   |4 shared a buffer with 5
3   0   0   0   1   |4 shared a buffer with 9
4   0   1   0   2   |9 allocated a buffer
5   0   2   1   1   |7 allocated a buffer
6   0   3   2   1   |7 shared a buffer with 8
7   0   4   2   2   |7 sharing with 9
8   0   4   2   2   |7 sharing with 4
7   0   3   1   2   |7 release a buffer
6   0   2   0   2   |8 release a buffer from 7

Is this a correct understanding of the suggestion?

Regards,
Kenny

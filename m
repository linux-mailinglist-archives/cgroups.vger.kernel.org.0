Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1487815FB57
	for <lists+cgroups@lfdr.de>; Sat, 15 Feb 2020 01:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgBOALh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 19:11:37 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41072 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgBOALh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 19:11:37 -0500
Received: by mail-yb1-f196.google.com with SMTP id j11so5655722ybt.8
        for <cgroups@vger.kernel.org>; Fri, 14 Feb 2020 16:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qj2zBbkIxBGfCERuHV86VP5E7OnuA4mxy13S+8Juj1A=;
        b=mQXv020xrGiFQVRcG+t3iVDyjz5L4TGdw0U6fbXeCwxrDC4hDSpg0HBUuUifRpC35r
         IAr+R+LZdTurVkQIlblgBmObc9b8hX5L2QMJXSgw+ykNNQcG5LVdhpwoKmSquITh5FDc
         me1wYFI8+0AcXmPj9ameun83h8tbAFaCzlBQVnK9wL0CfDhdWHFsRLu+6RaIUliQg3mx
         FEvcu8Ar1zcLaMHBuLvh3rsYsOfl0C2RlyfjNt65BG+ROrPNebXJjL0UYf9LxR0gYO5q
         4Entvu6OAzKq+H8KYWL1LRp/fdJbWViG6JTmq3xbcl9LNkt596K8wSd8/aHFGmc4lO1e
         VG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qj2zBbkIxBGfCERuHV86VP5E7OnuA4mxy13S+8Juj1A=;
        b=jA5y0QE0V+Jumhrq7RWmbLGgrvzQ48obdYP3HlW55VYkBa3d/Fe0I4LtR4pqTrYQhs
         OCGpnbnEkgpEeRCICcsYSIGnd9M1dD4yo+9wuY1phf1kAH5jodM+sSki+5ZdMlku557n
         TyuLhZqWPPxn/SCVhWY766dJ8I5GvArFI6SrbiFjarFeUje9xcVreVXh/HWKjY2q9yXq
         APd2scGc2gGudddfzHO38CZhNdmZzbPCR4eJxYtnztCIiy8U/7voHJhF6JiHzIKanniP
         XbvV+A2g5GLmJ9ExPQv8+McFmD2dCx37yX9SEPORBJFvNSE0KSNCC0z3Yq8whgfoFFFY
         1zrw==
X-Gm-Message-State: APjAAAVPDCe0/itajPEZUADWBFxSjWug4zPxJEGTXfj7NCqESdNKyNYp
        qO7mBnLhNeuBWgjvG61m3AvXAD5Jg4HdkCzPOCbR3A==
X-Google-Smtp-Source: APXvYqwRusIwUk6lCNfxmnhsTV8VjQlzho9wFmoZfuZX08t6lIpHqT7y+O10DM3NmqSYkj2omYk5blRS2XoRospyutQ=
X-Received: by 2002:a25:b949:: with SMTP id s9mr5305834ybm.274.1581725496112;
 Fri, 14 Feb 2020 16:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20200214222415.181467-1-shakeelb@google.com> <CANn89iLe7KVjaechEhtV4=QRy4s8qBQDiX9e8LX_xq8tunrQNA@mail.gmail.com>
 <CALvZod5RoE3V7HteKqqDEfCgY8pDok6PWHrpu8trB1vyuK2UHA@mail.gmail.com>
 <CANn89i+-GJgD4-YnF9yKhDvG48OK8XtM7oB9gw6njeb_ZbdpDw@mail.gmail.com> <CALvZod4kU=tWcWbu4pWBrHUcxgTnKj_2fEEdnBeU+F0kox0Hig@mail.gmail.com>
In-Reply-To: <CALvZod4kU=tWcWbu4pWBrHUcxgTnKj_2fEEdnBeU+F0kox0Hig@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 14 Feb 2020 16:11:24 -0800
Message-ID: <CANn89iKq5r7aCDdpTXzfvDbhHYgnTGhgyTG5_rLbcSeeF8uJJQ@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: memcg: net: do not associate sock with
 unrelated cgroup
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 14, 2020 at 4:04 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Fri, Feb 14, 2020 at 3:12 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, Feb 14, 2020 at 2:48 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > >
> > > I think in the current code if the association is skipped at
> > > allocation time then the sock will remain unassociated for its
> > > lifetime.
> > >
> > > Maybe we can add the association in the later stages but it seems like
> > > it is not a simple task i.e. edbe69ef2c90f ("Revert "defer call to
> > > mem_cgroup_sk_alloc()"").
> >
> > Half TCP sockets are passive, so this means that 50% of TCP sockets
> > won't be charged.
> > (the socket cloning always happens from BH context)
> >
> > I think this deserves a comment in the changelog or documentation,
> > otherwise some people might think
> > using memcg will make them safe.
>
> Thanks I will update the changelog. Also is inet_csk_accept() the
> right place for delayed cgroup/memcg binding (if we decide to do
> that). I am wondering if we can force charge the memcg during late
> binding to cater the issue fixed in edbe69ef2c90f.
>

Yes, this is exactly why accept() would be the natural choice.

You  do not want to test/change the binding at sendmsg()/recvmsg() time, right ?

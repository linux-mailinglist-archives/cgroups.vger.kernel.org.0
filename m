Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942EA17B101
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 22:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgCEV7u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 16:59:50 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45742 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgCEV7t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 16:59:49 -0500
Received: by mail-oi1-f196.google.com with SMTP id v19so423495oic.12
        for <cgroups@vger.kernel.org>; Thu, 05 Mar 2020 13:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZ9X7pBOQ32PghBEC4+dP85I/S+wu1As9RhQFRnXXto=;
        b=lSsXtoDIO0iLHjqPicvvXtqjyT7OR/kBmY+VLmgBRevQBgKkkDTBQRGLxzsgcELH6t
         gqiGETJBzstXBAnv9oYvbcIBIz89GpuahxVSYeZiGIBZ4JvWLqjwVYKVD1bfwB074NTL
         9MZik/rr8kw3M1VyRiiRn60Ts6yKRUKNcOSsYWGch+SBvf7epfYp8rNztCtiP/kPuX9K
         10Bcd7ggd2vSizpgzvw3rq7TbbT5qAgso27hxp1LZMY9bXozbQWsZzRKL1BXWCK66cCq
         FzIrI80C7cvzbZRPcHeBZj4Pxdrxrivy0+6UjMRhYPpEW17iy/T0kUB0lmxycqhI6IJV
         wl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZ9X7pBOQ32PghBEC4+dP85I/S+wu1As9RhQFRnXXto=;
        b=Otpuub9HS0+WldAQ0YKP8TFxd2r8CHr9YRiP0G33+/FYhRdsFophTcadFIEnO/oa3g
         6yAc6vfg8uP4qC+1jHhKaDwfOR2F6/uZV2KADpT70RnzQgIHaveMUCFTfX3MOghklaRa
         7Y76WDCemv5i1HEbq2qbCEKsSG0T4RKp21t+QCADOB7MUvjKfZa/SjBe49x0FKkNOa3p
         UqNufUeoAofvtqB3Iopk0h1WxJWvo4s8Ij2EIEW7ye+nCdSLqZSQHaMn8kArmt8ITK8v
         wSgdjyKj3YDvc65YkSgJwcrBELYHaqgY4eo0IB//0O5fWVajSFBnOhd13J6oZrK3tM0V
         NCsQ==
X-Gm-Message-State: ANhLgQ0sxGla9r1AHwz1lutAegi6zWkyJipBEaMCQ9BW7XO16R6bVa3C
        o2kHF/5a112rHMwUl4s8w272z2l+aP4XOI6zTcv+qw==
X-Google-Smtp-Source: ADFU+vtYXWLwZtcPM8JDPJKFFjMDljTV5RXVkWBf8UUOHRKcT1Dlz5TI0VyF36iQc7ZItQBmxNnUhKuVpOCALNdBsMo=
X-Received: by 2002:a05:6808:64e:: with SMTP id z14mr383631oih.79.1583445588674;
 Thu, 05 Mar 2020 13:59:48 -0800 (PST)
MIME-Version: 1.0
References: <20200305205525.245058-1-shakeelb@google.com> <9505d35b-f9fc-149b-6df5-e65ad95acabb@gmail.com>
In-Reply-To: <9505d35b-f9fc-149b-6df5-e65ad95acabb@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 5 Mar 2020 13:59:37 -0800
Message-ID: <CALvZod68Raqfa2ZJOfF_OOQdb-hxkOs54G5KK3VQnUdxiZ=KTQ@mail.gmail.com>
Subject: Re: [PATCH v3] net: memcg: late association of sock to memcg
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 5, 2020 at 1:17 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 3/5/20 12:55 PM, Shakeel Butt wrote:
> > If a TCP socket is allocated in IRQ context or cloned from unassociated
> > (i.e. not associated to a memcg) in IRQ context then it will remain
> > unassociated for its whole life. Almost half of the TCPs created on the
> > system are created in IRQ context, so, memory used by such sockets will
> > not be accounted by the memcg.
> >
> > This issue is more widespread in cgroup v1 where network memory
> > accounting is opt-in but it can happen in cgroup v2 if the source socket
> > for the cloning was created in root memcg.
> >
> > To fix the issue, just do the late association of the unassociated
> > sockets at accept() time in the process context and then force charge
> > the memory buffer already reserved by the socket.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> > Changes since v2:
> > - Additional check for charging.
> > - Release the sock after charging.
> >
> > Changes since v1:
> > - added sk->sk_rmem_alloc to initial charging.
> > - added synchronization to get memory usage and set sk_memcg race-free.
> >
> >  net/ipv4/inet_connection_sock.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index a4db79b1b643..5face55cf818 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -482,6 +482,26 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
> >               }
> >               spin_unlock_bh(&queue->fastopenq.lock);
> >       }
> > +
> > +     if (mem_cgroup_sockets_enabled && !newsk->sk_memcg) {
> > +             int amt;
> > +
> > +             /* atomically get the memory usage, set and charge the
> > +              * sk->sk_memcg.
> > +              */
> > +             lock_sock(newsk);
> > +
> > +             /* The sk has not been accepted yet, no need to look at
> > +              * sk->sk_wmem_queued.
> > +              */
> > +             amt = sk_mem_pages(newsk->sk_forward_alloc +
> > +                                atomic_read(&sk->sk_rmem_alloc));
> > +             mem_cgroup_sk_alloc(newsk);
> > +             if (newsk->sk_memcg && amt)
> > +                     mem_cgroup_charge_skmem(newsk->sk_memcg, amt);
> > +
> > +             release_sock(newsk);
> > +     }
> >  out:
> >       release_sock(sk);
> >       if (req)
> >
>
> This patch looks fine, but why keeping the mem_cgroup_sk_alloc(newsk);
> in sk_clone_lock() ?
>
> Note that all TCP sk_clone_lock() calls happen in softirq context.

So, basically re-doing something like 9f1c2674b328 ("net: memcontrol:
defer call to mem_cgroup_sk_alloc()") in this patch. I am fine with
that.

Roman, any concerns?

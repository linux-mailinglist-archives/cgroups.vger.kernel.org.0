Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2F15FB4D
	for <lists+cgroups@lfdr.de>; Sat, 15 Feb 2020 01:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgBOAEc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 19:04:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44105 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgBOAEc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 19:04:32 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so10799889otj.11
        for <cgroups@vger.kernel.org>; Fri, 14 Feb 2020 16:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sc3eN5qofsLsz0odXUjAXrrQtgiKgF8fh8BjuXC2JWY=;
        b=OpzcXXfkrp7UFH3ZK85YabQ88elz5XA6OO/FPNgHZkCMW/kxBKWveumbeQjL/Xav1P
         ty+v6E4VESghdBWneJyGKa+igJclsO2a1+3vswIplonbl5S+KcdbSPQ9MRbF18yIlU2I
         dgnwRWUtwnZt3zXEGFDhMWGJh9u+i42Mcn1kCybLYVgeQiyhHacQ7TUUdM+4+U56jaqy
         d9tdMOE3jWZIvcihxvFqfE8ew7Nux205pr5nJLrYaZCkhW/yXfL3YjxoECuwcIckYZHm
         qFG5VsR/2Ok/XAzuGw700He0YIDDQ1KHzWkBVK+S3C0h01QsVZVUYaSQ4MPyi0ROMS+g
         hsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sc3eN5qofsLsz0odXUjAXrrQtgiKgF8fh8BjuXC2JWY=;
        b=Z7DD2K/Msji53nVf1nXZEDHXX/1tY/Zv6cDsTpLtUDo/vTkwkhcmnxJbtoAbgwjGcv
         lw8BAUK1mq6lxdwJXaCw9gI2zTjAIZoA10jNG+yw0rfACYUYu6MdseTDsipcG3eYrfTg
         PREZfT3dAXgc5kRRUvhjrGwGrXd+xNgYyA0vifX59pgOWryHdgjOrbAS7QvEZf4xtPUY
         +d5R7efcSw/IH8C5LczV+e+V16lui9JbyC5rTOZF7DnPx4DyRnSSQmQasv0oM4HONhqb
         aZECu+rq06+z2zCDXVEDYxHjHhrb7wLDnFIJkhSckSBKjOfhB9brdiGiB/d8pFMB6qP1
         m2XQ==
X-Gm-Message-State: APjAAAU7j7FESxc7lnrhR82pPHk+2JIpWBiL2nN6XRvMijCr5i3TcY/5
        dCseFTVBoF+ssK4yJjoX6etNYW3+XkxW2dUQQYz1YQ==
X-Google-Smtp-Source: APXvYqzAjeek3/OrstwZ6dIH3DyJHOy/lz/gOfLKkozBzmnuWgnJCL9xr1l1yC1jWdBYvGnudU8ofd4dG/8syTmByoQ=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr4317523otq.191.1581725071308;
 Fri, 14 Feb 2020 16:04:31 -0800 (PST)
MIME-Version: 1.0
References: <20200214222415.181467-1-shakeelb@google.com> <CANn89iLe7KVjaechEhtV4=QRy4s8qBQDiX9e8LX_xq8tunrQNA@mail.gmail.com>
 <CALvZod5RoE3V7HteKqqDEfCgY8pDok6PWHrpu8trB1vyuK2UHA@mail.gmail.com> <CANn89i+-GJgD4-YnF9yKhDvG48OK8XtM7oB9gw6njeb_ZbdpDw@mail.gmail.com>
In-Reply-To: <CANn89i+-GJgD4-YnF9yKhDvG48OK8XtM7oB9gw6njeb_ZbdpDw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 14 Feb 2020 16:04:20 -0800
Message-ID: <CALvZod4kU=tWcWbu4pWBrHUcxgTnKj_2fEEdnBeU+F0kox0Hig@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: memcg: net: do not associate sock with
 unrelated cgroup
To:     Eric Dumazet <edumazet@google.com>
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

On Fri, Feb 14, 2020 at 3:12 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Feb 14, 2020 at 2:48 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> >
> > I think in the current code if the association is skipped at
> > allocation time then the sock will remain unassociated for its
> > lifetime.
> >
> > Maybe we can add the association in the later stages but it seems like
> > it is not a simple task i.e. edbe69ef2c90f ("Revert "defer call to
> > mem_cgroup_sk_alloc()"").
>
> Half TCP sockets are passive, so this means that 50% of TCP sockets
> won't be charged.
> (the socket cloning always happens from BH context)
>
> I think this deserves a comment in the changelog or documentation,
> otherwise some people might think
> using memcg will make them safe.

Thanks I will update the changelog. Also is inet_csk_accept() the
right place for delayed cgroup/memcg binding (if we decide to do
that). I am wondering if we can force charge the memcg during late
binding to cater the issue fixed in edbe69ef2c90f.

Shakeel

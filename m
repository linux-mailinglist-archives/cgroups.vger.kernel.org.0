Return-Path: <cgroups+bounces-241-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7C47E5242
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 09:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48AB1C20AA6
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BB5DDB7;
	Wed,  8 Nov 2023 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aNbrAE1y"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA65DDA0
	for <cgroups@vger.kernel.org>; Wed,  8 Nov 2023 08:59:44 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E684E1718
	for <cgroups@vger.kernel.org>; Wed,  8 Nov 2023 00:59:43 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1039710966b.1
        for <cgroups@vger.kernel.org>; Wed, 08 Nov 2023 00:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699433982; x=1700038782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tor/EJdIpY1mQ+T8Qhv4C03xA4q/rVwv1DfBop2f0Do=;
        b=aNbrAE1yKFuBCJcFtCPknM0so7xM+RsD4m7nVZNzkZdpNJ+0oXH5OWhjcthKbfmfB9
         L0Bzxe+oNszY9pkU2lUgvfUpEDO0vwkRgXV1Xo4eU24afFdalnzg61OSKdqybd7x7q5e
         A9WG2rW7wh1IjZaNUtyHNIHgNvPP2tOD9DVL1TWKhyzNStPNy1zbb4u0dBd9xRX7vAyV
         vwRTW6S+ro8x+Mq1EAEG3B+vjlWNVkOEhKn8Z0y15LBilQQeDBMUxQ0zO+UdBiqkbxmH
         xQxqKW0BScknWn+grt9msHa9qOLKizqJGFtucxNaCwljc31BDi58JtkaYagTM21FSKLK
         m4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699433982; x=1700038782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tor/EJdIpY1mQ+T8Qhv4C03xA4q/rVwv1DfBop2f0Do=;
        b=kQ5x1RF17Bcv4wjzlr+j0CsnwX6UpiJIPiHGITzyOtWVbOdeZ7F2TB4sjH8fVeuYPr
         hDHsIv7MnxqgUDZ1G1ebUSjnXbTTUFMZBenDtD12JfwsuA+nlRXqAv0TXJdxTVKbJjIJ
         N3w343oy/oU+a5JX3AKQXbxpGo1AOytcgsePeVakaNEQXcPxSMQkqwFEWqKrIUfUqnmm
         BYW0DOYLb7pwmy/va0wkYpTyotaRZIlyD+MjJCdrKsdWkyPHUyZaH8BHJ/M4KQBBRikz
         JqA7SuZfV1rbVFhmj7lb7yNXJ31DB+kG5tzTkgV3JWAOWEgv7OAWfZFCFbS1HHBB2u7b
         knoQ==
X-Gm-Message-State: AOJu0YzFqcyfrI4Vd7InB6iT+re1FbJZp1Idt+r3rL3FXOwwFHEEYwUi
	0X6d0U073ZZXiuIwJKtTgvBK+jD4JXxZyCwH58dlJw==
X-Google-Smtp-Source: AGHT+IGn6eGFsclyYzD50WFiPGxzCz+3fCLF0s6JgmmAuiqTby0HByPXoOE0rEbXVr+CVfr+KMHxOfjP0b/dgUSvGvM=
X-Received: by 2002:a17:906:c103:b0:9c0:2897:1588 with SMTP id
 do3-20020a170906c10300b009c028971588mr790461ejc.17.1699433982110; Wed, 08 Nov
 2023 00:59:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108065818.19932-1-link@vivo.com> <CAJD7tkYVtaX=W5XWhn-Y+d==mbHs5AZG-7sAaYmo7FDONpoQ7g@mail.gmail.com>
 <4c7db101-a34f-47ff-ba64-952516cc193a@vivo.com>
In-Reply-To: <4c7db101-a34f-47ff-ba64-952516cc193a@vivo.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 8 Nov 2023 00:59:02 -0800
Message-ID: <CAJD7tkZ2cnp6tSr6jb2Xpt4J-5oeTmAq1KNw6f7KBWPfjca8gA@mail.gmail.com>
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: Huan Yang <link@vivo.com>
Cc: Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Huang Ying <ying.huang@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Peter Xu <peterx@redhat.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Liu Shixin <liushixin2@huawei.com>, Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 12:26=E2=80=AFAM Huan Yang <link@vivo.com> wrote:
>
>
> =E5=9C=A8 2023/11/8 16:00, Yosry Ahmed =E5=86=99=E9=81=93:
> > +Wei Xu +David Rientjes
> >
> > On Tue, Nov 7, 2023 at 10:59=E2=80=AFPM Huan Yang <link@vivo.com> wrote=
:
> >> In some cases, we need to selectively reclaim file pages or anonymous
> >> pages in an unbalanced manner.
> >>
> >> For example, when an application is pushed to the background and froze=
n,
> >> it may not be opened for a long time, and we can safely reclaim the
> >> application's anonymous pages, but we do not want to touch the file pa=
ges.
> >>
> >> This patchset extends the proactive reclaim interface to achieve
> >> unbalanced reclamation. Users can control the reclamation tendency by
> >> inputting swappiness under the original interface. Specifically, users
> >> can input special values to extremely reclaim specific pages.
> > I proposed this a while back:
> >
> > https://lore.kernel.org/linux-mm/CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk=
51yKSNgD7aGdg@mail.gmail.com/
> Well to know this, proactive reclaim single type is usefull in our
> production too.
> >
> > The takeaway from the discussion was that swappiness is not the right
> > way to do this. We can add separate arguments to specify types of
> > memory to reclaim, as Roman suggested in that thread. I had some
> > patches lying around to do that at some point, I can dig them up if
> > that's helpful, but they are probably based on a very old kernel now,
> > and before MGLRU landed. IIRC it wasn't very difficult, I think I
> > added anon/file/shrinkers bits to struct scan_control and then plumbed
> > them through to memory.reclaim.
> >
> >> Example:
> >>          echo "1G" 200 > memory.reclaim (only reclaim anon)
> >>            echo "1G" 0  > memory.reclaim (only reclaim file)
> >>            echo "1G" 1  > memory.reclaim (only reclaim file)
> > The type of interface here is nested-keyed, so if we add arguments
> > they need to be in key=3Dvalue format. Example:
> >
> > echo 1G swappiness=3D200 > memory.reclaim
> Yes, this is better.
> >
> > As I mentioned above though, I don't think swappiness is the right way
> > of doing this. Also, without swappiness, I don't think there's a v1 vs
> > v2 dilemma here. memory.reclaim can work as-is in cgroup v1, it just
> > needs to be exposed there.
> Cgroupv1 can't use memory.reclaim, so, how to exposed it? Reclaim this by
> pass memcg's ID?

That was mainly about the idea that cgroup v2 does not have per-memcg
swappiness, so this proposal seems to be inclined towards v1, at least
conceptually. Either way, we need to add memory.reclaim to the v1
files to get it to work on v1. Whether this is acceptable or not is up
to the maintainers. I personally don't think it's a problem, it should
work as-is for v1.


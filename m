Return-Path: <cgroups+bounces-7643-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBE7A93EC9
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 22:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3B01B67D58
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 20:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC0022D797;
	Fri, 18 Apr 2025 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aX2hHJpK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B34215066
	for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745007574; cv=none; b=uPjsvyX0zJwvIz3j5ZNTO97bPvOIxDK5izVx6hnQME97lc0a/RtwcP2jWsTOmg72bYW8y9I+tObbhB7hIcYv5LD/4RYm6pGp9fnYmP0VlXA5nHyerG6jwuxLGMEAgHddecd2skWCzJjBcLqOjAfzHtZIYA0AHRaDSWH5kGO7He8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745007574; c=relaxed/simple;
	bh=xJYmpdCnSHWhWbWjYZkJPELxKSBAcPREU2gnjEv+SqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fz+pBVtPcA1A5VxNktSoNjSVjeicHvJy5YKkGXT3T6dOk59b4BdF3pRfJS/BFv0vIh4PVZxSQA4SXoRTUrT8JnNccUwVYVqGT5aZyca3/BFe7L6YKiXBu1SsQwEBMY/DchtcFMSj2bvzlTZ6990lZG6XOnC3m3ybWLM6V6MA+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aX2hHJpK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso13525a12.1
        for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 13:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745007571; x=1745612371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZXFKeC9M/Del26pDuuytW82irsQUL37Nct0skl7UqM=;
        b=aX2hHJpKwjDV8WBcFrStgIq7vqmrwIWCegJq6lWeRXd6vq2g+QUHEE8A+mI4ZEApKW
         y5tAGAw10+wl/3gj5+6AUA/2WB3VNvs+WLDxaKF02ICM9zZFNDchLOStZAZ8ZmjHkk5y
         +ahrIhbxzbmNdVwjUNu8bJX1yyzP/w0C0bIYf5smQtCRtxXCJywAMDnITyVS6eSDzo+4
         6GkHwcCZwWnAg4qeBNHztn5cfchJ0nsZSOGN5yRSDfYvULi+gqfxGfz3Gtu+2Ru4d9of
         Jx8BCGuJNQ/YV2NTS+MjxMN66RXtYxUlHKxaVo+rzu5LKA7gHAbhnCyvzcTkWPXZrXGU
         IpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745007571; x=1745612371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZXFKeC9M/Del26pDuuytW82irsQUL37Nct0skl7UqM=;
        b=JrpK82D0faHxV2Uob60VtRXM8gaoHle95O4y8FVNHUuFcSnw+ar1ueaNuM77rzg+IN
         Bukv/sUOiei7rh7/wG6/9ci/3VI9OQjH94pS5J/KchvOABbLKKChvIjreBuH1y0ilakm
         0DOLMmE3p2TvBczcfnK71jr1y1kj2OVez9SsgrlV+1vScRMktWU1LT7gNjcf6tfrAUj2
         /cCaTmPGMSPnhkZO2fhYXSqHiGXrYU2bE4poj37iN0F65Lr/AMhwFKBbC3f0Cr7sMPYa
         b4lypoq/rQ/aMT0beXbWtHb30ZP7lr0yGQkghXawaKXQnUvvKJ0vPtA7o7w/iDJGp9cm
         BA+w==
X-Forwarded-Encrypted: i=1; AJvYcCXuiBGQGJG/1uVW/kwhJrx0WNeBZsBVx/ryl4E5pEqrbpVqJ+iAURp9dhcV3nwmY3QV1JhHPl0y@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ48MOFDk5Lve6ex1y34o9eX3dm17vZOZURTQJpY6OGYBLxlCG
	eBsjjDmKpsRrl1KXHZA9+JonZTuJCWCLrgN/DI86d72wOz5HDzqxPCwH0XxOujbPEYERPeCA4CT
	C5DPmSNePyPWsGkbIy8DZgr5LXluDg/6FDmlW
X-Gm-Gg: ASbGncu86VDCWgzu5/ZuNuU644rEky1y/1UMMDUfbR9oBDYjQoI1kXif+Ofk/xsGjns
	1xCejEsD0pAmvLgXNGmiFYHu+5kyiv2U8pxQuT/3myXSxFylIHKKpSl1PfgSGzOpEpFqZMNeXTD
	T6pq6vCoOksBIjtwOTZ8XZLA==
X-Google-Smtp-Source: AGHT+IGFe97Mx8SoIIgHDiHuNwRkro7YcFs1R7KuODBZY8K/NGiuCZqNbl0JcflhwH61kKBZ35/7bfZnv2ML0wJSyyc=
X-Received: by 2002:aa7:d596:0:b0:5e0:eaa6:a2b0 with SMTP id
 4fb4d7f45d1cf-5f6289ac180mr92807a12.5.1745007570788; Fri, 18 Apr 2025
 13:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418195956.64824-1-shakeel.butt@linux.dev>
In-Reply-To: <20250418195956.64824-1-shakeel.butt@linux.dev>
From: Greg Thelen <gthelen@google.com>
Date: Fri, 18 Apr 2025 13:18:53 -0700
X-Gm-Features: ATxdqUEFwnlg_5kC790EFWxU23bmt6mATlBYh_XFDn6utQnVCEwoEYazCJRVwyo
Message-ID: <CAHH2K0as=b+EhxG=8yS9T9oP40U2dEtU0NA=wCJSb6ii9_DGaw@mail.gmail.com>
Subject: Re: [PATCH] memcg: introduce non-blocking limit setting interfaces
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 1:00=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Setting the max and high limits can trigger synchronous reclaim and/or
> oom-kill if the usage is higher than the given limit. This behavior is
> fine for newly created cgroups but it can cause issues for the node
> controller while setting limits for existing cgroups.
>
> In our production multi-tenant and overcommitted environment, we are
> seeing priority inversion when the node controller dynamically adjusts
> the limits of running jobs of different priorities. Based on the system
> situation, the node controller may reduce the limits of lower priority
> jobs and increase the limits of higher priority jobs. However we are
> seeing node controller getting stuck for long period of time while
> reclaiming from lower priority jobs while setting their limits and also
> spends a lot of its own CPU.
>
> One of the workaround we are trying is to fork a new process which sets
> the limit of the lower priority job along with setting an alarm to get
> itself killed if it get stuck in the reclaim for lower priority job.
> However we are finding it very unreliable and costly. Either we need a
> good enough time buffer for the alarm to be delivered after setting
> limit and potentialy spend a lot of CPU in the reclaim or be unreliable
> in setting the limit for much shorter but cheaper (less reclaim) alarms.
>
> Let's introduce new limit setting interfaces which does not trigger
> reclaim and/or oom-kill and let the processes in the target cgroup to
> trigger reclaim and/or throttling and/or oom-kill in their next charge
> request. This will make the node controller on multi-tenant
> overcommitted environment much more reliable.

Would opening the typical synchronous files (e.g. memory.max) with
O_NONBLOCK be a more general way to tell the kernel that the user
space controller doesn't want to wait? It's not quite consistent with
traditional use of O_NONBLOCK, which would make operations to
fully succeed or fail, rather than altering the operation being requested.
But O_NONBLOCK would allow for a semantics of non-blocking
reclaim, if that's fast enough for your controller.

> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 16 +++++++++
>  mm/memcontrol.c                         | 46 +++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 8fb14ffab7d1..7b459c821afa 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1299,6 +1299,14 @@ PAGE_SIZE multiple when read back.
>         monitors the limited cgroup to alleviate heavy reclaim
>         pressure.
>
> +  memory.high.nonblock
> +        This is the same limit as memory.high but have different
> +        behaviour for the writer of this interface. The program setting
> +        the limit will not trigger reclaim synchronously if the
> +        usage is higher than the limit and let the processes in the
> +        target cgroup to trigger reclaim and/or get throttled on
> +        hitting the high limit.
> +
>    memory.max
>         A read-write single value file which exists on non-root
>         cgroups.  The default is "max".
> @@ -1316,6 +1324,14 @@ PAGE_SIZE multiple when read back.
>         Caller could retry them differently, return into userspace
>         as -ENOMEM or silently ignore in cases like disk readahead.
>
> +  memory.max.nonblock
> +        This is the same limit as memory.max but have different
> +        behaviour for the writer of this interface. The program setting
> +        the limit will not trigger reclaim synchronously and/or trigger
> +        the oom-kill if the usage is higher than the limit and let the
> +        processes in the target cgroup to trigger reclaim and/or get
> +        oom-killed on hitting their max limit.
> +
>    memory.reclaim
>         A write-only nested-keyed file which exists for all cgroups.
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5e2ea8b8a898..6ad1464b621a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4279,6 +4279,23 @@ static ssize_t memory_high_write(struct kernfs_ope=
n_file *of,
>         return nbytes;
>  }
>
> +static ssize_t memory_high_nonblock_write(struct kernfs_open_file *of,
> +                                         char *buf, size_t nbytes, loff_=
t off)
> +{
> +       struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> +       unsigned long high;
> +       int err;
> +
> +       buf =3D strstrip(buf);
> +       err =3D page_counter_memparse(buf, "max", &high);
> +       if (err)
> +               return err;
> +
> +       page_counter_set_high(&memcg->memory, high);
> +       memcg_wb_domain_size_changed(memcg);
> +       return nbytes;
> +}
> +
>  static int memory_max_show(struct seq_file *m, void *v)
>  {
>         return seq_puts_memcg_tunable(m,
> @@ -4333,6 +4350,23 @@ static ssize_t memory_max_write(struct kernfs_open=
_file *of,
>         return nbytes;
>  }
>
> +static ssize_t memory_max_nonblock_write(struct kernfs_open_file *of,
> +                                        char *buf, size_t nbytes, loff_t=
 off)
> +{
> +       struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> +       unsigned long max;
> +       int err;
> +
> +       buf =3D strstrip(buf);
> +       err =3D page_counter_memparse(buf, "max", &max);
> +       if (err)
> +               return err;
> +
> +       xchg(&memcg->memory.max, max);
> +       memcg_wb_domain_size_changed(memcg);
> +       return nbytes;
> +}
> +
>  /*
>   * Note: don't forget to update the 'samples/cgroup/memcg_event_listener=
'
>   * if any new events become available.
> @@ -4557,12 +4591,24 @@ static struct cftype memory_files[] =3D {
>                 .seq_show =3D memory_high_show,
>                 .write =3D memory_high_write,
>         },
> +       {
> +               .name =3D "high.nonblock",
> +               .flags =3D CFTYPE_NOT_ON_ROOT,
> +               .seq_show =3D memory_high_show,
> +               .write =3D memory_high_nonblock_write,
> +       },
>         {
>                 .name =3D "max",
>                 .flags =3D CFTYPE_NOT_ON_ROOT,
>                 .seq_show =3D memory_max_show,
>                 .write =3D memory_max_write,
>         },
> +       {
> +               .name =3D "max.nonblock",
> +               .flags =3D CFTYPE_NOT_ON_ROOT,
> +               .seq_show =3D memory_max_show,
> +               .write =3D memory_max_nonblock_write,
> +       },
>         {
>                 .name =3D "events",
>                 .flags =3D CFTYPE_NOT_ON_ROOT,
> --
> 2.47.1
>
>


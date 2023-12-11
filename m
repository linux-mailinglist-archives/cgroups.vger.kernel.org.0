Return-Path: <cgroups+bounces-913-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A680DB04
	for <lists+cgroups@lfdr.de>; Mon, 11 Dec 2023 20:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F431C21529
	for <lists+cgroups@lfdr.de>; Mon, 11 Dec 2023 19:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEABD537E0;
	Mon, 11 Dec 2023 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BzpwBPEq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB6CF
	for <cgroups@vger.kernel.org>; Mon, 11 Dec 2023 11:42:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-550dd0e3304so3381415a12.1
        for <cgroups@vger.kernel.org>; Mon, 11 Dec 2023 11:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702323723; x=1702928523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1xlkoknCKe+rRAZq4chj+QZuYrtbZ8hKNLIJXx7jh4=;
        b=BzpwBPEqvUBjsQVHoOz/q1a76DmJJO7Kx/yAZ7og8hkf3sMxqcViv6MP4kyz84fcmT
         tahr1lgEtEBSA+/a6eRZKTSCdBdJ21KUaVJS1TOyy+1nprZut7KmPzCLSA+/kkVyRy3C
         Srnop5iVHzwVMSweBcfUw6DTmNNE3ePjAqFhIqc9m2n5OFMkf1NSsKU2vrkh93T8gRKp
         0xpKgKgKwGP5umqVeZjsqWWb+7m4pbu6ErHcE2c58pSTIWswotBK5eec6oyunabbHmIw
         lLUgLFH/Jcsrj9PVLf5KeXppPATDSLUsQvlxXg1dR8zq5gPXdT+nNiQb1KvXV4AQDMz4
         Xv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702323723; x=1702928523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1xlkoknCKe+rRAZq4chj+QZuYrtbZ8hKNLIJXx7jh4=;
        b=wP9aNQm77pPM5HaZ9xPnn10CiZcTZhunEChU55PylUoduJTg2oYKoyWGsE6tBmGQL5
         y7AEkul2OaQpMgT3FsPPyBdtIjv3QtXbvk7BFJxXbRFeC+J81JTTRgqjdJeZP79Hf0EM
         rZQNXx8R+e1etT1gYiFydMJvVGCy7x3ur8CIomZoYRp4TtRx+j67Zr9eJ9kJDq9IA5l7
         OQvXHKtqKDID2eccKG4+T35lbF01kpaVnGa0dUAGvpRYHeofES2aIHA2Q9YsisdRUWjP
         u44S9ZAcrCd0LBdDJV8/+fLEc4aKvtri3dEcCueNEYvDd7ToPJ6qTm9SkNVMGYtLPUWn
         x47g==
X-Gm-Message-State: AOJu0Yxl0nweTEaDWaCWQVY/XTI8ZRI/xlY6B4zLIOYVbcPeWSoB1yTB
	2t/5F+/P+ToLrm1FWdLFwGDHzHtmwcBeQnFvmaPm/SSn3GBSFszGVBAGRQ==
X-Google-Smtp-Source: AGHT+IEXX5Y883yAOe8bRnhdlt7eyI7DRp7CVLcBnW/9gGFaOpCCnndrsELXsX2XqXcpOP8ADBf92budkZMDnYJtEUo=
X-Received: by 2002:a17:906:33cc:b0:a19:a19b:78ae with SMTP id
 w12-20020a17090633cc00b00a19a19b78aemr2279264eja.113.1702323723348; Mon, 11
 Dec 2023 11:42:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211140419.1298178-1-schatzberg.dan@gmail.com> <20231211140419.1298178-2-schatzberg.dan@gmail.com>
In-Reply-To: <20231211140419.1298178-2-schatzberg.dan@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 11 Dec 2023 11:41:24 -0800
Message-ID: <CAJD7tkZQ2aakT8M2bTg0bp4sDtrGYv_4i4Z4z3KBerfxZ9qFWA@mail.gmail.com>
Subject: Re: [PATCH V3 1/1] mm: add swapiness= arg to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Yue Zhao <findns94@gmail.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 6:04=E2=80=AFAM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> Allow proactive reclaimers to submit an additional swappiness=3D<val>
> argument to memory.reclaim. This overrides the global or per-memcg
> swappiness setting for that reclaim attempt.
>
> For example:
>
> echo "2M swappiness=3D0" > /sys/fs/cgroup/memory.reclaim
>
> will perform reclaim on the rootcg with a swappiness setting of 0 (no
> swap) regardless of the vm.swappiness sysctl setting.
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 15 ++++++-
>  include/linux/swap.h                    |  3 +-
>  mm/memcontrol.c                         | 55 ++++++++++++++++++++-----
>  mm/vmscan.c                             | 13 +++++-
>  4 files changed, 70 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 3f85254f3cef..fc2b379dbd0f 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1282,8 +1282,8 @@ PAGE_SIZE multiple when read back.
>         This is a simple interface to trigger memory reclaim in the
>         target cgroup.
>
> -       This file accepts a single key, the number of bytes to reclaim.
> -       No nested keys are currently supported.
> +       This file accepts a string which containers thhe number of bytes

contains* the*

I think this statement was only important because no keys were
supported, so I think we can remove it completely and rely on
documenting the supported keys below like other interfaces, see my
next comment.

> +       to reclaim.
>
>         Example::
>
> @@ -1304,6 +1304,17 @@ PAGE_SIZE multiple when read back.
>         This means that the networking layer will not adapt based on
>         reclaim induced by memory.reclaim.
>
> +       This file also allows the user to specify the swappiness value
> +       to be used for the reclaim. For example:
> +
> +         echo "1G swappiness=3D60" > memory.reclaim
> +
> +       The above instructs the kernel to perform the reclaim with
> +       a swappiness value of 60. Note that this has the same semantics
> +       as the vm.swappiness sysctl - it sets the relative IO cost of
> +       reclaiming anon vs file memory but does not allow for reclaiming
> +       specific amounts of anon or file memory.
> +

Can we instead follow the same format used by other nested-keyed files
(e.g. io.max)? This usually involves a table of supported keys and
such.

>    memory.peak
>         A read-only single value file which exists on non-root
>         cgroups.
[..]
> @@ -6902,12 +6913,33 @@ static ssize_t memory_reclaim(struct kernfs_open_=
file *of, char *buf,
>         unsigned int nr_retries =3D MAX_RECLAIM_RETRIES;
>         unsigned long nr_to_reclaim, nr_reclaimed =3D 0;
>         unsigned int reclaim_options;
> -       int err;
> +       char *old_buf, *start;
> +       substring_t args[MAX_OPT_ARGS];
> +       int swappiness =3D -1;
>
>         buf =3D strstrip(buf);
> -       err =3D page_counter_memparse(buf, "", &nr_to_reclaim);
> -       if (err)
> -               return err;
> +
> +       old_buf =3D buf;
> +       nr_to_reclaim =3D memparse(buf, &buf) / PAGE_SIZE;
> +       if (buf =3D=3D old_buf)
> +               return -EINVAL;
> +
> +       buf =3D strstrip(buf);
> +
> +       while ((start =3D strsep(&buf, " ")) !=3D NULL) {
> +               if (!strlen(start))
> +                       continue;
> +               switch (match_token(start, if_tokens, args)) {
> +               case MEMORY_RECLAIM_SWAPPINESS:
> +                       if (match_int(&args[0], &swappiness))
> +                               return -EINVAL;
> +                       if (swappiness < 0 || swappiness > 200)

I am not a fan of extending the hardcoded 0 and 200 values, and now
the new -1 value. Maybe it's time to create constants for the min and
max swappiness values instead of hardcoding them everywhere? This can
be a separate preparatory patch. Then, -1 (or any invalid value) can
also be added as a constant with a useful name, instead of passing -1
to all other callers.

This should make the code a little bit more readable and easier to extend.


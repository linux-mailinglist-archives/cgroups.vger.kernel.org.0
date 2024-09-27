Return-Path: <cgroups+bounces-4963-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B1987D07
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 04:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961551F2482F
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 02:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AAB1667F1;
	Fri, 27 Sep 2024 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsLnB2n0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80690EAC6;
	Fri, 27 Sep 2024 02:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727404102; cv=none; b=hu0iH2nLHvvanaoCS0JxZbHp7oV1wt6iSvaBo+1Cy/GK1X+5cwQIS/NW8YXl54sseUwjl7QwYHycFVXzA6F3bpgocKaMpYuv9liK+1hji3eiUGBYLEexgPaWZryjIO1PrLeW+TjDm3p6VsphPD0MAj45kzfOzmPYKi2ihEohZpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727404102; c=relaxed/simple;
	bh=dPspyuPghP9GEiIwitpnKrG1ogn3PiVvy9w80zKIgMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/NavAp53CrwgcNh+/g93jmkIUgu2tmm5M1NB8db8YYBt+Nkr71zlb2uM8S0L4gtP6yh6AEW1i5RuD7dlxbq+5Cwc+pj9gu1LVQz6Z5uX44Vt9xRPipclMGWUyfxhFDtYjBSwUHo31CAeTP8Ok5xBpwpdx8uvtLAxJaz3ER4zy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsLnB2n0; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cb2ad51162so11958086d6.3;
        Thu, 26 Sep 2024 19:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727404099; x=1728008899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9O13VW6xIAn56yUlrhZA8RDOmDsOKO5QdexkzqK17I=;
        b=QsLnB2n05C8HI07SFM5JqE/kIrPhCn2dU4mRAsMaf6PnYfMQ9w7h9VuQOmI5ILDLXA
         uC7zMxOm7qUyH/9hSB3Sne1ouhMR9wnyUinm0s1rgTlKQlxHZMDKibt5yZPrRgojFtei
         9rf5iw0i4x+m2+kJVKVWcfWQZiv0j5rCR0SlZna09FSF8vJc/I++ynD5r1xFes7W2C3o
         K+YnYOkyQVlPFJ765R8KeoVOX6vhr8Ej5pI7gkGl5YiDwCq74aY7cm1MQdEzGZWD8PJz
         3LZhrksJlJbJvVsKkFFbuDQsag/ncjWHPsql2T8tNkZ1vCQV/JuyxzA2NT0iodX+Ou0P
         AILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727404099; x=1728008899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9O13VW6xIAn56yUlrhZA8RDOmDsOKO5QdexkzqK17I=;
        b=B3MRPRdjiCnJ8O6SmBLtfCPN/O41u8BdrtrcE4ngT0Fv1+0INLy05LGRp91LDrnp8x
         JNSIi60F9jNmKAsf2FfVsoN4TQ6tIeFhYl1XJ+yJPP+peVN930RSqXxXcRCTgzEO/FG/
         tYskdQZr6dwkqZYKK3vzV8x+s9Fb8PXiOWZ3gxtxg7RvA9oNEXZ4tZ6stz1gTJf8EeTQ
         1JIL8oJrRqwMO2gR5FDLaYc2Z4jBR4v1lEkwWMptSBFyeveqTGjYm8YW3+6Rg+gYu0bP
         eA2vHfAQDk4MPa9ngrf2QmWSgOnwN/2eZt/TeZa5S14aKILQYALA0xOPPZ1U979vx+/j
         1lgA==
X-Forwarded-Encrypted: i=1; AJvYcCUALzzG/3T1rAiYNsGvpyUZjXitA54caiqRJfYJ59L/ZpmD3TVOJ5a7mdvga0qvEvoOzkWfP4+a@vger.kernel.org, AJvYcCUWHMa/xh1wgU38a0rxM+R/Jo2KHD3ETDk/WC61uDen/WPONutb4OMFeP93RWZ6OkBbx3r4lUGNuz2C@vger.kernel.org
X-Gm-Message-State: AOJu0YygZDwzPjJUNLM0A9MTQUcSnvhWdq4pcI/MVlm8dd0jnX/2bgTe
	PaHUrzsgtQEAlor1nOvwVAuOTlkk13CC/Hq7BSNEfMQf9gKJ0p0+Q9GeoU260QgEbs7I9oS05G9
	W8M8BzaouUt9tpAdARYcehIe1Jmg=
X-Google-Smtp-Source: AGHT+IGZQ4YR8rkdKsmI3FP4EUN0n7EV1ZNRkvjTMTTlL/e4iLP5LMwlmfhZW/1Gy6JYibHBAEdJQTwSXxsfxY+lr+U=
X-Received: by 2002:a05:6214:570c:b0:6c7:c650:969b with SMTP id
 6a1803df08f44-6cb3b63daecmr26693046d6.27.1727404099230; Thu, 26 Sep 2024
 19:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926225531.700742-1-intelfx@intelfx.name>
In-Reply-To: <20240926225531.700742-1-intelfx@intelfx.name>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 26 Sep 2024 19:28:08 -0700
Message-ID: <CAKEwX=O=Qu4LZt79==FztxFjgBu2+q7C6EDji-ZmW5Ga38_dSg@mail.gmail.com>
Subject: Re: [PATCH] zswap: improve memory.zswap.writeback inheritance
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: linux-kernel@vger.kernel.org, Mike Yuan <me@yhndnzj.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 3:55=E2=80=AFPM Ivan Shapovalov <intelfx@intelfx.na=
me> wrote:
>
> Improve the inheritance behavior of the `memory.zswap.writeback` cgroup
> attribute introduced during the 6.11 cycle. Specifically, in 6.11 we
> walk the parent cgroups until we find a _disabled_ writeback, which does
> not allow the user to selectively enable zswap writeback while having it
> disabled by default.
>
> Instead, introduce a third value for the `memory.zswap.writeback` cgroup
> attribute meaning "follow the parent", and use it as the default value
> for all cgroups. Additionally, introduce a `zswap.writeback_disable`
> module parameter which is used as the "parent" of the root cgroup,
> thus making it the global default.
>
> Reads from `memory.zswap.writeback` cgroup attribute will be coerced to
> 0 or 1 to maintain backwards compatilibity. However, it is possible to
> write -1 to that attribute to make the cgroup follow the parent again.
>
> Fixes: e39925734909 ("mm/memcontrol: respect zswap.writeback setting from=
 parent cg too")
> Fixes: 501a06fe8e4c ("zswap: memcontrol: implement zswap writeback disabl=
ing")
> Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 17 +++++++++++------
>  Documentation/admin-guide/mm/zswap.rst  |  9 ++++++++-
>  include/linux/memcontrol.h              |  3 ++-
>  include/linux/zswap.h                   |  6 ++++++
>  mm/memcontrol.c                         | 24 +++++++++++++++++-------
>  mm/zswap.c                              |  9 +++++++++
>  6 files changed, 53 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 95c18bc17083..eea580490679 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1717,10 +1717,12 @@ The following nested keys are defined.
>         entries fault back in or are written out to disk.
>
>    memory.zswap.writeback
> -       A read-write single value file. The default value is "1".
> -       Note that this setting is hierarchical, i.e. the writeback would =
be
> -       implicitly disabled for child cgroups if the upper hierarchy
> -       does so.
> +       A read-write single value file. The default is to follow the pare=
nt
> +       cgroup configuration, and the root cgroup follows the global
> +       ``zswap.writeback_enabled`` module parameter (which is 1 by defau=
lt).
> +       Thus, this setting is hierarchical, i.e. the writeback setting fo=
r
> +       a child cgroup can be implicitly controlled at runtime by changin=
g
> +       any parent value or the global module parameter.
>
>         When this is set to 0, all swapping attempts to swapping devices
>         are disabled. This included both zswap writebacks, and swapping d=
ue
> @@ -1729,8 +1731,11 @@ The following nested keys are defined.
>         reclaim inefficiency after disabling writeback (because the same
>         pages might be rejected again and again).
>
> -       Note that this is subtly different from setting memory.swap.max t=
o
> -       0, as it still allows for pages to be written to the zswap pool.
> +       Note that this is different from setting memory.swap.max to 0,
> +       as it still allows for pages to be written to the zswap pool.
> +
> +       This can also be set to -1, which would make the cgroup (and its
> +       future children) follow the parent/global value again.
>

API-design-wise, this seems a bit confusing... Using the value -1 to
indicate the cgroup should follow ancestor is not quite semantically
meaningful. What does "follow the parent" here mean? Reading your
code, it seems to be "find the first non negative from this memcg to
root and just use it", but it's neither intuitive, nor deducable from
the documentation.

There are also ill-defined/poorly-defined behavior. What if we set -1
to all cgroups? Should writeback be enabled or disabled?

The implementation also contradicts the "writeback setting for a child
cgroup can be implicitly controlled at runtime by chaging any parent
value or the global module parameter" part. What happens if we have
the following sequence of zswap.writeback values, from root to current
memcg:

root.memcg.zswap.writeback =3D 0, 1, -1, -1, -1 =3D cur_memcg.zswap.writeba=
ck

Should we disable or enable cur_memcg's zswap.writeback? It's disabled
at root, but the first non-negative ancestral value is 1, so this
cgroup will follow it (even though that ancestor itself has zswap
writeback disabled!!!)

I think we should separate the values itself from the decision to
check ancestors. The former should be indicated per-memcg, and the
latter decision should only come into play when the memcg itself does
prevent zswap.writeback. It might be less confusing to make the latter
decision globally - perhaps through a mount option, analogous to
memory_recursiveprot?


Return-Path: <cgroups+bounces-11590-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8AEC349E5
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 09:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96864562A28
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 08:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56B2E8B7E;
	Wed,  5 Nov 2025 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="aHFw+XW4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9722C2E88B3
	for <cgroups@vger.kernel.org>; Wed,  5 Nov 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332747; cv=none; b=Ffs8mcPeTESvrBcGLpf1HVnhesrRvor/+HPIDSTt/7Hh2mrpUE6shdkybw+IgD/FrqkP85pU+AbP/Jp7LuXBvlHxDfJz6gYieJ8OTO0B/pEh7eU5Yxehp1L9rD9N2X8Q7dBoNRy4jG/QnItwqPd6XrNFPmcFgETwBeXfIHOms9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332747; c=relaxed/simple;
	bh=gp6ONkk4LnltkUdA1hEntsuPx28a5fC4wPGe0V4ewNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHSFJLFbsL2Pp/pfJ1/74xxsh9DuE6brclybIwc2uqdLdEcRbvMKwRz9Tqp7iEJRClvepLaUijQ+CYblDukzx8byZa4xrwPq1a/rYiM62LK12xVM1SzWaRqmGy93p7qHepxRjmelg/lajyXwalhJZxwLoN8LkKQz1TVztRrFk70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=aHFw+XW4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7155207964so512143466b.2
        for <cgroups@vger.kernel.org>; Wed, 05 Nov 2025 00:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762332742; x=1762937542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gkg/vCbQBbLgfYhLaxoF1MxQ4LNFqiCSVDKlCPX94O8=;
        b=aHFw+XW4mgvH2IW+imtB8XNv+Z3U80mSDKucZErMakceTCGynpaRjTwdXsIcbVac8G
         KZ5GJ5et88w5Tc5qsuk5y2eQ4qUyjteNXF5n7IgroX8WAx38lbIgI42gIR5G9CeBfWPZ
         KzrkYKd1nskvwA9a/ZK1TN4v5imG1MiieXqgf5xzfggaXb9OMMNJy+LmUk9smGhiKdO/
         kxmUr5xnsD7izLn/8XqoAOZ0el239ju43c3gBMPbnCaXv0zK09NtgiyWC3BOnWVILg5y
         qaYTlf84w5RMpqvFpzIqLOzmDllQ6c3/12YUTPhwpVJNWa8ySDruaG1xR39me0r2RmCT
         7bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332742; x=1762937542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gkg/vCbQBbLgfYhLaxoF1MxQ4LNFqiCSVDKlCPX94O8=;
        b=smZatH5HrZK3KpbU8X2716xd8AyTWsUgIxean7sD19RKclZesU7bbGx30VadLJHbRj
         J3y+lU8ZlcAer82Fy4BWUtTec4AfqqM/sJvylpFarynyCmOIzH15o/9cw4BdpnG91Zxs
         sReeghKt9YuX27X7mbKibcP6l6nMzH/1+DbTfATZKeQqV7/OjRe09mBbLQhZesOQGDOh
         9vdZg4SL1KtIivo4Bc5TeKndXcS7nN90s8BYBu3DSDwqC0wPqb8bLdiWjEqbWVQ6RwlU
         atXgAE75LxB2m1+/lTZwyrXDLM3AyvRAE71or2D+YJPc6iOHzQqVG0qtsK6ptZ7mr0lv
         4daQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqSFqFv/4ZKMjb/ZKdgO3rdrJR/tRSLYS0pKmFHoXYV8040y/WLlituALBe2XYi3S+Ka1O1Snc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0tWElBf5cDKXpvtWhLaEVebLqv8BwrC888MjtsSJ+SNCXXaGN
	jt30U+Qr+upltyObFy9gbCFib1Yn4oYVLmJUVURXbRJu89We4VMhABz4y8clGDXMh7EovZO9g+q
	rhbDDIEpNsovkcjq/323PKpYvscfa+key8Gsz1RaM1g==
X-Gm-Gg: ASbGncud8dLdb/VgTCOvSWVMzcimNsT0pKLUksL3qCiFFJVVpuOOLgN/kwqzMfp/frW
	P1VM1LbO/IIHy/UKUTmDA4OJT+ifp6/2ywihSldvJdynw3311oiuBiAwjq2n8uf+L8xQtbJmwhI
	u4Qu1qTBat360pu7S1Rfd0aPPTVVgFBgmwoPxHmHBahWc9OyPQq/7EPNzQH6gipIaaBKGl3lTii
	IlBadxZL5Y2T+zENkL/KTyeUFCUPEpjqXZy+q3Ie8Ot55qrf/nTcTUL3PZCNd8Ti3OpBg==
X-Google-Smtp-Source: AGHT+IFxxt2EdxGwLdk3L9EezdOqzEzIoElbn2uBq8KS5FKpSP/CV4oKR3J8eSFfaFisM3JEbR7uWvI68mpagt1N8hs=
X-Received: by 2002:a17:907:9815:b0:b71:cec2:d54 with SMTP id
 a640c23a62f3a-b72655a5d40mr200972466b.57.1762332741872; Wed, 05 Nov 2025
 00:52:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105074917.94531-1-leon.huangfu@shopee.com>
 <aQsIq_zQXMfNNo6G@tiehlicka> <19986584-885b-4754-b98c-948e4bf9716b@linux.dev>
In-Reply-To: <19986584-885b-4754-b98c-948e4bf9716b@linux.dev>
From: Leon Huang Fu <leon.huangfu@shopee.com>
Date: Wed, 5 Nov 2025 16:51:45 +0800
X-Gm-Features: AWmQ_bmvHlhc5eJ8ueTjqxVXAa3vivPGkX-f4MR8OhK4W12VAolYXW0qkjbzZYQ
Message-ID: <CAPV86roGZa5q1N95+ehdPRE6GkXr6bZbEU89--BgpOD8td5SoQ@mail.gmail.com>
Subject: Re: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
To: Lance Yang <lance.yang@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	akpm@linux-foundation.org, joel.granados@kernel.org, jack@suse.cz, 
	laoar.shao@gmail.com, mclapinski@google.com, kyle.meyer@hpe.com, 
	corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:39=E2=80=AFPM Lance Yang <lance.yang@linux.dev> wr=
ote:
> On 2025/11/5 16:19, Michal Hocko wrote:
> > On Wed 05-11-25 15:49:16, Leon Huang Fu wrote:
> >> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> >> index 6eed14bff742..8cab6b52424b 100644
> >> --- a/mm/memcontrol-v1.c
> >> +++ b/mm/memcontrol-v1.c
> >> @@ -2040,6 +2040,7 @@ struct cftype mem_cgroup_legacy_files[] =3D {
> >>      {
> >>              .name =3D "stat",
> >>              .seq_show =3D memory_stat_show,
> >> +            .write_u64 =3D memory_stat_write,
> >>      },
> >>      {
> >>              .name =3D "force_empty",
> >> @@ -2078,6 +2079,7 @@ struct cftype mem_cgroup_legacy_files[] =3D {
> >>      {
> >>              .name =3D "numa_stat",
> >>              .seq_show =3D memcg_numa_stat_show,
> >> +            .write_u64 =3D memory_stat_write,
> >>      },
> >
> > Any reason you are not using .write like others? Also is there any
> > reason why a specific value is required. /proc/sys/vm/stat_refresh whic=
h does
> > something similar ignores the value. Also memcg.peak write handler whic=
h
> > resets the peak value ignores it. It is true that a specific value
> > allows for future extensions but I guess it would be better to be
> > consistent with others here.
> >
> > One last thing to consider is whether this should follow
> > /proc/sys/vm/stat_refresh path and have a single file to flush them all
> > or have a per file flushing. I do not have a strong preference but
> > considering both are doing the same thing it makes sense to go
> > stat_refresh path.
>
> +1
>
> IMHO, a dedicated file like memory.stat_refresh is a much better approach=
 ;)
>
> It's cleaner, simpler to use, and much more intuitive for users.
>

Agreed. Thank you both for the feedback.

You're right that following the /proc/sys/vm/stat_refresh pattern makes
more sense here. A dedicated memory.stat_refresh file has several advantage=
s:

1) It provides a clear, explicit interface for the refresh operation rather
    than overloading existing stat files with write capability
2) It's more consistent with the existing kernel patterns - stat_refresh
    ignores the written value, and memory.peak also ignores it for reset
3) It's more intuitive for users - the purpose is immediately clear from
    the filename

For the next revision, I'll introduce a dedicated memory.stat_refresh file
that ignores the written value (similar to stat_refresh and memory.peak).
This will work for both cgroup v1 and v2.

Thanks,
Leon

[...]


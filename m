Return-Path: <cgroups+bounces-4257-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7699522DA
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 21:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72BDAB2461E
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 19:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3591BE84E;
	Wed, 14 Aug 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgGMQxH3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21063370;
	Wed, 14 Aug 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665141; cv=none; b=IV2u7OQG0LdH64tKYw4LVRTAoPr2HEcgTX2atHrWW3uqpO9kjVBKuCRXA8hxYobKw8hGFo7qWp0QrDiggdIe6fvctJFQskUkkigXa4G7P8+ghYB2V8TRWhz/BhEg1vICAwBZGXIdITmQGOsOMkjh6RA0vM+OAJTE4WvwaHN1PE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665141; c=relaxed/simple;
	bh=IeoPsrjRFuK/BstJVImPOaM8kWcJho5fxj+w3CFGxj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7SiL2yN8ZrZ+ahbvfm+unEPv+T9rKGR3aJFWl7h4qDtiD9u2mznH/NY6bXjOhGHOhpWmbDjcap9IAFLaQmNu4CpTX/xvNE7dTxRhSxOflYm9wFBydiqVkNWyWxQArvMiNA5P9W8PoAcjY3et+0SaG1W3e8zQKUB5oq5TBPycWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgGMQxH3; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-49762c3eb85so94732137.0;
        Wed, 14 Aug 2024 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723665139; x=1724269939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeoPsrjRFuK/BstJVImPOaM8kWcJho5fxj+w3CFGxj8=;
        b=KgGMQxH3L64VHwdM2o26LIdryKZnURPoRRTMkuJTx3gdCjZ0NgQtaviWa6PEPuVDZm
         7rJufQbFupDQLfC5sD2EOj3avjT7yO2waUA6nT6p2htJIFK6Vr0gJThYaRh1U+c1zHlp
         ul+02Cx0+AKQwcWYLJA4VQovEQhXK+r1LMTp3FHaF+rh+NkxCLu787qvGneYK2XwzwuY
         HDIqlOILa4KXPWips5CpY9zmA1pRK89Mlr/ufWo8Hicz/bFP15EEMBziozYZYpI0tjRO
         iITsYZ1xt/Q87J8HYn7LPadNJzN/BqVmd057Avz+7YVsKDtXKDdyFLM9ldSDdQgACoDH
         EQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723665139; x=1724269939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeoPsrjRFuK/BstJVImPOaM8kWcJho5fxj+w3CFGxj8=;
        b=M7zrXxVE7Esr36hadelz1zqwDHq6gAx7MJ7ZauoEjGkIHt5t1M9vL/l66yhoaa1cB/
         B7zjtJB/a/yWjocAhRO4vzoPPCQw2/tP7GiHyPhMJB6AlZIC6nvrPuSHPTI7V2Ludn87
         hWRsztPWyWyf9JvDHxdV9h+emQpAhdtGBWQh5Y0mggNv+5Q3VspMhrf0Hqodgl7Ziqpc
         /qHZXLvRsOCN15FDssKGz6YPbS3EuVI1EPpywR6DBH0WJAKxVXx9XLBftsxrUzSOKKnc
         UiPvLUZlT9IfiE3NDeBgQwMBf6FagJRQYRh6uGrfRvbJJRn2Tj8W9HazFTqMkd+MGPh9
         jTZw==
X-Forwarded-Encrypted: i=1; AJvYcCXW0WCim+qTj4LohynzLoa+2kMIyfJEFF03QuxH/znRx42lkgCj7Yl+EX5gOb0da9YhyOLnPoqqzWyvVHmduXlQq8j4icI/Bw==
X-Gm-Message-State: AOJu0YyD/xp9nKJz8e3+OUcgJ3Ydtjw3bmiOs8v/tMaAdfAtObcku1BL
	8WvEJ7tjU4+DSRe8B8tWB770ImGDWQHHjjNVHsVInJFQAorcI6rZ6qScKQbeQuR6gc7d4XG4w3F
	kRN0TUQwgvAmMO1D3zz6uGOFhSkM=
X-Google-Smtp-Source: AGHT+IFmyqM0n36CuBCgp4+9MlTTewpOjvy1XhbCATkx/SyHg8foHFQW1y1fhhdZR0oNy9184AxbZT5JpXLd37GpdXg=
X-Received: by 2002:a05:6102:cc9:b0:495:c53d:d6f4 with SMTP id
 ada2fe7eead31-497599d7602mr4427066137.29.1723665138763; Wed, 14 Aug 2024
 12:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com>
In-Reply-To: <20240814171800.23558-1-me@yhndnzj.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 14 Aug 2024 12:52:07 -0700
Message-ID: <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
To: Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 10:20=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wrote:
>
> Currently, the behavior of zswap.writeback wrt.
> the cgroup hierarchy seems a bit odd. Unlike zswap.max,
> it doesn't honor the value from parent cgroups. This
> surfaced when people tried to globally disable zswap writeback,
> i.e. reserve physical swap space only for hibernation [1] -
> disabling zswap.writeback only for the root cgroup results
> in subcgroups with zswap.writeback=3D1 still performing writeback.
>
> The consistency became more noticeable after I introduced
> the MemoryZSwapWriteback=3D systemd unit setting [2] for
> controlling the knob. The patch assumed that the kernel would
> enforce the value of parent cgroups. It could probably be
> workarounded from systemd's side, by going up the slice unit
> tree and inherit the value. Yet I think it's more sensible
> to make it behave consistently with zswap.max and friends.

May I ask you to add/clarify this new expected behavior in
Documentation/admin-guide/cgroup-v2.rst?

>
> [1] https://wiki.archlinux.org/title/Power_management/Suspend_and_hiberna=
te#Disable_zswap_writeback_to_use_the_swap_space_only_for_hibernation

This is an interesting use case. Never envisioned this when I
developed this feature :)

> [2] https://github.com/systemd/systemd/pull/31734
>
> Signed-off-by: Mike Yuan <me@yhndnzj.com>
> ---

Personally, I don't feel too strongly about this one way or another. I
guess you can make a case that people want to disable zswap writeback
by default, and only selectively enable it for certain descendant
workloads - for convenience, they would set memory.zswap.writeback =3D=3D
0 at root, then enable it on selected descendants?

It's not super expensive IMHO - we already perform upward traversal on
every zswap store. This wouldn't be the end of the world.

Yosry, Johannes - how do you two feel about this?

Code looks solid to me - I think the upward tree traversal should be
safe, as long as memcg is valid (since memcg holds reference to its
parent IIRC).


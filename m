Return-Path: <cgroups+bounces-5893-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723919F1BDE
	for <lists+cgroups@lfdr.de>; Sat, 14 Dec 2024 02:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959DB16A308
	for <lists+cgroups@lfdr.de>; Sat, 14 Dec 2024 01:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B125325765;
	Sat, 14 Dec 2024 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHxqLKcu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC626AFC;
	Sat, 14 Dec 2024 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734139755; cv=none; b=FPJHcFH4Jzs1R0fArwPrR9PlOcwvVsZ57/l+9FDS0mkLyA1+uOBbnlFnpmkhuYXDkSb1j4Io4MavyQe1RzoE6JrJwegsQTQjRNvCjPj9rLEHVUiiV7+ZF5OZSL+rVHhXZ4swoUBu37nxFEBGArfX6PwEVE/CpglXxYUoPQA2Vk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734139755; c=relaxed/simple;
	bh=4hUscQBSwRRYt9kBF/p96Az2eXar5FNycHLbwe+vqno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs54AOWxeMWT1Vy86ZFtX04shz497zRQ9EsbEt1yaQFHwcAWtib2c4MOdZ2C4Bmg+Q/YtVMdoPaEEj4Up8yBLAfLI6IX3b0f4J3yPO6N59dzGMe+g2gqyaNUoZCFF+XOxHR9O+QQliRj0c1OlFLitsQfjoznyjlG2ml6vHgqLbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHxqLKcu; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d884e8341bso18374706d6.0;
        Fri, 13 Dec 2024 17:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734139753; x=1734744553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hUscQBSwRRYt9kBF/p96Az2eXar5FNycHLbwe+vqno=;
        b=NHxqLKcuSKm+X+dGM79PI8gx8JEwjO5yR0qT5X3SKQVPGqxzIva/k/9AV0pPHjvKos
         w/N5/UK2NKNc0vg4xrHhcBumE6qQMstTW375sWNPfVyecKIuCYQzhcQc6V404J8Erpy0
         fFuq//NMWjmN6U/MvkQOPSvofPGVz3RKHmlrPW/Ct/Ya1KZ2tYybUWN1Ju5RvprBlLfw
         tkkncJSEREzuZOnQOvXBXL4oPWQBNAefgGkSY1V0bJKLWDEiQIoVtHqy+16HNUlImts8
         AHwiBIYsD+dAsGy1aFTCVqy8wjxoPKLBmiw7TCI5t5a4/5AbKwy8vnWESok3j8k88CpL
         AmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734139753; x=1734744553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hUscQBSwRRYt9kBF/p96Az2eXar5FNycHLbwe+vqno=;
        b=Qpr9COsjHN9VlH+NgYQu9ZChbC9XNICFiF6/D9qXUyD4hmgQxt93ejdF9cd+/QU2UY
         lKFrrQin7hqJa2OpZ2pUcUc5U3MT5/TbRgIwIEGriQ8LVm5+JTbn4EolcHp5IndvB0KI
         KP8dbYU3UDMRcXurBM3s1M+muNBW2bIGYfIMvsS8vSosb9s/VmjZUjXn5HZr1vPCVkwF
         sgtBJOPkjwK5Y+og4u+C9E6pkczORsapZj8OUvM0W+RUOjgmOSEcsu1rFFmO5+P1AbhH
         MQaCkTf+ju+N5F5LsbQ/84nSGB0pzzDPEvmWZyFVuAk1B1msO0Q8O4vVrAVagyzSJ3FB
         nTYg==
X-Forwarded-Encrypted: i=1; AJvYcCUrw84SvzNcqdGcdZ87DZj4IYgZwtyRL0t9BDNceG6g6P0vlhLqWtTSsYRpIqxyFd+iheNoPgwnQMSCjG3R@vger.kernel.org, AJvYcCWsZQoXzX2XlHda2lZK/Bj6PSoCqZde4TFrxCO05U7KwrKuqUPPDPOnSJhKrRTVOjC9UlEwywg2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4AF8bXFxSlLbB74GEB29tJkC7yjDAreFxWIskosUvctjKpB/U
	hZNabbHFEgu/OrbE7OePIIwwGcik0uwoil+yAb8nXMHNvrIJWgZOaQ5Nlpmj1AQOYOXaoo4ohR5
	a3hxpMmZY15sLN7qJ5ELDyE07imE=
X-Gm-Gg: ASbGnctAkuGI0RpsbPASrtPKB1OoGmRqayhzt4VvPxy8eALhRuuzhiYiiMhdH0LkFPu
	wT4qYi3d0heJj8cJveAZfb6gAejyym+8lysB7hTcmUij89A8Pf/hw
X-Google-Smtp-Source: AGHT+IF2SkaokBCI7EQwZihdLkI9OJeDhfOmaAq6AzuJ9bGEHqNuMr+sYNVN4956xebsUPf0Z+xplVm4s8RCkQPk6ME=
X-Received: by 2002:a05:6214:2a84:b0:6d8:861f:add0 with SMTP id
 6a1803df08f44-6dc96838d5fmr84769006d6.31.1734139752893; Fri, 13 Dec 2024
 17:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211203951.764733-1-joshua.hahnjy@gmail.com> <20241211203951.764733-3-joshua.hahnjy@gmail.com>
In-Reply-To: <20241211203951.764733-3-joshua.hahnjy@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 13 Dec 2024 17:29:02 -0800
Message-ID: <CAKEwX=MFF28pzxp7Cgjk_kDo-u3csG136paBxRc7hLTAVaksyg@mail.gmail.com>
Subject: Re: [v3 PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	sj@kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 12:40=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.c=
om> wrote:
>
> This patch introduces mem_cgroup_charge_hugetlb which combines the logic
> of mem_cgroup_hugetlb_try_charge / mem_cgroup_hugetlb_commit_charge and
> removes the need for mem_cgroup_hugetlb_cancel_charge. It also reduces
> the footprint of memcg in hugetlb code and consolidates all memcg
> related error paths into one.
>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Thanks for simplifying my convoluted code ;)

Reviewed-by: Nhat Pham <nphamcs@gmail.com>


Return-Path: <cgroups+bounces-8848-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C272B0DFC4
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 17:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC867B7B59
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D62EBBB1;
	Tue, 22 Jul 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TL/+QEoQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CAF2EB5AC
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196231; cv=none; b=e5VIULXlH3Eo6eqY4ao0LGNJxLlnWFRCApcgRFg7wRn/GAe9TKldM+MjmrJh+VPLACZICJWFeataOvSnzaFNwxDQ0nuRYhjI6E30I2sFbbO6Y95gTSfFCzz9dyM2mNTSaG6XZJL9U9p6NDbFX8K8aEc1rFi0kD97bkCcQr6gxKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196231; c=relaxed/simple;
	bh=m0AktCLJK+ZUuWGfQ+iSpRiQx815PM7rgLaWcjzgcEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIwrebWu59R24ljSD2C5ZkbDXkf0YvfWQmQVaw4D7YtOESMSXcsGg9tToChiqYC+fyJzVJUiqxMkzrLMOHJMzXP3IgWXPdVreyoTVyIBkHCbyFXajofUuhhHm/bt4KnB7tDX86geA2Nt6NuMfuM60XGpphU/WQqCA2NKx3I6w+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TL/+QEoQ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a9bff7fc6dso52722571cf.1
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196228; x=1753801028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0AktCLJK+ZUuWGfQ+iSpRiQx815PM7rgLaWcjzgcEA=;
        b=TL/+QEoQTvHHTqKVfsSawckKOBexZe9Hm20dESlfmBCYMNKoc+izJ5Dcexnj8J4BUm
         oP5bmepRZYfBwVlnMGPiTS0pKI7x0ZJr7TduCEiDphuFrJTrSqXLIPijcHb+qocD4Apb
         pRmW660zRre7Q8aNXWY14fz17dxwKK033KFUOyNZZcp8g3PCjtQt45FMnHyZXdizVbhw
         KrzNu3p+5QlWCasb1KI7U0A6a4u22NQkwuNKNl2W2jWunxsE8yI8UhQcnUn1Z5F5iQCl
         NepgOc8XRLf/oJfDRYLVlnKyylq861+vSIoE4QMT6NdLnrLpd7skz8E86WzZIhu+s+zj
         y7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196228; x=1753801028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0AktCLJK+ZUuWGfQ+iSpRiQx815PM7rgLaWcjzgcEA=;
        b=X1RgW6gzPSC5LeHI6wjkmye6+nNlIyBBlCVt5fZIfcJ9oomm5lpHSITWe5AgZIaBho
         whprromKyi020/I2SnjShSYUGLp4sT4JJ5DywgBWNpKB20BkVUUy8/mcF8lVBV3OHFyd
         bZPXp+w9SJOs4HrrGr4pUv5BxLscv0T3m1YIi768ZHX7fYhA+rS9OCnapjRJeeEgJ81B
         7JRea1j96x2G7dmDjMqG5lNWHupTwOfoiNpTcbXbud7F/RQtuSHTwakY9Sf+VwOH0/JF
         GeC3E5yul9bN3Q4hlL/nWFUySn/pYNTFTV/7lJ0At+LUx6jc42lxfY/Z0OqbaioICX3J
         p8qw==
X-Forwarded-Encrypted: i=1; AJvYcCWtJSlgCXm8BhshslnUYAbkXTEE8OaXhVzPix1pgzlA/gPHUKaLyrTziRdVtwuydOE7Nibv7PmD@vger.kernel.org
X-Gm-Message-State: AOJu0YyoY0nyI+OAPMK+BBNUPWLH97lijPPDY+zuJcwWG0jkxsfV3KxN
	QBNjIaUbVKQzu31lXDZbO3tQize158aJ6G3NRP47oYlTndQ4CJhOVo2WrAtG+CqcGbkId0KlV6H
	vhtDvoiftDwr/z5oeeGCHXkZT3wmbztCckBALeDVV
X-Gm-Gg: ASbGncu6qyQw4NSm0JwaTs/v49W8e3nGwxt5labUugJpKSb3RT55AYdOQNsVl9GySh8
	pgHbq8863VaiDKH+81N4ZJrIN/tpiCfnfozRCRjvjNhBts+tI6/FCOo0HHU788C/GzJTE5aHFh3
	uzPFD15/BTGnfKbl/lulBU5jyfMWsdCQQQqHDliEgoAjH+IuUyRIETllH+GJDaH3k3H05nyhgFS
	8nlrQ==
X-Google-Smtp-Source: AGHT+IEsEV3GGTDTdmiKaik3AqH1VA1TZx7fA6+/n168ze76wf/ZMKc7syZqUWj6LZzqN2/qXmVi5AZltoQwXWaeFfU=
X-Received: by 2002:a05:622a:5514:b0:4ab:6e3d:49b4 with SMTP id
 d75a77b69052e-4ae5b776852mr47163651cf.7.1753196227557; Tue, 22 Jul 2025
 07:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-9-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-9-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:56:56 -0700
X-Gm-Features: Ac12FXzomuVijK6Zq5KT2dKkSJnghXUcZpgHafRcifrYJKvhd0CQdjVZBQvvh-E
Message-ID: <CANn89iKC-RJg8Xi1o6Ks4iCgrrwhvYFxDGwtXN0q0KM6HqAs6w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 08/13] net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> We will store a flag in the lowest bit of sk->sk_memcg.
>
> Then, we cannot pass the raw pointer to mem_cgroup_charge_skmem()
> and mem_cgroup_uncharge_skmem().
>
> Let's pass struct sock to the functions.
>
> While at it, they are renamed to match other functions starting
> with mem_cgroup_sk_.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>


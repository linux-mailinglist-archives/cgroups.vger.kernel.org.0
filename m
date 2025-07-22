Return-Path: <cgroups+bounces-8843-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7AAB0DEFF
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 16:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E209AC5335
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA54D2EA73F;
	Tue, 22 Jul 2025 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHMpSN1X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ECB28C017
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194886; cv=none; b=NUThcxCF/Pmnt0FiKAFrJ2UAUtcF1xdk6uSNMR4aeHyG08Jei2eKNwR+HTeK6o2MNoaeOhvUDBxIghAA/zIbW2YQROAO1F3iLKgze8q7Iy2ALs4QgsSRIocf1dXS0stHFZCs0Zsm0kv3ixSqet0eaeSTPug6CxyybKl9SaA5BGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194886; c=relaxed/simple;
	bh=k1yUYuQxhxPejZAVd5Osy9ksEslSrueRAJCbWso5h7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ym/LZSrAgT5LIxdXMpba264LBXGwt/xLXNHFtkGKMmmj0LfJdf4Qr+o1tD6BlVu0xXGXLz+cx3wBK+An82z+PX9Pnj6KKiIFrhJao+UplODRg6DV2lWuIErZZIFjzd2tdeopaN+Ho1i4bh+MgxEw9/C7la02AaYZni/8bWDV4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHMpSN1X; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d5d1feca18so524690085a.2
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753194883; x=1753799683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1yUYuQxhxPejZAVd5Osy9ksEslSrueRAJCbWso5h7U=;
        b=fHMpSN1X+SXV4QgfglrLMmyPPc5DkwXoUrTPx2hzXGivYMkwkPJAV1d83wztaIf0FN
         xpGXqBh9f9ovNHjTcPImxd4TrWbvb47Piv6H8b4l7BwBDhb5EvIvVCCxgFMksvpLa6Sk
         kciAyA3GDXMANCtuYzOZncV/XCxl0S53HymHVJ7JeXzxH8/LQXIn+a/TkSth6MWgsv4W
         IW/+fRUH2EbT4t1wYb2ZbTulJn2ZDU39cFh6dFqrhzF5+yHh/s6e+8VKDtQqjcv2OZnW
         JEvVB6VRGy7TKMjOIp7kj7S+o+fK6Z7jqX67P8fLl0gHrNpUYCaaub2S4xB+pLXbuWTc
         jIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194883; x=1753799683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1yUYuQxhxPejZAVd5Osy9ksEslSrueRAJCbWso5h7U=;
        b=q9ooBCVJplft8ToBGAjXahzm02+tpd8N1JVIcIXgn0Bw+QAV/u16R6IqvKDOahOu8Q
         H2Dbe9ic3xncFt+pBjJd/qDHdEhgbdrMij6yrFqXmByyN0kzCFBMyONf+VJH8E5Mye0q
         sYrLQ+grkykrnbqfMXKZ+Hw+4SyUuMjFmC3QYudzYPBp0U/r+bnuva7zk+oU4x2g+i2C
         YQLFJk4RKo5fFRG0ilAEGf9hKnz68Rr4oNPTR+Kiq3nT1tUscfpr1PcrvlK3jaTx0uVM
         H7vIGfdloJYTyk+SvVJakq8Ub2f/94Be2tzR5nW3mqA1f4l8RYk50O39sUuZkrucl3eJ
         xoug==
X-Forwarded-Encrypted: i=1; AJvYcCXYwXf9D7ktZRJtwaWSFXplrvcx974+yUyksrv+mJJezSY0feWlCyd4NuSgzeZSY67zurjBgG1o@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm3YfKhNirqF1tkFuL9bwldZGn91gi6qMG5kSsgvnAFwCACJTM
	6QMfyP/np+cQRK2hgwnCReTYO7meyy+qYPV65ySIlicNYW9NqBnISviO5vtLk9ZvfmQVyF4VcbX
	GvES4HOHYJ1Fpngn68Jom6q2xzV9I+2mcyfvIohx1
X-Gm-Gg: ASbGncuueSxTBaDWO0CvZva+ntrROCtdmbhoI7TQmN3M9A/9R5sl2RTX84fFyOPDMkD
	i6RSTGcRZ4Zmvgi0X4SfFEPnCpM2RgpZw7RZee+UeBxDndTkc3EAUQXVabD+8Pj1eZLbBG+fqgM
	IsJy8YIWjMrvNceHgRLb2Dy4PhaCeSwgX8VVt5uZr2TIrC8FTnAg718+N6Yk77tp6sYXGuXr79p
	p35nw==
X-Google-Smtp-Source: AGHT+IFiji1w7r7AjCXlHaxfMjOrdW8jkVVGDDlvc9QhWhAg0vDKfADaHSk4qJ9skd7E3tmPFXgzgJZBnGJrSQTiafg=
X-Received: by 2002:a05:620a:28c4:b0:7e3:3ba7:f072 with SMTP id
 af79cd13be357-7e34356b85bmr3408946185a.13.1753194882975; Tue, 22 Jul 2025
 07:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-4-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-4-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:34:32 -0700
X-Gm-Features: Ac12FXzGLru6M1-g50J2KyQVjtZB32-ZEYTqBFpNaueaVx_KJKwNZF50EJpN3Ps
Message-ID: <CANn89iJkNYHLGqXCTFgG2rEp3S05VVkWi9=2HedGqqfw6YF+uQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 03/13] tcp: Simplify error path in inet_csk_accept().
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
> When an error occurs in inet_csk_accept(), what we should do is
> only call release_sock() and set the errno to arg->err.
>
> But the path jumps to another label, which introduces unnecessary
> initialisation and tests for newsk.
>
> Let's simplify the error path and remove the redundant NULL
> checks for newsk.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


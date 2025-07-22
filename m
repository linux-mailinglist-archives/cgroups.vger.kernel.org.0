Return-Path: <cgroups+bounces-8845-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4741FB0DF21
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 16:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAF51C255E6
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7800F38FA3;
	Tue, 22 Jul 2025 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jghAnaIg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D628BAAB
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195097; cv=none; b=QWBVSbj0iy+9x8Uu8W3F4tHfQ3uyOOVEhKB/i7HwlKsvrW5Ab2RtoE39xWWUrn7wv3tH8a+iGiFDIuDVIulWiLFxCi+DhwNEisRJva8kBYVdsxmUIu8UOtfalklSQnAxTvIx0Bm/ZLxIF+KLTTxWEW+PjzNuIKDsm856irymsgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195097; c=relaxed/simple;
	bh=os2DYnIMBSE/kMJQ/4ssNfzgbbajAEFKtkzZf35uM/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgDoyYyixPosxkNwqr4fPdcufc/ijRtVZKH0BjRNGDFdLurRqX6G2B/11Ii65hckx+pc/jxyYH3QjR1wLhjQf6HyHqBuACX1ulTvg3KxDHVVVqJkTMz3DmK0umrMFhDzcd8E0qycdhj/eroJJAQwbauVSEHvCKC/PKX5kBNuQkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jghAnaIg; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fd1b2a57a0so52585976d6.1
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753195094; x=1753799894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn4gJyDMnXhPbLwCQpWenpbaZRFD72gmw0empnN1AaA=;
        b=jghAnaIgRXv26KB6kY87bQyminisZTw+CJDHgZPgoPlaNbTipJZdw2vgEBewm2vrGn
         edlcehx/DnVfKLfg9yrUPfxgWGjjljz+85YhD0/ACY6VtqAHmMWrXAFxyVJ5GlwHODEr
         hsiwcSjj7HlW/NYeXZZbi3O3cyDEPuYc74riLXFtxUwdtrk5JxdTh2SZ0xCoUWiohxL2
         tPXhMOtA+fxmoY86Bd/ItH4OByGbD9PVzvieVfPv9cenQRchTqUNC9XruBsmg8Fzvteu
         o/c0o99PCybIlgNwl/6CzGwEYlJm85VI2uHtmdMzhPUzOUk6mFDfPH+ZaxVW2dVn8MYs
         jdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195094; x=1753799894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vn4gJyDMnXhPbLwCQpWenpbaZRFD72gmw0empnN1AaA=;
        b=AdFoNG0siPH2IhNDlZGJqY6Y1OUYtOfJAaOM8L5jhHnwEWlDfQXZK0BDH5GtSWYd6T
         UkyVGEtTaXiJZawNMOfg4ZItT28sH8ZFm7HzdWtO2xkRkBc9588dF20ydtZd98tWi67S
         b8f2BN2IOJeemr6TfyPSJNYrtE+UrXKYu1BXHy35v/mXugj1e75LkMf6MgGjPxrsuOZw
         YP4ORTq2djl02aeuBOoqwK+0LbuPTzouFgB/36dpExh+23jS4y9YFhHdT4/EP8ujKcXB
         ilbyfrOiDpre+Vcnf4VLIHjxiBjawzEkscM+T0Ulhl1K2TD6OkiMObY095CHd0j96J1c
         3Jeg==
X-Forwarded-Encrypted: i=1; AJvYcCWpJVy5k23ZHY5hPvNB3AERS3m3EPPmn6orjibswE3jgNmgtJuOzPh5hlyGwLfiRBWbGR6QCmsD@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEm1MisWHHkQfb/A7Ovq56AG1cC+KpxrhA4IdZOySn2NyEtxu
	tYpomMQVMs7ds2z7tJLA+vBTpAYwn4X3dbUqtArxlCDCx9b1qknUyLXazwlSEKPu4eyA+wKM+TS
	B8Sd7rtIQFAwFSPcYTjZDCghlTjkRiX8KiAww69ne
X-Gm-Gg: ASbGncvFvimyoxquPTatUzpttrxA60OehNy936CxCDGOVGpgIvGmFWb7Q/ueM08qnZ/
	xCmB6xYNcSx+2i9e1jOYIs88qIz8Wml8TaV5KlXpkrnYv5ZwF9vq3KxKUQxhN1XI1YkD8Gg42ww
	JTe01wxLFijWtpPkqyGoDOYB+vIcwQmxzy3F7zuYXHGW2snm0IDSZnELOW1w6MH2iATgI17Sugq
	UJzEw==
X-Google-Smtp-Source: AGHT+IH7wiXrlu0TBmC9UV2qMcDz1px3wXYN9maWZ0wBhcAItzqiY44+P1BWoDs4fyTq/fL+do1VMmfi2vruAWutpv4=
X-Received: by 2002:a05:6214:6207:b0:704:f736:7353 with SMTP id
 6a1803df08f44-704f736739emr250100436d6.25.1753195093977; Tue, 22 Jul 2025
 07:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-6-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-6-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:38:03 -0700
X-Gm-Features: Ac12FXxlsXsI3zGI0AVZPAQnuIlcT_-ASbHpDgM34ehNdBuFJw1M1IUr8BHKjK0
Message-ID: <CANn89iLBoSc+x2n0w44HQp8CKumWBkqgYQEOi-enLahFTY02wQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 05/13] net: Clean up __sk_mem_raise_allocated().
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
> In __sk_mem_raise_allocated(), charged is initialised as true due
> to the weird condition removed in the previous patch.
>
> It makes the variable unreliable by itself, so we have to check
> another variable, memcg, in advance.
>
> Also, we will factorise the common check below for memcg later.
>
>     if (mem_cgroup_sockets_enabled && sk->sk_memcg)
>
> As a prep, let's initialise charged as false and memcg as NULL.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


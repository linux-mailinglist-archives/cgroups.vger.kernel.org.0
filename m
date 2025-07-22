Return-Path: <cgroups+bounces-8841-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C161B0DEDC
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 16:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4F9AC2DE1
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D3E2EA75B;
	Tue, 22 Jul 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5YI68Pw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8CD2EA743
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194624; cv=none; b=uTeHABSPQ18B/rgrv7+Xy8UTOeWqBszmA7iuI5e8kt0ytWCs+pVN9jc6xCMei9xrNUGXwmD1qy+HnxTcRCFOaFDgwxzSSEOMZ5M2/VqWhBsqc+SRS8lUygwTWhBBCeG0OeyzlBVUGNGehcRgtQCe4HA0alQR6GkENPce22bM8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194624; c=relaxed/simple;
	bh=g8o6ReDW6MUKFXt64vm9RKofRiF0JKVVbYD+Mf8uO7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHud9J/p/ZUPffStpG/fCG8yRwNFo3hIHgoyDLJg4ohLx3iaxkeoqID5dLoM+MKqWev2yAMMBbrONL9IBwYMKl+4RdSxw+UM7NltXWIrseuFhmIO9/LJXN/2xBb3vO+EPshIo91LMBy7jIEDK/VJ9oyrztncIKLomnFFXZe2QRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5YI68Pw; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab81d016c8so77044141cf.1
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753194621; x=1753799421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs6B7ByVFqNhd4M7cO2OVqmSjId/nOtkp1oMTcQiG7s=;
        b=O5YI68Pw7Ft09SDA89dg0lM0wSWaorYLt7ZMFgrc3cgIE0DFheqOb5L58AHRfgQoPi
         hYOfnF4yEW71NhnBK1S4b7YhBiXH2epJTuaK+OfeR2gVLO3RuM9kQuYWQk/QhukxXvGm
         KoSvhsvvomFaqZL8PVl47+6WZ3A23kuQDaazbQB+KHE8x6OfJFQDJLZT0sF5h4bGErfN
         IDRabn3721t+9uZZQS3W3Pq62d7ZGu4DEdeVLoT0ioi1DzeXkuZM93VO62hqAzcGkpAS
         W9KmIdqL6o7oHCRqcwcvQKkxk4G0mj94h/QEwUUIf3DFZ63hRP1W8iw0G5GfkaEMjbfB
         5cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194621; x=1753799421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zs6B7ByVFqNhd4M7cO2OVqmSjId/nOtkp1oMTcQiG7s=;
        b=t+RKpLv917xutM2rR9tXmwptDsZhQRvzBmzjOjcDfwNbcd98BuCBojxw5ZPibK3pLa
         vdJwG1+CZ1u3h9mOMblnKkrlze0g5lfOmLQ3aIKp3yZ5x7GpS4mMu7lD0YHEkQzyGGTw
         GcX8zwu/k6KFUwL76pT7zRaLgzbsjbS6jm50h24azuIb+hq9yHsAMSwadvnzSAYIY5O4
         EjHopuZ5fcDnPaydFMXsFCCkE06tyw6/JpETbqOnBMl/mOx8tEJZuohUIJod/rf2zv/x
         VVGotArjPP3DWYlc+kJdp1wvWbpdQFjDl25jjECBmPf+1WBI+2rftyYYTKHiRVjVhAh/
         Cn3g==
X-Forwarded-Encrypted: i=1; AJvYcCWkmM7y+1a647cYt4UBb50swdihXWAd4xO/nJ557cO8yFsjgNoU/fqMX6pZGSMgLtFDBfiuKQ8s@vger.kernel.org
X-Gm-Message-State: AOJu0Yw36tbcNcAW4XYTCbucPz9gbRAhZLGclqJUbOjrSFG2ma2ig7fV
	nIS5jJEx+PonDVGKgjhLRv87JInJLsEqArpozxTyd1fkyFtGbv4pWe6LZPK3JtI5QpCcCilfW2Y
	/pYrGrVNvSKCA+rwp/P+V6pV6OarYCIwmpmBC88cw
X-Gm-Gg: ASbGncvO2Vxx+2RbmHNVDUALE9azfnWP6+b2PEuRUAa3LwoCnqH5pYJOapPKClw5cYg
	2iUDHDGMuwxX94jHbBmwNFsu/3yLIbsPlhHvStRsjaZKSHupUKSPe10M8wKXKvPdVZ/oFQat91H
	Z0zDG6HhyIIz5AUJT3mHF0T12d0HCxAg9PyC/A8uz17XRZF4CylqQrLO6Z4/jMZsgwbQ0DytNmD
	o0fO5I24j4/EIX5
X-Google-Smtp-Source: AGHT+IHQ1F/XNS6EEtYUtpk/olOEZA/Va6cGJiS4hiBQzXMnDQFWPRfhrIeUbeCE+v3wAGiJbMRJO1Xiv4/aKrsvrGs=
X-Received: by 2002:ac8:5d4c:0:b0:49b:eb1d:18ad with SMTP id
 d75a77b69052e-4ab93dbed7cmr383658691cf.41.1753194620995; Tue, 22 Jul 2025
 07:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-2-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:30:09 -0700
X-Gm-Features: Ac12FXzou9QrF6H0tl3cLlJlr49JVeNU-g_6k8oOer2kAmc56xaiC2vvAezaFAw
Message-ID: <CANn89iJQ_CDgAsDQ_cZC=fJJ9Vk5+Yk=RmmS=r3ds9abOqr-nw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 01/13] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
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
> When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
> sk->sk_memcg based on the current task.
>
> MPTCP subflow socket creation is triggered from userspace or
> an in-kernel worker.
>
> In the latter case, sk->sk_memcg is not what we want.  So, we fix
> it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup().
>
> Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
> under #ifdef CONFIG_SOCK_CGROUP_DATA.
>
> The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
> CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
> correctly.
>
> Let's move the code out of the wrong ifdef guard.
>
> Note that sk->sk_memcg is freed in sk_prot_free() and the parent
> sk holds the refcnt of memcg->css here, so we don't need to use
> css_tryget().
>
> Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


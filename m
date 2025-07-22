Return-Path: <cgroups+bounces-8846-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D51E2B0DF37
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 16:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB1E172BF8
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F872E9EAF;
	Tue, 22 Jul 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mB3eQuE7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614A828C5D8
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195164; cv=none; b=B0Byc8cjo8tiirsbJ1HIgJJo2ckmXGSYPkNXrvbGHtUNbOhpf9gepGMluJ//5itqWJyDJmOTO+i5HPbv4o776SzY+VjVt5cj7pJ8jvHc0QMZ1xliVK40EPk6f0CSGbz6qwuRn9eX7LrXKsoNSNm1MBkiXzJYVOQ8zzcWXefsDZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195164; c=relaxed/simple;
	bh=TfOWjAAjxzaPD6O6dTqgvPQKFnlN87Rl+iS0j68i0zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlbmHwQj2iNe2lBPxNLkheblad92iHw+Y5Dc/wfd0PjuVhImH/jfc3K4iuFMRPsTp6aSB25yAVfGQoaPGjnfrY3J5ZVU5r/T8DTYjZ5jVGG76YdyM8JB7co8qyj7SC7v+g44HhREH3O4a+iszmKyS2G19LU/Qa6HKFS3NEMjg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mB3eQuE7; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab39fb71dbso66454391cf.3
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753195159; x=1753799959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfOWjAAjxzaPD6O6dTqgvPQKFnlN87Rl+iS0j68i0zQ=;
        b=mB3eQuE7lXCB+C7RLxifwxwxsK0e+6hdHNESvYza9jzHlFqE9d1rBD68Ln98rXCZFU
         1krkC0Vr8d8IdkLWK8EZaWG85CuieL/5cGOcerOmrPX0Kh69oHI5CLEGAmwu38SCxHF5
         fJRAms0KdSZErVwAoRGEkNc5P2JHi7XIqgx1HypuuWMYYgnhUyAkH/IewGWgtm4AXCU9
         6SJ0PznkhZd6AvE3Rp8nw3xRlQVRe/zEklSF+zswZSMsIYzNnG5xKOzBnTbWh2czQQKR
         +IJ+c80g5nxvlb3dh6oTVx0wIsK+AJmi79H/ENVIK969pOToTwrNM6CmiwEfg+gRCnAe
         hQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195159; x=1753799959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfOWjAAjxzaPD6O6dTqgvPQKFnlN87Rl+iS0j68i0zQ=;
        b=QA8M4mgNvbSH03XcNJQKY1Cu4jmrG7CcSttXqUL6cPbGvsdmhmnwe3eUaBEyIApTAd
         5fCGTQmNNVz9ONSZ9ZGU8b3nVSHtNj5uT0NmyAn2VnUAB5qLv3bLhUui6cOm2OpxrlJe
         DhQZf7qVuwjQuKNc9oJLaQ4Pr6FlUyRtntjW7Rnhy4JYJZJVfMgv6UMLxnMgJ4NpRod2
         6ktTuTfwLlyoERF3btTOu5dF1kZEwvbWyt+IAKnkM68Mjc6OuCO3Dak3JB1QsrbT/qrf
         Bx5lkm9YGvnwi2mauR2RSdA2jrWfoTs3zUp1SgbIqxRci4TSVxBlumPkni3XKh93AFfb
         4RyA==
X-Forwarded-Encrypted: i=1; AJvYcCXEQ4yS3uEjRGT68EYvdN8TiwC8wVkgYcA9ErBkdWAsaR6Tx3PQxCOVmA/h4PXSt6oDee1PqWoz@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlk09RGASvjnUJqG7fR1ZyaFYkarsxVW4HLC2F2L6NgBG3hT8g
	65F8KTpyJ3Ajvo8oXhyH8ftknqUc8izO36DTvXmi2Te4I6NAKfLhGUxms7cgFhFygV6OO7WekRQ
	gGox2U6By3Za8dvMyWE52oIrAwu7mPGxFy2YfIP/n
X-Gm-Gg: ASbGncuZXhI/Ao2o2u75w1hOugsKIzqdEKvHxe5hA0dzIwBaKleSPUZnpblIZpf89K0
	/9Zu1dzx1nEvIgp0pWYf/gM0J9GDTkdH2QmQEi5dr5wBmmMbSinhQVpkX9r1IeN3m8UsV+8JhK+
	EC0i06VzcTpLMVSNT04KEk5A1/5lo0xV9MvPmPl/8GduL3UMIk/7YDxnOAPUMp8HEH5ocLmBoGu
	rhmW5w5yJSlVD58
X-Google-Smtp-Source: AGHT+IF/6P41Pb82F2ptVRkEzRWcH/wqc08aOFULaIn2GgGXH6mVUvBywwrKZk8BZMD9A0/6nMaxFzoslrPlJkLFRIo=
X-Received: by 2002:a05:622a:2303:b0:494:b1f9:d683 with SMTP id
 d75a77b69052e-4ab90cb6a40mr389467931cf.49.1753195158828; Tue, 22 Jul 2025
 07:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-7-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-7-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:39:07 -0700
X-Gm-Features: Ac12FXzzmBrUziOnhdn3RLzTJezLALGw-_Gmb0DoUXsN9KTiXNdnxPTcE5y2_MU
Message-ID: <CANn89i+qss82KMGJHKf-uMgrwFHXap9fs67+2azrNeBVpsVodA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 06/13] net-memcg: Introduce mem_cgroup_from_sk().
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
> Then, directly dereferencing sk->sk_memcg will be illegal, and we
> do not want to allow touching the raw sk->sk_memcg in many places.
>
> Let's introduce mem_cgroup_from_sk().
>
> Other places accessing the raw sk->sk_memcg will be converted later.
>
> Note that we cannot define the helper as an inline function in
> memcontrol.h as we cannot access any fields of struct sock there
> due to circular dependency, so it is placed in sock.h.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


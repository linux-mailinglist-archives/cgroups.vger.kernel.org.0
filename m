Return-Path: <cgroups+bounces-8847-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01976B0DF3B
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 16:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D5C3A8D3C
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582AB2EAB86;
	Tue, 22 Jul 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="thD5e4Md"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93FB2EA485
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195242; cv=none; b=V4XcFoMgYeWxFVPdzmn8Smi5AVYWqfRVtd69o/e3ltGFcA65/8TbZUSj1WgJ5U25V/dJ0GVkRaWTdpqY4QJ3BkYTO978mocaeEwWvZwGCt02WLgzMptgdUz7hS+gE+MQB73n9hSgIvt7fqVlPT8N5WkqmfHGXXYSzjBcsj5a9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195242; c=relaxed/simple;
	bh=4mYD7jOdcf5aFysRdnyjEGsG+qd6blmLlEJCLBef13Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcL1g8MLgckBB3JREnYKb997JLI+W7e4X2EPrhcepSRwZQMLoC+pSJ3TKn4N5AdmQ5cl7MdgPB7zXvEXNijzmb9kVXgrOluZlQfuWwaHsXbgYcQ5wSt8qUl0WA/aYaR22a0Ky+vlMr1TetQEF2URfPvbkfP5bjcBd14/XAfUAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=thD5e4Md; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab71ac933eso44554791cf.2
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753195239; x=1753800039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mYD7jOdcf5aFysRdnyjEGsG+qd6blmLlEJCLBef13Y=;
        b=thD5e4MdwcRjx418RWl/C6obm6caRo7yqimJiDXQ2UiFvzQKUCQ+TZCx9fIOdWH44e
         +1sbt5glpU7nRhWM84VLNGn3Ex2ziNzR7Fi3JLMzEPiEaV3deN1XNwWN9iDLAqAeapRc
         gvU9upP3sSUdKlaUQTU+Nw1T1Y7jxiNsk0VscY3S2fWLItw6Af7PG8NadKnt4kfR0Zpt
         ed+cyR7nSZyHDEziIT3gtX+4gDDrxmxWY6AHHxAOhczhR8lHa0hJY2i2HTdUXAlnGpeN
         jk0IKl+JMWe1SUrqnUaL77qJL7OAKMiBpzSiSRfRDdKW5s58qklEz0R0063unoH0MDFs
         Ca0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195239; x=1753800039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mYD7jOdcf5aFysRdnyjEGsG+qd6blmLlEJCLBef13Y=;
        b=tlrieykELdJfD1/cLxC2OUEjfDW0Gxuf18NMHoKTtG1qCj2rSBA6uCEig5yDMPam2R
         uVLaEVgeiwTH12LC5Cub1OXLFWjx4HfKl3zFnUUXQTzrlM8/bUwiP5870CFIWMgZUU9p
         glG8QRzs9ltpMvS4JkSOAa4Bky6jymsle3ty9g+sbi6MGxW0XKvBsPYUmOYfp4zj+htc
         6ZizXOdZLsYPJDJCm1AjhDNPLSl/CDj2Vx3cyOtE/UIQ9ehMw4MPIJf0eAPEEs51pdTn
         V1qOeEs6/RKh1/NI3jo8mHd/mJRFGR+tYTio1ucV6wOQUDSV/V4+Cp4z9btz1doZhgCj
         U4gg==
X-Forwarded-Encrypted: i=1; AJvYcCXBC7VP01+fwLyYVbT7/9s7gaDx69XjSHVuXXpLJhEazh+2cCn095ZF2CLzWgWX8ZijHmj3JRX7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcdep8UL8TYFtOStCH8f9mOh8uPniZJR/r03C2azqtpxxNnhRM
	U5LOYkS5kDtvyzFWgOtwgxVVfqlNQ4Mzn9FBhXS3lmeJ7gNN+WPg0SXZFwT04dfYpKniMogHvT5
	hWYBA6M8npKlwJUVr7z0g6YDc0PnO/jNcW/uoSAa+
X-Gm-Gg: ASbGncuNqTqBQQhoh8nm/VCzfmi4B9CceStPYPNHmhMP5c3WyLh16MXE39Gec4z2Ost
	s+Dlm+HxKfsoAxSbX4n/KM/zfvM9iERJtHfdqJOhay8wT+7vXVilcmI6xveeaFsmh6ykVI/TgR7
	5Pshqw8OHIJMR7qh6Ak1/dT8wI5c+gAid2yQwOSHft8N8SvJSetLBD7xppjM5oS5ciA8/TVhFyq
	bJpbdCKy2X1H0CW
X-Google-Smtp-Source: AGHT+IFZ5x4jrTTIZ/sGd3+42jtNM9vA9GRL20sU2/Os0v7FJS5rj0L8KeTwvfFJmKz+wiHNsfD/xtdlAAVmvq93h24=
X-Received: by 2002:a05:622a:250b:b0:4a9:a90a:7233 with SMTP id
 d75a77b69052e-4ab93c9cf1amr314039221cf.12.1753195239084; Tue, 22 Jul 2025
 07:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-8-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-8-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:40:26 -0700
X-Gm-Features: Ac12FXzTeElONnU3WaxKpa2K4YFqUCuJ6KHpalFp0jXckJ9R0eBW0R2J1Duwmhg
Message-ID: <CANn89i+XTkEfrLdJJa88n1YWPapFAc_OY7L0kAPO-z4hsqjHhA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 07/13] net-memcg: Introduce mem_cgroup_sk_enabled().
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
> The socket memcg feature is enabled by a static key and
> only works for non-root cgroup.
>
> We check both conditions in many places.
>
> Let's factorise it as a helper function.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


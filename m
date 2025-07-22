Return-Path: <cgroups+bounces-8852-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C9AB0DFEB
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 17:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A75546FC9
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988222ECD33;
	Tue, 22 Jul 2025 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uks0FgcT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9C2EA15D
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196543; cv=none; b=bkDPtaq+X741zIxfDkS9Q2ef6RP4wOP8Qp7ofIOAXcIQ35EKJJsUkjCPGU0D300GJtcLd9Zux/fMwucb+JgyTLFSRzp7TzUxD16qbcclvLnuGJoum6sPEEKt5EPfAboWHllTodOJZxJGoDhhNtndsTv+mJXkJ8ZGlBS37qEvOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196543; c=relaxed/simple;
	bh=umAjpYj5j2Nm68r3Iyqwfyn5wdRoOmNs41221wlvsuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTGJ+8b4OPoOLXkWTZcPTPd/cy+REsBE3cx9l7/v7LFDat+0VFDktjdXxkmKdfC1pP7siz657dM/h4fVOVFlvv6bB1X+urp6NSZ3Xz9+4AFCV06Kv0JRs2MbiEtlVMXJFjXcwqjcyBsS9FzYJFRdLUFNyJiFqzvl5tq2frsEjyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uks0FgcT; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab63f8fb91so48184701cf.0
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196541; x=1753801341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umAjpYj5j2Nm68r3Iyqwfyn5wdRoOmNs41221wlvsuw=;
        b=Uks0FgcTKWuZlIqUR95DWuVvfXVZNeC38/s7vc5vpulSpNb8NKuS1SdxbZVuU5PcP5
         ubehsfdOOZHMwChwQVHwPkqpqR6RNi+uUKOGgbsYFmlmFONs01ROcpBme7W1wWvmmNpf
         zxJ/CByYe5c2NOlMeT+XS7t+QlLA7rFUSFb/YGBcMyLgbrOchDqff7JXFOMpFyHw+pEY
         cUpjuDLv7hrYQNQvJbJcMvzhXBF8kcFz5DSiutfBXej8PAv9z3Tk2gXv+j7NIdMzl7ck
         AzTbSNXAnjRukJtQ+mmaEiq0wncPYtGLgQGkLxiHct67gJBbERdwxfjXCVIM991C1UnL
         uVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196541; x=1753801341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umAjpYj5j2Nm68r3Iyqwfyn5wdRoOmNs41221wlvsuw=;
        b=RkYs6Ij+ZYXnCoqd+mL4jT/WgoeEw7EBFngJLx7yCVGUGgHBhEwH2kU0hY17Vsdilz
         hjla1342+LWCyZzcYWN2bFvs9Wb7tYotnt+lvxNsESL78aGphyw+bPvh/7KREIuIv9sM
         a9TrIcb3Lr2ogVS/ix/sIz69DJ2/0rsOF1WPZ6bOumzJb+d0kDDZL+xAvWYwZvN34nLr
         E40j79xwWJSgfjW9R6KyZis23Ap6G3sgWYAQwq/yNSkw74nRj5RS8NVcSo1efPDc3Nxy
         KYvH8rRvspBWR7P4wZwAr+G0QoSaCMpoo/HkbYPbm9AUhFMHtXscicaeAbWmOmZCaQqr
         f+2w==
X-Forwarded-Encrypted: i=1; AJvYcCWwwy5xbT9ohHWqWUdYpISyyQbDnVunc+9F4/DmCtjAhCukQqxzRgpWLHyy9ha/EjU/orHUli01@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmQLj+byryhX2lmLidO88V583C0LcGgo2iaj11BpDZ16dhi8i
	ceUC7OVMREdfZRvbxvTW3+z71O5sEgOe/+yPIuHcD40wNAHlt2k9Q/5zVgH+S2JTdn/fzdQ94jZ
	eYVAivuSebN/c2dVkiJs7uZdBeTOFgvj1rzrARieh
X-Gm-Gg: ASbGncth/rB766ok6msiuaJGZwa8JUt+DOUHbrlVx2VXGWoEgbHnrFO/ma3udVckUfI
	6KqQuO4FbvKe2kaO+PNVAMD0mtU65RcVSe0bX55EH9Jp/UQtKQhgvvCI7QiTp1JvWilBjd/Q7cR
	6gcf1ZsL4EtI2CuOF98kDzNQkf5N7bfXUnOkj8g+BMCLrmp1DdEgsZGj4GQTBB491xeBuKX4QiL
	q4fFg==
X-Google-Smtp-Source: AGHT+IHatyO88FKjpHrkC5ZRrOvMvJcUcR//80j43PsSX5i96Xgq4GOLULMpeJdluQDo1lBmfvGH9r94q7sH87FUvUI=
X-Received: by 2002:ac8:7f13:0:b0:4ab:b02e:8c24 with SMTP id
 d75a77b69052e-4abb02e8cffmr222175891cf.9.1753196540172; Tue, 22 Jul 2025
 08:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-13-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-13-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 08:02:08 -0700
X-Gm-Features: Ac12FXwnxSRbbL9Frp0VNEdNEKZjMoYAXFHNjGRRYDkATQpDHC00xX2ThpLs5IY
Message-ID: <CANn89iJk3B57ytDOEL8YpQj5K-LacKS0v1ANgLi5+cZr5gqTyQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 12/13] net-memcg: Store memcg->socket_isolated
 in sk->sk_memcg.
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
> memcg->socket_isolated can change at any time, so we must
> snapshot the value for each socket to ensure consistency.
>
> Given sk->sk_memcg can be accessed in the fast path, it would
> be preferable to place the flag field in the same cache line
> as sk->sk_memcg.
>
> However, struct sock does not have such a 1-byte hole.
>
> Let's store the flag in the lowest bit of sk->sk_memcg and
> add a helper to check the bit.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


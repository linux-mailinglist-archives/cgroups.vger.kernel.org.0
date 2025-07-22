Return-Path: <cgroups+bounces-8849-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A423B0DFCF
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 17:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F817B8511
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 14:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206E62EACF9;
	Tue, 22 Jul 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uapqRshc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E502D8DCA
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196295; cv=none; b=syHZ3dLIWQRt/hxeuJrT48N9joyOR9dZtfAm45jjh+Wh5C2adg9DpUZgUH8ddTf+k8gFGSG9Lurt6sHsH7vye9CWuYyM504+ka2Y7SXM/Nu93J//rMSu+BUY+NBWB8T50hSk38zixCdT97utQg77GUmhN5aaXSQp8Kop9OP09sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196295; c=relaxed/simple;
	bh=NB1BVYhS+7MybxuCFsZv3QiZHTdAuScy85Aimnn5Du0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dW40iHs3eKhNY+IVnBh0UuHOtCW+4T8QooRTL/CEyE4fqZyEWNRqdhOAziYnS/fk3ElXRvmKYtLd4Hk2ZRSMOaJnR+kJCFK8Ac2d0S78CMyANkAgGWz7spdHy47/B3H0qxqNx5QNKxJ1XDNyG2DKTgv0JVfaQdJIyXotqARTrHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uapqRshc; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab81d016c8so77545991cf.1
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196292; x=1753801092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB1BVYhS+7MybxuCFsZv3QiZHTdAuScy85Aimnn5Du0=;
        b=uapqRshcyhtRKuXIKnEOy4fZ1kvKq7wWaYlB+W3sszOu1Tj35mf/6ocW2c6eKPC19f
         MCxHRKUYjjuM9MEc4GyZbpEKKqn+lGKfXwYGvU3gVY+85S8xF6zoa9ay/47EmmBx8fEg
         jbc4uc523PvnT1jpFmA+Plc46XzbL0JbcD2/KYZvD9FJbZnzvln1LlBnKmiKOG/jI9h3
         n2ti/O+4Hy3S+x25Bim7DRGE1AnrQBUVaVoyO20VOd176i7Ta3aB9wTLKOn2/zFnmf1w
         9RC9xocPFUIuFn8ur+3K8OT0IchYSE8gfku1DaS2UxsXz3HV8Nc4fkCC3pqAcSdWyoXo
         v5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196292; x=1753801092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NB1BVYhS+7MybxuCFsZv3QiZHTdAuScy85Aimnn5Du0=;
        b=rkk/PYXDhG71x4e/SZHhgWlL0KuVaDYiVpB2kDoeCgoNmn0SjY0zSCifa/tgpkamvY
         RFZe/rJoowUPqA8aE/tPeEcrjfVMieCDetrLrKt6nDs2t0rtgRu6poJt0LOi+lxlcb8d
         YRByYTgFNPZy4aOyxQJiRI/D26z/SvDdL/BARcjb2YibxbkLkMO3zHKA0SZmtr/w1Uug
         AoaxSP/ypgLT5tIQ8OxBSkKTNyQdKOTr6m4SeP4dB32tI2JJQgDUdjCYAEHaqir3xWBz
         VFz+h4z1h/1H3xe4q9kjeWBSg0VyZn3GikOLX+uYjzajOlV6KJFSG2+wTFCWfGDPdPlr
         2qHg==
X-Forwarded-Encrypted: i=1; AJvYcCVaERq+s7wlRczhfcev4+WPsmlCoo4oSKs+bGapzxhi2nHNUawbsG+dJX7t09xsBMchx7B96Opa@vger.kernel.org
X-Gm-Message-State: AOJu0YwKiVB400XNGYzK7SW+EEIrIt1WLbFkpJ57U8dRy9h7R9Ab6A+O
	raTWlY0okMNoSNh4GAU7QEFbV8K65ACCs7hDRNr03XrTV6HQKirE402MF+ors+tyqAe9jQ8UYSg
	z9ZFg7saWTZfC5s33HaROWjao98M9M0MuoUAzVDCy
X-Gm-Gg: ASbGncs1D92uMWtuJ+B2aYhtq5rExVruaDaJaARRqpAW2+IFSjgpm+gOtAuUoJEJhoT
	zfehxzikyrvCmjs2aaREmtlWRiR2VgWTDRaMDWhfaXbMG2qa443acZp/61qJNm/SA97W8n0aPD3
	GdqsuA9JkT2ujICnMnbXqUl8Z52+HggqfOneAklr95q3SoOJ0bAaAMVQKnfRe1IggWvmDFCtjUG
	AL+Wg==
X-Google-Smtp-Source: AGHT+IHbvsTmXoMJ90OlEJkh3KhkwboNSzW3FyySqD4AsNrmtWHLtCL62ueTgeIousB3XPBSsSCTtP6ho6CBB51apSk=
X-Received: by 2002:a05:622a:1999:b0:4ab:4d30:564f with SMTP id
 d75a77b69052e-4ab93df21dcmr375890231cf.47.1753196291532; Tue, 22 Jul 2025
 07:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-10-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-10-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:58:00 -0700
X-Gm-Features: Ac12FXyjA2hCizSwjNeIJfXQ3m0aOkPNJ6whPVh_v503OAB4UKe5n9M4BBBTIQU
Message-ID: <CANn89iJckRO1b6_pdgq1dY+wE_6M1SBgzenR4wtggiykv9B3FQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 09/13] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
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
> Then, we cannot pass the raw pointer to mem_cgroup_under_socket_pressure(=
).
>
> Let's pass struct sock to it and rename the function to match other
> functions starting with mem_cgroup_sk_.
>
> Note that the helper is moved to sock.h to use mem_cgroup_from_sk().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


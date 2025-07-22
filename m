Return-Path: <cgroups+bounces-8851-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3372AB0DFCC
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 17:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B33B279E
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20611273D7A;
	Tue, 22 Jul 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zDdAiO4d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839721E835C
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196448; cv=none; b=SrjHi5JIyu0nRdSHrYXM9pzhZ71q4bMxRiFU7sFD+JM04Gq+892EbKiXIBfl1NIJOS5IfPbkVOKm/2tsapY95+j8B+BvlrAo1qKYnhTcARc2g+syb3XukBVg3fB9hRLLLBkawevicpj4oNhdgBYJzIzHXCyHV1/HcuSlRcJFzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196448; c=relaxed/simple;
	bh=+nxKNO4a2BCMIJuvj3w0sl1mqftW1a06HRS7ZufxTrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiT/Q24MoraWjU5Ay5oJIFLEfskL07b5yJxFW3+JKWuDp/0uzUkfQwPMnmjEDhwfuab2yQkDP3NXNk53VnPg32Yb0Piu6XT5dJPJYSfK2njIpL3N2DCeZxTp35e5KBV8d+2ER5IfyEmNP32T6Ql8OivufVGQZ74vJNkySKzebzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zDdAiO4d; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab53fce526so80608241cf.2
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196446; x=1753801246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nxKNO4a2BCMIJuvj3w0sl1mqftW1a06HRS7ZufxTrM=;
        b=zDdAiO4daO95oVXR2uc22irs5z3vyN6sfv4p5Rx48qAwux8gCvGyS4gWSS9mF6dv00
         5sKggg18u1buNRAT2agbH95qdngXjN0dAlczsAsPQRHapwBPGDOZliMfuw5nchp1nUN/
         FVLCLUYATPRQ/ab4fGuhNXPAPhlRiP9l6i9X9oxVs5OiU7khsez56vxge+IoDCbiVcPw
         XtEUgBQGNdhdcNycTQ+cOpYoMsPRZmtpWfmeCPVXnoDDe7Viwh4MnAmi6qpSl9TAJ2b0
         mkC7kdwVow2PT/5Evm7cUMxOfMe61g0wGrc36BQG8QXbeZK3Edajeoh/d7tCsIlI285s
         MrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196446; x=1753801246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nxKNO4a2BCMIJuvj3w0sl1mqftW1a06HRS7ZufxTrM=;
        b=DIC626xKIf6WoVNc9tQ0peyN4MBMNPhTFu21rr4Fu0YAxw7ujKAiTyFVD5k2lf8+4Q
         rLQqvx9CCCIPufL8frBmNulvsxnfYaAIEibCqvDbTLnfAyoIK3MOYW2tr0KEY3gMRAxL
         Pe3ZlbILOiYghEDFGUnUe7UXy2laGV8gfPyG+Xx5sq/TKRWIuGhnMofwSt94XZ3Pefi2
         3CIQTzZZOJlTCI19EhlTjvtiT0mkh5yD0hXTZeYruXOkBtcnyiZrA+uKcPQ8lLZaavhT
         FlrauNFfK0tbwykSUD+EPVO3DKX9BUGcR0gv1KjRahMkj4MPjPvGdQuKJ3GwzpnJv+qQ
         AJWA==
X-Forwarded-Encrypted: i=1; AJvYcCWWy1ha/hCNpQF9NjfGKRkdWa3o7SOiQV7PVXrN5VF50bl8m8sl/1xWxuIclLJuPJv8PRw6kpcK@vger.kernel.org
X-Gm-Message-State: AOJu0YwUxJHIoTlfMaUT8cJoz3d1zE7nyigtrleRQOSZFYMnJ0AzOpni
	LSZ9X21HxhjnH5ym0Dldbsch+IoLCL86hW3qaONcOqp6Fi//g7Ul0KAcnove8WmpqazZjvbqcZM
	VvGxZrAJdvYNBHPDRXX9bY99bKDmxPbnHt6X2WY0W
X-Gm-Gg: ASbGncte41wPuUHVELV6ImIyuxPwfaGPRUIbUQ1khDmfdhgL9dCipWeVLLdoBMdn1lT
	uVF0pPK4m7u761PcezeqnJWYEads++zZ/rV+RnWYnq19RndshLylQTme0Dx5K9aZVBCwFiOeyJ1
	k5TnKRSEYmPNHvyOZQwRYu9h1dOTtjzR9HemuyU/Vca9FKjpGZHsRr1q08mPBpvdnnUA0FjhZ8J
	NJX3Q==
X-Google-Smtp-Source: AGHT+IEAwdtOOJZle/vAWN8RPtXy4MisNzaqxiiiStWuk5ZuXoX4lqwhlAmVuPypXJlxrGh34p2aRu8UWxGzVff9IMU=
X-Received: by 2002:ac8:5d4c:0:b0:49b:eb1d:18ad with SMTP id
 d75a77b69052e-4ab93dbed7cmr385323141cf.41.1753196444364; Tue, 22 Jul 2025
 08:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-12-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-12-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 08:00:31 -0700
X-Gm-Features: Ac12FXxzCSficlnnF49FJ-AwqyidP1dhOSx-V9OvnBpoHWZaDg3cQQfRkuFyMag
Message-ID: <CANn89i+mvoZ4rqtow2SRR0ZRB9gS4an9syCLuXyqcW=4-8Ek4g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 11/13] net-memcg: Add memory.socket_isolated knob.
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
> Some networking protocols have their own global memory accounting,
> and such memory is also charged to memcg as sock in memory.stat.
>
> Such sockets are subject to the global limit, thus affected by a
> noisy neighbour outside the cgroup.
>
> We will decouple the global memory accounting if configured.
>
> Let's add a per-memcg knob to control that.
>
> The value will be saved in each socket when created and will
> persist through the socket's lifetime.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>


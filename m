Return-Path: <cgroups+bounces-8972-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4E7B185C6
	for <lists+cgroups@lfdr.de>; Fri,  1 Aug 2025 18:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B4E580C83
	for <lists+cgroups@lfdr.de>; Fri,  1 Aug 2025 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B2A28CF4A;
	Fri,  1 Aug 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXAEWxWb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E003426CE36
	for <cgroups@vger.kernel.org>; Fri,  1 Aug 2025 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065649; cv=none; b=a0FnNzoc1rFNzDdxxHJKUYsdsDbc/KWsJnOdBWsSTbN+jwf7SML8ogz+8Cl4Jt2cOjyVLSKuI9owrsmtx7NWSjKLPmverh8uS0itvgx+mYD4Yg6sam2N38w6wrzlpEc94/bhU7wsIpJS25VNb4kOZPGtuN8V3xJNngh9sbzQKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065649; c=relaxed/simple;
	bh=LmwQUupYSQ5c5uv+Wg0TpH9+lHYtlOJKe2aOVLGnTKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIs5JwoTP4P9E9zapZtnP0FD2+jD8iyGACEnuLYS6TxTFcCGBQ9oxxyIKqVmZyJ9mDFvqGQ73xZhFH6SuHzqTehJB8HcF5W+L1IIC192kXc8Jslpbm/Sq/yvHwMpKC08nI+HvyG8ZjVlUvTgtoZoglWNEmay/qhFGXP2Ks94kC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXAEWxWb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31f255eb191so2094141a91.0
        for <cgroups@vger.kernel.org>; Fri, 01 Aug 2025 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754065647; x=1754670447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPlDNUMymhsODNFmsd1JRKJrfbGJJsVHVjtAtmZ8nro=;
        b=rXAEWxWbhPKRHKHuwGbf7t0NuR4fGxCfUeg3ZUD0uRB3TXzQQ6kl99Jax0WwieaUHG
         //X3tbfyD9qMFTFmm/SsMcXasGpWAn76SmlOz5dY9w0/U0NwiOKDDbMzIJi+TXEiaJPG
         KcVHoTt3Z6NwvJdgztg3KyobW7ArWZNOL+NEo0OrO7NLaNqDeoUgncR2dhSQQf2hhABp
         G3TbyJyv4zOyyMolEIJrLKov9Pmw8o3e/ixh34/47rALQal+FBMa8lI186ZXWz8QY8U/
         M4f5RdQtcrrk3Bgf6gnrCJXa8vVMQ1PyeN1FESRPZ/vCB74lyMid6XVqXuHWeGZ1xe1G
         EpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754065647; x=1754670447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPlDNUMymhsODNFmsd1JRKJrfbGJJsVHVjtAtmZ8nro=;
        b=pQ+u4mgBZEehYGWJCSXbkYQLaIuSuldBg/gNKhaNDzAlBUR91uZL0h3wokmN8c8MEO
         6phsXvPfLpt/yphLkrKtWK09O0OFe4zeZULet4LtWqw8HPAP1wONknrWuQA/sc9440MT
         v6FL8ZDBFP9I7ZFUZYEAzefA6FqMdTEkj2d8EjDcDsQ0xZjG2ExPeRDHzcxPmDPRJ7t1
         YwX7nWg4JAsuNkI1Gv6Ml3rEugIniwbMkWQtY1UEGjDY6H0hc/8FRSHJE5w0wwdyUG0B
         cFb20LNLJj4yfL1xxM6Q4ThRn9Yt8mPnBgrviARA7XEz3ySgRlhgqPMCfWNM8vVACQ3A
         rWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW60lWiMxTq5XoM9SBZfPaAGhZqtC9gIcqSdz3jkunWO9B9wWOCM0EJA5/EV7BWNWtquQkznWf2@vger.kernel.org
X-Gm-Message-State: AOJu0YxFh1nWcp4olybPsOJQYRgWuYqkCedS8NQv5BrbVKwEG3afM0ze
	/1k8YT5WdcVCeAa2/y3sMYRAN3c60iqea0eSvNhi9uI2azcjs8dR+8LBq9uu3AeQ0RXRWsb4MCX
	5dqYke7UFFDWzQkDLg2yAK6GhKgwQppcDwNDJL2XB
X-Gm-Gg: ASbGnctxs/+1V3dzH9mW9HtRmUYPwPmka/UMQ5BU4He82CHDU/XmjJ3n3PBgYW2Vu//
	5KS8ju3t3DcRWHKvAQ9SYfFhKJ1LKpMbhGnFq2YD7ovyGjI7P0FDnao1PH0DR6/I0jZuyajFrL0
	CLrrN78HxL8Di78KvMPR7dlDV0g5HhJroa36U0PB+w36LDzFrTdBwWzbzT4Un1S+v1vajgiBGut
	uOrgWaFTcLYNaH3REMJu0ke5IJoHoMhlnGkQBMeUx9Jq8Ha5pI=
X-Google-Smtp-Source: AGHT+IGrbCrNLGqTtBuWiAzE0+U3e1NMQB2FNpi+8gjkEuVtCmtDODuiea5OBd3jquswfNAUuJ4/jdmM5dWBSs9hwSU=
X-Received: by 2002:a17:90b:4a02:b0:31f:20a:b54c with SMTP id
 98e67ed59e1d1-32116115530mr791605a91.0.1754065646975; Fri, 01 Aug 2025
 09:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <fq3wlkkedbv6ijj7pgc7haopgafoovd7qem7myccqg2ot43kzk@dui4war55ufk>
 <CAAVpQUAFAsmPPF0gRMqDNWJmktegk6w=s1TPS9hGJpHQzXT-sg@mail.gmail.com> <ekte46qtwawpvdijdmoqhl2pcwtfhxgl6ubxjkgkiitrtfnvpu@5n7kwkj4fs2t>
In-Reply-To: <ekte46qtwawpvdijdmoqhl2pcwtfhxgl6ubxjkgkiitrtfnvpu@5n7kwkj4fs2t>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 1 Aug 2025 09:27:15 -0700
X-Gm-Features: Ac12FXySWBq5tqGpyUdEEo4tML_igvMbcYh9DoXD653V26VGI_HquHEhRn-c55o
Message-ID: <CAAVpQUCf=xHc7nx5Y5rZ4PcPt+PN9kdWvGo5jzRyNkubq-sRYg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 12:00=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Thu, Jul 31, 2025 at 04:51:43PM -0700, Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > Doesn't that end up implementing another tcp_mem[] which now
> > enforce limits on uncontrolled cgroups (memory.max =3D=3D max) ?
> > Or it will simply end up with the system-wide OOM killer ?
>
> I meant to rely on use the exisiting mem_cgroup_charge_skmem(), i.e.
> there'd be always memory.max < max (ensured by the configuring agent).
> But you're right the OOM _may_ be global if the limit is too loose.
>
> Actually, as I think about it, another configuration option would be to
> reorganize the memcg tree and put all non-isolated memcgs under one
> ancestor and set its memory.max limit (so that it's shared among them
> like the global limit).

Interesting.  Is it still possible if other controllers are configured
differently and form a hierarchy ?  It sounds cgroup-v1-ish.

Or preparing an independent fake memcg for non-isolated socket
and tying it to sk->sk_memcg could be an option ?

The drawback of the option is that socket is not charged to each
memcg and we cannot monitor the usage via memory.stat:sock
and make it a bit difficult to configure memory.max based on it.

Another idea that I have is get rid of the knob and only allow
decoupling memcg from TCP mem accounting only for controlled
cgroup.

This makes it possible to configure memcg by memory.max only
but does not add any change for uncontrolled cgroup from the
current situation.

---8<---
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 85decc4319f9..6d7084a32b12 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5102,7 +5102,8 @@ static void mem_cgroup_sk_set(struct sock *sk,
const struct mem_cgroup *memcg)
 {
        unsigned long val =3D (unsigned long)memcg;

-       val |=3D READ_ONCE(memcg->socket_isolated);
+       if (memcg->memory.max !=3D PAGE_COUNTER_MAX)
+               val |=3D MEMCG_SOCK_ISOLATED;

        sk->sk_memcg =3D (struct mem_cgroup *)val;
 }
---8<---


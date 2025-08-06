Return-Path: <cgroups+bounces-9007-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF80B1CEE3
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 00:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3804D5802AA
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 22:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B6621CA03;
	Wed,  6 Aug 2025 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M49FBrr2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095AC1993B7
	for <cgroups@vger.kernel.org>; Wed,  6 Aug 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517718; cv=none; b=BoLTQnUmXSZE/onr+nEGHyDdwIvcPdKK8GuUeGLQyMjY9kmBq2zae27TtPYMb+viR0LwSRYcGkFiHajvKqimTVDwzS1epPVP0bvqkQptCBHAOtJAQdHjwLE/L2aKao2VAuIKs8wpgoW6NF1GchhIj6FmtJYFLwNogcdGra9n+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517718; c=relaxed/simple;
	bh=wxmbacTzB5m4yxerqFQOHx/HCzp+RS+1K80LXLTDWKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgmQNY8Qtdhuxvv6OQQi3QMKYMaSoYvaM/5uCWAipCraWOsO1WX9jV91MEtLFjLCAmMmuRZmcRQQsGrBYoYFWjHrxxEXrWDBYRr+Li+97mfaWcUhZyu5gr5UcCUxVqbtOH1dS0y+IPahjP/iCZlzveUYRPq0TT73Wvq6S3dWgpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M49FBrr2; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3be5c0eb99so257636a12.1
        for <cgroups@vger.kernel.org>; Wed, 06 Aug 2025 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754517716; x=1755122516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS5sWoIyqI1LV97Jb4CN01ckOCIdChBVFk4TORl7K0c=;
        b=M49FBrr2sJ1DWx1r01t3SqTDILRkjGBdq5F4fypoXqFdvtsruxWgOgsgPBleKgy5er
         r8cCnRa9z3As7ZQ36RbI9wcWO6XI6TvVMggz/+5Gqi6AkMLWc0hdesyfjaY36xNs7d1u
         BJFxoFczebMjHikoxnSQxu76fq9yn7tyvxLsxA3ZV1cnloJV0MYFnJrwXNLmWEzGVVoN
         q8A2KCbUIu02xnGgOc0XO84jln02JKc5rqE+btQHyh6B0lg5aO5QFNEef6Mn1mpb8HZA
         2tduLvpB9mCvDvHnb+46rFItJRQy296R6WP20xnN2F0wi6rTPzGlAn+oDVqxBHlK7A1D
         Xx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517716; x=1755122516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tS5sWoIyqI1LV97Jb4CN01ckOCIdChBVFk4TORl7K0c=;
        b=k2gAgzdIITHTnounvwrF+D1wym6cULFdFRbL6+I0kjnUfQPfW3Ww4k2IpkSsmsRjai
         sFwwfuFC67HrPZLUNi4k1M2Pb36WeizytfIenIAmVIqCNBgauKMAhH43SPs80d5BWApa
         xYky+RByDlIVd3NJJ5UEXrtqxGZ7YVeLs69/fT5r9mTSMDIkJ3mMbgW6Y/LRwjoJ9Vxp
         5HzUNRGw69Tav/egv6GbfWXMc0GYLg4c5sCRE6ER8n6jYabmnqabhouARe3OfLajJsFd
         OCwCz7bDLM5w03ixncJwLke9dAxFCDwnB0INmiFVp8bDC5sAO/2puA33Frfs/H+BUeS0
         9l2A==
X-Forwarded-Encrypted: i=1; AJvYcCX8/zswZkU58ufGr0xm/Vo4qfkYMF3JCKWqt0e/02kkJmY/6ShdlW/qebk4ID4AosZyiSUoOOw7@vger.kernel.org
X-Gm-Message-State: AOJu0YzzpKo7JN4sK75ZLXlLiZQuzbefXw0Swq89qmFkNrmeN17+iQUA
	UT+FuOgxAD8JwDDKwwm7PbDfwdfy1rM27JbDD2RkoNH2ee7rC7ib7t483s34frgGiV7S5quawN4
	yQcjKVWkn85TWeHzGxGpZ1D7g/eTFdWZGKhFV++WJ
X-Gm-Gg: ASbGncv3aFwaP6h3bgyVB2L96g8QGVf5cah4Zg2WieQM4K3n6kDzjmzvEbfmhqytnF9
	0FomigMKTY/oZ8nNSh6F0nI4m+LyHMl8aUkRRS/Ol2oFuB5j/DRXlxtJL+kIyOKUmyk3/hBOaTW
	0o3dSHUCou7gDSM8Dky06Z5xMqxxgRroO7Vs8sHs/PB6MFSEcoSgqrSUSKotdKgAIETmsK75jnD
	P0JesVJUi9YkCuNfZJzAZ9kjYwOBd2wTbMToA==
X-Google-Smtp-Source: AGHT+IHSk7dzFSFXcu4X48id9sXvSiAxg4OZ+/L9B0Yq3eL15/6jfV7hChGejTL37W1MR4sOHnmzKtJZuAb4DsrqR74=
X-Received: by 2002:a17:903:2f89:b0:23f:d861:bd4b with SMTP id
 d9443c01a7336-2429f2d99a8mr55381415ad.5.1754517715836; Wed, 06 Aug 2025
 15:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <fcnlbvljynxu5qlzmnjeagll7nf5mje7rwkimbqok6doso37gl@lwepk3ztjga7>
 <CAAVpQUBrNTFw34Kkh=b2bpa8aKd4XSnZUa6a18zkMjVrBqNHWw@mail.gmail.com> <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
In-Reply-To: <nju55eqv56g6gkmxuavc2z2pcr26qhpmgrt76jt5dte5g4trxs@tjxld2iwdc5c>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 6 Aug 2025 15:01:44 -0700
X-Gm-Features: Ac12FXyFJKmVEi3oHI4ogHBbfqPpbXF9V_pMaOAaUcyE_TX_Or4bugRENLRs7x8
Message-ID: <CAAVpQUCCg-7kvzMeSSsKp3+Fu8pvvE5U-H5wkt=xMryNmnF5CA@mail.gmail.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:54=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Wed, Aug 06, 2025 at 12:20:25PM -0700, Kuniyuki Iwashima wrote:
> > > > -                     WRITE_ONCE(memcg->socket_pressure, jiffies + =
HZ);
> > > > +                     socket_pressure =3D jiffies + HZ;
> > > > +
> > > > +                     jiffies_diff =3D min(socket_pressure - READ_O=
NCE(memcg->socket_pressure), HZ);
> > > > +                     memcg->socket_pressure_duration +=3D jiffies_=
to_usecs(jiffies_diff);
> > >
> > > KCSAN will complain about this. I think we can use atomic_long_add() =
and
> > > don't need the one with strict ordering.
> >
> > Assuming from atomic_ that vmpressure() could be called concurrently
> > for the same memcg, should we protect socket_pressure and duration
> > within the same lock instead of mixing WRITE/READ_ONCE() and
> > atomic?  Otherwise jiffies_diff could be incorrect (the error is smalle=
r
> > than HZ though).
> >
>
> Yeah good point. Also this field needs to be hierarchical. So, with lock
> something like following is needed:
>
>         if (!spin_trylock(memcg->net_pressure_lock))
>                 return;
>
>         socket_pressure =3D jiffies + HZ;
>         diff =3D min(socket_pressure - READ_ONCE(memcg->socket_pressure),=
 HZ);

READ_ONCE() should be unnecessary here.

>
>         if (diff) {
>                 WRITE_ONCE(memcg->socket_pressure, socket_pressure);
>                 // mod_memcg_state(memcg, MEMCG_NET_PRESSURE, diff);
>                 // OR
>                 // while (memcg) {
>                 //      memcg->sk_pressure_duration +=3D diff;
>                 //      memcg =3D parent_mem_cgroup(memcg);

The parents' sk_pressure_duration is not protected by the lock
taken by trylock.  Maybe we need another global mutex if we want
the hierarchy ?


>                 // }
>         }
>
>         spin_unlock(memcg->net_pressure_lock);
>
> Regarding the hierarchical, we can avoid rstat infra as this code path
> is not really performance critical.


Return-Path: <cgroups+bounces-9191-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59814B272F4
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 01:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662CA7BB896
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 23:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9387A2874E7;
	Thu, 14 Aug 2025 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U4+Bw4zC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094011A08AF
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213764; cv=none; b=jLSKxMS3pZBtkgxfX8dgkCRTVJsZPWEcbj6gu7pjObBw8hM3srINXIxsLnzUGkSX06eCypcZ3gNS9Y8XJN16fJgTpGznsLUGcJ0WipO9LAGkWkeMdgisWIMPSciruzAKR73PBIysnt9FeNfR632CWD+qgBX1SiIn1hAITWII78o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213764; c=relaxed/simple;
	bh=YQ7YCZjjUdesfp/4AmnBBp2EwgfrYAy7oWynoXY99mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGT18FKappBkmfpVhsMg21AhrBvkeSQeQzrnhcSWJ6QkqC0Kq5vOgCtpe7nem2OjhDLWQqR8Ft0aLDu7srZA0rJ2TEcEcTJ0UKQZtLbbceXp9v26L0Kzlf8uSFFb69gimW1jaUx1RPTou5qOGJcBmf7TAGAO6wNJKT2HlweZx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U4+Bw4zC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24457f47000so13636635ad.0
        for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755213762; x=1755818562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ7YCZjjUdesfp/4AmnBBp2EwgfrYAy7oWynoXY99mk=;
        b=U4+Bw4zCHPYz4w0y1OyYPNn4xWLtuUtQ048u/0/5zhnhwG5vxwvgGbByWYsI1uBRxX
         hRERXh5V6LuAfMJnSfUVO1b7LgMpfckEKK1BBfGayhyuzEu5qwJ0M4Fig2OOk30IaEz5
         zQu5RTwLPU5LKNcrC2+Qt4AVLrI5ZPxwEiS+0ZuaVrU8fQZE31uE4v2XiOrnD5TulPlc
         vEVQLDCT94QNLHXccWCS2SH/UDz2ZBGgpAHKrorzlDTTKaZwc3H0dw92VWa43I7Xe+cf
         E1NuiFf0yhrHbwgoeJFa8EiCVumonb5lVP7REl5+bE1SWf1cjmD2fvXhgBV2yw4Jhfm3
         Mqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755213762; x=1755818562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQ7YCZjjUdesfp/4AmnBBp2EwgfrYAy7oWynoXY99mk=;
        b=car7eySqfcrfQw9bG3Q/oh8ABdAUyrkNfMjEy6PFDbYSZOt1m/DP23np7l6sWcw1JU
         goEYC8e6vWd47GeBWM/+pEMaBlkW5FzCk/fk9e29r2XQfQl0c4JarullXSRW0Oc1o2Sf
         mtqQSE8aIWnk7t4dDvqJXmVotMtOEpzCqrQJN5PQhqRsH2oJt2U0xK93zfh99HHXj7k6
         VUUzmIU8X8+9wSnCWl5yvbxgHF6Th73Aatmh1I9B8EHj3T9YB5Z06vvGeT1Ti71HmQ71
         /r+A2tELfbz3rAOqd/qqEWGFdfi3Lda0+V/G4ZuhHOluY10XXFqgboebUq/+zKM9CRjW
         nwBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN4K1eILrTMM2LNN2b/QK0uuD5cAVncMQ8ibCG1zCWruflYRK2I0DVg0cJAalR6MffbQ4zAtmt@vger.kernel.org
X-Gm-Message-State: AOJu0YyDfutoJaGZvGyxj56q1UTAfddktU2jg56uEst0e4NIeNFz1VD3
	Is+pO01XMGdnrGpLdsE4/EZVy79d8SfJNBIrDJzxO2xdkDS5IDqZ/ckQTl5xyBvO72Uj2FxjBAS
	yWX+yVE5UdYTRygD2xe6bX9wAAXRuQv4X0MlsFFHC
X-Gm-Gg: ASbGnctVJ1WN8qRIVObrXPsZLmnHts2YZ6M7pbqA0MSjk9oUQSJtZty2YZ7LNfu5YjP
	UVo5LTIGjw0t8YS8XlpiD2BONPE8U4RvQXp24UKiMQuc6zbTnqiCg7AZb7ZD3DuwUJgKNlzJQ5S
	sYNryDrs5Q5bKQsMb5syyHEeC+8m94Cv3u5lRCWLv6QrpDhuBA8epINZ4gIgvUg0mMa9joGBL5I
	khuPEWo2JVMJR22g5e/JA7i4ETw+MRoMs4Uu9hQABpdYPxYqWpDe5ML
X-Google-Smtp-Source: AGHT+IG+GzkTFoWSxjI/UBpeB+AhhE8U81bSEVut4K3CLnycOTHj2PFasfm2kLor4XHXf2jf8tiH2o7md6AgbgQhI+o=
X-Received: by 2002:a17:903:2444:b0:23f:c945:6067 with SMTP id
 d9443c01a7336-244586c3d33mr71675685ad.41.1755213762138; Thu, 14 Aug 2025
 16:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814200912.1040628-1-kuniyu@google.com> <20250814200912.1040628-10-kuniyu@google.com>
 <pl47mmcmxu53ptfa5ubd7dhzsmpxhsz2qxpscquih4773iykjf@3uhfasbornxc> <7pbqwjm4yl3oxebibihbdqkdusamnnui5ypzhfh32pxfkcordq@o3hottcdlavs>
In-Reply-To: <7pbqwjm4yl3oxebibihbdqkdusamnnui5ypzhfh32pxfkcordq@o3hottcdlavs>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 14 Aug 2025 16:22:31 -0700
X-Gm-Features: Ac12FXwLp2y7n2f70IACCfZi6vRBARC4QHPOIBg0j8Z8siCHACfmll_htqDpnyQ
Message-ID: <CAAVpQUDxXZaYz98hen3ariCek4s9TQ9JxWqS_zRoDK=ON-asbQ@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 09/10] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 3:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Aug 14, 2025 at 03:00:05PM -0700, Shakeel Butt wrote:
> > On Thu, Aug 14, 2025 at 08:08:41PM +0000, Kuniyuki Iwashima wrote:
> > > We will store a flag in the lowest bit of sk->sk_memcg.
> > >
> > > Then, we cannot pass the raw pointer to mem_cgroup_under_socket_press=
ure().
> > >
> > > Let's pass struct sock to it and rename the function to match other
> > > functions starting with mem_cgroup_sk_.
> > >
> > > Note that the helper is moved to sock.h to use mem_cgroup_from_sk().
> >
> > Please keep it in the memcontrol.h.
> >
>
> Oh is this due to struct sock is not yet defined and thus sk->sk_memcg
> will build fail?

Right, we can't touch any field of struct sock in memcontrol.h as
noted in patch 6.


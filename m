Return-Path: <cgroups+bounces-8906-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 136E7B1160E
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 03:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4424716C357
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 01:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F4C15B971;
	Fri, 25 Jul 2025 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljK7JmZQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26582E36F0;
	Fri, 25 Jul 2025 01:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408144; cv=none; b=CElM15XSPSf1pLcIrDQX2ZTwAN6rLexT9SO2ZtUukCtbuKhNiY/FFn/4UfeCq8hR8lEZGgfzPPjDYCTCvDKgvI8D/AL9A0F9Z2PW3vzJMHrpVR3gS+4sQ7UWHsm0dHrJkLO7wvlZqQnFg3cV5K3J5WoPjmdFZ+DkhiNSZuyzEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408144; c=relaxed/simple;
	bh=B9lc7fM1jtUNpSTwiyxqs6LzGFpaNCIpPSEYy36++8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7j6nONN7tVhXmmnjCYvkFBMAUOalyLmqrtKkKJuBROIJKXkBPuRNfE+eY7q40mg9y+WvG1XNrq7AV+HPPoK209rORY4BqfCRC2pKD+BBz9hlO8ASWbipoz0EoxlbhG7VDoL78GzQjFTjjBhlWylWCHj4bTq8ChSQRRC/768eaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljK7JmZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282F6C4CEF8;
	Fri, 25 Jul 2025 01:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753408144;
	bh=B9lc7fM1jtUNpSTwiyxqs6LzGFpaNCIpPSEYy36++8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ljK7JmZQNB6d1Y/lUQP5CBvKozqg+TyROpDUceazY6iMAN8OuIt6uHoqKKI1QqhQQ
	 VPS7JDHxK37SG0cOun0Bluuge524GKVNPuV9c1x0SNM9Fm24CkO/aPLHI1Isvl3Nx5
	 Ly3pcKP4ToDd4xBEgAzi9qRYb9uXHGDDKAETosrcvBsC4u6MUdKm8dg0eosxnVcGdF
	 2Djc58PEZKUsOWJqougd3xp2AGJqp160jdWiimNOc/Ni0ejvzqzzvzi8nFN0MVc2L1
	 Ifq1//hazBkRKLIzPfjZWkVa1KwrehqzM/6l1q7j/HQeF+//VaRosSmsswp8lAl275
	 756B6ApoYH2Dg==
Date: Thu, 24 Jul 2025 18:49:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Eric Dumazet
 <edumazet@google.com>, Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>,
 Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, Neal
 Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, Muchun
 Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, cgroups@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
Message-ID: <20250724184902.139eff3c@kernel.org>
In-Reply-To: <CAAVpQUDMj_1p6sVeo=bZ_u34HSX7V3WM6hYG3wHyyCACKrTKmQ@mail.gmail.com>
References: <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
	<CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
	<jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
	<CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
	<p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
	<CAAVpQUAk4F__D7xdWpt0SEE4WEM_-6V1P7DUw9TGaV=pxZ+tgw@mail.gmail.com>
	<xjtbk6g2a3x26sqqrdxbm2vxgxmm3nfaryxlxwipwohsscg7qg@64ueif57zont>
	<CAAVpQUAL09OGKZmf3HkjqqkknaytQ59EXozAVqJuwOZZucLR0Q@mail.gmail.com>
	<jmbszz4m7xkw7fzolpusjesbreaczmr4i64kynbs3zcoehrkpj@lwso5soc4dh3>
	<CAAVpQUCv+CpKkX9Ryxa5ATG3CC0TGGE4EFeGt4Xnu+0kV7TMZg@mail.gmail.com>
	<e6qunyonbd4yxgf3g7gyc4435ueez6ledshde6lfdq7j5nslsh@xl7mcmaczfmk>
	<CAAVpQUDMj_1p6sVeo=bZ_u34HSX7V3WM6hYG3wHyyCACKrTKmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 11:06:14 -0700 Kuniyuki Iwashima wrote:
> > 3. Will there ever be a reasonable use-case where there is non-isolated
> >    sub-tree under an isolated ancestor?  
> 
> I think no, but again, we need to think about the scenario above,
> otherwise, your ideal semantics is just broken.
> 
> Also, "no reasonable scenario" does not always mean "we must
> prevent the scenario".
> 
> If there's nothing harmful, we can just let it be, especially if such
> restriction gives nothing andrather hurts performance with no
> good reason.

Stating the obvious perhaps but it's probably too late in the release
cycle to get enough agreement here to merge the series. So I'll mark
it as Deferred.

While I'm typing, TBH I'm not sure I'm following the arguments about
making the property hierarchical. Since the memory limit gets inherited
I don't understand why the property of being isolated would not.
Either I don't understand the memcg enough, or I don't understand your
intended semantics. Anyway..


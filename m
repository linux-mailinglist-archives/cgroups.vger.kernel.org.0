Return-Path: <cgroups+bounces-9190-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A63BB27174
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 00:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2EF725310
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 22:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16531A3164;
	Thu, 14 Aug 2025 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BPZK4k5e"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2B279DAC
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755209472; cv=none; b=OKYmRhlfPHOCSp6yPnS2+EILKdfujDrjs2TTJGiQLXQH4Qe+yJ7dNA0se3EZpji7HSSlSPBL7KjI4GD7F5YyenOV0ONHzbazku4soEymLZ30WgllwNX5DQ7S7FSkP3kFBTYQWmfX/5+QiBfYSf5aVJLD7J1qEeM2TBbqjPL3r5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755209472; c=relaxed/simple;
	bh=+pR1aJoKjCECG9qSc6/tsYUF08a7Ff8nHem5Z8hHJHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBc/KvzbMeJJOv5kpHHatgob0almU51vYzkRBiBz248BWv7lZmsv+cz9aSdE5WQneFUJwtqhoWdU65SanYYC6Ec3Y4YXvesQjjFlvw5wyIyaIXTSmWSdR/nW+a/ahzu1N7P3IxdWoKU0eZBEmUoP3+WHZ6v4zgFktshjBlFb90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BPZK4k5e; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 15:10:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755209468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0BHr2ukl5jwbJzHutWmcqnBqCEqI3BR/SekxqoJVhI=;
	b=BPZK4k5e0zVdboI4PKyMCDpBMB7Y4efDzF01CdZWcizL2hxM9rYEH+VFigNROxHVY0x1Zk
	RRX8fKL290fEoMu3B5pmJzoJPVs00nhmbr9Ha9JqqWXuNB8dh5ayXPvGT+aSvIRBw2v5n6
	HfpQafRwhFcbM8ccDvmdOJbXYX3xYo0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 net-next 10/10] net: Define sk_memcg under
 CONFIG_MEMCG.
Message-ID: <nrtnpl53gxzwkhgntgdd2cxzf33fdsqh2hzwd6soidvf5mjeki@ck63r3n5maev>
References: <20250814200912.1040628-1-kuniyu@google.com>
 <20250814200912.1040628-11-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814200912.1040628-11-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 14, 2025 at 08:08:42PM +0000, Kuniyuki Iwashima wrote:
> Except for sk_clone_lock(), all accesses to sk->sk_memcg
> is done under CONFIG_MEMCG.
> 
> As a bonus, let's define sk->sk_memcg under CONFIG_MEMCG.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


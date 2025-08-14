Return-Path: <cgroups+bounces-9185-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A63FB27113
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 23:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08C91CE050C
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 21:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB7027A11A;
	Thu, 14 Aug 2025 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cEDXn7WY"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFC2797BA
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755208278; cv=none; b=q/frHUmCPaUaAwiFQqMbgq1+R1ALTnhS1RKTD5ZFTxLZC3LX7+WKhPfsYE193N3Y9pglOHgD+GMBmyGDS7SeO4qA5mD4DpmjB56RwEEY4wbsXyMRDh7gBz+tIMOVRQV90Nrn4LT9RMTYx/Z8yPZo9PxvRg+sH4vvEmMCYFJ6gCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755208278; c=relaxed/simple;
	bh=0qDayALLGpfPGGJVeOJH1w5pS9wW9PEZgPAEEihPeWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTxoDYkNw18bkt4Kc8ocuWdA7+O8GSYQ7DGnrRJd6mOuyVfsz42i8CpV6o+LTssBuMTpjeAxmMHlibLHIcy4/VR72Zf0uV9NEs25gNjBdHH52lKWXkuwFg9zldNiOXgz4tVhCxPmTO+wZ+SzAXhEwCJhx6/ixc5jcZUei3zupX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cEDXn7WY; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 14:51:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755208273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NFRVQUUs9c39FN0bau/fEfOu6gLqtTA31f+AF65Xi8g=;
	b=cEDXn7WYmz3adjgl8K9+j7MUS3BpjExjj4/2Wvq5fB8rljL6y2EotLQy7s1S6y81j6XHSU
	vxGNLQ1U7dZC3PADsPBXTtzOdmoRlQuswEVOf8phOkOjl/YvN/OXmWCO0o6hhF9kk2Ie4f
	ANYAM7/5GxYduANX2ISMKvkT9lVZ1Vg=
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
Subject: Re: [PATCH v4 net-next 06/10] net-memcg: Introduce
 mem_cgroup_from_sk().
Message-ID: <yaxx7v7ftzhaivt36qy7ov32u2su5anv6eoqk6f4dspgf57ttu@6ab2n4cp5hbi>
References: <20250814200912.1040628-1-kuniyu@google.com>
 <20250814200912.1040628-7-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814200912.1040628-7-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 14, 2025 at 08:08:38PM +0000, Kuniyuki Iwashima wrote:
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
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


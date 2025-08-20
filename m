Return-Path: <cgroups+bounces-9285-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 088F3B2D15D
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 03:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF9B725E7A
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 01:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CD6212D7C;
	Wed, 20 Aug 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZaPJdoc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD5920B7F9;
	Wed, 20 Aug 2025 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653038; cv=none; b=WlQcvxXmiSCCw5oJkBsjRVzzfrdXPBfuAY2tPYCZZrUukd7tpWeRcezOtuSAfdQ44iwLD0U0JNCIdBqG4DcK+YiTEBlKQ2U4hG6x4c7ssEpvlI5HCZ0AxrDsa2FrNSKs20ldxpHivaFZnRlJ69qt5yWdOOxChyY31SAhNY7/FkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653038; c=relaxed/simple;
	bh=C+2GTR0YI18RQg7u25sMTQABBcMAstNJVqtMhULRkOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmxlFIrP5cUp90bchQTgkcebpAlz+I9tzxcXFY6qMnHhOGX9G4y+SfRWvwm7IQmueEWDL2uRHmkN9cP31T2wTsyO3ggCJaOGtV65LRKyPpBcCE06VmGf62E64+xsFW3ooSxDLzggFL/e2WOyIULem0ag+qkatV70p0yNXpXIhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZaPJdoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFDAC4CEF1;
	Wed, 20 Aug 2025 01:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755653037;
	bh=C+2GTR0YI18RQg7u25sMTQABBcMAstNJVqtMhULRkOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WZaPJdocCn479Xgj8B3WHfL6XEbteMRp4spYbJHrKRBsvPTNdt82w7J0ckf1sbZ3K
	 v9NLjjrNm03pfouKO9pYrOz5WmbXxn0zgnY7eQhSHLKFALzAzd7gGxDXbAXO7ggY6S
	 ZP6KuZGPuipzXROF92MMdH1DF++mTr9xnzIbQoqfGyqa/LtMo511gtA0Z8HjzXSyf8
	 pykXVleVygK3hxM9bwoYGzDKOB33L3M0EUgvmgNfV3iFTsKEryFnjpp7f+S77kWBbj
	 1i7g6Qf9xMxQ2SjhotyTIT4+ebodrg5TiFSBQ/AiC1u7MxNG8D99SIZ6KKZSBUxKmP
	 009BVg9fIAqzg==
Date: Tue, 19 Aug 2025 18:23:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko
 <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, "Michal =?UTF-8?B?S291dG7DvQ==?="
 <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>, Simon Horman
 <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, Kuniyuki
 Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 net-next 09/10] net-memcg: Pass struct sock to
 mem_cgroup_sk_under_memory_pressure().
Message-ID: <20250819182356.75aa4996@kernel.org>
In-Reply-To: <20250815201712.1745332-10-kuniyu@google.com>
References: <20250815201712.1745332-1-kuniyu@google.com>
	<20250815201712.1745332-10-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 20:16:17 +0000 Kuniyuki Iwashima wrote:
> We will store a flag in the lowest bit of sk->sk_memcg.
> 
> Then, we cannot pass the raw pointer to mem_cgroup_under_socket_pressure().
> 
> Let's pass struct sock to it and rename the function to match other
> functions starting with mem_cgroup_sk_.
> 
> Note that the helper is moved to sock.h to use mem_cgroup_from_sk().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Hi Shakeel, looks like you acked every single patch here but this one.
Is this intentional? :)


Return-Path: <cgroups+bounces-9183-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D74EB27022
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 22:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFC61BC7E3C
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 20:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6B5259CBF;
	Thu, 14 Aug 2025 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AYlpvdK7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB050258CF6
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202920; cv=none; b=bwvdODb5qBZwUdLH8vC7sntd8P1yXgnul0Tigd4FfzjAV4GeXcADylrrZsXvbUA9SWFXHzoszWHzc43oCKo7Vdb6zhQ7gAwzyUmlXo3TYxEJRvr4CaZfyMGk0PDULH+pmDiqW1LX7uH0DAXK86JO2uT0WuNW3L7M2Q2ePc22Kwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202920; c=relaxed/simple;
	bh=889VYTRIrbL3AsWcOiJZXGuYshjOG6r3nV8h7mnZeGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GCovb4RUrLQYU+gYqBK/iCvTJCBKMFGy2WCFpIQAIUmgYflMIgmTAiUFA8AJRp6a2lSZO7pl8RIVlvtweAoYqaJM2j9sVT8bozJo0kziOHcABYTwB7R8jhr6tEq4nBiG/ErOjEhI7EhwOWev5qsBPe7BYOPZo2IONYIXKqVGRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AYlpvdK7; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755202906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=889VYTRIrbL3AsWcOiJZXGuYshjOG6r3nV8h7mnZeGo=;
	b=AYlpvdK7DjpVAS/UM1NYteoAytadnZdoVApEVlZwGSQBgzH6J+vMAPj4+JWjquYjK8X0z5
	eG9bgeus6GC4N1okdQkTVZW+gfU+jn+Mi/hNMgxrTijT6YWoZhufcdP1T+WSlKD36RdA3f
	XjhOHHO0bZbB9SDh0THNG9EOWeH6KEw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Neal Cardwell
 <ncardwell@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Willem de
 Bruijn <willemb@google.com>,  Matthieu Baerts <matttbe@kernel.org>,  Mat
 Martineau <martineau@kernel.org>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,
  Andrew Morton <akpm@linux-foundation.org>,  =?utf-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>,  Tejun Heo <tj@kernel.org>,  Simon Horman
 <horms@kernel.org>,  Geliang Tang <geliang@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Mina Almasry <almasrymina@google.com>,  Kuniyuki
 Iwashima <kuni1840@gmail.com>,  netdev@vger.kernel.org,
  mptcp@lists.linux.dev,  cgroups@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH v4 net-next 10/10] net: Define sk_memcg under CONFIG_MEMCG.
In-Reply-To: <20250814200912.1040628-11-kuniyu@google.com> (Kuniyuki
	Iwashima's message of "Thu, 14 Aug 2025 20:08:42 +0000")
References: <20250814200912.1040628-1-kuniyu@google.com>
	<20250814200912.1040628-11-kuniyu@google.com>
Date: Thu, 14 Aug 2025 13:21:24 -0700
Message-ID: <877bz5lkmz.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kuniyuki Iwashima <kuniyu@google.com> writes:

> Except for sk_clone_lock(), all accesses to sk->sk_memcg
> is done under CONFIG_MEMCG.
>
> As a bonus, let's define sk->sk_memcg under CONFIG_MEMCG.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>


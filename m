Return-Path: <cgroups+bounces-8947-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C5B16A9E
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 04:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894673A652A
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 02:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16E020E702;
	Thu, 31 Jul 2025 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qODRXZlu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526CC15383A
	for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 02:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930725; cv=none; b=tPnshaklfDiLAdIe40w1TCYLa+H05SIYeUApQkI0bQjJcyDh34601AzTVDQmS00W3mxJq37llsu6XdvsGYI2cTW9FVD5BecvSGhxQGXXL3LqkN5tBLzaeOajGeuSEuqDCo5pOUkQ+WUowdwZZXyA6F9xaXQxQpc1jGg4Od4oMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930725; c=relaxed/simple;
	bh=hO4jQq8PLpE3srsD0rPnbC1MtEeo3jkBhYPUfq1jFi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=emzGC4bHv7cKUNCcFQ+3/QXjqL03OPh94qWJtpNHdG85cOiBgOZDadve9g/QCjDaLhEUoEkdVwmS2SuG//MIj7zNj49/EXwWaSlle9eL4F+3H2Mo6qAwVRScYeJqP8vqult3bu2RWk79esohf4PBoLTQWVSjDbw8sj1oMvsdu1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qODRXZlu; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753930720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hO4jQq8PLpE3srsD0rPnbC1MtEeo3jkBhYPUfq1jFi8=;
	b=qODRXZluoTdZwsqIuRfPB+EmJlGTteKL3nnL/Ucebe10AjPqn+1D455FmrTHJPFgnZI0Jh
	JMNnJ6aM2zKV+49b9RReayHJAoHS8GgGkLFGaAFI3DdlOr+/X3+3i7whoAoR7V9v4nUV5l
	Lb4LEniPT+7zzehE3Z3mfWCDC1JYkBE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Neal Cardwell
 <ncardwell@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Willem de
 Bruijn <willemb@google.com>,  Matthieu Baerts <matttbe@kernel.org>,  Mat
 Martineau <martineau@kernel.org>,  Johannes Weiner <hannes@cmpxchg.org>,
  Michal Hocko <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,
  Andrew Morton <akpm@linux-foundation.org>,  Simon Horman
 <horms@kernel.org>,  Geliang Tang <geliang@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Kuniyuki Iwashima <kuni1840@gmail.com>,
  netdev@vger.kernel.org,  mptcp@lists.linux.dev,  cgroups@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
In-Reply-To: <20250721203624.3807041-14-kuniyu@google.com> (Kuniyuki
	Iwashima's message of "Mon, 21 Jul 2025 20:35:32 +0000")
References: <20250721203624.3807041-1-kuniyu@google.com>
	<20250721203624.3807041-14-kuniyu@google.com>
Date: Wed, 30 Jul 2025 19:58:32 -0700
Message-ID: <87pldhf4mf.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kuniyuki Iwashima <kuniyu@google.com> writes:

> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
>
> When running under a non-root cgroup, this memory is also charged to the
> memcg as sock in memory.stat.
>
> Even when memory usage is controlled by memcg, sockets using such protocols
> are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
>
> This makes it difficult to accurately estimate and configure appropriate
> global limits, especially in multi-tenant environments.
>
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
>
> In reality, this assumption does not always hold, and a single workload
> that opts out of memcg can consume memory up to the global limit,
> becoming a noisy neighbour.
>
> Let's decouple memcg from the global per-protocol memory accounting.
>
> This simplifies memcg configuration while keeping the global limits
> within a reasonable range.

I don't think it should be a memcg feature. In fact, it doesn't have
much to do with cgroups at all (it's not hierarchical, it doesn't
control the resource allocation, and in the end it controls an
alternative to memory cgroups memory accounting system).

Instead, it can be a per-process prctl option.

(Assuming the feature is really needed - I'm also curious why some
processes have to be excluded from the memcg accounting - it sounds like
generally a bad idea).

Thanks


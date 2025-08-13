Return-Path: <cgroups+bounces-9115-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74518B23DDF
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 03:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46645856BD
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 01:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113F01A23A6;
	Wed, 13 Aug 2025 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FTYQkOUv"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA21213BC0C
	for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049669; cv=none; b=XWF/rps7NXE5CGRp6ZPPxVkzQhlfms7fVgwsjzGQiQCupxxz/mrwaAEmP5EoTYFfquMBr6iaMVlaGd2NxaLknv2S9M/zR+2GqD6j+pKbu0mh/95f2M93gPh5sujBQB+iBBsntxBazOARMdFaTszR4tH8Pf3K+TexH8FhJYPf9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049669; c=relaxed/simple;
	bh=zMF9GFXJ6Qj3YiII9M3bcvYpqiCjR5wzUFfq8z/K6XI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZHbPQbHkiB7LIULgmA4/F8RQ42DITBBdlSyog3TvyrYCDIY+EwrIqaDwO1K8g0TG0mA8VHXKR7h1LlnAYagjaM8WWJ/6A+v2GZas3Z6QMHh+sktjKA17IWwyarxBf2zB6U/WoFiyiGjTHsuJM21dzNpzUzrJyGxNRxRMsddIGrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FTYQkOUv; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755049666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zMF9GFXJ6Qj3YiII9M3bcvYpqiCjR5wzUFfq8z/K6XI=;
	b=FTYQkOUvj+t/XYrp4P59mJ9IAnMlXI/vjuCXT/xnTdWOvZYRD6kb6A4LK6bymUccbHK/bj
	0RWM80egWzvTKhb2lAJ6vtM6tCh9v8LwUgu+kRILBruyR9dKc9+q+UErTnzZrEFFb1tqYk
	Lv9ceKaVO01aJ+JpG804qpDDA6xiocQ=
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
Subject: Re: [PATCH v3 net-next 08/12] net-memcg: Pass struct sock to
 mem_cgroup_sk_(un)?charge().
In-Reply-To: <20250812175848.512446-9-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Tue, 12 Aug 2025 17:58:26 +0000")
References: <20250812175848.512446-1-kuniyu@google.com>
	<20250812175848.512446-9-kuniyu@google.com>
Date: Tue, 12 Aug 2025 18:47:36 -0700
Message-ID: <87sehwq9fr.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kuniyuki Iwashima <kuniyu@google.com> writes:

> We will store a flag in the lowest bit of sk->sk_memcg.
>
> Then, we cannot pass the raw pointer to mem_cgroup_charge_skmem()
> and mem_cgroup_uncharge_skmem().
>
> Let's pass struct sock to the functions.
>
> While at it, they are renamed to match other functions starting
> with mem_cgroup_sk_.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>


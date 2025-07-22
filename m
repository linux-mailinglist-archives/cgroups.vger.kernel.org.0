Return-Path: <cgroups+bounces-8866-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F69B0E3A6
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 20:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFE74E3287
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF95280A58;
	Tue, 22 Jul 2025 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="px/4UZxU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3AA221297
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210090; cv=none; b=u58TljRVZ3EVsxRfirnHUW3Cy6hwykNumpe3qQroCR/qm8xTbpxu94qtgQBuTnwzVazu0OztYEu/Iyl7cxYXq3Op4NlAWlxUKA4FvrruIu5LHv2nUR2yIcKdYvUCind1YSygUhqhV4kHSahpZGfdAneOheVSB7E6A+WqFZBTFMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210090; c=relaxed/simple;
	bh=YGmW3D7ASEelLjgYBUU+VDJhURA4prAt2wQSaMN3LhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRX56qVpgu+Au5/mBpOoMhijyAyQYTiZ62zGQgd0yfNAXVQNYj79hiiJiVPBGyp+sjuwWFHJYbr+eVCaXhFwQ+xTEXqQWKz9vL60W1UqOu3cJEN6W8qovHZBKxuIqECEhSymVpoieLvIt5xeMkoStslG3v+vp6P/oU3JLzNQobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=px/4UZxU; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 11:47:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753210074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5sCklFQeH1wpwJU3c3owakmNQ9FbOcSJOwXrNUCuwsc=;
	b=px/4UZxUJlH60I/csj7mBusDiqFmR5qMD44hPwbqcQeWS+/juOizvApMMbDvBJ1nexsZzw
	jO26AzePuLJXHPA+HrDuuFUuo01ntMFCnPe/c8vmwzqC+A9Zgfak7zhOqq4D3L3EeT8QOi
	1fnx+s/trAF2+75Rr6x/CUG6BZcLMDY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
 <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
 <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
 <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 22, 2025 at 11:18:40AM -0700, Kuniyuki Iwashima wrote:
> >
> > I expect this state of jobs with different network accounting config
> > running concurrently is temporary while the migrationg from one to other
> > is happening. Please correct me if I am wrong.
> 
> We need to migrate workload gradually and the system-wide config
> does not work at all.  AFAIU, there are already years of effort spent
> on the migration but it's not yet completed at Google.  So, I don't think
> the need is temporary.
> 

From what I remembered shared borg had completely moved to memcg
accounting of network memory (with sys container as an exception) years
ago. Did something change there?

> >
> > My main concern with the memcg knob is that it is permanent and it
> > requires a hierarchical semantics. No need to add a permanent interface
> > for a temporary need and I don't see a clear hierarchical semantic for
> > this interface.
> 
> I don't see merits of having hierarchical semantics for this knob.
> Regardless of this knob, hierarchical semantics is guaranteed
> by other knobs.  I think such semantics for this knob just complicates
> the code with no gain.
> 

Cgroup interfaces are hierarchical and we want to keep it that way.
Putting non-hierarchical interfaces just makes configuration and setup
hard to reason about.

> 
> >
> > I am wondering if alternative approches for per-workload settings are
> > explore starting with BPF.
> >

Any response on the above? Any alternative approaches explored?


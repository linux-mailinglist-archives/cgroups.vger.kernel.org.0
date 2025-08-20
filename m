Return-Path: <cgroups+bounces-9297-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4732BB2E56C
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 21:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10511C846D2
	for <lists+cgroups@lfdr.de>; Wed, 20 Aug 2025 19:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507C328000A;
	Wed, 20 Aug 2025 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7m+UaI6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5F736CDEB;
	Wed, 20 Aug 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716593; cv=none; b=sIzduzPaTS0ES/rEbbE8OSrSVE/1MiV44+qZJaOvCha4nv9LZFWUnHiBV/q9W0zQBk6aJHhGTrG0gvERZcz64bVU8nX/Kq3zEZma/h7DZQNrSkNcONtxHPaAM4+lKJaZxIZc97QBzB8ohTyhS+FhPMOojJ8F6Xlku/J1Q4zAFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716593; c=relaxed/simple;
	bh=odD/T6EvPgMd2KV47i6OxxVsN3PY9jzhXcMSyoj+vRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOnlXjBaOlzHO2KP+U0g2TtZLPqRTtEna4vbDx98br4d3MoU+TUBqwbRQaozz/Ouv1CLNd779RbxI4lTnTcweDnYohWdqG4oNziU/uL6xFR1DyBbSUEacDwHX2edsBU8Cnq9Z1MBRj/1P0ruSRl1s6E4aA7hFKVgNb7XyRhgPYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7m+UaI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1DFC4CEE7;
	Wed, 20 Aug 2025 19:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755716592;
	bh=odD/T6EvPgMd2KV47i6OxxVsN3PY9jzhXcMSyoj+vRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7m+UaI6oQeP8JYab2Nf7jH0X0EUH+aTaZTSQYheGVQir/3UPwdBnPR0Bi2Od8h+B
	 GEiLUDa9C0mMvdd20fFORMnVJYc3IqniQscqwRZnbMJprKVo2wXyAOmQ3JJrxifxHI
	 O651V2hk5sXJvrbhwUnFoVkN+ayXQg3ayzhUOH4Bk+5VD+NMDf42qmOu13N1xQSUYr
	 nj8/BMtaEWq3vR3NmZ3ur5ybBoiWyT/MiW0IAULG0xgffiEWL/eKnQjJcK8kd2YJi4
	 IuW3P9pG58TpLKY9juUccPaAl5SByEag2HNibrU3+BAnnkiwbEcZfE4RfFhlkNTcvn
	 x0brddGhUzNig==
Date: Wed, 20 Aug 2025 09:03:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Matyas Hurtik <matyas.hurtik@cdn77.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Daniel Sedlak <daniel.sedlak@cdn77.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Message-ID: <aKYb7_xshbtFbXjb@slm.duckdns.org>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <aJeUNqwzRuc8N08y@slm.duckdns.org>
 <gqeq3trayjsylgylrl5wdcrrp7r5yorvfxc6puzuplzfvrqwjg@j4rr5vl5dnak>
 <aJzTeyRTu_sfm-9R@slm.duckdns.org>
 <e65222c1-83f9-4d23-b9af-16db7e6e8a42@cdn77.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e65222c1-83f9-4d23-b9af-16db7e6e8a42@cdn77.com>

Hello,

On Wed, Aug 20, 2025 at 06:51:07PM +0200, Matyas Hurtik wrote:
...
> And the read side:
>   total_duration = 0;
>   for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
>     total_duration += atomic_long_read(&memcg->socket_pressure_duration);
> Would that work?

This doesn't make sense to me. Why would a child report the numbers from its
ancestors?

Thanks.

-- 
tejun


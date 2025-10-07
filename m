Return-Path: <cgroups+bounces-10590-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D63BC2947
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 22:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983E5188E2A8
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 20:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848CE1FECAB;
	Tue,  7 Oct 2025 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0HQm81i"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1941A8401;
	Tue,  7 Oct 2025 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867313; cv=none; b=U2MidH3MXgtjE9+XSnyPonqc1suc6nYSEbiBvcyVrmoDp0EBTNUcIzivvTronCEd3RNylemMami4hjlGu8s5/xszFCyNwNwc22jdGgDxaU2dld1YIvh1m2fs3VtMeIKQurp5KnItK+9YeYuBG9ZHpPjzp4JYxXlpoPdD+YArOA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867313; c=relaxed/simple;
	bh=+kd6dOZFIOmjSNgpR1x2QwO0MCg1WYh6jGTABkyuXDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1wwl6H5Fqfr4SfgYp1KnBV0rLWuLJwPPySi/516jj21hnFkUoPltokw+n237Y6IL2znQimqvE1iM7jVjtyIIBLIDunEfaX5otKt04bnPmnGQ7Dz7mJ8dBf0RJeNViQ3V8CopNBm/0Ceoo3Jd2ztpvjJuxJ3Furw3FhB4VvGoDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0HQm81i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EC4C4CEF1;
	Tue,  7 Oct 2025 20:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759867312;
	bh=+kd6dOZFIOmjSNgpR1x2QwO0MCg1WYh6jGTABkyuXDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0HQm81iGSKVFOSxMqCnqXlOfEFv6hvpPMcwP5z48eSQ8imRIFnKsFkYDuHgsujXi
	 PVKhmKCkmd/rNYLZfVCRK26CLzqWjHR0gkTPEUhMqHEzj5VnzwrZ5v80ZG7qF7vWM4
	 zv6c+msgQaKvsRbf8770PclbOK8w0Ng779bXGzs+0S/Hd0E/+8EILbjN0zNPDjDDSJ
	 MS05VhZrAGsvSMKfRsyRgwCL5Xtlt4a5IXmfoyNWToFbxoXCPGKftLyOmc+odxx4s3
	 Hf6YsWifRQO0YIkeq5gwyP5PqlWbk8fR+H2zwdairp2bJwwaImKb7Scu4pfRUak66Z
	 aTfR8LfyzWxTA==
Date: Tue, 7 Oct 2025 10:01:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: "David S. Miller" <davem@davemloft.net>,
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
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v5] memcg: expose socket memory pressure in a cgroup
Message-ID: <aOVxrwQ8MHbaRk6J@slm.duckdns.org>
References: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007125056.115379-1-daniel.sedlak@cdn77.com>

On Tue, Oct 07, 2025 at 02:50:56PM +0200, Daniel Sedlak wrote:
...
> 1) None - keeping the reported duration local to that cgroup:
> 2) Propagating the duration upwards (using rstat or simple iteration
> 3) Propagating the duration downwards (write only locally,
>    read traversing hierarchy upwards):
...
> We chose variant 1, that is why it is a separate file instead of another
> counter in mem.stat. Variant 2 seems to be most fitting however the
> calculated value would be misleading and hard to interpret. Ideally, we
> would go with variant 3 as this mirrors the logic of
> mem_cgroup_under_socket_pressure(), but the third variant can be also
> calculated manually from variant 1, and thus we chose the variant 1
> as it is the most versatile one without leaking the internal
> implementation that can change in the future.

I'm not against going 1) but let's not do a separate file for this. Can't
you do memory.stat.local? It'd be better to have aggregation in memory.stat
but we can worry about that later.

Thanks.

-- 
tejun


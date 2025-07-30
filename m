Return-Path: <cgroups+bounces-8924-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F5FB1563F
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 02:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F3A18A06ED
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 00:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89C22A1CA;
	Wed, 30 Jul 2025 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxtYG9E2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737C11EB3D;
	Wed, 30 Jul 2025 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753834546; cv=none; b=cAj6x4xOZChrEDGKkdZfeer8MPhR1gERVKBTNLCWQ/w0RcTzV6f3eseLs/gL34gNhd2zbLNZIq4BhZcM4jX8QpxEVYtUfdT5O7zaa043+jx5Wt4XZ55fPhf3/aa782PXFvXNSKrJWl0pRIdBCT+MwgLEJNHoowTWqAfHnYdn6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753834546; c=relaxed/simple;
	bh=/IL8wmq+lOfAOx4ojeLTp4+XN3Okds+fOFj21+eklGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfaArnMYVFt26sAjAj2pOxXn2nlQAB2eQC/+dELsTVeku6qKDIRiBd8yqesJFaZcEGNkx/mVQUV5u1A535e2wbHeLGtZm0DBkSLcj3I1YgkfrbCCRspWNbk52UvzJAtMPSt75n2Bc60QhN05/R/P6gAf8O8ymUG5OD12VTXiVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxtYG9E2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E35C4CEEF;
	Wed, 30 Jul 2025 00:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753834545;
	bh=/IL8wmq+lOfAOx4ojeLTp4+XN3Okds+fOFj21+eklGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxtYG9E23WOEWELbkklCmxuL7KIqwx5IVWa0qXcWHnsLD3l40Y8GiejBlbRH+pmfx
	 ajucUIRd+AQxoF6UrKLR4jozCnIS2AcobpcoOxG5ev1G1fj8CpgFQD7BF779tBSNDH
	 RkloEKhmTdoI32GKc3sUaSf60Iz5LSzpg5/pawFHn0go0rgZ4oiEU4/U70TIQXajlM
	 LPVojjAkJz3EQFiAdYmRbv6BCyCXl0Lv3Y46tI6uDDwTDISfbK1NTqEN62+TYCSOhg
	 7x1B++x/mku8g5a5/CIafTpkyeh3UDn6xYIHpOR2VKozK1SghUKPDLhMg8Z10RxemJ
	 Dze+B39NhWoNA==
Date: Tue, 29 Jul 2025 14:15:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
Message-ID: <aIlkLxDMT6keDJAC@slm.duckdns.org>
References: <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com>
 <4g63mbix4aut7ye7b7s4m5q7aewfxq542i2vygniow7l5a3zmd@bvis5wmifscy>
 <CAAVpQUCOwFksmo72p_nkr1uJMLRcRo1VAneADon9OxDLoRH0KA@mail.gmail.com>
 <jj5w7cpjjyzxasuweiz64jqqxcz23tm75ca22h3wvfj3u4aums@gnjarnf5gpgq>
 <yruvlyxyy6gsrf2hhtyja5hqnxi2fmdqr63twzxpjrxgffov32@l7gqvdxijs5c>
 <878ca484-a045-4abb-a5bd-7d5ae82607de@cdn77.com>
 <irvyenjca4czrxfew4c7nc23luo5ybgdw3lquq7aoadmhmfu6h@h4mx532ls26h>
 <486bfabc-386c-4fdc-8903-d56ce207951f@cdn77.com>
 <aILTi2-iZ1ge3D8n@slm.duckdns.org>
 <924a8a12-ed89-45e5-900d-6d937108ec3e@cdn77.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <924a8a12-ed89-45e5-900d-6d937108ec3e@cdn77.com>

On Mon, Jul 28, 2025 at 01:29:29PM +0200, Daniel Sedlak wrote:
...
> Ok, I will send it as v4, if no other objections are made. In which units
> the duration should be? Milliseconds? It can also be microseconds, which are
> now used in (cpu|io|memory|irq).pressure files.

Yes, microseconds.

Thanks.

-- 
tejun


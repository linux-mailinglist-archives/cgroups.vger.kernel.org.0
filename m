Return-Path: <cgroups+bounces-12927-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7D2CF697F
	for <lists+cgroups@lfdr.de>; Tue, 06 Jan 2026 04:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1393C305D99B
	for <lists+cgroups@lfdr.de>; Tue,  6 Jan 2026 03:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9422A4FE;
	Tue,  6 Jan 2026 03:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L4SeUm1j"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A812248BE
	for <cgroups@vger.kernel.org>; Tue,  6 Jan 2026 03:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767669277; cv=none; b=ngNKwQENaeQQ+2nTbzP09tTm0JvzSWnmnDDHji1w/u3ryuXUIyk5H2WYFOfMvEaPlC1S6879A4sDcRjWAQaBtALtJnf94Evutcuf0UTx2FUIyo9GT4zC+JrTS0VOUmz/e4jdtfqdKcAX0w/OZkSswDWvnatpoR7zadmC1GwpJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767669277; c=relaxed/simple;
	bh=qoZ/tlTPnPndCNj6CJ0wQxbyr0N4gGrEz+sLejOl0HQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=hqYyok22f/9RysrflDjL/6tUPOQKjKmX1OBPphLZNuzUmVRPj1//3Ush1B78Tpd2lJakNc/3/vmisOEGbgDf1DkpVsHzUlqsbgnTJVLzlVRFfTf26faKVAZd3ZI792l098eKiMi/vX7KP7Z/rjXG4103xOV6xu8GpW+pmXA+O7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L4SeUm1j; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767669272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSIXmXHDZZDTd4tsk6VB8G6eA4XEfbMhwVQl2vQbAZs=;
	b=L4SeUm1j/nAU67n5ezffzmjCAaPcy9UI1hOi8JJXpVKrGChdsu2EFiAaRVNxAAogheJBV2
	46PNCMSxVk70AuM1bZ9lNDF2H/zmLT84KOpu/+AECdoBYf0wv8i/6YNjscf5lh4OVuGL1T
	lnrfComLSWTDt2PpK8hY7rvDVs6apkM=
Date: Tue, 06 Jan 2026 03:14:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <d9ed02ebcf71057e42c808beb68f8eb489394750@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] mm/memcg: scale memory.high penalty based on refault
 recency
To: "Shakeel Butt" <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Muchun Song"
 <muchun.song@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
 "David Hildenbrand" <david@kernel.org>, "Qi Zheng"
 <zhengqi.arch@bytedance.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Axel Rasmussen"
 <axelrasmussen@google.com>, "Yuanchu Xie" <yuanchu@google.com>, "Wei Xu"
 <weixugc@google.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Hui Zhu" <hui.zhu@linux.dev>
In-Reply-To: <qlzvksuvo22rrngdihyeepwhphretoenre3gvkako7kgsgw3sy@l775pvzorcdh>
References: <20251229033957.296257-1-jiayuan.chen@linux.dev>
 <qlzvksuvo22rrngdihyeepwhphretoenre3gvkako7kgsgw3sy@l775pvzorcdh>
X-Migadu-Flow: FLOW_OUT

January 6, 2026 at 01:08, "Shakeel Butt" <shakeel.butt@linux.dev mailto:s=
hakeel.butt@linux.dev?to=3D%22Shakeel%20Butt%22%20%3Cshakeel.butt%40linux=
.dev%3E > wrote:


>=20
>=20+Hui Zhu
>=20
>=20Hi Jiayuan,
>=20
>=20On Mon, Dec 29, 2025 at 11:39:55AM +0800, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20=20
>=20>  Problem
> >  -------
> >  We observed an issue in production where a workload continuously
> >  triggering memory.high also generates massive disk IO READ, causing
> >  system-wide performance degradation.
> >=20=20
>=20>  This happens because memory.high penalty is currently based solely=
 on
> >  the overage amount, not the actual impact of that overage:
> >=20=20
>=20>  1. A memcg over memory.high reclaiming cold/unused pages
> >  =E2=86=92 minimal system impact, light penalty is appropriate
> >=20=20
>=20>  2. A memcg over memory.high with hot pages being continuously
> >  reclaimed and refaulted =E2=86=92 severe IO pressure, needs heavy pe=
nalty
> >=20=20
>=20>  Both cases receive identical penalties today. Users are forced to
> >  combine memory.high with io.max as a workaround, but this is:
> >  - The wrong abstraction level (memory policy shouldn't require IO tu=
ning)
> >  - Hard to configure correctly across different storage devices
> >  - Unintuitive for users who only want memory control
> >=20
>=20Thanks for raising and reporting this use-case. Overall I am supporti=
ve
> of making memory.high more useful but instead of adding more more
> heuristic in the kernel, I would prefer to make the enforcement of
> memory.high more flexible with BPF.
>=20
>=20At the moment, Hui Zhu is working on adding BPF support for memcg but=
 it
> is very generic and I would prefer to start with specific and real
> use-case. I think your use-case is real and will be beneficial to many
> other users. Can you please followup on that Hui's RFC to present your
> use-case? I will also try to push the effort from the review side.
>=20
>=20thanks,
> Shakeel
>

Hi Shakeel,

Thanks for the feedback and pointing to Hui's RFC.

I noticed Michal has already forwarded my patch to that thread, and
Hui has responded. I'll wait to see how that discussion evolves and
whether there's an opportunity to integrate my use-case into his
BPF framework.

You're right that my timestamp-based approach is heuristic. It was
designed as a simple, low-overhead approximation to detect active
thrashing without the cost of flushing refault counters on every
charge. But I agree that a more flexible BPF-based solution could
be cleaner in the long term.

I'll follow up on Hui's thread once there's more progress.

Thanks,
Jiayuan


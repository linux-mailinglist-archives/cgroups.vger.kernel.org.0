Return-Path: <cgroups+bounces-12687-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E80CDC9B9
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 15:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAEAD30820A7
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAAF33E35D;
	Wed, 24 Dec 2025 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NvKppPY/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214B31A55B
	for <cgroups@vger.kernel.org>; Wed, 24 Dec 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766587891; cv=none; b=nW3UcAWANtlec0LUDQgLFY7wOvoj8kjevSANkzwLKsCG50TtoXLNklz3v4GXFtJJDj+n881wBrntJW4LGGyWUXmGdPgG2vqiR5jQfPkSF1AXKbpASJeezIPxusN+Qxmq7/jQbHXv3OZlrYJkLzcG2NH1o5/79GQQ8WsUcGuRtOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766587891; c=relaxed/simple;
	bh=Rp+lRlZOcYTrpWK22yLTaZ01bPK7Jm9kSTUZQkMovWE=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=QXelgRB1POx5BFWXx73pxS5KkZFFhlNZ2AqmPwH0AVlTft7WjMXYDOAv+iCFP6nVZKNQx+Q+Rc3RFf7s8r5A2Lab6Oztfd+quAyqbjSC14NG6TrHP9YzFWJHZbh1cBH7zh6c6O8uAe5sLoqp4aaqvc/dbWFOlrHAeh1eHKAzgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NvKppPY/; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766587877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoh76je9Y3Sm6zc0YLyPu6J6RebFiJwddemaqJXNDUQ=;
	b=NvKppPY/LBc/y5r9Uxy9sDkzpg2e5Y348uqB7ay4FLX+k9Tdm2sZxSUermDM+sKVWI6vPI
	vzonrh+F9CaCZQcHYlpVt/H0D67eFs+eeQiCPnsNKNrLlGDcauHDMrLMtgU/f0LM4AUbL1
	UkxrbfC/5LD5mUiv/RvdFAy2UCX/b1A=
Date: Wed, 24 Dec 2025 14:51:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yosry Ahmed" <yosry.ahmed@linux.dev>
Message-ID: <23f6bad90dd7eb98a7fef00736b4aff21bbcad4d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
To: "Harry Yoo" <harry.yoo@oracle.com>
Cc: "Qi Zheng" <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, "Qi Zheng" <zhengqi.arch@bytedance.com>
In-Reply-To: <aUunxoFxrx5hiIPy@hyeyoo>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5>
 <aUunxoFxrx5hiIPy@hyeyoo>
X-Migadu-Flow: FLOW_OUT

December 24, 2025 at 12:43 AM, "Harry Yoo" <harry.yoo@oracle.com> wrote:


>=20
>=20On Tue, Dec 23, 2025 at 08:04:50PM +0000, Yosry Ahmed wrote:
>=20
>=20>=20
>=20> I think there might be a problem with non-hierarchical stats on cgr=
oup
> >  v1, I brought it up previously [*]. I am not sure if this was addres=
sed
> >  but I couldn't immediately find anything.
> >=20
>=20Hi, Yosry. Thanks for bringing this up!
>=20
>=20>=20
>=20> In short, if memory is charged to a dying cgroup at the time of
> >  reparenting, when the memory gets uncharged the stats updates will o=
ccur
> >  at the parent. This will update both hierarchical and non-hierarchic=
al
> >  stats of the parent, which would corrupt the parent's non-hierarchic=
al
> >  stats (because those counters were never incremented when the memory=
 was
> >  charged).
> >=20
>=20Hmm, I wonder if this only applies to LRU pages.
>=20
>=20In theory we should have this problem for NR_SLAB{UN,}RECLAIMABLE_B
> because we already reparent objcgs, or am I missing something?

We do, but we don't expose these stats in cgroup v1, and we don't expose =
non-hierarchical stats in cgroup v2.


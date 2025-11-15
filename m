Return-Path: <cgroups+bounces-11985-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C32FC5FD2C
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 02:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9333BA762
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 01:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA7A1C3BE0;
	Sat, 15 Nov 2025 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhEqFRWJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627917BEBF;
	Sat, 15 Nov 2025 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763169773; cv=none; b=mnPetuWkPhZDGceZNk45yqYeBYkGmpmyF9cJhEPbpM1I8Zg2wIzwBx7xShMrSiiAHB08o8JRKR4/+scfv8oZD1fNm18QTUMC/Iv5d08EDb2r8CpBJTBh3m5bHw8svnjdb5D5tK/LXCWeAT4ilfGPgr/LmrGP3EWjl8mTh63/9Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763169773; c=relaxed/simple;
	bh=eQsdDltmb6P7uFAk5MYeuKsn/K8/pYmmEhSLmqls45A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWOFxt1ZaVWwpSx3iCegzA+KyrgoI12o5XlLmYoQtDKTHFbrW2QsxFbYaNEdhHSdlldWCyoEQsyOMYoVoUDxZvKa4uz/2D3mhtLNj5zFvLT4Umm5eV2DKGeJ6VhkRs3AKAe+m/AMmu0Ph/ewiW112RMyHycX+ssI0SZ02HIczqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhEqFRWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FE0C4CEF8;
	Sat, 15 Nov 2025 01:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763169772;
	bh=eQsdDltmb6P7uFAk5MYeuKsn/K8/pYmmEhSLmqls45A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhEqFRWJRAl8ptzMXC9mAW/w4Mk1OEKJ6drFzClhcMlgN0OHpKVwIysriIsH4E0jB
	 TPMcGNZl87bIxYAdbKurkge+oINY5IdFUx1vaCRpI6F/AsxdL3dqyb8pQU1Gbb+jRC
	 OIKlhQk+QTSLISAlg3xc4M6fvnpTVWFWf0vyM9Lt32IAqxDxV2rp2QsoYGFeYqyXGE
	 Ge2PibrejVTmI/YJ66JOUjh+5W9RK9kDlxXjbQ6I1sc4dCL6fodKX3q9PsV9UEblk2
	 p6GyUsFY4JWOBrhAY7n9AicE5YqROoHJkRkce3t8gm39AQNARp0CPj6SmZcNmDAIxd
	 iV2MTiHObJOyg==
From: SeongJae Park <sj@kernel.org>
To: Youngjun Park <youngjun.park@lge.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	gunho.lee@lge.com,
	taejoon.song@lge.com
Subject: Re: [RFC] mm/swap, memcg: Introduce swap tiers for cgroup based swap control
Date: Fri, 14 Nov 2025 17:22:45 -0800
Message-ID: <20251115012247.78999-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251109124947.1101520-1-youngjun.park@lge.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun,  9 Nov 2025 21:49:44 +0900 Youngjun Park <youngjun.park@lge.com> wrote:

> Hi all,
> 
> In constrained environments, there is a need to improve workload
> performance by controlling swap device usage on a per-process or
> per-cgroup basis. For example, one might want to direct critical
> processes to faster swap devices (like SSDs) while relegating
> less critical ones to slower devices (like HDDs or Network Swap).
> 
> Initial approach was to introduce a per-cgroup swap priority
> mechanism [1]. However, through review and discussion, several
> drawbacks were identified:
> 
> a. There is a lack of concrete use cases for assigning a fine-grained,
>    unique swap priority to each cgroup. 
> b. The implementation complexity was high relative to the desired
>    level of control.
> c. Differing swap priorities between cgroups could lead to LRU
>    inversion problems.
> 
> To address these concerns, I propose the "swap tiers" concept, 
> originally suggested by Chris Li [2] and further developed through 
> collaborative discussions. I would like to thank Chris Li and 
> He Baoquan for their invaluable contributions in refining this 
> approach, and Kairui Song, Nhat Pham, and Michal Koutný for their 
> insightful reviews of earlier RFC versions.

I think the tiers concept is a nice abstraction.  I'm also interested in how
the in-kernel control mechanism will deal with tiers management, which is not
always simple.  I'll try to take a time to read this series thoroughly.  Thank
you for sharing this nice work!

Nevertheless, I'm curious if there is simpler and more flexible ways to achieve
the goal (control of swap device to use).  For example, extending existing
proactive pageout features, such as memory.reclaim, MADV_PAGEOUT or
DAMOS_PAGEOUT, to let users specify the swap device to use.  Doing such
extension for MADV_PAGEOUT may be challenging, but it might be doable for
memory.reclaim and DAMOS_PAGEOUT.  Have you considered this kind of options?


Thanks,
SJ

[...]


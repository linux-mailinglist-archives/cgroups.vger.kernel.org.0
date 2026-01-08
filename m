Return-Path: <cgroups+bounces-12962-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4580D01088
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 06:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1A6630621D4
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 05:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B652D5A01;
	Thu,  8 Jan 2026 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuHyXbUY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8052D249A;
	Thu,  8 Jan 2026 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767848533; cv=none; b=CoIARXlahBw4Q0T/ncyED2zzEpr9banX6WMaN91vda/NQWCwudkNAMbM4fKDcqWU5pm8HVYn5AR9SR2Iy3H87BExoaZLXMWzBlxlbA5oOOgNFATASWhQnPbKfQMS7i5fezaNxHHz6LZy1gElHGH84r8+mwxfS5YeSauUbJI7G+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767848533; c=relaxed/simple;
	bh=i4vxDHGS1uCPrVEmpsixJJW62XNo1Hexm5sGNP4HlFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCI9tBJfNF8qjpciEUl81pDg8UiJZwbOeLTmd8tAwnNQomXrKsnGE9yT7cp6xNbUKSOb5GfEK7obWOA5roXbC6x7teQ1Ou/H7KLeMBa4x9BhnMn5EVCRs5ZyTJpojBix3LwJ5sixbXAWm124i2RaVrLfmo9NVwvVrCI46debCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuHyXbUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488F7C116C6;
	Thu,  8 Jan 2026 05:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767848532;
	bh=i4vxDHGS1uCPrVEmpsixJJW62XNo1Hexm5sGNP4HlFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MuHyXbUY5gsIUFy+nPKOl8ADyxIguPI/IQJK4MooIQvzrXrOv1dSjqvd6sL2FTTQR
	 dsTx6NRFmFE2kFF02ftOKz9Tbk12OTfkey2pgxVBKE4M8YiqnfDabVxUdcmeeuT+by
	 ldIlmHeJPMfY593xmKo4ys6xlPvD1ABrhoexmOGv8qm9Qc9qXBmQkw8oy5n7Re814Z
	 HetvJrum9TH1HffpcDkGris04F2JqKm02pm3EhhOrv8N+L/wx39iNNM9JHIkvENVQO
	 rFFouuRy85Cu7GLmYcLuGTEa7eBpXQZ8nlsuoLG6bQvEuHr7glgbhOm06G0AjnziCq
	 r58hBkxQjP9/g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] memcg: rename mem_cgroup_ino() to mem_cgroup_id()
Date: Wed,  7 Jan 2026 21:02:02 -0800
Message-ID: <20260108050204.78666-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251227221206.282703-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Dec 2025 14:12:05 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 26 Dec 2025 20:31:38 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Shakeel,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on sj/damon/next]
> > [cannot apply to akpm-mm/mm-everything tj-cgroup/for-next linus/master v6.19-rc2 next-20251219]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Shakeel-Butt/memcg-introduce-private-id-API-for-in-kernel-users/20251226-072954
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> 
> damon/next tree contains some debugging-purpose only changes that not aim to be
> upstreamed.
[...]
> And this issue happens due to a damon/next chage that made for only debugging
> and thus not aiming to be upstreamed.  Hence, no action from Shakeel is needed.
> 
> I will resolve this issue after this patch is added to damon/next.

FWIW, I ended up removing the debugging-only-purpose commit from damon/next.
So hopefully it will not cause any noise.


Thanks,
SJ

[...]


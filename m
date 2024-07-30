Return-Path: <cgroups+bounces-4011-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8858A942180
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 22:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA491C22F85
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 20:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D584918C916;
	Tue, 30 Jul 2024 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jwEVD59/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB7B18B482;
	Tue, 30 Jul 2024 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370719; cv=none; b=cQqunxVt2L2Uo6kFzUB5cy7nnJf8/3zgNH4uzXvPHrC+pevwbVRMuTBjPOMBzwVm1aoB+mWbu+MRGdxpxs4aye4dvICp1lxjETPPDfMVRe+uqTAy41tf7wPjFAFLIga3bUT4KclCo32dTjQBvWvEXbq9IBebmruq8rgd3YX9KTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370719; c=relaxed/simple;
	bh=Rl/+3HeX6qIGurmUZjt7d/d0g5+si7+DJaacpXjNcHI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WrjTmqOgLeB+LRkK7zNaxkIwMeD63/iCDr/kQtdXDrNCY8jtfzBKgt7W259RuNyZCUcvcAJyX+NteB4bsnlfsHgWmmJo2nNWwYD+o1Y+ARuPwuvxmQufMVzZVJ3weDEJbvefWEmdcDReHQX7h0Ymc7r1gmsPt81aq3/gsEMGN4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jwEVD59/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC03C32782;
	Tue, 30 Jul 2024 20:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722370718;
	bh=Rl/+3HeX6qIGurmUZjt7d/d0g5+si7+DJaacpXjNcHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jwEVD59/I0D5axzFYGYXNSK3om8omEvvbfiiSYSN5fzUGkxgZgkCoYgeyAGNSGv65
	 94UQ5DeoX84KGiteLIAyEciMASAOwziMW5yVdkE72naT3U/4b5Eq56f6n1kWoMSLoV
	 U/WHi8F2WocI4GTRvALWDFjjLvOD1qrzqsU/gvuA=
Date: Tue, 30 Jul 2024 13:18:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, vbabka@kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: kmem: add lockdep assertion to obj_cgroup_memcg
Message-Id: <20240730131822.a170e6da169da396a833aa4f@linux-foundation.org>
In-Reply-To: <3c4b978b-b1fe-42d2-b1a7-a58609433f3c@samsung.com>
References: <20240725094330.72537-1-songmuchun@bytedance.com>
	<CGME20240730185206eucas1p28b14a1d9802ce2703bd13edc75e1b55d@eucas1p2.samsung.com>
	<3c4b978b-b1fe-42d2-b1a7-a58609433f3c@samsung.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 20:52:04 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> This patch landed in today's linux-next as commit 230b2f1f31b9 ("mm: 
> kmem: add lockdep assertion to obj_cgroup_memcg"). I my tests I found 
> that it triggers the following warning on Debian bookworm/sid system 
> image running under QEMU RISCV64:

Thanks.  I'll drop the patch while this gets sorted out, to be nice to
linux-next users.


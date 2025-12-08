Return-Path: <cgroups+bounces-12293-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9222ECAE03F
	for <lists+cgroups@lfdr.de>; Mon, 08 Dec 2025 19:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C0A63099D04
	for <lists+cgroups@lfdr.de>; Mon,  8 Dec 2025 18:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B12D7DD3;
	Mon,  8 Dec 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESVown7v"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D562D6E6A;
	Mon,  8 Dec 2025 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218742; cv=none; b=bTb3GIyAHIR/MvL/XvwnXkZrqIKArYNYYzuHWv4KNyyjI1Y9QQgxFn8Hnmf/UaSr+cJsZKSRD0utPZG+2wvW0xNPTENGhha3kouBwAPu1IekKYWBIIxouh0KCx1RZmBhNiJ8nDWo6s3ul3rBDuYHGnMFfCa64zBhvjTxa2tZ1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218742; c=relaxed/simple;
	bh=pCrpHr+5nP6rYJTv7XfOJuqw4MWXOL0/IjDzYaKEs/M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=h9wLeztxPAA6m4IM1Z5xyc6ADrZBg5YwB5YVUsu0cG1BOjiVKNEO3Np1KfPlj8Fb6nvzxjMiVFTLOxsQdMCx2287TSIq1ygTN8Pk1nfdrvP3lpZh9Cu9l9tV0rJ2wy3Yj91g0FMC6Alpak3HzwPjMdPVTrlxGpBBpuQibgzg4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESVown7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A85BC4CEF1;
	Mon,  8 Dec 2025 18:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765218741;
	bh=pCrpHr+5nP6rYJTv7XfOJuqw4MWXOL0/IjDzYaKEs/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ESVown7vYFsf/+ZVQt3bYja9Uz0eFlRxif443ije8LEY2I/bZu0gl7cwBVXAt5dMh
	 kUoo+8H24YEWehD8j6z2wNQjFtCdps2adg+OWR/r3iKgpqB9H11autCk2IIQc8Z9Kh
	 s7OeZz1AhJ1nuKin1uBbcpE4X8C2oClaqkBiwVPzaIIeI+WVlU2+dG6TCF/4gs4C1y
	 PJYE7J4CiH10gEjYHlacSZjWlSQMCgIB5WSMe4Zv+ARTA2f4hCaDnVzyEmZZt7v+o4
	 QjamIfXPlnBX0YC/aGbZZgPgp3za2gqMGJWv9cpUehdGTgKfFIddpFf789CCINE72G
	 kLdW21k3V/RMQ==
Date: Mon, 08 Dec 2025 08:32:20 -1000
Message-ID: <6a075882857f0be33ef8361c18f54a76@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 JP Kobryn <inwardvessel@gmail.com>,
 Yosry Ahmed <yosry.ahmed@linux.dev>,
 linux-mm@kvack.org,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated
In-Reply-To: <20251205200106.3909330-1-shakeel.butt@linux.dev>
References: <20251205200106.3909330-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.19-fixes w/ stable cc added.

Thanks.
-- 
tejun


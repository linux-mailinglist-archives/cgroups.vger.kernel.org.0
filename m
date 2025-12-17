Return-Path: <cgroups+bounces-12389-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC282CC5C79
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 03:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D38B30101C1
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 02:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FA07D07D;
	Wed, 17 Dec 2025 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tPlXnag5"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63F3A1E67
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765938949; cv=none; b=oMto03dzXtJ1ucxqg/LJvhEwpRqsFqC6at78wUHIbIUmAN0GXBPGwMa3RwtsVOFGnAyDuw7kH8XxaswSDhoI46Amg1/IPlMXtvN6hY+n3LZq9hkXDsr0t1IsHc4F4VwVpkOOUzYwy1A4Ov/VbGtg0BlzN+qhAlRUoP3odaq6Xhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765938949; c=relaxed/simple;
	bh=fiBf13gs6B66pnEdGZ4uqxqCSotFnbkUNxUPZPxNybY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cAperGP5KbxBUgG7JmqNcwMAZd42TRrfZQ8smzUVQjXDzJ9L49RIDVewyiPtZiLZBzJyDMu5PogfY20srSCbjUAN91Vh/lOEdIXCPUkqiCTtnYVI0+a1xUa0ZM/ULUUhiYVucSFqtelbodkrU0isOe9/zCN59hlDkhxEziIAp8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tPlXnag5; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765938944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiBf13gs6B66pnEdGZ4uqxqCSotFnbkUNxUPZPxNybY=;
	b=tPlXnag5gfhKjhwnnAiJWQYLhdWF/esHQ5Mk8SE1604YTqnG4BbID6U9G60CQt+Zvebo+S
	/XvMC3bjpDYWMwcXPbbp7+lCwv1DGzfgKYk4p6rpO3kPg41uXxeuzPaIiwifKr7z+uqlsK
	htQSnWK+wCWYajamAOD3NdXEUA0lC6c=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH] mm: memcg: fix unit conversion for K() macro in OOM log
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20251216212054.484079-1-shakeel.butt@linux.dev>
Date: Wed, 17 Dec 2025 10:35:03 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Vlastimil Babka <vbabka@suse.cz>,
 Meta kernel team <kernel-team@meta.com>,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Chris Mason <clm@fb.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACCDA933-E222-4890-A29E-2C77CD4DE35A@linux.dev>
References: <20251216212054.484079-1-shakeel.butt@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Dec 17, 2025, at 05:20, Shakeel Butt <shakeel.butt@linux.dev> =
wrote:
>=20
> The commit bc8e51c05ad5 ("mm: memcg: dump memcg protection info on oom
> or alloc failures") added functionality to dump memcg protections on =
OOM
> or allocation failures. It uses K() macro to dump the information and
> passes bytes to the macro. However the macro take number of pages
> instead of bytes. It is defined as:
>=20
> #define K(x) ((x) << (PAGE_SHIFT-10))
>=20
> Let's fix this.
>=20
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reported-by: Chris Mason <clm@fb.com>
> Fixes: bc8e51c05ad5 ("mm: memcg: dump memcg protection info on oom or =
alloc failures")

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.



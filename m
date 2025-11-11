Return-Path: <cgroups+bounces-11822-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73255C4F84F
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 19:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE4B3B3D0C
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 18:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA42C326B;
	Tue, 11 Nov 2025 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CAmFJeGW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF862C3248
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887525; cv=none; b=n7ynxcyJM/xua77bUFbH6lgyPSD4do8/dAhzJFJE1D3Px9jwbfGQXQ7PbyrmtN3rNEd4adcEQIIDht8MeHtpEZEwyikP56FCKT4BxO3p+9YEtKbP/1RL53ySYwXS6Tf31TAxLEdfHiQMVFEEA7m91ZbKig4Uv5JgiL8RlY12UQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887525; c=relaxed/simple;
	bh=AGVQvQg8MiLEgx1G3pQPBT8+hmFVeqeHvps6Z7l8J/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kLfKYrp/dyqhtS/gzv8vzoArr9moxxjuQOXyfQpaPKZHS2olYv58VzvIJT7VWTYxlwaQaX8R+Gaj5lMf1j9UnkqatDxJIY9OE67tDXlOL+QSOdJdGwOfqTDLYkOx//UeVRfiSQqKwSc76Xz+ATZBgnntwZnERV6ve90FlSDVqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CAmFJeGW; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762887520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AGVQvQg8MiLEgx1G3pQPBT8+hmFVeqeHvps6Z7l8J/w=;
	b=CAmFJeGWCZJN57MY4gwWybs2dREiErDYue/5FkpwaTUcKoSHRYBd+iwgP58+4Ya76HjQaQ
	aTh8usMbQC2DeyEzHeLKJQBPTjn/lvHDdqglejQE+XTtesJbXwIgdjEyyGCRDD9nauKniU
	urGosVTQFZPdErlV2MyeoZQoQWc4vRc=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Harry Yoo <harry.yoo@oracle.com>,  Qi Zheng
 <qi.zheng@linux.dev>,  Vlastimil Babka <vbabka@suse.cz>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/4] memcg: remove __mod_lruvec_kmem_state
In-Reply-To: <20251110232008.1352063-3-shakeel.butt@linux.dev> (Shakeel Butt's
	message of "Mon, 10 Nov 2025 15:20:06 -0800")
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
	<20251110232008.1352063-3-shakeel.butt@linux.dev>
Date: Tue, 11 Nov 2025 10:58:30 -0800
Message-ID: <87qzu4s8fd.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> The __mod_lruvec_kmem_state is already safe against irqs, so there is no
> need to have a separate interface (i.e. mod_lruvec_kmem_state) which
> wraps calls to it with irq disabling and reenabling. Let's rename
> __mod_lruvec_kmem_state to mod_lruvec_kmem_state.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>


Return-Path: <cgroups+bounces-11826-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EAFC4F877
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 20:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C5CE4EB7D9
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 19:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7B202C48;
	Tue, 11 Nov 2025 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zg6iOzgw"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535972836F
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887718; cv=none; b=MV4Iw8w6aWx1TzdJp+PQ126M+k/iHVQg2IMYwXhC6581bPADSoOJ+PaoogYjG3IH5AuHc8TW3WYn5udtORkVHlSIdYbkbbP8RvIFh7EJslDya9hCPZ9Ayai7c+SowIk52TsFIs//toyVo/KZwrP/Sp5ZGy4dvuX/HMgJ4QfKR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887718; c=relaxed/simple;
	bh=X3p0OHTe0vlUjyhDWhZhm6oTZ1C1L+keJX+PJWob0hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RIS9kD8ZNS2GWbK6n+9SbpJUOz9iZlpH6Hu11TnCz0Qp9m7uWjS1oW/LyszqG4MwtYApveiFMQhdClRFtvrSKeYoW60Z7k/4Sl3+h+N3k6oPyyZnr0pYA1x4NetiohTy8NP3HVLs+2oIir3Ogk2ET4u0/ffoU13i7ANVDfqGoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zg6iOzgw; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762887714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3p0OHTe0vlUjyhDWhZhm6oTZ1C1L+keJX+PJWob0hk=;
	b=Zg6iOzgwfbrFafmG6DBIIvIS6DBeLRm6Sopz75Lft2XojfXoTDjLb5lA4KUWmxyE+akzZq
	L3lqa9rGljR2bmGx6tMT30TfUHA7vjS3K2hsIgOxPH/lQ0f2S+Cqb4t4w5E9tZZz4qX8le
	gnjpDmDj0GMG5gDFQ0SkqBFkI7O/HRw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Muchun Song
 <muchun.song@linux.dev>,  Harry Yoo <harry.yoo@oracle.com>,  Qi Zheng
 <qi.zheng@linux.dev>,  Vlastimil Babka <vbabka@suse.cz>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
In-Reply-To: <20251110232008.1352063-1-shakeel.butt@linux.dev> (Shakeel Butt's
	message of "Mon, 10 Nov 2025 15:20:04 -0800")
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
Date: Tue, 11 Nov 2025 11:01:47 -0800
Message-ID: <87pl9oqtpg.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> The memcg stats are safe against irq (and nmi) context and thus does not
> require disabling irqs. However for some stats which are also maintained
> at node level, it is using irq unsafe interface and thus requiring the
> users to still disables irqs or use interfaces which explicitly disables
> irqs. Let's move memcg code to use irq safe node level stats function
> which is already optimized for architectures with HAVE_CMPXCHG_LOCAL
> (all major ones), so there will not be any performance penalty for its
> usage.

Do you have any production data for this or it's theory-based?

In general I feel we need a benchmark focused on memcg stats:
there was a number of performance improvements and regressions in this
code over last years, so a dedicated benchmark can help with measuring
them.

Nice cleanup btw, thanks!


Return-Path: <cgroups+bounces-10414-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ED0B990BF
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 11:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692761899203
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC252D5A14;
	Wed, 24 Sep 2025 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X31usdp7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD02D592A
	for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705054; cv=none; b=g3e1i+wwAqqIMii0AHi303G5i36n9oYQxtQCTSw/BBY6vTh+4PO0dKBdPxnvJn1USogNdwGN6hC9Pd8srTRpbxGRoPkRX+dsHwdjCOYb37U7A3CG6IGH1bUQ6AvfNOYWwBeNvBe8lxmvEM+6J76K0xWyyFOdST8QmwmLB/YU8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705054; c=relaxed/simple;
	bh=wUDySOv7HlKF+HxWT2OI3uXw/DzQu4hAUfLskiKMf/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WxXenUK505oelXJ/oTUduVIlTxPvM7zl9SPGIGeyf2b2t+Q0EYuVisvvhGulGKQEJeYtjSD/MemdsKi+i2yPrglV+0/2yYoUIItHVIRJnhIaLQzcNHaQluDYtBuyjx/cFlig4OmDM9SJJ0S5sQtI7/05JzCPOoXjpOJYjU5VYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X31usdp7; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758705040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUDySOv7HlKF+HxWT2OI3uXw/DzQu4hAUfLskiKMf/0=;
	b=X31usdp78cFCydE/T23Kxzp5auuT98YsCa/7QC+DzzcjhZ9cNLbzgf3OHvBQoxaqCa1HnU
	1Kos01djZWNlz7HEv9WtbVRfkDdzNQLcPzWtVm6RQ7BrWVhQSghLLvZGXHCChG2PZ03USa
	9pHOsgKsWxY6wWXuuGVHsVZjJOt+ucU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hannes@cmpxchg.org,  hughd@google.com,  mhocko@suse.com,
  shakeel.butt@linux.dev,  muchun.song@linux.dev,  david@redhat.com,
  lorenzo.stoakes@oracle.com,  ziy@nvidia.com,  harry.yoo@oracle.com,
  baolin.wang@linux.alibaba.com,  Liam.Howlett@oracle.com,
  npache@redhat.com,  ryan.roberts@arm.com,  dev.jain@arm.com,
  baohua@kernel.org,  lance.yang@linux.dev,  akpm@linux-foundation.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  cgroups@vger.kernel.org,  Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 1/4] mm: thp: replace folio_memcg() with
 folio_memcg_charged()
In-Reply-To: <0ac716fb7fea89ada92ad544f88ca546e43d1f29.1758618527.git.zhengqi.arch@bytedance.com>
	(Qi Zheng's message of "Tue, 23 Sep 2025 17:16:22 +0800")
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
	<0ac716fb7fea89ada92ad544f88ca546e43d1f29.1758618527.git.zhengqi.arch@bytedance.com>
Date: Wed, 24 Sep 2025 09:10:07 +0000
Message-ID: <7ia4plbg6wsw.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Qi Zheng <zhengqi.arch@bytedance.com> writes:

> From: Muchun Song <songmuchun@bytedance.com>
>
> folio_memcg_charged() is intended for use when the user is unconcerned
> about the returned memcg pointer. It is more efficient than folio_memcg().
> Therefore, replace folio_memcg() with folio_memcg_charged().
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>


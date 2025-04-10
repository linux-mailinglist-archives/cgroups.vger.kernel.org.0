Return-Path: <cgroups+bounces-7462-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101D1A85055
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 01:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB60A8C571F
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 23:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345042147F6;
	Thu, 10 Apr 2025 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p0BYxoby"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE38133F6
	for <cgroups@vger.kernel.org>; Thu, 10 Apr 2025 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744329528; cv=none; b=dma6k5foN02kSXLMfE8dLQm7otEQ9wWC6kGkeagbG4pfspR4d//ZMZbdpWo0Qy5h0f+vBjiKMB6AmGyA1HlUhsg4mDYmFZtRoLmlvZyQD2+MWSoyHJiZ0qJfEfxbYglWqRBAZ+Ov2mWh7YiJE3N0xoSFjBAzeoB78+7Zvsyx4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744329528; c=relaxed/simple;
	bh=zS1yfxeRokA8cnGRHyUwOOHvMnk8CAc9VfSUbBB1V4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rM2bbC40rS7j+ce4aRVhd/plN46GnrbMtcnflY3SpaLhZhdPHaAdWeKsI6yPi0Hn5ftaQHBSnqOqB3SpjvI7CCf9sD7nFokVFmMQ1y3+zeJzE8Vk1N5MtescpWwAULCtdb8tsGZIBps+2FuCKXcbKLhWDj8VEIDyXKZNvGRjVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p0BYxoby; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744329523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zS1yfxeRokA8cnGRHyUwOOHvMnk8CAc9VfSUbBB1V4A=;
	b=p0BYxobykot/O1wR2GbeCtnrfajU9GwzxJ8f8GwbgEBhEu2j91HvknQrz3WTAEJGWGQY6g
	zi3s3n8fF5qVBdC3Rpfl5HWOFP1d7OnKNrksEfFWnqgk0uXCEgxnOQ92nThJjdQaotRnKG
	8ECyojXys5nIuJMOyEDyZaOu/QdiDEA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Muchun Song <songmuchun@bytedance.com>
Cc: hannes@cmpxchg.org,  mhocko@kernel.org,  shakeel.butt@linux.dev,
  muchun.song@linux.dev,  akpm@linux-foundation.org,
  linux-kernel@vger.kernel.org,  cgroups@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcontrol: fix swap counter leak from offline cgroup
In-Reply-To: <20250410081812.10073-1-songmuchun@bytedance.com> (Muchun Song's
	message of "Thu, 10 Apr 2025 16:18:12 +0800")
References: <20250410081812.10073-1-songmuchun@bytedance.com>
Date: Thu, 10 Apr 2025 23:58:38 +0000
Message-ID: <7ia4cydj1scx.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Muchun Song <songmuchun@bytedance.com> writes:

> The commit 73f839b6d2ed addressed an issue regarding the swap
> counter leak that occurred from an offline cgroup. However, the
> commit 89ce924f0bd4 modified the parameter from @swap_memcg to
> @memcg (presumably this alteration was introduced while resolving
> conflicts). Fix this problem by reverting this minor change.
>
> Fixes: 89ce924f0bd4 ("mm: memcontrol: move memsw charge callbacks to v1")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!


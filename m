Return-Path: <cgroups+bounces-13263-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACC3D2959C
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 01:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6954303ADD7
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 00:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FDB26E709;
	Fri, 16 Jan 2026 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AKrPb8qY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA11F63CD;
	Fri, 16 Jan 2026 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521613; cv=none; b=GLF5gtn8ZC+Ur+773nTutBamZdHbFHUjgPvSTO3Ddmdzyr6L8PvIzwdcQIVY6VjgvbUItUaZj6Om1dokFRXOE1cF/eu68ukmbgNcGubt21HvI+jpfB81olGiayaaxYTKnGFgfsF7g5xmSAA9PcMVtRU0rJ1vA7dy+nL8AzA/1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521613; c=relaxed/simple;
	bh=zld3AdtUOIHhx3f8LkbO7KV0NONlEXy9qHMcSpdYqO0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Q/0R2P52FUf6uILfFcPV4XOYvQnk0RaBPI6UWFTcnyAzd12ZDXk1PF4VndjAvmUjtQw/8mraFuDWMhg6xwF5a5SLKMBYxwjm3gvbjrdCJ8g2X465CERrZnZZESmfQuZgdFaplFGpwCxH99UVM8PuqCdviC/O7auvKU3bUaHsLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AKrPb8qY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEC7C116D0;
	Fri, 16 Jan 2026 00:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768521613;
	bh=zld3AdtUOIHhx3f8LkbO7KV0NONlEXy9qHMcSpdYqO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AKrPb8qYK/xcbXFwX1jqFte9UFIUe7ItN3F820LjpAnZcPr4OhV1l+frX+3Fmrg7T
	 M/E0SplVJYcCG28K4uWynEPDmff+4lrdO0RzdcQERONJsKRGOxxEOYrCCPOFf8WdUU
	 X430A6O+GdXvOHEnNaip3Z88ofPFmB23pnBaGf9g=
Date: Thu, 15 Jan 2026 16:00:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Bing Jiao <bingjiao@google.com>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei
 Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 muchun.song@linux.dev, roman.gushchin@linux.dev, tj@kernel.org,
 longman@redhat.com, chenridong@huaweicloud.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v9 0/2] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-Id: <20260115160011.29dca1c262ab1fb887857508@linux-foundation.org>
In-Reply-To: <20260114205305.2869796-1-bingjiao@google.com>
References: <20260114070053.2446770-1-bingjiao@google.com>
	<20260114205305.2869796-1-bingjiao@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 14 Jan 2026 20:53:01 +0000 Bing Jiao <bingjiao@google.com> wrote:

> I’m resubmitting the full refreshed patch series together this time.
> I just realized it is better to include the unmodified patches alongside
> the modified ones to ensure compatibility with upstream automated tools
> and to simplify your review process.

No probs.

[1/2] is cc:stable whereas [2/2] is not.  Ordinarily that means I must
split the series apart (they take different routes) and often discard
the [0/n].

In this case I think I'll leave things as-is, so [1/2]'s entry into the
-stable pipeline will occur a few weeks later.  I don't think the
problem is serious enough to need super-fast-tracking?  

Hopefully this approach means we'll get some Reviewed-bys ;)


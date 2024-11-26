Return-Path: <cgroups+bounces-5686-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59D09D9E08
	for <lists+cgroups@lfdr.de>; Tue, 26 Nov 2024 20:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C5F286794
	for <lists+cgroups@lfdr.de>; Tue, 26 Nov 2024 19:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD711DE8A0;
	Tue, 26 Nov 2024 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oq/8LgXz"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34E1DE880
	for <cgroups@vger.kernel.org>; Tue, 26 Nov 2024 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649368; cv=none; b=SdOTMvvb6fm5xgbhAr9ZloYBHyaedc56zJDKyUlmnYe1HZsrFz/VjiycxU6yA6NSTBNo6+r/AIflzlOImHHSZGV4bk5qOtiVykM8XZBt98dD/RHmz+RuPmrn56gCVRqyyCLUwwWqcEU0SudxqXOau4aU3GrgOLjm0rQ6715uxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649368; c=relaxed/simple;
	bh=oA/qdV6gyIyfl9AXAgDB9I+NgI2XOp2Rl5kd2AhTO+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slaKOrXvlFd/Vkov5PQX5CVUtSKdT/QeS6u7xscUNaGVwDofHJtJvq5U4go+Hoa/L7XeAaBH858pox9DlaXwNw4V+P+JcquE2uKeJJ2kKt6FDH97HHFcxOZYT5N1umjHxapw5YFsPcTGb7KCUlc+GznKd0N6DjCw2wJjHfSKcI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oq/8LgXz; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 Nov 2024 19:29:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732649360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zEUa6tKt5tK0Kb57WdB49xzZN3WpeLv/SaNRuQje//8=;
	b=Oq/8LgXzoMjfOZGiAo69b54cDx2xC/O33Xxq1O86CuJtUgIufZdOmePR93HnrRUHRdmbPW
	O1JsUBDgqxRMNuWYBpulfNrAyOJERwusIbg02U7UrDx0ktcQprdT5e4uphkNjGxdX1B3cy
	vtyMCjWyLxYfq0FYXNfpaWuxHp+8IOk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] mm: mmap_lock: optimize mmap_lock tracepoints
Message-ID: <Z0Yhivws5XSeme68@google.com>
References: <20241125171617.113892-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125171617.113892-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 25, 2024 at 09:16:17AM -0800, Shakeel Butt wrote:
> We are starting to deploy mmap_lock tracepoint monitoring across our
> fleet and the early results showed that these tracepoints are consuming
> significant amount of CPUs in kernfs_path_from_node when enabled.
> 
> It seems like the kernel is trying to resolve the cgroup path in the
> fast path of the locking code path when the tracepoints are enabled. In
> addition for some application their metrics are regressing when
> monitoring is enabled.
> 
> The cgroup path resolution can be slow and should not be done in the
> fast path. Most userspace tools, like bpftrace, provides functionality
> to get the cgroup path from cgroup id, so let's just trace the cgroup
> id and the users can use better tools to get the path in the slow path.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!


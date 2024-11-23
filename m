Return-Path: <cgroups+bounces-5670-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FD29D6B8E
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 22:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AE31618E9
	for <lists+cgroups@lfdr.de>; Sat, 23 Nov 2024 21:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE891A3047;
	Sat, 23 Nov 2024 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dxkobz0M"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017ED17C2
	for <cgroups@vger.kernel.org>; Sat, 23 Nov 2024 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732396553; cv=none; b=RuHHhAogAOU2cLHoMirIFed4gFpdXsnwV/KAz2j1GH4ptRw4kwU8Hzjes8OcfsIdItJPqwNEHS1Jar9/jIwCo9Gi4xMAgjE8ehJu3qFhpJqdTKozQX7CxYS1J4j7VJZAFO12i/gcK5wGyYsMGK5L2GwV/+JE1UJjTluMNLBQF8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732396553; c=relaxed/simple;
	bh=hZ+lIMlNIlbFR25T7VMc8NmKASzcirseMhYDuyhhqXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7/vBZs11prai7Gl9G1/vXSsqamr+8Hwdmd6hQSNwO8lNBQ2gDK8sMnuxmr6iRj18hbBvOqO3r7n+lZFLd4BleDqCi4aTSbnlRgFH9l+mtJ9F1rnLLfwovzbDRRUBJAcOamvzgyBRCBaHlfXR287gwESyFA2YzqZ4Mq3tAlgA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dxkobz0M; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 23 Nov 2024 13:15:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732396549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MXmSBrZpWl/Xy/VpB0EsgeUw0zP4+U6MJ+lql+/W8ws=;
	b=dxkobz0MvFMtfcUDntw4+WeL4boWWsnW0X5Mi1WFim5eEIZp6baQ8ldbTujGnmE0LeByQz
	7yoZWeQS71FeX5Fa0LGuW7iKce9m+tfdq/vR9GwjUAdLLxReVuTmQ3JJWvd5rZD1NkZ+Bn
	ySWDBcsR8uL1hGeWD8Z9FfyFNpkgiOY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tejun Heo <tj@kernel.org>, Michal Koutny <mkoutny@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Axel Rasmussen <axelrasmussen@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm: mmap_lock: optimize mmap_lock tracepoints
Message-ID: <a2aa5dbl2lwi3q3qzyds3lllgbcgruxjzwzwhnolg63i4swcus@lwtetk5wra44>
References: <20241123060939.169978-1-shakeel.butt@linux.dev>
 <99c6af52-942f-4262-a79d-53a9c2e8eefe@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c6af52-942f-4262-a79d-53a9c2e8eefe@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Sat, Nov 23, 2024 at 09:38:09AM +0100, Vlastimil Babka wrote:
> On 11/23/24 7:09 AM, Shakeel Butt wrote:
> > We are starting to deploy mmap_lock tracepoint monitoring across our
> > fleet and the early results showed that these tracepoints are consuming
> > significant amount of CPUs in kernfs_path_from_node when enabled.
> > 
> > It seems like the kernel is trying to resolved the cgroup path in the
> > fast path of the locking code path when the tracepoints are enabled. In
> > addition for some application their metrics are regressing when
> > monitoring is enabled.
> > 
> > The cgroup path resolution can be slow and should not be done in the
> > fast path. Most userspace tools, like bpftrace, provides functionality
> > to get the cgroup path from cgroup id, so let's just trace the cgroup
> > id and the users can use better tools to get the path in the slow path.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> AFAIU this would also remove the lockdep issue that patch [1] is solving
> with RCU conversion. It probably has other benefits on its own too, so
> just FYI. It's definitely better to avoid complex operations to gather
> tracepoint data, if avoidable.
> 
> [1] https://lore.kernel.org/all/20241121175250.EJbI7VMb@linutronix.de/
> 

Thanks for the pointer, I might add a reference to this in the commit
message in next version.


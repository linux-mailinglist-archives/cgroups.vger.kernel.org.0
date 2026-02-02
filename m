Return-Path: <cgroups+bounces-13588-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI4yLdMngGnv3QIAu9opvQ
	(envelope-from <cgroups+bounces-13588-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 05:28:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE00C828F
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 05:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EEF43009B1E
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 04:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAE62951B3;
	Mon,  2 Feb 2026 04:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WK4WO/Vx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692F628D8DA;
	Mon,  2 Feb 2026 04:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770006401; cv=none; b=McV1sb3tiz3ifSgI66aRn0uVCVNPE6ZPHlqU/pIoE6mB/MiT+WSSJtkIwRGWtbFMUmM+QEyWvCwZlOJenwMKV5+tIY+o53ALJ7tuCe3IvX5w7j0GSvF/450++qysl8xdMc28i+ruvNx2xJ13vPSKczciuPrUwptm6gTSCAl5Hbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770006401; c=relaxed/simple;
	bh=eTPUb27fYDjIBBY0IWHiR/uvgqJGSq45Ak1PRI3n4Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdq2XkJLqiva4MA/RPnEgivlqxqwcDCj2owv0Iw2Hbyqxh1XXTnIVcsXtRkuqPrLiBqRP7XNyh+6NSaJPkgSNIBbTYSvYq4IUb/f7YR12ttsaFlIRMNjHXQivt4I7xbqWTAr0/rjKu3WTZc+tz8bPGaNaF/SiTukna/cqk4V0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WK4WO/Vx; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 1 Feb 2026 20:26:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770006397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RX4DYoaFUx1Q/wII/CNEigIzDOhmkDv7YtwkWo/GjWA=;
	b=WK4WO/VxIDlhyJ7Yt7tThvk8vTVtZPlexdarCKgavf04ztFMlFdK22LNttf1+FdeZ7uO8h
	TwOYJJ4QnchiuFoX/L04ZlJXsUcv+92qRcVIUtqXiNPnEzyTVnX94MjWVnh61MOGLiOymt
	+lENuKBBYW9WdNa+dWqXd1PpTrpmSI4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <qi.zheng@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/4] memcg: use mod_node_page_state to update stats
Message-ID: <aYAmGc6lu973jRwu@linux.dev>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <20251110232008.1352063-2-shakeel.butt@linux.dev>
 <1052a452-9ba3-4da7-be47-7d27d27b3d1d@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052a452-9ba3-4da7-be47-7d27d27b3d1d@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13588-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 1BE00C828F
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 06:35:21PM +0530, Dev Jain wrote:
> 
> On 11/11/25 4:50 am, Shakeel Butt wrote:
> > The memcg stats are safe against irq (and nmi) context and thus does not
> > require disabling irqs. However some code paths for memcg stats also
> > update the node level stats and use irq unsafe interface and thus
> > require the users to disable irqs. However node level stats, on
> > architectures with HAVE_CMPXCHG_LOCAL (all major ones), has interface
> > which does not require irq disabling. Let's move memcg stats code to
> > start using that interface for node level stats.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> 
> Hello Shakeel,
> 
> We are seeing a regression in micromm/munmap benchmark with this patch, on arm64 -
> the benchmark mmmaps a lot of memory, memsets it, and measures the time taken
> to munmap. Please see below if my understanding of this patch is correct.

Thanks for the report. Are you seeing regression in just the benchmark
or some real workload as well? Also how much regression are you seeing?
I have a kernel rebot regression report [1] for this patch as well which
says 2.6% regression and thus it was on the back-burner for now. I will
take look at this again soon.

[1] https://lore.kernel.org/all/202512101408.af3876df-lkp@intel.com/



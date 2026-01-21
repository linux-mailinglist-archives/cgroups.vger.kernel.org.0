Return-Path: <cgroups+bounces-13340-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNSjOaiNcGkaYgAAu9opvQ
	(envelope-from <cgroups+bounces-13340-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 09:26:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1DF538C5
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 09:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 681F77C2AC0
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 08:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21B94779A0;
	Wed, 21 Jan 2026 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DMquiX5p"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A13477E55
	for <cgroups@vger.kernel.org>; Wed, 21 Jan 2026 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983632; cv=none; b=VKFCpnleIvwZFLxOaNcsTxbJu1xEdtg6l/uZJSbCmX32XpyH+mGCK1P51Kfj9munlHFUkC0n1rNqFTKn6J6KZobCESUpwQu0SBAjGtWCsfyqfsOiwg+HchJmDQXXQgRn8gS5uvwTy6zCY11IB3p6hrlgyDTxQvuQ0FVXunoDw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983632; c=relaxed/simple;
	bh=roY9SJu7tQziPZER9V+z21m8fFRs0wQ9DBTdX8sJLFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVmZDkbLqxUzZMynHYWUhfWPHvWvH7jpyV8omo4p6kiepCW3O8Cyh+IFSkV0xQRLDOGyoMLRg1HH2ptVrIOT5o2meUQpf9lp+c7geD3iZ9Y7rk/Q4TscFEVBZP+Kwy0jMqYs5q6t4com1c8SJ6x+3kOjaFd1yvji5GhtQrCWbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DMquiX5p; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Jan 2026 00:20:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768983618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/C7RlKb6kG1iTpXvW7JQqVlIIZuudSPPRI9mtHGK9MM=;
	b=DMquiX5pLi5Jxf8xMEaJv17fESPSsBAXhtfXYVWupL0N0c37DPf2khFhe7aWvvq8A7U67E
	lcUMcLLxBIPuCJAtrwMkrIMlObW1IVdm/NdIDjjr4QGSLdgJ/37hkcB4EDyWZPnbDvZKH8
	0z/DybNcVBxCL0pPtHcCSynGH3HW9G0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, hannes@cmpxchg.org, 
	hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 28/30 fix 1/2] mm: memcontrol: fix
 lruvec_stats->state_local reparenting
Message-ID: <aXCIsLQMSdQ2GNc4@linux.dev>
References: <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
 <e5afd1b5ae95d70f82433b9b4e13201342d16707.1768473427.git.zhengqi.arch@bytedance.com>
 <ifcth3hxyrwmmeo3nejettdtkw2ndxdjbylszmhq3vohuhsncl@k23pew6gywko>
 <5a18658e-2076-4cbf-bc53-5b6e99c1035f@linux.dev>
 <A13923AA-8200-4863-8080-EC4B254BA3AA@linux.dev>
 <moupi2ch2cpuyrurthk66igh275ks62pltjk2zfngxozj52oxs@64lxvcgh3ays>
 <37734a82-1544-4015-b4dc-30583441a7ba@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37734a82-1544-4015-b4dc-30583441a7ba@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13340-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 8A1DF538C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 11:43:50AM +0800, Qi Zheng wrote:
> 
> 
> On 1/21/26 2:47 AM, Shakeel Butt wrote:
> > On Tue, Jan 20, 2026 at 03:19:00PM +0800, Muchun Song wrote:
> > > 
> > > 
> > > > > No reparenting local stats for v2.
> > > > 
> > > > It seems that lruvec_stats->state_local (non-hierarchical) needs to be
> > > > relocated in both v1 and v2.
> > > 
> > > Here we might need to elaborate a bit. Specifically, in the function
> > > `count_shadow_nodes`, the use of `lruvec_page_state_local` to obtain
> > > LRU and SLAB pages seems to also require these logics to work correctly.
> > > For SLAB, it appears that the statistics here have already been
> > > problematic for a while since SLAB pages have been reparented, right?
> > > 
> > 
> > Thanks a lot, now it is clear and yes it seems like SLAB is problematic
> > but now I am wondering if it is really worth fixing. For LRU pages, how
> > about using lruvec_lru_size() defined in vmscan.c. That would at least
> > keep count_shadow_nodes() working irrespective of LRU reparenting.
> 
> Do you mean calling lruvec_lru_size() in count_shadow_nodes()?

Yes but I am mainly brainstorming. We can keep the reparenting local
stats for both v1 and v2 for now as it is not a performance critical
path. I am more worried about the stats update path where upward
traversal of memcg for CSS_DYING can be costly and I don't want that in
v2.

> But
> numa_stat interface also reads lruvec_stats->state and make it visible
> to the user.
> 

Not sure how this is relevant.


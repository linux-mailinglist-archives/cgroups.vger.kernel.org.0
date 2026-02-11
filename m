Return-Path: <cgroups+bounces-13850-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD+dGoXPi2kbbgAAu9opvQ
	(envelope-from <cgroups+bounces-13850-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 01:38:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE582120572
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 01:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B86433047BD6
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 00:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E7A1F1518;
	Wed, 11 Feb 2026 00:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nGjpWQG2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1AB1FE451
	for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770770306; cv=none; b=ExD0BgjMOiqc+0MO/B1eLUClflcIe44Fa6UlfKxD5jmRrkGp3VDO7GfDexHrawwKvzv8hUF0Vp6n7eYpPM4AK3dLJoyMqY7yl1y9CeEmIkax6n0NFZKRQR7z40LjivV7md4P0GOI+4lTMj6CPr9Kfb1w0EDv4BVjcI0GIykULbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770770306; c=relaxed/simple;
	bh=4K1bsS9FsrnaV4lN25Pd6F9YjUSRT5r+WMaVyQGDrh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1SVJ+YhWdPCZA2JPt8CumLY+OFW809gUgHmyTS/mNgmnyT2BItrKlss4Fi4BEPUV6wp9p9u0iyIRImvco1cUQsFcz4mvGE5WaRDYZIhEFDLE3E65SCPj2h1z9fZsspPRLes7ilozxbYoh1/fUdksmTUFEIl+PPsAN/guD5wLS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nGjpWQG2; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Feb 2026 16:38:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770770293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FbwdsItdNCVn/rOvfiUbXy89AP6MsD7J95YTJtH5IKY=;
	b=nGjpWQG2/c7L7wdCTrpV+AhW2KBz3M5rW7e7GCv58fHxE6WzUsIwwHKk5JLqeXsX5+05qN
	qoXZPTC9S2q3xvSGv8Bu+GVQFwoe8amFtgpZN4LDKfkYllOahsE7ivJOZ96n/wSlA5U+M1
	9wn+kGto9IbAxLcmGeUN3kZ2zd/EH/g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, bhe@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 29/31] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-ID: <aYvO2IaYnyWYDHTX@linux.dev>
References: <cover.1770279888.git.zhengqi.arch@bytedance.com>
 <3ca234c643ecb484f17aa88187e0bce8949bdb6b.1770279888.git.zhengqi.arch@bytedance.com>
 <aYabQii_-9EVdgub@linux.dev>
 <0673b72c-8d7c-4bfb-a8b2-da5ae5bb5f00@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0673b72c-8d7c-4bfb-a8b2-da5ae5bb5f00@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13850-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE582120572
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 02:47:51PM +0800, Qi Zheng wrote:
> 
> 
> > 
> > Add the usage of these start and end functions in mod_memcg_state() and
> > mod_memcg_lruvec_state() in this patch.
> 
> Using these two function will change the behavior of mod_memcg_state()
> and mod_memcg_lruvec_state(), but LRU folios has not yet been
> reparented.
> 
> To ensure the patch itself is error-free, I chose to place the usage of
> these two function in patch #30.

Makes sense.

I think we are good with respect to this patch series (next version), it
will miss 7.0 but I think that is fine, 7.1 is not too far.

Thanks for pushing this through.


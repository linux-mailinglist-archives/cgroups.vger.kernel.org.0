Return-Path: <cgroups+bounces-17528-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hnH5NkVXS2rKPgEAu9opvQ
	(envelope-from <cgroups+bounces-17528-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 09:20:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 076D270D738
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 09:20:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=qO+jFkbx;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17528-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17528-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCC2534DF511
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 06:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D403DEFFE;
	Mon,  6 Jul 2026 06:30:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8C3C4B95
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 06:29:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319401; cv=none; b=BUssY1kuBnhBMRAoI0gafdPSgU/RQZpfG5yuAhbGSq6YEl69pxdPf03kzqiS+7xwFUfINSKm4zZecfhEPh/w2Yiyatyvqt9+1yTgRNomiRZCIEBlxOYEZQ6JtPLZAMs9JHw/SU+ZBB3WFU73yGv1YbjfVnNCn93qafYGTIxEwuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319401; c=relaxed/simple;
	bh=Ylxt5w21YIIbpNtItpVBprDhb2T1dKI9eJzRxGfJ0cA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PQR1e85HRB9N9bc+63Zte4axaPnWlh3QyXAAqVP7t8EwSocph86mirRbQ+IVUqoPchHN3O4I3j6HcF550seFmNeO03S6UpXPHsMTL+O9fViE6IZyR80NlvCc9hJzuijAeW7cIZ2HWLgyWeV6anPd9rFNXi9QumhQwyrp7oXslB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qO+jFkbx; arc=none smtp.client-ip=95.215.58.179
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783319389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XQkYBnHZWsJpiyDF1oAd+8WYbBHmcQTchDtP++ibmA=;
	b=qO+jFkbxMfLVNFyOyT2C9xJgciesprCRI0aNzSsDeA8+DQP2vHUY0p5odBTMJos6gjXI9V
	HrDYMBdGGGXpwhGk1avVIz1/LnmEqiz9JlOg58JJpRgMtu7X/y9H8b/4BcPnJuh2HU4AAi
	RaL1ZpF2wvW5pAmsGODfbpAWQzFSVG0=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2] mm: memcg: reset zswap settings in css_reset
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260702024827.353185-1-jiayuan.chen@linux.dev>
Date: Mon, 6 Jul 2026 14:28:54 +0800
Cc: linux-mm@kvack.org,
 Jiayuan Chen <jiayuan.chen@shopee.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <152D4FB6-5540-476E-84AE-AF463929F2B2@linux.dev>
References: <20260702024827.353185-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17528-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:jiayuan.chen@shopee.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jiayuan.chen@linux.dev,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[muchun.song@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 076D270D738



> On Jul 2, 2026, at 10:48, Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> 
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> mem_cgroup_css_reset() is called when the memory controller is disabled
> on a cgroup but the memcg cannot be destroyed because it is pinned by a
> subsystem dependency -- for example, the io controller declares
> .depends_on = 1 << memory_cgrp_id, so memory remains in the cgroup_ss_mask
> and the css is hidden rather than killed.
> 
> The purpose of css_reset is to revert the memcg to its vanilla state so
> that no policies are applied and the css can be safely made visible again
> later.  Currently, all page counters (memory.max, swap.max, kmem.max,
> tcpmem.max) and other limits (soft_limit, memory.high, swap.high) are
> reset to their defaults, but zswap_max and zswap_writeback are not.
> 
> These fields are initialized in css_alloc (zswap_max = PAGE_COUNTER_MAX,
> zswap_writeback inherited from parent) but were missing from css_reset.
> As a result, stale zswap policies remain in effect after css_reset: the
> zswap charge path (obj_cgroup_may_zswap) continues to enforce the old
> zswap_max limit, and the writeback path continues to honor the old
> zswap_writeback setting, even though the memory controller has been
> "disabled" on this cgroup.
> 
> Reset zswap_max to PAGE_COUNTER_MAX and zswap_writeback to true, matching
> their defaults in css_alloc.
> 
> Test:
> echo "+memory +io" > /sys/fs/cgroup/cgroup.subtree_control
> 
> mkdir /sys/fs/cgroup/test
> mkdir /sys/fs/cgroup/test/child
> 
> echo "+memory +io" > /sys/fs/cgroup/test/cgroup.subtree_control
> echo 10000 > /sys/fs/cgroup/test/child/memory.zswap.max
> 
> # child/memory.swap.max and child/memory.zswam.max disappear
> echo "-memory" > /sys/fs/cgroup/test/cgroup.subtree_control
> 
> # re-enable memory control
> echo "+memory" > /sys/fs/cgroup/test/cgroup.subtree_control
> 
> # before this patch
> cat /sys/fs/cgroup/test/child/memory.zswap.max
>    8192
> 
> # after this patch, same as memory.swap.max
> cat /sys/fs/cgroup/test/child/memory.zswap.max
>    max
> 
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.



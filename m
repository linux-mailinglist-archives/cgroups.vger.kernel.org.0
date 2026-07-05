Return-Path: <cgroups+bounces-17503-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jJE5DWvHSmoPHgEAu9opvQ
	(envelope-from <cgroups+bounces-17503-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 05 Jul 2026 23:06:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCAC70B705
	for <lists+cgroups@lfdr.de>; Sun, 05 Jul 2026 23:06:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=gaEbpmQB;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17503-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17503-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EA1030146A8
	for <lists+cgroups@lfdr.de>; Sun,  5 Jul 2026 21:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C36371D11;
	Sun,  5 Jul 2026 21:01:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DC810785;
	Sun,  5 Jul 2026 21:01:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285295; cv=none; b=VGzXeGoKyhG+9riOkFp1uEVitP1jOr0bKbyMORmjOFVbKyeudrk3XGfevuul3KWy2St8hHzG/hkNausCH1wPawYaavBrbh3LVyJMfOwZLyvi8/kZqX+c1FdYNzJi0QCa2I/kN9nTA3wtvekLB7UIQZqFP1pDHm5dTMOghZV7fF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285295; c=relaxed/simple;
	bh=5YPz26udgKF64J7Re/gASAkHwEqz5eu478BUDsn/R+4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lzG0suOHOyec6OBohb/Ff87Z/fA45i7GDOMZbPNdiFlpfidzXkPKMrvqFiKBlgxHRvqigQnXbfNHttcc/hjSn+FAnxPznKIQOxnvSiFd2oTNHiXROzSbcYnNfavQULJXh+S58n1XAjDKQ4uBT49k1kEDWwA6vzQav5qipe8t6co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gaEbpmQB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DDD1F000E9;
	Sun,  5 Jul 2026 21:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783285294;
	bh=BfKe0kCK3HJQeJ+5QEWh3IBAQ7s7PrrKQ5wszb4ExVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gaEbpmQBnJyIhLLQBSPXy7hGKEQJ0EcKljhlQsHrcFmRLuH6JXUBUirqyggrp0H/n
	 SDMcpr7ofWrghjqkrYSjWGCnjNvSfKsDOrlsLvy5a9sH6+Kgdgapx4Q1glsgai1UW6
	 TK6l3/6QSFncABTi/rcejYOvG4Vz9cr4bmfHBu5U=
Date: Sun, 5 Jul 2026 14:01:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman
 Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, Nhat Pham
 <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>
Subject: Re: [PATCH v2] mm: memcg: reset zswap settings in css_reset
Message-Id: <20260705140133.e0534a0be91346860fd9056f@linux-foundation.org>
In-Reply-To: <20260702024827.353185-1-jiayuan.chen@linux.dev>
References: <20260702024827.353185-1-jiayuan.chen@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:linux-mm@kvack.org,m:jiayuan.chen@shopee.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yosry@kernel.org,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17503-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,shopee.com,cmpxchg.org,kernel.org,linux.dev,vger.kernel.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,linux-foundation.org:from_mime,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DCAC70B705

On Thu,  2 Jul 2026 10:48:25 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

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
> 	echo "+memory +io" > /sys/fs/cgroup/cgroup.subtree_control
> 
> 	mkdir /sys/fs/cgroup/test
> 	mkdir /sys/fs/cgroup/test/child
> 
> 	echo "+memory +io" > /sys/fs/cgroup/test/cgroup.subtree_control
> 	echo 10000 > /sys/fs/cgroup/test/child/memory.zswap.max
> 
> 	# child/memory.swap.max and child/memory.zswam.max disappear
> 	echo "-memory" > /sys/fs/cgroup/test/cgroup.subtree_control
> 
> 	# re-enable memory control
> 	echo "+memory" > /sys/fs/cgroup/test/cgroup.subtree_control
> 
> 	# before this patch
> 	cat /sys/fs/cgroup/test/child/memory.zswap.max
> 	    8192
> 
> 	# after this patch, same as memory.swap.max
> 	cat /sys/fs/cgroup/test/child/memory.zswap.max
> 	    max

Thanks.

You convinced me, so I'll queue this for testing.  

The problem is old and doesn't sound serious, so I'll target 7.3-rc1,
no cc:stable.  If people disagree, please speak up.

AI review suggest that memcg->oom_group is missing similar treatment:
	https://sashiko.dev/#/patchset/20260702024827.353185-1-jiayuan.chen@linux.dev



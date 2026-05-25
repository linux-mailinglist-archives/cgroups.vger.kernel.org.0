Return-Path: <cgroups+bounces-16260-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGwIF+2hFGpdPAcAu9opvQ
	(envelope-from <cgroups+bounces-16260-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:24:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DB35CE02B
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBC723014C68
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 19:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3D037CD55;
	Mon, 25 May 2026 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZSOLjv27"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8AF290DBB;
	Mon, 25 May 2026 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779737066; cv=none; b=Y5YLLlPu+M/hOirBBhDfkpSCGrYJ9UdAGpdpzD1olilAz6vKqAsAvWLSJSBy0+l2qra9nJ7utfBsAShqFoGkJ4pVMXY4m1D8+4usVnc+zUBN+nL+GB8sMFG6gp9cp2ZVwAZbSFdA8GJbBBFujyuWQLCtctHJjeCDvz9EfnB4Yq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779737066; c=relaxed/simple;
	bh=1G6+ETjl2Cro0iGpi5o2KcowAXRc5aBuFpnCFrQvRP8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nej4YvAnVsTd1UaoOamYM9x7O4GBXdUMpR+8Do1HQKQsSUy4BPvCGk+FGesKXBqGF20rddApetNvrvhO6udnmsh+ZRCgp2SR9CGjMTjETnN1gNFvjNgBVRNDC2uQ6JUCxM2FThRoNifO4y1RY2rwnCEBbIoblGOrgugsrm1Z24s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZSOLjv27; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BFA1F000E9;
	Mon, 25 May 2026 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779737064;
	bh=TKlA8hHoa2n8yz5CbnFJQhuo/fhrP2H+HP0o5NvJ06o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZSOLjv27xFVHWtdplcli0bikszi0EUeOxKRdE571PnbtV9XARQw9qYmlFe7KL5bC2
	 BUMtvdE9gNFsrYp6BbrufSWmyVk0KyNvCM6yIj7EqmjW1n8enj+GCpqrwhCvgBovSb
	 tp+n3yQ8qWwvRW/hG5UskkdhuIcF9u3q7Z29rKrU=
Date: Mon, 25 May 2026 12:24:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@kernel.org, yosry@kernel.org, mkoutny@suse.com, nphamcs@gmail.com,
 chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH v2 0/4] mm/zswap: Implement per-cgroup proactive
 writeback
Message-Id: <20260525122424.3b2818f06832d9d55da8d69b@linux-foundation.org>
In-Reply-To: <20260525122242.36127-1-jiahao.kernel@gmail.com>
References: <20260525122242.36127-1-jiahao.kernel@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16260-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	NEURAL_HAM(-0.00)[-0.864];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: C7DB35CE02B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 20:22:38 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:

> Zswap currently writes back pages to backing swap reactively, triggered
> either by the shrinker or by the pool reaching its size limit. Although
> proactive memory reclaim can automatically write back a portion of zswap
> pages via the shrinker, it cannot explicitly control the amount of
> writeback for a specific memory cgroup. Moreover, proactive memory reclaim
> may not always be triggered during a steady state.
> 
> In certain scenarios, it is desirable to trigger writeback in advance to
> free up memory. For example, users may want to prepare for an upcoming
> memory-intensive workload by flushing cold memory to the backing storage
> when the system is relatively idle.
> 
> This patch series introduces a "zswap_writeback_only" key to memory.reclaim
> cgroup interface, allowing users to proactively write back cold compressed
> pages from zswap to the backing swap device. When specified, this key
> bypasses standard memory reclaim and exclusively performs proactive zswap
> writeback up to the requested budget. If omitted, the default reclaim
> behavior remains unchanged.

Thanks.  AI review found a few things to complain about, one of them
described as "preexisting".



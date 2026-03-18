Return-Path: <cgroups+bounces-14906-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEIpACo1u2mTgwIAu9opvQ
	(envelope-from <cgroups+bounces-14906-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 00:28:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB22C3D4D
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 00:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25F5B3024456
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AC71A682E;
	Wed, 18 Mar 2026 23:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tOXpz2X+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC4C1F1534
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876518; cv=none; b=Wg/WRMXAGk4lNyP4SdWs7Kqb6Q9ZC9kHprX0F+H2BFvLzhI1sDC6EkiCmdFrOTv7yKu+zztGfqdUgVX7oy8cUStHqq4oyMztQtWySQq/zVwUEmUuURWUJEX/rqOcN3OUlOhiafvRNy6rS4CoXCYpBhg5dqyW6FGrVjcpvc54Qoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876518; c=relaxed/simple;
	bh=q3Ko5dheHE0hL5WdgqpM8oRno6jJk0HmjxA69twDnHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUCdLTFwqOS/sAYO0P5rgOgKldypTqn6GTzMwjHRQdMQLFO6VtXfThDB/F7QZloe7LrefQ9Cp+EKEGo0qdXDrY/rIblRZIbOg4/VrDfsKWxyqHi1/uw464FsZvHwTPtCTxIZGmvL3QvxiEzmJELVNSzhwxwJdkPPP9uRuQsOE7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tOXpz2X+; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 18 Mar 2026 16:28:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773876505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Js6oHi8egyhsbSgRpIpQSUvyw4AU4dc1dagQu73NTIg=;
	b=tOXpz2X+yd20tixpcBzWD7GN28MkeuHwjquOwHJs8Jjm8LdIB/MIZuZFGQoUkREgGLLjcm
	JMXPJ5WtjGAQ7fXBpDPUtfSWUyRxjsSanh8CtuxHpZP4+95zv2yL4NMWgjOl/wy8nwMb0s
	8fLFKx0rj1eSQOHY9kJkK7oUkpzDL6Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Bing Jiao <bingjiao@google.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org, 
	bhe@redhat.com, cgroups@vger.kernel.org, chrisl@kernel.org, david@kernel.org, 
	hannes@cmpxchg.org, joshua.hahnjy@gmail.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, mhocko@kernel.org, 
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com, roman.gushchin@linux.dev, 
	shikemeng@huaweicloud.com, weixugc@google.com, yosry@kernel.org, youngjun.park@lge.com, 
	yuanchu@google.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v3] mm/memcontrol: fix reclaim_options leak in
 try_charge_memcg()
Message-ID: <abs03hzUF4rx-RdI@linux.dev>
References: <20260318215629.2849052-1-bingjiao@google.com>
 <20260318221957.2979346-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318221957.2979346-1-bingjiao@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14906-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,kernel.org,redhat.com,vger.kernel.org,cmpxchg.org,gmail.com,tencent.com,kvack.org,linux.dev,huaweicloud.com,lge.com,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.901];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 56BB22C3D4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:19:46PM +0000, Bing Jiao wrote:
> In try_charge_memcg(), the 'reclaim_options' variable is initialized
> once at the start of the function. However, the function contains a
> retry loop. If reclaim_options were modified during an iteration
> (e.g., by encountering a memsw limit), the modified state would
> persist into subsequent retries.
> 
> This leads to incorrect reclaim behavior. Specifically,
> MEMCG_RECLAIM_MAY_SWAP is cleared when the combined memcg->memsw limit
> is reached. After reclaimation attemps, a subsequent retry may
> successfully charge memcg->memsw but fail on the memcg->memory charge.
> In this case, swapping should be permitted, but the carried-over state
> prevents it.
> 
> Fix by moving the initialization of 'reclaim_options' inside the
> retry loop, ensuring a clean state for every reclaim attempt.
> 
> Fixes: 6539cc053869 ("mm: memcontrol: fold mem_cgroup_do_charge()")
> Signed-off-by: Bing Jiao <bingjiao@google.com>
> Reviewed-by: Yosry Ahmed <yosry@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


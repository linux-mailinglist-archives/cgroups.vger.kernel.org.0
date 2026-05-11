Return-Path: <cgroups+bounces-15801-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GyEC1BcAmosrgEAu9opvQ
	(envelope-from <cgroups+bounces-15801-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 00:46:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6013517119
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 00:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C08DA301BF7A
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0265C28D8DA;
	Mon, 11 May 2026 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2laXtpN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729038332B;
	Mon, 11 May 2026 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778539591; cv=none; b=t/YgP8hlMVzsWNGtWHi8LS/mkteFiCQ5ZtfKDMkpwzv79hK0RmOOAMfbl09U9ETX0oA8JSbdTw6onL8P4XEHLsJsTt19nH9oWz///dsMV0ejcriCUjnaihbuP8VBRmRcEzftT1JaZHP3e1hxYGUvjVdql2RNwFRoMGpVgn4OPYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778539591; c=relaxed/simple;
	bh=ZSi/5KocwBQnf1OnFPbhDuhQNcsMBXqvZzwUmu60IHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOaYvgRwPymPJAySQE/gYnRlbFkN92BzF2ZOuKf9tGVAkZN72TlbFatbBIPfOe39vxjmICnkoZJz8VgcHPxif6u/gf0BU6a2mtlJUPlf+vDHs7M40zi17bcDphwYwnanwHMcey623oG6owtbKqCD+FTkDAQ5qNbVNOwZlIyIgDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2laXtpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BF2C2BCB0;
	Mon, 11 May 2026 22:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778539591;
	bh=ZSi/5KocwBQnf1OnFPbhDuhQNcsMBXqvZzwUmu60IHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r2laXtpN2/+dlTE6cZ37R2GPzqKnLW8SO4fJywCOcZ4LZ5qaLvahducW4aXC4jzKj
	 rH0SCuEV4+ishUl4E7JlREPWZwH1OESXTQHYQgv96VFzohw+PMXYim3HIVD0xD4E9G
	 Wg8U2HzDDgVXd0dUyIX/6Gb01qDzstIBfHQ5UevZcl/DdS+q6wXoTBLzGXhRn5+H45
	 hiRWlsNW2nwB8kaXTlA2X4CiklVSUZZpopI102dNT+xxRAcJQbCZIkUCWSCTPm5Mi/
	 kdGFr2gKO+Q3YdQq/iLMXtJi7pTISjEV6+wXxcf6+7GoMXcB8XRmSM5Ddx8+V8/k4b
	 ukccLcDtgUgUA==
Date: Mon, 11 May 2026 22:46:28 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, tglx@kernel.org, 
	vbabka@suse.cz, weixugc@google.com, ying.huang@linux.alibaba.com, 
	yosry.ahmed@linux.dev, yuanchu@google.com, zhengqi.arch@bytedance.com, ziy@nvidia.com, 
	kernel-team@meta.com, riel@surriel.com, haowenchao22@gmail.com
Subject: Re: [PATCH v6 01/22] mm/swap: decouple swap cache from physical swap
 infrastructure
Message-ID: <agJcCZuLqWwU_sSR@google.com>
References: <20260505153854.1612033-1-nphamcs@gmail.com>
 <20260505153854.1612033-2-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505153854.1612033-2-nphamcs@gmail.com>
X-Rspamd-Queue-Id: C6013517119
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15801-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 08:38:30AM -0700, Nhat Pham wrote:
> When we virtualize the swap space, we will manage swap cache at the
> virtual swap layer. To prepare for this, decouple swap cache from
> physical swap infrastructure.
> 
> We will also remove all the swap cache related helpers of swap table. We
> will keep the rest of the swap table infrastructure, which will be
> repurposed to serve as the rmap (physical -> virtual swap mapping)
> later.

I didn't look through the entire series, but let me ask the same
high-level question I asked before. Instead of moving things out of the
swap table, why not reuse the swap table as the representation of the
virtual swap space? Seems like most/all metadata is already moved there
in a nice concise format.

> 
> Note that with this patch, we will move to a single global lock to
> synchronize swap cache accesses. This is temporarily, as the swap cache
> will be re-partitioned in to (virtual) swap clusters once we move the
> swap cache to the soon-to-be-introduced virtual swap layer.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>


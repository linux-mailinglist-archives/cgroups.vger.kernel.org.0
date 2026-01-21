Return-Path: <cgroups+bounces-13353-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBK3D/ZRcWkXCwAAu9opvQ
	(envelope-from <cgroups+bounces-13353-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 23:23:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF7C5EBDD
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 23:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A7688610D3
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 22:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C2543D4E6;
	Wed, 21 Jan 2026 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bRcPWOGZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3019346E51
	for <cgroups@vger.kernel.org>; Wed, 21 Jan 2026 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033994; cv=none; b=l33a7VEWoAb5StQsuvvnwnRq9+HwzJB7JeDlUr4jgXUTJOBj0Ebx8+he+wk0CqEy1vAjYlmllV+MarMTgjm7ob9/+Dhb4kyNGFLh7a9DRC2aLxBtbok+M9WAgVKwiXjal7BLNLR1Qi511BedGNJQ4PRQgGLnbzE5+3OZ93XrRxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033994; c=relaxed/simple;
	bh=yb3EVg95+PjCTvf2Xtv6yyaE4fFqLPPjH+MGY6BGmeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oiwjq/gHS5KURwn0K+BgLxn+6A2RTmiUaMhl+HUlGtvuIMmMhvL0L34PtVt6Ga2BI6pz7BdoYF7T7URswD6GBpx8OwbBshaAmApBAXqaoWW5DKYN4iGQKh+TBLJnsvuGD5xh1YpwjO04joqUX3qEAWQsGMUyEaC/15qZusan3p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bRcPWOGZ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Jan 2026 14:19:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769033989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HoQi6KkVwO2LhgzMpx+nRVqZde/RMh0LYhGYMNHF+wI=;
	b=bRcPWOGZvCAF46Vb6d+TQK7NJXXCA1nyBDuGiR30fw6T2n2RgwTpzNZsEoy7Sw8d7wFm6H
	dFr++EqcJGqK4eMkbiF/b08+spW4WaOIL49mAPk8Xb9i4ovQiwLgdCvZbi5lkyrSgh6UW+
	dV28mKXR+f8sdVTOAWqWhdjoPIBVXz8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] mm/lru_gen: add memory.lru_gen interface for
 cgroup v2
Message-ID: <aXFPhnOn4oGllq_Q@linux.dev>
References: <20260121123955.84806-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121123955.84806-1-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13353-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: DAF7C5EBDD
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 08:39:46PM +0800, Jiayuan Chen wrote:
> This patchset adds a memory.lru_gen interface to cgroup v2, allowing users
> to interact with MGLRU directly on a specific cgroup without needing to
> know the internal memcg_id.

Unfortunetely we don't want to expose reclaim implementation specific
interface to a cgroup. 

> 
> Motivation
> ==========
> Currently, the only way to perform aging or eviction on a specific memcg
> is through the debugfs interface (/sys/kernel/debug/lru_gen), which
> requires the memcg_id. However, there's no straightforward way to get the
> memcg_id for a given cgroup path. This makes it difficult for users to
> leverage MGLRU's proactive reclaim capabilities on specific cgroups.

From the next kernel version, this memcg_id will be inode number of the
cgroup for this interface. So, a simple 'ls -id cgroup_path' would  be
sufficient for your use-case.

The relevant series [1] is in mm-tree at the moment and if you want, you
can backport it to your kernels.

[1] https://lkml.kernel.org/r/20251225232116.294540-1-shakeel.butt@linux.dev


Return-Path: <cgroups+bounces-13553-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKmxKVBAfWmoRAIAu9opvQ
	(envelope-from <cgroups+bounces-13553-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 00:35:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D72D4BF65D
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 00:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 799BE300723C
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 23:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0707238A29B;
	Fri, 30 Jan 2026 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X1Dza28U"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20A389473
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769816137; cv=none; b=sQsc7XjvtxI1YOfLOGg+nsGXeFkNoxz7WZFKA8gY748NDB0urkoej+DGgb+s69GtRz1So15sLjd1Nyj5JNQsBq3lKKPAQiwsBAyQ3zjaDv65T3g88MAVY6wBdA1mGVfiUT9s8W2Wb36TZHngdKkk6BwVK1dL/jnAk6WZiswj9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769816137; c=relaxed/simple;
	bh=0XsmNB/cJEEJOV5ekDEBb6y6xwpl6vjPQ8VpLUrCSbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIoz7VjrJGcx1OF/dLTJOiH2FfI296D4RGTQKuM2vFv4hCUwtlKyuM6HGGrPnvYCfMXEGtoeKKtnuiMjYgbj1mPzhzZqOqkIEFXx5FZIVkRDcPHui/R8dkgSgu/FkS6OZndypr6yHUYuxBJ1+kSp+GteOqtUi1dbXNmZuQvpe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X1Dza28U; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 30 Jan 2026 15:35:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769816133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gn7Q0rUz55te6YHyK/yjpPJr74GIFvZD19IJz+ORIro=;
	b=X1Dza28UzfqXP3kwVJyhdYf7rx3FSQwEP5EJ+43zoCMDzSJ1HCpq+x7n5srwyelv8lfCto
	ntgFhpg7JnzNF1DVpw0iGJdTat+m796ZdymJ8gjZE87xPHnv9d//tiyBdqYpRoARez2MHt
	l0EhKVp6CM1XGbRezlroUnePeH13fM8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Bing Jiao <bingjiao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, tj@kernel.org, longman@redhat.com, chenridong@huaweicloud.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v9 0/2] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-ID: <aXlY04m0FuX-9LRE@linux.dev>
References: <20260114070053.2446770-1-bingjiao@google.com>
 <20260114205305.2869796-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114205305.2869796-1-bingjiao@google.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13553-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,suse.cz,google.com,suse.com,cmpxchg.org,bytedance.com,gourry.net,gmail.com,linux.dev,redhat.com,huaweicloud.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: D72D4BF65D
X-Rspamd-Action: no action

Hi Bing,

Please don't reply (i.e. use In-Reply-To) to older revision of your
series. Send each revision independently.

On Wed, Jan 14, 2026 at 08:53:01PM +0000, Bing Jiao wrote:
> This patch series addresses two issues in demote_folio_list(),
> can_demote(), and next_demotion_node() in reclaim/demotion.
> 
> 1. demote_folio_list() and can_demote() do not correctly check demotion
>    target against cpuset.mems_effective, which will cause (a) pages are
>    demoted

pages to be demoted

> to not-allowed nodes and (b) pages are failed to demote

page fail to demote

> even
>    if the system still have allowed demotion nodes.
> 
>    Patch 1 fixes this bug by update 

updating

> cpuset_node_allowed() and
>    mem_cgroup_node_allowed() to return effective_mems, allowing directly
>    logic-and operation against demotion targets.
> 
> 2. next_demotion_node() returns a preferred demotion target, but it does

does or does not?

>    check the node against allowed nodes.
> 
>    Patch 2 ensures that next_demotion_node() filters against the allowed
>    node mask and selects the closest demotion target to the source node.
> 


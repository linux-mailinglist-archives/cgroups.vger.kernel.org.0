Return-Path: <cgroups+bounces-16111-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF5YKHxODWoNvwUAu9opvQ
	(envelope-from <cgroups+bounces-16111-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 08:02:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B0E587FAC
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 08:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2935E301348F
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 06:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869DD2E974D;
	Wed, 20 May 2026 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC03oqID"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1AB343886;
	Wed, 20 May 2026 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779256889; cv=none; b=Yi+eOc4yVHqgXIov5n6EdJ4bO1PxktPwggVjEZaIvHRaiVqAq5phiqVxMpOVcq2czqnuRfQI+IB/LoLnvDZ8Op1u6C1PTltXWujjYWRWiL19sp5PbGwvVLb4INwuYsUEVKZe/BDSxyRKG29gJCFN1+xgcXRLwYX/rWwxQOC14Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779256889; c=relaxed/simple;
	bh=M5foHdb6UyldcI/TMUxqynUvhWzgDhdlRXyTGuDw4/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDVmKokTuoZRkkhTJ11j2pwZdXNzq1iUaV6N88yytIUMN7JGqGoGfKHC3LdkWekt0MzMWFVr6YNn10LxhSLCWtR1w6vAAv7MNZvCk31wvd1YG0k8Gn3ndOe5y0LMThXtMNn87yg4UT4is2bOs6A3QkZaL+9YKAioM2Ly0BWpaXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC03oqID; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD1D1F000E9;
	Wed, 20 May 2026 06:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779256888;
	bh=XUuf3KluThhkKceNz3An+1YHqbDqW0wLJBxqsVqxkwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TC03oqIDpmgQKcVjw9nJ0KNPdkGUZuF7PCpEoA+pJfAToPjhihGccVLPtvrebIZbH
	 q61MwlIfLoTojg6kBoO1Y9KD8qpDHC/I3K6mMlo7bzwPliW+QDgrn4tmSnyyffr3Qk
	 GOTGOaZ+RdS0NOhXhoUaT681o+mAUSZUWISGAMN+GsYzAcaBN+PBd/deu/ItbHXNB1
	 GYdF8v4jC9wB8nkjjzc7AeGevyKJsQBaPrGET0L14S/ae98BQZlVBr5cEH1Gcp4MtJ
	 ZJYfPYWE0ZTKsC2DYcdAG7T+ZK4uovuYIkaNpNOugb9GRyRcIIbU0q4q0JrN2dW7xI
	 uTmhrtZcP2C9g==
Message-ID: <00a65776-ce8f-49ad-8fe3-797d6e92f51a@kernel.org>
Date: Wed, 20 May 2026 15:01:23 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] memcg: store node_id instead of pglist_data pointer
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 Alexandre Ghiti <alex@ghiti.fr>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20260520053123.2709959-1-shakeel.butt@linux.dev>
 <20260520053123.2709959-2-shakeel.butt@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260520053123.2709959-2-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16111-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,linux.dev:email]
X-Rspamd-Queue-Id: E8B0E587FAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/20/26 2:31 PM, Shakeel Butt wrote:
> The struct obj_stock_pcp stores a pointer to pglist_data for the slab
> stats cached on the cpu. On 64-bit machines, this costs 8 bytes. The
> pointer is not strictly required: NODE_DATA() can recover it from the
> node id. Replace cached_pgdat with int16_t node_id and use NUMA_NO_NODE
> as the "no stats cached" sentinel.
> 
> At the moment all the archs limit MAX_NUMNODES to 1024 so int16_t is
> plenty; a BUILD_BUG_ON() makes sure we notice if that ever changes.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> ---

Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon



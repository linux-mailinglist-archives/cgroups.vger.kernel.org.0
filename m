Return-Path: <cgroups+bounces-16192-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPhAOCu/D2pwPQYAu9opvQ
	(envelope-from <cgroups+bounces-16192-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 04:27:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4C05ADFED
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 04:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B3AA300F604
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 02:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507F42E6CA6;
	Fri, 22 May 2026 02:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GVpw4nkH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4925B09F
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779416870; cv=none; b=BGaai08hAspdzBSLZvAbvDmC5eL7NepHfexZS9ZPQEXLd7Lyj9G82Zs0C+MSUYQJAYfy9jqAwwLdpcTzNCgbU3bpVuaqqldHGQ3lRTf56nRT0spJpl38Y9ZyQcszZlzGTkz0EdRN6wzhuHwv6Yq6KWKoUKnl8WGuEaRb/NOrLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779416870; c=relaxed/simple;
	bh=DhpVESDQBgXXw+wOLddAcOF5ND6kknaupEmYWCM3y00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhv7Jl+Cl6D+1VoRQV37/A05eu3b46iQju7rEGTujWsxmepJqrkkvLI03uTBMJxZyWQ56s0P4tfl8eUne8His4DY0tVfMpaW5pUq7wY1xHkviPZsjKSWRGfDFuDnGE3AdQ34kDa91UU4XDwIb7X0R44O/FAk0d942K0QrW3FdEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GVpw4nkH; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <150014a5-82d0-4e53-8595-b01b3bf43832@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779416866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLflcTnDVR68YXOTUiaDyXVU/XHr7QC3203n7y7YGNA=;
	b=GVpw4nkHZflPEGjsfKYHrPnisj2uSGUz/jH04R8rFFS6qfVFmYVXCQ7eZNWVP+ct/UCMvM
	5NytgX00z3Av116TkzeRk51G4La7vdHEP5NeWrdXXv+B0nOyKtG2JlNyKk3gv3e9QSn9V9
	6YkanccAoChLgcmi7ZWHvgil1S7hpXs=
Date: Fri, 22 May 2026 10:27:38 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] memcg: store node_id instead of pglist_data
 pointer
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Harry Yoo <harry@kernel.org>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20260522011908.1669332-1-shakeel.butt@linux.dev>
 <20260522011908.1669332-2-shakeel.butt@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260522011908.1669332-2-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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
	TAGGED_FROM(0.00)[bounces-16192-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,intel.com:email]
X-Rspamd-Queue-Id: 8B4C05ADFED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/22/26 9:19 AM, Shakeel Butt wrote:
> The struct obj_stock_pcp stores a pointer to pglist_data for the slab
> stats cached on the cpu. On 64-bit machines, this costs 8 bytes. The
> pointer is not strictly required: NODE_DATA() can recover it from the
> node id. Replace cached_pgdat with int16_t node_id and use NUMA_NO_NODE
> as the "no stats cached" sentinel.
> 
> At the moment all the archs limit MAX_NUMNODES to 1024 so int16_t is
> plenty; a BUILD_BUG_ON() makes sure we notice if that ever changes.
> 
> Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
> 
> Changes since v1:
> - Added tags in the commit message
> 
>   mm/memcontrol.c | 26 +++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
> 

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks!



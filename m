Return-Path: <cgroups+bounces-17704-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oz+sM42+VGo5qgMAu9opvQ
	(envelope-from <cgroups+bounces-17704-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:31:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C83A749DAB
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:31:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=t7KmIKiI;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17704-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17704-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 449BA3061077
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FA3EC2E3;
	Mon, 13 Jul 2026 10:27:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0AF3E92B9
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 10:27:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938432; cv=none; b=LpqMOJeFEDKr8P3HzHzwCUfWjs9r4w3KfktSol6L8BSlGtsfc7bOKDzKnwht2tRC2B0fFldyQx+e9baMfg3Tw80MdGDQMQtLzj4pNT4C2k9/v0T0rsBne8LCndzAG+qSBdYjklT62XRZ1HzFKuMGqkF57P4WZQMCneSd7DKeUww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938432; c=relaxed/simple;
	bh=tlSStQRjz7IsgoduonWvy/BiNHcyY6I1VMddmxBXKcc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tv51Udd9/IrC2uASP+qvPn/7Rx5LSicxQ+2TEoxuUEjvpuOEkzJOOh/JWMkqagIhp1Q0BRiq6kGlrdZeofmQfYl9BIrCgnkp5bJMn29+qaQLlpH+q15FPjPE90QeegKb0+3QrqyZfO1cJOC1kio+Lg17BZ5j6DZxlwDJSFHxOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t7KmIKiI; arc=none smtp.client-ip=91.218.175.173
Message-ID: <877c39be-d4d6-4d9c-b824-18d9463c62c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783938425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hI0ulS+e7/Y2oO5fBiqc90A7kYsME7pKoySFXxv5Y8o=;
	b=t7KmIKiIfaH9vl5ApL6tbaX1tiOn/PaCox8ALC8rjDdI01CWo4AmLTP0tK6BQlWieFWasG
	0JO4hkTfq9GOdwbNl5DqBRt225BskLmxXZfbAVmz6vFMi2FQ7hPHhjyRUltdm1FqaK6hPs
	48nvhCZmrCrmd0yqgcc0L3n3D12Qv8w=
Date: Mon, 13 Jul 2026 18:26:58 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] mm: memcg-v1: account vmpressure event allocations
To: Guopeng Zhang <guopeng.zhang@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Stanislav Fort <stanislav.fort@aisle.com>
References: <20260713085520.2953121-1-guopeng.zhang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260713085520.2953121-1-guopeng.zhang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:zhangguopeng@kylinos.cn,m:guopeng.zhang@linux.dev,m:akpm@linux-foundation.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:stanislav.fort@aisle.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17704-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C83A749DAB



在 2026/7/13 16:55, Guopeng Zhang 写道:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> Commit 72797d218b43 ("mm/memcg: v1: account event registrations and drop
> world-writable cgroup.event_control") accounted cgroup v1 event
> registration allocations with GFP_KERNEL_ACCOUNT, but missed struct
> vmpressure_event.
> 
> Use GFP_KERNEL_ACCOUNT for this allocation as well.
> 
> Fixes: 72797d218b43 ("mm/memcg: v1: account event registrations and drop world-writable cgroup.event_control")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>  mm/memcontrol-v1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index e8b6e1560278..f8424ec3734b 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -1721,7 +1721,7 @@ int vmpressure_register_event(struct mem_cgroup *memcg,
>  		mode = ret;
>  	}
>  
> -	ev = kzalloc_obj(*ev);
> +	ev = kzalloc_obj(*ev, GFP_KERNEL_ACCOUNT);
>  	if (!ev) {
>  		ret = -ENOMEM;
>  		goto out;
Acked-by: Tao Cui <cuitao@kylinos.cn>



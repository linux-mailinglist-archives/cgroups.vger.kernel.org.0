Return-Path: <cgroups+bounces-17645-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id psVdNnJzUGryzAIAu9opvQ
	(envelope-from <cgroups+bounces-17645-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 06:22:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 927F87371B1
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 06:22:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=qoMWIDHG;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17645-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17645-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC39E30237F1
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 04:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD5B36C5BF;
	Fri, 10 Jul 2026 04:22:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFB236A362;
	Fri, 10 Jul 2026 04:21:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657321; cv=none; b=jcSSC+JugSu2XosNo9/fuXwsVcGKM2xXhx4zJ0CzZrypC+XE5UD9RhRFvozKYF1M/RbEUnDETw5O9j8JvyaX2Y+OimQxE+ArR5XJCSZvvmry89JK8xUSCvqce3WG0GTMZ4pOviyXpnZpkmHjL8T+9Dhq4Vugq1W+RVcIDofxMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657321; c=relaxed/simple;
	bh=LZcMK+XoldP7yradNDcuGxhwCXeeM+TMPel+b3TPJVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYgHEabZvMrhShnk2CIzOrhqrlfmQzRIg5ej6iWdcfB5NvzBCOsqLrhiIlJ6y65QRgSlurz4SMyxiijhc8rAgYt0WBKBhOnQ6BKpjJ6TVMVGw3LKE3ukFJ2azYiPdZmx9C1Gqfyy9a+f4JdwDC1L8UzTRqCnE6NkZZzZyqWNVxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qoMWIDHG; arc=none smtp.client-ip=95.215.58.182
Message-ID: <2277444e-111e-405b-b031-57efa5fcb8ef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783657307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1lpSCBPT1MfvQVMMK5lCzHUYPGixov0SxOx6zazzW9Y=;
	b=qoMWIDHGpox1VZZnudIb+Te9ql2jRejnUkB2P0kdJZvXuhTx3Oq8pUTu2RBISo9KvvEOn+
	WMJf0T2gewvNq0cB9IR8RNRxcYTH4Eps0uD7HKaresot8LSlALraucQ31yCJiZyoPTt8YA
	WXd/gfHAXNwwIbg+/6h/tHnpAlgHtKw=
Date: Thu, 9 Jul 2026 21:21:10 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 12/13] RDMA/rxe: Implement disassociate_ucontext
 callback
To: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: cgroups@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, jgg@ziepe.ca,
 leon@kernel.org, parav@nvidia.com, mbloch@nvidia.com, cmeiohas@nvidia.com,
 roman.gushchin@linux.dev, bvanassche@acm.org, zyjzyj2000@gmail.com,
 shuah@kernel.org, tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
 alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, sidraya@linux.ibm.com,
 wenjia@linux.ibm.com
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-13-jiri@resnulli.us>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260709095532.855647-13-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17645-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:linux-rdma@vger.kernel.org,m:yanjun.zhu@linux.dev,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,suse.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 927F87371B1


在 2026/7/9 2:55, Jiri Pirko 写道:
> From: Jiri Pirko <jiri@nvidia.com>
>
> Implement an empty disassociate_ucontext() callback so the RDMA core
> can move rxe devices between net namespaces. The core requires this
> callback to reset user contexts without waiting for userspace.
>
> rxe needs no teardown here: its user-mapped queues live in
> reference-counted vmalloc memory (see rxe_mmap.c) that stays valid
> while userspace holds the mappings.

The logic here is correct for enabling netns migration. Since RXE's 
user-mapped

queues rely on reference-counted vmalloc memory, this empty stub is safe 
enough

to prevent kernel panics or Use-After-Free (UAF) during device movement.


However, as a note for future improvement: keeping this callback 
entirely empty

means userspace won't be immediately notified (via SIGBUS or page table 
zapping)

when the underlying device is moved out of its netns. For now, this 
serves well as

a functional enabler, but we might want to introduce proper PTE 
tearing/zap_vma_ptes()

down the road if applications require strict, immediate disconnection 
semantics.


Thanks Jiri.

Reviewed-by: Yanjun Zhu <yanjun.zhu@linux.dev>

Zhu Yanjun

> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 1ec130fee8ea..6eb10d2f0653 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -240,6 +240,10 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
>   		rxe_err_uc(uc, "cleanup failed, err = %d\n", err);
>   }
>   
> +static void rxe_disassociate_ucontext(struct ib_ucontext *ibuc)
> +{
> +}
> +
>   /* pd */
>   static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
>   {
> @@ -1478,6 +1482,7 @@ static const struct ib_device_ops rxe_dev_ops = {
>   	.destroy_srq = rxe_destroy_srq,
>   	.detach_mcast = rxe_detach_mcast,
>   	.device_group = &rxe_attr_group,
> +	.disassociate_ucontext = rxe_disassociate_ucontext,
>   	.enable_driver = rxe_enable_driver,
>   	.get_dma_mr = rxe_get_dma_mr,
>   	.get_hw_stats = rxe_ib_get_hw_stats,

-- 
Best Regards,
Yanjun.Zhu



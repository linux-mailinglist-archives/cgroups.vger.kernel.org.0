Return-Path: <cgroups+bounces-16842-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Cc7OzJHKmp/lgMAu9opvQ
	(envelope-from <cgroups+bounces-16842-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 07:27:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B46D66E8CC
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 07:27:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=GxqslFYr;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16842-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16842-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65F1830144E9
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 05:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3862BE7D1;
	Thu, 11 Jun 2026 05:26:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE1535CB6F
	for <cgroups@vger.kernel.org>; Thu, 11 Jun 2026 05:26:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155587; cv=none; b=eI4zsM1QCdPbz3ZainxQjz52i7Ovw+LNOG7HSb6/t3V9XxqKNVbLBES0utBLXJG+iRCHJbO5VwfuFBDVBNZ2p3pUDyKYXZoBpmUNA6utRY1P6jzPex2iYotlt6SlabGTuQoAhkAj18D3NAncSt1rAqRh/7DCi9P+v4ImO6zS0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155587; c=relaxed/simple;
	bh=KWQqS8gV2CPteH4a+zKxTE85D/3pI+ltsiFq8cmqFKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QauyCgEpKBQZeqAw8lCUJbVIcKzC9uBE2U52ZmYrai/mVLDIIf8+Iry+TX4ct8mWLHxxulKWfzgHRHPYec5IzOnIiAsFR7MFsHv1aYnHRu+fxl9NfjVMxreqJf9Qu2Z+1IH8pEdJvqvx4l5SqRWWA9yf+3N+IGh9UKpnMhosP0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GxqslFYr; arc=none smtp.client-ip=91.218.175.185
Message-ID: <0b1099e8-e124-4073-a0e8-2d4e85bc26dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781155576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34u/gf0ccNs0AJS7sbBUEsTt849laT5bFT+HM9Xyi74=;
	b=GxqslFYrILbXOQlWHj8igI1eCbxWd1zxelDqBdx7jfsco16NQTduCUecWvKi8JXiwGhR2U
	fcyNmuKDL8Hez8SmareSvLt+vsPOAq6pnWt4NhCCCwTCnbLTZl+b6fUds4yDWlVbmx/hVk
	7DgSIqPlyAmQvtyvqZRiud1HlGLddWM=
Date: Thu, 11 Jun 2026 13:25:54 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] cgroup: rdma: free idle pools during cgroup teardown
To: Ren Wei <n05ec@lzu.edu.cn>, cgroups@vger.kernel.org
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 pandit.parav@gmail.com, yuantan098@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, tr0jan@lzu.edu.cn, d4n.for.sec@gmail.com
References: <cover.1781092143.git.d4n.for.sec@gmail.com>
 <9eb365a37ab83f38686007f8a61a656759d39bd7.1781092143.git.d4n.for.sec@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <9eb365a37ab83f38686007f8a61a656759d39bd7.1781092143.git.d4n.for.sec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16842-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:cgroups@vger.kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:pandit.parav@gmail.com,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:tr0jan@lzu.edu.cn,m:d4n.for.sec@gmail.com,m:panditparav@gmail.com,m:d4nforsec@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B46D66E8CC

Hi,

在 2026/6/11 02:13, Ren Wei 写道:
> From: Daming Li <d4n.for.sec@gmail.com>
> 
> rdmacg_css_offline() converts each pool to all-max limits so the
> existing reclaim path can free it after the last uncharge. However,
> zero-usage pools are already reclaimable at that point and leaving them
> linked until rdmacg_css_free() lets later device teardown hit a
> use-after-free when free_cg_rpool_locked() deletes cg_node from a freed
> cgroup list head.
> 
> Free zero-usage pools directly from rdmacg_css_offline() while holding
> rdmacg_mutex. This keeps the existing reclaim rule, avoids new lifetime
> states, and ensures a cgroup cannot be freed with reclaimable rdmacg
> pools still attached.
Looks good to me.

One minor note: the offline path skips rpool_has_persistent_state()
and frees idle pools unconditionally. This means peak/event stats are
lost earlier than before (at offline vs. at free). This is fine given
the cgroup is dying, and css_free() cleans up remaining pools anyway.

Reviewed-by: Tao Cui <cuitao@kylinos.cn>

Thanks,
--
Tao


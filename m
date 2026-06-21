Return-Path: <cgroups+bounces-17112-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j0vPIqkuOGoxZQcAu9opvQ
	(envelope-from <cgroups+bounces-17112-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 20:34:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C22C6AB6F2
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 20:34:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=FxKLKXmv;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17112-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17112-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E1413006161
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EBA36605A;
	Sun, 21 Jun 2026 18:34:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5831F9A3
	for <cgroups@vger.kernel.org>; Sun, 21 Jun 2026 18:34:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782066855; cv=none; b=MEyrX/uDfQHqZ8jL3zmgKtwiBw2SXYSMEB6DVcyQw9+4LzykZHbHXfjiLxw4i0ynwG+ugi5u1TYm99+0/lpqfZGXnbTk1yvNUryUWddseb1QCB/xU7iWTDGFEAW5KvHQNvJnbFLliGArXc/KEej7pINlGz4TnznVDjfVyXFDMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782066855; c=relaxed/simple;
	bh=5QlDLf8SQDOeoIfSCkdH2+1gK99hn1dAn40S+rifjd8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EmsdjH7CYdr8dKDyLl4MdB44lVL8Ak8Ts9x3dEG8+b4a4vCcuioVYn02//iqspza7wHbYVNF5l0dV4VSBv3pfcx2KOJ8hglo4YXIwan4wjOio1QN6wFdsq32XnouyTsjq6T+1qKDHiD94A72BqoTgHC6y5qabSfGjnHwQvLK424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FxKLKXmv; arc=none smtp.client-ip=91.218.175.171
Message-ID: <02d53444-a0f6-4135-9e94-8ace2d89b0c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782066840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2cZkl4yw2fKXXfmszC3Jt+fvYCWM7AKjOfb2EHPKc8=;
	b=FxKLKXmvQ9yNLZnr8L1aPNBPdcXzFvfAZkOtO+34GXggY+mjdcPQ+VQ05q3uxJH0rlp4vd
	ejjw51qNey4ncRhRsjQySrCRr+oCFz/S3HUrvHbDxG1u2tDVqY+ZEIeJM00VbMqXW/3tIh
	ll8IvNvPYAS1Co4CUdFn/2UMZT09QjM=
Date: Mon, 22 Jun 2026 02:33:28 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] block, bfq: protect async queue reset with blkcg locks
To: Cen Zhang <zzzccc427@gmail.com>, Yu Kuai <yukuai@fygo.io>,
 Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jens Axboe <axboe@kernel.dk>, Arianna Avanzini <avanzini.arianna@gmail.com>,
 Paolo Valente <paolo.valente@linaro.org>
References: <20260621135930.2657810-1-zzzccc427@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260621135930.2657810-1-zzzccc427@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,m:zzzccc427@gmail.com,m:yukuai@fygo.io,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:avanzini.arianna@gmail.com,m:paolo.valente@linaro.org,m:avanziniarianna@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17112-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,fygo.io,kernel.org,toxicpanda.com,kernel.dk,linaro.org];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C22C6AB6F2


Nice catch. The race is real, and the fix lines up with how the rest
of the blkcg code already protects blkg_list walks — the new nesting
(blkcg_mutex -> queue_lock -> bfqd->lock) is the same order
blkg_free_workfn() and bfq_pd_offline() use, so no inversion.

Reviewed-by: Tao Cui <cuitao@kylinos.cn>

在 2026/6/21 21:59, Cen Zhang 写道:
> Writing 0 to BFQ's low_latency attribute ends weight raising for active,
> idle and async queues. The async cgroup path walks q->blkg_list, converts
> each blkg to BFQ policy data and then reads bfqg->async_bfqq and
> bfqg->async_idle_bfqq.
> 
> That walk was protected only by bfqd->lock. blkcg release work is
> serialized by q->blkcg_mutex and q->queue_lock instead, and
> blkg_free_workfn() can call BFQ's pd_free_fn before it removes
> blkg->q_node from q->blkg_list. A low_latency reset can therefore still
> find the blkg on the queue list after the BFQ policy data has been freed.
> 
> The buggy scenario involves two paths, with each column showing the order
> within that path:
> 
> BFQ low_latency reset:              blkcg blkg release work:
> 1. bfq_low_latency_store()          1. blkg_free_workfn() takes
>    calls bfq_end_wr().                 q->blkcg_mutex.
> 2. bfq_end_wr_async() walks         2. BFQ pd_free_fn drops the
>    q->blkg_list.                       final bfq_group reference.
> 3. blkg_to_bfqg() returns           3. blkg->q_node remains on
>    the stale policy data.              q->blkg_list until list_del_init().
> 4. bfq_end_wr_async_queues()
>    reads async queue fields.
> 
> Fix this by taking q->blkcg_mutex and q->queue_lock around the
> q->blkg_list walk, then taking bfqd->lock before touching BFQ async
> queues. The mutex serializes against policy-data free and queue_lock
> stabilizes the list. Move the async reset out of bfq_end_wr()'s existing
> bfqd->lock critical section so the lock order matches blkcg policy
> callbacks.


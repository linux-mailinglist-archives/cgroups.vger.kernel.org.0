Return-Path: <cgroups+bounces-17578-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VNzZJ+rbTWr4/AEAu9opvQ
	(envelope-from <cgroups+bounces-17578-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 07:11:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC5F721B7B
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 07:11:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=W+WALtvV;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17578-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17578-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 251CE3006130
	for <lists+cgroups@lfdr.de>; Wed,  8 Jul 2026 05:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0643B38AE;
	Wed,  8 Jul 2026 05:11:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93EC3B6377
	for <cgroups@vger.kernel.org>; Wed,  8 Jul 2026 05:11:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487464; cv=none; b=eMuNLaimHyOO48hKWvZDJl1nt9xcGjuIA0OMNeXIbgFmXZfk+pJZ89JBjJx78q+3Z0Xi+ewv1bSh7VMtaIntMWUqSQ/l9XERJOrju5Eka54q3RU1sgVs0lVYHwypdM+Bsn7QnsLYaTLgJSxV101qm/ETEM5LlA4c4FPMCLobkVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487464; c=relaxed/simple;
	bh=vv8D2L8doGz9gEj6yEEeTzBs9V+HoojsKpK8bM9rlDA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ua32AgxnhixEmpWn9lQRsQ3rRJnKX28rEzIChFMxldunKmBS2DkNqvtgRY9Xt20HqpjauvPIeLGBAwy4GvmoRwKHGf6IM7a1wfIjmN2NDf73cGAzHSwjQldych0Q49dIxSixLtmII5nsJ6lCuCM9LHD8Xv/n7pxUgtwQtcDn3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W+WALtvV; arc=none smtp.client-ip=91.218.175.184
Message-ID: <841e91db-a51e-4df5-8cfc-e3762a2fecf1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783487460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDTp1TcEqFpY3yW2LIhbxzhg7yVVaR/dVnLK5C8kfJ4=;
	b=W+WALtvVlrpL5xZ7l7B9MC6i9lku2jsnrRksapy3ZMZPwgQmwzlFOi2jpx0C8kUfcWn1vz
	z0yTIvs3NMVUmGwaJyUf12Zicjr7lKPoVOCjDY2niqR5jJrV9SVkCzd93ExHu0QB5EzfXr
	Nhyc15Hk966xmt2skeqFc5YE6/WCs4U=
Date: Wed, 8 Jul 2026 13:10:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Yu Kuai <yukuai@fygo.io>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] blk-cgroup: clear blkg->pd[] with WRITE_ONCE() in
 blkcg_deactivate_policy()
To: Guopeng Zhang <guopeng.zhang@linux.dev>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
References: <20260707125814.1978139-1-guopeng.zhang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260707125814.1978139-1-guopeng.zhang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17578-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:yukuai@fygo.io,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,m:guopeng.zhang@linux.dev,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEC5F721B7B



在 2026/7/7 20:58, Guopeng Zhang 写道:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> blkcg_activate_policy() installs blkg->pd[] entries with WRITE_ONCE()
> and also uses WRITE_ONCE() when clearing them on its error path.
> blkg_to_pd() is used by RCU readers and reads the same array with
> READ_ONCE().
> 
> blkcg_deactivate_policy() clears the entry with a plain store. Use
> WRITE_ONCE() there as well.
> 
> Fixes: 56cc24f59c14 ("blk-cgroup: don't nest queue_lock under rcu in blkcg_print_blkgs()")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>  block/blk-cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index d2a1f5903f24..a1dd69f99f5c 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1691,7 +1691,7 @@ void blkcg_deactivate_policy(struct gendisk *disk,
>  			if (blkg->pd[pol->plid]->online && pol->pd_offline_fn)
>  				pol->pd_offline_fn(blkg->pd[pol->plid]);
>  			pol->pd_free_fn(blkg->pd[pol->plid]);
> -			blkg->pd[pol->plid] = NULL;
> +			WRITE_ONCE(blkg->pd[pol->plid], NULL);
>  		}
>  		spin_unlock(&blkcg->lock);
>  	}

Reviewed-by: Tao Cui <cuitao@kylinos.cn>



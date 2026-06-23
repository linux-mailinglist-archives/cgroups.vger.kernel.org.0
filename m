Return-Path: <cgroups+bounces-17166-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MEPcNW3eOWqWyQcAu9opvQ
	(envelope-from <cgroups+bounces-17166-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 03:16:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4886B31D4
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 03:16:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=NX7BAWz3;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17166-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17166-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53D1F302E607
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 01:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B6376A0B;
	Tue, 23 Jun 2026 01:16:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532DE30D3E9
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 01:16:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177384; cv=none; b=pT20EgaOG5SzGJxrq7mRPSNMAUVnRcZC3yhvqFe5irHroaNdrfPCcTmU2F9hjTrA/I/5/w0IG59Mhcbsu0pxv84UZ1LPFEJwlgMRw4EfGf3e9fD0E868ecjSiHqCzAg+Z4BNyhH7jZm0g5vULtHWyBNRQqK0qe6l/x9Q/kUthEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177384; c=relaxed/simple;
	bh=vg3wPC7jO9qTviKshM1mltF4IV5lb3FhxmhRHoFsvVI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GTjJPf5d39Q/L7C2liFk4rWaA3eGMlATZTB3lIeCbc3yLHcjHZz9093Mcx4xWvQClPv/4N/znhIIsyt3obL9uw6TQ2OCmlXVAGS9OacVo0zZGU/o4j9EIBF9W2VT9+bOeLR+SdGwL/0eT9CZVvE4julLYjz9xnRVn91rN4nu7W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NX7BAWz3; arc=none smtp.client-ip=95.215.58.181
Message-ID: <38704548-786f-4ec7-afd4-228aa8d68ad7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782177381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jazVFyYoX6ftfj3SrA57nJBQLa/oXcNsFtjUmrhgLSk=;
	b=NX7BAWz309zA4pLIM0U0aZPFiH+SwFh59Czpu0M5/MYWP90j8ARH0PCXdVSrpP7vcAPAbD
	mCH6d3oTYJmQothNsmM8raLHjX7fcnlheqEqljTzW4O0UgFmLyIMO4onc5dQwy4hdOt29y
	GhNIXjd7BH6/aL0G6LUanDOfnfu01Q0=
Date: Tue, 23 Jun 2026 09:16:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, cgroups@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, houtao1@huawei.com, yukuai@fygo.io
Subject: Re: [PATCH 1/2] blk-cgroup: fix blkg leak in blkg_create() error path
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, linux-block@vger.kernel.org
References: <20260622070714.1158886-1-wozizhi@huaweicloud.com>
 <20260622070714.1158886-2-wozizhi@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260622070714.1158886-2-wozizhi@huaweicloud.com>
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
	TAGGED_FROM(0.00)[bounces-17166-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:cgroups@vger.kernel.org,m:yangerkun@huawei.com,m:chengzhihao1@huawei.com,m:houtao1@huawei.com,m:yukuai@fygo.io,m:wozizhi@huaweicloud.com,m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:linux-block@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huaweicloud.com:email,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C4886B31D4

Hi Zizhi,

Thanks for the patch.  I ran into the same issue and posted a fix for it
earlier:

  https://lore.kernel.org/all/20260507061229.57466-1-cuitao@kylinos.cn/

The leak fix is identical to yours (blkg_put() -> percpu_ref_kill()),
plus one extra change: moving blkg->online = true into the success
block:

	if (likely(!ret)) {
		...
+		blkg->online = true;
	}
-	blkg->online = true;

On the failure path the blkg was never inserted into any list, and its
blkg->pd[i]->online flags were not set either (those are in the same
block).  Leaving blkg->online = true marks a blkg as online that was
never created -- inconsistent with pd[]->online and with
blkg_destroy(), which clears blkg->online = false.  Not observable
today, since the failed blkg is on no list and unreachable by the
online readers, but the flag should track the actual insertion.

(This was sent to the cgroups list rather than linux-block, hence the
overlap.)

Thanks,
Tao

在 2026/6/22 15:07, Zizhi Wo 写道:
> When radix_tree_insert() fails in blkg_create(), the error path calls
> blkg_put() to release the blkg. This was correct when blkg->refcnt was an
> atomic_t: blkg_put() dropped it to 0 and triggered the release path.
> 
> But commit 7fcf2b033b84 ("blkcg: change blkg reference counting to use
> percpu_ref") switched refcnt to a percpu_ref. In percpu mode
> percpu_ref_put() never checks for zero, so the release callback is never
> invoked. This blkg is on neither blkcg->blkg_list nor queue->blkg_list, so
> blkg_destroy_all() / blkcg_destroy_blkgs() can never reach it to call
> blkg_destroy()->percpu_ref_kill() either, cause the leak.
> 
> Fix it by killing the percpu_ref instead, which switches it to atomic mode
> and drops the initial ref.
> 
> Fixes: 7fcf2b033b84 ("blkcg: change blkg reference counting to use percpu_ref")
> Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>  block/blk-cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index bc63bd220865..6386fe413994 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -437,11 +437,11 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>  
>  	if (!ret)
>  		return blkg;
>  
>  	/* @blkg failed fully initialized, use the usual release path */
> -	blkg_put(blkg);
> +	percpu_ref_kill(&blkg->refcnt);
>  	return ERR_PTR(ret);
>  
>  err_put_css:
>  	css_put(&blkcg->css);
>  err_free_blkg:



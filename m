Return-Path: <cgroups+bounces-17504-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YLcWEKvHSmoYHgEAu9opvQ
	(envelope-from <cgroups+bounces-17504-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 05 Jul 2026 23:07:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7472770B71B
	for <lists+cgroups@lfdr.de>; Sun, 05 Jul 2026 23:07:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=E41w9rZK;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17504-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17504-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 572FC3002B73
	for <lists+cgroups@lfdr.de>; Sun,  5 Jul 2026 21:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386D636C597;
	Sun,  5 Jul 2026 21:02:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B92366806;
	Sun,  5 Jul 2026 21:02:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285367; cv=none; b=oM5ec6G1o3FA/HKQR9kwn1GdnGjDAUoDlpVdGa63TeQrx3huCpOusv+3qHPMC0rCuKA4LgWqfFi3PY9ycMYqAuQykJPdwDAaxbajObl9YNDTzBvLltA0XH8smDJQGfU+D8RmL00e9PawXQCqOj8bheEV1oT6ZJcmFYZZCbBvJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285367; c=relaxed/simple;
	bh=qeHYPbFp2iiNuLYjQ8jAX0+Oeh/uY5TxePuOiHUoO1s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Se0IIQa0soSNMwp/DmhxxgFtcJoG/iEx9ZhuMvXHhtAwiNQ/dhvPcxf5uMeJHYdyDK09IZLvgNkYyGNNsgwjeu1zhka5nLleSsRjE1F/UXVeGY0GhRAyVIiDuKDFza0cXjPiYz2gGW5tq7EzOd10vrj1BNRoaPn5qzc6aDUHuK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E41w9rZK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CD31F000E9;
	Sun,  5 Jul 2026 21:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783285365;
	bh=3gCHWKa4Bf1jecM+x/DY8mFkX1R2/+i0CVe4zKSjV2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E41w9rZKWqcMtKADxjBWyRinhU1EDTBk02trbkitXaR5Py+y2r6IIWGCZ4QE9eOX9
	 zvKOQQCdsLIhG8oJDZwuDDyq2aTzWkw2N8B3ri1bCyw+vIUB4ah05nrijJAdmLvQhu
	 KXwnd0Kl744NfRIVbWFogyDhYHXhUKjWhXz8+uFo=
Date: Sun, 5 Jul 2026 14:02:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-mm@kvack.org, Jiayuan Chen
 <jiayuan.chen@shopee.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: memcg: reset zswap settings in css_reset
Message-Id: <20260705140245.179017e8360490bc3c9f5ae7@linux-foundation.org>
In-Reply-To: <722b2c40-6d82-4eef-b3f1-245fba465bc0@linux.dev>
References: <20260702024827.353185-1-jiayuan.chen@linux.dev>
	<722b2c40-6d82-4eef-b3f1-245fba465bc0@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:jiayuan.chen@linux.dev,m:linux-mm@kvack.org,m:jiayuan.chen@shopee.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17504-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:from_mime,linux-foundation.org:dkim,linux-foundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7472770B71B

On Thu, 2 Jul 2026 12:07:23 +0800 Tao Cui <cui.tao@linux.dev> wrote:

> > 	# child/memory.swap.max and child/memory.zswam.max disappear
> > 	echo "-memory" > /sys/fs/cgroup/test/cgroup.subtree_control
> > 
> 
> Looks good to me.
> 
> One trivial nit on the commit message (not the patch):
>   # child/memory.swap.max and child/memory.zswam.max disappear
>   zswam  -> zswap

I fixed that in the mm.git copy of this patch.

> Reviewed-by: Tao Cui <cuitao@kylinos.cn>

Thanks.


Return-Path: <cgroups+bounces-16366-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC0yFS9WF2oPBQgAu9opvQ
	(envelope-from <cgroups+bounces-16366-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:38:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA12E5EA20C
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 378173075FEE
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BD73C4B64;
	Wed, 27 May 2026 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uO0kMIEC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BC83C661D;
	Wed, 27 May 2026 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914216; cv=none; b=rRog9XPNCJOg9pPhBPVwO5SLfd4G/Z265n7mXAZtZm91cnkLLV6ArDGlushwgyxSb1s3N7uY+zR+nLbzwQdRpNU9BrUtvyjlUxtvUyJ6ycC/00xrtjASXnKX5E9AfKMyNXqQe4mlwq+ogCul8oWh6DGTOvmGah9fYUg0AfrQbSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914216; c=relaxed/simple;
	bh=ivUTafxW7EUYHVzuAj524XGfbtSrkHr+Zd+VSWRd/Zc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KwwF1IEvRSbHjV6d1us4fjBtV88a0Ef0D8hy6noKuoAoqp3AY8P00KFc8EJHavkf6mGwoaCVxIbjbfQBLcJPMWCs+r5RJNhPpG8dSglyLzFuluoadkiKvG1aJij3lVYwwdd6+tqSvzZIYsHt6hIOnJB5srRElWUqpzXROc/v1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uO0kMIEC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41091F000E9;
	Wed, 27 May 2026 20:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779914212;
	bh=zoqeZwG3y/DBbZTflYJmnprqIV3duVrLDa/AW8PkbO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=uO0kMIECI+ZA9S927s3ybqIf4C88FRCgd72kPKcPaZoajjn9zvOEn3ySaNm+LtO6q
	 fvAQQYcklDxHuiAL+BcXbr8jVHUg3oZz8TJJL4p9sRE0SVVRjoWB+jXBaPSILloafl
	 WpntFOChULwcpyxhpmx18DOfzp5atrrnU3pruI3E=
Date: Wed, 27 May 2026 13:36:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Youngjun Park <youngjun.park@lge.com>
Cc: chrisl@kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, kasong@tencent.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
 baoquan.he@linux.dev, baohua@kernel.org, gunho.lee@lge.com,
 taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com,
 baver.bae@lge.com, matia.kim@lge.com
Subject: Re: [PATCH v7 0/4] mm: swap: introduce swap tier infrastructure
Message-Id: <20260527133651.2ce806fa542a82eca5ff66d6@linux-foundation.org>
In-Reply-To: <20260527062247.3440692-1-youngjun.park@lge.com>
References: <20260527062247.3440692-1-youngjun.park@lge.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16366-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,lge.com,suse.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lge.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: BA12E5EA20C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 15:22:43 +0900 Youngjun Park <youngjun.park@lge.com> wrote:

> This is v7 of the swap tier series addressing review feedback.
> The cover letter has been simplified.

One question from Sashiko.   Minor, but easy to address.
	https://sashiko.dev/#/patchset/20260527062247.3440692-1-youngjun.park@lge.com

I'm reluctant to add a new feature patchset at this time - we have a lot
already and we're at -rc5.   What do others think?


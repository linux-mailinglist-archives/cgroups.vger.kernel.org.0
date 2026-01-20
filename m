Return-Path: <cgroups+bounces-13331-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIkuD6y9b2kOMQAAu9opvQ
	(envelope-from <cgroups+bounces-13331-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 18:38:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A4E48B4B
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 18:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A947D80B42F
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6378139A816;
	Tue, 20 Jan 2026 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ScaXqcI3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13AD43D501
	for <cgroups@vger.kernel.org>; Tue, 20 Jan 2026 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924494; cv=none; b=hhn4mVYrlhBHgvcc7l+0LKT7qN6T6Dr79uCjf6nik5xMX7DErpSsY0HSEWEVD0mG1wOQRmL89tED4W44SDZrsyRzTwv7So1FsaDxORBY4kTMlJwMtnqcqt1m6+IpOw8LxE/aX4Ablr3yoH6PTpFsidU7L1Rg/mDpgmu4B/bByT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924494; c=relaxed/simple;
	bh=CZxq9hFfJYPFyzVRzUIKNcCMuzAqeShEK1X01eO094w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLWDiiL0ItO4NCI5Lm96QzQ4auu5lYg1b2FStGD0wCdY4BWhrPimwnnJJsqVt+4S/ob/CQtAH9TmG0MM9kE7l/41h/PhyPSTE8LBc1i1TTUKTMGdaWcuM49wkeNwbMURpOZx1RMNTyq89DYLfo5b28+5vegcI+Ic1Vi8YIZuMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ScaXqcI3; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Jan 2026 07:54:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768924489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IhsVj2SW0FOxYtaPNx5A7XnA7ZGrfb7ONRjNT2dq1cs=;
	b=ScaXqcI355Enod1tJ2i/3AlhFJPA6uABNdikdvdAsNXrGz6B/WaEJtYD7pN0V7ZfndiNgp
	tMeCJgJiIA2TJXFybimJiSW9WBvpNKUpINDiBCOKgh4yvGG957S0wQIrfLH8cLd8F6sNq+
	D3ATwcewePPGGTLuuJWokdKA0bEIXWI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
	hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev, 
	david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, 
	yosry.ahmed@linux.dev, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev
Subject: Re: [PATCH v3 24/30] mm: memcontrol: prepare for reparenting LRU
 pages for lruvec lock
Message-ID: <7ruaiutqvgcja5l3zmxluwjp4c7utn62f3lx6ybwcwz5liki37@77fhdxyhmyk5>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <0252f9acc29d4b1e9b8252dc003aff065c8ac1f6.1768389889.git.zhengqi.arch@bytedance.com>
 <4a1b69d2-df29-4204-91fd-bb00b52350db@linux.dev>
 <e7aa1221-040e-4806-a259-56718844897f@linux.dev>
 <ncg4ibcrecdutsizzwdu4buw2fvqc57yji4rx3hsdwv4mgobkz@krdjtokzz4xg>
 <dd288f1a-e7b0-48ae-9b11-d882f42bab36@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd288f1a-e7b0-48ae-9b11-d882f42bab36@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13331-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C9A4E48B4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 11:44:09AM +0800, Qi Zheng wrote:
> 
> 
[...]
> > > 
> > > If no one else objects, I will drop __acquires/__releases in the next
> > > version.
> > > 
> > 
> > If you drop these annotations from header file and keep in the C file,
> > do you still get the compilation error?
> 
> I did test it this way, and it does fix the compilation error, but
> Muchun thinks these functions are very simple and there's no need to put
> them in a C file.
> 

I think we should prefer correctness at this stage. We can always change
these functions later if we see performance impact of these. So, I would
recommend to keep them in C file along with these annotations.


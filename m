Return-Path: <cgroups+bounces-17718-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mo8oKOfbVGrrfwAAu9opvQ
	(envelope-from <cgroups+bounces-17718-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 14:36:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C24174B00E
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 14:36:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=XqnxdyNS;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17718-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17718-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC776300AD8E
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54FB2D9796;
	Mon, 13 Jul 2026 12:34:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C91C860C
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 12:34:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946091; cv=none; b=OI0xbr+Bx5LOkZtYpijPNIwbx8hxIp1pRs74sr9rqSBoAQhGPjlzbHOrcL7nD3yaZK7iNH7ZHrjKprUGOVsJGxgEEr5LCWT4exOl0kQj29/jz1AezbKk35N0EIalEtneM0LA3zA37L67CvPV6B5JCqNpTUcgk4gYOo30cs+pWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946091; c=relaxed/simple;
	bh=U5MfuI69Ft1hR5jqHeDoj3qJTcgQ5f4Qpk1xwWp59hI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IUIXXva41JyNdJ80fyfwJMLbGWN/Mw2Q2HZxwPvj2OeDugE+Y/M9m76GfMVcIbM320sDhJric2f/JIZBvxIItjSBiw+Qjd6dDPw1uh4aI/zd2pDzfDEPofONnoEe+UMXz451naLrA1WBrtHczbyT036fflA9UFKmY481jtza4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XqnxdyNS; arc=none smtp.client-ip=95.215.58.173
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783946087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBpjdqtbb2rhGpETSozc/NsckdAfaonoUVSLNlrevv0=;
	b=XqnxdyNSZIzgO8zwA2kFyBgmgkh2Jcw+ncWitZMoz3Kw0IQLXn+O2Kxb0/6pD5GPT+lROt
	jnJ63+rKvyE7k0cLuTpcwGZUw+3gYRhEkWVVz7qfhSEFnPT+XdPxF9pt59LBblAkqiKkjT
	T1Zf0m79HVLADdHQMtAbfzDk0vsIvTw=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] mm: memcontrol: factor out memcg kmem uncharge sequence
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260713090304.3015329-1-guopeng.zhang@linux.dev>
Date: Mon, 13 Jul 2026 20:33:54 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Guopeng Zhang <zhangguopeng@kylinos.cn>
Content-Transfer-Encoding: 7bit
Message-Id: <5012E3D9-0989-4115-A17B-FE0050DFE25F@linux.dev>
References: <20260713090304.3015329-1-guopeng.zhang@linux.dev>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17718-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:roman.gushchin@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[muchun.song@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,kylinos.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C24174B00E



> On Jul 13, 2026, at 17:03, Guopeng Zhang <guopeng.zhang@linux.dev> wrote:
> 
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> The kmem-uncharge sequence (mod_memcg_state(MEMCG_KMEM) +
> memcg1_account_kmem + conditional memcg_uncharge) is duplicated verbatim
> in obj_cgroup_release() and drain_obj_stock_slot(). Factor it into a
> small memcg_uncharge_kmem() helper. The reference get/put stays at the
> call sites, as they differ.
> 
> No functional change.
> 
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

Reviewed-by: Muchun Song <muchun.song@linux.dev>




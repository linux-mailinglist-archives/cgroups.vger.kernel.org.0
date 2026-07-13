Return-Path: <cgroups+bounces-17717-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ov47E8raVGqXfwAAu9opvQ
	(envelope-from <cgroups+bounces-17717-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 14:32:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC88C74AF76
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 14:32:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="RAZ3e/aw";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17717-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17717-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7768A301E997
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00E840B397;
	Mon, 13 Jul 2026 12:31:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF43F482D
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 12:31:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945904; cv=none; b=sFRilJefrfVqvwoL+tzXgJcjzd9BRtQM1tRH/CTaX6d5RS0W2tN+hOCTyE50Mc24LtiQx4BUAFCwPnseIyD14cxIUYS2gOBNK5UI2wpcKqqR4Pw3x44SrVnkvpjKIIGO7xifgeuFWaQ8ObKEYVz9uqOsc2fGfwvnnDIWcmegAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945904; c=relaxed/simple;
	bh=dthRE+BlFw+TWQNOPcF/CmxNRFrGwo5+fll8LJh0BLg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CTABhtzqYq7LiQtxh7qJ9GzYwHbHUZi346mXUrqPQTI1W28vZhwIJreO/xa5wCgAxxtGurN6C10fek3LXEipOl0xNkPr2ewi99BLXNQlWVASIsUE4oTsO7VmkhJeE1t5jWH+gO8fyBAEzv2ebb3Asv/Ktg7AYhcAtvUsyC9agCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RAZ3e/aw; arc=none smtp.client-ip=91.218.175.186
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783945901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUhcYPLrB310Teap/CNxFNyqUL3uVFa5TFThGRISyng=;
	b=RAZ3e/awoc1DjulIHHhH07ar3DMKCCaS7LV0be+jSRMj5t+uF6xC6dtAJMWahRHQnOVrk8
	fyzmpN6fbyGDtjsJVasRe5vXWFqrJU4OPnn5ourPhzqVF052/UBQPgAMKybKNAt91LIPz5
	kH0H3rRd3yUrb2Oxn5OgBHT3hsmou5Y=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] mm: memcontrol: drop unused cpu argument from
 flush_nmi_stats
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260713090010.2991906-1-guopeng.zhang@linux.dev>
Date: Mon, 13 Jul 2026 20:31:08 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Guopeng Zhang <zhangguopeng@kylinos.cn>
Content-Transfer-Encoding: 7bit
Message-Id: <89877E8B-F3FB-439B-8683-EFA191D0286F@linux.dev>
References: <20260713090010.2991906-1-guopeng.zhang@linux.dev>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17717-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,kylinos.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC88C74AF76



> On Jul 13, 2026, at 17:00, Guopeng Zhang <guopeng.zhang@linux.dev> wrote:
> 
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> flush_nmi_stats() does not use its cpu argument. Remove it from the
> function and its !CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC stub. The
> caller still uses cpu for the subsequent per-CPU rstat flush.
> 
> No functional change.
> 
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

Reviewed-by: Muchun Song <muchun.song@linux.dev>




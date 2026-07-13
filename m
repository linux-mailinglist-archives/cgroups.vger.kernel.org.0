Return-Path: <cgroups+bounces-17716-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8ojaN6XaVGqPfwAAu9opvQ
	(envelope-from <cgroups+bounces-17716-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 14:31:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FAB74AF5A
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 14:31:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=LEwTWAxR;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17716-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17716-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1C84301586D
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D1B40BCC9;
	Mon, 13 Jul 2026 12:31:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2240B363
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 12:31:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945885; cv=none; b=fYv8GcN085b07BLA6E55CQ1eYYnjzarMNNQd73DTd9jJY8gKnn9oQG/snXvoiqo2o3gSgCkLMIdF0fwvA4rfLn6C6GaPrq2wsha6tyoH30FOUWDOQbW1yyKMfO1LVNJz3SApBIvb32CFrJieG6KEcM1xPCtCi21PCymrIToqj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945885; c=relaxed/simple;
	bh=uWIEFLURnkESme9T+L7ZlebN9+Cdd1pDM0f7TC93rOY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UGALvsv0s7lArre6DPgSq4iKx1Jw59jX6oqq8fZDT/5WzqYq8zYKVT3DNgCG+UYV7ltrvBv1jWn+wsiGSB0kLxn4qJa3XTkEGdP4v5hZfWMuPH30gkzxWFUNcgKQMGAeqi2RE17AfPtUwA15MIdiS2l7S29404GUkP5GrVIudl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LEwTWAxR; arc=none smtp.client-ip=91.218.175.172
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783945881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFB23UDIkU558vFag9ouVrBUfbEP1y+rl+Xg6XT26so=;
	b=LEwTWAxRdzON92cwYpy3JHRbt9SQS+fjRMDclWI5ejveG2sc0X35nsBV+ea++I8UqIr9kV
	1bqDSd6akUhrhDXJ1uFJnHlQJIfHzmxJyS17qzvSyIfFag5hGTb09wSVQZIbogf6A6pSdT
	9NxhHMzDxrfVqs2ZbcSTyGWpWMAr4mc=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] mm: memcg-v1: fix wrong linux-mm list address in
 deprecation warnings
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260713085756.2973549-1-guopeng.zhang@linux.dev>
Date: Mon, 13 Jul 2026 20:30:48 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Guopeng Zhang <zhangguopeng@kylinos.cn>
Content-Transfer-Encoding: 7bit
Message-Id: <3B4076F2-A893-44E4-AC2E-B5451226B618@linux.dev>
References: <20260713085756.2973549-1-guopeng.zhang@linux.dev>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17716-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73FAB74AF5A



> On Jul 13, 2026, at 16:57, Guopeng Zhang <guopeng.zhang@linux.dev> wrote:
> 
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> The deprecation warnings for memory.oom_control and
> memory.pressure_level use linux-mm-@kvack.org instead of the linux-mm
> mailing list address. Remove the extra hyphen.
> 
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

Reviewed-by: Muchun Song <muchun.song@linux.dev>




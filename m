Return-Path: <cgroups+bounces-16022-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLYPFL8YCmr8wgQAu9opvQ
	(envelope-from <cgroups+bounces-16022-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 21:36:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8309B563942
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 21:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30973302925A
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 19:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD9A33FE36;
	Sun, 17 May 2026 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tYSH0kMs"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884122DCF52
	for <cgroups@vger.kernel.org>; Sun, 17 May 2026 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779046486; cv=none; b=LqKCtGJMpA4cqs90tT8YOu6OeBSH1/Akcm7R79LWXQx3Mye8I9c/VjP8CIZEKZ1gEVWLgHBTA0bneVS3WYmXGBLFZa6OP6snB3/1T+a2JOjNjXBnorQuco5mGWA2C62Sv9PILMzemmXrvWJ+S+edXRSV2sgr89ZVrGQROuClZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779046486; c=relaxed/simple;
	bh=fqVGrMPltQycqdJUUF3iNfkZ1nzUuT9Uk8viQYk3eI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN/PehkVmemn0QdwhjAGMYW34QxHB+9j6tsY2Odqd2iJ7UTlaIhp4RAieVdltX99feXhrEIo8usGxMK+ma0R/EaKPoV1LOE+YaCsPh4MVbudTLr4LxJuNlvUtrpWYtSLyds381owi8ohLzulUXqXnZ+xRDnS/DP98fZ9Zw3G8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tYSH0kMs; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 17 May 2026 12:34:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779046482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iMAxYkiLe+6rFdPj4BXY2Sm1CnSl5lwd7zUgGll+LNI=;
	b=tYSH0kMsOtzH6hBlheNnNNf6sSMd47g5ItVVvMKyFwyPg9cXN6EyO0UYWh17vOpTHcr+F/
	Y1RkFWSkhCPB7TzPu1m7hU0AVSnbSCx6T+W6KKDwL3Mw41b7MmAgymsUyBB1jt+mEZWALF
	4ggl/OwcTDyCUNJTDbmgXOI9qz68eMQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] memcg: cache obj_stock by memcg, not by objcg pointer
Message-ID: <agd-gbYnVyaaiLH7@linux.dev>
References: <20260515171953.2224503-1-shakeel.butt@linux.dev>
 <agdnTPXhuepuu7hG@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agdnTPXhuepuu7hG@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8309B563942
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16022-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 11:42:39AM -0700, Shakeel Butt wrote:
[...]
> > Will sharing the reserve between per-node sibling objcgs without updating
> > stock->cached_objcg break the page multiple invariant in
> > obj_cgroup_release()?
> > 
> > If an allocation for objcg_B consumes bytes originally funded by objcg_A,
> > and the stock is later drained, those borrowed bytes are flushed into
> > objcg_A->nr_charged_bytes.
> > 
> > When obj_cgroup_release() is invoked, nr_charged_bytes will not be an
> > exact multiple of PAGE_SIZE. Will this trigger
> > WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1)) and truncate the remainder,
> > permanently leaking the page charge from the memcg?
> 
> This is actually a very good point and need more thought.
> 

I think we can handle this simply by taking over objcg->nr_charged_bytes into
the stock.



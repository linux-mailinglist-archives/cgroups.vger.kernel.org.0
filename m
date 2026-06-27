Return-Path: <cgroups+bounces-17361-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nsf1CZwYP2pQOwkAu9opvQ
	(envelope-from <cgroups+bounces-17361-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2026 02:26:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 871366D09C9
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2026 02:26:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=xa2LIILx;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17361-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17361-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0994430316ED
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2026 00:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52BD19D065;
	Sat, 27 Jun 2026 00:25:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AA914F112
	for <cgroups@vger.kernel.org>; Sat, 27 Jun 2026 00:25:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782519951; cv=none; b=Nq29/tdb/nn7+VRoi237EHvbGjldmFXpOeQ6ZyOWwqGaUBdYyJbB7aFa6AyQM4lX4eby9tr1/EQI/MYv990JVTl7SyzEH2aehjRqLapodFm3bICBWr0c3/FWddsY6Goh/Cnx2tb6B0noEMGAw+EXjkH0xgwhvOTGYFbKyM3Z0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782519951; c=relaxed/simple;
	bh=cpZeDxH/8kquhBtLjijxoMFE249+DJTDDNQeZc7MnGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RL37WusQRXR0fa9Rg+l9Vr2uZkdeo5DkQrY1Z1EjIY/2ZWelRmB9ixXGCv39ukqnfSllLoLyzJN42/HDYbAf1G3G+/UjdNZT9HMFpLslZSvb9kXyRfc8tMi59UlN6tNmOjYE2/9V5wyQ+IbRWO7RakhxiQapGZtA7/qv7o0jAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xa2LIILx; arc=none smtp.client-ip=95.215.58.189
Date: Fri, 26 Jun 2026 17:25:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782519938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2rtmhvJjinb8DEEiGRho1gz89/v7/dbBZ8zEBhu5q/s=;
	b=xa2LIILxyclfD441FflIQK7j1hGGLliqf33fZ7ZssQWT1pkGKSVCn9Q7fG+XFPaQrZQk5c
	2q9Ia1lSFkmC5hwixcTy2ISERcSMtSRN8gU5yTLQHImyrGqCttWs3hBZU+SM3n6qgV8j6S
	QKw5IoEzyOKykbjEbVEqv2eVD1oQBrw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Breno Leitao <leitao@debian.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: initialize *locked in memcg1_oom_prepare()
 stub
Message-ID: <aj8XjtMqwAQM2XNd@linux.dev>
References: <20260626-memcg-oom-uninit-locked-v1-1-a00175936b39@debian.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626-memcg-oom-uninit-locked-v1-1-a00175936b39@debian.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:mhocko@suse.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-17361-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 871366D09C9

On Fri, Jun 26, 2026 at 05:43:02AM -0700, Breno Leitao wrote:
> mem_cgroup_oom() passes an uninitialized "locked" to memcg1_oom_prepare()
> and reads it back in memcg1_oom_finish():
> 
> 	bool locked, ret;
> 	...
> 	if (!memcg1_oom_prepare(memcg, &locked))
> 		return false;
> 	ret = mem_cgroup_out_of_memory(memcg, mask, order);
> 	memcg1_oom_finish(memcg, locked);
> 
> This relies on memcg1_oom_prepare() setting *locked whenever it returns
> true.  The CONFIG_MEMCG_V1=y version does, but the stub used when
> CONFIG_MEMCG_V1=n returns true without touching *locked, so
> memcg1_oom_finish() consumes an uninitialized value.

On CONFIG_MEMCG_V1=n, memcg1_oom_finish() is an empty function and I assume
compiler will just remove it completely. Maybe on CONFIG_UBSAN=y kernel,
compiler is not removing memcg1_oom_finish90.

> On a memcg OOM this
> is reported by UBSAN:
> 
>   UBSAN: invalid-load in mm/memcontrol.c:1932:27
>   load of value 0 is not a valid value for type 'bool' (aka '_Bool')
> 
> Initialize *locked to false in the stub; with cgroup v1 compiled out
> there is no OOM lock to take.
> 
> Fixes: e93d4166b40a ("mm: memcg: put cgroup v1-specific code under a config option")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Anyways, this is not a performance critical code path, so this is fine.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>



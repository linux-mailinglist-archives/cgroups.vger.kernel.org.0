Return-Path: <cgroups+bounces-17332-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sfNcH3+MPmohHwkAu9opvQ
	(envelope-from <cgroups+bounces-17332-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 16:28:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7A16CDE5D
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 16:28:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=uHabhH9I;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17332-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17332-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 855AA301DAD9
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B753F660F;
	Fri, 26 Jun 2026 14:24:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0363EFFAE;
	Fri, 26 Jun 2026 14:23:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483841; cv=none; b=lDIF+t8Uf1AXnN89wq6ae1ihIOyTDmzkqui1mqeMVlrbpynkRAvgx432yfa/97ly96OCu/zJ7zsUqEo1o4j38zIEmjMQfD3T9UpXNOAufk28YC6LIrkIsG9EP66v0DA3pRDK6GXuabRNxDr28SyQCeiamiD0lSo8qC37EQWgHoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483841; c=relaxed/simple;
	bh=GnX817I9Dn5YTTh2YnnLw/KGmBvjVUzH+Qx51nCzAQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBykZpl/sF7teXQyUN+5Cejpi2Zo8ZueIjJt2XdWftGB6GJrcVzhKAF6T2zxGkAwBOcLyq4jFGF9dg1FLG7c46wSD/5hxMTNJcGDC9a1FA9hA5uPuHv8SVLQj1jmLEB4GnMfU7aAx7wzFPS/jHm6wAGaNzNt5QmEzmvpq5abi50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uHabhH9I; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GnX817I9Dn5YTTh2YnnLw/KGmBvjVUzH+Qx51nCzAQ4=; b=uHabhH9I316qhbMCfxGzmP2TIC
	9m6XaBd276OkV8dmxvQelKHMdkmB5WsEuAOm/WnOkBD7tUUWiYSKb0PNq1FBebLAG+kE9kZuaebES
	rYXcumoGRLjHBVxJW7vZRmrQxugV23OimSmn+Mts0EraNRGWhvbL6kvjYQ7JwqA+J08atLVM40DAO
	b7V0e/OjI01LNSSUvWWPpU7D6M+7LcDeavirD7KIBSsHlXzrV2CspO3eng8wu6wkfhkeENmXBnpfP
	f6p0ss+g19B8nXdzwEj0LMplm5B3q6BXDUprHTUpPkZ9tZJ4mBzJWRf+BteMwlWIUomyp5HJ1LHlI
	OiO98WRg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd7TE-0041xv-1W;
	Fri, 26 Jun 2026 14:23:52 +0000
Date: Fri, 26 Jun 2026 07:23:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: initialize *locked in memcg1_oom_prepare()
 stub
Message-ID: <aj6LKHe0ONwelBmI@gmail.com>
References: <20260626-memcg-oom-uninit-locked-v1-1-a00175936b39@debian.org>
 <20260626135612.3697893-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626135612.3697893-1-joshua.hahnjy@gmail.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17332-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[leitao@debian.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:joshua.hahnjy@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:mhocko@suse.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE7A16CDE5D

Hello Joshua,

On Fri, Jun 26, 2026 at 06:56:11AM -0700, Joshua Hahn wrote:
> Part of me wonders if we should just initialize locked = false in the
> caller (mem_cgroup_oom) as to not make the stub have side effects,
> but your chnage looks correct and this is a fix so perhaps that is
> not so important.

Nice, your approach seems to be even better than my silly one. I will
wait for further review and respin with your approach.

Thanks,
--breno


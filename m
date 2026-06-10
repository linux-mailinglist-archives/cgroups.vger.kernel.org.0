Return-Path: <cgroups+bounces-16793-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7hSaMqetKGqEIAMAu9opvQ
	(envelope-from <cgroups+bounces-16793-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 02:19:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40122664EEE
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 02:19:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nJP47KD1;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16793-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16793-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EFEE302291A
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 00:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C871A3029;
	Wed, 10 Jun 2026 00:19:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93D14BF92;
	Wed, 10 Jun 2026 00:19:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781050787; cv=none; b=oL4fS4sX+dCrzGMY0uUOS/7V/ns3E0JXC2EV4wkZ1xwJbbX61HUNwKeOYgs/y39KichsziG5xSH94oOP4aTlvaCqs9wnLsUPFUofe8Vqi5WoHWbNBTeBgtW6t8Ni1E541+ZBT60bweeLQ7lie5WLC7tIaKZuLVnTLW5qswvhl9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781050787; c=relaxed/simple;
	bh=rcnhI1gz6rGDI3MpjmQm1cY9tN+OOLMVWD2/8jEkC2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ch7F5YWSfwDRz+QYhh2EK6kkRKG6aON1XQt3MkVbjOtqWf9Gy8bGhvqKeUVBbOVjXCp+AI8yz1kTP3nBwXwBOUh3rhpIbm+7e84J3Q2G0X7GEmoZsgqB6jZ8nZkDRF3tGmSriLDqov91rLX4FxNRQCNMWOGit4TCGWD2Z8U0jeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJP47KD1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C647E1F00893;
	Wed, 10 Jun 2026 00:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781050786;
	bh=J6Qec06ssPjZ8KBpX5bHjrDWkBPXABIpPVj+yD4nsUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nJP47KD1xmj0+wbmArvRXxtJ0OtvRFbtwrAedhff3E+nr1a58A3hIDqqqkqDT2JbT
	 nWpaYSf9JEt9lRb/4xCqkqelm5WcHsEteiw26d3UAo1recuw6shcpx07tO9Z9S5GON
	 0gGNmsfODaPOMYQlArenuEs02ePfW4TfUIbQgekopwCiYj/XodVIsLDtRD3j3CprW3
	 MwoSH997YlEx00d1lBpFzB0Bwg9uLHA/awmtrFqI4880OSAET7y07GguP9dERmkPxb
	 wJWeR0mSFBFH89RYA8exc1D2TGfjGwpWtL+5pnJVKw6YQKOy+/HweqsNih5bK2wnBm
	 cx0VK6Rk5KnjQ==
From: SeongJae Park <sj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	chenridong@huaweicloud.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	rientjes@google.com,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	youngjun.park@lge.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	ziy@nvidia.com
Subject: Re: [PATCH] mm: constify oom_control, scan_control, and alloc_context nodemask
Date: Tue,  9 Jun 2026 17:19:36 -0700
Message-ID: <20260610001937.77371-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609002919.3967782-1-gourry@gourry.net>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16793-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gourry@gourry.net,m:sj@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:kernel-team@meta.com,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:rientjes@google.com,m:chrisl@kernel.org,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:youngjun.park@lge.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:ziy@nvidia.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,vger.kernel.org,meta.com,redhat.com,huaweicloud.com,linux-foundation.org,infradead.org,google.com,suse.com,tencent.com,linux.dev,gmail.com,lge.com,cmpxchg.org,nvidia.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gourry.net:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40122664EEE

On Mon,  8 Jun 2026 20:29:19 -0400 Gregory Price <gourry@gourry.net> wrote:

> The nodemasks in these structures may come from a variety of sources,
> including tasks and cpusets - and should never be modified by any code
> when being passed around inside another context.

Nice work, I also confirmed I can built the kernel with this patch.

> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Tested-by: SeongJae Park <sj@kernel.org>
Acked-by: SeongJae Park <sj@kernel.org>

[...]
>  	/*
>  	 * The memory cgroup that hit its limit and as a result is the
> @@ -6599,7 +6599,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
>   * happens, the page allocator should not consider triggering the OOM killer.
>   */
>  static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
> -					nodemask_t *nodemask)
> +				    const nodemask_t *nodemask)

Seems the above indentation has changed for a rason that I have no clue, and
also introduced a line having both spaces and tabs.

Just thinking loud.


Thanks,
SJ

[...]


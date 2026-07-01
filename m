Return-Path: <cgroups+bounces-17431-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EwRDKMymRWr4DQsAu9opvQ
	(envelope-from <cgroups+bounces-17431-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 01:46:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38F6F2742
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 01:46:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ig7VGz8s;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17431-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17431-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4562230498CE
	for <lists+cgroups@lfdr.de>; Wed,  1 Jul 2026 23:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE1841226E;
	Wed,  1 Jul 2026 23:40:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F643BA249;
	Wed,  1 Jul 2026 23:40:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782949233; cv=none; b=TluDvkbxts/nd32LAOpAlZwkHvzd9Ttfpu043ErMPhEWCeFtCE2T+CPfVxsEjCFYxwRiXIsQxyXBKdvkP+Toz7qEW9kiIDjECUUFYyRebji27IzXpiXJX8HXP33T40stDTMJ6fStKaK1GSm6BCnrNDufxfPPonh1bl1YJ2ybNlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782949233; c=relaxed/simple;
	bh=5yW0zUjhiMac8QG6Y5cF1snznsSu+8ZbO5nXVu64T7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9IhQwrspop6RH3OceZqFlHAvEK0dgMifhqsIiSCtqKdrjSmn+FLXOpNwuD3vbwPCriXNWK5ae30xrX/gPb4FFGyi369G9Yld459VC2urttfoPmnrSSqad7kD0lTK+IJMyK3aSQnfCVgA5YKkYYlpEL//G/pKFtoQ3M6A5jbs5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig7VGz8s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116031F000E9;
	Wed,  1 Jul 2026 23:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782949231;
	bh=+LXAnbfNg10BTks6zYdMXX5zaByxhhgaseK49BiW7Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ig7VGz8svalvd6KD6RGdcmcnMVWWJH+11TDo9WA/JM8QDjNXh4Qd7ji4F9Bs2N5cK
	 geuOCIdC8z0S/eEe7hS9rs7kwYn9ETUMZIFYA+5PrwY2hlVQb//r5SFzi3F38pa5lT
	 b+6wtX5WbZaQuYelFv8V6feHe1JIDW3KYOGpye/k5xujFkEJ43Ccw1OVkm9zzcaV88
	 hAsKIeN4EXj7qfqJMRnw1+7crP9GzH8bQikdYHPnMJ8pRNIpPi0HXzsSCWUqCJMHYZ
	 Qq0keQwNdEDfPqO7KYPlMmuClbX6J1p+6eICrCEKJcWImMTussRT2QgiRd3s7MAfIk
	 VmHs/o5k9/B3Q==
From: SJ Park <sj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Gregory Price <gourry@gourry.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: gfp_types: fix __GFP_ACCOUNT, GFP_KERNEL_ACCOUNT documentation
Date: Wed,  1 Jul 2026 16:40:23 -0700
Message-ID: <20260701234023.85590-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701182102.1586784-1-hannes@cmpxchg.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17431-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:sj@kernel.org,m:akpm@linux-foundation.org,m:gourry@gourry.net,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:david@kernel.org,m:ljs@kernel.org,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,gourry.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C38F6F2742

On Wed,  1 Jul 2026 14:21:02 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Gregory points out that these descriptions are cursed and confusing,
> considering what these flags actually do. This is mostly due to
> historic implementation choices and cgroup1 baggage. Improve the
> description of their actual effects.
> 
> Reported-by: Gregory Price <gourry@gourry.net>

FWIW, checkpatch.pl complains.

    WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report

I think it is completely fine to ignore, though.  Hence FWIW.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]


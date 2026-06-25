Return-Path: <cgroups+bounces-17267-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jYHcIfdxPGpgoAgAu9opvQ
	(envelope-from <cgroups+bounces-17267-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 02:10:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3646C1F17
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 02:10:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h4Qoor1r;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17267-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17267-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5FEC303DACF
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CD472622;
	Thu, 25 Jun 2026 00:10:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7250233993
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 00:10:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346228; cv=none; b=Jzxj9S6G1P2F5Zj+7iINEjGhnX1LNfSB7AbLmFaJSDHIV6d39wjdHZlL58lMw8UYaPBTH7W/r1TrAtB/cnGVOSYQ0gFhJTLmy7D5PliZT74ZBSp9Ss3pDiEiV69vcfmnAWx+8tfJom3kJJUghhh0pewUvWvGSJC68kvAUdbRQWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346228; c=relaxed/simple;
	bh=dqmr+0H1Hj/OSIazHjDf33f0kFDVCoEucarJG+xFJA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8OczpGWchG+7jtZAzwVoZ9Gr9C5hQydhZgX2bsZH22GdzVw9y7PYT5mG5M5+2Ikfmf2RHvdTrUyt0qlNxsVc7tSNG0Y4B0xtAPFuJTnDwW3czDb3X4D+bQA8zbWJyt0yIcKa2gfiMo/6nF977VNdWwXWqaMRApmKHfFd9t7qqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4Qoor1r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894D51F000E9;
	Thu, 25 Jun 2026 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782346227;
	bh=oYYvJ1fa11WriUAAkZ3OTeyNq8CrXyDcpAuJQKIWx9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h4Qoor1rOXUgchWCRCHn6zSHUBT8buGsfoJOrRb7VQzL6lvYkx+LVK3DRIQ9vb63e
	 DRsNpY1jz62QQ7gG+DVARZMw23a/AHoO3n+WejIWZyADMyk9m8qt+4vW318o+aHSxc
	 QXZCMgYgvkThofQp3qiM5XK+4ZZdda8iN06dNoBRqBbaWgQRQfkBXHa1Bfmn93EcNK
	 re14wKrEXF3Y5AfsS1pC/hCgs02RgFrnY6+wuAZCxMc2CF4tNIesY57EERgjPUpJUx
	 /+3jZbApi4wbupzv5rg6Qk6aANHsn7EG1PF8qA8f9uZvBCFooS6E6Dc2o6eZ9JOuWW
	 q6suOjpnVX2XQ==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-kernel@kvger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mm/memcontrol: remove unused for_each_mem_cgroup macro and cleanup
Date: Wed, 24 Jun 2026 17:10:16 -0700
Message-ID: <20260625001018.95717-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624183700.1152742-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sj@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:joshua.hahnjy@gmail.com,m:sj@kernel.org,m:linux-mm@kvack.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@kvger.kernel.org,m:kernel-team@meta.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17267-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE3646C1F17

On Wed, 24 Jun 2026 11:36:59 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> Commit 7e1c0d6f58207 ("memcg: switch lruvec stats to rstat") removed the
> last caller of for_each_mem_cgroup back in 2021, and there have not been
> any new callers since. Remove the macro.
> 
> A comment in mem_cgroup_css_online has also been out of date since 2021,
> when 2bfd36374edd9 ("mm: vmscan: consolidate shrinker_maps handling
> code") open-coded the for_each_mem_cgroup iterator. Update the comment.
> 
> Finally, 99430ab8b804c ("mm: introduce BPF kfuncs to access memcg
> statistics and events") added a second declaration for memcg_events to
> include/linux/memcontrol.h, duplicating the one in mm/memcontrol-v1.h.
> Let's clean that up too.
> 
> No functional changes intended.

Nice cleanup, thank you!

> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]


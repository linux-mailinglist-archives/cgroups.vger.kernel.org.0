Return-Path: <cgroups+bounces-13761-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOGlILuThmnuOwQAu9opvQ
	(envelope-from <cgroups+bounces-13761-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 02:22:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2464F104750
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 02:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CC6D301875C
	for <lists+cgroups@lfdr.de>; Sat,  7 Feb 2026 01:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E81527510B;
	Sat,  7 Feb 2026 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3vXRIxE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBA2265CBE;
	Sat,  7 Feb 2026 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427284; cv=none; b=sc9/WVaAtKj/EEli0/Y7x6QBcRwNmhmXcNBc6yc66LFTRY1Eh2y0lNirFPYwJWq0N1zMCBau0tVH6ZtbizWiGjEA+k8c6rZlgEbjJOKoYvhbuVbjcJgSNnXg7zRvkypZIuhwaZ1czUhqUzj9LrLnhR4USeT8qIEdIKLf30eGR8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427284; c=relaxed/simple;
	bh=3LezWnJCREdR+u+KZoLLda16qsHeRwAq2hqua8icpYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elhfnGELd2/X7BdcP54WR6WbUnxilc18w0ciP66JmwjIDZVTCOG/ZOa6P+aUmG6PWHFL0T9TzQ0Za9NTuBxIwrty0ddfbm+soNI44adpTX1nHaucRywNdJYGeVQNWHoOXUlJUx/wvtLyXs/BUBpvVvY+Hw6BQvTUK8+KJJQsvrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3vXRIxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37092C116C6;
	Sat,  7 Feb 2026 01:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770427283;
	bh=3LezWnJCREdR+u+KZoLLda16qsHeRwAq2hqua8icpYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3vXRIxEpK23GyO+mY6d52E5k2taD8BCE+4O3YDNni+k+sBFyuoUMgr8ra5ibrrtJ
	 hGljfUIJbr952NnmS3sxPS6JxBIJrgD3Qfs+QXEhMnJR6OKeHoPsIdffeXQllAPcQh
	 Z0LkIvHBr4ML8gRRlK3wmdqD80khBT06Vw3NXSMKYDw2Z/isd5nMv2oY0VDuV0llm8
	 UfcP6QfT9aED9bwIIyOyDGENI4vkFicmQsvcQh5hkm/DXnLC0L3GFJ2Mq7lfCKd8YX
	 ftnTl9ivxsChN3MWvH9gV6soMaHw+pftMf05/wytW82F6de4FmSQmS/bsmA+y4bU4E
	 +zQlDgdWwyZBQ==
From: SeongJae Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: zswap: add per-memcg stat for incompressible pages
Date: Fri,  6 Feb 2026 17:21:18 -0800
Message-ID: <20260207012119.69369-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206072220.144008-2-jiayuan.chen@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,shopee.com,gmail.com,cmpxchg.org,suse.com,lwn.net,linux.dev,linux-foundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13761-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email,linux.dev:email]
X-Rspamd-Queue-Id: 2464F104750
X-Rspamd-Action: no action

On Fri,  6 Feb 2026 15:22:15 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> The global zswap_stored_incompressible_pages counter was added in commit
> dca4437a5861 ("mm/zswap: store <PAGE_SIZE compression failed page as-is")
> to track how many pages are stored in raw (uncompressed) form in zswap.
> However, in containerized environments, knowing which cgroup is
> contributing incompressible pages is essential for effective resource
> management [1].
> 
> Add a new memcg stat 'zswap_incomp' to track incompressible pages per
> cgroup. This helps administrators and orchestrators to:
> 
> 1. Identify workloads that produce incompressible data (e.g., encrypted
>    data, already-compressed media, random data) and may not benefit from
>    zswap.
> 
> 2. Make informed decisions about workload placement - moving
>    incompressible workloads to nodes with larger swap backing devices
>    rather than relying on zswap.
> 
> 3. Debug zswap efficiency issues at the cgroup level without needing to
>    correlate global stats with individual cgroups.
> 
> While the compression ratio can be estimated from existing stats
> (zswap / zswapped * PAGE_SIZE), this doesn't distinguish between
> "uniformly poor compression" and "a few completely incompressible pages
> mixed with highly compressible ones". The zswap_incomp stat provides
> direct visibility into the latter case.

Sounds like a useful new stat, thank you for making this!

> 
> [1]: https://lore.kernel.org/linux-mm/CAF8kJuONDFj4NAksaR4j_WyDbNwNGYLmTe-o76rqU17La=nkOw@mail.gmail.com/
> Acked-by: Nhat Pham <nphamcs@gmail.com>

Nit.  It would look better to have one line before tags lines, or use 'Link:'
tag with '# [1]' like trailing comment for the link.

> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]


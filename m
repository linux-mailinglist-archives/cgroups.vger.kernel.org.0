Return-Path: <cgroups+bounces-15954-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N/pMmA+BmqmggIAu9opvQ
	(envelope-from <cgroups+bounces-15954-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 23:28:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EB15470BD
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 23:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 465843038ACD
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 21:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86083BF696;
	Thu, 14 May 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU9vmmce"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6B25B094
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794023; cv=none; b=nbEGoW5NGr49Jk9+TqD7yPLOnfPzZcISJNN4K2mE9ygYQ73hs7jGhpl4ikSHCeeYcRnqG+vKwzTMwAIm1fS/DRatK8797NYTXr+ZqYjY01auH/f1jpljrEGa2gW8giQTJBWLqXZ//lUt7tRMJ3LBRVR8jStdhDBFgJAB2dvDtH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794023; c=relaxed/simple;
	bh=ICqq6yT6L0OzuLwOLkwbzZUQ1wutvXU4NnOmK1n5JFc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=EeOPbVi6zPInoONpiXtL7YQuQy9e565S4wluhbmDQHlm42q6drv5BueeCvvWFjxXoJ0/KcTDc3uYtT62vPqqbw9ipiY0kaT0tZeyQDmRPmxCchybVPMdMk0yiguTO96bfrwJL3WgzMCFZwMk+ERWvleCTfoh6uI64XoJ/zEAPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU9vmmce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331EDC2BCB3;
	Thu, 14 May 2026 21:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778794023;
	bh=ICqq6yT6L0OzuLwOLkwbzZUQ1wutvXU4NnOmK1n5JFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mU9vmmcerkvEbDgsSovMmNra+bNI261jPWBtQB43Zd1kdXrHzqXRWPl/XzbbRO8qc
	 g4dWlQeIequua16/Ze9P4juMNC5bodpVgwfbPFeVmYKt9Ekvw1UFAcx18Y6v72NMbR
	 L7BKZbULL3MVofMLjMFz+PVomDljSNh7FyJ2z2rMY9uFNvJVbFuC3axNd2fnev2m6g
	 /Hmzok1BERHkyQOwZdestfS4TJ3Yd/bZdf4zr8FBDyEKvvNP3CCFARH/8zEraE7NbM
	 PaImAarP1k4j8O6odAcHNykmGW9TG4UaTGHjGGE/yJwdoyzDgdgpJjw1vmQsN8gnOO
	 s8kRUxQlCuQew==
Date: Thu, 14 May 2026 11:27:02 -1000
Message-ID: <895a3faf86b3f9661fbcae7a8a91f318@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 0/4] cgroup/rdma: add rdma.peak and rdma.events[.local]
In-Reply-To: <20260514065034.387197-1-cuitao@kylinos.cn>
References: <20260514065034.387197-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 55EB15470BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15954-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rdma.events:url]
X-Rspamd-Action: no action

Hello,

> Tao Cui (4):
>   cgroup/rdma: add rdma.peak for per-device peak usage tracking
>   cgroup/rdma: add rdma.events to track resource limit exhaustion
>   cgroup/rdma: add rdma.events.local for per-cgroup allocation failure
>     attribution
>   cgroup/rdma: document rdma.peak, rdma.events and rdma.events.local

Applied 1-4 to cgroup/for-7.2.

One follow-up: the new event counters use READ_ONCE() on reads but plain
++ on writes, and all accesses are under rdmacg_mutex. Please send a
follow-up patch dropping the READ_ONCE()s.

Thanks.

--
tejun


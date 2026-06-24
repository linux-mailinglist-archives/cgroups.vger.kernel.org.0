Return-Path: <cgroups+bounces-17257-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bqjJOSE5PGrglQgAu9opvQ
	(envelope-from <cgroups+bounces-17257-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 22:08:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D2D6C12D5
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 22:08:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="O/KTWK0/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17257-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17257-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 902D3302880B
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 20:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86A0383C7C;
	Wed, 24 Jun 2026 20:07:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3FC3033CC;
	Wed, 24 Jun 2026 20:07:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331677; cv=none; b=L+57Giy7pfk6CkSNFzZJKV0Y/vuqoPanLbVqsBduNhPr6ugzdVlXiwecM85S387hWcBXQtoYgH1KYJn9grzxqkivMHosn7DiW/cy9mEcKrK4PLk36WsiVj4LhiJDhU32F1lICSeVEaw1hWKOEp1ZS/Iya3jXBes0TY4XZGiYVbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331677; c=relaxed/simple;
	bh=MvdxAoJ7YexdWzyjieZxC0ZqQhclQ8yHQTQhbVrniGg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qxxtiBDN1tSXdKeGg0UoDQALT2ICo6HMd2U6OgWifLnvn6rxOT+NKLzJficqAMuHT2EFk3Ctk2TbQau9gbG3Cmkh9t/8ECVJsrtBQXuUWwOEnk/pY0nRj298g7QJ6XvkfWLp6ZIjwXsBYG4vGGFNUT+VnLyeeMJJvfF3FbJDcf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/KTWK0/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE341F000E9;
	Wed, 24 Jun 2026 20:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782331676;
	bh=MvdxAoJ7YexdWzyjieZxC0ZqQhclQ8yHQTQhbVrniGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O/KTWK0/vfMmCWHBKZ383cCO4oBFSbI516hL2/lOepxH8pj71PnQKFdqZwg3DnXgp
	 qUmlUWtx+vbuWa2u9sXyWfWEkSYPKOpXadD+bKRg7rVI1LdMIm1I3RwXk9oghc9RCe
	 nIqG5v4bqfbjlP7WG3e/uTv8P0BeE8OxKcuXdAWmJGHab/8CIlL9oSqeSlX1Jb0aQp
	 LNHGtRwEHka/75oZoCCgutlYct7RXLHjGPp6sRAKIinNQ2hKF9gpIVJlxZcbXXLNil
	 xaIpAXf5Wz6i4lX6dDey10XVs+a8/NYw5Natj06ddj874Nje3FURfOmcFXRI16QPrp
	 A22245zAVTwgA==
Date: Wed, 24 Jun 2026 10:07:55 -1000
Message-ID: <0130538fffad5f2457c422133435bd60@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Doehyun Baek <doehyunbaek@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Yosry Ahmed <yosry@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>,
 cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/admin-guide/cgroup-v2: fix memory.stat doc details
In-Reply-To: <20260620122751.388770-1-doehyunbaek@gmail.com>
References: <20260620122751.388770-1-doehyunbaek@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-17257-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:doehyunbaek@gmail.com,m:corbet@lwn.net,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:akpm@linux-foundation.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:yosry@kernel.org,m:nphamcs@gmail.com,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[lwn.net,cmpxchg.org,suse.com,linux-foundation.org,linux.dev,kernel.org,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1D2D6C12D5

Applied to cgroup/for-7.2-fixes.

Thanks.

--
tejun


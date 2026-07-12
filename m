Return-Path: <cgroups+bounces-17675-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fVJ4C87TU2pofQMAu9opvQ
	(envelope-from <cgroups+bounces-17675-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 19:50:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D4274587F
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 19:50:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AhG9PMIy;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17675-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17675-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D81E1300D854
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 17:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9672435DA43;
	Sun, 12 Jul 2026 17:49:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722A1FECBA;
	Sun, 12 Jul 2026 17:49:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878591; cv=none; b=MdHszNW0EFT6i+Ztd8qNAUIljlQ6oKfd0v/jBPySjEGUBXjWupFGRfRl6wfdUZysYO7Z8/RVOcZE4yROYjSgNG3X4yMLbJJVcVZBz355DQn9g1lyX5fp5NCZszH+Wi4ZCjd7RwpqUo6wg4hAiADR1/JFaS2KB97838u/BDQS27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878591; c=relaxed/simple;
	bh=IBoTameHtApVct8Gcw/wRYeJ8o+Yi+AraZc0AeVgRg4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=tiZ5k7BX40X75qT4J8/1CTmOwpwLY8BCyKUBiGDYO0r34qek4oXtWP0Dg9UL/7CDDx/Kzk8tdrudmII3me2Pv0nPc/ME68kj2JlESCcb+BM/1Inx5MqlwT7lHcZEqHq+r2GoaAQqF2kf8kNlooko+KvKiErkw+MYK0seZ4Rt1Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhG9PMIy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C81E1F000E9;
	Sun, 12 Jul 2026 17:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783878590;
	bh=ZbTJLyMBEKn4K0UBdEH2PwNeOUsKZYezLVl/CAZSf1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AhG9PMIyPP2F5X3HHartainVwqGpzBd6VT75jmn9E4vkVDMKkTPQOYlIFQgnyUiex
	 J3tS5BNFNu/0X5kUXMHX2nsti3m41opGzGqrEKxwLnNGcOB1Mlp1fW3FBw/Cj5BIuI
	 yKCOft9APs3DmCi0DAsfUTXVXI98PzAr62njXDZsyt6OpNNbkRdvo+Dhe9DMLrEFAA
	 dICO7VXJ1zYtWuAhjWc5ZeUbj01AO5KH3/CHjm41dcCWfwF87K+BMLXEwgKk8vksT0
	 g28bXWiH5SPMTpSq0L6tC0W6gh/C/ldY/PCi/Ammqkd6C6FVfiYeOyACKqfRv4nMeZ
	 CODBcKc7hq9yw==
Date: Sun, 12 Jul 2026 07:49:49 -1000
Message-ID: <4e252ec5766ec86878fc6cc33e6efc7e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	sched-ext@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [PATCH cgroup/for-7.2-fixes] cgroup: Create the psimon kthread
 outside of cgroup_mutex
In-Reply-To: <20260710134945-psimon-fix-tj@kernel.org>
References: <20260710100441.2653477-1-matt@readmodwrite.com>
 <20260710134945-psimon-fix-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17675-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matt@readmodwrite.com,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:hannes@cmpxchg.org,m:surenb@google.com,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:mfleming@cloudflare.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[manifault.com,nvidia.com,igalia.com,cmpxchg.org,google.com,infradead.org,qq.com,huaweicloud.com,cloudflare.com,lists.linux.dev,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3D4274587F

Hello,

Superseded by the v2 posting, now a two patch series with an additional
rtpoll_timer UAF fix:

  https://lore.kernel.org/r/20260712174619.3553231-1-tj@kernel.org

Thanks.

--
tejun


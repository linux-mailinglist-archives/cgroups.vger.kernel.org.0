Return-Path: <cgroups+bounces-16046-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAL8BkpqC2qnHAUAu9opvQ
	(envelope-from <cgroups+bounces-16046-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 21:36:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D22572F17
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 21:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A1F8302989F
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0939023B;
	Mon, 18 May 2026 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHUbWISf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D91DB13A;
	Mon, 18 May 2026 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132998; cv=none; b=gXww8pimhU4u57iSdZCtJMp+yHILEPlxtj61B+8kKFEvfOdaIYDyY4Vt7buKWCWDRb7l9q81lbpm1r18yg6aOYIJ3Z9dNnE7M8W43lB0JXhfgurE061X4f0fc9Xy/fs+IqUxCKo+YFBHfkuzRTJEtNjxtw0nG0BpK7PCi+IIR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132998; c=relaxed/simple;
	bh=Wi4BvHbnLogHwDnFAOY65k7rUtfMvJIPCaPQGLK8bGM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qfHNUpXLhMsFltuTAOjvBsFlBTq3V5qOqao2fYmOPdXcKkI528hfdN4GiMogGZbUyM/8rws44/DaEm9VN+BIbmsoEATFqXgxal5X5daP3dCOktelAORQgwfi06hhyVNiFl3X5jVqPeAZ0XUsf8j2W7xsNlgfddENf7I8OVFUErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHUbWISf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D39DC2BCC9;
	Mon, 18 May 2026 19:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132997;
	bh=Wi4BvHbnLogHwDnFAOY65k7rUtfMvJIPCaPQGLK8bGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nHUbWISfDDPMmeTskxlUgDj20zlZf5ueVVBgVCkkys/td237mdFYzqbo+3e2bKrP7
	 +I6JaY27VuRSK6VaJc0oAH6tC29ivAtndPbkgjI9eV967MvzipLcFuj5JLNgXhh+mW
	 CZ9C1ihR87awMWUbC6RDLrjiDLt5NPSmseTMxVMXVSTL7K32VAn/RxvxamnBkoqy17
	 a7XZvINC1MAYhvNAVPTkjob5f58PPVKUsCR+hZxb628znZfT5lp1eAXkpEt657oTLn
	 gkhWX7RSTVep0I5Ayg9VVCl2sTYfMQeM69J2pVwjQPO24a8jxhS+YAw96uwf09snN5
	 AwY37XiJh6aKA==
Date: Mon, 18 May 2026 09:36:36 -1000
Message-ID: <64f59b64664f769661a8b8cd587c85f8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qing Ming <a0yami@mailbox.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutný <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/rstat: validate cpu before
 css_rstat_cpu() access
In-Reply-To: <20260516070849.106141-1-a0yami@mailbox.org>
References: <20260515122952.59209-1-a0yami@mailbox.org>
 <20260516070849.106141-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16046-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 77D22572F17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

> Qing Ming (1):
>   cgroup/rstat: validate cpu before css_rstat_cpu() access

Applied to cgroup/for-7.1-fixes.

In hindsight, we should have added a separate kfunc wrapper from the
start instead of tagging css_rstat_updated() with __bpf_kfunc directly,
which would have avoided the rename. Oh well, it is what it is.

Thanks.

--
tejun


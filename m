Return-Path: <cgroups+bounces-17256-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kCoANn80PGoGlQgAu9opvQ
	(envelope-from <cgroups+bounces-17256-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 21:48:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0256C1189
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 21:48:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="nRt6/X0T";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17256-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17256-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 952233038ACE
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 19:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED02A3CAE8F;
	Wed, 24 Jun 2026 19:47:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA7D336EC5;
	Wed, 24 Jun 2026 19:47:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330455; cv=none; b=R5pQltukny1g6Mha11VcCvmC/kUqHQuQPf8Emii7MkiL3xMH5Rr3QjpA9iYjx+TjCvoTfNFJe7aiWiOpFYKwmH5nEOAM5gmMg2jXUzTN/8Uj6ZC+S3oZE0FU6QU/ozDuLu8p3yEmNCSHdse+eiJAS6+zNagwaZjznmMaeC/TuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330455; c=relaxed/simple;
	bh=3WU9kQVmuCWNzR3Xk8fGyhiMilXuJNpHAz6XqXQsiVs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=PG34MZXLWljI58L7HhoFtp0rhPQZp6MZi1U+SAR3WcT0328nz4L0+F3rBFUCMKwxK6uv+yF61ENIEoxcbWwDmctnQ4Wv2anWfB3FWtfjRvd2H+TN5H+BjioHv99coBPx+jnKHQiiIVvOOUnb8gfJWIC9tOhWzG8FT9cKLmNYH/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRt6/X0T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D9B1F000E9;
	Wed, 24 Jun 2026 19:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782330454;
	bh=IPp9y2W1h8wIV6L1aNRHeDOUJv4cSkPKHzb2+Tuorxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nRt6/X0TJjKwWm+RJ+HBbSI8se4QAEcBiIoOxpZJp5a52BG3VAG+OoL1Vce1bySi+
	 iWLgYsCWA2Y7WdADe20h01vu4OKPRNsCOFeMCHV9HPk/IStGGC5egixOE2P23GbSvs
	 +iczac/ZTGbGOqRk6KD8FMusvQnAEuuLNPVKFEJ/j34FOHvCAgJJm4+FwCArVMfxsq
	 CgxRR6/8Gw0P6w6TjtAM/9Aah/cfAFtfCMITCAYpKtkIZRI5SqQ9j6h7wUTNi9jK9R
	 nXDDvCdIz0kflS34AnpprDmBMxndExLsASrj6XJsshQXoLlhwmEePCtxhT/Y8MRY5T
	 Qba2Se0Copv5w==
Date: Wed, 24 Jun 2026 09:47:33 -1000
Message-ID: <038bfbbc34714676b7a672b7f748aee4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 Ridong Chen <ridong.chen@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/2] cgroup/cpuset: Miscellaneous fixes and cleanups
In-Reply-To: <20260623230413.1984188-1-longman@redhat.com>
References: <20260623230413.1984188-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17256-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:ridong.chen@linux.dev,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B0256C1189

> Waiman Long (2):
>   cgroup/cpuset: Avoid unnecessary cpus & mems update in
>     cpuset_hotplug_update_tasks()
>   cgroup/cpuset: Rebind/migrate mm only for threadgroup leader in
>     cpuset_update_tasks_nodemask()

Applied 1-2 to cgroup/for-7.3. I folded in a few minor fixups: a
changelog typo, the compute_effective_nodemask() kerneldoc parameter
name (new_cpus to new_mems), and the comment and doc grammar nits Manuel
noted. Also added Ridong's Reviewed-by to patch 1.

Thanks.

--
tejun


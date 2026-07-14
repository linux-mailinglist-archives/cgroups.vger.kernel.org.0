Return-Path: <cgroups+bounces-17807-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SrjHL8WzVmp2AQEAu9opvQ
	(envelope-from <cgroups+bounces-17807-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 00:10:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F5A75925D
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 00:10:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DqaY2kZl;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17807-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17807-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF896303FAD1
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 22:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2F418A3D;
	Tue, 14 Jul 2026 22:09:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C7F32B108;
	Tue, 14 Jul 2026 22:09:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066968; cv=none; b=iX5Vd7KMRo8cj+/ODAE9jR++E2Fbk71k/s+DBPx0cITQ6ttKSLrorZE+JpaR3qiR+3qN0n7qj4kcP48SOvKD+Z/xqRn+afauLi5lgvPmJWBB2sEoFqlMWymcsODo64S0qriR0UZutX58t1D6KaOOWrYmMoXzdsWxoRqQ1wqztSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066968; c=relaxed/simple;
	bh=WFnyeTa3mJh1SlKnasalPxh3NphMILx9MnorwnAMzW4=;
	h=Date:Message-ID:To:Cc:From:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZHrfRxFedbOoH6O2JZ/wpzSgkF9Y1S/5z6IXzXZW3rZWlC3hFiXo14fB3DorgswzomQULpWNA9Umff/Kru5PD59dMfyxIuuDzMOqzj0CMRFTjNyY6rae9D3rhEB3b18tHWXVpYn6qgQROhYmMe44g5R8TShmFLZWRm2X5iT4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqaY2kZl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74161F000E9;
	Tue, 14 Jul 2026 22:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066967;
	bh=Zxgrol/rhLCcz5WkQn7r9aXEdOI37ZHRmg+Zpz3syog=;
	h=Date:To:Cc:From:Subject:In-Reply-To:References;
	b=DqaY2kZlX5oAx64LWOZgEdRs5Dq2aiuVTR6WQzzOG/yKKWVp8QcAWgrP7iQBObT0C
	 9h1dCZeqbK6q/BS9oc/+8wbuUIBkusAHWQ9Ti7abKAATR/H6RO4Phjh29T9dTDl+ab
	 dFslzRnWKlNKtHntSdTSwvp28Znc+b66oOubrJsnPGbX3qSOkMPsZdo8dQ+Nx2glM9
	 DL8sD6apqZeteG5j6/wQ0hN/yItTa28D+DvrNg7nnAtNTpQMa9K81YUHFAtis2JZZw
	 UdACJXvz33+WTeCahoDsSt00czQCt3UiSInwJ+avqYUjsnqj0FU4ol3BI7G/LoP7ps
	 bLDgv+1ryLMew==
Date: Tue, 14 Jul 2026 12:09:26 -1000
Message-ID: <4ae04b8055b7145e182380a46f92c26e@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] selftests/cgroup: Fix intermittent test_cgfreezer_ptrace test failures
In-Reply-To: <20260714183125.521650-1-longman@redhat.com>
References: <20260714183125.521650-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17807-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10F5A75925D

Hello, Waiman.

> +	usleep(1000);
>  	if (cg_check_frozen(cgroup, true))
>  		goto cleanup;

A fixed 1ms sleep only hides the race. On a loaded machine or a slow arch
(you mention ppc64) the refreeze can take longer than 1ms, and the test
reads the unfrozen state and fails anyway.

The freezer test already has a way to wait for this properly.
cg_prepare_for_wait() sets up an inotify watch on cgroup.events and
cg_wait_for() blocks until it changes. cg_enter_and_wait_for_frozen() shows
the pattern: loop cg_wait_for() then cg_check_frozen(). The cgroup always
ends up frozen, so looping until cg_check_frozen() reports frozen is
reliable and doesn't depend on timing.

Can you respin using that instead of usleep()?

Also, temporaily -> temporarily, in both the changelog and the comment.

Thanks.

-- 
tejun


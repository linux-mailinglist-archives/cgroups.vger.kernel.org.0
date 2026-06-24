Return-Path: <cgroups+bounces-17259-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id db3aOg8/PGqblggAu9opvQ
	(envelope-from <cgroups+bounces-17259-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 22:33:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 791BE6C1348
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 22:33:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n12ytX9b;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17259-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17259-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 904CB302F4E0
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 20:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85DE3AB285;
	Wed, 24 Jun 2026 20:33:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7A4308F26;
	Wed, 24 Jun 2026 20:33:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333195; cv=none; b=jKd9i1gBiwgMYlwOOPAIuB3hlmZEoCjVI5couTylbzPEqPo0ahstFTC2Thk1LWX3jC/4zhfgS9uEQRRSBsM2rP2XnWYBfGKciPNaeB2mSJy0DZAJcpuWBcy6PmanvRVNJBG1MbP+4y7d0NfBzFE3avNJrpjFgelHETgHQ7Cd9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333195; c=relaxed/simple;
	bh=quBsAGvcYsSCgnkwdbNoJkYFKOEC802izVMjR3799/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bn3wreEzQYLWDtxveGUmmioV5u1mvWTroe4cmkrzKaMvpnKjaBw//WOMJ86l5P+IEiCjYu1dW4p1YW7SrNGaPpbLS300m73iRt6ACzLoPiTGYntX3JFdsTvnbrQBv+3Z5DZvf7IPUrYXPG0pr6hrnxpwimnYQqOKDgfzsM7RzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n12ytX9b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6041F000E9;
	Wed, 24 Jun 2026 20:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782333194;
	bh=sNbg4tuYvmM3+Ihbku9IYrXjnBwh4AlGNJ0Hy7sTAPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=n12ytX9bp7B7eI5XhPx5eIpZyFQBjhoN9SxthB7R+cVXD+8iRiTqgmtRKLhu5HQwR
	 ILrBypL56rtKgZ0h0CkPGgcBSk+PoaOuFaNF+5NmG7piFQ8j7cLl/a8wMUOIIR24IQ
	 mhB7PwPrxUVmbTl8WdQ6XL4zpeDjXWZZcMLbWtT22Yy29vThSv1BxGSJexUfDJK3H/
	 uhzKGgGUtbgNdXdiaXBlM6qbwRN0QyWfPGUmvfUFY04Nkz6EJEqfcne4v0V9rvs28V
	 lS27wM4uRi88V7upkRFh/+K5k1FGnV4j3yALm+A0Gdh8zDHD4gZYkzDO9FcRNY1p23
	 duMatNWv8327g==
From: Tejun Heo <tj@kernel.org>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Guopeng Zhang <zhangguopeng@kylinos.cn>, Tao Cui <cui.tao@linux.dev>
Subject: Re: [PATCH] cgroup: Use READ_ONCE() for task->flags in task_css_set_check()
In-Reply-To: <20260623022946.525885-1-guopeng.zhang@linux.dev>
References: <20260623022946.525885-1-guopeng.zhang@linux.dev>
Message-Id: <20260624202644.877fae40488c@kernel.org>
Date: Wed, 24 Jun 2026 10:26:44 -1000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17259-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:guopeng.zhang@linux.dev,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,m:cui.tao@linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 791BE6C1348

On Tue, Jun 23, 2026 at 10:29:46AM +0800, Guopeng Zhang wrote:
> -		((task)->flags & PF_EXITING) || (__c))
> +		(READ_ONCE((task)->flags) & PF_EXITING) || (__c))

This only feeds the CONFIG_PROVE_RCU lockdep predicate, so it's a
diagnostic-only read. tools/memory-model/Documentation/access-marking.txt
recommends data_race() over READ_ONCE() for those:

	(data_race((task)->flags) & PF_EXITING) || (__c))

Please update the changelog to match.

Thanks.


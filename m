Return-Path: <cgroups+bounces-17300-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cf7jM4+bPWoC4wgAu9opvQ
	(envelope-from <cgroups+bounces-17300-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 23:20:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 561146C8AFE
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 23:20:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AeaCb3Ik;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17300-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17300-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50A223047E65
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84FC315793;
	Thu, 25 Jun 2026 21:20:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0102FB969;
	Thu, 25 Jun 2026 21:20:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782422408; cv=none; b=qGuAzK/dQCRVPXDDfXrujY8Fmwp7ChAO406XrALOLDMQgTgslexZrNf3zJkhJ0KWFxTpHrbHmnjLWq+wJmfffNDGfW8ZRG6C2c75CZ7LxU0bU6UvTucOkA2DIeRzCQ0iIVrlAIBCDyPYzSevIQZIY+WXPD42iJejd6qKathw2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782422408; c=relaxed/simple;
	bh=vls/tKxHm+vtJXpLSCupj9CJuOfDIMd53MxJyoF4900=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=oPmcTGiMBn29cERlOYRbHWSnq1T0gTu9ICd4PJ75C6nAqWzRzSHp599mynq5jLE09HRdMT//UkQRJTWzQrs8s/46K4fc/kXhNxzxdqbKvF+HhrTo9CZo2ftLNJ55Y4n3crDF1eFljULU0ZTPsUwcF2NbnU80Zv/eSWGSnsji0Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeaCb3Ik; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601D41F000E9;
	Thu, 25 Jun 2026 21:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782422407;
	bh=vls/tKxHm+vtJXpLSCupj9CJuOfDIMd53MxJyoF4900=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AeaCb3IkItCRXGWBcH9YwLD/KxQFytL/hPasOQa70GOanIGGyPFzhCesbS3nOkbns
	 yQ6yodMsOKmnv6q546Oztuagu+By7H1s48qu9xLLlFu/5fOsLW7Oro/m5DJILP5sWb
	 oDnqEEMt4HZThgUvYLYkYwjWHLohfLuhGyHrZk0ehZV8gupIHXkMh4/5ApceogcQOi
	 Cnb8qubRerAcH5VkX0Q9DxubOqgeQH0fUPdEgvL+DjwCYUav3TG092UiXq/c0H7hIi
	 6Ic54kP7tJaDJgaMgnAGeifX5v7+0LP+qUiU01pYtE8/axJr1dOa1QOy92wvfRzuI5
	 elaOnJZI4rOYQ==
Date: Thu, 25 Jun 2026 11:20:06 -1000
Message-ID: <1a3026eaf111b5d4761ec941d031e48b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH v2] cgroup: Use data_race() for task->flags in
 task_css_set_check()
In-Reply-To: <20260625013944.253318-1-guopeng.zhang@linux.dev>
References: <20260625013944.253318-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17300-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:guopeng.zhang@linux.dev,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 561146C8AFE

Hello,

On Thu, Jun 25, 2026 at 09:39:44AM +0800, Guopeng Zhang wrote:
> task_css_set_check() uses rcu_dereference_check() to verify that
> task->cgroups can be dereferenced. One accepted condition is that the
> task is already exiting, tested by checking PF_EXITING in task->flags.

Applied to cgroup/for-7.3.

Thanks.

--
tejun


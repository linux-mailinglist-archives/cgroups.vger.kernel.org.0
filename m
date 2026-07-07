Return-Path: <cgroups+bounces-17571-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tQaKDzmBTWos1QEAu9opvQ
	(envelope-from <cgroups+bounces-17571-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 00:44:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C03720352
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 00:44:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WPqQ7t4E;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17571-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17571-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 470FB3084635
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 22:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9774B494A0C;
	Tue,  7 Jul 2026 22:30:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676C480DC3;
	Tue,  7 Jul 2026 22:30:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463432; cv=none; b=aJSnVZk9C8uMn2yiQ7q3nVHDPz81KbW/YMqfeQjXsRKsfq6kogNtubMrki0uG0afuHJ0knVIhuxHAUBaiF4tfY2zZzxej1vJv18imaU/AxwqQ6ADxGWHlicQX5LPdaChMYpyEHSJnqJNwV+xNzBK/frHOIC6hwIKEGpfJJmKaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463432; c=relaxed/simple;
	bh=IGeK+fyE4j0wCGDvO6onUm1VTlMWGJhVl84IsAA4kuo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=AjQ8f7LxEDkGrygs3Hkwy3ZIctJH/hY0OxeBWnGVxZJL1SqsvFDUcPQqmwhaFUWVqKtAnI9sscFC7sjW8xcOqMBbkz5XRE+ByLtj3v+B4h+dGoPmRxsyo/r+d5o/cvxszklri93hZoxnffjFoEpS4pNdbAHqy98Nag49GhTTils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPqQ7t4E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091981F000E9;
	Tue,  7 Jul 2026 22:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783463431;
	bh=IGeK+fyE4j0wCGDvO6onUm1VTlMWGJhVl84IsAA4kuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WPqQ7t4ESnJ0OWSou9XVyo6TRQgNqvOpj6EwZenNAkFmZXHGURYNHoPnwy1YZxKLN
	 pazKE1g4swX0Qo1QLFgKTwtobpEA++4+5nmIuWw6547viDqCcWlacRpg/w9HLvmjA9
	 g72svX0577bOj9auWbUOitkXNQpo1i8TRxU/0pZDgYoWfKtvJRIrzuXZIFStV8JeEK
	 ZoT1BYLyAwLZgyRtNe4D97rLk2jCdlu/aY1vG0QNJYSCX8dFF/ZB/WJKy7DgdDblXu
	 WNmrzbnyenh+8Y8GW1oyLVnLxeMr39RbeiMDRpGe05KT8SAiVnc7PViQeiIxEhQpm8
	 7iRrijEsHfNSg==
Date: Tue, 07 Jul 2026 12:30:30 -1000
Message-ID: <f68eae4eb38e965331a0aa9306cce034@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Koutný <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Guopeng Zhang <zhangguopeng@kylinos.cn>, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 0/3] Docs/admin-guide/cgroup: update controller interface docs
In-Reply-To: <20260707102148.692250-1-guopeng.zhang@linux.dev>
References: <20260707102148.692250-1-guopeng.zhang@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-17571-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:guopeng.zhang@linux.dev,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,m:cuitao@kylinos.cn,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2C03720352

On Tue, Jul 07, 2026 at 06:21:45PM +0800, Guopeng Zhang wrote:
> This small series updates cgroup controller documentation to match the
> interfaces exposed by the current code.

Applied 1-3 to cgroup/for-7.2-fixes.

Thanks.

--
tejun


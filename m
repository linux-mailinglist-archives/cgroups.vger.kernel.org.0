Return-Path: <cgroups+bounces-17379-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mDG2B6/DQmr5AwoAu9opvQ
	(envelope-from <cgroups+bounces-17379-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 21:12:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A200F6DE396
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 21:12:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YVDJShgk;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17379-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17379-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A263E30098B4
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 19:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8183ADB8D;
	Mon, 29 Jun 2026 19:12:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135839768D;
	Mon, 29 Jun 2026 19:12:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760361; cv=none; b=VtWH8hsg3oYAEIO+DIVrVHOyWipqOwIGJqBcNNZwbSwtvuKtJjsN5ljKWp5E0vPb09Ogf314t7JvXmjHUDG5/az2BsFTbjgWOngMoUlMPME6IqcAqgjaayYplXKDrAvIpMJvvRcukqaRhcHF72wcSpvvHF2lQRInXK3U1U2jFok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760361; c=relaxed/simple;
	bh=IgkyJKi60WXCmh17XYm05cccG/GD8qQaAxSY1ZxWgM8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date; b=MpAP8OflRT7oc8/QUVY/zbXzb4gXSrzxCsrhTYHTcJXsPVitXdin+G0a7fInbO/dLXINfBj2E6Zmbm8GygUOCFFloBakx4yuIXvv/6xSYiU/j5C9yQUebRCWH0gFnd5FQw4hIJ6QMyWSW5bTAL1D2RHhOM5ix6Y2lgKjXpxBxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVDJShgk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05ED1F00A3E;
	Mon, 29 Jun 2026 19:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782760360;
	bh=IgkyJKi60WXCmh17XYm05cccG/GD8qQaAxSY1ZxWgM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YVDJShgkl9W7Qs4eDRHslRHnUeWnBlD6YYUGobJ3aUNjsTlrvLMX4Sb3D5ESZfnqq
	 zynaP+5QnPQKJ2hme9z0xc7W9NaAhzZCm1XXyKjdBil4SEjrRl+NIaHuPsgxz6VbzF
	 vQjc6wYNTdKueojtx25AfSsPJhnmLk6xqRlGdIx7XtBm8Ml4t4TibYjlTP5kAXzkLp
	 ywOIDLOdFqkvbmfW7yj9STYDJDl+Hq2KR9+OqxNV5XKG5B8E61vEjZjO6gWP9CDV8q
	 rIrJsgFvV9ZUMlEtn2sUB0nSo9WGFDo5jafDPGA/GekrROGRZWkjoK5n8sYnO8JVhv
	 ViMxKgtmgzUbg==
Message-ID: <d1d34d4bdda5608c13c89d2c7a0a9671@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Joe Simmons-Talbott <joest@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutný <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	cui.tao@linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	nphamcs@gmail.com,
	Waiman Long <longman@redhat.com>,
	li.wang@linux.dev,
	sebastianchlad@gmail.com,
	zhangguopeng@kylinos.cn,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] selftests/cgroup: Adjust cpu test duration based on HZ
In-Reply-To: <20260626202925.1527524-1-joest@redhat.com>
References: <20260626202925.1527524-1-joest@redhat.com>
Date: Mon, 29 Jun 2026 08:55:12 -1000
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17379-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joest@redhat.com,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cui.tao@linux.dev,m:akpm@linux-foundation.org,m:nphamcs@gmail.com,m:longman@redhat.com,m:li.wang@linux.dev,m:sebastianchlad@gmail.com,m:zhangguopeng@kylinos.cn,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[cmpxchg.org,suse.com,kernel.org,linux.dev,linux-foundation.org,gmail.com,redhat.com,kylinos.cn,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A200F6DE396

Hello,

Applied to cgroup/for-7.3.

Thanks.

--
tejun


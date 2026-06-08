Return-Path: <cgroups+bounces-16740-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zO6JFaf0JmrTogIAu9opvQ
	(envelope-from <cgroups+bounces-16740-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 18:58:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE523659000
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 18:58:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b="MFcT/9rY";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16740-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16740-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D08B5309B091
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0883D4131;
	Mon,  8 Jun 2026 16:51:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0471F30BB;
	Mon,  8 Jun 2026 16:51:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937486; cv=none; b=Vaj4Jl5xKokmj+nXYEOyHQhvleJrnKQj8l7vIvdGFwLXfYna/f7etJPeskH9raP3NG9IOBxzc1H9wXDEQVGy0NiiytXewzgwbcnQeMn9lyEVPF/cE8ntFDuLLNsgCXhAoAPAotg3Ld7sQnkz9qpHwOamsq1zD7PSWoN17SEzrCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937486; c=relaxed/simple;
	bh=bDRyQ7k7wh2rEdBIMmE/ZeSkvPY7NVDJK0xnChIA7IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFT7DIsLQTkzJL5E7xlGnKKyvLQ++hXzwM90A6sME/6raea/QIqAdLMh78BWGXVqC+0klVcUzl4zM7AMs+8mqr5Br6yAfEqOrrQnvWSgSkwMXo5lft+SWlpcKDzDz6KBDr/85gdvEtNS4TbG73n/VcNROmG2l67K1TntrmG/dhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=MFcT/9rY; arc=none smtp.client-ip=212.227.15.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780937482; x=1781542282; i=natalie.vock@gmx.de;
	bh=bDRyQ7k7wh2rEdBIMmE/ZeSkvPY7NVDJK0xnChIA7IE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MFcT/9rY0QhnvZqRHUrR47ycaSdSZmzZjqkOT7PRm/lDs5CWE/8W4jmThfCci7TT
	 H8Cfi27AJ2G41JX/cSgp5h60DeYdPf/Ozxwenijrn+Houm2rtR6UbSrI5FbcdGUoB
	 2wjD2e7tSMn4W2/XgchHm1+cCcigo44mu0n22nP+0TEIsHrM2nwLJsABD/do2QC5Q
	 MvOmfpypOAm8QSowvjNda1Jb0FZPMX+dA8mpKppSkJ/WFwd8IWbq0x26nHvwk3h61
	 Rr0752OgP0uFy70qluv9jEWaomxuPO56AFSzZ3Adj2d0AE+QCHjDfyxX+lTsNzCQH
	 7sQ2p3wpxZ8GDzLYWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmKh-1wqdz110sz-00O25e; Mon, 08
 Jun 2026 18:51:22 +0200
Message-ID: <c6e147b0-48f7-4bb2-8ad2-7948764c7163@gmx.de>
Date: Mon, 8 Jun 2026 18:51:21 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/dmem: accept only one region per limit write
To: Eric Chanudet <echanude@redhat.com>, Maarten Lankhorst
 <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Albert Esteve <aesteve@redhat.com>
References: <20260608-cgroup-dmem-write-single-region-v2-1-b0cd6c4ccf1b@redhat.com>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <20260608-cgroup-dmem-write-single-region-v2-1-b0cd6c4ccf1b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sF8xefmnnDnB58NNemaKZvq5B4z7kaLp9Uha6dgKtpUjCUbvxin
 7ooc1MylaipJF0ipKkZ5UGhbD4UeF9yCPhs8C7vwE/ghiYzogP8onH78uAmVpSdGJIVD6L2
 is2DCOgaxIscEDjkJWeDaNun7YdXSSJPo8OiLIIQl7JxF4zx56DNXAesVaNi4vhuPa7q9LP
 OT6LIenRzMe2dFiAxRnhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M1DQeKNtBlY=;+CkmNVWcx5WRjuf56Ur5BuavVb4
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16740-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:echanude@redhat.com,m:dev@lankhorst.se,m:mripard@kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:aesteve@redhat.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:dkim,gmx.de:email,gmx.de:mid,gmx.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE523659000

On 6/8/26 17:53, Eric Chanudet wrote:
> Accept only one "region value" pair entry for the dmem.max, dmem.min,
> dmem.low files.
>=20
> This changes the UAPI that otherwise accepted multiple lines for setting
> multiple entries in one write. No existing user is known to rely on
> writing multiple regions in a single write.
>=20
> Processing multiple regions in dmemcg_limit_write() could quietly change
> first limits before failing on a later one and returning an error to the
> writer, with no indication some changes occurred.
>=20
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Eric Chanudet <echanude@redhat.com>

Reviewed-by: Natalie Vock <natalie.vock@gmx.de>

Thanks,
Natalie


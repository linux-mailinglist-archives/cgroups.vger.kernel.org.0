Return-Path: <cgroups+bounces-16737-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m92cA5v/JmqkpQIAu9opvQ
	(envelope-from <cgroups+bounces-16737-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 19:44:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C96595C1
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 19:44:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=I6niaMOg;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16737-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16737-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8368F32E87C3
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902153321D4;
	Mon,  8 Jun 2026 16:37:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F247832D0E3;
	Mon,  8 Jun 2026 16:37:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936666; cv=none; b=pS6DpFRZEDcRbNzR2u0iyzWmWEIat0NaZ0tLAfBXZ568sN5IVx+7XJn42wAIqBCvQpCpfAtT1vRdLJPXO+dq33Nn4cCADQQOjVG0AghowacwbbTjGseSSBO1pGLvVu7o2fqyQk7B4n/7rzyzJHfvHKO88x+5GypNr619rIoDVpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936666; c=relaxed/simple;
	bh=XluZQvNJwzIdMIShW1d7zjlSPj+Xxx0P+P7C2V7SFJY=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=NVWIvBAnJq6QvKzxxRXkL4d0Av/qoCunc8gyKw+kXRIUXo4iaWByXDWq7Mor2WmJqVmhZaq2o/79IVzIMw/etqjAAFBFnftOzn/U11fJQcL7wZUDrtF/lxncbtO+JxnAdQYTKQdizcWlAIBbmj/+p49Qu3bqieiYYdqxZuG1YwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6niaMOg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D561F00893;
	Mon,  8 Jun 2026 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780936663;
	bh=92FbV1Okgp8r+Sh0xvK1D17MGvbjqqbutVZw89jzoNg=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=I6niaMOgfMIa88cpbcCXUX3j+YvXFwsh9XGbccX6l0LeHNv/xkywkv/qht1Q9fhFw
	 ekHpDl5UVYTdQoTTaEDaZ1FoTtqFNx37Gc0pn2U9bLj3f6wHLem7LML+vUn/g/bj9W
	 2h3wcp1xFYtaqP6Rx9JuaC64BZ349WKcIuuPNYHHjQnBQEfzoqoNCrd/cjg+u3CaHb
	 a+ceDefpIbZ8xhGztkedW31HSolGi/eLoc5QkePpzFXp36SOxkUly8uSU64qxwR/n2
	 qtXlECxZ/8ZmR7dhVciV5joBE5Rmw7idY9fX279f3wModnbhlmaaxFRehqAF+77wna
	 qXbKU2bwn13bg==
Message-ID: <17557800bc330c00d686411486959af4@kernel.org>
Date: Mon, 08 Jun 2026 16:37:40 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Eric Chanudet" <echanude@redhat.com>
Subject: Re: [PATCH v2] cgroup/dmem: accept only one region per limit write
In-Reply-To: <20260608-cgroup-dmem-write-single-region-v2-1-b0cd6c4ccf1b@redhat.com>
References: <20260608-cgroup-dmem-write-single-region-v2-1-b0cd6c4ccf1b@redhat.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Albert
 Esteve" <aesteve@redhat.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Maarten
 Lankhorst" <dev@lankhorst.se>, "Maxime Ripard" <mripard@kernel.org>,
 =?utf-8?b?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>, "Natalie Vock" <natalie.vock@gmx.de>, "Tejun
 Heo" <tj@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16737-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,redhat.com,cmpxchg.org,lankhorst.se,kernel.org,suse.com,gmx.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:echanude@redhat.com,m:cgroups@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:aesteve@redhat.com,m:hannes@cmpxchg.org,m:dev@lankhorst.se,m:mripard@kernel.org,m:mkoutny@suse.com,m:natalie.vock@gmx.de,m:tj@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mripard@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mripard@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C9C96595C1

On Mon, 8 Jun 2026 11:53:51 -0400, Eric Chanudet wrote:
> Accept only one "region value" pair entry for the dmem.max, dmem.min,
> dmem.low files.
> 
> This changes the UAPI that otherwise accepted multiple lines for setting
> multiple entries in one write. No existing user is known to rely on
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime


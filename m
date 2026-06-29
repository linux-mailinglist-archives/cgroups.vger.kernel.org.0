Return-Path: <cgroups+bounces-17380-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qe/4K73DQmoDBAoAu9opvQ
	(envelope-from <cgroups+bounces-17380-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 21:13:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 567326DE3A3
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 21:13:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X2GEgV22;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17380-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17380-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C02983011063
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 19:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87F339EB7C;
	Mon, 29 Jun 2026 19:12:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3498318EE6;
	Mon, 29 Jun 2026 19:12:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760367; cv=none; b=hEOz8q95OMKlSHsGfwO0B73rCNKhrsRJb3njnqLvxmwTjOZfP9ZyPcHehq5cB56lIAnZaGmj9xyvYky6HScix3tDgVUTPUop4HCS097MwrNXW4FT3vB20DyIzbA3RKfxWC/h1DyYdA8/7omkC2SbX50mrSlveTSLuFKMqQdEYfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760367; c=relaxed/simple;
	bh=IgkyJKi60WXCmh17XYm05cccG/GD8qQaAxSY1ZxWgM8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date; b=WJXwQ0GE/ZZXYDw2YwwUjiMMsv2aj0jJy6s6IYEq4UzjlZoZMHKOwuSIONeetSHYD+VcX/AeTfnYtGYzEPhoabbLr8uvcQZxY3uD/bf2VFZHq0Z3mZowMUp+A1MQequNhh+bXUUFi6u2pSUDsRI6UCmhx+zvyY3d+15GyDjFrBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2GEgV22; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B7C1F000E9;
	Mon, 29 Jun 2026 19:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782760366;
	bh=IgkyJKi60WXCmh17XYm05cccG/GD8qQaAxSY1ZxWgM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=X2GEgV22QI+a6k3Vo7JEMVxpjU6PbRhuZHnwhO7HsJmf2NCpgi/VJxo1Oa/kWnG9c
	 WGBTJgaQFyMnA8B4/KLydRYskWtAkT99x7p/77q6/AQvwlpgUKibqcPD6gOp9b5GFO
	 tWLbobLdfvYqSwaiDzGS8MyvPSTmJY8MQUN79Em5k/MpQv5tJsH9u38Z5WG9ykv2Wq
	 oHXK2FnYDlk9PccNmSGLVyKn0Fk8Rsy3U1207v9B+3dSzrSO/C87cV09WIZB+K1mUo
	 WC65UcSW14DBibIhR11gVlIfusLAG9OUitNjtx36TR2vvTJvAfoRFvMulYSCcsJv4N
	 HaUiKIylSsXng==
Message-ID: <34e0c59bcaf01412e85ca387c8f8b094@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: Michal Koutný <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	cui.tao@linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cgroup/cpu: document cpu.stat.local and clarify
 cpu.stat behavior
In-Reply-To: <20260629060636.200118-1-sunshaojie@kylinos.cn>
References: <20260629060636.200118-1-sunshaojie@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17380-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sunshaojie@kylinos.cn,m:mkoutny@suse.com,m:corbet@lwn.net,m:cui.tao@linux.dev,m:hannes@cmpxchg.org,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 567326DE3A3

Hello,

Applied to cgroup/for-7.3.

Thanks.

--
tejun


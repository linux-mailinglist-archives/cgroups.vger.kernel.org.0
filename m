Return-Path: <cgroups+bounces-16584-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jpNfAjNNH2ptjwAAu9opvQ
	(envelope-from <cgroups+bounces-16584-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 23:37:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1306321DA
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 23:37:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Fmt6hpBC;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16584-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16584-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E8B304020C
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 21:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB6D3A48DF;
	Tue,  2 Jun 2026 21:31:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC60243367;
	Tue,  2 Jun 2026 21:31:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435905; cv=none; b=suwsC9OsGNNl83+RW4LXCHsByusJ698wSCrSrDpE1CiHZXPFk1ShapWnlIgRxGUs1Jx0U6VidmfeotuwYfidDtNqaVDysmxnZYhVL9BsQlm2yI2bAsvuLLal/UBjzbSAVeAyWBb2BYjjFizwBk5lxF4iPNFaryh0rwI6VskHzlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435905; c=relaxed/simple;
	bh=kAHb6UBp4emrhytW5HZoIVehGmzsgP76iq85RTas4/A=;
	h=Date:Message-ID:To:Cc:Subject:In-Reply-To:References:From; b=Z6PDAPZ1FJH+6Wy24DDTSS6/VM2MvMJWKEhbcRTzlD+G3UYPMl+yVoJRVpi01QfEyNwJP5NRGzmu66eZwlT0zjUQQwteAHlXPfyT9JBnsCcrXTvrtHl55E+2ite2kTWoSSGfdk5hONwz1zji/Jg9wwwTnKLkyCPI+/fR2vIwvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fmt6hpBC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7FA1F00893;
	Tue,  2 Jun 2026 21:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780435904;
	bh=kAHb6UBp4emrhytW5HZoIVehGmzsgP76iq85RTas4/A=;
	h=Date:To:Cc:Subject:In-Reply-To:References:From;
	b=Fmt6hpBCLz75Bi7j3nTaW++lUY/tjeWHQEa7aaEpDz+yqNZgo2gaU+oO82DuMsG9F
	 aGsqY7jyzGBWpoN65V8vbWJw4TadHUaHukUA0WwFiXTI4y9SfRhmreI3Iu1iBE6t+3
	 7od8axAtMVMD50Zqdd8VEn1567k5WgMpA7rI1GZiGfQDFpwz82qG/B5BVSsbaeTVEJ
	 nUlV5CXCPWyNq7zAAbKUBIM5w/GuAYnxBgITVJxcGQtNvo4Xs8Jc2fn15CIItziH28
	 IOAeIqdQDAILCquft6UjHXCfUXK1MStie1jafNeYVE3hV2yxE+3I9rdQYEu0QIZgpU
	 Wftubx1kfYR4Q==
Date: Tue, 02 Jun 2026 11:31:43 -1000
Message-ID: <ab08bb53225ba774024e576c17ab7478@kernel.org>
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutný <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: change ridong's email
In-Reply-To: <20260602091038.26901-1-ridong.chen@linux.dev>
References: <20260602091038.26901-1-ridong.chen@linux.dev>
From: Tejun Heo <tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16584-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:longman@redhat.com,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A1306321DA

Applied to cgroup/for-7.1-fixes with Waiman's ack.

Thanks.
--
tejun


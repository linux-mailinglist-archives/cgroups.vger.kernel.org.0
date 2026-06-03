Return-Path: <cgroups+bounces-16588-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zijRBdx+H2rMmQAAu9opvQ
	(envelope-from <cgroups+bounces-16588-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 03:09:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D00863351C
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 03:09:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E3om3GI4;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16588-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16588-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C7E430241B7
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 01:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98773002CF;
	Wed,  3 Jun 2026 01:08:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C772FC89C;
	Wed,  3 Jun 2026 01:08:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448919; cv=none; b=KvgTxV9cs5n0mjUG+buoZbaAS95rk67QNTsricQ4tnhadFm/yz8wHF1iBznfALNach/SVu8R12Fvvjll3zfkMBY+++p2/ylui04ONrR7olooeF7YVIWwB0HxjJoplytyYw/bT2qeTH8HvTML40NuFcv7S9LlklIGR4PX0v7d584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448919; c=relaxed/simple;
	bh=KVgBh65DOs2vRcTmvOaHrIisMdjRVW747c9X1mB/WDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goH25WZ2+CJPa+4gwf/ppblQzmqgnEpgeJDaY3JzluwApPIptrDzN6YZ1W0clFQU3mOxpqn8www5ZHmU7f3xdMzXGx9qi+TTQcV1U+mhDEiZ/4Upl7U1VT2ST3G3+0PtNOJe/W4a+hxzhQ9M6KAmmCK/XLFMO17OJywq1JIWIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3om3GI4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EE51F00893;
	Wed,  3 Jun 2026 01:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780448918;
	bh=ozV6ZOmVXi4nkGyIBKRv9ZwY2v1cDSymmVFpB2OdqNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E3om3GI4Ldwx2VQi5sf7entYZKMmOVTCOKcy13iQ7zLJg2/VDRCkhz7hxLs+vbP9Q
	 YcngHqgjRzLiBgsC8D2sl+uLqsYpnm9doQGpnP+Vsfyi6OXefzwW1yoqOVaBbzz+H4
	 oTgZtuphmyi/BiHC0TTrRIlp6xKwhrp0sUcOjYDW1liO7zCvFtf0zsfUxPKYTebksX
	 WgqNGl29B4/nVlKjLdPSf9796XGd1VmtsHD9jTTCy6IP38QuRkPRs6buxJgTFIuYWw
	 Lirz1sIuFfvg1pBWOacpVaC/tDsFvgEqBEmPu5Aek0QwjAUBfmQDGME9fSxeJb+/8K
	 a6n4BKsbYdicQ==
Date: Wed, 3 Jun 2026 01:08:36 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Ridong Chen <ridong.chen@linux.dev>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: Change email address of Chen Ridong
Message-ID: <ah9-hgsCj7F0wRbW@google.com>
References: <20260602140819.265274-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602140819.265274-1-longman@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-16588-lists,cgroups=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20260515];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:ridong.chen@linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[cgroups];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D00863351C

On Tue, Jun 02, 2026 at 10:08:19AM -0400, Waiman Long wrote:
> Chen Ridong has contributed quite a lot of fixes and cleanups to
> the cpuset code. Recently, his email address has been changed to
> ridong.chen@linux.dev. Update that in the MAINTAINERS file.

You probably want to update .mailmap too.

> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 74c86cf9bc65..634eb67acd06 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6526,7 +6526,7 @@ F:	include/linux/blk-cgroup.h
>  
>  CONTROL GROUP - CPUSET
>  M:	Waiman Long <longman@redhat.com>
> -R:	Chen Ridong <chenridong@huaweicloud.com>
> +R:	Ridong Chen <ridong.chen@linux.dev>
>  L:	cgroups@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
> -- 
> 2.54.0
> 
> 


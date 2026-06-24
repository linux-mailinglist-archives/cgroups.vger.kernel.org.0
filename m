Return-Path: <cgroups+bounces-17253-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2E80IoYnPGphkggAu9opvQ
	(envelope-from <cgroups+bounces-17253-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 20:52:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A0E6C0CDB
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 20:52:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mYZnXoy9;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17253-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17253-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B97EC3037B99
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 18:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D07331237;
	Wed, 24 Jun 2026 18:52:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4E326CE39;
	Wed, 24 Jun 2026 18:52:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782327169; cv=none; b=tS6oqrAxKd3reAOg81dfT93fnEWEfvBX4aRCT6c7/L9Csbr/MeJIbIiGT4fsS50LUGMZa4CwDTT/D6hmLoP2tpbNJPnqjOAuafy3Z62j/Y7XxkiVrWD1urF5TLOJGgi4eV4lbkBfq/CnQMzZXB2ZbRCYU0oQqgQUMB08nA6djFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782327169; c=relaxed/simple;
	bh=HZjqd0Y7OSQvpJcJ2bp9igewa30PUcr5IHn+FAh0a1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYjrjY4V/EGWKgzbJu+QUYsMPoon4eaq3Agtcs6UhwG0/80UBqBR8SC4Zxm8aNCbMDm/Ga74CjcYUUurkc08S5fNJJpfC3LDeSAZmJwKu9NZT6uf/tDK2luWXdp+yG1b+KI7xGUgvzuNocPEgxnIEOpzUl4HvPXSEVhSKXCjtX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYZnXoy9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B881F000E9;
	Wed, 24 Jun 2026 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782327168;
	bh=D7hkJteoSNs8rS8VBpeystfizFe6bdWuHjQ285p+IEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mYZnXoy9/kEr1Csqc8vSItQjEXA/Xa2JMYS1/w+q+osQ2ycPTCHhBmPA151h3Ml/T
	 nPRri5JwXErUOM5mbDide4yewYAtZ+X8mU1tEXedjiueoeOR24VdRc9c8pki8+zZa3
	 EXa9J82JFFSQXFUupv4jWk/+Oqo1BVTSMNNVeEE2NklQLsBKMTScQ5qqy6nvYdTLjR
	 qfT2QlMRvWLeYH3bpdbWxV8L0G/Y5wOukgExuH6X7VoiWeFzRN0XTEjfsvTPzVSxD8
	 IMeX9nSca1ZKfW+/IvNjIJc+9c7Ri9tdld1PTJgvqiwmPjWWGDbUuQrxKqWNektPRL
	 MfD3vQNXC7uNw==
Date: Wed, 24 Jun 2026 08:52:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Hongfu Li <lihongfu@kylinos.cn>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, corbet@lwn.net,
	skhan@linuxfoundation.org, dev@lankhorst.se, mripard@kernel.org,
	natalie.vock@gmx.de, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] cgroup/dmem: add per-region event counters
Message-ID: <ajwnf0uzT4PMHYZx@slm.duckdns.org>
References: <20260624031107.667253-1-lihongfu@kylinos.cn>
 <20260624031107.667253-2-lihongfu@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624031107.667253-2-lihongfu@kylinos.cn>
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
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17253-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lihongfu@kylinos.cn,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:dev@lankhorst.se,m:mripard@kernel.org,m:natalie.vock@gmx.de,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,lankhorst.se,kernel.org,gmx.de,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,slm.duckdns.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21A0E6C0CDB

On Wed, Jun 24, 2026 at 11:11:06AM +0800, Hongfu Li wrote:
> Add dmem.events to report hierarchical low/max event counts per DMEM
> region.  Increment counters on dmem.max allocation failures and
> dmem.low protection events.  The file is available for non-root cgroups
> only.

Please don't double space in descs or comments. Also, maybe it's obvious but
it'd help if you list why and how this is useful. Why do we want to add
this?

> +  dmem.events
> +	A read-only file that reports the number of times each cgroup
> +	has hit its configured memory limits.  The format lists each
> +	region on a single line, followed by the event counters::
> +
> +	  drm/0000:03:00.0/vram0 low 0 max 3
> +	  drm/0000:03:00.0/stolen low 0 max 0

This isn't a supported file format. Please read the documentation on allowed
formats.

Thanks.

-- 
tejun


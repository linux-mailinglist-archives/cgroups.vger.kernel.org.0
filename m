Return-Path: <cgroups+bounces-15917-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEcVFYDnBGpCQQIAu9opvQ
	(envelope-from <cgroups+bounces-15917-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 23:05:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB21753ACF3
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 23:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE2D5303FDF1
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 21:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9013815EC;
	Wed, 13 May 2026 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COTeppWY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB825B090;
	Wed, 13 May 2026 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706120; cv=none; b=F/2O3vQxeABzyFbG6/zI4TxS/m6FtOADZkGyJsGS7ZTO3xFAvTbhreJWRCFc42R9XOB+ObjRxIx/0UuqjegH/WmUQf5TT9eAS5WpyruHV8fK1oZ6pnC88xZ44/qFpcSMiHJDnrK/24gdlfPsRyMLlLWDQK/1DjFJDx/Re+xbInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706120; c=relaxed/simple;
	bh=MefVyzu5xSTXaF2TqFH8xe4uK4dGoM7ULjBiWwjxeAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVwmt9WRlBl7eFtoFOI1udSEF2X7eVUq4zWtdrBMcfVS3UMrWiKmrPxL/DoktN8Tj8ZOwfHtL+iwbqSKlOJarRIwV5TbQ+GD+RDgBAbA8W0LdacpuPNRdCXXZm9BB5CHeolSQRMqD1/Pil0dSIpqcQ9p0zIb9KDmNSKmVhNZtYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COTeppWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FE0C19425;
	Wed, 13 May 2026 21:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778706119;
	bh=MefVyzu5xSTXaF2TqFH8xe4uK4dGoM7ULjBiWwjxeAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COTeppWYpsO1+tl+6pGpHRoY4hemu874+5P+Z8bpvcEjJZ+8wjSD6H78VpfAwCGPU
	 MNHYPT3nYdbz8Q1vFZb5gc9hb5pMQtnfO2a8hc0EsnMxbhNKusZKp2RIKulyojuI/9
	 IXHkU3rt5pV2+ydhWmNki3n+jdnTxBEO27gl46o35s2LfBNRWEFkvB0qOzxwhFeMYy
	 5iTN0pZMVVHUDqcUSmQ+oKQslipbdHvjaK7mUI1RMDM3X16Nz+iez7xb9eQHGTcM0w
	 G5zgkMEt19qIh9XabQfCNuV5BE+lpT9I5942t/HBkYAO66i0uXazbx3lSMtlgmaJhr
	 6818MhA35EXYg==
Date: Wed, 13 May 2026 11:01:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Malat <oss@malat.biz>, Bert Karwatzki <spasswolf@web.de>,
	kernel test robot <oliver.sang@intel.com>,
	Martin Pitt <martin@piware.de>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET cgroup/for-7.2] cgroup: Per-css kill_css_finish
 deferral
Message-ID: <agTmxoVWzRn09Els@slm.duckdns.org>
References: <20260505005121.1230198-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505005121.1230198-1-tj@kernel.org>
X-Rspamd-Queue-Id: DB21753ACF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linutronix.de,malat.biz,web.de,intel.com,piware.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-15917-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Action: no action

Michal, any thoughts?

Thanks.

-- 
tejun


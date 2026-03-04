Return-Path: <cgroups+bounces-14610-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGk+FlZiqGmduAAAu9opvQ
	(envelope-from <cgroups+bounces-14610-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 17:48:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B7C20492B
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 17:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9268030117FB
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 16:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0F635F5F9;
	Wed,  4 Mar 2026 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps/UMxSo"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008127FD52;
	Wed,  4 Mar 2026 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642899; cv=none; b=LemKnc4NKnOH1H7qAFDFU9zWOQcIJxzNH2d4UgoBKX8dlOSFQkE6jmuRcTfmsqaD7Ri9jk7x1tctf0Q4OQAelKmVsvzCf4Ot9CXm8J1WsW/8SFbICHimiFUApRez5u4Oafx/EC/Mf8pu7uFFUaf0vmzKUbc9DlVhTWu9MAYcjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642899; c=relaxed/simple;
	bh=5BbHZMLyY1O+x4P9MgQ1WppXPdBOTizCZSh/gDLkd+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qedjvXr9x92ucfczLiEpcTXJmdvVIrSn04s+hget2oSQsovTwRKrAboXab7kVLW+bwxOI4gWN6/D+gBzCobcek3p3PYn/bv+rgzOokSjURcqDfAKdpSxIHtTLkNt4CyjIhKoO5EspMv2p8ad4ZBFSItJWSJRIDV9JKMzU7mC30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps/UMxSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90772C19425;
	Wed,  4 Mar 2026 16:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772642898;
	bh=5BbHZMLyY1O+x4P9MgQ1WppXPdBOTizCZSh/gDLkd+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ps/UMxSoCn8YIhEWM20xB+ijaCPxzG7qeMx5ATR1V//dcYK0jlwTzSEmWRert7lEq
	 5LXSK8u+N39MA9/1fKhw8V+cIUPWdl8103WvD+g96QiTnRNEcfEmdPmXJ1qZ1EVQis
	 mxXGW1AV45Bjsyo9xy0mMci+8sswcSsqNcHn/+LqDSW8U8WGHjirxf5uEqI0YUks2f
	 yB3yiPShcNJEt25AwWEgDwfAzFCPXShWjC20pka0L98FJi1YOsl8xHdKegjC7Ru/To
	 V0rCLie9Cf+bX6OCjV7irAvbjqBBxysNte8WgcrbJhbXBXY4nw2VFAFwqmDQNhJHnW
	 fRUo653P/uujg==
Date: Wed, 4 Mar 2026 06:48:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, thevlad@meta.com, kernel-team@meta.com,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v2] blk-cgroup: always display debug stats in io.stat
Message-ID: <aahiUfIRh84tpqrw@slm.duckdns.org>
References: <20260303-blk_cgroup_debug_stats-v2-1-196c713cb762@debian.org>
 <aacehv3rpO9irhEG@slm.duckdns.org>
 <aaf98kejfRuMvIu3@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf98kejfRuMvIu3@gmail.com>
X-Rspamd-Queue-Id: 38B7C20492B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14610-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello, Breno.

On Wed, Mar 04, 2026 at 01:56:43AM -0800, Breno Leitao wrote:
> > Given that they haven't changed for a long time, maybe it's okay to expose
> > them by default, but why? This is something which can be toggled on easily
> > at any time.
> 
> My goal is to ship a kernel that exposes these detailed io stats by
> default, without requiring any runtime configuration. The stats should
> simply be available out of the box.

This is a pretty trivial patch to carry, right? Or just do it as a part of
boot system config?

> > What's the benefit of exposing these extra numbers which
> > probably don't mean much for most people?
> 
> My original plan was to introduce a Kconfig option for this. In v1 (about a
> month ago), Michal suggested removing the toggle entirely and always exposing
> the stats, which seemed reasonable to me and received no objections, so I
> went ahead with that approach.
> 
> To be clear: is your position that we should not support building a kernel
> that always exposes the detailed stats in io.stat?

As a debug option maybe but I'd prefer if vendors (including us) that want
to permanently enable these debug stats carried the patch in their trees.

I think that these are a bit too tied to the specifics of the current
implementation and it's not very difficult to imagine at least some of the
keys changing or getting dropped in the future, so I'm reluctant to export
them by default.

Thanks.

-- 
tejun


Return-Path: <cgroups+bounces-15542-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDljAZPh8GmoagEAu9opvQ
	(envelope-from <cgroups+bounces-15542-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 18:34:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52591489056
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 18:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BAF530BADB8
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6402B3254A8;
	Tue, 28 Apr 2026 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeIoV98F"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D63233E8;
	Tue, 28 Apr 2026 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393036; cv=none; b=bcY8PotJrnobFzebIfQUlzejnxfejbKzmyDHrCpmFwsx/OUDNuDFuDXWodAytPtsmHSiZZRrtEDZaF2taI8edlNd88anM6mrjmYA0uoPnqFMw0OlbHgWd8lnol0taJYy03MJVbNIgMs6PAnE+aMLmylVzUt2jL3Z6n5mKNokCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393036; c=relaxed/simple;
	bh=Crq6T+1UCK2OZRO7GtGPiO36SXM7lyhEyH9B+Sm6MoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeOudrLbKKAttqskN9wSDvhYUlnvmsvccpwqI+7OUKZkG7M8DrRreCmlDPiGqqDnyuHGY5/JvFRxDYSrBSI+3XoiV+EF11olTN+O7PWrZEu9VgQ/FqaJdAjponzD2cZvM7T4qSWyEtTE047IwG8i49286AcX/UNip5W89ESX2tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeIoV98F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD02EC2BCAF;
	Tue, 28 Apr 2026 16:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393035;
	bh=Crq6T+1UCK2OZRO7GtGPiO36SXM7lyhEyH9B+Sm6MoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EeIoV98FqyHrzR3WZ3h2BXMxiDQALrLSO6puAN2I4uz3D08/FXLmAwsO57nv0mJQW
	 ETMIMWkHbDG2hDK5sUvTucb94b2uDk3igTbU4Bz+8Dfe3nbelxyh/6wNw8+6i8py6f
	 krStlSKwwVcmY3RHDIDrXu2l1vdOnlvX0iQ+5zJVauc2oUF7QLRSuNgJLuRHqwqSTO
	 0aM/OQX2UlB/6DYkRRza7ds9J6u3I/kRjyz/iVKHEhImnXcEafmG5t7V3r2wyKjzZ7
	 dhosI3PRK3DA3dWI5ci8JisZYwuq1igGaCjKfAaF4pV81sLJb/Ewz12Y4nSAagPVj6
	 PrUErcbV7zg7g==
Date: Tue, 28 Apr 2026 06:17:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: corbet@lwn.net, hannes@cmpxchg.org, mkoutny@suse.com,
	roman.gushchin@linux.dev, brauner@kernel.org,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] Documentation/cgroup-v2: warn about cgroup.kill /
 cgroup.freeze delegation
Message-ID: <afDdinJLH2H8nYfc@slm.duckdns.org>
References: <ftvtv7lv6gh6tfzabant74ncmtqjuljr3xfjxn5evaehwzhy56@kuf4jiwchuie>
 <20260428072251.2464314-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428072251.2464314-1-maoyixie.tju@gmail.com>
X-Rspamd-Queue-Id: 52591489056
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15542-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,slm.duckdns.org:mid]

On Tue, Apr 28, 2026 at 03:22:51PM +0800, Maoyi Xie wrote:
> +	A write to cgroup.freeze affects every process currently in the
> +	cgroup or its descendants regardless of the writer's signal
> +	authority over those processes. The file therefore acts as a
> +	delegated stop knob: chowning it, or passing an open file
> +	descriptor to it, grants the recipient unconditional freeze
> +	authority over whatever lands in the subtree. Runtime authors
> +	should not delegate cgroup.freeze outside of the trust boundary
> +	of the cgroup itself.

For example, if you delegate a memory control file, whoever can write to it
can control memory distribution over everyone in the cgroup too regardless
of their UID. Here's an excerpt from "Model of Delegation" section:

  Because the resource control interface files in a given directory
  control the distribution of the parent's resources, the delegatee
  shouldn't be allowed to write to them.

These threads basically amount to "if I give SUID to bash, I get a root
shell". Please stop.

Thanks.

-- 
tejun


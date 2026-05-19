Return-Path: <cgroups+bounces-16094-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JTFObyiDGq8jwUAu9opvQ
	(envelope-from <cgroups+bounces-16094-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 19:49:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 746F458350C
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 19:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A956A300D6B2
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 17:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AED32720D;
	Tue, 19 May 2026 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnDuKDDk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D999A3438BC;
	Tue, 19 May 2026 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212981; cv=none; b=mG1aMF/K46gh2lBT1cCmOWIRHGJvsLEDJN9n6th7eS54yKc5fdI7wMjFOyj75ZEfQnq0hqnKFAqf5jKAnytaf9AVUPo3hRm0AQJ8m+wcJY0GB5kAbFL4IEZlmapXMwMeoDaoh0E7cNkmNU/EZhaRD87ueW/I8fb8XSPMDWeSkm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212981; c=relaxed/simple;
	bh=MCFb8ajmYnerqfxj37M676JQ1A3rkKHOZQ7mKtCXqpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhZDIkj1hRbiF2Bp31V3NCQNxtYIqRrlLbErVP3RfhAWkQMLvxJWXQS0Ywdh5wyFwuskgetw4EFYqx+Uz41CuN/B68y+7IFFHvDBgdiHmpRs34mxBF+l6n+c08umWmN896Ii2z18VNLzSKRC9E0yOs2tYSn8nqeVFI9jr0MpvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnDuKDDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930D6C2BCB3;
	Tue, 19 May 2026 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779212977;
	bh=MCFb8ajmYnerqfxj37M676JQ1A3rkKHOZQ7mKtCXqpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnDuKDDkFBW+V/FxozQsPiFcPx8aZYGHnTP00yAyRccWcvqBsMieueWvO5wUJn7cv
	 juvyPyHTMUcutMWr0TvWLfDXXl5RzLWcS4PG+5LEH3g0bde029SFyYN6dZ/7ScMU3G
	 +GcxkDXrV8pkyB9JjxVAbZ7ucRPdqtJmYZumRZMEj/MTKFUo993v1HvWgbkB5hs76X
	 KtZ7833USoNlSwPzYHm8TR6vuudwPOpT2BqVxRIh/6eZeeSblSBc74T1oHWnrgNXEI
	 oor5AYAcpblzY08Bez9w/3I0n6suexTpMVhqDB+prmJ6Jv35j2djFhp17QADteyOXZ
	 DlThIwRoxYO3w==
Date: Tue, 19 May 2026 07:49:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cgroup/rstat: convert rstat lock from spinlock to
 rwlock
Message-ID: <agyisB5nfUdDBCk5@slm.duckdns.org>
References: <20260519173134.1486365-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519173134.1486365-1-thomas.falcon@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16094-lists,cgroups=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 746F458350C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 12:31:34PM -0500, Thomas Falcon wrote:
> Implement rstat_ss_lock and rstat_base_lock as read-write locks
> instead of spinlocks. In addition, update tracing to reflect new
> locking implementation.
> 
> The benchmark below, meant to simulate a workload performing many
> concurrent cgroup cpu.stat reads, completes in 134 seconds on an Intel
> Xeon Platinum 8568Y with 144 cpus compared to 241 seconds when
> using spinlocks.

Can you try using seqlock for readers? That'd be decouple readers a lot
better than rwlocks.

Thanks.

-- 
tejun


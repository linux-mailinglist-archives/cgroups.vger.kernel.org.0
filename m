Return-Path: <cgroups+bounces-12803-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10061CE7C38
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 18:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E086D300E839
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 17:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7C732C305;
	Mon, 29 Dec 2025 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk840Rfp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4921623182D;
	Mon, 29 Dec 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767029957; cv=none; b=F7AE9YRiQyEEeyyc0/hhaRL5sC5sNFKiW1fb/dcQik5QbM6qTxhTj6tFL++hP4YSjjLo82EKDT+rT4IMZ4BYYCpGE8nVQ4MwCH20bIdQPbsfutjUNeDEiGn/RWZEora5VxWvC6/GomTkgMTzOtzfEITX/zVtkP4aYpD3xq0NjuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767029957; c=relaxed/simple;
	bh=5sgY48DeFt6LZVv6AA4skmGB5LL1KiEINGNQH9CCg1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S11CO+XropRIQw1gASvzvdswpYuiMysFpIVhdNozLlGY/gZXe80jkRELiygxjjiCO5ygQsx0PiSUCaTYFerItNjNuxlsW5WSmAFqgXcOTshyHhR6zDAtN9dp3m7Eka0TvLvxWmcrSAL50jYlf9lFM33sYsr8WFa1j/lxbXTiIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk840Rfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4657CC4CEF7;
	Mon, 29 Dec 2025 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767029956;
	bh=5sgY48DeFt6LZVv6AA4skmGB5LL1KiEINGNQH9CCg1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fk840RfpFBaXBRJKCW1UPyDZzPN/FYE+rOEqTP1Zml7dhTvDHJ2APcZcOIEYLrfcx
	 SAW/Pp91iph7HL/ONiixJej1ljpbESgiZCOh997uKjJLFcnGrshmwnj4hf9F56cnzY
	 blDWNuJHOJ3BJudwrfp9mMYMnWThzQtdbhIDrI+DfEDJATKvJGkZP+uPzbwCGc3nTW
	 pn8NzbIY+66LrUq3Wd+YCbwMtrOfEU7FHIxPBGKRksl3rWJiXsjO8Php/Yzr5qhzs9
	 +oLUTXVIBFQLU6CAHAeNtusQsy6/tku+2ynY2CkFCBJhhB7cWc/51/4xV60YPBj2oB
	 l4UxRwJxkPNVg==
Date: Mon, 29 Dec 2025 07:39:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup-v2/freezer: Print information about
 unfreezable process
Message-ID: <aVK8w5vjzf384-m1@slm.duckdns.org>
References: <20251223102124.738818-1-ptikhomirov@virtuozzo.com>
 <20251223102124.738818-4-ptikhomirov@virtuozzo.com>
 <aVBjDYPQcKEesoKu@slm.duckdns.org>
 <80d36215-de7e-448c-85ea-9e848496c210@virtuozzo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d36215-de7e-448c-85ea-9e848496c210@virtuozzo.com>

Hello,

On Mon, Dec 29, 2025 at 01:32:11PM +0800, Pavel Tikhomirov wrote:
> > This is only suitable for debugging, and, for that, this can be done from
> > userspace by walking the tasks and check /proc/PID/wchan. Should be
> > do_freezer_trap for everything frozen. If something is not, read and dump
> > its /proc/PID/stack. Wouldn't that work?
> 
> Yes, I think that will do, Thanks.
> 
> Though the trace printing in /proc/PID/stack is a bit less informative
> than show_stack(), e.g. for my test module
> (https://github.com/Snorch/proc-hang-module) the stack in /proc/PID/stack
> will be just empty. (I guess it has to do with the fact that you need less
> privileges to read /proc/PID/stack than dmesg, so you can do a more
> informative thing in dmesg).

You can use drgn, bpftrace or any other bpf tools to read way more detailed
backtraces.

Thanks.

-- 
tejun


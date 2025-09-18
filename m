Return-Path: <cgroups+bounces-10265-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9E9B85E2C
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 18:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED7E189319F
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162412FBDF8;
	Thu, 18 Sep 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4SvCXod"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DFF23C8AA;
	Thu, 18 Sep 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211175; cv=none; b=MvHZ+khm8qpxwnRqhOc5QdP5n4EC0AAO1aoAoSzFZCttNBVkcFbJqCq4Fvooeau2NS77GNjxfSAKw8oqbUA2dmCOcjGYZTJSUzArifOn0Byd3n4cM3eSdotN+xFIYxtS4JAPlMVw7GTLkH6LvN2lWWT8B7C3zQ6BX+wU7Eckk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211175; c=relaxed/simple;
	bh=aQuwObe4h1vc7cwntcxYpwoRZI7cY+TDd5U2RVXloxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBXK5FmdWtgabAzWthx7+0dDL4gkHGdIJ5Vvq4UQ5jp+qyyJYLEQjsKWO/P7s6r1ydgLe6jMv1gEtYUhtn4Dc/K3MreQEE8yv3oOY4nL45AKm1KhvwRm+D9AMLtAxlQ9DpoDcGwIzlh+3S1Z5to3cuYya+CXMMcoVulmX13fs4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4SvCXod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595C0C4CEEB;
	Thu, 18 Sep 2025 15:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758211175;
	bh=aQuwObe4h1vc7cwntcxYpwoRZI7cY+TDd5U2RVXloxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4SvCXodRR6tWrtsFbq9rIfAjPOhlvM4JzV4+osPtgzRvKe04XOz6xSaUWik4o7Zd
	 QKdhj+a+oTtOZuHMSGad2LlojtyHIyvboWeQEFLBg8+W3wXtHRbbwUGjl5Kgs6uBPQ
	 8BCbgyF60NINxfL9WVNs9hhTZQ6jXiaPCtDoWrqdWJd1ZTw7gVJDq3opa0FVHvUZOQ
	 +ClAxELjOs0ITi5mCNBwDZk8V0AywnzkAMGs/gdg7QEokpwlPwcqrH+ZqNnwulHqq2
	 aeUl/XS6BnL0eutEMklBHXi3VA7zNHkOcAbl+poqgklFe/mQ1fJHmHg3ql0F9WHyxd
	 2T4lKdQSBEG3w==
Date: Thu, 18 Sep 2025 05:59:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
Message-ID: <aMwsZism0R-ZHLkq@slm.duckdns.org>
References: <20250918074048.18563-2-bagasdotme@gmail.com>
 <aMwo-IW35bsdc1BM@slm.duckdns.org>
 <ul3hrtvui3wuvchludb67wy7kahsroclvppssmeuqrfwieyfv4@vd3gbuuda2xq>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ul3hrtvui3wuvchludb67wy7kahsroclvppssmeuqrfwieyfv4@vd3gbuuda2xq>

Hello,

On Thu, Sep 18, 2025 at 05:55:07PM +0200, Michal Koutný wrote:
> On Thu, Sep 18, 2025 at 05:44:56AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > I don't think I'm going to apply this. Sure, it can get out of sync but I'd
> > rather have TOC which sometimes is a bit out of sync than none at all.
> 
> The TOC is in the generated output :-p

I know it's tongue-in-cheek but one big benefit of the doc format we use is
that these are still very readable as a plain text document. In general, I
don't want to make changes that worsens plain text accessibility.

> I understand you want this "[PATCH v2 4/4] Documentation: cgroup-v2: Sync
> manual toctree" [1], which is also fine.
> But I'd drop this "[PATCH v2 2/4] Documentation: cgroup-v2: Add section
> numbers" [2], because that adds more places for out-of-syncness.
> 
> [1] https://lore.kernel.org/lkml/20250915081942.25077-5-bagasdotme@gmail.com/
> [2] https://lore.kernel.org/lkml/20250915081942.25077-3-bagasdotme@gmail.com/

Sure, that makes sense. Will apply [1].

Thanks

---
tejun

Thank.s

-- 
tejun


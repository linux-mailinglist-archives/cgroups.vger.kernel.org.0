Return-Path: <cgroups+bounces-6829-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1B7A4E9A2
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 18:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7520B3AFCEF
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 17:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC4F29DB6B;
	Tue,  4 Mar 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2Rq8z9/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F4264600;
	Tue,  4 Mar 2025 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107304; cv=none; b=GNSVZiQwybBsyiJKNeYijdhgYgcsOj/4wPRi6aa3Cc3+d28FSwyUtzmMdW3MJkbu47amtrf/4IgR3PP+i6C0ei1y/Freqc08kyCxTjG77G4Be8K+/yZA3b7T2AQ37S8g2qHdgQqWa9uN82s2fjSPK3+usIk7BNzCAKkAenaGFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107304; c=relaxed/simple;
	bh=b0tgUtFT8jt9U9rAUFsewLIDZQyfCwT4CxSxsMn617o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmHEktfNPTecthqH75dw/KIJDCcLJGdIRb8qskxiYiHW/EDfIAuN1FYh8CO3PEIfplN8wJEIgtEg6qbK6ib9oeS08JzWZPnOzu2I/Sg+Jf7ILLstWJZmQkpNPa4UwHrfZMQ4JQ7B4rF7u6/ad392VYjjnfHX8iYNyEyg6SXxc8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2Rq8z9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50726C4CEE5;
	Tue,  4 Mar 2025 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741107303;
	bh=b0tgUtFT8jt9U9rAUFsewLIDZQyfCwT4CxSxsMn617o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2Rq8z9/nPxSEiZwUtvczIg9EPcyL/IYN32H60rL/gqIycMJKiRuQOIj/pgZ5I03D
	 9WrgshNJEhKU58Q0KI1iEYJRRsMb21f6LT/1gSL1JI6dKDQHSKeRWNc3mW254Rgr9C
	 IcYGH3P5YQwo04ZoVKexsrSAJEa/d+fR+QLJ+eS01xz3sWQAe/OIFc4YOPs68yaKsz
	 Q6Z5jjf6RsKkieIbBGTjmnSsklG7voc7jrETAn7MdANlC3bgIe2UD+3ju/eb0ROkQx
	 TFsSVIgnKa0cmQK+p9wXsiEQIwRZyqGXOIwAGUvSxjkpN1+dFyVwIKYufIANYR/JYS
	 9sbEy8w/oVrkw==
Date: Tue, 4 Mar 2025 06:55:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 4/9] cgroup: Print warning when /proc/cgroups is read on
 v2-only system
Message-ID: <Z8cwZluJooqbO7uZ@slm.duckdns.org>
References: <20250304153801.597907-1-mkoutny@suse.com>
 <20250304153801.597907-5-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304153801.597907-5-mkoutny@suse.com>

On Tue, Mar 04, 2025 at 04:37:56PM +0100, Michal Koutný wrote:
> As a followup to commits 6c2920926b10e ("cgroup: replace
> unified-hierarchy.txt with a proper cgroup v2 documentation") and
> ab03125268679 ("cgroup: Show # of subsystem CSSes in cgroup.stat"),
> add a runtime message to users who read status of controllers in
> /proc/cgroups on v2-only system. The detection is based on a)
> no controllers are attached to v1, b) default hierarchy is mounted (the
> latter is for setups that neven mount v2 but read /proc/cgroups upon
> boot when controllers default to v2).

I'm hoping that we could deprecate /proc/cgroups entirely. Maybe we can just
warn whenever the file is accessed?

Thanks.

-- 
tejun


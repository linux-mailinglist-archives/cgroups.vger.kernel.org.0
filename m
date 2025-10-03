Return-Path: <cgroups+bounces-10533-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3D3BB7384
	for <lists+cgroups@lfdr.de>; Fri, 03 Oct 2025 16:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C0874ECF7C
	for <lists+cgroups@lfdr.de>; Fri,  3 Oct 2025 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FBC1F9F73;
	Fri,  3 Oct 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKZEvdLz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8C26FD9A;
	Fri,  3 Oct 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502555; cv=none; b=ei+LtKAgzlvdGLMnukhHfqm+zG4TZZjsMFB4by+AZcMc69ORUfaBKVBVFWAMU+nvTFXep709oJOAdsHdhRDFWJ7kGXMfk9D/8PXQISgiAlaZSpokhyvBEbNzx+S67eCEbOzV74jdjf+AMApFRE6wNhWVOOa7LhUjPEhcSYITtoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502555; c=relaxed/simple;
	bh=TQw/bGbK3C7Gulzf952bPr+x4MS4cOjJGbDj8MAcYls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmTZrGZPI7GYjXmu8WYBdHw4WOSkKJHP52SDlvae5b4s+drvQT5lMCA3cPOTOsVen9z6qYz0YQvjPv5GRocTk37QWbPwRAaHxB7A3ikt3xw/QN+rpSkhN0AHCPyaYgeIBCfly73llina200zVrgY2BPwJHbtaPYwaKMbybpTOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKZEvdLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C77C4CEF5;
	Fri,  3 Oct 2025 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759502555;
	bh=TQw/bGbK3C7Gulzf952bPr+x4MS4cOjJGbDj8MAcYls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKZEvdLzfjIxroXPgLKjY+qsOA0PRvyD9m7X3SC1ApSl04h08Jfd8Kej276024Wt8
	 2MFarIdf7JWFSzvYkknZOcS6QuvUekP1tJOoLgtaFoUIjjgBxRt30/gALItqIhpPEz
	 NX14LLrCNBzlHcZsK1rMYgcRs8FNBet2Yv7z8I7BXpn5GoE6wDHSHMOthdKFXbVmO3
	 MHY728yOrCsKAntKyF2iTefdGXm4R2bnypNuCht7Jm8QauSPOzWXnbVP3uwPxhwe88
	 hAA1rJ97uY/h4DoPlJkpL2wfFNTdmzZYLDwb1qtJrmVBlfu11Cs6HEs3poWvRkcK8u
	 GpfiPpebpmL+g==
Date: Fri, 3 Oct 2025 04:42:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tiffany Yang <tiange@google.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
Message-ID: <aN_g2WO6R87DaaEN@slm.duckdns.org>
References: <20251002052215.1433055-1-kuniyu@google.com>
 <58de560994011557adefca6b24ebe4e8@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58de560994011557adefca6b24ebe4e8@kernel.org>

On Thu, Oct 02, 2025 at 06:45:01AM -1000, Tejun Heo wrote:
> Applied to cgroup/for-6.18-fixes.

I applied the following patch and dropped this one per the discussion on
this thread:

 http://lkml.kernel.org/r/20251003114555.413804-1-nirbhay.lkd@gmail.com

Thanks.

-- 
tejun


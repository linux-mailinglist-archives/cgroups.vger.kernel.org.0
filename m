Return-Path: <cgroups+bounces-7841-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83323A9D21E
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 21:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BBC17B4369
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A111F3BA9;
	Fri, 25 Apr 2025 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME2CEg6M"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57B535963;
	Fri, 25 Apr 2025 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745610359; cv=none; b=nWAs4M/+MFQvc63s7FjFBblrerJEd7ATIUTvqcfDJv9U+fxhFm9v6do7fLACE8xRazCEsf2ZlmzzDg0PJQUwyaY07hhizmTSE/q7dGj5yBef8s09r1ZYRuo3+ZhLFcvC5Cpu3xrL9pX9dx+w+eiBGi9nJM6afhhYzLEjxhVmxVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745610359; c=relaxed/simple;
	bh=C9sDb3VEOtMBLtbmJ2Wz66s2W79wJBMaGKUxctPs9gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHH6wJfZHrEAzCO5bvcBM7DMJV1PHNYxgPjpNumKrPSQekinS4YNMWF24xrbEN4NmkSG+CbGK4H8L3pmmiBNT1exUY3vvExKwEgk8fYjB66ilaV1mnSZUDGu/4LIXKxXjx34Xg8fqCAQcYYvr2RKXvSQKqYKfH7Gg4LQfhWlCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME2CEg6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B80EC4CEE4;
	Fri, 25 Apr 2025 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745610359;
	bh=C9sDb3VEOtMBLtbmJ2Wz66s2W79wJBMaGKUxctPs9gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ME2CEg6M1jo4Lj9UxfvcUGivOi/VgKQZ0Nu2yTeQEkWF3R047s7M6NbJWRlMv1qSw
	 p5ntKREmj6DiHJcMD9Y6Rk5RqTFAWLmLjt8RGNsbzRKtESlRpZUMahIidsWKuZ6XbW
	 LURZ9mc01wx5fSu2kvcEdxHTfmeP85Pg1fQJZjP4AZGFVkAS4LJamYlDi9zJQ7L/Bd
	 e+CHTKOu73h2DAvLQT39ChTMVDaN1b1t9+kgbA4M0PMwAo7yKjaCuMfmgb+2uxl0ZM
	 v8xJ+VVS0J58kPNt8H3vP7DzrRZZWiPPmKeb9N9N6gVywOFa/sdFGx1mCfSEovcTvV
	 RSNcML/UNAZ7g==
Date: Fri, 25 Apr 2025 09:45:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-cgroup v2] cgroup/rstat: Improve
 cgroup_rstat_push_children() documentation
Message-ID: <aAvmdg6T_g5s73cR@slm.duckdns.org>
References: <20250425031656.790645-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425031656.790645-1-longman@redhat.com>

On Thu, Apr 24, 2025 at 11:16:55PM -0400, Waiman Long wrote:
> The cgroup_rstat_push_children() function converts a set of
> updated_children lists from different cgroups into a single ordered
> list of cgroups to be flushed via the rstat_flush_next pointer.
> The algorithm used isn't that well illustrated and it takes time to
> grasp what it is doing. Improve the embedded documentation and variable
> names to better illustrate the transformation process and make the code
> easier to understand.
> 
> Also cgroup_rstat_lock must be held for the whole duration
> from where the rstat_flush_next list is being constructed in
> cgroup_rstat_push_children() to when it is consumed later in
> css_rstat_flush(). Otherwise, list corruption can happen leading to
> system crash as reported in [1]. In this particular case, the branch
> being used has commit 093c8812de2d ("cgroup: rstat: Cleanup flushing
> functions and locking") which breaks this rule, but is missing the fix
> commit 7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list
> with cgroup_rstat_lock") that fixes it.
> 
> This patch has no functional change.
> 
> [1] https://lore.kernel.org/lkml/BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com/
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.16.

Thanks.

-- 
tejun


Return-Path: <cgroups+bounces-7668-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBEAA944CF
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 19:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D4A1894C52
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123081E1E04;
	Sat, 19 Apr 2025 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAzLxzIL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54371E008B;
	Sat, 19 Apr 2025 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745083306; cv=none; b=p85zeD+jjTDvOApYnLQbtOPbWJvgHuZRqoIfrlcseot35BihKe5Fx7siW3SF5FPfvKHcSFRfHGmRcwvtKIw4noRV/wTU0fho1bGMMmh3pBaT8KDxrxFuoHBSdVUuGdgGQ9B7OWfOdNXN3FCs7Hy6wmu5lCHyBHghuUB2eZKEUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745083306; c=relaxed/simple;
	bh=gubOaCJu4/S9c8n4ojxqS9QUB7mqxeUWCfhq6ikB6Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZRCyYzsBq+niqnN2+6+I7YwGdzBIE5myxzzYqpbIBnVYG18OSVU3dqRp0YiTrAT/UhmncNk6rvxuT7Euh5u2ECPiIVQEbI/ix7ST+NZPwovyBfYwd6TfGJir4auN97XMaNyRHHaBOABehZxvOAZ41smPa1dYHyeyD0E6RsT7kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAzLxzIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8952BC4CEE7;
	Sat, 19 Apr 2025 17:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745083306;
	bh=gubOaCJu4/S9c8n4ojxqS9QUB7mqxeUWCfhq6ikB6Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAzLxzIL0cN4CKUMGyC00dPYO8XLzx3KMT4LQBrZ1CcXJ5+AS0ek2N3/crkQGZvWO
	 lKsWVFqbnEmRX1gvK4iaM4suPI4Uj7DNtnwiy0CSbm//UZ9TFLxRbfKgFVj0fgHvbd
	 sevTIKYNz0wSBRlTXb6eJdt/qPthSAwqV5cb8A8u/akmTz+DLcYKWI1vUynkkxon65
	 s3fyhiEbL7MwgMF61rviujP7hUlYt9aNYgwDvTMCvWjHv0Tne9B0Gl3iWEzAxsflG1
	 LwldbvwEFEnY1V56swq/SfoKLxu5nU21BeMEyAjru4cvUhyDlIM4RTuI5qJlZQQX0O
	 mag0OmhItlaWQ==
Date: Sat, 19 Apr 2025 07:21:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3 0/2] vmscan: enforce mems_effective during demotion
Message-ID: <aAPbqbAzxsrGv0IR@slm.duckdns.org>
References: <20250419053824.1601470-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419053824.1601470-1-gourry@gourry.net>

On Sat, Apr 19, 2025 at 01:38:22AM -0400, Gregory Price wrote:
> Change reclaim to respect cpuset.mems_effective during demotion when
> possible. Presently, reclaim explicitly ignores cpuset.mems_effective
> when demoting, which may cause the cpuset settings to violated.
> 
> Implement cpuset_node_allowed() to check the cpuset.mems_effective
> associated wih the mem_cgroup of the lruvec being scanned.
> 
> This requires renaming the existing cpuset_node_allowed() to be
> cpuset_current_now_allowed() - which is more descriptive anyway - to
> implement the new cpuset_node_allowed() which takes a target cgroup.
> 
> v3:
> - remove cgroup indirection, call cpuset directly from memcontrol
> - put mem_cgroup_node_allowed in memcontrol.c to reduce cpuset.h
>   include scope
> - return true if mems_effective is empty, and don't walk the parents
>   as recommended by Waiman Long.
> 
> Gregory Price (2):
>   cpuset: rename cpuset_node_allowed to cpuset_current_node_allowed
>   vmscan,cgroup: apply mems_effective to reclaim

From cgroup POV:

 Acked-by: Tejun Heo <tj@kernel.org>

Given that the operative changes are mostly in mm, it'd probably be best to
route through -mm, but please let me know if you wanna go through the cgroup
tree.

Thanks.

-- 
tejun


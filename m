Return-Path: <cgroups+bounces-4827-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5B99743DE
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 22:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F2F28B930
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 20:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58211AAE28;
	Tue, 10 Sep 2024 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfNFnUwz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C71A76CE;
	Tue, 10 Sep 2024 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725998696; cv=none; b=Unx2Ttntp7IPEUSpo5BLFFMasTA+/QiaLA0PUbW00V5isVp0rBMKyvZV3HNfMdKwDbnnyUAZfgsvKO0CVLacyIA5qS7B4+05/pFOfL308wEd9tjtR4PQWuxZfFfAwvpo34Ipmyr04V7eXlrJU+Hrw+k7oYPlhfeemP4ZzjCx7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725998696; c=relaxed/simple;
	bh=mCP/S64qRWDXiS+KlJDht7ed6FhIJFpBriSrSt5LC1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ygk9yMXEnK5j6YJGr1HdTugNN4AF+0jEkOySiZw1lpUx1KHVClMb4FdLOTVd98NAnTEf1DmTR6KNhkTUKoSiAv9x7IkXsqP+Qlkk6/IJvQWHf/8ZxxhplcjT7VlmXfCoazbxdDGN2rRAl5n0Uhw713/SaaieV7Kx7nIY7+HST0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfNFnUwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE09AC4CEC3;
	Tue, 10 Sep 2024 20:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725998695;
	bh=mCP/S64qRWDXiS+KlJDht7ed6FhIJFpBriSrSt5LC1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AfNFnUwzHwCKx7jw7mV+9VYmV3h/7mkLMuhq3mHraEMs7TwPIjf/5ZFx1WODEhH+o
	 bgy1p1kJ3yoB4RkABm80RKmHvVX1Tdep3u8v2QWvtgdJ8vuERblzMNTsCAJVzFUikf
	 9Hz0ooHZLSwR8ITevm+EML8cf+qKrLRvh83ltNDRhp6wDh6taetddOn/IKSqSMGnlp
	 laoPiZZqIp6F23QSNAVJ+vQYjX7X9FqofLdZPhIEmcFLuf8VGcoPxTsLYWaItapkXf
	 fSoE/5mk2osx63cbtC+mk1IN7rE9o58JVR74R+x3rMf4fqNKfEkeq39+qZslIeB4ff
	 j8jYrJAnDEHKg==
Date: Tue, 10 Sep 2024 10:04:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH 4/4] cgroup: Do not report unavailable v1 controllers in
 /proc/cgroups
Message-ID: <ZuCmZrkcZWjzq1NY@slm.duckdns.org>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-5-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240909163223.3693529-5-mkoutny@suse.com>

On Mon, Sep 09, 2024 at 06:32:23PM +0200, Michal Koutný wrote:
> This is a followup to CONFIG-urability of cpuset and memory controllers
> for v1 hierarchies. Make the output in /proc/cgroups reflect that
> !CONFIG_CPUSETS_V1 is like !CONFIG_CPUSETS and
> !CONFIG_MEMCG_V1 is like !CONFIG_MEMCG.
> 
> The intended effect is that hiding the unavailable controllers will hint
> users not to try mounting them on v1.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-6.12 w/ Waiman's reviewed-by.

Thanks.

-- 
tejun


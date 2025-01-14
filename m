Return-Path: <cgroups+bounces-6157-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF4AA11262
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 21:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE94161957
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 20:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6AD1FA82B;
	Tue, 14 Jan 2025 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR3bLBCa"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB6204590;
	Tue, 14 Jan 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736887471; cv=none; b=dr5JsvcSRx6KmEwl+eg+cQJPD158W48EcFlE7uEkAhxjMtjKPqcc74Z4Kg/wc1mUXkh+tFfvicIBxsC6AZkheu79shdYWtlLJjmYwxrqdW0hib4E/bNtnDx16WYY9HF6qWIIh4lYp3IiTVddbdx4pH28UcxLrNTFNkoko+Ic2VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736887471; c=relaxed/simple;
	bh=GhSyuvazemiNBHplKm7JkAuEuU0thINNrfaZZ5PCoG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxU1ugrvO3N/LfMd77NDv1pyoNPLVfRTF1qjWQgAni3gAXAA7Oxcj55bHVHC+zzSBhIuCbOCmlGsR5kSxbkD2rVQDs3BeTxTgR2SvjBwh8HalN2n7zuTgngbb80qY2Hs6wQgmYK6dr8b5WMwkQr7VUyLS3Waj7/kdWV6phpFE6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR3bLBCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980EBC4CEDD;
	Tue, 14 Jan 2025 20:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736887470;
	bh=GhSyuvazemiNBHplKm7JkAuEuU0thINNrfaZZ5PCoG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TR3bLBCaEXtn6gKtpIjKi2FuGrDLFxP23CpdxZWuBPDHHQO5o61eRWp6HptQCGoju
	 T/LkaX3g78JIPWzRtHVgtdaBaWDQkacXBkS3uF1DrLPh62OUpNTevE5q/q4yyftkyj
	 807NpvzsOAPVyCFVSvMdDM/776gKWQ9zwc/qB5djjSdgrmiowqkW/Nx8MvMvtpO/67
	 DhnmNc+CZtday2l+vPTPBMmPoL/8xso2M127C71HeCBEQWyha2aZ0+jnMpJzEgtNJ/
	 hq/Dk+/lVFUpxBbeE75tKLb0+OLUQKF7WP9WsK8vVEERzKjAO/h4P6LuuBv4BqaVyQ
	 aMyi+EcnhRgsQ==
Date: Tue, 14 Jan 2025 10:44:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Waiman Long <llong@redhat.com>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] kernel/cgroup: Remove the unused variable climit
Message-ID: <Z4bMrXdcNWEj9MYc@slm.duckdns.org>
References: <20250114062804.5092-1-jiapeng.chong@linux.alibaba.com>
 <f502ee68-7743-48c6-9024-83431265a6b8@redhat.com>
 <20250114-voracious-optimal-alligator-cdaaba@houat>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114-voracious-optimal-alligator-cdaaba@houat>

On Tue, Jan 14, 2025 at 06:56:38PM +0100, Maxime Ripard wrote:
> On Tue, Jan 14, 2025 at 10:41:28AM -0500, Waiman Long wrote:
> > On 1/14/25 1:28 AM, Jiapeng Chong wrote:
> > > Variable climit is not effectively used, so delete it.
> > > 
> > > kernel/cgroup/dmem.c:302:23: warning: variable ‘climit’ set but not used.
> > > 
> > > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=13512
> > > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > > ---
> > >   kernel/cgroup/dmem.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> > > index 52736ef0ccf2..78d9361ed521 100644
> > > --- a/kernel/cgroup/dmem.c
> > > +++ b/kernel/cgroup/dmem.c
> > > @@ -299,7 +299,7 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
> > >   				      bool ignore_low, bool *ret_hit_low)
> > >   {
> > >   	struct dmem_cgroup_pool_state *pool = test_pool;
> > > -	struct page_counter *climit, *ctest;
> > > +	struct page_counter *ctest;
> > >   	u64 used, min, low;
> > >   	/* Can always evict from current pool, despite limits */
> > > @@ -324,7 +324,6 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
> > >   			{}
> > >   	}
> > > -	climit = &limit_pool->cnt;
> > >   	ctest = &test_pool->cnt;
> > >   	dmem_cgroup_calculate_protection(limit_pool, test_pool);
> > 
> > The dmem controller is actually pulled into the drm tree at the moment.
> > 
> > cc relevant parties on how to handle this fix commit.
> 
> We can either take it through drm with one of the cgroup maintainers
> ack, or they can merge the PR in their tree and merge the fixes as they
> wish through their tree.

Acked-by: Tejun Heo <tj@kernel.org>

Please route with the rest of dmem changes.

Thanks.

-- 
tejun


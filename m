Return-Path: <cgroups+bounces-7368-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F831A7C4A9
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 22:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 767B57A5511
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9394B1F2C5B;
	Fri,  4 Apr 2025 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV79duNv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5332E1494A6
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743797391; cv=none; b=osYioQH3UGF36Vq1iVr5nVy/03HjmstxKdEuUG0ZTdmSmEWhuxmspYJABpt+4Rco9adtx91p1Tb2NaVKObhkXbGtH+IDvH5QbWhnmbj+9DQwQTuJ7eBS7R1MKi9W19pIionlFALkg9ANIzl/eCSeRAYrKw81iKt0Lfuj+uK0kh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743797391; c=relaxed/simple;
	bh=5MKQFTnc4HH4IcmQJ8cqBJBgkSr327R+5PevCPCJrkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoJ1nHWegzvAstNsSiyohCSU9GivEhaAU+6UvU+8XGnn9mOAe0PJdcAk8uF68bVBV5L4RZsAu8dKuJW+WTqfoGSvMdXRyRehBBr3qtl0gbWRIyGtU7Hz71dnl3If4ij6A3AGEZHd3pH610Dk3pVPuGQZK1Rb6adMuFwK8BhRwNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV79duNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB121C4CEDD;
	Fri,  4 Apr 2025 20:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743797390;
	bh=5MKQFTnc4HH4IcmQJ8cqBJBgkSr327R+5PevCPCJrkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kV79duNv4MRvBZs2fARTvmvWbf3CoRvQX0SPG/STX4ksvgy7GrLD4Rbsp7dpEw79w
	 WFCZTioDYUuaLSP2Embi2jIJfH/ClBH7r8Rwjt73W346l3L0mSBlyFQudN+AMrhgOO
	 gv4laNnY9fZ/mEno2jbaWvPn209vdugsd4NxHf2SOZ5Zat1olVIHuywUKv22e4YYiE
	 8QMkhzzFHwWcM0LK4OGOBEpnkIq6JVl0NliT5gWFwWPuHDmOa8FnVw1PEgerb4XeH4
	 qH3aR8NgHwcfbBiS4qT4jUP4sIZ+VBEsuxmBGMbKgxXr4R5OW/0dV2ry4NrwmwKm3S
	 ZsQ6O8TYjKgQA==
Date: Fri, 4 Apr 2025 10:09:49 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 3/5] cgroup: change rstat function signatures from
 cgroup-based to css-based
Message-ID: <Z_A8jcXXKJp-snYA@slm.duckdns.org>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-4-inwardvessel@gmail.com>
 <Z_A6WXpNcybYssn6@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_A6WXpNcybYssn6@slm.duckdns.org>

On Fri, Apr 04, 2025 at 10:00:25AM -1000, Tejun Heo wrote:
> On Thu, Apr 03, 2025 at 06:10:48PM -0700, JP Kobryn wrote:
> > This non-functional change serves as preparation for moving to
> > subsystem-based rstat trees. To simplify future commits, change the
> > signatures of existing cgroup-based rstat functions to become css-based and
> > rename them to reflect that.
> > 
> > Though the signatures have changed, the implementations have not. Within
> > these functions use the css->cgroup pointer to obtain the associated cgroup
> > and allow code to function the same just as it did before this patch. At
> > applicable call sites, pass the subsystem-specific css pointer as an
> > argument or pass a pointer to cgroup::self if not in subsystem context.
> > 
> > Note that cgroup_rstat_updated_list() and cgroup_rstat_push_children()
> > are not altered yet since there would be a larger amount of css to
> > cgroup conversions which may overcomplicate the code at this
> > intermediate phase.
> > 
> > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> 
> Applied 1-3 to cgroup/for-5.16.

There were some conflicts with the commits already in cgroup/for-5.15-fixes.
I resolved them but it'd be great if you can verify that I didn't do
anything silly.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.16

Thanks.

-- 
tejun


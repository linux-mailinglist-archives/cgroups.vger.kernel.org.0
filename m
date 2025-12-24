Return-Path: <cgroups+bounces-12688-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA23CDCBAE
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 16:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D673B3074839
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB86C2DAFBA;
	Wed, 24 Dec 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU3PatpK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB924DD15;
	Wed, 24 Dec 2025 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766590655; cv=none; b=Bbu2n/LdFYX382ehr+dJMAmpd/Q40HqHHbrTyhmiuPD/BCRN27MSs9x+qB1FpbYP1keZd0y20krmiytpD1OF1Ane5o3Al59jSXjTFo1nH3RTUYzOH+fapgrTxMBUQA20HGcD4qVKJADj5KNfeYkw9i57yUj/csSus1e9sOspRGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766590655; c=relaxed/simple;
	bh=Kq2IKIwGlEg3jCMrjcxejf8rYj77mjFHSMzj/fyqpVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V48ZIdyTDtmm1PnkdosamMuV0Hmx6YrCxolpw17DPt5/5VHt2zaQfA727rHxYz6HZJy5dyswAZynX3lfek3dGQApVRMfk5xsEiO1VpBKYETmcFhoorovBr8GhW8XzX+KBXECOL6g9INxg8b4dIsKgh4UJ0vchbpy6S32cZ04Uio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU3PatpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B748EC4CEF7;
	Wed, 24 Dec 2025 15:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766590654;
	bh=Kq2IKIwGlEg3jCMrjcxejf8rYj77mjFHSMzj/fyqpVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HU3PatpKRIH9r9cf9LBg691ulT/Eg1MJt3PwpZ81oJMY10QzYmgdQmgCfr+YGB3zy
	 y6vB3BU9UbJqOz65JZBXcJRGqkGISFl6LNo0j4mTUZRqoOZqiPNrc3S2pCa8V0qoZ1
	 +2jZyqLxwO2guSPLJD2sTmD3wkg4gFWLd2L0VltOb/YocfwqpATjDiuqJEC16UnFJs
	 AigKEHXfgKcPIGA5EIKmFMkOMyzYaiQ6y21iDoQYof9nFeMtIBXwnaAGCHjwrerrtE
	 YP8jkDUUy3nANQP6xOmNAWYh8GTAjq9RVZfaDXQGaVZ8aptQKjQnCQQXhvkAgmBqbn
	 02ySujIllgAcw==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: damon: get memcg reference before access
Date: Wed, 24 Dec 2025 07:37:30 -0800
Message-ID: <20251224153731.69411-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <peusxpenpbjdnhr5nkgvqtiuuofmc6khsxsxxvj3k3eyledkft@kgvgid53zbbg>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 23 Dec 2025 23:51:55 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Tue, Dec 23, 2025 at 09:21:47PM -0800, SeongJae Park wrote:
> > On Tue, 23 Dec 2025 19:45:27 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:
[...]
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index 4ad5f290d382..89982e0229f0 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -2051,13 +2051,15 @@ static unsigned long damos_get_node_memcg_used_bp(
> > >  
> > >  	rcu_read_lock();
> > >  	memcg = mem_cgroup_from_id(goal->memcg_id);
> > > -	rcu_read_unlock();
> > > -	if (!memcg) {
> > > +	if (!memcg || !mem_cgroup_tryget(memcg)) {
> > 
> > For this part, I was thinking '!memcg' part seems not technically needed
> > because mem_cgroup_tryget() does the check.  But I think that's just trivial,
> > so this also looks good to me.
> > 
> 
> Hmm !memcg check inside mem_cgroup_tryget() is a weird one. It makes
> mem_cgroup_tryget() to return true for NULL parameter. We can not use
> mem_cgroup_tryget() as is alone here.

Oh, you're right.  I should have read it more carefully.  Thank you for
enlightening me :)


Thanks,
SJ

[...]


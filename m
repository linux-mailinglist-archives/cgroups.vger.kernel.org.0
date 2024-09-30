Return-Path: <cgroups+bounces-4992-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B498AC77
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 21:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD521F239BE
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F90194C92;
	Mon, 30 Sep 2024 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1Iu/aAe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B9E1AACA;
	Mon, 30 Sep 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722881; cv=none; b=Ao9wZa3KFweWZFp2u7zuNOHzTaDnzWeFx/sA3a5RdJfqHNyfG/NYDP/G0j4Kpra2FyrCi5kCSuDwmzKk7+eFlg1xY8b2jTfYis7kqSsWHvQUJTCb2vMwYGVUhOHL0BJulYzKyJgOFASesTt7KmjWtMOukfgZBtI/uTWfgbePtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722881; c=relaxed/simple;
	bh=+y4GtKnDlCcn8EWTJCARurHDIL2BC49bzBIksN9jNps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHUgqwW3C2/eBI7NjPOQJTLoGXk49mZTA+oMEGXR/RBCIFapR5oIvV1+W9tzz9EuA4n04irO7aRTemO25lzJJAicldKUsPOyms9IBl8qKWB4nh23Fn59i84kXvP05vx+pTtJ5tkPBdansBiTrDEfoBq2MkslHiMdGI8HygCPH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1Iu/aAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415DCC4CEC7;
	Mon, 30 Sep 2024 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727722881;
	bh=+y4GtKnDlCcn8EWTJCARurHDIL2BC49bzBIksN9jNps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1Iu/aAevrrPVkpCjmX9LQzxIjjvbPlMB9gPT7oKY4cGrwxppXItX0mLzXD7judQT
	 m6v7atldetL7I7pfNNQV8Jl8btgPaIU1J7d/JDdkeqJR///158ib6mn5BGtNy53Y4W
	 /2NjEhfFEvUHJz1Yr+6xTH2S5LBx2EWwokmVpxNatZpQ8YVyTbzAbR2WriXmq5tNTn
	 X8Em83QfojNJ5OHcA+TFJaKC2KNRMiW0Oi2gpPLnkM15I8DdZpd7sARUGVW4Ztxj+F
	 /dAu0tUuA/uQzvyMfx+ZXu7a839i19huzrucgxhfl+nVvYKPskx2q1Ug721Hy3IYZU
	 TFjxAivPNPMuQ==
Date: Mon, 30 Sep 2024 09:01:20 -1000
From: Tejun Heo <tj@kernel.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix spelling errors in file kernel/cgroup/cpuset.c
Message-ID: <Zvr1gKNKBblkcy4z@slm.duckdns.org>
References: <20240915082935.9731-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915082935.9731-1-everestkc@everestkc.com.np>

On Sun, Sep 15, 2024 at 02:29:21AM -0600, Everest K.C. wrote:
> From: everestkc <everestkc@everestkc.com.np>
> 
> Corrected the spelling errors repoted by codespell as follows:
> 	temparary ==> temporary
>         Proprogate ==> Propagate
>         constrainted ==> constrained
> 
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>

Applied to cgroup/for-6.13. The patch didn't apply cleanly and I applied
some of the edits manually.

Thanks.

-- 
tejun


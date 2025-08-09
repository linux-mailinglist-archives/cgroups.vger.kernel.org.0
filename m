Return-Path: <cgroups+bounces-9059-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2D8B1F5DA
	for <lists+cgroups@lfdr.de>; Sat,  9 Aug 2025 20:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BDC189A824
	for <lists+cgroups@lfdr.de>; Sat,  9 Aug 2025 18:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8191E1DF2;
	Sat,  9 Aug 2025 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUssSR2R"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A2566A;
	Sat,  9 Aug 2025 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765172; cv=none; b=i6TLSImTPo2VvE3iKeY99sTF4gXrpqerOHw0LQgc9VrmQSXh2BL8u0IJpCwBmPb9swzxotdx/ZuKbBTcGdoxF9uxoZ1/3rScaXM0bgCPu8w7Z8UgYMcgoaKONQaiMVPYrh7lXB/TafacJe/OElmuhuSqPisJBKaFM4mCa3z9FIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765172; c=relaxed/simple;
	bh=nT8UQmrnUFHFzTpXawIUcLR18++XKc1qlQMcl1/GMMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDkXW+a/q6V+eHCHr4CQFyK3ezGsZuuo+lYbebzjkNdlxOBpzKRaEl6bsuFg1yCAdaWug9HDoaQP/eiWjz7FeZ+DMd+lkgtgtRcRdSWgCOZtD2Y+9b1D0IOTevsjGRDoIppxlnqez2tgzUS3CvPgzSaX4bP3vWR1Iu2n718jCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUssSR2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CB7C4CEE7;
	Sat,  9 Aug 2025 18:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754765172;
	bh=nT8UQmrnUFHFzTpXawIUcLR18++XKc1qlQMcl1/GMMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUssSR2Rs+wacrpwn5pGzOsENWGcUmPDW4FiZi/QZahM5KuoPbe7i9FHnp4Ap2ef+
	 24I5c69oMTNhIondDJ1hJ+HblTwtbs+5j3xUOtgl1bCx9dgv4GjFwSI3snMZt7DWtr
	 SSkHKTIKmuNAPtqTBi5Rp41pr7MoTBJZygZT7uPtBzMgZnsFuNKw50w7QLSPpn+oTg
	 gZN8YxqS7YV5St65O2dcjWPnb/p3tE5QiZ5TsWaEI79rEf0xEV7U/Ds6QZz7mYjaQg
	 Opfeu3ixKPlK6cHkXHrrtFq0Z5dK0EkGZy/l0jyzpowq1o4LdRIM78xnxhD4EsqS2X
	 lsVLMzDutnoIg==
Date: Sat, 9 Aug 2025 08:46:11 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, mkoutny@suse.com, yosryahmed@google.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH cgroup/for-6.16-fixes] cgroup: avoid null de-ref in
 css_rstat_exit()
Message-ID: <aJeXc2-GjqZI9I9F@slm.duckdns.org>
References: <20250807003350.178160-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250807003350.178160-1-inwardvessel@gmail.com>

On Wed, Aug 06, 2025 at 05:33:50PM -0700, JP Kobryn wrote:
> css_rstat_exit() may be called asynchronously in scenarios where preceding
> calls to css_rstat_init() have not completed. One such example is this
> sequence below:
> 
> css_create(...)
> {
> 	...
> 	init_and_link_css(css, ...);
> 
> 	err = percpu_ref_init(...);
> 	if (err)
> 		goto err_free_css;
> 	err = cgroup_idr_alloc(...);
> 	if (err)
> 		goto err_free_css;
> 	err = css_rstat_init(css, ...);
> 	if (err)
> 		goto err_free_css;
> 	...
> err_free_css:
> 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
> 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
> 	return ERR_PTR(err);
> }
> 
> If any of the three goto jumps are taken, async cleanup will begin and
> css_rstat_exit() will be invoked on an uninitialized css->rstat_cpu.
> 
> Avoid accessing the unitialized field by returning early in
> css_rstat_exit() if this is the case.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> Suggested-by: Michal Koutný <mkoutny@suse.com>
> Fixes: 5da3bfa029d68 ("cgroup: use separate rstat trees for each subsystem")
> Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Applied to cgroup/for-6.17-fixes.

Thanks.

-- 
tejun


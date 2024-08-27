Return-Path: <cgroups+bounces-4513-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34EF961696
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 20:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB11F23B44
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F41D27AC;
	Tue, 27 Aug 2024 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1glkD46"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A1C1CF2B8;
	Tue, 27 Aug 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782543; cv=none; b=Cpmr2I6lbypau5bRDvMkuxk/3lSy1+nj4mRvJu6BOy4WGoim9PwHCa7rBSoyzFvZ7B+E19QJNNoQ/a9E5RvB3wjygXxFGUBKp92JSCr+m7k6ddk0WM+clzAK36besCcAl5kHL38AOnoWj4ylhEq8KXMl3HburkdcBs7sHrGKayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782543; c=relaxed/simple;
	bh=4+JgWpiSu97u6O4C8eU4TdFqqADaU4vGUi5rtkUrPPQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ppTW7GkNt3KegXPIV7Q4ddk4JZjqVockBIM9gBJEMUzQyT8h6BU7D1CcmtNt2DXLCsXQJVaCzT/ZAJudq3ajOSSyGz4ICB9LeB001DF1kkpfkvSjqLqJrVE+o96J9MBZm54i58StyNmHRlbVBPgKBSvlIig8Yw0ycwH/GmvGKis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1glkD46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AD7C567C2;
	Tue, 27 Aug 2024 18:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724782542;
	bh=4+JgWpiSu97u6O4C8eU4TdFqqADaU4vGUi5rtkUrPPQ=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=D1glkD46FBWhK5xSsEdA6sYQd36cUFKJO/7BDYpCb+I8fnUCZswpAGlNJQqJ1lyVj
	 oLN2cLSPuH2lQItXWRwjxkKzz6k/NJGNouN7ngHoopWFXrKTho8qLy+W5pxpTgDC6+
	 UloRgo0tlFzBR+g5qtOJeC8nXyr6BWH+GI7ZVfb6/do0IsKS777I892nHS+LyfevYk
	 OtIVOmY8yuBUeC8GZPK3GV5DtY9flCllOtCcyBc2KTQ8FLauuJEtuqLVTt/eDdakf8
	 DcMo7cNgBPhoBYrfXuZTBi3BMNX1ANy38nPLjJfPoPssH77jIayiUTst3KnuKKeBCi
	 68wtjJd3PCJIw==
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Aug 2024 21:15:38 +0300
Message-Id: <D3QWDRKVYJ25.2TPQTKQ3CWDDZ@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <chenridong@huawei.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v16 09/16] x86/sgx: Add basic EPC reclamation flow for
 cgroup
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
 <20240821015404.6038-10-haitao.huang@linux.intel.com>
In-Reply-To: <20240821015404.6038-10-haitao.huang@linux.intel.com>

On Wed Aug 21, 2024 at 4:53 AM EEST, Haitao Huang wrote:
> Currently in the EPC page allocation, the kernel simply fails the
> allocation when the current EPC cgroup fails to charge due to its usage
> reaching limit.  This is not ideal.  When that happens, a better way is
> to reclaim EPC page(s) from the current EPC cgroup to reduce its usage
> so the new allocation can succeed.
>
> Currently, all EPC pages are tracked in a single global LRU, and the
> "global EPC reclamation" supports the following 3 cases:
>
> 1) On-demand asynchronous reclamation: For allocation requests that can
>    not wait for reclamation but can be retried, an asynchronous
>    reclamation is triggered, in which the global reclaimer, ksgxd, keeps
>    reclaiming EPC pages until the free page count is above a minimal
>    threshold.
>
> 2) On-demand synchronous reclamation: For allocations that can wait for
>    reclamation, the EPC page allocator, sgx_alloc_epc_page() reclaims
>    EPC page(s) immediately until at least one free page is available for
>    allocation.
>
> 3) Preemptive reclamation: For some allocation requests, e.g.,
>    allocation for reloading a reclaimed page to change its permissions
>    or page type, the kernel invokes sgx_reclaim_direct() to preemptively
>    reclaim EPC page(s) as a best effort to minimize on-demand
>    reclamation for subsequent allocations.
>
> Similarly, a "per-cgroup reclamation" is needed to support the above 3
> cases as well:
>
> 1) For on-demand asynchronous reclamation, a per-cgroup reclamation
>    needs to be invoked to maintain a minimal difference between the
>    usage and the limit for each cgroup, analogous to the minimal free
>    page threshold  maintained by the global reclaimer.
>
> 2) For on-demand synchronous reclamation, sgx_cgroup_try_charge() needs
>    to invoke the per-cgroup reclamation until the cgroup usage become
>    at least one page lower than its limit.
>
> 3) For preemptive reclamation, sgx_reclaim_direct() needs to invoke the
>    per-cgroup reclamation to minimize per-cgroup on-demand reclamation
>    for subsequent allocations.
>
> To support the per-cgroup reclamation, introduce a "per-cgroup LRU" to
> track all EPC pages belong to the owner cgroup to utilize the existing
> sgx_reclaim_pages().
>
> Currently, the global reclamation treats all EPC pages equally as it
> scans all EPC pages in FIFO order in the global LRU.  The "per-cgroup
> reclamation" needs to somehow achieve the same fairness of all EPC pages
> that are tracked in the multiple LRUs of the given cgroup and all the
> descendants to reflect the nature of the cgroup.
>
> The idea is to achieve such fairness by scanning "all EPC cgroups" of
> the subtree (the given cgroup and all the descendants) equally in turns,
> and in the scan to each cgroup, apply the existing sgx_reclaim_pages()
> to its LRU. This basic flow is encapsulated in a new function,
> sgx_cgroup_reclaim_pages().
>
> Export sgx_reclaim_pages() for use in sgx_cgroup_reclaim_pages(). And
> modify sgx_reclaim_pages() to return the number of pages scanned so
> sgx_cgroup_reclaim_pages() can track scanning progress and determine
> whether enough scanning is done or to continue the scanning for next
> descendant.
>
> Whenever reclaiming in a subtree of a given root is needed, start the
> scanning from the next descendant where scanning was stopped at last
> time.  To keep track of the next descendant cgroup to scan, add a new
> field, next_cg, in the sgx_cgroup struct.  Create an iterator function,
> sgx_cgroup_next_get(), atomically returns a valid reference of the
> descendant for next round of scanning and advances @next_cg to next
> valid descendant in a preorder walk. This iterator function is used in
> sgx_cgroup_reclaim_pages() to iterate descendants for scanning.
> Separately also advances @next_cg to next valid descendant when the
> cgroup referenced by @next_cg is to be freed.
>
> Add support for on-demand synchronous reclamation in
> sgx_cgroup_try_charge(), applying sgx_cgroup_reclaim_pages() iteratively
> until cgroup usage is lower than its limit.
>
> Later patches will reuse sgx_cgroup_reclaim_pages() to add support for
> asynchronous and preemptive reclamation.
>
> Note all reclaimable EPC pages are still tracked in the global LRU thus
> no per-cgroup reclamation is actually active at the moment: -ENOMEM is
> returned by __sgx_cgroup_try_charge() when LRUs are empty. Per-cgroup
> tracking and reclamation will be turned on in the end after all
> necessary infrastructure is in place.
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


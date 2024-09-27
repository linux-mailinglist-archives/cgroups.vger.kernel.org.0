Return-Path: <cgroups+bounces-4976-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA1E988AFD
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 21:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F9B2810CC
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 19:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FEC1C2435;
	Fri, 27 Sep 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSPDIATa"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BB113BAE2;
	Fri, 27 Sep 2024 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466990; cv=none; b=Wpa+f5FvPRhbs8t0UanQ1ZqoQ3gvtjGV9XhmvwuwenVktl/qcLp9iXFc+CFIHWgFMK0NRt5mBRDgEaItwKFwsbsWIiIVVzg5/LzkNDB95XqBqo3juvH5cjyKEf9W0JGW9Sq/G1UbeBXMfn09mx8BRwzlCPcnS4vkKVyP6fIjODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466990; c=relaxed/simple;
	bh=YHueFDko7gzpgE2n62VUPrObWi+WZbZm6FC2Qc7lks0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF7eZ4vxQvlRoxVfH4qtWXCTenS8DQqwwdNQK9vtccSsmz9wdrS4jt78NpgJKMYAZLB/Vq6ziUQ+gqMtv+y0MflCa1i/UofJivrGqwOinp/XJrlIMQSWPcLwdmR6tF+qFM8dmoauCkl+CH2N29vY0hk17S391M9SxhhMoh9sFG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSPDIATa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657E6C4CEC7;
	Fri, 27 Sep 2024 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727466989;
	bh=YHueFDko7gzpgE2n62VUPrObWi+WZbZm6FC2Qc7lks0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSPDIATa8TjuDork9cpNoaOaReKyoM9p8bFAJ84rqMHRkx/8+z3AJJl2L6+EQVuEv
	 AYKU9kEm8OgpQlQijCanbsrwuchKh5rgROWGoh2CobRhAVsOkYxobEwb4A4H1AlIzR
	 TAAd8jFiS4fMo58jx2mhDqYp7BO8XJUSUsuY4i5QlV+ZSwZvaxEvNxX7tTuBKuMNxy
	 ZEgzFM+eW9IFKtqfdCnTb8+MQmsKo6WIozLgslk9cm0dOsW9cAYDV/GlttkcTjTgGH
	 DKzhOeJ2E5ngDH0B/CdkmGev6JUQYEY8ouxPbiW5S48UJCp19AEfzSwmWJAjhgcQ+F
	 NI1XnCEKCD9eA==
Date: Fri, 27 Sep 2024 09:56:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	mkoutny@suse.com, chenridong@huawei.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] add dedicated wq for cgroup bpf and adjust
 WQ_MAX_ACTIVE
Message-ID: <ZvcN7O_UBNNQlnSz@slm.duckdns.org>
References: <20240923114352.4001560-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923114352.4001560-1-chenridong@huaweicloud.com>

Hello,

On Mon, Sep 23, 2024 at 11:43:49AM +0000, Chen Ridong wrote:
> The patch series add a dedicated workqueue for cgroup bpf destruction,
> add adjust WQ_MAX_ACTIVE from 512 to 2048.

Patchset generally looks good to me. I'll wait for an updated version
addressing Michal's comments.

Thanks.

-- 
tejun


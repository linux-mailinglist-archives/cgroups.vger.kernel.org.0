Return-Path: <cgroups+bounces-6359-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A651A211ED
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 20:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9DF1645C2
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 19:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94611DED68;
	Tue, 28 Jan 2025 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+d4blNn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A323A1DED44;
	Tue, 28 Jan 2025 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738090906; cv=none; b=SPjTC4Tqh/eRqVgC/R72ML5brd22NUKQq+jQdvguEECxQhsoLi/fFy8WOk32zJxgl6VG7tUAQ92POjmJF6NRuhaoTd7OB0KXFzmrrqtWvfR0JuqLGi2LZsFRTdOpct+/9kU/doCjS86uPHXdh6/A3p8iNvZPVDz1riv50nNJHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738090906; c=relaxed/simple;
	bh=RFQUi1P0VCNysL5xegNFmcxLjcGUwJRmhllYqRhzSEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAXaUe9ofqrZ9j0K1gEtUDWt8+aWZ1MJfy/jBQC6gpTKaBeDXfwwu9s0VUL8zvhRjxuSLOTnJA5fKquy7uSO7UhgvLABtLtti8ZV+mxqXVL2WlvDi8Om1PMGg6iWGhCfPRjUvbTZWi+3gmcXKbnLdFp7/gBR8Pvubjpt6TUDN9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+d4blNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1130C4CEE1;
	Tue, 28 Jan 2025 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738090906;
	bh=RFQUi1P0VCNysL5xegNFmcxLjcGUwJRmhllYqRhzSEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+d4blNngxcZuKxC/VWK57bGsBzcWQsgpGONeejyYCFOpD+ZumzNAvTtPvxMiLGzg
	 1n5H2gzOJukXlg/8S+y/eVPZBhU+b1dwrny3ZP3/twN3x4IOmQShaF7JCHRCBD/asI
	 J7OUr/rJvAJUHVMiBRSsheKMkGMVJITMYzaQ3/h8ObyMzV+m6FVNr+7rbfF7zCUMXR
	 axfCa48jWE2cC5frmrdH4Kdy4IJlwZvie8+aynRtLnK7RhJZRK1GX4sx01vZvUHsCb
	 RfA8O0E3Q86ujBg6ltx+LPtd9WZsnjyG+Pw1GqnrIO/rRfrCh5vo3EIzWwe2NSHaq0
	 o+JcgW6I8+V8g==
Date: Tue, 28 Jan 2025 09:01:44 -1000
From: Tejun Heo <tj@kernel.org>
To: linux@treblig.org
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/misc: Remove unused misc_cg_res_total_usage
Message-ID: <Z5kpmLqC6lIEOHxP@slm.duckdns.org>
References: <20250127235214.277512-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127235214.277512-1-linux@treblig.org>

On Mon, Jan 27, 2025 at 11:52:14PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> misc_cg_res_total_usage() was added in 2021 by
> commit a72232eabdfc ("cgroup: Add misc cgroup controller")
> 
> but has remained unused.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Applied to cgroup/for-6.15.

Thanks.

-- 
tejun


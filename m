Return-Path: <cgroups+bounces-5206-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B49AD525
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 21:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8A6B2392D
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 19:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3FC1D3627;
	Wed, 23 Oct 2024 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr6O/71Y"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56E7C6E6
	for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712732; cv=none; b=bbRcIFwyRwgWkLLhTR82IUbFm6PnMi2ofVo11MfdCbu2YBQnpa46sjS71l9R4BEC3rf62rcqka1lzlsJDVfEr3Jhiunnc4zDR0aGVY0OVOUuUBAN3CTTofEhLkdq1rvvEL8x7d6dr2wxZyQtvHUyO0zNXEfGPajvRddMdizp+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712732; c=relaxed/simple;
	bh=PJeb5KjS9okZQ+Wh74QaJX6U1IJE5XCCcMXLrggfaYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLbKkrc5E7HyvQ/9NQnjUe/pa9IPU2HD5q3ZTDr8P935rJwRZut1E5obE/MNNifMAGMSQQssQ2idlg6RLQQMlIe6UxBPQ99KXRvzsUJzAZSpzQx6v8UxeKJOmmCxBZFXF9EtFKTlMRwv2DWHmcdSFFmLMOYgakUpBl45VBVTgQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr6O/71Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5963AC4CEC6;
	Wed, 23 Oct 2024 19:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729712731;
	bh=PJeb5KjS9okZQ+Wh74QaJX6U1IJE5XCCcMXLrggfaYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lr6O/71YMSB8BYqSVek1jHKxpwTws0jkok5zlzrSwHM8qx0t4cJRZnChU86X/vzLZ
	 bCmZB09XZAsTQ7cUP0YqSNT/j9bwL352DUmRNh4zP6CMIZz4C4X3KcZYX8GVEo3iCK
	 cpW+pGYRaMINtbs+M2yONl27ktyuIuztxpfJgqIdNDYPPNxFgEizNrjH4wHmMduhxW
	 xnb3e7jaJlFRMk4zFL9YHu8hcwBMvcOR3kw+mb1bEjmmGZXZXjriXd6Cu3DH1jzzh3
	 lCJu7fZGnqJm9Hx4N5xJL8NKMS2zw0mmT/tvGLY2uQsH125NkHJ639G4ttWjQi1riP
	 yR4Mw/18wkiEg==
Date: Wed, 23 Oct 2024 09:45:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	adityakali@google.com, sergeh@kernel.org, mkoutny@suse.com,
	guro@fb.com, cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH -next v4 0/2] Some optimizations about freezer
Message-ID: <ZxlSWhBt4L5xJ3Op@slm.duckdns.org>
References: <20241022114946.811862-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022114946.811862-1-chenridong@huaweicloud.com>

On Tue, Oct 22, 2024 at 11:49:44AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The e_freeze flag has been changed to a bool type, which will reduce
> unnecessary looping when the freezer state does not change. This patch
> set adds helpers to make the code more concise.
> 
> Both patch 1 and patch 2 have been reviewed by Michal Koutný.
> The patch for v3 was dropped, because there was no good idea to make the
> code much more readable and reduce unesessary loops.

Applied to cgroup/for-6.13.

Thanks.

-- 
tejun


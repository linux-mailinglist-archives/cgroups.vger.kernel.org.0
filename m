Return-Path: <cgroups+bounces-4938-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF6397EE4D
	for <lists+cgroups@lfdr.de>; Mon, 23 Sep 2024 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932E91F2263A
	for <lists+cgroups@lfdr.de>; Mon, 23 Sep 2024 15:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF915C2C6;
	Mon, 23 Sep 2024 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZG7Fcyx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043E8821
	for <cgroups@vger.kernel.org>; Mon, 23 Sep 2024 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105797; cv=none; b=stiAAu8dVrKc9YzJcPrQmT9+tZNkV4plyeebRE62SpgiHVI7nHx1yGYefDnpOcPtp7XmbjzXagPR8tRCpuGt3OjlrXRZ6xMqmK7ZxhcqXoyr5USo8VJSu/UDBeKmHXXzaA7NGKsBsSP4Cb6V+QZDnQtCmObBrb207+CHc925pV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105797; c=relaxed/simple;
	bh=cx668J1SqQouKhgwxQ/qcGaw8Om61ovMVE7yU2u7/20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMp/pLB/PGpj3Hf0C6EeGIlRP8aQ6GQGI2xI0dPQQqQBkzIOj9OCxiZzJLDQROjzR8SfzLZks42AZYfnl5qrwvIIY+3ncZ+fmMVUH9k3zoqY02q6laoZj6wF48MrXI+aPzEYxxM54h36SqN6HMCa9BrVZ8YhUw+CnoVlQt1Utbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZG7Fcyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9129C4CEC4;
	Mon, 23 Sep 2024 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727105797;
	bh=cx668J1SqQouKhgwxQ/qcGaw8Om61ovMVE7yU2u7/20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZG7FcyxdcohXQdlbS/8TIlpFHNkosaH946AgcZMclH6Dx1/5J4Mn/mhg6fbxDtVY
	 JBHLpWozoPOS0i1e/Yvhkyc/0I1+FW0HRWkz5f1T4xbWXgeS4DYkldmHhRpH2mhup8
	 79CPMe2E5HTiLwE0eiq24BHRW89zXjNNV1BZOONkcD603AHCiFrU9zv01XPTvbHyNn
	 36s6rxtQ1gMAggJbxvMM89PXMDFE9waepbtMKmgF9sOD4mRCUxhHclQg/+xd9R4yL7
	 tE/XIT2fbogNuSGNgXHfhCsHXqu2sRNLbyMzQzMOE8MpjPf2QjdShnKTJChtFtT55k
	 0wTKF1Mzm/GXA==
Date: Mon, 23 Sep 2024 05:36:35 -1000
From: Tejun Heo <tj@kernel.org>
To: chenridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	adityakali@google.com, sergeh@kernel.org, mkoutny@suse.com,
	guro@fb.com, cgroups@vger.kernel.org
Subject: Re: [PATHC v3 -next 0/3] Some optimizations about freezer
Message-ID: <ZvGLAwzherQwdP_P@slm.duckdns.org>
References: <20240915071307.1976026-1-chenridong@huawei.com>
 <d9a9186b-8b4b-4ead-8e39-83b173539f3e@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9a9186b-8b4b-4ead-8e39-83b173539f3e@huawei.com>

On Mon, Sep 23, 2024 at 11:37:14AM +0800, chenridong wrote:
> Friendly ping.

Will apply after the merge window.

Thanks.

-- 
tejun


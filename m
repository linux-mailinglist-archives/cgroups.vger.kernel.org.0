Return-Path: <cgroups+bounces-4825-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4359743D0
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 22:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6F61C256E9
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 20:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F3F1850B5;
	Tue, 10 Sep 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCrrW5HD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD842176252;
	Tue, 10 Sep 2024 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725998567; cv=none; b=Lzoz9eSpkeIVxcuMO/PcD+RBIf0R+SR1VMMd2HIRX974YORDQ/Fbf5YO+ArSnvMfGQB1K0VqHYoG7fNdwYAduYkFutcpEejE8QjoLP9vx2jVi2L4TSX5AwUtkzE8pO5xqHqu4p+Gr4yvnuUoy+T3/gm+NaaZ3oK8rdBKPcdVRMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725998567; c=relaxed/simple;
	bh=dp2BYi02YNW2K4ppjPhhoQskIQuheiFsgBa6IjkUdgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ikf+A0pGH74NxLme1vAbCRdakogI+AXE+ngiily+UbO5j4X9VLGj2xuA2Pvm9g11g4EzN0verfzwh5svqKpyi4JKo3zUu6JQ1WJ/8dcbE64STcovxHXkF06IRQomDx0Bnxx0lCE1piz34UKWnZePQxDXzlW/WU82YJbmnNcZShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCrrW5HD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AD8C4CEC3;
	Tue, 10 Sep 2024 20:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725998566;
	bh=dp2BYi02YNW2K4ppjPhhoQskIQuheiFsgBa6IjkUdgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCrrW5HDLWDTCJpkMca0FuyQ2ykh64DrNfXbg09aIbFbjBa5u/n9/CXA3+ABSeVM+
	 kN2Y3zqwk7ULyotnjkr38RYdT8VdoH85OHtMPWrr7D6XiwERy4rvRgAFh/71udauq+
	 HbG9qkbZ1MBA3paBnbfY3L/beuWLLsBk+4kAaODBMQkaLxp2Y4S6wVxHdqzfZBf2Nr
	 jl3VQCrhXszie4rtnxEJPAkklqTwSd6tZyPqEhpFGFf0p59dqcjnAgEluTldHWRJME
	 CMNYVtcDBHTBzRC7klzVRs17RBKz+7i+1Cru659WDFymsWzKI2RoiCK2rJavuWHhpg
	 sTYmC5Y8LMnWw==
Date: Tue, 10 Sep 2024 10:02:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH 2/4] cgroup/cpuset: Expose cpuset filesystem with cpuset
 v1 only
Message-ID: <ZuCl5ZwuV9zaYXRd@slm.duckdns.org>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-3-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240909163223.3693529-3-mkoutny@suse.com>

On Mon, Sep 09, 2024 at 06:32:21PM +0200, Michal Koutný wrote:
> The cpuset filesystem is a legacy interface to cpuset controller with
> (pre-)v1 features. It makes little sense to co-mount it on systems
> without cpuset v1, so do no build it when cpuset v1 is not built
> neither.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-6.12 w/ a typo fix and Waiman's reviewed-by added.

Thanks.

-- 
tejun


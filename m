Return-Path: <cgroups+bounces-4859-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3079760E2
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 08:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F91F1C22D29
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 06:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6A618A6C7;
	Thu, 12 Sep 2024 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hX/tlpSC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95300188927;
	Thu, 12 Sep 2024 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120789; cv=none; b=EM5slDdUw7wG/h+LSmIpZeO+SXtF0nR3nuSXBT/RNJDUdNRMf92KMB8eRKykUJJSjrvtyuOyY6Xnc9/763sdHu2qadfQnBYv5gi748jyISDZ+nKjUDgbrhRQy7VaENG904XJQJQE3Zqz7VRuhmARvHrDTsqXZ+3X0MYA8mY4/j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120789; c=relaxed/simple;
	bh=pdGCoDLFknytFHxTBZchFqbIFEPSKZ3Zw/2AcW44moI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDgYKep+aGmAzaGmp8wwAam6ul4pGIkbDoovxoDj335KQcPiQkcr5WEzre1P4xcsOfNkYXGCqJkLcDgBSoJI6ieqPNY7H6WAqVegPx45unklPwtNtmW2HW62FZZ6P7N09t75Hg4PjTFqJB1Ynv3dUjrS0r26nyPQnFet68/StM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hX/tlpSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54C8C4CEC3;
	Thu, 12 Sep 2024 05:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726120789;
	bh=pdGCoDLFknytFHxTBZchFqbIFEPSKZ3Zw/2AcW44moI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hX/tlpSCw22C5Ky+HJ5qpqOQ2efapTaR1qLD0HzzH3EKyTmmt3FgxC2ANKfF81WZd
	 H6ZJhBApc6Ks5hlOrhiAUYmpRhr73yimCgyJ3llNHzbACgCoJzDCEg4cIIjR9nb2Mp
	 BP8Ci/yji6UH/Uz6g8PnZLjS49piVKCIMZ3ENywKcgtI4UrWRCifGpFvYA5r4oPiYr
	 1MovcyP5eG3DlNS/5IfUHbuKweg7KwIiV9PzdctnwWSrTfOgcl8BA7QcKqiZp3vSVN
	 rmy19Hh3DE4S/gmZ+wSp2U4PFk80f1Yuh72UKYKXsXP4pPWHywzbdwVRoIpM5S89Fg
	 vshqC6kmwYjPA==
Date: Wed, 11 Sep 2024 19:59:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Chen Ridong <chenridong@huawei.com>, martin.lau@linux.dev,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
Message-ID: <ZuKDVMTvy5Q8evSx@slm.duckdns.org>
References: <20240817093334.6062-1-chenridong@huawei.com>
 <20240817093334.6062-2-chenridong@huawei.com>
 <kz6e3oadkmrl7elk6z765t2hgbcqbd2fxvb2673vbjflbjxqck@suy4p2mm7dvw>
 <07501c67-3b18-48e3-8929-e773d8d6920f@huaweicloud.com>
 <ZuC0A98pxYc3TODM@google.com>
 <ZuC3femqBNufgX1D@slm.duckdns.org>
 <83cea8c6-d2f8-42f2-990e-80412ebf296e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83cea8c6-d2f8-42f2-990e-80412ebf296e@huaweicloud.com>

On Thu, Sep 12, 2024 at 09:33:23AM +0800, Chen Ridong wrote:
> I will add a patch do document that.
> Should we modify WQ_DFL_ACTIVE(256 now)? Maybe 1024 is acceptable?

Yeah, let's bump it.

Thanks.

-- 
tejun


Return-Path: <cgroups+bounces-5570-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47D19CD509
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 02:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD351F21C51
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 01:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4304F5B05E;
	Fri, 15 Nov 2024 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WenNt2wL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2038DDB;
	Fri, 15 Nov 2024 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731634101; cv=none; b=aSdF4CIEVE9Wpu1J7jl2INwHyrCw5pTwb+Uygb0vy8CjbvrlFY0QM2G6ZNiYGgT5cFULoYKAF9AXPgfCDUhK2D3S2wHb7k+9eI/XKDazb8vQjRbx1iclFt3a56e4A04K+ZZBJ9RPKhw4/3wtiM98gTTwyoYgxR1GmcXxjGwcOoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731634101; c=relaxed/simple;
	bh=mBNK/YSrMUfB1C41jB/Z/WgXfU6bbRvm6v5kByx3T3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJy9Of2vgazHQIhH9Cbc2DwWnQpvp3kWWiViwh0+eCShqND6ASetIgMP9qen/58uDyUdJ5uXeGjGJc9VPc/3GXPZdw3nwugohCYoV/WLT2eUxS3/OXNuVKfv+s59hFhFCYPPtq7bDaAFSJGdcP3rdSm0rrxvvJELIMoKxkPOTaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WenNt2wL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4301C4CECD;
	Fri, 15 Nov 2024 01:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731634097;
	bh=mBNK/YSrMUfB1C41jB/Z/WgXfU6bbRvm6v5kByx3T3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WenNt2wLnoQmPzosbwmf/D+J/pegjpn7PJB+L1CiWO/JkL2iHpVPZFcLXjdphSyfU
	 I1YSWIFEy1AXcmr+grCR5glqwxvGnJTgshNHF48DrbkCIPgdplQfDMfW3UwvrVL14y
	 VUoBLWdbJWumENf9APsR9iDl3Jbg4B6UEkTnjc5/yJqbvLo2J7Wyti4P2yQwB07WzU
	 G9QIulKhdxDFE7EQ4H7m42b+sE93u5CijhKUCeNUJpyQeqIBgm6BAAAQ/fRl/6JTuj
	 ee2+09zap33hHhP87jMXUMKniP8lhWZdivcsKCjE9hwHh5WJEzqWs35ITn4JJEI8YM
	 DRupvuJE0UCSQ==
Date: Thu, 14 Nov 2024 15:28:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Valentin Schneider <vschneid@redhat.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	=?iso-8859-1?Q?mkoutny=40suse=2Ecom_=3E=3E_Michal_Koutn=FD?= <mkoutny@suse.com>,
	linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] freezer, sched: report the frozen task stat as 'D'
Message-ID: <ZzajsLHrXXtYk04l@slm.duckdns.org>
References: <20241111135431.1813729-1-chenridong@huaweicloud.com>
 <xhsmhv7wrb3sc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <4f78d752-52ab-493d-8bf5-f12dc4f554c8@huaweicloud.com>
 <ZzYo19k9ZvkC7V-1@slm.duckdns.org>
 <2f755161-ec7e-4785-b0ca-ea68c01785a2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f755161-ec7e-4785-b0ca-ea68c01785a2@huaweicloud.com>

Hello,

On Fri, Nov 15, 2024 at 09:14:32AM +0800, Chen Ridong wrote:
> Hi, Tj, There is no ambiguity what cgroup v2 shows. However, in cgroup
> v1, the frozen tasks are reported as 'R'.  Do you think this is reseanable?

Oh, right, pardon my confusion. I thought this was about cgroup2 freezer.
For cgroup1 freezer, yes, D is the closest state for reporting to userspace.

Thanks.

-- 
tejun


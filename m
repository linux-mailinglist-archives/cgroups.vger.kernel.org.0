Return-Path: <cgroups+bounces-5795-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F029EC4E6
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 07:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B08282716
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 06:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C40E1C4610;
	Wed, 11 Dec 2024 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucaVq7pq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69126DCE1;
	Wed, 11 Dec 2024 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733899150; cv=none; b=JRdUAE0C+wgtnZLu5DXipgaW7nQWnANxiEtzBihemhYBTdhROvB/u5cP36UfzxkQ257kCj3328I2jYKVObpHH67d0Mp/nzjgdJasIwt/N/AT/D2HZcVWWlt3ih7iFFI6CiHI7fJ839L8/NsalOJqhyFsMSVDPRZ+YCLmR9d5nGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733899150; c=relaxed/simple;
	bh=a7Xg0S1Jly5/05RvJ5drEAApmT9tg80lqVKE2mqedmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLhRXDOatUT+jl2VEr8OPHLv6+Gjt59sivUtaecBH7EF6LodsTH0u3L+ojtN6ZS1C0IZDEAzpTfytGZqohIqMpGuaiaO1Vcp1Ie8y13RfFMQI+rYiKkk6nsEZj0hd4gyZ4c2ByemDKJwAQcy07/Kkqce1aN2QRbnoSDiR2es2Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucaVq7pq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C38DC4CED2;
	Wed, 11 Dec 2024 06:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733899150;
	bh=a7Xg0S1Jly5/05RvJ5drEAApmT9tg80lqVKE2mqedmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ucaVq7pqP3yD5KTEXYpa5uDTAABxclEnm5g8WOIphoB258hbi5aaQJ2735+zMTMte
	 s5CFeZFci3F4px6jXWW4cT3ScGRzvs6gJjzSEl3Baj7W9dzJ6w0g6KL5fJYcZekcZE
	 sltEDF16Ytrs0slDwqhtGWvBhOgoOFWFcREz+h4VuPznNqjy5Z7cFOiSFELbZRNSkI
	 dnK6g6JW2Dw87ERebkWj38gn8VYKnc7i9EDFgA2HXiKgTG9XVc5T/MmBt66G1+MtWc
	 xsWeI7ysR1AZoJFwv6zUmtogCujKi20Cxd3SgoRSC6tf6ISSB997rjSOTYCDzWpLoR
	 jpofYy74saalQ==
Date: Tue, 10 Dec 2024 20:39:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: Remove stale text
Message-ID: <Z1kzjcYmH-a6_SxW@slm.duckdns.org>
References: <20241204110442.348402-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204110442.348402-1-costa.shul@redhat.com>

On Wed, Dec 04, 2024 at 01:04:41PM +0200, Costa Shulyupin wrote:
> Task's cpuset pointer was removed by
> commit 8793d854edbc ("Task Control Groups: make cpusets a client of cgroups")
> 
> Paragraph "The task_lock() exception ...." was removed by
> commit 2df167a300d7 ("cgroups: update comments in cpuset.c")
> 
> Remove stale text:
> 
>  We also require taking task_lock() when dereferencing a
>  task's cpuset pointer. See "The task_lock() exception", at the end of this
>  comment.
> 
>  Accessing a task's cpuset should be done in accordance with the
>  guidelines for accessing subsystem state in kernel/cgroup.c
> 
> and reformat.
> 
> Co-developed-by: Michal Koutný <mkoutny@suse.com>
> Co-developed-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

Applied to cgroup/for-6.13-fixes.

Thanks.

-- 
tejun


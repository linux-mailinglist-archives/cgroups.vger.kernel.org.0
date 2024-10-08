Return-Path: <cgroups+bounces-5073-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD6699570E
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 20:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393BA1F27A9F
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 18:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402292139D7;
	Tue,  8 Oct 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM85hDsE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3A212648;
	Tue,  8 Oct 2024 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413114; cv=none; b=tzD/sOji8OKRvwFq0d6DYbDiWLHfYdCWqL0mvWOcZ/hXURDcb9JHTeomTNljLLQ8SVc7PQKQet6y0HmEq5hyg5GLBMYXQ8wgX0TSUVPmOhSOpKkZ32jNLEeUQOMEY8FDpApICHHRsy6ZOycLMICak92Pucz87ANwwlZG2AtyEvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413114; c=relaxed/simple;
	bh=ucT9n6rJEMAxgdbuMowKn28E0NcqrYsXSzXVdDt9ldo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsLxNmGd/4E26wtO+nOM2zmh0VSkIiTIkUrQY+whTaWiAbyK+LjvyffLv8CribwMnSTjYtXhG1eA35xxYMCZR6wZcvIMgTBe1IsL192SM2uMlcB0onKL8KX6mmAv171b0Qu8Y8ZRzlKPyYz10dS/RJ5zoMiS3JqfFlEnrHyc1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM85hDsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AF3C4CEC7;
	Tue,  8 Oct 2024 18:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728413113;
	bh=ucT9n6rJEMAxgdbuMowKn28E0NcqrYsXSzXVdDt9ldo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GM85hDsEY6GFpGaeY3f58Z1jA1Dix7V/+EmY/11KDjzOaWmuWqmimvyXlWqCvBi26
	 TJL0t3Rek73y1xM7dFBdR/O95DKfOkppfk1M6gLAid1/cXVTwL/rPF/iEQCTwznmcC
	 uTH7baFE5FgpqEKJ63thk/fUzhKhuR4yALcq79rQPYlveVZTKyOxj8xMBaiOYJBKet
	 VT2lAfCplHmw/kzzRrsvL473saP7fTULQ1GWJwKKmhRBVk1nPFpbeLEh/FFksYawnU
	 Q6/YA66R3keaQ2mqbDi9YLyOCcnZiIaL/1P0/rvdwRANgBsh0Y5a+lprOlUP5My0vp
	 q+Tb9F5HPIllA==
Date: Tue, 8 Oct 2024 08:45:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, mkoutny@suse.com, bpf@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenridong@huawei.com
Subject: Re: [PATCH v6 1/3] cgroup/bpf: use a dedicated workqueue for cgroup
 bpf destruction
Message-ID: <ZwV9uH30yukKQeSZ@slm.duckdns.org>
References: <20241008112458.49387-1-chenridong@huaweicloud.com>
 <20241008112458.49387-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008112458.49387-2-chenridong@huaweicloud.com>

On Tue, Oct 08, 2024 at 11:24:56AM +0000, Chen Ridong wrote:
...
> To fix the problem, place cgroup_bpf_release works on a dedicated
> workqueue which can break the loop and solve the problem. System wqs are
> for misc things which shouldn't create a large number of concurrent work
> items. If something is going to generate >WQ_DFL_ACTIVE(256) concurrent
> work items, it should use its own dedicated workqueue.
> 
> Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from cgroup itself")
> Link: https://lore.kernel.org/cgroups/e90c32d2-2a85-4f28-9154-09c7d320cb60@huawei.com/T/#t
> Tested-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Applied to cgroup/for-6.12-fixes w/ stable cc'd.

Thanks.

-- 
tejun


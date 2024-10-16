Return-Path: <cgroups+bounces-5145-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 613ED9A1048
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 19:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F41CEB235E9
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB9F206971;
	Wed, 16 Oct 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g364JahB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A8E136358;
	Wed, 16 Oct 2024 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098270; cv=none; b=B6ZFNKIgfvmzJBTuBUtsQBWIBhNDD+mcZHrq/HWcsxKAl9SOvaeXOV8xtbRtd8aHzabeYBL160i+Wg407W0W82IJahP2oKcTfqlx+CxlWyhNEsqGfHvjW8g1a0ow5tUgrG9czMUi0sFYNzM7/h81L1dqxYjneCLcMTFYD/K6LWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098270; c=relaxed/simple;
	bh=CX9Vtd5JRZ6CUj4QoB0EX1rOR78R+P7OGs4cTTtUhI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKcCrWZXMKuKgWWwJIPI3OhQd1ig9wIF4Sz4T4f5E4P3N+JsnHzcaLO5doJXGCmwLGwFehU2Jgr8ur98aCjPBUxqpWnHEV8CqS7OZGj55JKPI2hyB8AcOr19MTw3Uf3Ke1aGPSAyGxvimQX+6p2QbA56wPDv24U78M60uwK+SMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g364JahB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826E8C4CEC5;
	Wed, 16 Oct 2024 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729098269;
	bh=CX9Vtd5JRZ6CUj4QoB0EX1rOR78R+P7OGs4cTTtUhI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g364JahB/sCv2dpwVHTq9xHoZ3GytonbE9O0BaXmDiLo/QDpsa5qKPYXo+Uo2TDSH
	 PMzNjkVvUd1vMkoaNtUzzqObCBJRnT4znktf4E2O6rloekXsbyZ/qRvSG9HZhvbTwu
	 0hTLGfQr7rUcXFiMMd9vmdWvHYZ39rnCwOobBYlns2FysIv8rA5YeRd9oeDG6kXUzx
	 spmXwBOF4LCxaMQQ4RPhUHlp/P5I6dYW0Ghun6DpyXanxFgzD/2aScpKdAjEfZIziC
	 4BJS2Z/DrhaCLuZJGbscXnDBUp13ppXL6YkU4Tf6RxqyBDjE5fx8ayCqrd769NqR3g
	 xNI2WUsMin+Jg==
Date: Wed, 16 Oct 2024 07:04:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, longman@redhat.com, john.fastabend@gmail.com,
	roman.gushchin@linux.dev, quanyang.wang@windriver.com,
	ast@kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH] cgroup/bpf: fix NULL pointer dereference at
 cgroup_bpf_offline
Message-ID: <Zw_yHEJCBwtYFJoR@slm.duckdns.org>
References: <20241016093633.670555-1-chenridong@huaweicloud.com>
 <bidpqhgxflkaj6wzhkqj5fqoc2zumf3vcyidspz4mqm4erq3bu@r4mzs45sbe7g>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bidpqhgxflkaj6wzhkqj5fqoc2zumf3vcyidspz4mqm4erq3bu@r4mzs45sbe7g>

On Wed, Oct 16, 2024 at 03:13:52PM +0200, Michal Koutný wrote:
> Hello.
> 
> On Wed, Oct 16, 2024 at 09:36:33AM GMT, Chen Ridong <chenridong@huaweicloud.com> wrote:
> > As mentioned above, when cgroup_bpf_inherit returns an error in
> > cgroup_setup_root, cgrp->bpf.refcnt has been exited. If cgrp->bpf.refcnt is
> > killed again in the cgroup_kill_sb function, the data of cgrp->bpf.refcnt
> > may have become NULL, leading to NULL pointer dereference.
> > 
> > To fix this issue, goto err when cgroup_bpf_inherit returns an error.
> > Additionally, if cgroup_bpf_inherit returns an error after rebinding
> > subsystems, the root_cgrp->self.refcnt is exited, which leads to
> > cgroup1_root_to_use return 1 (restart) when subsystems is  mounted next.
> > This is due to a failure trying to get the refcnt(the root is root_cgrp,
> > without rebinding back to cgrp_dfl_root). So move the call to
> > cgroup_bpf_inherit above rebind_subsystems in the cgroup_setup_root.
> > 
> > Fixes: 04f8ef5643bc ("cgroup: Fix memory leak caused by missing cgroup_bpf_offline")
> > Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> Hm, I always thought that BPF progs can only be attached to the default
> hierarchy (cgroup_bpf_prog_attach/cgroup_get_from_fd should prevent
> that).
> 
> Thus I wonder whether cgroup_bpf_inherit (which is more like
> cgroup_bpf_init in this case) needs to be called no v1 roots at all (and
> with such a change, 04f8ef5643bc could be effectively reverted too).
> 
> Or can bpf data be used on v1 hierarchies somehow?

We relaxed some of the usages (see cgroup_v1v2_get_from_fd()) but cgroup BPF
progs can only be attached to v2.

Thanks.

-- 
tejun


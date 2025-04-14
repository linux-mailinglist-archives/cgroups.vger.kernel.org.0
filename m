Return-Path: <cgroups+bounces-7521-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B73A88A34
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 19:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9AC3B74EA
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D55294A1B;
	Mon, 14 Apr 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6Dq8boi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF7294A0D;
	Mon, 14 Apr 2025 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652551; cv=none; b=a4u7zJ0pW5AL1e8kcvcNdzcffWuodNp49Oi7Bv+p/eCaCyM7YzHHfaAOw73+8LfLO7PyMMeYV8uLvFtZqCkh7WSwUaRp8GsbBbMYlaahzLihzJ1U628jIFeAYuhV9oiVWmcIXzBeP2Cgb+GZ1d7OskoBTkAGVajlus9PHJPTRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652551; c=relaxed/simple;
	bh=rHNqKe0wnjxL9vRhO3SMhzsHYmLDT1uHMStxy6Kmuow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1oCKEZyE+oOjebdMOeE9UaPJnlRMbCVFy9lUlHGzqsym/8fixPhjtzFKhM+HxdcaftoCRobMN1t2dNXccxaICtDB1l5j2u6KRHAypPbF43wn/i61jlmExFZ8BOwQejQHejo0DKguWHCc6CPF1z4Uphe90o8owWL1FIGBud+2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6Dq8boi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2152DC4CEE5;
	Mon, 14 Apr 2025 17:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744652551;
	bh=rHNqKe0wnjxL9vRhO3SMhzsHYmLDT1uHMStxy6Kmuow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6Dq8boiwz+d7sr6d7OCABDDiuE79ezZp447ak8CGukiVmWVkUBLVmqLf5ibin3mE
	 +UMqUQHWbCzBh2PPIYYJQ9sVp6OgcGfQF15c8cBKXN+ju2uHHfUtR7Ac6m1gUg/qZD
	 T0fx0tbQC0vtClBqf2kE8JHbG80SuUnso+zUp2AtIz/EhND09CQ6pOkzBByvu4sIzJ
	 ZVs+HbVO6pJXKZUcuPiSGxJ/71PkOJBy53L87lMwtydwgR7IRuC4ahp1Z7CmvgAlJ3
	 2owF3lLT2QjX6nUj+3PDJLMApo9VKxU9U3Tl4uf3fQ5qDApwRExGKDp8iCe3IAOHE+
	 BwtHYpoe64NIQ==
Date: Mon, 14 Apr 2025 07:42:30 -1000
From: tj <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: ffhgfv <xnxc22xnxc22@qq.com>, hannes <hannes@cmpxchg.org>,
	cgroups <cgroups@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: KASAN: slab-use-after-free Read in cgroup_rstat_flush
Message-ID: <Z_1JBt3RMATxnDgL@slm.duckdns.org>
References: <tencent_084EDA1878C098FFB951DC70F6FFCC896408@qq.com>
 <djupj4qfnd2izxhtzkmmhx6bfmnn3462dqi45qwbmdj46twart@424eqzhhh2s3>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <djupj4qfnd2izxhtzkmmhx6bfmnn3462dqi45qwbmdj46twart@424eqzhhh2s3>

On Mon, Apr 14, 2025 at 07:40:04PM +0200, Michal Koutný wrote:
> Hello.
> 
> On Mon, Apr 07, 2025 at 07:59:58AM -0400, ffhgfv <xnxc22xnxc22@qq.com> wrote:
> > Hello, I found a bug titled "   KASAN: slab-use-after-free Read in cgroup_rstat_flush " with modified syzkaller in the Linux6.14.
> > If you fix this issue, please add the following tag to the commit:  Reported-by: Jianzhou Zhao <xnxc22xnxc22@qq.com>,    xingwei lee <xrivendell7@gmail.com>,Penglei Jiang <superman.xpt@gmail.com>
> > I use the same kernel as syzbot instance upstream: f6e0150b2003fb2b9265028a618aa1732b3edc8f
> > kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&amp;x=da4b04ae798b7ef6
> > compiler: gcc version 11.4.0
> > 
> > Unfortunately, we do not have a repro.
> 
> Thanks for sharing the report.
> 
> > ------------[ cut here ]-----------------------------------------
> >  TITLE:  KASAN: slab-use-after-free Read in cgroup_rstat_flush
> > ==================================================================
> > bridge_slave_0: left allmulticast mode
> > bridge_slave_0: left promiscuous mode
> > bridge0: port 1(bridge_slave_0) entered disabled state
> > ==================================================================
> > BUG: KASAN: slab-use-after-free in cgroup_rstat_cpu kernel/cgroup/rstat.c:19 [inline]
> > BUG: KASAN: slab-use-after-free in cgroup_base_stat_flush kernel/cgroup/rstat.c:422 [inline]
> > BUG: KASAN: slab-use-after-free in cgroup_rstat_flush+0x16ce/0x2180 kernel/cgroup/rstat.c:328
> 
> I read this like the struct cgroup is gone when the code try flushing
> its respective stats (its ->rstat_cpu more precisely).
> 
> Namely,
> 	__mem_cgroup_flush_stats
> 		cgroup_rstat_flush(memcg->css.cgroup);
> this reference is taken at cgroup creation in init_and_link_css()
> and released only in css_free_rwork_fn().

Maybe another casualty of the bug fixed by a22b3d54de94 ("cgroup/cpuset: Fix
race between newly created partition and dying one")?

Thanks.

-- 
tejun


Return-Path: <cgroups+bounces-6116-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A96A0FFB6
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 04:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE13D7A2AFC
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 03:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EB722FE16;
	Tue, 14 Jan 2025 03:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="l4xnWvRe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58D1E4A4;
	Tue, 14 Jan 2025 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826348; cv=none; b=mUbaSMIKG7WgXLyYwn1dNZ0TYzkzNdrktgr29REYgHiVY8D/DGKsZpQl/9RJakg4DqodYO11mXPDLU4xJGygOe5oN3Hk+nSsNNcJRnutjTiCOg6ZICc8IoOHBAxcJVY+6Hsv1ForrMDap/KdPwemzas8EBZWOb03SwO6f3OQW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826348; c=relaxed/simple;
	bh=S9/mJqNvgVCYUx8ZpWZUpeA5W4YEkSbONpCP6gTCHdQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hnv0cwGD4PBV0uyS1hId1IW7pJXzgqrbr/m8zVm8qKYKKFAQV4oWDzdeWqFoRlmfcYjdSVF1W276bP3qKP7aFQ9frU0oD57EnCV0KU7UcQNa1VhZjmuIGm7tecAGeD/nA+4kSUZeJN1wUrjxWSpIQNi1QYZHo0egrp9Skit5TgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=l4xnWvRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ECDC4CEDF;
	Tue, 14 Jan 2025 03:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736826347;
	bh=S9/mJqNvgVCYUx8ZpWZUpeA5W4YEkSbONpCP6gTCHdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l4xnWvRet4z0e7dQuQmyY2RR0PYjtekU1sqenPc/vtjMTz1CW8WrNiItDlMshUcfO
	 HGtdjCnM3eoTmh4ZMcIIKDChRpX7Qa9U1xSfXOnU0cqiU/0MgS1+xFl76x0NrGnErl
	 /n8ZQXikiCLz9+RSIog8tIPmKvWmQDj4cwemTAbc=
Date: Mon, 13 Jan 2025 19:45:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org, hannes@cmpxchg.org,
 yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, davidf@vimeo.com, handai.szj@taobao.com,
 rientjes@google.com, kamezawa.hiroyu@jp.fujitsu.com, RCU
 <rcu@vger.kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
Message-Id: <20250113194546.3de1af46fa7a668111909b63@linux-foundation.org>
In-Reply-To: <58caaa4f-cf78-4d0f-af31-8a9277b6ebf5@huaweicloud.com>
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
	<1ea309c1-d0f8-4209-b0b0-e69ad4e986ae@suse.cz>
	<58caaa4f-cf78-4d0f-af31-8a9277b6ebf5@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 14:51:55 +0800 Chen Ridong <chenridong@huaweicloud.com> wrote:

> 
> 
> On 2025/1/6 16:45, Vlastimil Babka wrote:
> > On 12/24/24 03:52, Chen Ridong wrote:
> >> From: Chen Ridong <chenridong@huawei.com>
> > 
> > +CC RCU
> > 
> >> A soft lockup issue was found in the product with about 56,000 tasks were
> >> in the OOM cgroup, it was traversing them when the soft lockup was
> >> triggered.
> >>
>
> ...
>
> >> @@ -430,10 +431,15 @@ static void dump_tasks(struct oom_control *oc)
> >>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
> >>  	else {
> >>  		struct task_struct *p;
> >> +		int i = 0;
> >>  
> >>  		rcu_read_lock();
> >> -		for_each_process(p)
> >> +		for_each_process(p) {
> >> +			/* Avoid potential softlockup warning */
> >> +			if ((++i & 1023) == 0)
> >> +				touch_softlockup_watchdog();
> > 
> > This might suppress the soft lockup, but won't a rcu stall still be detected?
> 
> Yes, rcu stall was still detected.
> For global OOM, system is likely to struggle, do we have to do some
> works to suppress RCU detete?

rcu_cpu_stall_reset()?




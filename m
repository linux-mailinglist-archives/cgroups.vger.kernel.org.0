Return-Path: <cgroups+bounces-4918-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6298797D9CA
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 21:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267F6284103
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 19:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E09A184540;
	Fri, 20 Sep 2024 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiA6engl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040EC17C217;
	Fri, 20 Sep 2024 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726860215; cv=none; b=VjhM1qMGYhsVGuYYuJkRHIAdNZU5TDB2SYMxXm8jkZUyyjaJaeEyhsLJIyEKNozfxKqZcAVMAeWDxe1gbj3bhYilmEwIkeAmqNWi9ecpBdLgx3lCFy77wF89hbd97Q1uZidWr1DC+IZ1Kqfhl39azxntrM6D1smM1Cw5zDWmNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726860215; c=relaxed/simple;
	bh=IiY9MEWVuAKFZDe6thj87PaPMOK8LxMPdg86MnqrlOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb2bHec9lY64IqRVxBKwW1wX/jrZ6NrEvt0FHPVcuEcmRDKIzAtQCV5XoG8NfPmT0zSAJI4pYq6i9dmJZNpvu0OK4vFweD3enuH4BLeY+4KUA1wssAD0pRnaAK+Dcooxu/1jC089xQwMtnNMSd4Vc8mF0GC7YT4qEOOm8p9kAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiA6engl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB99C4CEC3;
	Fri, 20 Sep 2024 19:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726860214;
	bh=IiY9MEWVuAKFZDe6thj87PaPMOK8LxMPdg86MnqrlOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jiA6engl8hu42lLOARiA4L8B7vDdJgXBTYOcqHpy2sfQRdBLNMf2Ub027qFIlfXTS
	 x6MFaZFkXru1eR9PbHsJVP8Rdf4sBRRQ0STlHIbTrieol+EUOHwjMYntvWGKOnZqy7
	 eemzCNL0heo3IBF2HyyKT6Yvgl1XUX1+1JA6N7Cti5d6Az/YicubPrKHobV7STSegG
	 CU8beZ2A2f7RrysTY4NHQKG8OejjppqVHj8kDXM8KK6ZGlep7NguqAvhU5qQ2kH9ss
	 K3VVxt80kZnm66+FHu/QCoRYOgKz2Z6Ay/eClsPWJZKX6fraTEpJ3TZPnI+huUjPa9
	 6fsXFAeVNbS8Q==
Date: Fri, 20 Sep 2024 09:23:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	bpf@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
Message-ID: <Zu3LtU9HUY3XH1WV@slm.duckdns.org>
References: <20240913131720.1762188-1-chenridong@huawei.com>
 <eaa664da-8d88-486c-9793-09a97d8c607a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaa664da-8d88-486c-9793-09a97d8c607a@huaweicloud.com>

On Wed, Sep 18, 2024 at 05:44:47PM +0800, Chen Ridong wrote:
...
> >    cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
> >    workqueue: doc: Add a note saturating the system_wq is not permitted
> >    workqueue: Adjust WQ_MAX_ACTIVE from 512 to 2048
> > 
> >   Documentation/core-api/workqueue.rst | 8 ++++++--
> >   include/linux/workqueue.h            | 2 +-
> >   kernel/bpf/cgroup.c                  | 2 +-
> >   kernel/cgroup/cgroup-internal.h      | 1 +
> >   kernel/cgroup/cgroup.c               | 2 +-
> >   5 files changed, 10 insertions(+), 5 deletions(-)
> > 
> Friendly ping.

I don't know why but this series isn't in my inbox for some reason. Here are
some feedbacks after looking at the thread from lore:

- Can you create a separate workqueue for cgrp->bpf.release_work instead of
  exporting cgroup_destroy_wq? Workqueues aren't that expensive. No reason
  to share like this.

- The patch title is rather misleading. The deadlock isn't really caused
  between cgroup_mutex and cpu_hotplug_lock. They're just victims of
  system_wq concurrency depletion. Can you please update accordingly?

- Can you add a new line before the note paragraph? Also, I'd say "deadlock"
  rather than "block" to properly convey the imapct of such saturation
  events. I don't think "eg. cgroup release work" is adding much.

Thanks.

-- 
tejun


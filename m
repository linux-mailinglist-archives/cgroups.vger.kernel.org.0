Return-Path: <cgroups+bounces-13236-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36804D227A1
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 06:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E68B3301F003
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 05:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A6A2836AF;
	Thu, 15 Jan 2026 05:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AGoi7q8K"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A612367DF;
	Thu, 15 Jan 2026 05:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768456759; cv=none; b=rJuTpr5Pkaa7RRM7hae1P7DtupmQg1FPz6g6RrPeaxuuFMP9VVSAZeLOoEQS8QuJhD9iw2Fciqy0qqKhtlRdgrzGJIrzLyr5BZ26hdg3uQi/jXd2xnmlP3jAIMZaHoqC00qisjhODvGZfrH01fefxTpc313XkYIBUk2viIu+XuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768456759; c=relaxed/simple;
	bh=WaB1WfcSyPRy13gJone2ay7mYx/vRaB7yTVcyMuNWD0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fh+/EMiqfBCBMFz3+wQxETmwRgA1wPY7vTBkgLsetmXiArYDLbhxdl+1ddHTfIHdlfuYlx0c/DVhWC4OWtJp/6yP/jIHu/N/omeyyeR+B0aBqkM2cm0fGmeMqPhPw51O0rEN1iLxRR/ntduIgF7yfe7heSJ2RyvAe0hezYsQaZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AGoi7q8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA83C116D0;
	Thu, 15 Jan 2026 05:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768456758;
	bh=WaB1WfcSyPRy13gJone2ay7mYx/vRaB7yTVcyMuNWD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AGoi7q8K05EyGTE0Hdv5rTXzye2UijvczBaSBIK5VLU/5fA47DnK09MaTwimMwonz
	 4EC4iUpaoSchwE6AceY8N7D9sUEtMLD+noQaqZ/lyqcenW95Y6slunLW0vEGC/B54b
	 K/+k2KHaucsaCGfgumma9d+s8LdgXkUj2RdbQ9Mo=
Date: Wed, 14 Jan 2026 21:59:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 00/30] Eliminate Dying Memory Cgroup
Message-Id: <20260114215917.8eee7b9fa4da37305b74d6f2@linux-foundation.org>
In-Reply-To: <98819615-5001-45f6-8e63-c4220a242257@linux.dev>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
	<20260114095839.eabf8106e97bf3bcf0917341@linux-foundation.org>
	<98819615-5001-45f6-8e63-c4220a242257@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 11:52:04 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

> 
> 
> On 1/15/26 1:58 AM, Andrew Morton wrote:
> > On Wed, 14 Jan 2026 19:26:43 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> > 
> >> This patchset is intended to transfer the LRU pages to the object cgroup
> >> without holding a reference to the original memory cgroup in order to
> >> address the issue of the dying memory cgroup.
> > 
> > Thanks.  I'll add this to mm.git for testing.  A patchset of this
> > magnitude at -rc5 is a little ambitious, but Linus is giving us an rc8
> > so let's see.
> > 
> > I'll suppress the usual added-to-mm email spray.
> 
> Hi Andrew,
> 
> The issue reported by syzbot needs to be addressed. If you want to test
> this patchset, would you like me to provide a fix patch, or would you
> prefer me to update to v4?

A fix would be preferred if that's reasonable - it's a lot of patches
be resending!


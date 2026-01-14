Return-Path: <cgroups+bounces-13218-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B248D20B1D
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 18:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB2A8300BBDF
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 17:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D04D32ED2D;
	Wed, 14 Jan 2026 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b3csv+P8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D532E73D;
	Wed, 14 Jan 2026 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768413521; cv=none; b=Z9f5nbb2sVSgn0zxKZKk7YdgIu65wH4LCEUFA4EJSBwI5L5+vjIbTaZ2Ipxqql6OgH0azkIroif+UIv1GLnEP70CPGsm5cRO0JoTsaQQksBlQFlUbLagoCASqVDfcPZAbbc/gYHF4Qznqww3UCfGlrlMxQvOXVekiVbvl6NeCfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768413521; c=relaxed/simple;
	bh=9Fv9tS9uQrGFTi2th9Xoxxzo7Y0x6OhXx+Sy3T2KfuA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dcE06O6GQL8ahWny2rAKzy0onGDGKxH6ddjYXi5HrwgDzcAmmt/Rlc+n1KBaP7yNaN02ayTXjBHmGV6MXCEBexThaDlmO954Rh0mnsPdPl2O++OBeW4BWVib5oY0CT347Eb4X74mBN5YNJ4qWLTbKpGKb+UWkUlKRqNd77w8jyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b3csv+P8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063F4C19422;
	Wed, 14 Jan 2026 17:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768413520;
	bh=9Fv9tS9uQrGFTi2th9Xoxxzo7Y0x6OhXx+Sy3T2KfuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b3csv+P8615OFxJg1bifahfXhNgrmDvfbhd018ZXmvO7eitG2MqdJPXyle+rSrcrM
	 EQmQSa68tG9p0SMJRibZEokmbdKPpNvodTJ0padh7NBvNIZOaqq6Urq/vFtarrxC5P
	 Vof00TTQn2UmtBLJUXzzleywj758yixQmP37bPjk=
Date: Wed, 14 Jan 2026 09:58:39 -0800
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
Message-Id: <20260114095839.eabf8106e97bf3bcf0917341@linux-foundation.org>
In-Reply-To: <cover.1768389889.git.zhengqi.arch@bytedance.com>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 19:26:43 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

> This patchset is intended to transfer the LRU pages to the object cgroup
> without holding a reference to the original memory cgroup in order to
> address the issue of the dying memory cgroup. 

Thanks.  I'll add this to mm.git for testing.  A patchset of this
magnitude at -rc5 is a little ambitious, but Linus is giving us an rc8
so let's see.

I'll suppress the usual added-to-mm email spray.


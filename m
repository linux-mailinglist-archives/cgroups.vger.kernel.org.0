Return-Path: <cgroups+bounces-13257-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9A6D27B52
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 19:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BD86310524C
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B963BFE4B;
	Thu, 15 Jan 2026 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YT77vFZ2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B53BF309;
	Thu, 15 Jan 2026 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499225; cv=none; b=orTqyUSfPB/zMjQQvr8MwRzQTOG5RjRcX76SCVZZxON9PBn9EmH8GSMPQaRV5LDxbAsrdNA/qqxY0aUkh5Lyp1Ozy9gpNgeRLMPiEX/fJS5RbSImizR3aZ6dsXkTlsL6b4xXRXFvIKW/t7EfLMfQ6S/FZYv0fLXxiW94wD9CVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499225; c=relaxed/simple;
	bh=C0SodaDfVTiyD9izfNenedvQEytBtrnvMR6/MpPi0+Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dyslXeCUFdx+/nFvQVIkfrERRMdh5ycgUrHny6kCECR6KtzL7ybo4v/JF505hVSkSsajjlBuXv/rDCl69DwFRlJkDyfP7McUVn2Dw8pR/M8ZQPE9sPDqVec5mnNkhglheeGN5kQu4gPHgemN8hnmuKHLP5dSrxstK/qJzXDZjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YT77vFZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4442C116D0;
	Thu, 15 Jan 2026 17:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768499225;
	bh=C0SodaDfVTiyD9izfNenedvQEytBtrnvMR6/MpPi0+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YT77vFZ2+7Mb4JRJnlkEcCnCQ3FdCi/XnGOboKt/d4mGB5ja5LxRc2AK/LHwAQK1D
	 r2IzpDbFlLtgWyVyyl0Dy4RU9OnH55YSUvc85GZ7VFqSc7zqtiR4SALjv7HmtZs/Jj
	 i1UfLPTGugFvU3Ffxhzzq9yBJ3aZKF79RmfCPLJY=
Date: Thu, 15 Jan 2026 09:47:04 -0800
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
Subject: Re: [PATCH v3 28/30 fix 1/2] mm: memcontrol: fix
 lruvec_stats->state_local reparenting
Message-Id: <20260115094704.17d35583bbcff28677b5bc12@linux-foundation.org>
In-Reply-To: <e5afd1b5ae95d70f82433b9b4e13201342d16707.1768473427.git.zhengqi.arch@bytedance.com>
References: <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
	<e5afd1b5ae95d70f82433b9b4e13201342d16707.1768473427.git.zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 18:41:38 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

What was "fixed"?

I queued this and [2/2] as squashable fixes against "mm: memcontrol:
prepare for reparenting state_local".



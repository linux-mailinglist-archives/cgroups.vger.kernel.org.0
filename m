Return-Path: <cgroups+bounces-9388-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30042B34A0B
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 20:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D87994E23B8
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 18:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8FE2798FB;
	Mon, 25 Aug 2025 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH8nY2EE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0B1CEAB2;
	Mon, 25 Aug 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145883; cv=none; b=VF8wZ+lNAmuH27DhncEkqTAbg/Tu4ClsOX3KxZVw3f5iNZNa/BZKAMpN0CfHstQrUknpBsYxfqqcI1xv2Koh9h6ox54xgyA+qIsquWBdmWVQ/EzOiKsnFTLKyi6orOb+/8GsE/VXMly68JAxNiFe6oxS07Q/+MAZ0ZjiSI9UtgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145883; c=relaxed/simple;
	bh=o2zMb7DV0FaHdjnAmQJKIBUjG4tlL5qOjSszG3XrUBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVc60SZ2SZ+xgD7F+K9hiKXNFZKTnWe4salAcBnTVLCv8orZFZ3nMdMlzj3AJ/pi4oXcAc+YGP1UApmMQG2jVHBm1jnkZhcPYSQtP5Pd+5uCzzGyYaRlgAFZAThxfYsFKCkdAWlz7iyZCL1RPNJ/iBdcG2hTS4UaTk7La4WA+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH8nY2EE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00110C4CEED;
	Mon, 25 Aug 2025 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145882;
	bh=o2zMb7DV0FaHdjnAmQJKIBUjG4tlL5qOjSszG3XrUBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fH8nY2EEHew1s53xE0YJWbiOEoOmxA6BORJ+/zmkSxoWaRZ/qU2x2E2psZMZJeTn4
	 nTHztSPzmxcojM8DrmAH286mKK6NzsD75CxZSQBDVNK3icLLU2iuMKpFvWp4BJ/UE8
	 cBqnjx//xa5Ip85Mh7F6aq4/BOlu3xd9mc6gpDx6rdcvQODXQbL9FMXRC+vNuQLpE9
	 q642c8cxEsQXWLAX3AB0GBWYhJryBubWRwyQnSeoXeHAI0/OHX2pbGbYnVADxDmAn/
	 FvL+STgW2Feoo4NYDTnctYKsMwAoZXh51bIkE4cMoa73szriyk7sTNJdHREjNfDYLA
	 0vep2ro4l/PEg==
Date: Mon, 25 Aug 2025 08:18:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	kernel-team@android.com, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: Fix 64-bit division in cgroup.stat.local
Message-ID: <aKyo2V8T3yFFpq69@slm.duckdns.org>
References: <20250823022128.3183940-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823022128.3183940-1-ynaffit@google.com>

On Fri, Aug 22, 2025 at 07:21:28PM -0700, Tiffany Yang wrote:
> Fix the following build error for 32-bit systems:
>    arm-linux-gnueabi-ld: kernel/cgroup/cgroup.o: in function `cgroup_core_local_stat_show':
> >> kernel/cgroup/cgroup.c:3781:(.text+0x28f4): undefined reference to `__aeabi_uldivmod'
>    arm-linux-gnueabi-ld: (__aeabi_uldivmod): Unknown destination type (ARM/Thumb) in kernel/cgroup/cgroup.o
> >> kernel/cgroup/cgroup.c:3781:(.text+0x28f4): dangerous relocation: unsupported relocation
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508230604.KyvqOy81-lkp@intel.com/
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> Cc: Tejun Heo <tj@kernel.org>

Applied to cgroup/for-6.18.

Thanks.

-- 
tejun


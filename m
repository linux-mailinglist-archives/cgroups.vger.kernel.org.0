Return-Path: <cgroups+bounces-4660-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4073967287
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2024 17:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45B81C2158D
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2024 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD873CF4F;
	Sat, 31 Aug 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSIQzmno"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD81EB5B;
	Sat, 31 Aug 2024 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725119569; cv=none; b=D++84NstWtYQ/rZW+7cKwxAy6oVDqfnTOyZrdmt07eLqhOsMtTjslUvOpCbz/T5q31kVWewSd3LSWyy87mQspO02UPPjODe0YKjN6SNpinSxlWlFXaTDhdqZPFyPOHV9peJF1MpSI6o4gqOc4W27X9aANdrxjOKy2AetCRSBSlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725119569; c=relaxed/simple;
	bh=pIp4N8BD0shGHYnoaJAIllScl8Zig696ipUSNsthjT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhLUNkAO4V8rZLiZlOsvN7zGO1JMoAZE+Klo0EQbz+puxdctiUgok+B9CZXiZSeLrz2tstIUt2mc5EYFyw9WC5YNYBl8WPOzxiGHSxb7ri1iesSbIyYBT6QFmekzRPe86wlgSG0jrbAaRH7AyCHTNDYYQSNDrmsnLH9fbvg7S44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSIQzmno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C01C4CEC0;
	Sat, 31 Aug 2024 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725119568;
	bh=pIp4N8BD0shGHYnoaJAIllScl8Zig696ipUSNsthjT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSIQzmno4IxWhFlY8y3n4ohLw2n+w5CBRbVt2YHwKpKoGP9JdGNjc++zdAVFkNNo5
	 896vcSlY4w0UpRcexi8K/Evsp3MwtzrK0ZU1mUlsKdRSQKVNCevNylTw3az4pxPZ54
	 YTg//D178IKAGvkHcc3ZetdaGeABgHBiF0S/E8o+KfiFuUNRYPcN/w/bYADciXDdvj
	 Pl1JUmxrBPdaeymn8Fqrpn5bbWDbAjSRkrRUfiiNbYlU/gn6kh90w0pHHbfgOk5Msh
	 +WOQkQnr0hvXicveyQyqMZZkT4RS1tqOi7VOVraYlq+AUYzzbshnH7I2sZngM2ohDh
	 o68+AQBkSN7bA==
Date: Sat, 31 Aug 2024 05:52:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH-cgroup] cgroup/cpuset: Move cpu.h include to
 cpuset-internal.h
Message-ID: <ZtM8TwPL2cZdeAuo@slm.duckdns.org>
References: <20240831135703.881282-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831135703.881282-1-longman@redhat.com>

On Sat, Aug 31, 2024 at 09:57:03AM -0400, Waiman Long wrote:
> The newly created cpuset-v1.c file uses cpus_read_lock/unlock() functions
> which are defined in cpu.h but not included in cpuset-internal.h yet
> leading to compilation error under certain kernel configurations.  Fix it
> by moving the cpu.h include from cpuset.c to cpuset-internal.h. While
> at it, sort the include files in alphabetic order.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408311612.mQTuO946-lkp@intel.com/
> Fixes: dd46bd00ab4c ("cgroup/cpuset: move relax_domain_level to cpuset-v1.c")
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.12.

Thanks.

-- 
tejun


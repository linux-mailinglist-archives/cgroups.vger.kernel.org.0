Return-Path: <cgroups+bounces-3662-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B71F9304B4
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 11:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EED284016
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F3446A1;
	Sat, 13 Jul 2024 09:23:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0903D33CD1;
	Sat, 13 Jul 2024 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720862607; cv=none; b=HLBfg53VL+H9WCbhIAPCnURwgnXRdjDtbmXPu5nSpEgXuzInngn0r4Q7OaWtHXAqU4l7sY81ATTa3dkyaRrcKZpZfzKvXurzSegmgI2v9KkbfDCODyM0NOXFXH54YITDC/khT5MXHPCOeiKg6rY0R4lW//ets2yoz5B1EVapuFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720862607; c=relaxed/simple;
	bh=gJRnRe5LtYsJ4TJLJtZTgFQvNoHEehUOb/8OUz1acws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q+7iy9coJ41rNrn45Z2FjsJzNZDNt98LaBAd4ZGEPYL8CgkQRvxfnD9qazm51j6yuwqMiNvmmy8OPVpbbrsKvnLTKm1uo2ghN1tVWqdAqNcgG0UOi+iQI8iZI2JEpknC6wq8Gq5SrxGyR2gUnb+qjYjm8o+AVq/vBVfPVTpnS40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WLjZ237PRzxSZf;
	Sat, 13 Jul 2024 17:18:34 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A91018006C;
	Sat, 13 Jul 2024 17:23:21 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 13 Jul 2024 17:23:20 +0800
Message-ID: <bd583161-edc4-bd43-5a11-7e6707a60f5b@huawei.com>
Date: Sat, 13 Jul 2024 17:23:20 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH cgroup/for-6.11] cgroup: Add Michal Koutny as a maintainer
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Zefan Li
	<lizefan.x@bytedance.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<kernel-team@meta.com>
References: <Zo8OzWUzDv3rQIiw@slm.duckdns.org>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <Zo8OzWUzDv3rQIiw@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Hi,

On 2024/7/11 6:44, Tejun Heo wrote:
> Michal has been contributing and reviewing patches across cgroup for a while
> now. Add him as a maintainer.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..3dd70792f572 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5536,6 +5536,7 @@ CONTROL GROUP (CGROUP)
>  M:	Tejun Heo <tj@kernel.org>
>  M:	Zefan Li <lizefan.x@bytedance.com>
>  M:	Johannes Weiner <hannes@cmpxchg.org>
> +M:	Michal Koutný <mkoutny@suse.com>
>  L:	cgroups@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
> 

When I use ./scripts/get_maintainer.pl to get the maintainers, I get
this info:

UTF-8 "\xFD" does not map to Unicode at ./scripts/get_maintainer.pl line
385, <$maint> line 5656

"Michal Koutn\xFD" <mkoutny@suse.com> (maintainer:CONTROL GROUP (CGROUP))




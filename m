Return-Path: <cgroups+bounces-5949-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEE9F5782
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 21:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A50188F9CE
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 20:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488921F9416;
	Tue, 17 Dec 2024 20:17:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C11F8EEF;
	Tue, 17 Dec 2024 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466654; cv=none; b=rntxRW8lNAJQNx8Gv7TWijpepXFyXGthT5LLgxX2LygInnYHc1hcSHTT5Sz8Gdye5R8wHPhaj5Rplg9lvMMEQORV2cnilPjoWr5H8KpnNmguTndmHkq0Vro/w+/Zn1XyVZlP7CIlJo9p5p0kSVd30XpiWUjPzQM85I+6F95IoeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466654; c=relaxed/simple;
	bh=p3GaFQZHi3m+TeT6OrllpUeQjXe6ODh4B2+UIRKSsIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7yGscJGxqrtOFpaD4zTsLocCIAcmUWAkEB27kJuduBD4c12BD9UMlKNaNz27liG/Ch/CBW2gXScTVW+umBQt6WFKXBa8XNBCnAXW2k+5bviL36UWHUIDcIZut3aakZhW/0tjsc7fE261GGqCRH4UVmnBvj9hfDQacMRs46R0iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lankhorst.se
Message-ID: <61b95c08-a3c2-4f92-b6e5-df77fd2491e2@lankhorst.se>
Date: Tue, 17 Dec 2024 21:17:24 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
To: Tejun Heo <tj@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>,
 Dave Airlie <airlied@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <20241213-proud-kind-uakari-df3a70@houat>
 <80c49a80-d49c-4ca5-9568-9f7950618275@lankhorst.se>
 <20241213-gentle-glittering-salamander-22addf@houat>
 <5a50a992-9286-4179-8031-ffb514bca34f@lankhorst.se>
 <20241217-meek-bullfinch-of-luck-2c3468@houat>
 <a69a3500-be17-4899-bdb9-c6a63bf8dc81@lankhorst.se>
 <Z2GwpOQDVshpv-ml@slm.duckdns.org>
 <c0a539e7-0f1b-496a-9848-73a7ada66bfb@lankhorst.se>
 <Z2HBqtKDSTkd1lST@slm.duckdns.org>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <Z2HBqtKDSTkd1lST@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey,

Den 2024-12-17 kl. 19:23, skrev Tejun Heo:
> Hello,
> 
> On Tue, Dec 17, 2024 at 06:37:22PM +0100, Maarten Lankhorst wrote:
>> Den 2024-12-17 kl. 18:11, skrev Tejun Heo:
>>> On Tue, Dec 17, 2024 at 03:28:50PM +0100, Maarten Lankhorst wrote:
>>>> Now that all patches look good, what is needed to merge the series? Without
>>>> patch 6/7 as it is a hack for testing.
>>>
>>> There were some questions raised about device naming. One thing we want to
>>> get right from the beginning is the basic interface.
>>>
>>> Thanks.
>>>
>> I believe it was solved. The conclusion appears to be that we go with how we
>> defined it in this series. drm/$pciid/$regionname. With the only regions
>> defined now being VRAM. Main memory will be a followup, but requires some
>> discussions on hwo to be prevent double accounting, and what to do with the
>> limited amount of mappable memory.
> 
> Provided Johannes is okay with the series, how do you want to route the
> series? If you want to route it through drm, that's fine by me and please
> feel free to add:
> 
>   Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 

Thank you!

I've discussed this with the DRM maintainers. What was suggested is to 
create a topic branch, merge it to drm-misc whichwhere it will be picked 
up into drm.git during the next pull request. At the same time the topic 
branch can be also be merged into the cgroup tree if needed.

The drm-misc tree already handles dma-buf and fbdev core, think DMEM 
could fit in there too.

Cheers,
~Maarten


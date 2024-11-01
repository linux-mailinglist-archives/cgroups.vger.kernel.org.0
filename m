Return-Path: <cgroups+bounces-5371-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7287B9B90B2
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 12:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C931C2139E
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 11:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BCB19C54A;
	Fri,  1 Nov 2024 11:54:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E319925B;
	Fri,  1 Nov 2024 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462073; cv=none; b=YwBQGBMI2kYmV97vE3moNOtD9wPvjncONu6Tn0dECUcESWltbIaMulkZnPd0n8UVCnvwbDVDMi4i1zPKrgfeeZ9luunL5LDMbiEedmwvOUkmYMnkK9HlCpVLZNrZODZEGl5rAcrZDrRj2vXSfeZdD67ntHGIzHAPNOiJpuHMfFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462073; c=relaxed/simple;
	bh=bjZUQBIBMPaA1dMDMineNYwWt/HrO98ItObjJC3RPTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WqyfgTIMfxKo3lI8qTrQbsnJy5E60ePf6Z/8F/fKebwBlA0uf64N5SqnKYtKNp6VRnLAP1aSZ35GuiSWwfxrttG6L/gDASUflAnZ1b2wA5LgiEvEMJiqInZXAy/qxu/tM0lDbznOzLgu/gZOu8GBoaFDFBDxR/lQqUSApeqnZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xfzl4488Mz6JB6N;
	Fri,  1 Nov 2024 19:53:04 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F418140B3C;
	Fri,  1 Nov 2024 19:54:28 +0800 (CST)
Received: from [10.123.123.226] (10.123.123.226) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 1 Nov 2024 14:54:27 +0300
Message-ID: <274e1560-9f6c-4dd9-b27c-2fd0f0c54d03@huawei.com>
Date: Fri, 1 Nov 2024 14:54:27 +0300
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
To: Michal Hocko <mhocko@suse.com>
CC: Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<baohua@kernel.org>, <willy@infradead.org>, <peterx@redhat.com>,
	<hannes@cmpxchg.org>, <hocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<alexander.kozhevnikov@huawei-partners.com>, <guohanjun@huawei.com>,
	<weiyongjun1@huawei.com>, <wangkefeng.wang@huawei.com>,
	<judy.chenhui@huawei.com>, <yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<kang.sun@huawei.com>, <nikita.panov@huawei-partners.com>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyHwgjK8t8kWkm9E@tiehlicka>
 <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>
 <ZyI0LTV2YgC4CGfW@tiehlicka>
 <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>
 <ZyJNizBQ-h4feuJe@tiehlicka>
 <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>
 <ZyNAxnOqOfYvqxjc@tiehlicka>
 <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>
 <ZySEvmfwpT_6N97I@tiehlicka>
Content-Language: en-US
From: Stepanov Anatoly <stepanov.anatoly@huawei.com>
In-Reply-To: <ZySEvmfwpT_6N97I@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

On 11/1/2024 10:35 AM, Michal Hocko wrote:
> On Thu 31-10-24 17:37:12, Stepanov Anatoly wrote:
>> If we consider the inheritance approach (prctl + launcher), it's fine until we need to change
>> THP mode property for several tasks at once, in this case some batch-change approach needed.
> 
> I do not follow. How is this any different from a single process? Or do
> you mean to change the mode for an already running process?
> 
yes, for already running set of processes


-- 
Anatoly Stepanov, Huawei


Return-Path: <cgroups+bounces-3582-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE9E92BBA6
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 15:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BBA2857CE
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB291598E3;
	Tue,  9 Jul 2024 13:46:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F330D38DD8;
	Tue,  9 Jul 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532764; cv=none; b=XYemnHUQ1OwCYySrPqnt+G2yMchhC8jqeX7q2n6gSQ+HnAFJGOnkCCNFVH+GS5talruM7LYRsVkET+1qOn7tM5zmGjtTnepd1w+c1Qmm0M/vR9cYfVS+CZ9Y51RDPXoaYjL8P5AuaKc7CvPXCJpNWz8pQO9ppPdnFttcfuCRJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532764; c=relaxed/simple;
	bh=69Zg09kOFuS8vnbadZiA0MZFZvEHafPmE15XT+i8spI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XDViIhJzEcM4nGmi+26dDpcUv3yo1kEUACmFLnoQQHwo57EcwZ2t0rBsuUoDmKWry1QDnLSUB11x1FOoNoZI7GPvRgUeDYfNdQAT8oqZgX1A2GGjlA7Gnlw0DvdDIk6i5Er5TjTdKW+TmmQXYGeRrLjSdSeOTgm83oyFcd4zh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WJMbw1MbSzQkfL;
	Tue,  9 Jul 2024 21:42:04 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E183180ADD;
	Tue,  9 Jul 2024 21:45:59 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 9 Jul
 2024 21:45:58 +0800
Message-ID: <e90c32d2-2a85-4f28-9154-09c7d320cb60@huawei.com>
Date: Tue, 9 Jul 2024 21:45:57 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: Fix AA deadlock caused by
 cgroup_bpf_release
To: Markus Elfring <Markus.Elfring@web.de>, <bpf@vger.kernel.org>,
	<cgroups@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard
 Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Song Liu
	<song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Tejun Heo
	<tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Zefan Li
	<lizefan.x@bytedance.com>
CC: LKML <linux-kernel@vger.kernel.org>
References: <20240607110313.2230669-1-chenridong@huawei.com>
 <f8dfa410-bce0-48fe-b3d1-19fb5f5768a8@web.de>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <f8dfa410-bce0-48fe-b3d1-19fb5f5768a8@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/6/10 20:28, Markus Elfring wrote:
>> We found an AA deadlock problem as shown belowed:
> 
>                                             below?
> 
> * How was an “AA deadlock” problem detected?
> 
> * Were any special analysis tools involved?
It occurred after a long time of pressure testing.

> 
> 
> …
>> preblem is solved.
> 
>    problem?
> 
Sorry for the spelling mistake.
> 
> Regards,
> Markus

Regards,
Ridong


Return-Path: <cgroups+bounces-2820-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951E48BE0CF
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 13:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70651C21E77
	for <lists+cgroups@lfdr.de>; Tue,  7 May 2024 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA54152168;
	Tue,  7 May 2024 11:17:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D341509A6;
	Tue,  7 May 2024 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080667; cv=none; b=MSgOwyGL42azLar7kZmWlt9xgsj6HocGuanqu9/0QVCZyM52S8RS2CjiPWwbUao1pJ2eVzmNFF0ZFYlBngYJUctCBRab2RwYtl2ntuNcYnS85eqRa/76hVdg0EiHHinbSzNGmHl24xMRHpxFB1dTa4+Ry1SI6vRARRkESNYBJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080667; c=relaxed/simple;
	bh=0lxFd2GCE2ODuH3qgno60tjiH9OHy42/GKT7AMGXobw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F628KAY+qULV8rxp5/wahkMVkqdyMlv38Kxdpo+OccixweSgMIbhxq25AGIzbUm+mJfKn8uKuAXvUvRyj0Y1uSb/tWGd58ddbJltSYCJzUnzW/eOy9GHBBW73tgC5rZbYTcjyZGkyxrMh4YyoqcaiyOrm5lYRJgKHlENObKe5Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VYbK66NBsz1yn0M;
	Tue,  7 May 2024 19:14:50 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 2234B1401DC;
	Tue,  7 May 2024 19:17:36 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 19:17:35 +0800
Message-ID: <b98d71e7-9b0f-4c8d-4c90-d1cc1eb730a2@huawei.com>
Date: Tue, 7 May 2024 19:17:35 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] mm: memcg: use meaningful error code for return
 value
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240506133643.1124102-1-xiujianfeng@huawei.com>
 <Zjjg60ZW-d7r-DS9@casper.infradead.org>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <Zjjg60ZW-d7r-DS9@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/5/6 21:53, Matthew Wilcox wrote:
> On Mon, May 06, 2024 at 01:36:43PM +0000, Xiu Jianfeng wrote:
>> alloc_mem_cgroup_per_node_info() returns 1 if failed, use -ENOMEM
>> instead, which is more meaningful.
> 
> This should probably be changed to return true/false instead of
> an int.
> 
OK, already sent v2.


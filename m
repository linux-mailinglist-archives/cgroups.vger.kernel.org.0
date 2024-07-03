Return-Path: <cgroups+bounces-3510-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C6B924DF4
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 04:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8071F23FE4
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 02:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA6B53BE;
	Wed,  3 Jul 2024 02:46:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C068C1FAA;
	Wed,  3 Jul 2024 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719974763; cv=none; b=HYmBggM5eRb5KeWbM4jvHnYOzPua/Bzhc84+lflN0bM/6v8p3C34YiTLeIYr3sXEq0unqu6dqgEFhUhUgQD7Zahq8UG7hV2ey/Y0JJ3u+8mFEKhPKoHoUsOEebbh3nTgFtH+hHmDY4+aYBa9qiS9fENK1lBv2aQQm+RX4hjVVHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719974763; c=relaxed/simple;
	bh=HbZ2/NQMFiEjCpkEyupxJ18g0j8Jt4GnyywqyrmUaK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gak31LV7dGMqQGrw1caaa1RQ7+y/TgoPxO0OUicUEWi+esCRDfQ3Jn6C6gvYlf0+azcTNb0HVdiEg9Mma2YMiJ66PU8L+kh+nOuCOkMt5JzSoJyfVhGif08IzAD7ekUTzr3a3oSbqqLNYxiwvcAICIJAgNMI6QU2U7DLFypQ8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WDPDM6Q4szZhBq;
	Wed,  3 Jul 2024 10:41:23 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id EB53A1402E0;
	Wed,  3 Jul 2024 10:45:56 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 10:45:56 +0800
Message-ID: <6843023e-3e80-0c1c-6aab-b386ffebd668@huawei.com>
Date: Wed, 3 Jul 2024 10:45:56 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] mm/hugetlb_cgroup: introduce peak and rsvd.peak to
 v2
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
CC: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<corbet@lwn.net>, <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20240702125728.2743143-1-xiujianfeng@huawei.com>
 <20240702185851.e85a742f3391857781368f6c@linux-foundation.org>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20240702185851.e85a742f3391857781368f6c@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/7/3 9:58, Andrew Morton wrote:
> On Tue, 2 Jul 2024 12:57:28 +0000 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> 
>> Introduce peak and rsvd.peak to v2 to show the historical maximum
>> usage of resources, as in some scenarios it is necessary to configure
>> the value of max/rsvd.max based on the peak usage of resources.
> 
> "in some scenarios it is necessary" is not a strong statement.  It
> would be helpful to fully describe these scenarios so that others can
> better understand the value of this change.
> 

Hi Andrew,

Is the following description acceptable for you?


Since HugeTLB doesn't support page reclaim, enforcing the limit at
page fault time implies that, the application will get SIGBUS signal
if it tries to fault in HugeTLB pages beyond its limit. Therefore the
application needs to know exactly how many HugeTLB pages it uses before
hand, and the sysadmin needs to make sure that there are enough
available on the machine for all the users to avoid processes getting
SIGBUS.

When running some open-source software, it may not be possible to know
the exact amount of hugetlb it consumes, so cannot correctly configure
the max value. If there is a peak metric, we can run the open-source
software first and then configure the max based on the peak value.
In cgroup v1, the hugetlb controller provides the max_usage_in_bytes
and rsvd.max_usage_in_bytes interface to display the historical maximum
usage, so introduce peak and rsvd.peak to v2 to address this issue.


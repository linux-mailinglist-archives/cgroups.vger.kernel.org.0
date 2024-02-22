Return-Path: <cgroups+bounces-1792-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F242C85EED0
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 03:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D325B21E06
	for <lists+cgroups@lfdr.de>; Thu, 22 Feb 2024 02:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3685913FF1;
	Thu, 22 Feb 2024 02:01:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA611CBE;
	Thu, 22 Feb 2024 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567273; cv=none; b=ToHCEXpgsmVWcVoEJY3lWlSbvaLimNIca1s2nvDR6Y8Fz0ei8uQkrDVIBdo61PeEwnpGfw/rTIMdsMpR9LyQ2lXme3WzF4kvM3DIeH1/pZZoArmWm5ocLbS1zwdr9UgYDb6oF6BwHL0HcZZ3sm5XAMB45D0kAi73cf5T174kXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567273; c=relaxed/simple;
	bh=FxBxQvpWr/t/SMgs/1y6sJ0MS8oWk0441mgO3fJ+kdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nl/cc/yexrdKmBFcB8SVCjoutsR8CxsZX5u7iIgyhe+6bOO2wBeq/tNdYY3Vb2NazIOedpsyUjux63JM2lS8Sm0A7HY1k5U9Qb3hPpYBUgu+tjSF0qgzB81lNltx8nsVPPDIgft9YSndfC1SZV9AdB4CcBW+b/qyaS2nvpuZlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TgGXS0JWWzvVvZ;
	Thu, 22 Feb 2024 09:59:04 +0800 (CST)
Received: from dggpemd100002.china.huawei.com (unknown [7.185.36.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 27EC6140153;
	Thu, 22 Feb 2024 10:01:07 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemd100002.china.huawei.com
 (7.185.36.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Thu, 22 Feb
 2024 10:01:06 +0800
Message-ID: <9e5b19c7-1f57-5f19-6331-75c2cfc7800f@huawei.com>
Date: Thu, 22 Feb 2024 10:01:06 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH stable] memcg: add refcnt for pcpu stock to avoid UAF
 problem in drain_all_stock()
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
	<shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, Wang Weiyang
	<wangweiyang2@huawei.com>, Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20240221081801.69764-1-gongruiqi1@huawei.com>
 <ZdW2gMajIw_cUN2-@tiehlicka>
 <5436af7a-26d4-7c04-466a-7163d5a26040@huawei.com>
 <ZdXLgjpUfpwEwAe0@tiehlicka>
From: Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <ZdXLgjpUfpwEwAe0@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd100002.china.huawei.com (7.185.36.164)



On 2024/02/21 18:08, Michal Hocko wrote:
> On Wed 21-02-24 17:50:27, Gong Ruiqi wrote:
>>
>> On 2024/02/21 16:38, Michal Hocko wrote:
>>> On Wed 21-02-24 16:18:01, GONG, Ruiqi wrote:
>>>> commit 1a3e1f40962c445b997151a542314f3c6097f8c3 upstream.
>>>
>>> I think it would be good to mention that this is only a partial backport
>>> and also explain why to do a partial rather than the full one.
>>>
>>
>> Okay. I think to fix this problem we should add refcnt relation between
>> memcg and stock, and since higher versions have achieved this, maybe
>> it's better to use the same code and align with them. So I put a "commit
>> xxx upstream" here, as requested in kernel docs[1]. So yes it's a
>> partial backport as we only need the stock part.
> 
> I think it is sufficient to mention that this is a partial backport to
> minimize the fix to the bare minimum.
> 

Okay. Then I will send a v2 and add a paragraph to mention this.

> [...]


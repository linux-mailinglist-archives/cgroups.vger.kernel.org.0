Return-Path: <cgroups+bounces-5789-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6389EAFFC
	for <lists+cgroups@lfdr.de>; Tue, 10 Dec 2024 12:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD1D162228
	for <lists+cgroups@lfdr.de>; Tue, 10 Dec 2024 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A54210F7F;
	Tue, 10 Dec 2024 11:35:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0DB2080D2;
	Tue, 10 Dec 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830551; cv=none; b=Ktb/5iwpM3y3/PkwkRNVd3zvz3ZcUXVd4/6E4AGdeC5jgeD1lS9ShV1nNEJoFMAkB0lpsTmhcYFVGyVwfTrR+0puCxoVxSES22JeN9U3Ld545PGkBjlRO5S0fJRLHmlifjKMgzmyETrvMG2lqLzfnY+wm6/NYyMJzElbN24aNaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830551; c=relaxed/simple;
	bh=DBCKw02zjg9Ixa3L9GiBlWaE+1cfhfx80IV1vktGJTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApyUwllu41tfLYdSnK5Tg8bsdxF1tOrwPM9o20jVNPn0FcXeggCW7wE8v9W0c3W8xe01Gb8nwR6bkEqbWAQO21IjP5rTMQMZyYoL2izB8lKPJnxKgjvoMm44mMmy9ZAxUvOARbgUebHD76tXMIt92H4s4LgfFMo7GlRGO2PQKQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y6xVq26WFz4f3l85;
	Tue, 10 Dec 2024 19:35:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7EB5B1A058E;
	Tue, 10 Dec 2024 19:35:45 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgC3Y+CPJ1hnBTauEA--.27259S2;
	Tue, 10 Dec 2024 19:35:45 +0800 (CST)
Message-ID: <b78b8183-4dbc-4163-a84b-f74f5af97e84@huaweicloud.com>
Date: Tue, 10 Dec 2024 19:35:43 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next -v1 3/5] memcg: simplify the mem_cgroup_update_lru_size
 function
To: Shakeel Butt <shakeel.butt@linux.dev>, Hugh Dickins <hughd@google.com>
Cc: Yu Zhao <yuzhao@google.com>, akpm@linux-foundation.org,
 mhocko@kernel.org, hannes@cmpxchg.org, yosryahmed@google.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, davidf@vimeo.com,
 vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
 <20241206013512.2883617-4-chenridong@huaweicloud.com>
 <CAOUHufbCCkOBGcSPZqNY+FXcrH8+U7_nRvftzOzKUBS4hn+kuQ@mail.gmail.com>
 <897b04c9-dba3-44ae-8113-145ca3457cb3@huaweicloud.com>
 <edab8d46-7c03-4bf5-fe1c-0150cdf4d96a@google.com>
 <xuhsdsl2bhlrlaghar3ru7nhlhjsmaiyjxayryogylsordbwcx@e2jxsb2qdbhd>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <xuhsdsl2bhlrlaghar3ru7nhlhjsmaiyjxayryogylsordbwcx@e2jxsb2qdbhd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgC3Y+CPJ1hnBTauEA--.27259S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1DZr43ZF4xJF4rZw4DCFg_yoWxtFb_Wr
	ZYqFsrKwsxXanrZw4kKrnY9rWkXw4jvFnrAry0qFsrZr13CF4DGFWDGr4xZrZ8KF4vkF13
	AFWrJwsI9wnrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
	AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsU
	UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/12/7 5:20, Shakeel Butt wrote:
> On Fri, Dec 06, 2024 at 12:24:54AM -0800, Hugh Dickins wrote:
> [...]
>> Another thing to understand: it's called before adding folio to list,
>> but after removing folio from list: when it can usefully compare whether
>> the emptiness of the list correctly matches lru_size 0.
> 
> I think one source of confusion might be that this "emptiness" check has
> been removed by commit b4536f0c829c because of maintaining the list size
> per-zone and actual list is shared between zones of a node.
> 

Agree.
Maybe it doesn't have to distinguish between  "size > 0" and "size < 0" now?

Thanks,
Ridong
>> It cannot do so
>> when adding if you "simplify" it in the way that you did.
>>



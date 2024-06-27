Return-Path: <cgroups+bounces-3388-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4F91A190
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 10:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF781F25E3E
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 08:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A706980600;
	Thu, 27 Jun 2024 08:33:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365612FB3B;
	Thu, 27 Jun 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477186; cv=none; b=YRepVgL4x9tQDjPSm0CsJJiwk7m2LmXWAev6XTVN3dBu5GfVZX3Xck2d1Jc52tOIBbiTKrOfcCvVhoNtu+Kkz7WWIgZ1XOCRbXXoSJjFSrbMzztZPPLZgMSAJ9tKN5sEcYpAcEa2B1GIGBQ8c5NlNdiFMj++KPdehwmtX/wmWu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477186; c=relaxed/simple;
	bh=FGzq335qYYq6OcnTxNBfpF7Lths13lSYSLh6qha25nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IL5ush5/edzfespULf1FC5dmHFju69BHB3RHQmWJWgHbzKKScIOHnRhsjCXX2lw7vYmnabTMsbjaNUhZATbTLl/fnxw3MEwzxCyY5fAbj0kWczSFwgytHL1IwGdGbeh1VSG/WiSDM3NaDsTmESZHRLbzhK9/MAgIXwJe+9KQBDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W8sCl3yWMz1T4W9;
	Thu, 27 Jun 2024 16:28:35 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id D80B518007E;
	Thu, 27 Jun 2024 16:33:00 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 16:33:00 +0800
Message-ID: <a351c609-4968-398a-9316-2ad19d934e9c@huawei.com>
Date: Thu, 27 Jun 2024 16:33:00 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] mm: memcg: remove redundant
 seq_buf_has_overflowed()
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
CC: <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240626094232.2432891-1-xiujianfeng@huawei.com>
 <Zn0RGTZxrEUnI1KZ@tiehlicka>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <Zn0RGTZxrEUnI1KZ@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/6/27 15:13, Michal Hocko wrote:
> On Wed 26-06-24 09:42:32, Xiu Jianfeng wrote:
>> Both the end of memory_stat_format() and memcg_stat_format() will call
>> WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format()
>> is the only caller of memcg_stat_format(), when memcg is on the default
>> hierarchy, seq_buf_has_overflowed() will be executed twice, so remove
>> the reduntant one.
> 
> Shouldn't we rather remove both? Are they giving us anything useful
> actually? Would a simpl pr_warn be sufficient? Afterall all we care
> about is to learn that we need to grow the buffer size because our stats
> do not fit anymore. It is not really important whether that is an OOM or
> cgroupfs interface path.

I did a test, when I removed both of them and added a lot of prints in
memcg_stat_format() to make the seq_buf overflow, and then cat
memory.stat in user mode, no OOM occurred, and there were no warning
logs in the kernel.

> 
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>  mm/memcontrol.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 974bd160838c..776d22bc66a2 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1846,9 +1846,6 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>>  			       vm_event_name(memcg_vm_event_stat[i]),
>>  			       memcg_events(memcg, memcg_vm_event_stat[i]));
>>  	}
>> -
>> -	/* The above should easily fit into one page */
>> -	WARN_ON_ONCE(seq_buf_has_overflowed(s));
>>  }
>>  
>>  static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
>> -- 
>> 2.34.1
> 


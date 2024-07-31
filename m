Return-Path: <cgroups+bounces-4026-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED6894249D
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 04:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6F6285623
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 02:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB4A175A1;
	Wed, 31 Jul 2024 02:56:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC21BDDF;
	Wed, 31 Jul 2024 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394582; cv=none; b=rOyAFVVTn2d/vP7tQw3hCHTc68aThnsdVJ1mbhN32vTLkwN4pnv3ulRZHIOqpgNVq7l5j93ktIk8wEdumw2ZqGI+drnwWom6YiDtJQ472i4pnwCZu9GembXvXukzzBWrTVPGgs3rD37yLy/RTmL0KT0KijrwMh8LPJzL8JqKnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394582; c=relaxed/simple;
	bh=Ir8ZY6v8/t8OwbnCW7ZLF1/6eyvsdQSaOHsDbbmuWlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXF71uilO5tbia6OPhhOjs5R05j71K25FpVFmVlz22fG6lJM9ox93A4HFObFCoz38BSugt512x6W6wZ49TtKjOee12pybo9sStKuUy8VcyryRwPJvQmCQ/pwJPqTHgawB8OjAUvGLCV+gkKXGYlP9qocIwz2ij0aK58qWBlAYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYcDK6Dh2z4f3jHk;
	Wed, 31 Jul 2024 10:56:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C7ADB1A07BA;
	Wed, 31 Jul 2024 10:56:15 +0800 (CST)
Received: from [10.67.110.112] (unknown [10.67.110.112])
	by APP3 (Coremail) with SMTP id _Ch0CgAHarjOp6lm3VRNAQ--.37254S2;
	Wed, 31 Jul 2024 10:56:15 +0800 (CST)
Message-ID: <555ce52c-ba32-37d9-13de-a05f773b21f2@huaweicloud.com>
Date: Wed, 31 Jul 2024 10:56:14 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 -next] cgroup/pids: Avoid spurious event notification
To: Tejun Heo <tj@kernel.org>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, xiujianfeng@huawei.com
References: <20240730032920.3690263-1-xiujianfeng@huaweicloud.com>
 <Zqll1sNJB4qQc0s2@slm.duckdns.org>
Content-Language: en-US
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <Zqll1sNJB4qQc0s2@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAHarjOp6lm3VRNAQ--.37254S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWxtrWftr17Cr1rtryDAwb_yoW8Xr4xp3
	95J3WrtFWkJw12kFs0q39rWryrZrZ7Jrs5JFn5X3yfGr42gryagF42kFyj934kZr1xZw1Y
	qa1jga93Aay5Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/



On 2024/7/31 6:14, Tejun Heo wrote:
> On Tue, Jul 30, 2024 at 03:29:20AM +0000, Xiu Jianfeng wrote:
>> From: Xiu Jianfeng <xiujianfeng@huawei.com>
>>
>> Currently when a process in a group forks and fails due to it's
>> parent's max restriction, all the cgroups from 'pids_forking' to root
>> will generate event notifications but only the cgroups from
>> 'pids_over_limit' to root will increase the counter of PIDCG_MAX.
>>
>> Consider this scenario: there are 4 groups A, B, C,and D, the
>> relationships are as follows, and user is watching on C.pids.events.
>>
>> root->A->B->C->D
>>
>> When a process in D forks and fails due to B.max restriction, the
>> user will get a spurious event notification because when he wakes up
>> and reads C.pids.events, he will find that the content has not changed.
>>
>> To address this issue, only the cgroups from 'pids_over_limit' to root
>> will have their PIDCG_MAX counters increased and event notifications
>> generated.
>>
>> Fixes: 385a635cacfe ("cgroup/pids: Make event counters hierarchical")
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Applied to cgroup/for-6.12.
> 
> Note that spurious events are explicitly allowed. Anyone watching an events
> file should keep track of the reported values to detect actual events.

Hi Tejun,

Thank you for your clarification. I thought it was not allowed.

Anyway, it's always good to avoid spurious events and disturbances to
users IMO.

> 
> Thanks.
> 



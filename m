Return-Path: <cgroups+bounces-6521-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB57A322DC
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 10:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920FA166039
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD439206F0B;
	Wed, 12 Feb 2025 09:52:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773C82063D6;
	Wed, 12 Feb 2025 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353933; cv=none; b=RuL8SK6aQsT9mdvkWT292791j8Nfe9aeCIJ3c+DBWC+gyopEVTlRMEamsMSviTpK0QyCckVaWlel4UjBomOJg9ES+q5i6JTxeEExAZViujgQ6QdEwvTNlKKWSLMVtRRz7CDbktV9JPY5bXAXmtCzcFswGQcrAN2IbnJ9qYtC3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353933; c=relaxed/simple;
	bh=cSr1mIEzkXQTd9lr9ZoTJBEI1rewAifGbG4i4w7KKN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6CPyp3yCmkGwLH8jEweHZ5EJoev4sXKflAwXWKs8cwBMoQWqyVwN2BJr4M3WppoCpYT8Ktk3dpzsREnGKL8qGc9DhJPA2srfqVb3AblLwTHjynl57aEsrP2moZmQJO1p532QDl0juKSVjbeDuKvSYMGf86hWUiO6nBu/djanZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YtD9W2Fbfz4f3kvv;
	Wed, 12 Feb 2025 17:51:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 08DFB1A0E41;
	Wed, 12 Feb 2025 17:52:06 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgBnGHlCb6xnEwBSDg--.38612S2;
	Wed, 12 Feb 2025 17:52:03 +0800 (CST)
Message-ID: <7dd7109d-7554-4b69-8a46-02620abb8583@huaweicloud.com>
Date: Wed, 12 Feb 2025 17:52:02 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/oom_kill: revert watchdog reset in global OOM process
To: Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 davidf@vimeo.com, mkoutny@suse.com, paulmck@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20250212025707.67009-1-chenridong@huaweicloud.com>
 <Z6xig5sLNpFVFU2T@tiehlicka>
 <d264a73e-966f-4890-9e23-88d476f0fc81@huaweicloud.com>
 <bccc9e06-af8b-4a55-a69c-98596f1c1385@suse.cz>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <bccc9e06-af8b-4a55-a69c-98596f1c1385@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBnGHlCb6xnEwBSDg--.38612S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw45Jw1rJF4rKr4xCF4rXwb_yoW8WF4kpF
	W7u3WDKan8G3Wjvr4av34Iqry2kr1xXF4rZF1DJw15Zrn09rnrArW8Cw4Yga4DXwn3ua1j
	vFn0ga4fJ3y5J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/2/12 17:34, Vlastimil Babka wrote:
> On 2/12/25 10:19, Chen Ridong wrote:
>>
>>
>> On 2025/2/12 16:57, Michal Hocko wrote:
>>> On Wed 12-02-25 02:57:07, Chen Ridong wrote:
>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>
>>>> Unlike memcg OOM, which is relatively common, global OOM events are rare
>>>> and typically indicate that the entire system is under severe memory
>>>> pressure. The commit ade81479c7dd ("memcg: fix soft lockup in the OOM
>>>> process") added the touch_softlockup_watchdog in the global OOM handler to
>>>> suppess the soft lockup issues. However, while this change can suppress
>>>> soft lockup warnings, it does not address RCU stalls, which can still be
>>>> detected and may cause unnecessary disturbances. Simply remove the
>>>> modification from the global OOM handler.
>>>>
>>>> Fixes: ade81479c7dd ("memcg: fix soft lockup in the OOM process")
>>>
>>> But this is not really fixing anything, is it? While this doesn't
>>> address a potential RCU stall it doesn't address any actual problem.
>>> So why do we want to do this?
>>>
>>
>>
>> [1]
>> https://lore.kernel.org/cgroups/0d9ea655-5c1a-4ba9-9eeb-b45d74cc68d0@huaweicloud.com/
>>
>> As previously discussed, the work I have done on the global OOM is 'half
>> of the job'. Based on our discussions, I thought that it would be best
>> to abandon this approach for global OOM. Therefore, I am sending this
>> patch to revert the changes.
>>
>> Or just leave it?
> 
> I suggested that part doesn't need to be in the patch, but if it was merged
> with it, we can just leave it there. Thanks.

See. Thank you very much.

Best regards,
Ridong



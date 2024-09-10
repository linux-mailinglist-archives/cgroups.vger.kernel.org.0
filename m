Return-Path: <cgroups+bounces-4785-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B57972791
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 05:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1074B2290D
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 03:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BCB14A4F1;
	Tue, 10 Sep 2024 03:16:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2E22638;
	Tue, 10 Sep 2024 03:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725938197; cv=none; b=XR6DUTWLiRXpKmizTgnDHwi2O2eLwSF8SH2ZiE0xfhzxx2JDZW8ArS59MUiPIRaLjoD731KSPNYqO0MmmhuWoW14r9uFUp40on/ktSRSpaSfEuawRsNYWJ7sPt/hiCWDosK6U97zKO/3nnN+DoFupBzt+ECX5otcC2BGxNslx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725938197; c=relaxed/simple;
	bh=lFxErR4YdWyeGpwnwXOkexej8T5ukJtSZJZNdtrzdH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAVZt91ZzPhe2bkR+uEsasfJV/Ks0EyxYL/EJGBK5EIvEmW1BcIAjDJOIoqSYcdrd0HUtvNkf2+8s4NPsgAwUBotLsgN4DI0CSiYSoVTIieVQOW4cPk9wlNXseFyLSXdSeI2YooK3V82EwIjsqIbPHt+eZi+xlnu3jlRz5VPJlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X2pkr6lDTz4f3jkP;
	Tue, 10 Sep 2024 11:16:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7F97D1A0568;
	Tue, 10 Sep 2024 11:16:31 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgDnHMkPut9molWWAw--.19723S2;
	Tue, 10 Sep 2024 11:16:31 +0800 (CST)
Message-ID: <52bed78b-e7ac-49af-886c-df15968f1c74@huaweicloud.com>
Date: Tue, 10 Sep 2024 11:16:30 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 -next 0/3] Some optimizations about freezer
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 longman@redhat.com, adityakali@google.com, sergeh@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240905134130.1176443-1-chenridong@huawei.com>
 <dl4j67yzzipthp2quj2cl5i6g2cbtiv7ssmhpz2vbcixhig4sc@wfx65evjb4ca>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <dl4j67yzzipthp2quj2cl5i6g2cbtiv7ssmhpz2vbcixhig4sc@wfx65evjb4ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnHMkPut9molWWAw--.19723S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF18GFy5tw1UtFWfCF17KFg_yoW8WFykpF
	WvgF1Yyan5twn7GF97Xw1kWw1Yqr4xAFy5Xas0qw1xGa98Xa4xKFWxtrWYgFnrZr4Sq3W5
	Aan09wsxC3Z8ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	0PfPUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/9/10 3:04, Michal Koutný wrote:
> Hello.
> 
> On Thu, Sep 05, 2024 at 01:41:27PM GMT, Chen Ridong <chenridong@huawei.com> wrote:
>> We optimized the freezer to reduce redundant loops. We add a selftest to
>> ensure our optimizations cause no harm, and we confirmed that the
>> performance can be improved.
> 
> I think these patches have potential to make the code also cleaner and
> better to understand (the numbers from optimization don't impress me
> that much at the moment).
> 
> I post more comments on the individual patches.
> 
Thanks.

>> We tested the following subtree: D, E, F and G each have n children.
>>          A
>>         / \
>>        B   C
>>      / | \  \
>>      D E F   G
>>     /  |  \   \
>>   1-n 1-n 1-n  0-n
> 
> (Why is the last one different?)
> 
Sorry, this should be same.

>> Our test is to freeze A B C D E F G, and then unfreeze A B C D E F G.
> 
> I would say measuring freezing/unfreezing of only A would give better
> idea about the impact of the change.
> (Going through all descendants manually would unfairly show greater
> improvement.)
> 

I will add this test.
And I only test freezing/unfreezing A, The first patch may not be effective.

>> We measured the elapsed time.
>>
>> 	BEFORE(ns)	AFTER(ns)	SAVED(ns)
>> n=10	142679950	139666014	3,013,936
>> n=100	199832160	192773032	7,059,128
>> n=1000	488595100	414901570	73,693,530
> 
> How many tasks were there inside cgroups in this benchmark?
> 
I didn't put tasks inside cgroups to test. Because this series didn't 
change how the tasks be froze. That only reduced some redundant loop.


> (I assume in practice the freezing time would be dominated by waiting
> for tasks' response, so it'd be good to note this beside this result.)
> 
> Thanks,
> Michal



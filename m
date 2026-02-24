Return-Path: <cgroups+bounces-14208-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LIQGqddnWmxOgQAu9opvQ
	(envelope-from <cgroups+bounces-14208-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 09:13:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD56183748
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 09:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A243E310FEC3
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C35366064;
	Tue, 24 Feb 2026 08:09:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37633EB13;
	Tue, 24 Feb 2026 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920578; cv=none; b=QDKF8Eo1ycySdSWIOculUi6V3DTZr9Iex18RFIN16K4x5bp+sWMrdm/ulC7H+pU+C3IsP4K/VgcxZoAhWN7X8Yb2IBx0nZxlogw7Ciq3HGegAQFrAq1egURxGxjzO3RYWfFyPwfDzLZCpNMQ/e5E+nGJLLgP4oXUzuQ3WX53gnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920578; c=relaxed/simple;
	bh=/rff5WuuETbz3+BdREVdFqh43GqqchT9R+JQhxQA66Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+2kCq9Q9LaN2NcI4u8ZNCQGDX8ef73afQsWB0sNHR8oX1nE+o7So2/fFEp9PN5L/R94krqYmoUQ91Y6yT6bZHKvLcmFtiRpuMVvNjciqAZ+WdyndVJThV1lFDG73ds9bskXit7KARufBoltnEbx6mqDhYQ/0dY3yl16OR/s5/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fKqdl5vFKzKHLyV;
	Tue, 24 Feb 2026 15:50:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AE58E40573;
	Tue, 24 Feb 2026 15:51:29 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgC3Y_R_WJ1pWTFIIg--.8099S2;
	Tue, 24 Feb 2026 15:51:29 +0800 (CST)
Message-ID: <0d339d59-5208-4a41-8931-12aff1874edb@huaweicloud.com>
Date: Tue, 24 Feb 2026 15:51:27 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] cgroup/cpuset: Fix partition related locking
 issues
To: Waiman Long <llong@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260221185418.29319-1-longman@redhat.com>
 <9cc7401e7137e27cd2f02625aab23330@kernel.org>
 <3a3548ae-c5e1-4ef0-86dd-f66bcd2c6d78@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <3a3548ae-c5e1-4ef0-86dd-f66bcd2c6d78@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Y_R_WJ1pWTFIIg--.8099S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4UuFW5ArWfKrW7Ar1fZwb_yoW8XF4DpF
	WqgFy5tw4YkrsYk3Wqy342gr18t3ykCF1Dtr1qg3s5JFW3tF1rur4j9rn8Cr1kWFs3CryU
	Zrya9ay3WFnFywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	NEURAL_HAM(-0.00)[-0.966];
	TAGGED_RCPT(0.00)[cgroups];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-14208-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,test_cpuset_prs.sh:url]
X-Rspamd-Queue-Id: BFD56183748
X-Rspamd-Action: no action



On 2026/2/24 5:11, Waiman Long wrote:
> 
> On 2/23/26 3:57 PM, Tejun Heo wrote:
>> Hello,
>>
>>> Waiman Long (8):
>>>    cgroup/cpuset: Fix incorrect change to effective_xcpus in
>>> partition_xcpus_del()
>>>    cgroup/cpuset: Fix incorrect use of cpuset_update_tasks_cpumask() in
>>> update_cpumasks_hier()
>>>    cgroup/cpuset: Clarify exclusion rules for cpuset internal variables
>>>    cgroup/cpuset: Set isolated_cpus_updating only if isolated_cpus is changed
>>>    kselftest/cgroup: Simplify test_cpuset_prs.sh by removing "S+" command
>>>    cgroup/cpuset: Move housekeeping_update()/rebuild_sched_domains() together
>>>    cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to
>>> workqueue
>>>    cgroup/cpuset: Call housekeeping_update() without holding cpus_read_lock
>> Applied 1-8 to cgroup/for-7.0-fixes with the following minor fixups:
>>
>> - 5/8: Removed a duplicate test entry that resulted from the "S+"
>>    removal (two previously-different lines becoming identical).
>>
>> - 8/8: Fixed typos in commit message ("essentally" -> "essentially",
>>    "beforce" -> "before") and code comment ("top_cpuset_mutex" ->
>>    "cpuset_top_mutex").
>>
>> This has gone through more than enough iterations. We can resolve further
>> issues if there's any incrementally.
> 
> Thanks for fixing the errors.
> 
> Cheers,
> Longman
> 

This series looks good to me, it's much clearer now.

Thanks.

-- 
Best regards,
Ridong



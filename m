Return-Path: <cgroups+bounces-11841-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80857C5039B
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 02:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B693B29AE
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 01:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCF827E045;
	Wed, 12 Nov 2025 01:42:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F149C27B348;
	Wed, 12 Nov 2025 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762911773; cv=none; b=raVRcnwj4A9kXaHjOjnGSYMpMNoRGCFRnm9xEGj3LHAIxfnN73HWRqjNdPnw7w/4prkSpqifF0H3sMmkRQBVlNx4tPd48FP2PLc4SD1z3o9ekKXdWwbNoHVU2jCc/D+mwttZXTSIr91sRlsFBpujBfwrfIUFF+bpnXITuYLe3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762911773; c=relaxed/simple;
	bh=iXJzpszPFFgqyF131PAUcV/1KSKkkZ7UBUuJCB04/PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDBtB5IC3XhiwzAilJFizMnT5JKVcv8LgSzk0pYpVi3OzVh1kRsinpYBBWzR8AiGhr0d+yCsASmkD+bWQbQ99MvfR+vy5mtIfKJ8H/Y7KgKzbNJfg23ZWphPeGhTt0bcTIV77s/XkowbUuqxjXS1xk/F0NEI1Uj7H3xq74q1Nrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5mNq6qpkzYQtg7;
	Wed, 12 Nov 2025 09:42:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 970FD1A0C78;
	Wed, 12 Nov 2025 09:42:47 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgBXs3kW5hNpWlLAAQ--.49377S2;
	Wed, 12 Nov 2025 09:42:47 +0800 (CST)
Message-ID: <5c9af868-ec66-481d-b25f-7d0f7c2bc6d8@huaweicloud.com>
Date: Wed, 12 Nov 2025 09:42:46 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cpuset: Treat tasks in attaching process as
 populated
To: Waiman Long <llong@redhat.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20251111132632.950430-1-chenridong@huaweicloud.com>
 <dpo6yfx7tb6b3vgayxnqgxwighrl7ds6teaatii5us2a6dqmnw@ioipae3evzo4>
 <fed9367d-19bd-4df0-b59d-8cb5a624ef34@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <fed9367d-19bd-4df0-b59d-8cb5a624ef34@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXs3kW5hNpWlLAAQ--.49377S2
X-Coremail-Antispam: 1UD129KBjvdXoWrXw4xZrWxGF1UGFWDCF45Wrg_yoWxGrX_Zw
	4Skr1q9r4Fvr4fKa1rKFZ8WrnrAa1vy34UJ395JrWUZas5XFZ3Xr1rC3s5JFy3GF4IqFsr
	Cwn0va9Y9a429jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbz8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/11 23:16, Waiman Long wrote:
> On 11/11/25 9:01 AM, Michal Koutný wrote:
>> Hi Ridong.
>>
>> On Tue, Nov 11, 2025 at 01:26:32PM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> ...
>>> +static inline bool cs_is_populated(struct cpuset *cs)
>>> +{
>>> +    /* Tasks in the process of attaching should be considered as populated */
>>> +    return cgroup_is_populated(cs->css.cgroup) ||
>>> +        cs->attach_in_progress;
>>> +}
>> s/process/cpuset/ in the subject
>> and
>> s/Tasks/Cpusets/ in the comment above
> Agreed.

Thanks, will update.

-- 
Best regards,
Ridong



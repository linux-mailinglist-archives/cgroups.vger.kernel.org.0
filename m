Return-Path: <cgroups+bounces-12201-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6421FC87D5A
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 03:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9BB3AC91F
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 02:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816B2EF660;
	Wed, 26 Nov 2025 02:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0Qg9MW/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBqI0DPh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474CD22A4E8
	for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 02:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764124442; cv=none; b=aMJos4TOmPPeGJEUzXiFPE2aAKGoPpAvGs/BkmF4mdmHGA2uCiDGXTodQLh6gQUpkcUm3wwVR3vXNNXNGJt258qmUVxPqTYmbVDZFd8Jv2F4jbBuQW29Eh0qhrdMm5RF3EmKqyVHWl+SxJj3P7VAUFLT2/xxyZDICxC9ZjqeE/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764124442; c=relaxed/simple;
	bh=+LFFjhNbu5lZSrbuLBmkZYtjhNsOgYEfLOKDDeFGLU8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fi+Ylb+6bOqY/YhaV6eN+2+x1zMjd5CjV5Tkf4tg3FejgEBPNTIK2JapZNSLo8NDdQnw0b1nOZAQWhc0Q1vyhjgMfiDlsJS2U9npelAWFX1G26rxMF1d/UH531tEfWVL+GiJLeDCOr2feg9/foqRAQ5Ys/T4+xaPF5u/1eC3PuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0Qg9MW/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBqI0DPh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764124439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khR6G5j6LeYnYLREff6usfxODvmiqoKm6G0Zfw20k9A=;
	b=P0Qg9MW/XHV/o2NKwzWS7sRdd/pGZNjRGItBGn+pFXUmhYkFk/IwXT5bVQe0avdUMVnhYO
	1kUH4sfmcixajSxfRik1A87ICpWkgnasMjQ2l0CD+XJRC42qreDc9q1MYWlRW4GB9sNTh/
	4UZ48P2IVaAWAkCi1t2i4U1nQyRjZPA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-GyWPApfeOqCNV5zvhmvq9A-1; Tue, 25 Nov 2025 21:33:57 -0500
X-MC-Unique: GyWPApfeOqCNV5zvhmvq9A-1
X-Mimecast-MFC-AGG-ID: GyWPApfeOqCNV5zvhmvq9A_1764124437
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b24383b680so2144846685a.0
        for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 18:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764124437; x=1764729237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=khR6G5j6LeYnYLREff6usfxODvmiqoKm6G0Zfw20k9A=;
        b=jBqI0DPhsqDvTb15+lBKqFXpsOixku07CvrYM71fQwh6a+t5smZ0f5P7BC3bu8Q1fg
         lGnI/1yLEj5xjBgm9rjjodCB0nOXoDa+OtukrrojlXh8ivTzLvGPF3ZzQPOZDcUvdbJ3
         UIhrFmEW8+J16XKnzfe8TToEjjtXur/cLlZNP8puN1AVNHRPT190s+63Iu1isRqeXZQW
         ZUNqNSuNIfKeXEHkbQ+lR9/yBMIDqtLIyOBsVNcU3/P7c8CYGJu5HkO2bawJxJiX3a2M
         Hw3HwDBNZGWkcqZHEEqSamqbBWYFjmo6BX/AEDRprtXlJ63DQtArauD4e4ihwKJ1bXc/
         rF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764124437; x=1764729237;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khR6G5j6LeYnYLREff6usfxODvmiqoKm6G0Zfw20k9A=;
        b=P/nLz54q1vN5v27G65PQHXp8zKVjXHz1M48QHi8TLPcEdWyT3SacneGrvx5957Dxvw
         Re+EgF+bMGsvh3oFfoiUD4NnobsdYMU/ta6hV5taNQ98lSDW7S7VybnFXC7HcmevSmAi
         l+Y4YMHFnWB5nUBFQLTwU9P3TZcxVYVsK0gwC1DP2msvGJnrSAjp3wv29hEAtUMDB2Se
         Qp2C1ey5mCbVQvayHsuKkef4DLD5WqwDN7XsrKJ9ctxpiBCgwbTPOAoDFXpm+zpfQRPj
         yAO6Dn5vnJMmcT6h7nOxev7T0wE1u6JuosJ7SM8x3amzwO2olVYLu3MfmE8KUIh6MR6d
         +Xhg==
X-Gm-Message-State: AOJu0YwARIHqbqjZF71Vm3VDKUZVd9ka3I1uQu1UOkkACUimCo5NlRmn
	XhAOn0V3Of80w/bGGeQD2oywi7yTmjtZ+BCziwNShfTfRo1kvuW+enJxdaQdvTD5ZeG+K54/Abg
	hUSDSal1vhX1uiNJMHdqA7zSdOhvtN1czgs1Fgz+aWNr81neoeUg7pvciCxw=
X-Gm-Gg: ASbGncvf0OZPzcFiGz/NW2yexe4PU+6aV7LCckqheRcIDzfxnyWnTZFdnnvWw/feG4G
	PqOxdRne0YSGBYf73ReaxCAcv6/45XrmLQzuTOxSZxVILbGuEhxT25tM76Q3iamRLi8/RbrmE28
	MR/9FHY/jdWLeppCUg9wEW+Shl89cJbsUPQ+jOYG6Lp/I2cJy4OkEb3u9PPYATtKHdaZYpWsmCA
	7FfCoCjcOtXhhXxDEd8nP6u/is3OmFrcH9rmZ80/5GNerbS2cxGMtT7Tk/QpxgMyLF0u6LNZ0V4
	MU7PPxBhpU39ErbdnSUXzPpYr25ikKVDqgLZq95Wq+CBmFB9P1WY6W2JhkOvHEVXZtdeRayiuGx
	UrhqXiF7cVefZCeDiqoxcsVTCfEMnP08w7cTVyp3l6BWQbvIMZeBfiiYi
X-Received: by 2002:a05:620a:472c:b0:8b2:f29e:3afa with SMTP id af79cd13be357-8b33d4a74ffmr2175761785a.45.1764124436888;
        Tue, 25 Nov 2025 18:33:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/TeCaSeghqdxyn0kLeVMxodP41ayP8g58ovmVJ2Z6pGjUXF1b5dxQK9qisPQXAoSh6f18uA==
X-Received: by 2002:a05:620a:472c:b0:8b2:f29e:3afa with SMTP id af79cd13be357-8b33d4a74ffmr2175759885a.45.1764124436552;
        Tue, 25 Nov 2025 18:33:56 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295eefb6sm1299270585a.50.2025.11.25.18.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 18:33:55 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <eaedf7d3-31dd-448b-9b00-60542e54260e@redhat.com>
Date: Tue, 25 Nov 2025 21:33:54 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: Remove unnecessary checks in
 rebuild_sched_domains_locked
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.m.jordan@oracle.com, lujialin4@huawei.com, chenridong@huawei.com
References: <20251118083643.1363020-1-chenridong@huaweicloud.com>
 <27ed2c0b-7b00-4be0-a134-3c370cf85d8e@redhat.com>
 <0ecb1476-2886-430f-a698-cabbe9302129@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <0ecb1476-2886-430f-a698-cabbe9302129@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/25/25 8:01 PM, Chen Ridong wrote:
>
> On 2025/11/26 2:16, Waiman Long wrote:
>>> active CPUs, preventing partition_sched_domains from being invoked with
>>> offline CPUs.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>    kernel/cgroup/cpuset.c | 29 ++++++-----------------------
>>>    1 file changed, 6 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index daf813386260..1ac58e3f26b4 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -1084,11 +1084,10 @@ void dl_rebuild_rd_accounting(void)
>>>     */
>>>    void rebuild_sched_domains_locked(void)
>>>    {
>>> -    struct cgroup_subsys_state *pos_css;
>>>        struct sched_domain_attr *attr;
>>>        cpumask_var_t *doms;
>>> -    struct cpuset *cs;
>>>        int ndoms;
>>> +    int i;
>>>          lockdep_assert_cpus_held();
>>>        lockdep_assert_held(&cpuset_mutex);
>> In fact, the following code and the comments above in rebuild_sched_domains_locked() are also no
>> longer relevant. So you may remove them as well.
>>
>>          if (!top_cpuset.nr_subparts_cpus &&
>>              !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
>>                  return;
>>
> Thank you for reminding me.
>
> I initially retained this code because I believed it was still required for cgroup v1, as I recalled
> that synchronous operation is exclusive to cgroup v2.
>
> However, upon re-examining the code, I confirm it can be safely removed. For cgroup v1,
> rebuild_sched_domains_locked is called synchronously, and only the migration task (handled by
> cpuset_migrate_tasks_workfn) operates asynchronously. Consequently, cpuset_hotplug_workfn is
> guaranteed to complete before the hotplug workflow finishes.

Yes, v1 still have a task migration part that is done asynchronously 
because of the lock ordering issue. Even if this code has to be left 
because of v1, you should still update the comment to reflect that. 
Please try to keep the comment updated to help others to have a better 
understanding of what the code is doing.

Thanks,
Longman



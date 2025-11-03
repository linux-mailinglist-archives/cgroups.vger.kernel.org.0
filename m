Return-Path: <cgroups+bounces-11544-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4410C2E20B
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 22:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9388B3B5F81
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849412C0F76;
	Mon,  3 Nov 2025 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FC7Flu7f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHhICV/m"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13301DFF7
	for <cgroups@vger.kernel.org>; Mon,  3 Nov 2025 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204673; cv=none; b=dIKBujAZhbCVzpauvd9nYgoKjBlocg+iGveXPdERX8zgFLCbjau090enSm08exElHDrjBDW04aT+5YkdoMru0RW22jx47Gb/jK4xjxEKQpLmcXjK6meLVZJIGIdUqKJTe+MWgn6XoXy4XkkRkGwmHM00Fs09qVvaeX81gQ25+uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204673; c=relaxed/simple;
	bh=9J6yqex/gZJKgynTDeP/ehjjvv0k/x/9/xKD0WVfO6M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O1vqXP4B6hoeTv2ycgAPUcw5uKdOAaO2NOgVsBZ/T7NVQqR1t/h4V5Zn67CJloCvNfkmt56+fObaV0SJSWLu9+/3Z2KhZ5x+9BYZ+TceW7TYEg8a8E9j6nmdnX1GUTzb/seWcMgQZIoARQrVgc3s8amoj490Ig4LG70VzZngw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FC7Flu7f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHhICV/m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762204670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USFRuarN2DDmZ60WTQmY9vNchaKY1eZd7PSTZA30xy4=;
	b=FC7Flu7fT4XTNWrn+QSNSlz5z/vOvmFRFWnWipMTvbP86Fk0Oym2WVuLa55qhyAZX6+6Hc
	o/8XIkh1eMCTUeVsmC6NgJmg1GMxQBJfUKpH3eTX+cBPvvRdL977GheGs3DC2CJa9DbByn
	33Hb7VYHMCD2pYmp0jaCfPKF6pkS2GA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-KaHRsjaeN4KTLK8KsaGycg-1; Mon, 03 Nov 2025 16:17:49 -0500
X-MC-Unique: KaHRsjaeN4KTLK8KsaGycg-1
X-Mimecast-MFC-AGG-ID: KaHRsjaeN4KTLK8KsaGycg_1762204669
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78efb3e2738so104359236d6.3
        for <cgroups@vger.kernel.org>; Mon, 03 Nov 2025 13:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762204669; x=1762809469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=USFRuarN2DDmZ60WTQmY9vNchaKY1eZd7PSTZA30xy4=;
        b=HHhICV/mZugNvZAhp4YGr0oPkX6jqBwBQXpdxOWTWasceUFxwc04r3BziL1B0FStzb
         6VOfX4KJRr4UDf3nF9rv2dSYipLcFJ7haweuVaQPAkvxON1zpbjgEV9yT1hqlKMGa1jy
         UAGgp3UrpTT/24SfVk9qcRdmpgWxG3XoQ18+0a+b9yCDDao4toDed17qMpS7qdYLe4SW
         Fct6UxL+RlyUqKOZ4tfgBX//hPCqCbGIiutgnJetWRGrypzeD3JIX8v+tQ1NiGxQlQCw
         Xbxgl5yyCOOQf/ywk+JM6SJ2GeXfCgKtZF+hmyD3L07Q9HlPaCKD+/y9afeZNz2VbCAR
         IP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762204669; x=1762809469;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USFRuarN2DDmZ60WTQmY9vNchaKY1eZd7PSTZA30xy4=;
        b=divvyTHYsqnVV6JwUAPstkD88mWKNtHG9oU9rihSt7dXLIxfnbhJbqDoLGDsiV4laV
         Ue3ai3svTw3YMc5pBvTewtK7SqyFzt2B3vK9dvAdJ5teDlrx/J++PL/tHvBe/7fN6byD
         aKwCClOAiNzxqRvTlBMv6Qkkdz5E4AaU7HM1Z2Si1O2LPmO6DT+izH+QEkGUJ5y/g0IQ
         pdmbUQ1bEKahIPouH/XXCxYNj1E+GAtnItOBwl+8f2wyLIzSjZqBbTfhnkorBUm/9/U5
         rAGDKSBzbh1ZQtCj4yu2ZJm6ttV/hEx1/jOdzoBD/gPMx06tqJYv9tLZhkV78breUUWQ
         FFIw==
X-Gm-Message-State: AOJu0YyKbfEgDw5wH0mZA1ekDvoFi19b8xID4IELKpPTyQHpsu+UvP55
	948DNko0U6YM405M723wU2mEs+i529OcXNBwHhUqAQ/6EODIa1OdPp9xryaDPIKoCktqChYiHiX
	mnjhcwpyCi6JKVHImYJPo696tQOk7G2aQp/u5vHNFgBFVNNkF5KYozhQK4Wk=
X-Gm-Gg: ASbGncv1kd7aigj6fHNDATb7VyU6w3yH591TCkgSdG1hL/yJCHzrY+6o8QP+sDqfu0P
	4YIdFKBNHJO4ym0bi0BO/HlC8LA8uGVZPcQAftIf8rea3F6qFksx0TebFhQKTBx9xD/UoK9E6lT
	r0V4GsX3tNwpB4lYiZlQdFPRpvt5Og3yl7AQx8FK/XHlDneOCieXsetpYYhfr3P3xNeMJYBYwxs
	kjmv4YRv0eYBN3PZwCV8hfDnsF7JXVN7nsA6Sur2q/fsDpldDngMPw+IuM5w1ptapzW5lXUYh2Q
	neypr0yCxk1ZZ5mCBnMx6Sv8y43TlIF5kGAYnqCluFkAlzU7ND1BibMJnuOfl/qXuiGT1RtoHg5
	0hI9j7eMWt4Sos1FVZOdKhfM/M/IsXcEKzJ0vhQRchQHMXQ==
X-Received: by 2002:ad4:5ec6:0:b0:880:4695:4640 with SMTP id 6a1803df08f44-88046954d60mr135727256d6.28.1762204668865;
        Mon, 03 Nov 2025 13:17:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgiWHmeJStIAjhdNz7B69Q+dc+3OAFuWf7GDRnU1qJuTYKxeQ4SiuLMWhQY8veT2nqDtzHrg==
X-Received: by 2002:ad4:5ec6:0:b0:880:4695:4640 with SMTP id 6a1803df08f44-88046954d60mr135726836d6.28.1762204668454;
        Mon, 03 Nov 2025 13:17:48 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060db5a9esm9423726d6.1.2025.11.03.13.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 13:17:47 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6911f3c8-dcef-444f-bea2-d6bb247563d9@redhat.com>
Date: Mon, 3 Nov 2025 16:17:46 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH 3/3] cgroup/cpuset: Globally track
 isolated_cpus update
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251103013411.239610-1-longman@redhat.com>
 <20251103013411.239610-4-longman@redhat.com>
 <ffe1d7ec-70fc-44cd-879c-23902929a24a@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <ffe1d7ec-70fc-44cd-879c-23902929a24a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/3/25 1:46 AM, Chen Ridong wrote:
>
> On 2025/11/3 9:34, Waiman Long wrote:
>> The current cpuset code passes a local isolcpus_updated flag around in a
>> number of functions to determine if external isolation related cpumasks
>> like wq_unbound_cpumask should be updated. It is a bit cumbersome and
>> makes the code more complex. Simplify the code by using a global boolean
> Agree.
>
>> flag "isolated_cpus_updating" to track this. This flag will be set in
>> isolated_cpus_update() and cleared in update_isolation_cpumasks().
>>
>> No functional change is expected.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 74 ++++++++++++++++++++----------------------
>>   1 file changed, 35 insertions(+), 39 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index d6d459c95d82..406a1c3789f5 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -81,6 +81,13 @@ static cpumask_var_t	subpartitions_cpus;
>>    */
>>   static cpumask_var_t	isolated_cpus;
>>   
> Is isolated_cpus protected by cpuset_mutex or callback_lock?
>
> If isolated_cpus is indeed protected by cpuset_mutex, perhaps we can move the update of
> isolated_cpus outside the critical section of callback_lock. This would allow us to call
> update_isolation_cpumasks in isolated_cpus_update, making the isolated_cpus_updating variable
> unnecessary. Reducing a global variable would be beneficial.

isolated_cpus is a user visible cpumask. So I would like to protect it 
with both cpuset_mutex and callback_lock like the other user visible 
cpumasks.


>
>> +/*
>> + * isolated_cpus updating flag (protected by cpuset_mutex)
>> + * Set if isolated_cpus is going to be updated in the current
>> + * cpuset_mutex crtical section.
>> + */
>> +static bool isolated_cpus_updating;
>> +
>>   /*
>>    * Housekeeping (HK_TYPE_DOMAIN) CPUs at boot
>>    */
>> @@ -1327,13 +1334,14 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>>   		cpumask_or(isolated_cpus, isolated_cpus, xcpus);
>>   	else
>>   		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
>> +
>> +	isolated_cpus_updating = true;
>>   }
>>   
>>   /*
>>    * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
>>    * @prs: new or old partition_root_state
>>    * @parent: parent cpuset
>> - * Return: true if isolated_cpus needs modification, false otherwise
>>    */
>>   static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
>>   {
>> @@ -1347,15 +1355,12 @@ static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
>>    * @new_prs: new partition_root_state
>>    * @parent: parent cpuset
>>    * @xcpus: exclusive CPUs to be added
>> - * Return: true if isolated_cpus modified, false otherwise
>>    *
>>    * Remote partition if parent == NULL
>>    */
>> -static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
>> +static void partition_xcpus_add(int new_prs, struct cpuset *parent,
>>   				struct cpumask *xcpus)
>>   {
>> -	bool isolcpus_updated;
>> -
>>   	WARN_ON_ONCE(new_prs < 0);
>>   	lockdep_assert_held(&callback_lock);
>>   	if (!parent)
>> @@ -1365,13 +1370,11 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
>>   	if (parent == &top_cpuset)
>>   		cpumask_or(subpartitions_cpus, subpartitions_cpus, xcpus);
>>   
>> -	isolcpus_updated = (new_prs != parent->partition_root_state);
>> -	if (isolcpus_updated)
>> +	if (new_prs != parent->partition_root_state)
> Can this if statement be replaced with new helper isolated_cpus_should_update？

The isolated_cpus_should_update() helper is for validating the change. 
It is too late to call in partition_xcpus_add/del().

Cheers, Longman




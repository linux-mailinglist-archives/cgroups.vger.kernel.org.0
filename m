Return-Path: <cgroups+bounces-14099-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDDfAhkFmmnhXwMAu9opvQ
	(envelope-from <cgroups+bounces-14099-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 20:18:49 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D57516DA63
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 20:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7569030205ED
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D562ECD1D;
	Sat, 21 Feb 2026 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CURV2HjA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsJpXXrS"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC235979
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771701522; cv=none; b=qDvPEY424O7qiCVz7E3LrPFgNKqEBpeNjF8nyYbWG/CPJMPCWlVPJ7y+x8IKX8X21AXCOrhQvyKK8ECJpiqEMFNORtrgxyfqxKw1/oQcckVitlVW74QRLpb4hMPz7Jp9rgZqEoWb9qw7Xs+w0O7uSsBZG/5Rr+yx+krB0nth3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771701522; c=relaxed/simple;
	bh=y5yCMd2oa+DT/yk9AJ3rCQZW9RGjNj8Gsp2vP1DzXQI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cbWf4SywHfZPgweS8nkZOCwmdpW7Ejp86RpvY1m3ypMy0YE91AAnw+VZtB3wcMTvuCpnQ/HD0lOwCIBM2WMmb+pIUaAdEsuQ0d4ugfK8rLn548yVPGWwegW0TgFkK9C2bzFkfek2HjCjuZpGJWP1guLXFfBSAW81HZwV0fnBpsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CURV2HjA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MsJpXXrS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771701520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hx8RfWzWYamghKcrDMA6FiyZYhfTQKUfitsZoNr3bPw=;
	b=CURV2HjAq1FtKUpE8coeNsnaUKfimSSebJISZwe6QZ98rcPh4vl/upOR3dpWw2KAw4ffya
	qRd95Hr6YBa0w7Z/Be6KvACYDqNJEN5LGCM9/v7cfwiqg58G7LJ4MSXd691P/YtqLAxZoF
	cn4iIEyorFyTTO2jCQHBVqz8LI1i9G4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-LbN3-H4rP5C8HLPMJXh-hA-1; Sat, 21 Feb 2026 14:18:39 -0500
X-MC-Unique: LbN3-H4rP5C8HLPMJXh-hA-1
X-Mimecast-MFC-AGG-ID: LbN3-H4rP5C8HLPMJXh-hA_1771701519
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4a241582so2658243785a.0
        for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 11:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771701518; x=1772306318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hx8RfWzWYamghKcrDMA6FiyZYhfTQKUfitsZoNr3bPw=;
        b=MsJpXXrSN5GANJHvH+xjApCNG1Hgoqh729Gbxuu2uuP++7ug/5o0zoQX8Q1de+lK2O
         rACUmlnr0ecZQrJ4AVQia5LCds6nf5le4IYgn+aA8/7lApg84ZBDX04JWeN5ZEMg1vWm
         MN3WJjtkKSWwVe/0F3DQm50Welffxb3vwFW8n3Q4KVefVqXhzbrlSzAi1APpPE0O7tr9
         7t5b0idJF4zBCT4JQYXqB0fweoqdMszUEJey5c477JzCl4VGYMrx15auYh0yRTID2tl5
         XScZk8OWahwTcSdcRfU8yySqQni3pQpvnLcY5AkXdO8s6lj3CDEhesz5Q31KFkW5/QVN
         JOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771701518; x=1772306318;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hx8RfWzWYamghKcrDMA6FiyZYhfTQKUfitsZoNr3bPw=;
        b=bQ9nhSNKnorHuVHICdqXezevt6COO1MzZem0Ioh4aS2l3IB7QPv6IZZ5G2MJDjNnq3
         8xbPOaHWqCaNcwN1GoeOZ1OcV1HVlTXAIlmS80c7GaO/MvhckW+pivX/J+h59w0GvVOu
         NzBpz7GJxIsBXw2j0/MEKRYrdjzK/gPfzA80DMYQsrysUoVTFveeDDyubjXiUeKjSvy6
         Ss8LtWcRLLEORnuo5ejodHk9Rofu9LJ5BjC/hwxSrUQt3TMNZhIfrrr1KOLGYv6nGfK5
         6IBURgjWdfn0/drchZtUalDE+RcCoaOj6SjqM6UkeHtmG+5FBRP/MgFn1gQLiVj+0Omc
         4ZnA==
X-Gm-Message-State: AOJu0YyBP9/wWezexwSjhfdGSRbIYygsU1DbS3r+742Ljr93n7KZiO9D
	afm+YbDlDSsyc6dDSzq1N4s5uO/Ctlq4VVLBaxuO+8ccFi5EwjiwW26p9CtwXTCZ525qEAFz6Ou
	sDaBjBf8sBJendnPns+2BmuNTSNHGPl7mOlwZyxUKEGQFidbWJ0tXi27HEgg=
X-Gm-Gg: AZuq6aKXsEJB+/cHwERbE38wlcPWhZQxDWFPUmewggIZHHtkUTowvZ+iLec46P7e9rm
	63aLzLnrcGIHDSMACdQwr4Wy9rIE5VBFV0vf2zxoPDTu4X+dFHzMiiT+8odMimKRPOTq5+/+AMW
	Ovo6HIC/EE0GEueu+2wwiYkS5/wJMillvSA1a+FKzwXBDOvOHISKO9pzfR/aG7xdugG9rvn2nLc
	/TMOA9NT31NXklEkDPDwqSL8v+cuAnjexSKjuw7tloTZrYKHiN9CfCHZeB/EhheJsqY/51mmTcV
	7F7aJ6tDtQWQEV+uVK1KTkdembY7xqpz3T8B/6/u9uEnrqy8C46L3L0WIniOEnudUSKSZXLbNwX
	XizACzUk700CoU8uvugneLUTqBTDcnOw0fpmqBHhlLWOGphOkHx4r2z1emUy8wp68TH9e
X-Received: by 2002:a05:620a:708b:b0:8c3:7f27:a65d with SMTP id af79cd13be357-8cb8c9fd136mr483932085a.28.1771701518674;
        Sat, 21 Feb 2026 11:18:38 -0800 (PST)
X-Received: by 2002:a05:620a:708b:b0:8c3:7f27:a65d with SMTP id af79cd13be357-8cb8c9fd136mr483929285a.28.1771701518176;
        Sat, 21 Feb 2026 11:18:38 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0460c9sm287647285a.5.2026.02.21.11.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 11:18:37 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <359310f9-216a-4f0b-8de5-02d9b0829b3e@redhat.com>
Date: Sat, 21 Feb 2026 14:18:34 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] cgroup/cpuset: Don't update isolated_cpus from CPU
 hotplug
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260212164640.2408295-1-longman@redhat.com>
 <20260212164640.2408295-5-longman@redhat.com>
 <d77ef443-d816-4565-a9bc-e7e46c0a92c4@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <d77ef443-d816-4565-a9bc-e7e46c0a92c4@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-14099-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D57516DA63
X-Rspamd-Action: no action

On 2/13/26 1:56 AM, Chen Ridong wrote:
>
> On 2026/2/13 0:46, Waiman Long wrote:
>> As any change to isolated_cpus is going to be propagated to the
>> HK_TYPE_DOMAIN housekeeping cpumask, it can be problematic if
>> housekeeping cpumasks are directly being modified from the CPU hotplug
>> code path. This is especially the case if we are going to enable dynamic
>> update to the nohz_full housekeeping cpumask (HK_TYPE_KERNEL_NOISE)
>> in the near future with the help of CPU hotplug.
>>
>> Avoid these potential problems by changing the cpuset code to not
>> updating isolated_cpus when calling from CPU hotplug. A new special
>> PRS_INVALID_ISOLCPUS is added to indicate the current cpuset is an
>> invalid partition but its effective_xcpus are still in isolated_cpus.
>> This special state will be set if an isolated partition becomes invalid
>> due to the shutdown of the last active CPU in that partition. We also
>> need to keep the effective_xcpus even if exclusive_cpus isn't set.
>>
>> When changes are made to "cpuset.cpus", "cpuset.cpus.exclusive" or
>> "cpuset.cpus.partition" of a PRS_INVALID_ISOLCPUS cpuset, its state
>> will be reset back to PRS_INVALID_ISOLATED and its effective_xcpus will
>> be removed from isolated_cpus before proceeding.
>>
>> As CPU hotplug will no longer update isolated_cpus, some of the test
>> cases in test_cpuset_prs.h will have to be updated to match the new
>> expected results. Some new test cases are also added to confirm that
>> "cpuset.cpus.isolated" and HK_TYPE_DOMAIN housekeeping cpumask will
>> both be updated.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c                        | 85 ++++++++++++++++---
>>   .../selftests/cgroup/test_cpuset_prs.sh       | 21 +++--
>>   2 files changed, 87 insertions(+), 19 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index c792380f9b60..48b7f275085b 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -159,6 +159,8 @@ static bool force_sd_rebuild;			/* RWCS */
>>    *   2 - partition root without load balancing (isolated)
>>    *  -1 - invalid partition root
>>    *  -2 - invalid isolated partition root
>> + *  -3 - invalid isolated partition root but with effective xcpus still
>> + *	 in isolated_cpus (set from CPU hotplug side)
>>    *
>>    *  There are 2 types of partitions - local or remote. Local partitions are
>>    *  those whose parents are partition root themselves. Setting of
>> @@ -187,6 +189,7 @@ static bool force_sd_rebuild;			/* RWCS */
>>   #define PRS_ISOLATED		2
>>   #define PRS_INVALID_ROOT	-1
>>   #define PRS_INVALID_ISOLATED	-2
>> +#define PRS_INVALID_ISOLCPUS	-3 /* Effective xcpus still in isolated_cpus */
>>   
> How about adding a helper?
>
> bool hotplug_invalidate_isolate(struct cpuset *cs)
> {
> 	if (current->flags & PF_KTHREAD) &&
>      		(cs->partition_root_state == PRS_INVALID_ISOLATED);
> }
>
I decided to revert back to the v4 way of deferring 
housekeeping_update() call to a workqueue to make it simple, but do it 
in a simple and straight forward way.

Thanks,
Longman




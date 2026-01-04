Return-Path: <cgroups+bounces-12894-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 111B9CF1692
	for <lists+cgroups@lfdr.de>; Sun, 04 Jan 2026 23:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 042B63003BD8
	for <lists+cgroups@lfdr.de>; Sun,  4 Jan 2026 22:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9C127A469;
	Sun,  4 Jan 2026 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaKhDeAW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLdtya1F"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423A942049
	for <cgroups@vger.kernel.org>; Sun,  4 Jan 2026 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767565585; cv=none; b=u/7HLR/dkA/aGLlaE1o29R1JUopnc7tFtA6awK99Dbh/iXjFkNKIZ+G9lxz9JpLOa++fE5ppuggILZ0IMczgqrmQ6XRdtA2kvTIMC75+CpwCDTLixeWkxG7OIa3fJWSsS/zC0nEQZ/7tVSVYaolP1YvAErUtygnEURFgqy5kF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767565585; c=relaxed/simple;
	bh=18zqbZPHCZfC4IECcFh5Oo9n88sS/9RdXF1BYxgm8CY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ECKPbefbwhdrJH2ODbipcrZsU81Ct4Fng5jz0l3EhObQKHcKU416fgJTQaApfEaqE5busl8JQEmJJ23+m9kHCgAPer1lhPRwUpoYDqKcEeyYx19GDYBY48P602iLjsgkzCSeBUs37tzddQpT398D4+HwfbIFn24+nOLGWZQW0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaKhDeAW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLdtya1F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767565582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MX6wynQZFsiu7Tz4PLzaszcf/RQEoHul08Z9Zkyf+Is=;
	b=GaKhDeAWx+ogPJFWrFWWkOhcjODQhbhIw9jcPIvgbsbuX4TOLb9zIfpscFW72RahTc647A
	L946Cklp971uchvXwojo7opQpEalMGZYeVNiAYjpSigw/nQ7IsOwl5v6sl2tZE0GllHpIK
	4SrG7SdPAjkI2w6HTfrKRTcLDslKDns=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-JTWrbk7zMOyorkrxxoK7tw-1; Sun, 04 Jan 2026 17:26:20 -0500
X-MC-Unique: JTWrbk7zMOyorkrxxoK7tw-1
X-Mimecast-MFC-AGG-ID: JTWrbk7zMOyorkrxxoK7tw_1767565580
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c1cffa1f2dso386179485a.1
        for <cgroups@vger.kernel.org>; Sun, 04 Jan 2026 14:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767565580; x=1768170380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MX6wynQZFsiu7Tz4PLzaszcf/RQEoHul08Z9Zkyf+Is=;
        b=aLdtya1F1GDOdz1hTflB7L6wy3yPREOMaiqfJ5Ck8NYpDiRd8ZcLsqYNfzaQTMMJiL
         ribdYnwTe2ri594qkNwlKANnEOWOFOoj9y52PShxpd0Ey7Dz9U7F4s782NF90lQGx3mw
         KR8hqu0dEgW+etnTcevicCcqJVt9id8KN0ev38lFm4SlsZ1aKWVbTcKCWeLl7CgVm+tm
         4zk8woOBUidyyBd9xHBvy5KGYGw06LrrIE7Ts6CG/yT7+2jtkU9yaZeUaY4pSa+TBFjK
         09ajFFCoMgs2FAJ1+IlFjfHoJ4eyVAqjM0M26K4d5Ozc6noYunHULfApOySPqcLp6+iL
         BrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767565580; x=1768170380;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MX6wynQZFsiu7Tz4PLzaszcf/RQEoHul08Z9Zkyf+Is=;
        b=T4R9xegC4ot+sKLwcrnClAoGpmQg8l0rojTviKOV0gnvdudUISWu39M+t8dBj2AlWD
         UZPXwSZO7bMqnNI9Hhod4tpLXCU64TH34Yxwp72omnwsE8ebe6mz+XuaRwy35ezdf84g
         EBKi7rOn4GHA9p12CVPsLB60/e68jr2EceUfWPKcFA6lsMgxZGV5BG7kCkp5eMTHpTe7
         4mBmggznkDQFJmQakriGXqXxkxcB6Ynsj8j29ZPZYGjK9A16teqnYv2ylEO/bhirU7qc
         Ulh98ipcTk9uIzKAJB0t5KRZc/Jq6wbLSTxW1EV0t2wwPybyWDjGbjoWpayQlB8cj7II
         9qSw==
X-Forwarded-Encrypted: i=1; AJvYcCWg4+0RWIocpUmGMtTdpyfyGuBzoUCiW49zOYjcVY1EjyNe/HkiGC/PXaxmmB0089znJa9YAYd1@vger.kernel.org
X-Gm-Message-State: AOJu0YzBuLzKg8BQTt95wbcI79YhpaLBjnH7OCzytsmQCj3jGtTe6jYH
	cg4XSqaTMI98c5U4EDU+ODRKONvKCFU6B4fR8m7lulVEY8rWsYY5abEZ4CgGklJ7mHi7BRa03yb
	MZq7SYtRPRYgX859+kJo/+K4sMlO42bZitzMI7qP9YK1qs9qBtXLwvKO9ZTM=
X-Gm-Gg: AY/fxX72Ugi5RISlBWGqSRMAvLCgIYvv6tARdaiET6226RJrc95OT6KPRdVZgMt+qB7
	lph0zDaY1SwgmWUmKHxh1LMCfGFiGHojU2zFD7WGQIj3kBxx96dZa7uX/jkcc/p1R8HdjKe7rUq
	AtLd9eVyAnAc2dbwtkMrg7zphJtkf3BXtdEH9sR/CizdynUBOA2Grfl57Qp45Otbqq16lX4CGEP
	YYUAglfuWeXmHRh3GNEIILcTHh3sVgNK0vteDySQD5XdrCNPhQnqyGOjhXtKe8JuYC8tzyb9pgJ
	G0bFCoQmzPyL5uO554Fp0e28QG2P+ynW6+vLu5SEa30R//F8yLmxpX2DmpO11pISwxf0En2eG2c
	u3/SZz2m2aJuwUrSp8mVaitLITAc3PYgYeF9FmvuDABBZTw6gFdb8yU5U
X-Received: by 2002:a05:620a:2993:b0:88e:1be9:cf65 with SMTP id af79cd13be357-8c356f610f2mr826664185a.39.1767565580443;
        Sun, 04 Jan 2026 14:26:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1alN5adMavXwg0qoPb9OAbKBalJiqdid2PFcZ88dBnIGljKevyz4sWtBubRBFhtfzz1Bexw==
X-Received: by 2002:a05:620a:2993:b0:88e:1be9:cf65 with SMTP id af79cd13be357-8c356f610f2mr826661785a.39.1767565580057;
        Sun, 04 Jan 2026 14:26:20 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9aa363e3sm337038506d6.57.2026.01.04.14.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 14:26:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5ed163d8-c229-4aed-bc8a-ae9cba9b78ec@redhat.com>
Date: Sun, 4 Jan 2026 17:26:18 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 4/4] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-5-longman@redhat.com>
 <f561b413-7fdc-45d9-9d89-8bd55e960d51@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <f561b413-7fdc-45d9-9d89-8bd55e960d51@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/26 2:53 AM, Chen Ridong wrote:
>
> On 2026/1/2 3:15, Waiman Long wrote:
>> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
>> with the cpuset.cpus/cpuset.cpus.exclusive of a sibling partition,
>> the sibling's partition state becomes invalid. This is overly harsh and
>> is probably not necessary.
>>
>> The cpuset.cpus.exclusive control file, if set, will override the
>> cpuset.cpus of the same cpuset when creating a cpuset partition.
>> So cpuset.cpus has less priority than cpuset.cpus.exclusive in setting up
>> a partition.  However, it cannot override a conflicting cpuset.cpus file
>> in a sibling cpuset and the partition creation process will fail. This
>> is inconsistent.  That will also make using cpuset.cpus.exclusive less
>> valuable as a tool to set up cpuset partitions as the users have to
>> check if such a cpuset.cpus conflict exists or not.
>>
>> Fix these problems by strictly adhering to the setting of the
>> following control files in descending order of priority when setting
>> up a partition.
>>
>>   1. cpuset.cpus.exclusive.effective of a valid partition
>>   2. cpuset.cpus.exclusive
>>   3. cpuset.cpus
>>
> Hi, Longman,
>
> This description is a bit confusing to me. cpuset.cpus.exclusive and cpuset.cpus are user-settable
> control files, while cpuset.cpus.exclusive.effective is a read-only file that reflects the result of
> applying cpuset.cpus.exclusive and cpuset.cpus after conflict resolution.
>
> A partition can be established as long as cpuset.cpus.exclusive.effective is not empty. I believe
> cpuset.cpus.exclusive.effective represents the final effective CPU mask used for the partition, so
> it shouldn't be compared in priority with cpuset.cpus.exclusive or cpuset.cpus. Rather, the latter
> two are inputs that determine the former.

Yes, that priority list can be somewhat confusing. I will take out this 
paragraph. The next 2 paragraphs in the commit log should be good enough.

Thanks,
Longman



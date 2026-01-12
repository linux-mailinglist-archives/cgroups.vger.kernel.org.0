Return-Path: <cgroups+bounces-13073-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 984D7D13ABA
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 16:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8E94303F37B
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44AB2E7BDE;
	Mon, 12 Jan 2026 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OquIy3yk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioGvxbv3"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56D2E5B19
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230925; cv=none; b=Crj00UoHHRq1K8Ubw5MdUWwBldCsvmu8eDQUwF3+wGg0JedJVsWeuyvFwheDJGjsrbs8LASXLAkWbh8L4tirR37XF9gKNZoXraEjG+GELMNve3/jo835GpmYlc56RaPC21WjzAChV8vFleddTE+1ROt4t7+FwGVClboZNFxxYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230925; c=relaxed/simple;
	bh=UWmSshBEHQ7KxE8MnHPkIfsFEU9/Q6SjGSI/Gge/kD8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k3vzlimCEXdo7SStB4cxLNHOlrvf8SgrR495NWVQNPKe5N2r6lxHBXW29vPDywl3sqSwaLQOMkE7HXg2bxaQIHj52znkiRxC7FHfa9+wUbNfc3wyCKfCgDnKtil+9dnw+3GoZybrlNJGVbcGXT262WbcZSlgrh9VernKQ0pZqXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OquIy3yk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioGvxbv3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768230923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBnEhkF7Qdzoo2GNW/2wAAQ4zQejO2Ma9rGc252Ro1o=;
	b=OquIy3ykPivdZ4P3JfPsaDY8hP4Rxp3Wbq8INII1kreH92PLKkSqo9vg/PcyOphmZtNKNQ
	Jixtypw/kDeJdBj4bzNL02vB4hukIC/LfpYO+LDlmD9TujviMcUM6jXS3MSb1F0gwzUZeP
	4mLNWwmEGuz6XuXEluoh1LVXXsQ7yjs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-gmWEhXG-MUehHG7u8qtgGA-1; Mon, 12 Jan 2026 10:15:21 -0500
X-MC-Unique: gmWEhXG-MUehHG7u8qtgGA-1
X-Mimecast-MFC-AGG-ID: gmWEhXG-MUehHG7u8qtgGA_1768230921
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a32bd53cdso202383616d6.0
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768230921; x=1768835721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBnEhkF7Qdzoo2GNW/2wAAQ4zQejO2Ma9rGc252Ro1o=;
        b=ioGvxbv3KePlaaSTy5wqTAqfaMPBb7jFEBOvmyp1gXHqCeS6U7WOtjPN+HGMDrEI4V
         p6FfEQy1kafw0OI9oqueCm7CMl4tFj6NByWvaFm07qVReKjisc/pDAl9pFvmtL7qK3BT
         Ck8zDj8dk4i6RUTc17Uc2lU5hB3hMb+035RVg3LnvSX6xHyQwdvg6MFpKA2/luEQ0pFg
         h5Luum8SQ40G05TbtnelPwm+XVQ6K/mCG1jBdlnt3yroW3Hquyj7MqpF9wBshxuygRWL
         MnWrGsHolYYrJfZj5ZAYMneMzUqob4EHAE00kRblHCg9XKvS/vaG1EkrcJtS1vx+Qdyp
         1lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768230921; x=1768835721;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBnEhkF7Qdzoo2GNW/2wAAQ4zQejO2Ma9rGc252Ro1o=;
        b=UmCf70AFruKkLSZkg25hyW1uEoeIn7Bde6oYyVA6JScgyHl+MtopYFauOj0OGS/AZA
         22EC/5zSL6sO1KuXDHMxjdfsKrJwxm6neLW098y7ct9YMC8dYFSniGxehaUQMWg2EAJ9
         xsng68S/NidaY2u4A+kiEiU1ccQeBMtBhQFIOXRgxUo/v6hF3bc2s+4cqNz/rE8r6i6B
         Okh6Md28RQ02KGhNmmj5RUDHeik2rnu9wI2pFDwmMFc+50mvFUtXuUc93oEDgS6w1xAJ
         XowL4H4Nu4LIYKg8SzQBBeleus5CLUBpor11G3PQ0dnWy1qusWkQONTYtgSCKw4R0By+
         IchQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv8vcpjD6blqmuI4vJ0oXZjmeZBl87Up9TpGmMe29oEF6TfBAaWisfX8rmcrhyRdHcUNlHCTfg@vger.kernel.org
X-Gm-Message-State: AOJu0YyR/0YA2mYJl26gpSescqnTs1d1TVAzl37gFBW83rMSe9J3cxKG
	5FMepVCo2Xx1XOJqd3E59izZHQnPdPh5ZQJA+QnWB+DOUEBojDCc1KRp0kDXU/1RaRgkZhbDiVt
	QFCGiQaoQ1rzomK0TQnh1E2333PBZqTNysdf9zW97lRi8a5H+l9UAyA0BnIQ=
X-Gm-Gg: AY/fxX47oqPOiJSK9Ux1CtY8PsDK9xoHhhQCcoXQluSV2T4LpdsbeaiB8GEGQlacOwc
	Ybrz406F7ck2+TJg0BkAyS0s4gcwALhu+xeXX+IV0IBmKXYTx/T7a8vaBXxh8GxRLM2jLoYBanL
	+siAUqR+Yb8gYTkjm95R4NyoM/RRZUuO98VnaExHiY4dLAvW97ixMzKrRV1svyhXYXrZAMMspeC
	9Nie7btv0FvCUwmwqNb9Ot55LEOyq/6u3dwVwveUbaZBv5RIFas1kBsZfOXtAP37oYh+VKZcd8M
	E9WJwAj9LeLpBwXxU8+rDJ+moLwBryLeSFn3a6921fhfzaKdOnXBno4z74xn1ZU6Nuuxp1BJRW2
	oFKcrx17XCmELhmUlH80vBQD1Isl8zi0BIbnOq5HlolkBCfabuoZXVb+T
X-Received: by 2002:ad4:5b87:0:b0:87f:e1b3:2014 with SMTP id 6a1803df08f44-890842d60cdmr242991886d6.66.1768230920856;
        Mon, 12 Jan 2026 07:15:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEEvjOnKFKxOB5sHeF3FHbEdls66ozWBRKEY9iiOUfJDVYVV2wAJMexcKiVyLElIE1U7IUUw==
X-Received: by 2002:ad4:5b87:0:b0:87f:e1b3:2014 with SMTP id 6a1803df08f44-890842d60cdmr242991006d6.66.1768230920201;
        Mon, 12 Jan 2026 07:15:20 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077253218sm137736816d6.43.2026.01.12.07.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 07:15:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9a1b7583-7695-484f-a290-807b6db06799@redhat.com>
Date: Mon, 12 Jan 2026 10:15:17 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-6.20 v4 4/5] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>, Chen Ridong
 <chenridong@huaweicloud.com>, Chen Ridong <chenridong@huawei.com>
References: <20260112040856.460904-1-longman@redhat.com>
 <20260112040856.460904-5-longman@redhat.com>
 <2naek52bbrod4wf5dbyq2s3odqswy2urrwzsqxv3ozrtugioaw@sjw5m6gizl33>
 <f33eb2b3-c2f4-48ae-b2cd-67c0fc0b4877@redhat.com>
 <uogjuuvcu7vsazm53xztqg2tiqeeestcfxwjyopeapoi3nji3d@7dsxwvynzcah>
Content-Language: en-US
In-Reply-To: <uogjuuvcu7vsazm53xztqg2tiqeeestcfxwjyopeapoi3nji3d@7dsxwvynzcah>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/12/26 10:08 AM, Michal Koutný wrote:
> On Mon, Jan 12, 2026 at 09:51:28AM -0500, Waiman Long <llong@redhat.com> wrote:
>> Sorry, I might have missed this comment of yours. The
>> "cpuset.cpus.exclusive" file lists all the CPUs that can be granted to its
>> children as exclusive CPUs. The cgroup root is an implicit partition root
>> where all its CPUs can be granted to its children whether they are online or
>> offline. "cpuset.cpus.effective" OTOH ignores the offline CPUs as well as
>> exclusive CPUs that have been passed down to existing descendant partition
>> roots so it may differ from the implicit "cpuset.cpus.exclusive".
> Howewer, there's no "cpuset.cpus" configurable nor visible on the root
> cgroup. So possibly drop this hunk altogether for simplicity?

Ah, you are right. I thought there was a read-only copy in cgroup root. 
Will correct that.

Thanks,
Longman



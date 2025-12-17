Return-Path: <cgroups+bounces-12387-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E80E6CC5BE4
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 03:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA4F9303134B
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 02:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1295D1A9FAA;
	Wed, 17 Dec 2025 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaU5Pelt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lp2mDsqd"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98A3A1E6B
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 02:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765937017; cv=none; b=q4jwqjyxe/JT0mW1JIn1KHN++Ezgc9CCdr0ozvIge6IAXA/W1lhSYgFa1qqVszY+pTBgvog4mwQu3H2JaG1zvOhQ/FwBqQ8zstUgla85DXnDFfkm5k4xpwG87EfgyDrIwo0xt994rIbHUv5J1hOG1J4KVhrCTFoCN6PBiURv9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765937017; c=relaxed/simple;
	bh=umxrCUxt7JdhKqPFzL0+FOQ55Wo/7PIYPQB70jttcuM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dcxg9gthFEjyxgbERu96IdCxnP9hQko8V/ciDPF4FbpcnTOVrDSdywFemhkT50aoN1zsHi5vkBLmRgmJYnIRR8nGmHP0ulGYQ/w8L9w3ur12Rq4RzFfiWI3XuQHa7Eb4+oU411d2GTtetySf5GYVkLdq2WhHNYVrjI/FQ33Ixws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaU5Pelt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lp2mDsqd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765937015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7Zi0lFaT8ketL7r3/3mTmx2Y/75ccXCTRMPiAb0gVA=;
	b=EaU5PeltbKqwHngVdmB4si9KSkwk/6JI+/ENlSgLOqNDtRDmdOkzwXunRLmAqNE39uhFpr
	MkLc9k66Jjwv+YYyozvOZPdQH+m2G22uIS+CuYtbFQqqytxDtqbJlVORfpt3u8UbdB2jAD
	s370cjpKXK9Q3y4hj9WHZ/4/YCXSUeg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-uXJv5vkhNqCk7mHzj_oqMQ-1; Tue, 16 Dec 2025 21:03:33 -0500
X-MC-Unique: uXJv5vkhNqCk7mHzj_oqMQ-1
X-Mimecast-MFC-AGG-ID: uXJv5vkhNqCk7mHzj_oqMQ_1765937013
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8bc4493d315so622100485a.1
        for <cgroups@vger.kernel.org>; Tue, 16 Dec 2025 18:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765937013; x=1766541813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r7Zi0lFaT8ketL7r3/3mTmx2Y/75ccXCTRMPiAb0gVA=;
        b=Lp2mDsqdAMkXr3dsiHajBCu/jvcVnc6ObpSY+JLgQb+tLxjrFZSQL3LK7hsLzrn44Z
         zq+gQjCOhglrJg47NaoR3M8xvPxfiOzJW6/YMiQmBmZ6nxlDy09MZRKHaZgzcJzpKd8S
         bp9pmjf8LUbKY3ooIOoJ62Rwb1HNByHDLIE7x2tt3dbsjL9Pw8N27t8fiJkS50Kz7K+A
         885t8K6CzcEMR49bcGOUryOsY+N4NMW6k54pnSteep7zw4BStOAZbUVzbEoWjyZwUCtl
         moZV5dMQmZCHSGZNeZpLw4KvZBUxblt5puu6D+XNMIHg61zsgX1KcQn9pN5gvxXNXpIl
         6EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765937013; x=1766541813;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7Zi0lFaT8ketL7r3/3mTmx2Y/75ccXCTRMPiAb0gVA=;
        b=i7wMDGWfi2NL6nHDrHEas/aZozIx0YqlovP+ukli2HSONlabzVAs5+GZA+emTWi1W/
         jJE2KZxQQEW8WjiPhJvWGf2uK9MD4waQ+mjGu34WIsrcGadXazi8z4SjJ6uRFmFYJmtk
         9OUtzV5rpBs5Z3Kw9FOZC/cBU4f+GN00J7YhZlqdY0JAmVndgyfjxqXdvPPSqqtWLmG0
         rTZclJdQu5cvaUysXyrAMG8Zq7SsiCHgsNTivpTbGlJhbg0tbzvN/cFPHAW/hOhiRIKr
         u0besuPEw804/8ghBhL0h/B/uskC/rXtA1/KJM5lzLfq1fUb3z676yl38K2fD33EP5yQ
         qVGA==
X-Forwarded-Encrypted: i=1; AJvYcCX0P18TAbSw2kpoX8Xwg8OWGZTXdqsgMAWwdgUrpNXsD9SoJgVh+lMARs3get2hd2IyROfEmRXe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Dv0dVyakyHvF1J8lwwpD5NwFxENZEYFtH0Qtjt4AVfT+axi2
	p4MKG4OTQ18r9NnzKe6oQDuKaxzSUvj7lAJhSq7OI26chJclF80V7CoqR4Opa9POHX8gj6II5Tq
	6yOJoV5/6V7dxJ6xGpLvzW2V0Dm59Bs8Q+yTiT/IZRxrAIwj7rzt1Pd2GJVU=
X-Gm-Gg: AY/fxX5uSZR0nodMlN2T7U8YXFzzVLSCxjUNINKN7WDentxO40isL8fEAzxfhef9Oz5
	DwAcjnWwrfpI7bPpi0jDUc20BNbIRQnvd/hyWZYOi3G5i2GDP8KLCct4HUxraSf/m1b8UX8DFKa
	M+vJ4dGj6hGqhbLNZ6GwyIvtCU2zwsn2RHLCWPXUdUamzgamY/7w/a2AuvjMegkO7SVagEQFvZj
	S9gpfNL8NodX5laHVktRAoETazUIuj2G8oOGvc2Z6lL60mkzZs0C2/RnJkCQfWqizY0ofJERM6w
	LkN04jT9Mma7S2XmM2H8ben9K12Fzl8+7bswzq5t6u8XcWaiGRPBcFB7gF5p07KGplsuZMK8lX5
	syDq4g0M+KKWtWG+c++C28kfi7+mF2/XFCzCnx6w6DlPOJzUEfb4YF2Hl
X-Received: by 2002:a05:620a:1917:b0:8b2:e924:4db7 with SMTP id af79cd13be357-8bb3a0be507mr2226270985a.40.1765937012676;
        Tue, 16 Dec 2025 18:03:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/GRjiq7fWsyYciGNqXV9akONIxhexb203orHkTFDHZ/ah/amTqjSGH2E9C1kKyBxZK/ee8A==
X-Received: by 2002:a05:620a:1917:b0:8b2:e924:4db7 with SMTP id af79cd13be357-8bb3a0be507mr2226268485a.40.1765937012297;
        Tue, 16 Dec 2025 18:03:32 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b43140sm88952526d6.6.2025.12.16.18.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 18:03:31 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <032b60c1-4a5d-44e1-be9c-05f84172a8ca@redhat.com>
Date: Tue, 16 Dec 2025 21:03:30 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: add cpuset1_online_css helper for
 v1-specific operations
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com
References: <20251216012845.2437419-1-chenridong@huaweicloud.com>
 <sowksqih3jeosuqa7cqnnwnexrgklttpjpfzdxjv2tmc7ym45r@vrmubshmlyqi>
 <a45617e5-7710-49e8-a231-511ae77b5e51@huaweicloud.com>
 <vprpzrc6g4ad4m2pwj6j5xp3do7pd7djivhgeoutp6z2qmeq22@ttgkqpew7uo4>
 <5a35692f-2800-4fd4-9c23-97d0284293df@redhat.com>
 <3785c9ca-5bdb-4ff2-9c8f-a3515ba58538@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <3785c9ca-5bdb-4ff2-9c8f-a3515ba58538@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/16/25 7:53 PM, Chen Ridong wrote:
>
> On 2025/12/16 22:58, Waiman Long wrote:
>> On 12/16/25 9:03 AM, Michal Koutný wrote:
>>> On Tue, Dec 16, 2025 at 08:13:53PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>> Regarding the lock assertions: cpuset_mutex is defined in cpuset.c and is not visible in
>>>> cpuset-v1.c. Given that cpuset v1 is deprecated, would you prefer that we add a helper to assert
>>>> cpuset_mutex is locked? Is that worth?
>>> It could be un-static'd and defined in cpuset-internal.h. (Hopefully, we
>>> should not end up with random callers of the helper but it's IMO worth
>>> it for docs and greater safety.)
>> I would suggest defining a "assert_cpuset_lock_held(void)" helper function and put the declaration
>> in include/linux/cpuset.h together with cpuset_lock/unlock() to complete the full set. This will
>> allow other kernel subsystems to acquire the cpuset_mutex and assert that the mutex was held.
> Considering potential use by other subsystems, this is worthwhile. I will add the helper.
>
>>>> Should we guard with !cpuset_v2() or !is_in_v2mode()?
>>>>
>>>> In cgroup v1, if the cpuset is operating in v2 mode, are these flags still valid?
>>> I have no experience with this transitional option so that made me look
>>> at the docs and there we specify it only affects behaviors of CPU masks,
>>> not the extra flags. So I wanted to suggest !cpuset_v2(), correct?
>> The "cpuset_v2_mode" mount flag is used for making the behavior of cpuset.{cpus,mems}.effective in
>> v1 behave like in v2. It has no effect on other v1 specific control files. So cpuset1_online_css()
>> should only be called if "!cpuset_v2()".
>>
> If cpuset1_online_css() is only called under the condition !cpuset_v2(), a compile-time option might
> suffice? When CONFIG_CPUSETS_V1=n, cpuset1_online_css could be defined as an empty inline function.

cpuset_v2() includes "!IS_ENABLED(CONFIG_CPUSETS_V1)", so the compiler 
should compile out the call to cpuset1_online_css() if CONFIG_CPUSETS_V1 
isn't defined. If you want to make cpuset1_online_css() conditional on 
CONFIG_CPUSETS_V1, I am fine with that too.

Cheers,
Longman



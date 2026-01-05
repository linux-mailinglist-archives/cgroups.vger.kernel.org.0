Return-Path: <cgroups+bounces-12900-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9EACF1C7C
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 05:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CE36302AFBF
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 03:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1116320A20;
	Mon,  5 Jan 2026 03:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRoySTSx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U38+v2s/"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C1331AA95
	for <cgroups@vger.kernel.org>; Mon,  5 Jan 2026 03:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767585587; cv=none; b=kdABhOsmmUmmhOCGODhetRzg7WAKqruGwpiqUI0Tg9iMjPUxQE3r73fHw8V5HtguR71bojPYCbnnPyfkYGyKETVWbWu8hkzuHTOtQrLVZqCqyADxI+m9thHhXxaeqEgkZR5y4RdYbeQKxrq6NEg5TNkngneFzzUpCFNMCwOxwFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767585587; c=relaxed/simple;
	bh=i14d6bDqTphWg0tcgZQtxI4oehvWUN5DxtfPLeQ9Xek=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AbpsE2dXXjScaqdQoL6/FMuyTE2fpTdHtkYY+fTmHZ01CqXnhyb9y1ICuU4liCIA2V6pnVOYYYHDEik9tvLU0s9YLBX+2p4zeExPzkkD89tX064JhFM9NWvjeJES822GDtewN4OBm9WPO1kvlCv0qmvy6yRXI4ZrVmcaQuJaRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRoySTSx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U38+v2s/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767585584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DcstfgGe6NPr6oxFWbPA0cQo82UVim7d++fhOcCLZtk=;
	b=iRoySTSxvfD+UgnTwVOsw3lmUTXu2Sh9ALU7/4mUz1FWEtHRaH0mx3qNOADAsOVewcIpnQ
	jPN9rVzej1hGttvYSMEC1TNNQTM2fUhkRcFJLsb/9LyRgTjS4p7rXT1Nzlj1Qcvq85PH23
	atNLtnuZ1AtSLbN8pqm2F9AeZqo60zo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-5yxCkF30MQOuu-jX916_uw-1; Sun, 04 Jan 2026 22:59:41 -0500
X-MC-Unique: 5yxCkF30MQOuu-jX916_uw-1
X-Mimecast-MFC-AGG-ID: 5yxCkF30MQOuu-jX916_uw_1767585581
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f1dea13d34so348149891cf.1
        for <cgroups@vger.kernel.org>; Sun, 04 Jan 2026 19:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767585581; x=1768190381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DcstfgGe6NPr6oxFWbPA0cQo82UVim7d++fhOcCLZtk=;
        b=U38+v2s//8MK9WHZltDfz1riArl6GWWIUp399Ay3PGC00g+h1Msgy55419Ni2N+qGm
         yuq0vyNrRTF9kbkD3zMlYVbNzbNs26fhVXcxMznuPyCmIjdC4PdGPqbWXkvYSYUxswUj
         NOqbYPTzZmkzKCLpKO+tTGdMKBZ0iQIXupptywrOl97whjOR3uOyCK6CCjCekU45ycXm
         7oqwIK+W1kIYuji0zM6TzkIS6c4+SGXrJt/B5J1CL6zToOxkcnjhiZGjttn3WrR6NwLH
         MbqC5zQmCgmwx1WVeipYjnbfY+/pDuyCUfx2pn2EAkDW/6WexRPj9y8UH+iI4JVYfEp9
         IK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767585581; x=1768190381;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcstfgGe6NPr6oxFWbPA0cQo82UVim7d++fhOcCLZtk=;
        b=pSW2szJ/kG6bE6rWAQ9lufH8Ww0XufgUlbgI8pfuNk8FtkWUox6fj9RCyc0HDHhGTq
         d4C/2LhJiWkFM5ogiOA0nmgSvlpuVvFjhRBqFuW08JKewrjkDA2mERvTXWBtD68EtL/8
         4/ImezuMoalKt+i1mmWZ2d4wu9Nwy7bgfHfzwp779YX+1SM4ZX6wFdyvFJ1zLkJCvfvE
         WjnnMfpgwwbqmpFNQPMaEyRrlOFdqIwe2MUmvtCvl4AfBKYsQCZAdoAkcBQCx/fj8v1q
         pWWCuAGN3TeXbS3ZSeWFRo8OPzEx+VbZR/oG5A0SD/5vVys1VVgaWykv0hKOLwWhrilr
         LD9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaXXHwgm+Ndj6Rl4kr1FJYQ2hZRUBRyMndTg5++/gBmT0Tu8KY7lDeTXYugRtM+9B/NXkmUT+b@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhxa4FESiYLrrua7TYuLnQnH5ry5T+t5RwCY/xErC43p+oIE7Z
	sjX5sNLzzttjxm7iDbxII4w+Z9fcVtDOpcT3QRrgmj/iMIgJoxJ1eoB9WTAjlfpyt9nQtOpyIua
	PFsVbanN9v1W3k/WcmGpcj3Q6+b7Sr+E3I/JSV1mPsnReCUy8ZaJx+3hQGwE=
X-Gm-Gg: AY/fxX6Zcndm5NTxTw/Asqj8235o2g6A0fvEq64lfuAfp2xla86mpGSVKoHdr2fIeZd
	kSNtcQ5VEEswAB+fApA9AAXWUgg8qoJwCQ5fuq8h/FFgmdcuz1TrQIP+zqPRlkzheB+NRDhURMO
	elG4enGzUhj8K+cmar7Uz2xFsjqZm3BvKnhYxp6t4qwcYslACBb+Rzmjg9n1fOtLZSCrg5ZI7xF
	UIuQSlqTRA2Ky7BM53sPrHQoPcZ1nnaXzXm63jgBPuRDkZ0RoHwhmnRlUC7xDoW9ADZgT8qIeDq
	dGllzdgdUdbwAvc/PaxtTnA6/wjfvHjk6HY4QnZVHvP5rtF5e3AaHOpwlRB62lmuCzGsChH+TGR
	2chnP/0CBvY5dmxmxX0788HD4yVLgRqOwnv/olwrVEAY53zSKu631F4Rd
X-Received: by 2002:ac8:6f0f:0:b0:4f0:2d78:b955 with SMTP id d75a77b69052e-4f4abd797f1mr748971241cf.53.1767585581002;
        Sun, 04 Jan 2026 19:59:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+NcyGeeiQSa4IIGkUpR94ZHm/A+yiFKrXcCzGbDEBp1p4GQ6FxU+mKwmroOKv1AZgBlIG4w==
X-Received: by 2002:ac8:6f0f:0:b0:4f0:2d78:b955 with SMTP id d75a77b69052e-4f4abd797f1mr748971071cf.53.1767585580638;
        Sun, 04 Jan 2026 19:59:40 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac530f0dsm339626871cf.3.2026.01.04.19.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 19:59:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <85f4bca2-e355-49ce-81e9-3b8080082545@redhat.com>
Date: Sun, 4 Jan 2026 22:59:38 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 3/4] cgroup/cpuset: Don't fail
 cpuset.cpus change in v2
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-4-longman@redhat.com>
 <efdcd90c-95ed-4cfc-af9a-3dc0e8f0a488@huaweicloud.com>
 <6eedf67b-3538-4fd1-903b-b7d8db4ff43d@redhat.com>
 <7a3ec392-2e86-4693-aa9f-1e668a668b9c@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <7a3ec392-2e86-4693-aa9f-1e668a668b9c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/26 8:35 PM, Chen Ridong wrote:
>
> On 2026/1/5 5:48, Waiman Long wrote:
>> On 1/4/26 2:09 AM, Chen Ridong wrote:
>>> On 2026/1/2 3:15, Waiman Long wrote:
>>>> Commit fe8cd2736e75 ("cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE
>>>> until valid partition") introduced a new check to disallow the setting
>>>> of a new cpuset.cpus.exclusive value that is a superset of a sibling's
>>>> cpuset.cpus value so that there will at least be one CPU left in the
>>>> sibling in case the cpuset becomes a valid partition root. This new
>>>> check does have the side effect of failing a cpuset.cpus change that
>>>> make it a subset of a sibling's cpuset.cpus.exclusive value.
>>>>
>>>> With v2, users are supposed to be allowed to set whatever value they
>>>> want in cpuset.cpus without failure. To maintain this rule, the check
>>>> is now restricted to only when cpuset.cpus.exclusive is being changed
>>>> not when cpuset.cpus is changed.
>>>>
>>> Hi, Longman,
>>>
>>> You've emphasized that modifying cpuset.cpus should never fail. While I haven't found this
>>> explicitly documented. Should we add it?
>>>
>>> More importantly, does this mean the "never fail" rule has higher priority than the exclusive CPU
>>> constraints? This seems to be the underlying assumption in this patch.
>> Before the introduction of cpuset partition, writing to cpuset.cpus will only fail if the cpu list
>> is invalid like containing CPUs outside of the valid cpu range. What I mean by "never-fail" is that
>> if the cpu list is valid, the write action should not fail. The rule is not explicitly stated in the
>> documentation, but it is a pre-existing behavior which we should try to keep to avoid breaking
>> existing applications.
>>
> There are two conditions that can cause a cpuset.cpus write operation to fail: ENOSPC (No space left
> on device) and EBUSY.
>
> I just want to ensure the behavior aligns with our design intent.
>
> Consider this example:
>
> # cd /sys/fs/cgroup/
> # mkdir test
> # echo 1 > test/cpuset.cpus
> # echo $$ > test/cgroup.procs
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> # echo > test/cpuset.cpus
> -bash: echo: write error: No space left on device
>
> In cgroups v2, if the test cgroup becomes empty, it could inherit the parent's effective CPUs. My
> question is: Should we still fail to clear cpuset.cpus (returning an error) when the cgroup is
> populated?

Good catch. This error is for v1. It shouldn't apply for v2. Yes, I 
think we should fix that for v2.

Cheers,
Longman



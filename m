Return-Path: <cgroups+bounces-5579-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D86509CF33C
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 18:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5241F23DE7
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 17:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E07165F1E;
	Fri, 15 Nov 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbADT9PW"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A01D435C
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692845; cv=none; b=dTM5S0xJ788DjtIRWNkvphQFbXqUswURPtN86xzsYFSPDJVM4lrQj41IoL5qFiTVKADZpxW2SYa7RPuA1stMkWQpZ3NvCyI2SUu3/AMhpQy6b/wQOZ8BGHiLM0FAj4hPJeFkEIfcZCvedqcgdwaKOlJy/+L7IDy74+SvUoBl0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692845; c=relaxed/simple;
	bh=M8pwNvD9B/yuT7abi8lk/RZ9h5awT0wqPUfRZxaGERk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=B8L1KwwajOvP3qRyv1+fi4fDT5FJc6aTF59rtQaM1vSi5oFjti+Rr6VxgySWF18gl6hp50AOkue00WlpVxN33L36j1Kf4wUqB7qG6fdRZl7Rftw9k9JoG4LoySPNDCScrW8GNIQHTmngeeBDw/91lTlNfzIkQy2sRvmd3eKBH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbADT9PW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731692843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m9Ta/CtP5pjWn4bPuxT4gm+0qsnrJMxo3ASMZDuEf1k=;
	b=VbADT9PWk6VF02MOvhNueIt6V3dPVurHAl3UV5V8sqmn4OtP/Y4WCoDSOovdwpjmbrZy5f
	lTTqofqQjSN1M08ZB4lw33x4H02pQHnADFpP4fQxMsGLuYsONQUWb3EtnQGbt34BCGCopg
	zfR6+9/snaCmmV2/1muosEK/w5ACBdE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-jir7CPodPRe707Ivl28OZA-1; Fri, 15 Nov 2024 12:47:21 -0500
X-MC-Unique: jir7CPodPRe707Ivl28OZA-1
X-Mimecast-MFC-AGG-ID: jir7CPodPRe707Ivl28OZA
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-71a3da16d58so1926544a34.3
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 09:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731692840; x=1732297640;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9Ta/CtP5pjWn4bPuxT4gm+0qsnrJMxo3ASMZDuEf1k=;
        b=PG+issuRnrRq13YfVZR4IhCJyq5HFbeMqYpiEmOw7GtUj3yAyogGK+9e+r9npPv3l8
         +aBpRBlRqcs3o2WH6yc7/EZC2MJ6h8ELPXcQ92yz5RWKJ/uIdsWgtlv/GyxC7i7R9BDn
         ek9EkryBQqTjSWzXu1SZt6SWzBeZN7gZfI0IDreaUsCbmLxrC5Qu1jsF0dqeLHLVesE4
         NCBjOv06rnpYaWYMN7yRHjZMBRtDKer99Fmk3pCBVZ/3NUnCISHM1QqtBWrvIB8w1J4g
         LD13OhK2Lu4Yq2Y888ilMa9uJOTHXLQPfDBkNmbLRLp3nkWo/7Fm2gn1hk4/sx6UaUjR
         AmRg==
X-Forwarded-Encrypted: i=1; AJvYcCWqyDGhxi6qgK4PPLgxguS7bBLjyxQNuIiX+8TNx+fl7huheL7OvnlVlsxwPSgGSdlxf1PMpkTG@vger.kernel.org
X-Gm-Message-State: AOJu0YxhFaLAKQJAHSUEnZhy2bvFp3KHXOWDmIiXsMJNM1Xo7nKvoUiP
	QpOQ7o9sSGZDawg/LcmCEWVknZMUUeJoI82r+3jcqSP7RYiXUXvigHU7QkdBIsZlrKJFeQP6Irb
	M/RHhdVzeKDnZVtXqxl9o+sDfbcfbuiX4Pd3bfkFMFE8B7WJngTHL13GlR7Y5L+Y=
X-Received: by 2002:a05:6359:7996:b0:1aa:c492:1d34 with SMTP id e5c5f4694b2df-1c6cd297293mr274638655d.23.1731692840153;
        Fri, 15 Nov 2024 09:47:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbQZYj5r/0Y4qwHog4+zSYSxfUMed5vkN6uvv9z59ZF8VnJ2WLqn2tQa49TSKP40O4bTNprA==
X-Received: by 2002:a05:6359:7996:b0:1aa:c492:1d34 with SMTP id e5c5f4694b2df-1c6cd297293mr274635855d.23.1731692839820;
        Fri, 15 Nov 2024 09:47:19 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee7d207csm19972696d6.70.2024.11.15.09.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 09:47:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <bfbedc6a-9f04-472f-afe9-828efe0387e6@redhat.com>
Date: Fri, 15 Nov 2024 12:47:18 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Additional issue with cpuset isolated partitions?
To: Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <Zzd3G67_UwBUJaRt@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <Zzd3G67_UwBUJaRt@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/24 11:30 AM, Juri Lelli wrote:
> Hello,
>
> While working on the recent cpuset/deadline fixes [1], I encountered
> what looks like an issue to me. What I'm doing is (based on one of the
> tests of test_cpuset_prs.sh):
>
> # echo Y >/sys/kernel/debug/sched/verbose
> # echo +cpuset >cgroup/cgroup.subtree_control
> # mkdir cgroup/A1
> # echo 0-3 >cgroup/A1/cpuset.cpus
> # echo +cpuset >cgroup/A1/cgroup.subtree_control
> # mkdir cgroup/A1/A2
> # echo 1-3 >cgroup/A1/A2/cpuset.cpus
> # echo +cpuset >cgroup/A1/A2/cgroup.subtree_control
> # mkdir cgroup/A1/A2/A3
> # echo 2-3 >cgroup/A1/A2/A3/cpuset.cpus
> # echo 2-3 >cgroup/A1/cpuset.cpus.exclusive
> # echo 2-3 >cgroup/A1/A2/cpuset.cpus.exclusive
> # echo 2-3 >cgroup/A1/A2/A3/cpuset.cpus.exclusive
> # echo isolated >cgroup/A1/A2/A3/cpuset.cpus.partition
>
> and with this, on my 8 CPUs system, I correctly get a root domain for
> 0-1,4-7 and 2,3 are left isolated (attached to default root domain).
>
> I now put the shell into the A1/A2/A3 cpuset
>
> # echo $$ >cgroup/A1/A2/A3/cgroup.procs
>
> and hotplug CPU 2,3
>
> # echo 0 >/sys/devices/system/cpu/cpu2/online
> # echo 0 >/sys/devices/system/cpu/cpu3/online
>
> guess the shell is moved to the non-isolated domain. So far so good
> then, only that if I turn CPUs 2,3 back on they are attached to the root
> domain containing the non-isolated cpus
A valid partition must have CPUs associated with it. If no CPU is 
available, it becomes invalid and fall back to use the CPUs from the 
parent cgroup.
>
> # echo 1 >/sys/devices/system/cpu/cpu2/online
> ...
> [  990.133593] root domain span: 0-2,4-7
> [  990.134480] rd 0-2,4-7
>
> # echo 1 >/sys/devices/system/cpu/cpu3/online
> ...
> [ 1082.858992] root domain span: 0-7
> [ 1082.859530] rd 0-7
>
> And now the A1/A2/A3 partition is not valid anymore
>
> # cat cgroup/A1/A2/A3/cpuset.cpus.partition
> isolated invalid (Invalid cpu list in cpuset.cpus.exclusive)
>
> Is this expected? It looks like one need to put at least one process in
> the partition before hotplugging its cpus for the above to reproduce
> (hotpluging w/o processes involved leaves CPUs 2,3 in the default domain
> and isolated).

Once a partition becomes invalid, there is no self recovery if the CPUs 
become online again. Users have to explicitly re-enable it. It is really 
a very rare case and so we don't spend effort to do that.

If only one of 2 CPUs are offline and then online again, the full 2-CPU 
isolated partition can be recovered.

Please let me know if you have further question.

Cheers,
Longman



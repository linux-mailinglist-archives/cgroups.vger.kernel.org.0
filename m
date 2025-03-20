Return-Path: <cgroups+bounces-7205-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751AAA6AD53
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 19:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D053AB38E
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389D227B9C;
	Thu, 20 Mar 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYIzxQ8x"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717201E8339
	for <cgroups@vger.kernel.org>; Thu, 20 Mar 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496728; cv=none; b=LMU9QzPJfSkjvyYXl0d+xHqy4htAzj58vDmzxhr5wk27pWuBMHDk9m9q6A5U1GyEGvns698I6RBeV4je0J7AzfN71R0z+64D9nWRBHLQ/q7lCzJ4JEwN5ZFT+o3L615GE3EGD1/zY2IMHQ/H3JKpk+JVcyKxJk1ImnQPdUq0aqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496728; c=relaxed/simple;
	bh=X2OpYnKwhgcCKv5ixMN2zzlAolO88TSzl2cNHMuaauQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=mDRFlOuOGcfOyDizpwbgb67da8AV4p+LUArPiAE/ojIfr/GLfEjX92V+NWM9Lxt7RmlDO6YuXU2gAzLTm5mlUWygTCjBVFgc04LBiBhT0sts+ZOrNFD/3Y4z2DSDvH+/QiTGXVDiSQV3MPcxWrhqrp2bH+i3DZaDwqHdvu6zN08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EYIzxQ8x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742496725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1k55B5xhcakMKOiOpFLhvz9gfJXnsz7lGEA/a0h9Z4=;
	b=EYIzxQ8xZsZZM0xPUMTIKaD1G3o4Abq3UrCqbnUsk8hTuWW1NnckecsJaUfHHyQoijKy3a
	ZcQUCrbtZMTPz47pMCdhRqnxp82vMj0MwsYwx2P3DPeImEOSCpi82uF6y8GiezBxCKHgat
	fD+YKXG96kXVVnRklsbc9Jgf7RvT8eM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-nn0-0x47O6yHqqlpEmR8FQ-1; Thu, 20 Mar 2025 14:52:03 -0400
X-MC-Unique: nn0-0x47O6yHqqlpEmR8FQ-1
X-Mimecast-MFC-AGG-ID: nn0-0x47O6yHqqlpEmR8FQ_1742496723
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e916df0d5dso18681996d6.2
        for <cgroups@vger.kernel.org>; Thu, 20 Mar 2025 11:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496723; x=1743101523;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1k55B5xhcakMKOiOpFLhvz9gfJXnsz7lGEA/a0h9Z4=;
        b=rJEh8nqNRGO+1C8LfzNUYGr/qLTZp5AuXFyLtIus4MPaMTEj2h/q37xCIa18BglWWk
         zow4FdzkYwTmLSEV03TKOzHmgpN8yRGxSZXa8Xar17D5AmvVqgSqbH0TAN2AetJ1pqvy
         /HLI0TnhbgNcLuzB9uo38MgHuRpijMgqMrfUdkIBak9ZF6e+zWJKAph/xnk/+8T1FGyx
         LUZ2s8RpaXU2BGeXulnrpxIfLaElzHk7SKh74EttadAp9UYDpDFtwZY/s//bfzZ/VuVd
         I3gJAT4YpIYurG9PdibcSXD7nEtGRhFxJgVmwgS13TjWZZgUHCibk/dWJrjb2gvTIFSN
         y3UA==
X-Forwarded-Encrypted: i=1; AJvYcCUrwznCYCGIwNpQ1m5GtGQOXVydBjlXJWi05QH5AdH0FEg3sHMXOcA4EDGBhTWSX4e0l0W7clNv@vger.kernel.org
X-Gm-Message-State: AOJu0YzizFKBg3Elo1dMavwEn+SXV7Ekygcih67xLPJKbkjOMvs6F+7K
	0OxIzlHnsLKjSfx1RRXXa9bpb8Bf+MrtsfZ/VbOxt+Ms8Q+lHm97b8wKb8uAN+CiQwvi51Z0QMF
	LDtsHa6YxC9nZMtijcIHASR69Rqz474iqUps4qP3fq4E3kq2a9BVpsdk=
X-Gm-Gg: ASbGncvfl7uESmArXrFO2LF0zKJNyL7eA1n1n8BKCTYEBeUkjIrcZ/EjPOyXdVHr/X+
	5w5qedqxGDu4+QbqFPLv4q5mNfWg8wM4TGSSUdnegpD/h76ri/WZyfTPIAODZfuSP9DGEbezBmb
	tFNVs8oWXApwMApLZg+TLMZFWBwOC0opYP+T0oe0yp3A+zIE6tfvMXJNc3OW+9gwwurZIkiLAtM
	VMfnaioFKvtav6mofmy34yUcj5xEDNNZioU276O035d7cESsKMHUoc9GNDo2wc4m17T2Lrq5pZ4
	veUcNwbY9b3Hn6MIPkt4Gf+VRwhq4V47ExKjEgmBoFlYFPnOpgW/FUI9IRzv3w==
X-Received: by 2002:ad4:5cae:0:b0:6e6:6599:edf6 with SMTP id 6a1803df08f44-6eb3f32bbbcmr6229886d6.34.1742496723152;
        Thu, 20 Mar 2025 11:52:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvh77Q26yZkIaOjE9rN2gWPWPTOxr8NTa7GBcQHCf5dZw1w9tTeKP1KQzRIFczUKcY7bIj4A==
X-Received: by 2002:ad4:5cae:0:b0:6e6:6599:edf6 with SMTP id 6a1803df08f44-6eb3f32bbbcmr6229676d6.34.1742496722804;
        Thu, 20 Mar 2025 11:52:02 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef251c7sm1578376d6.49.2025.03.20.11.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 11:52:02 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <36fab78e-9ac3-48ce-b23e-90edc4523603@redhat.com>
Date: Thu, 20 Mar 2025 14:52:01 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG in LTS 5.15.x cpusets with tasks launched by newer systemd
To: James Thomas <james.thomas@codethink.co.uk>
References: <c5c7fe20-61a6-4228-876e-055ee9ab43b6@codethink.co.uk>
Content-Language: en-US
Cc: stable <stable@vger.kernel.org>, cgroups@vger.kernel.org
In-Reply-To: <c5c7fe20-61a6-4228-876e-055ee9ab43b6@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/20/25 6:07 AM, James Thomas wrote:
> Hello all,
>
> I encountered an issue with the CPU affinity of tasks launched by systemd in a
> slice, after updating from systemd 254 to by systemd >= 256, on the LTS 5.15.x
> branch (tested on v5.15.179).
>
> Despite the slice file stipulating AllowedCPUS=2 (and confirming this was set in
> /sys/fs/cgroup/test.slice/cpuset.cpus) tasks launched in the slice would have
> the CPU affinity of the system.slice (i.e all by default) rather than 2.
>
> To reproduce:
>
> * Check kernel version and systemd version (I used a debian testing image for
> testing)
>
> ```
> # uname -r
> 5.15.179
> # systemctl --version
> systemd 257 (257.4-3)
> ...
> ```
>
> * Create a test.slice with AllowedCPUS=2
>
> ```
> # cat <<EOF > /usr/lib/systemd/system/test.slice
> [Unit]
> Description=Test slice
> Before=slices.target
> [Slice]
> AllowedCPUs=2
> [Install]
> WantedBy=slices.target
> EOF
> # systemctl daemon-reload && systemctl start test.slice
> ```
>
> * Confirm cpuset
>
> ```
> # cat /sys/fs/cgroup/test.slice/cpuset.cpus
> 2
> ```
>
> * Launch task in slice
>
> ```
> # systemd-run --slice test.slice yes
> Running as unit: run-r9187b97c6958498aad5bba213289ac56.service; invocation ID:
> f470f74047ac43b7a60861d03a7ef6f9
> # cat
> /sys/fs/cgroup/test.slice/run-r9187b97c6958498aad5bba213289ac56.service/cgroup.procs
>
> 317
> ```
>
> # Check affinity
>
> ```
> # taskset -pc 317
> pid 317's current affinity list: 0-7
> ```
>
> This issue is fixed by applying upstream commits:
>
> 18f9a4d47527772515ad6cbdac796422566e6440
> cgroup/cpuset: Skip spread flags update on v2
> and
> 42a11bf5c5436e91b040aeb04063be1710bb9f9c
> cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly
>
> With these applied:
>
> ```
> # systemd-run --slice test.slice yes
> Running as unit: run-r442c444559ff49f48c6c2b8325b3b500.service; invocation ID:
> 5211167267154e9292cb6b854585cb91
> # cat /sys/fs/cgroup/test.slice/run-r442c444559ff49f48c6c2b8325b3b500.service
> 291
> # taskset -pc 291
> pid 291's current affinity list: 2
> ```
>
> Perhaps these are a good candidate for backport onto the 5.15 LTS branch?
>
> Thanks
> James
>
You should also send this email to stable@vger.kernel.org for 
consideration into the 5.15 LTS branch.

Cheers,
Longman




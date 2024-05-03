Return-Path: <cgroups+bounces-2765-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2968BACEB
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 14:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB951F22B64
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31B4153579;
	Fri,  3 May 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd4GZDPD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA68495;
	Fri,  3 May 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741141; cv=none; b=IpZN8Qpmew+9kqu6dtCEbDf7JUg3wkgMbUq2ynwGkPrEd5PNYhuNExQ3T/GMWldw02SkObWaTbOn48UBoVQkaA94kz+kaq3fR/x6ckErpJpWcitLRIlBkUrJfbEntXgkdZq0p8j/Qvm9/a28CkqYhudw5+XFjO+brcN3As5AYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741141; c=relaxed/simple;
	bh=Uj1cwNv+UCHnN7nqmvGy0hMOZ7WAjQ3MkfqneQLAISk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbCrQquou5XDqY0+jKDW116rYPsHpTzjHt4pJ3eGT5iUFLxqBYTZXF0jvFPmp7oW7H28a0FqyOflZbxw8cQvREtMfGuYrUZbLGZWZwP3dPEPV8iPDNiqQxNHuQEeZmLvazR63fb0F9xhAWG3VGJgwdEbPUw3zOcaLpgrWluE0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd4GZDPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF816C4AF14;
	Fri,  3 May 2024 12:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714741141;
	bh=Uj1cwNv+UCHnN7nqmvGy0hMOZ7WAjQ3MkfqneQLAISk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hd4GZDPDvredSG5fm6vJ52DUbvyC4aJvst2KyRAfrpZuByknfcR9mjqmxATyx7fsg
	 c2FLGnPpsCc1VT3sD3B4wMOB4NKbSiJBGAooFYWR1wgHYwEcXbaTNaM6AquolWuYDY
	 jfSZeahdvQECMks1g2M4YvD7POxUpzDWyoiL6yDzQXLdBOIOzJ8j/Dw2yXss0z5PaC
	 XlTOsuUHWca/Jp3SR7v1vbu/mtjtI4iTLziqoOpZ+mJI2SBH+opZ3hjMpqOBWgZ4O4
	 4zifmO9dDEBFkMxv471+w0AVTp33PFpH55YfgiGwE6q8/kbWdFSoNd3tUyfjWXToKO
	 uL1EqL/JYv3aA==
Message-ID: <c5a79618-8c64-4e7b-aeed-69aeecb1590d@kernel.org>
Date: Fri, 3 May 2024 14:58:56 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Waiman Long <longman@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, cgroups@vger.kernel.org, yosryahmed@google.com,
 netdev@vger.kernel.org, linux-mm@kvack.org, kernel-team@cloudflare.com,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
 <30d64e25-561a-41c6-ab95-f0820248e9b6@redhat.com>
 <4a680b80-b296-4466-895a-13239b982c85@kernel.org>
 <4m3x4rtztwxctwlq2pdorgbv2hblylnuc2haz7ni4ti52n57xi@utxkr5ripqp2>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <4m3x4rtztwxctwlq2pdorgbv2hblylnuc2haz7ni4ti52n57xi@utxkr5ripqp2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/05/2024 21.44, Shakeel Butt wrote:
> On Wed, May 01, 2024 at 07:22:26PM +0200, Jesper Dangaard Brouer wrote:
>>
> [...]
>>
>> More data, the histogram of time spend under the lock have some strange
>> variation issues with a group in 4ms to 65ms area. Investigating what
>> can be causeing this... which next step depend in these tracepoints.
>>
>> @lock_cnt: 759146
>>
>> @locked_ns:
>> [1K, 2K)             499 |      |
>> [2K, 4K)          206928
>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [4K, 8K)          147904 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
>> [8K, 16K)          64453 |@@@@@@@@@@@@@@@@      |
>> [16K, 32K)        135467 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
>> [32K, 64K)         75943 |@@@@@@@@@@@@@@@@@@@      |
>> [64K, 128K)        38359 |@@@@@@@@@      |
>> [128K, 256K)       46597 |@@@@@@@@@@@      |
>> [256K, 512K)       32466 |@@@@@@@@      |
>> [512K, 1M)          3945 |      |
>> [1M, 2M)             642 |      |
>> [2M, 4M)             750 |      |
>> [4M, 8M)            1932 |      |
>> [8M, 16M)           2114 |      |
>> [16M, 32M)          1039 |      |
>> [32M, 64M)           108 |      |
>>
> 
> Am I understanding correctly that 1K is 1 microsecond and 1M is 1
> millisecond? 

Correct.

> Is it possible to further divide this table into update
> side and flush side?
>

This is *only* flush side.

You question indicate, that we are talking past each-other ;-)

Measurements above is with (recently) accepted tracepoints (e.g. not the
proposed tracepoints in this patch).  I'm arguing with existing
tracepoint that I'm seeing this data, and arguing I need per-CPU
tracepoints to dig deeper into this (as proposed in this patch).

The "update side" can only be measured once we apply this patch.

This morning I got 6 prod machines booted with new kernels, that contain 
this proposed per-CPU lock tracepoint patch.  And 3 of these machines 
have the Mutex lock change also.  No data to share yet...

--Jesper


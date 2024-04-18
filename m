Return-Path: <cgroups+bounces-2579-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92668A9488
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 10:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A741F22BC4
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE8877F2D;
	Thu, 18 Apr 2024 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbNnVMCs"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EF5762E5;
	Thu, 18 Apr 2024 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427221; cv=none; b=JNnGOzqHuzxJ1R1tVW0WiXEFqh4B2mxfoz4NLm07HwRkCVnIJUi5nq/u0ny21+HhacMm9EK4S3h+nqIxfbEzTHjfC5BxiXIW9I2Q2Dg04LFHL+f3km4JZ2YNWaiJIkrzlOOQZx1UinxxmGzV+crgW05jNZE0z2vlX/Pb3qhYEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427221; c=relaxed/simple;
	bh=8xkMYyuEcKoA6xltCA5FHMbWSOH1kFJ6bzMXvN0SpMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNDUHBDPEAilRWh276aOOC4QADBr9fOqHJJSrL+CKpoUI/LaXaBKGySkVcBLSIMeRg5p1i4tCMraTIgzJu4mT+M+farwVV5uuMQfPBcVKwbZTrc9jPgNrNoHZekCVYo78AJlSw8oVje6fDLE5HqwOVR490JcdJVLtDX/RsREoGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbNnVMCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF511C113CE;
	Thu, 18 Apr 2024 08:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713427221;
	bh=8xkMYyuEcKoA6xltCA5FHMbWSOH1kFJ6bzMXvN0SpMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gbNnVMCs3OpZ7tw3N/dPN0SJ6ZdFxArs40SVqZA5Ck30OuzATWr6xJPV4JA3o4Yr1
	 b1Wcy7Nd/n4ZsLB/XDkxkqHZE2hU6cfwI2oquZcJEnYExFg4JHxetExSmOPZS0gc3S
	 hOxVkGla6AERdW7iJxLvvHcNwIUKVXX3kZJ//Bvugn/wv6J4By7WhNBrZLzp8O1jrZ
	 rW6HXz2lIB9WdNjkGOhNS2Kcb1MGluHl5pThVJ8QIiXJexT6mkhFytklyPkdimV+iG
	 R07jRsGzXA3zgtZLW6yz+cB+5YfJPI1/mAitJZTjpGjQSAdBouZwbYfkrDmrHpzeR2
	 YzC017NummtaA==
Message-ID: <2f08b2c8-a931-4fc9-85c1-e63b49dbfebc@kernel.org>
Date: Thu, 18 Apr 2024 10:00:17 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] cgroup/rstat: add cgroup_rstat_lock helpers and
 tracepoints
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org,
 yosryahmed@google.com, longman@redhat.com, netdev@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev,
 kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328988660.3930751.17537768209042139758.stgit@firesoul>
 <Zh7vVPp-Rj5hB6eN@slm.duckdns.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <Zh7vVPp-Rj5hB6eN@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 16/04/2024 23.36, Tejun Heo wrote:
> On Tue, Apr 16, 2024 at 07:51:26PM +0200, Jesper Dangaard Brouer wrote:
>> This commit enhances the ability to troubleshoot the global
>> cgroup_rstat_lock by introducing wrapper helper functions for the lock
>> along with associated tracepoints.
> 
> Applied to cgroup/for-6.10.
> 

Thanks for applying the tracepoint patch. I've backported this to our 
main production kernels v6.6 LTS (with before mentioned upstream cgroup 
work from Yosry and Longman). I have it running in production on two 
machines this morning.  Doing manual bpftrace script inspection now, but 
plan is monitor this continuously (ebpf_exporter[1]) and even have 
alerts on excessive wait time on contention.

It makes sense to delay applying the next two patches, until we have 
some production experiments with those two patches, and I have fleet 
monitoring in place.  I'm be offline next week (on dive trip), so I'll 
resume work on this 29 April, before I start doing prod experiments.

--Jesper
[1] https://github.com/cloudflare/ebpf_exporter


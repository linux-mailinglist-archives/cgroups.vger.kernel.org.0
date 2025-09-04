Return-Path: <cgroups+bounces-9693-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292AB43050
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 05:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386DC1890E02
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 03:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8321E520D;
	Thu,  4 Sep 2025 03:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CdzWmESk"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8414139D;
	Thu,  4 Sep 2025 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756955739; cv=none; b=cBnY2AejTdKKkyneR3N4rNAnlrn8lJnCXenfwByXbpWxBmDOlIWQVRL9uMIvB1dCqdNwvo03WFoA8lzLHanT6myU+IStNGbchn4OScFi+pfxJz2ifPrvY9zn2HYKWYf+JhY6Y1/oA1Jj3SJVN88LcHVquAv83OW2tqW52ycg7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756955739; c=relaxed/simple;
	bh=LgXZSmAOF0pdsVXKJTcNcin49JI1ZYybuRbxyld9wRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKV86i9oqmS1t+uJ/xR3HgHALnn6IPQtdHJql+sJXCoHpAK84QVAGEO1xLB5qESMmxop68zSzLCYV10Vpy9f90MWgyGo02oNJ1tIikNHsFqxywL7+CI720/NGUhquKHXKUIu0ogzWy2F0p8X1FxMpBaD8tc297haby5FtyEi4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CdzWmESk; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756955727; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LgXZSmAOF0pdsVXKJTcNcin49JI1ZYybuRbxyld9wRA=;
	b=CdzWmESkhROPgq2usz+47yQw+Kb0i4A7u+GMTIwlPn4MXCmIDRo2/F+z22xGX8EmlKF2xUk0e1glWcNGmV8DVWy6ag80emmKqG+MBjHUAX+sH+x/TfqpDjLmeq53y/zIUiG5MaHnfDuvGSytgti06LGGSzzbJJkQ2MlPJQUw1nw=
Received: from 30.221.148.63(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0WnDwRFx_1756955726 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 11:15:27 +0800
Message-ID: <cfe595a7-c20d-4891-aba1-35546c488024@linux.alibaba.com>
Date: Thu, 4 Sep 2025 11:15:26 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <aLhykIPSGV1k_OG0@slm.duckdns.org>
From: escape <escape@linux.alibaba.com>
In-Reply-To: <aLhykIPSGV1k_OG0@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/9/4 00:53, Tejun Heo 写道:
> Hello,
>
> On Wed, Sep 03, 2025 at 07:11:07PM +0800, Yi Tao wrote:
>> As computer hardware advances, modern systems are typically equipped
>> with many CPU cores and large amounts of memory, enabling the deployment
>> of numerous applications. On such systems, container creation and
>> deletion become frequent operations, making cgroup process migration no
>> longer a cold path. This leads to noticeable contention with common
>> process operations such as fork, exec, and exit.
> If you use CLONE_INTO_CGROUP, cgroup migration doesn't just become cold. It
> disappears completely and CLONE_INTO_CGROUP doesn't need any global locks
> from cgroup side. Are there reasons why you can't use CLONE_INTO_CGROUP?
>
> Thanks.
>
As Ridong pointed out, in the current code, using CLONE_INTO_CGROUP
still requires holding the threadgroup_rwsem, so contention with fork
operations persists.

CLONE_INTO_CGROUP helps alleviate the contention between cgroup creation
and deletion, but its usage comes with significant limitations:

1. CLONE_INTO_CGROUP is only available in cgroup v2. Although cgroup v2
adoption is gradually increasing, many applications have not yet been
adapted to cgroup v2, and phasing out cgroup v1 will be a long and
gradual process.


2. CLONE_INTO_CGROUP requires specifying the cgroup file descriptor at the
time of process fork, effectively restricting cgroup migration to the
fork stage. This differs significantly from the typical cgroup attach
workflow. For example, in Kubernetes, systemd is the recommended cgroup
driver; kubelet communicates with systemd via D-Bus, and systemd
performs the actual cgroup attachment. In this case, the process being
attached typically does not have systemd as its parent. Using
CLONE_INTO_CGROUP in such a scenario is impractical and would require
coordinated changes to both systemd and kubelet.

Thanks.



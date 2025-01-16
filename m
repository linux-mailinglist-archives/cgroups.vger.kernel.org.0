Return-Path: <cgroups+bounces-6183-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE8CA13537
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 09:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EB53A55C0
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78419198A38;
	Thu, 16 Jan 2025 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="gR8FApBG"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36A194C75
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737015620; cv=none; b=f0945t+zlEbCVcQr0xg+v9hPXs0TJ2ACmyThBjnzCSDaGC66/6DcNSejCQcQaBbHK7tPlVg3yDyjinQhHGBrX/k+zGEO5LiAACh/dfj+RHfrd6mhykXaGcb8MKsPqk3Tu/b1KuNE09U0p60wBrqUkR74EZQeT5gLuJwkQn0z9+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737015620; c=relaxed/simple;
	bh=/RHLlbc4PW8R9gp+t/in1mtnrEju6WaZEupfBALpjfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzdq/S+ZgoChtGRr501Dr8CQFHeH1sZQO3VzU2X1N+GaXzageXaGD+zMY9L4Gpc169BqIaHcUDP5sRzLnG3yTYcbXYbdu0FDU8uDmwSFdAqLGH57QUwMarbAkPuBw5IvRZeipnmMt5UTUYuG8L5Ktr/hNXxiVsLNSj1sCd+okdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b=gR8FApBG; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1737015609; x=1737620409; i=friedrich.vock@gmx.de;
	bh=/RHLlbc4PW8R9gp+t/in1mtnrEju6WaZEupfBALpjfo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gR8FApBGALYfRCY67/CwEde2UjnFdfWccX7H3oLJfLISOrjS8Xb/5SDr5f4dmkw5
	 WQ8h2FW+HV85W6imnmYEI0ihuOAKq4Jx0wDjKruT99FDTOURrvjHmXJgxhcZ9gSNk
	 EBZvISFFBIQ6b82+QyjW35XQ5MHciXpOSxdkEyi4ccTKp955H6DLrTm4Rl76KOXZ0
	 10jgkOPl4YXTauVza0h7pLOHdj3f4KYpMs0YBFIS25IZNIxusN/yGCyst7mgnbhWs
	 3odohk9lMWpYH0J4lgM3vjmyplSWgCi22sLpc7bs7KYptbDTYArPM2qm/u1mu7Y5N
	 y2qFLdsDtDqeKFPmTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.16.110] ([134.34.7.110]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1t2bmm0G5d-00lhcQ; Thu, 16
 Jan 2025 09:20:09 +0100
Message-ID: <4d6ccc9a-3db9-4d5b-87c9-267b659c2a1b@gmx.de>
Date: Thu, 16 Jan 2025 09:20:08 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/dmem: Don't clobber pool in
 dmem_cgroup_calculate_protection
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org
References: <20250114153912.278909-1-friedrich.vock@gmx.de>
 <ijjhmxsu5l7nvabyorzqxd5b5xml7eantom4wtgdwqeq7bmy73@cz7doxxi57ig>
Content-Language: en-US
From: Friedrich Vock <friedrich.vock@gmx.de>
In-Reply-To: <ijjhmxsu5l7nvabyorzqxd5b5xml7eantom4wtgdwqeq7bmy73@cz7doxxi57ig>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9vRwhu7cYH3l3nQNyx4UESIEEF6MUpfdauZlOt/NmAn3SLx/gPy
 JWhXXtrBcX6D6Cpg6HB8EJZYq/vUQxihciR2Fk7rtwXn7CWHeuxeVvoglNGVHbk5lPEjNyr
 UK2FzmEp6Wfg5nCymfv4fCOp3oA7lZYcZLDfFlcv7R2QAh83ReymaLZRNl5ZQLmKjKUHW1Q
 S2lIiWfIaEfMm7n9Hc4Kw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cu/3UwpS19U=;v5KsVh8RdsptcHqNt75KrsHadhC
 lwZbeJWl10DGv9Xy4Jb7uE8LlGx+IZ5VGAKI4WIxm5n9+w2s+WMPixi74PjLJDVmW0JjKNxL6
 zX7zKLAUIqtF5OGyRbjbKNLI65vWITTkugcQJMXzCkBG6JTjMwvZNNJm90U1MKZQ2otr8E9ic
 0u5US7Mu6mnsxR95uRVC0AmGJahcu8MZvTnEuU7HYx3n5reTi5qBWlXgyEx5P0EqeUk/cORSw
 dy2De15F9+J+nIm1k4LJN+5PIgEQXcB02cV3FdcNFY51mNaMlIxiSiO8qEse1Ra6DpTqHhKKl
 9+kfATRgPUA8GKfyuW0mJHsWJ3lm2dtiKnqOJqocMyMXOP5l7mJhOvz3YYB8yHESGW2SYoBSS
 ZOtzbnOIv1s+qDPuNamvfo6cI/ZSbmqVA9yi8GlZhEpRDVJ+GRmFu45Wo1EIZUtGYhfypD7Ml
 2OvzHWooM2HV/bAFcPrGFsYkgTW9La4LPBDNDaIaM+LIAEoHn+/wlunNbiPhx1oDdscL14do5
 6vnIbIYspor0lfUFR5bN3qmwJvs/1gdPLFTrczglvZzluSY7Cyaysx39IiDaowilnJ5cuLDTP
 6PC6ltWY1woiUaZgWQEcZLSzZ6NGgpXQ3cIpXPQKQmB6MDjonjt9yVehX/etix0KEalRdjQ2m
 sTlpTC1fu/OClNxzAslAgmn8rGDK42chfZe8DT9Q0I3jQ3AX8NhM9Krwd/n8wQ42QN21L+qLq
 6L3Nd27UPj45L47oyILg2SRVm7yTbnMJ7JJc/FTjsNfkfaGPypbMjIhYAmKi4tZ2N1Sy5cN70
 wRlzcm9llSEW1I3gRiUswrhj+YWaRfdSFrxt1rV5xghjjUGdxbKa5OA1MCwLi8ndPq+YPh3v/
 6EeXUeeUdGMFP98MwSXyiFHYgrPszLhVTvb8GHjd2bpxbBn5ydTjNRI7qdWufp39PixHT8aqt
 KxVAXSUvmyoeYhtfCeH9RruQuE2k0pyhJUP0VbP13Be9EjJ4VjFEp913xRFYel8Dp/aFzr9Yv
 /o+ltN5i5mdWc8klT4/2A7AvqVxpZO2gHI22qdTsFQ3gtOpC+bWfZKAVbUl8ZSfDNJIxZJ/sO
 sZnxmml6jQWfj2kbSSUOfgHGIXBsEW77+BbWF5Cd6nfJ7aM8U3yleokTCbiDRegCYgm3WmhW6
 7vDTXD8Fft81Vt/xEoCyoeANVx89T5nJNxNJ0EcOXBA==

Hi,

On 14.01.25 16:58, Michal Koutn=C3=BD wrote:
> On Tue, Jan 14, 2025 at 04:39:12PM +0100, Friedrich Vock <friedrich.vock=
@gmx.de> wrote:
>> If the current css doesn't contain any pool that is a descendant of
>> the "pool" (i.e. when found_descendant =3D=3D false), then "pool" will
>> point to some unrelated pool. If the current css has a child, we'll
>> overwrite parent_pool with this unrelated pool on the next iteration.
>
> Could this be verified with more idiomatic way with
> cgroup_is_descendant()? (The predicate could be used between pools [1]
> if they pin respective cgroups).

I'm not sure if I'm missing something, but I don't think
cgroup_is_descendant is really related to this issue. Each css can
contain some amount of "pools" representing memory from different
devices (e.g. with the current DRM implementation, one pool corresponds
to VRAM of a specific GPU). These pools are allocated on-demand, so if a
cgroup has not made any allocations for a specific device, there will be
no pool corresponding to that device's memory. Pools have a hierarchy of
their own (that is, for a given cgroup's pool corresponding to some
device, the "parent pool" refers to the parent cgroup's pool
corresponding to the same device).

In dmem_cgroup_calculate_protection, we're trying to update the
protection values for the entire pool hierarchy between
limit_pool/test_pool (with the end goal of having accurate
effective-protection values for test_pool). Since pools only store
parent pointers to establish that hierarchy, to find child pools given
only the parent pool, we iterate over the pools of all child cgroups and
check if the parent pointer matches with our current "parent pool" pointer=
.

The bug happens when some cgroup doesn't have any pool in the hierarchy
we're iterating over (that is, we iterate over all pools but don't find
any pool whose parent matches our current "parent pool" pointer). The
cgroup itself is part of the (cgroup) hierarchy, so the result of
cgroup_is_descendant is obviously true - but because of how we allocate
pools on-demand, it's still possible there is no pool that is part of
the (pool) hierarchy we're iterating over.

Thanks,
Friedrich

>
> Thanks,
> Michal
>
> [1] https://lore.kernel.org/all/uj6railxyazpu6ocl2ygo6lw4lavbsgg26oq57px=
xqe5uzxw42@fhnqvq3tia6n/



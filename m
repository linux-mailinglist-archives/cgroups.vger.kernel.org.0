Return-Path: <cgroups+bounces-6233-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C436A157C1
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 20:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1253A795D
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6701A4E70;
	Fri, 17 Jan 2025 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="InYojkNR"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599CB13541B
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140589; cv=none; b=dT99x4UOGF7uRXcIIPB+58VTqIZmmIGdxugIVFaYR0gSeHr3JjP5GbtZC5FpikASNKdpl+amRsU1J6UGEW1j2eukmhTTPhI8084hQ0M10cUNpGtlETGErN/4uBMcwKrfREx6DV9VCR/t5a7jlti84hBeNlpsOGHnzjIxDT3Mn/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140589; c=relaxed/simple;
	bh=qV3G5HHTgEgnrgbvyQ2bbWWMNUDuHIoQRl3KqV3lKNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svVI2GVon1XmXKmtFhbpPlGyM1u3F9SFYBnv52Qe/STG1OF4RmNo78UZdywkmJI4nIZi0T+giy6VzicifB8yXetTL4Gcv8gEHTyXDcYYPIUHPCEHQGgLpSsAqEa56GB3VGOpPgYPcNbemc64CyLN6k63f+xbB0e2aQrnZDQzV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b=InYojkNR; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1737140576; x=1737745376; i=friedrich.vock@gmx.de;
	bh=HUdSRDRV0cPJ6WDT4VYchkxwV9clbSyqzdevI16Z3+E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=InYojkNR1FqZK4Je0pj00wRO9MP2Z6Sn/TyobHyCeNk9KqYCtPB0PW28OlNt7oT+
	 GUChWwkyt8dqaMooUlfnvm9En+mnYID3vRUWjrGP9VeMGhquJd9fMdoZXON5WpTjM
	 jOdq2yCixboIUrTPTW7H1o88OZGsfvanO76x3ddjsgvr/Hfec9qzUajyZwXCwPpGK
	 0btrbWM96Dvu9LrRlznxehk0J7H6n9A/n/nQ+1t4YQXZ7ET1uDe58gB6M7qoaChNb
	 msu2AD+8bDDu7eIGe2lwG1QaNpuzk2u5MCLIlhHKRjnh/NxT1byKmwXdxkmwkGfDg
	 vP4pyI56ElWpSCFiaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.3] ([109.91.201.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1tBbga3Chw-00hmgq; Fri, 17
 Jan 2025 20:02:56 +0100
Message-ID: <672de60e-5c10-406b-927c-7940d2fbc921@gmx.de>
Date: Fri, 17 Jan 2025 20:02:55 +0100
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
 <4d6ccc9a-3db9-4d5b-87c9-267b659c2a1b@gmx.de>
 <oe3qgfb3jfzoacfh7efpvmuosravx5kra3ss67zqem6rbtctws@5dmmklctrg3x>
Content-Language: en-US
From: Friedrich Vock <friedrich.vock@gmx.de>
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <oe3qgfb3jfzoacfh7efpvmuosravx5kra3ss67zqem6rbtctws@5dmmklctrg3x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x++ngGT0yz66f+VdCjKPhROCNNUFMQU9JppzLR7xi/HSpWYmaAo
 /PX9fSWVEobFgb+93rNawEuTh8Tip3RpxnvWf3t+1t4dM9GrzLgPj0EtQi+2R8OExKnKV5u
 1Ia9bA6uXpiO3Sx6Urfl3+AjCqrGhV4rJ16o69n78HjAbXnjfk2FmBzAKurf//ZkK9sTW/O
 qUmdi3I1jNO44DhzLXWOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LeEm+z2Zc10=;e7+9SwaDc6joL+vsZahBM2NTdlX
 txHHc/L1P3CWNqvAB+WyMeM6qixMZE41rdrolyo8OPeDA8XQH2lFYCUD44gTx+AL274+PYlho
 0CjO5utleLHVbM7VVZtjyPxArQXabV9W6aXs/C57Vjwq3q8nv8ZcBkkidUWot30sZizQ7DnpC
 k47aMpEykIJp6h0AMpklmw6MED/AHUoov3uHP47G/ybMN1ABDB5QxE3fjS6PDoGNx9+pEuyea
 1qeP0PXdLRxcKdKKILHkwkx7Rcr75Or4ksPAqdakOJ8vStCb0QeIJP2ZqVPTP3TmPTStxkz+J
 /aB5mZQVv5b9BGhtFtfBxwQ2xGMOZ9Yt/oIv+NJ8jmNpfWqfHxarYDmjbhf2YWjT8hd0EAJ6/
 EKLFuBRMhlqyfdjbpL/hIKAuC8nzgG4PJjNzLSRkpwfSNfMqh9IYes09AcfwyKYbqaOX83a7C
 xk62EI0kfVnDNeqXPIwcB4lNC9PG1HrmJZpArPNJOPEFIfr0tltJlwoxO5p3jBG41/ANZw6dD
 dZNytCmZcHIKsgAucxBTsy82A5J45ObaxlQVO4LIWwuWY+lPhgugQ7JOXftLtIA+AWZSVFWND
 EdEclR+iFJhF49B18Qs8ONCybzhnyqtSui1qHERIcXI+9BXepHj6nndLbkQ/ksNQWXmA2+v33
 9AfjXiF+kJYFFAhZjRgjIJusIEqjdMYO/fZor+i8YECbZdQ8Jn876XLxjGtAuQ/90MGEb4Vag
 tC4FZxRALFSSAQL12oMBdS5LxXau5AW1mRLElbycNU4CjLC9WWEBmoev+ZItiHLgFURU4atPN
 Dz2m7YDoZi9Hyov2V9jM7LRbGSISBR4W/OlWIepCwQ0QATQ2OA0XELoXs/+1AS9dDMxc7NiCR
 qcSborEPkhlef5jQgs6LPBh+E7aGn65W+2SbG8zh+7VyiM1ocw8ZEdKBMCUhszbiC3rM0EvXr
 VzgmCl4fuSE5RTR6UH1snCHjAKW1KNgQVPCdgaofkXgXsLufxbuezwi9rWsXArfc1te7MrCbr
 Q2MM0B2JJ7iTvK7ByU9NcZwjmQ40SY6Y9EhWcN9qqBPfF62V8rq9i1BipWklhUnWwaTWKsyN6
 /beI6Llz1dFFFPmoZaSe/xIN6f2zXm/LZ7SpnXl+T6K2u2osqcqZuiCRo3YyeeTyALH8fjv0r
 r21AxZFy4fVCF6kEvlCdhk+sJRh5EWFIERIcnqbWBEA==

On 17.01.25 18:29, Michal Koutn=C3=BD wrote:
> On Thu, Jan 16, 2025 at 09:20:08AM +0100, Friedrich Vock <friedrich.vock=
@gmx.de> wrote:
>> These pools are allocated on-demand, so if a
>> cgroup has not made any allocations for a specific device, there will b=
e
>> no pool corresponding to that device's memory.
>
> Here I understand.
>
>> Pools have a hierarchy of their own (that is, for a given cgroup's
>> pool corresponding to some device, the "parent pool" refers to the
>> parent cgroup's pool corresponding to the same device).
>>
>> In dmem_cgroup_calculate_protection, we're trying to update the
>> protection values for the entire pool hierarchy between
>> limit_pool/test_pool (with the end goal of having accurate
>> effective-protection values for test_pool).
>
> If you check and bail out at start:
> 	if (!cgroup_is_descendant(test_pool->cs->css.cgroup, limit_pool->cs->cs=
s.cgroup))
> 		return;
> ...
>
>> Since pools only store parent pointers to establish that hierarchy, to
>> find child pools given only the parent pool, we iterate over the pools
>> of all child cgroups and check if the parent pointer matches with our
>> current "parent pool" pointer.
>
>> The bug happens when some cgroup doesn't have any pool in the hierarchy
>> we're iterating over (that is, we iterate over all pools but don't find
>> any pool whose parent matches our current "parent pool" pointer).
>
> ...then the initial check ensures, you always find a pool that is
> a descendant of limit_pool (at least the test_pool).
> And there are pools for whole path between limit_pool and test_pool, or
> am I mistaken here?

Yeah, there are pools for the whole path between limit_pool and
test_pool, but the issue is that we traverse the entire tree of cgroups,
and we don't always stay on the path between limit_pool and test_pool
(because we're iterating from the top down, and we don't know what the
path is in that direction - so we just traverse the whole tree until we
find test_pool).

This means that we'll sometimes end up straying off-path - and there are
no guarantees for which pools are present in the cgroups we visit there.
These cgroups are the potentially problematic ones where the issue can
happen.

Ideally we could always stay on the path between limit_pool and
test_pool, but this is hardly possible because we can only follow parent
links (so bottom-up traversal) but for accurate protection calculation
we need to traverse the path top-down.

>
>> The cgroup itself is part of the (cgroup) hierarchy, so the result of
>> cgroup_is_descendant is obviously true - but because of how we
>> allocate pools on-demand, it's still possible there is no pool that is
>> part of the (pool) hierarchy we're iterating over.
>
> Can there be a pool without cgroup?

No, each pool is always associated with exactly one cgroup. What I was
talking about was the case where a parent cgroup has pools A and B, but
its child cgroup only has a pool for A. In that case, the child cgroup
has no pool that is part of B's pool hierarchy.

Thanks,
Friedrich


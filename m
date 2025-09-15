Return-Path: <cgroups+bounces-10095-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0741B57C9B
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 15:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A01171E9C
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BC530CDBE;
	Mon, 15 Sep 2025 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="QrI1PImJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1B42A82
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942267; cv=none; b=KfzRkB51YZreO0LwmFcTboPxhWWZKLQQmgPGmeL14uA6Edc957zDSmK8AQUlJMgmr8zlNWm2q0ifwbndCjTzbemNb9eTC2A4CnqtBcyfvLS8bSfJCwWD8sXVzQpgtB6DGGLhEHIsRGRjrLj8nE6DQnFNgcSRJl3Rdmio0EL5DXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942267; c=relaxed/simple;
	bh=VZ5ztYT7BrZo4R3GcRUIavwGanWLZq7yl7NM5Y4X5rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHbHOyoQyNcX207jmRsRLUvPE1n9CDwZyES3mchuzJxFm75LmDORTv9HiGba303nbfwLgFnnhT6+p/1YuJa1WTZk5Woz4VhxJVNvhgecM1lM99ZR4H0HXdgylzDjJFhvB881liNVvw9V77cJqcm2I6rhSskzzXU6gD+gy7SuGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=QrI1PImJ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757942263; x=1758547063; i=natalie.vock@gmx.de;
	bh=fyMOOUCoam/ib37j55c/zuWeEgYq6oPxD2lOjfP63RQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QrI1PImJGdqa6axiplZEWh6jYsOT7o4cgmjqVlRpAN74CNijDd5VhZNT3t7PUOAC
	 encRfA/4tCjUQlMmUfhJWXPtPosTcQiOa8SRUhq0VOBvkbAJjkOz0GzXulrLy9k2B
	 DjaQZhRh8QjSRNWbpLqrpFHGW+ur8cAEFVHaKJue15e8737ReL6Y95o8toZU51MI4
	 4a1auL+rzyfY8u9oyHq6oWRUcMwcqJYZ0XNmRR10VIRRx9m10dPdex+QJmh9B0tpy
	 tMstSkx/IMgrh81AG7DS+2pR/s4Szs6ZBDiNOMQCicPgMQkhAIOIDWR8pGNwopLVX
	 g6XnyWP/5+MvN4VQHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.3] ([109.91.201.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7iCg-1uLK443Tda-00zh5p; Mon, 15
 Sep 2025 15:17:42 +0200
Message-ID: <6f4d8e35-5230-49ed-99e2-3d923e9d0012@gmx.de>
Date: Mon, 15 Sep 2025 15:17:40 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] cgroup/dmem, drm/ttm: Improve protection in contended
 cases
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20250915-dmemcg-aggressive-protect-v1-0-2f3353bfcdac@gmx.de>
 <01e2369e-1df2-446d-9f9d-59c86cc55a04@amd.com>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <01e2369e-1df2-446d-9f9d-59c86cc55a04@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kx8C6UwtyWAsWPeku0jGhVghNmmker5SpH3buvNp42ADPhAsz0n
 SbTKeJoLFHXKtupg7khyFKlGZcnQJaZ01dfsg4/3w3x0pEjK+7raTYyS0XurQdm0Lpb2PDx
 n/fyNpRykSKz3V84Mbxx0tIPyHLEMXGTq7OQIhshSArCw5F0IxMp7gU3D1YBDJvXUCXFoMr
 7WqyvPLpMYHkvfC5Cu1ZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:THqIyRf5xGM=;YIF5FLMYHrtzGRS0MOyDWV2aUUd
 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
 fSbsUf88wM

On 9/15/25 14:48, Christian K=C3=B6nig wrote:
> On 15.09.25 14:36, Natalie Vock wrote:
>> Hi all,
>>
>> I've been looking into some cases where dmem protection fails to preven=
t
>> allocations from ending up in GTT when VRAM gets scarce and apps start
>> competing hard.
>>
>> In short, this is because other (unprotected) applications end up
>> filling VRAM before protected applications do. This causes TTM to back
>> off and try allocating in GTT before anything else, and that is where
>> the allocation is placed in the end. The existing eviction protection
>> cannot prevent this, because no attempt at evicting is ever made
>> (although you could consider the backing-off as an immediate eviction t=
o
>> GTT).
>=20
> Well depending on what you gave as GEM flags from userspace that is expe=
cted behavior.
>=20
> For applications using RADV we usually give GTT|VRAM as placement which =
basically tells the kernel that it shouldn't evict at all and immediately =
fallback to GTT.

Yeah, in general this behavior is completely expected - though I'd argue=
=20
that protecting VRAM via dmemcg influences the semantics a little here.

Giving GTT|VRAM as placement from userspace essentially says "ok, please=
=20
try allocating this in VRAM, but it's ok to fall back to GTT" - whereas=20
specifying VRAM only essentially says "ok, please allocate this in VRAM,=
=20
and really try hard to keep it in VRAM whatever the cost".

Usually, resource allocation failing is good enough of an indicator that=
=20
it's not possible to allocate in VRAM. However, when the application's=20
memory is protected by dmemcg, it essentially says that it actually=20
should be possible to allocate up to that amount of memory - the cgroup=20
is entitled to that memory, and the other unprotected cgroups have to=20
make do with the rest.

I think it's a justifiable tradeoff between the indended function of=20
VRAM|GTT and the intended function of dmem memory protection to evict=20
these unprotected cgroups for only as long as the usage doesn't exceed=20
the awarded protection - this is what this series implements (dropping=20
the GTT flag in userspace would have negative implications in the case=20
the app uses more memory than the protection afforded to it, and as I=20
described, just letting protected memory allocations fall back to GTT is=
=20
insufficient too).

Thanks,
Natalie

>=20
> Regards,
> Christian.
>=20
>>
>> This series tries to alleviate this by adding a special case when the
>> allocation is protected by cgroups: Instead of backing off immediately,
>> TTM will try evicting unprotected buffers from the domain to make space
>> for the protected one. This ensures that applications can actually use
>> all the memory protection awarded to them by the system, without being
>> prone to ping-ponging (only protected allocations can evict unprotected
>> ones, never the other way around).
>>
>> The first two patches just add a few small utilities needed to implemen=
t
>> this to the dmem controller. The second two patches are the TTM
>> implementation:
>>
>> "drm/ttm: Be more aggressive..." decouples cgroup charging from resourc=
e
>> allocation to allow us to hold on to the charge even if allocation fail=
s
>> on first try, and adds a path to call ttm_bo_evict_alloc when the
>> charged allocation falls within min/low protection limits.
>>
>> "drm/ttm: Use common ancestor..." is a more general improvement in
>> correctly implementing cgroup protection semantics. With recursive
>> protection rules, unused memory protection afforded to a parent node is
>> transferred to children recursively, which helps protect entire
>> subtrees from stealing each others' memory without needing to protect
>> each cgroup individually. This doesn't apply when considering direct
>> siblings inside the same subtree, so in order to not break
>> prioritization between these siblings, we need to consider the
>> relationship of evictor and evictee when calculating protection.
>> In practice, this fixes cases where a protected cgroup cannot steal
>> memory from unprotected siblings (which, in turn, leads to eviction
>> failures and new allocations being placed in GTT).
>>
>> Thanks,
>> Natalie
>>
>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>> ---
>> Natalie Vock (4):
>>        cgroup/dmem: Add queries for protection values
>>        cgroup/dmem: Add dmem_cgroup_common_ancestor helper
>>        drm/ttm: Be more aggressive when allocating below protection lim=
it
>>        drm/ttm: Use common ancestor of evictor and evictee as limit poo=
l
>>
>>   drivers/gpu/drm/ttm/ttm_bo.c       | 79 +++++++++++++++++++++++++++++=
+++------
>>   drivers/gpu/drm/ttm/ttm_resource.c | 48 ++++++++++++++++-------
>>   include/drm/ttm/ttm_resource.h     |  6 ++-
>>   include/linux/cgroup_dmem.h        | 25 ++++++++++++
>>   kernel/cgroup/dmem.c               | 73 +++++++++++++++++++++++++++++=
++++++
>>   5 files changed, 205 insertions(+), 26 deletions(-)
>> ---
>> base-commit: f3e82936857b3bd77b824ecd2fa7839dd99ec0c6
>> change-id: 20250915-dmemcg-aggressive-protect-5cf37f717cdb
>>
>> Best regards,
>=20



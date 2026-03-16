Return-Path: <cgroups+bounces-14831-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCBsN1DJt2kRVQEAu9opvQ
	(envelope-from <cgroups+bounces-14831-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 10:11:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7077C296C57
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 10:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE67B3061771
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A90D382F13;
	Mon, 16 Mar 2026 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="YFdRkUyz"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF78382F12
	for <cgroups@vger.kernel.org>; Mon, 16 Mar 2026 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651927; cv=none; b=EjI1uylpO3rFGcEGUJFInuC1+jnaMDKiKT2yBHrZ5DT3bwQZfE8+6QM1L58s6WrR2D6JLGBTp6+ZvYYMP12hjh/0wVmKDql27UXEbOTOqBwwoHEJTvKDlUHnjMuyrXk1+nSLmJlUBw8YbUzvUo6RfCT/1YrIMbOgfPhCRZWjZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651927; c=relaxed/simple;
	bh=Y+Xwh+O1w2JgaYhr8eGzj06PXUowI/yAVRV8jeCtX38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYKDZD6UJW5wpVnfjspbxMLPkO41WnCM4VfgSHzNeTemwy1sLYGU5lR8IoMG9bPHkgQ1Bkd8PqIQUDHDLgiaJs2g2KRAiRJU33bTapbfOVlJkpFXvdfclWzNoBQE8upoGb3CRs5oThacf4M0kMJ3wL3HObllr2JLVQf/bTZSc/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=YFdRkUyz; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773651910; x=1774256710; i=natalie.vock@gmx.de;
	bh=Y+Xwh+O1w2JgaYhr8eGzj06PXUowI/yAVRV8jeCtX38=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YFdRkUyza8zbxwRTYfrgIUTuDFCd1PFUXiITHpFSFKgGx98K0q8SxOP9+6AbqJ8C
	 8utZ23tKEnjWfSZIxJgavpPxOxgYIjjgcXAVPpIMK69H5Zysiz1SDqIRyTsmpwTvP
	 eKYDW95SxZv+vVj2F8PztdjH6Pcuoc6WKKqFHl7rNz9lQR5pRfjGffR18uQHzrolE
	 CGIIOdFjl1WCv0Fft5glyNKz5SXa+yke1ZfScsS5gqeF33P16UNcz/D57e7gkZTVf
	 tJfTyV8HwUqbxQ8ZIXRy8cSSfJLzLepeMEZm7ftwSzzoeM5tdPuMBuHgZbYONFfFz
	 IwkVhgkGb7bnPKuU1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1vPAhU3ZTZ-00dpR8; Mon, 16
 Mar 2026 10:05:10 +0100
Message-ID: <792705f1-e50e-48f8-ae06-95b6da0bb0f1@gmx.de>
Date: Mon, 16 Mar 2026 10:05:07 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/ttm: Use common ancestor of evictor and
 evictee as limit pool
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-6-7c71cc1492db@gmx.de>
 <cf522bc4-09ef-4e19-afc4-2c8a9d8a1abc@ursulin.net>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <cf522bc4-09ef-4e19-afc4-2c8a9d8a1abc@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wC/9A+nsQs0YyX8ZZ005iHf95jqrlLiSMzOAC0BIkuetQfC7t6n
 /qf1+Rbu/4/TlyUBf2yApE5HPdfFlxIjdSS8C+Q1ZBys8UahopuK2VNV4KXavHhaFswypSP
 JUDpRndTbtK8Ombv2teCTiHcpposfPvquClfJL9X/LIGTUIEf6zXNLr4fjtTHd1s28qBwqG
 T9aCfGiCo8OhQIGxAys8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VdI23JBag7w=;gdzRqBsPtjFZEs+JpysOyXSIiL4
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14831-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[ursulin.net,lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7077C296C57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 15:11, Tvrtko Ursulin wrote:
>=20
> On 13/03/2026 11:40, Natalie Vock wrote:
>> When checking whether to skip certain buffers because they're protected
>> by dmem.low, we're checking the effective protection of the evictee's
>> cgroup, but depending on how the evictor's cgroup relates to the
>> evictee's, the semantics of effective protection values change.
>>
>> When testing against cgroups from different subtrees, page_counter's
>> recursive protection propagates memory protection afforded to a parent
>> down to the child cgroups, even if the children were not explicitly
>> protected. This prevents cgroups whose parents were afforded no
>> protection from stealing memory from cgroups whose parents were afforde=
d
>> more protection, without users having to explicitly propagate this
>> protection.
>>
>> However, if we always calculate protection from the root cgroup, this
>> breaks prioritization of sibling cgroups: If one cgroup was explicitly
>> protected and its siblings were not, the protected cgroup should get
>> higher priority, i.e. the protected cgroup should be able to steal from
>> unprotected siblings. This only works if we restrict the protection
>> calculation to the subtree shared by evictor and evictee.
>>
>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>> ---
>> =C2=A0 drivers/gpu/drm/ttm/ttm_bo.c | 43 ++++++++++++++++++++++++++++++=
++++=20
>> ++++++---
>> =C2=A0 1 file changed, 40 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.=
c
>> index 7300b91b77dd3..df4f4633a3a53 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -628,11 +628,48 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk=20
>> *walk, struct ttm_buffer_object *
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_bo_evict_walk *evict_walk =3D
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 container_of(wal=
k, typeof(*evict_walk), walk);
>> +=C2=A0=C2=A0=C2=A0 struct dmem_cgroup_pool_state *limit_pool, *ancesto=
r =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 bool evict_valuable;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s64 lret;
>> -=C2=A0=C2=A0=C2=A0 if (!dmem_cgroup_state_evict_valuable(evict_walk->a=
lloc_state-=20
>> >limit_pool,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bo->resource->css, evict_walk->try_low,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 &evict_walk->hit_low))
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If may_try_low is not set, then we're tryin=
g to evict unprotected
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * buffers in favor of a protected allocation =
for charge_pool.=20
>> Explicitly skip
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * buffers belonging to the same cgroup here -=
 that cgroup is=20
>> definitely protected,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * even though dmem_cgroup_state_evict_valuabl=
e would allow the=20
>> eviction because a
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * cgroup is always allowed to evict from itse=
lf even if it is=20
>> protected.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (!evict_walk->alloc_state->may_try_low &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bo-=
>resource->css =3D=3D evict_walk->alloc_state->charge_pool)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>=20
> Hm.. should this hunk go into the previous patch?

Hm. Maybe, I can move it there in a v7.

>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 limit_pool =3D evict_walk->alloc_state->limit_pool;
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If there is no explicit limit pool, find th=
e root of the=20
>> shared subtree between
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * evictor and evictee. This is important so t=
hat recursive=20
>> protection rules can
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * apply properly: Recursive protection distri=
butes cgroup=20
>> protection afforded
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * to a parent cgroup but not used explicitly =
by a child cgroup=20
>> between all child
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * cgroups (see docs of effective_protection i=
n mm/=20
>> page_counter.c). However, when
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * direct siblings compete for memory, sibling=
s that were=20
>> explicitly protected
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * should get prioritized over siblings that w=
eren't. This only=20
>> happens correctly
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * when the root of the shared subtree is pass=
ed to
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * dmem_cgroup_state_evict_valuable. Otherwise=
, the effective-=20
>> protection
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * calculation cannot distinguish direct sibli=
ngs from unrelated=20
>> subtrees and the
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * calculated protection ends up wrong.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (!limit_pool) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ancestor =3D dmem_cgroup_ge=
t_common_ancestor(bo->resource->css,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 evict_walk->alloc_state->charge_po=
ol);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 limit_pool =3D ancestor;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 evict_valuable =3D dmem_cgroup_state_evict_valuable=
(limit_pool, bo-=20
>> >resource->css,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 evict_walk->try_low,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &evict_walk->hit_low);
>> +=C2=A0=C2=A0=C2=A0 if (ancestor)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmem_cgroup_pool_state_put(=
ancestor);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!evict_valuable)
>=20
> This part is probably better reviewed by someone more familiar with the=
=20
> dmem controller. One question I have though is whether this patch is=20
> independent from the rest of the series or it really makes sense for it=
=20
> to be last?

It depends on patch 2/6 (cgroup,cgroup/dmem: Add=20
(dmem_)cgroup_common_ancestor helper). I could potentially reorder it,=20
though then there's likely going to be quite a few rebase conflicts.

Thanks,
Natalie

>=20
> Regards,
>=20
> Tvrtko
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bo->pin_count || !bo->bdev->funcs->e=
viction_valuable(bo,=20
>> evict_walk->place))
>>
>=20



Return-Path: <cgroups+bounces-14799-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K9BIZz3s2nYdgAAu9opvQ
	(envelope-from <cgroups+bounces-14799-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:40:12 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F94282569
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D1443030D30
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 11:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0684837268C;
	Fri, 13 Mar 2026 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="tpYdWsBs"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7172DAFA1
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402007; cv=none; b=u9QZeKX9AxsFXuE4JKBupcMEEj9lUBk7SqeII9MVxDg5HcEx3bICiZO3de3/eUDkLzJQFigtE+fHsLS6IZNx5nApd+SJ36kd8JrPQaMDrAQm2ETnvTh+xjpIerMTLpXfjOnHQOy2jOl9pCyiijyRg1Gc7QVNcnphfJbOw/D7gRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402007; c=relaxed/simple;
	bh=O6LnZ/OriRH8IEezyrh+nyfupgbna2z1KjXLdE7UBWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpVu/90NQWORwNlQkrdkucA9IQwCvfJI3I1Z4PjPvlF0WBgq5U0gHJyUAYmNGc+gRdcC8LLx3GeTsLKKhf3MBZ+zEl6MVqWeEE9PTiAQEZZjYEBPUzZLBR8SSzAWO/nmkekt3XdkJ8LIdqdnpLNg5CBiqyGT+bkSE1CSNgCKIGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=tpYdWsBs; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773401985; x=1774006785; i=natalie.vock@gmx.de;
	bh=YEpOiLNywxYHECbqq5un45bCps6h5ekzhNixay7A9M0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tpYdWsBsOpdCcOppVbwvUCkLddXAEshYxDiSsrHwXKAP1WmiM8zo7LN3FaVYwUIX
	 TGYaUoqvXmQZguHiSLf0sLJmOXyJ8F7uoLlGSnKIOPbcpqM8IT8Y4UfMrGeHk7K1N
	 tTXudquC0CvY+af0Q3IVy3KIolRNsfLZi/G7sof8vG0Cue3+JL/l9BYBIJpTd8oo0
	 Ic6U3sTLIl9O+kmfXqlfAuf8H+C6xEFJP/eqlkar2/62vr3BBxcOSGQA2qc1C+B2y
	 5kTW1As0GpJETqfm3IqflvZPsvSoSvdl9pY1AdIg1htwHofbBjbcEXvkjLwH9IWa0
	 927CrIGJSnuAoM95wQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26rD-1w2wg53x4z-002p9j; Fri, 13
 Mar 2026 12:39:45 +0100
Message-ID: <168a4220-56e6-49e6-b995-64f60592b434@gmx.de>
Date: Fri, 13 Mar 2026 12:39:42 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] drm/ttm: Be more aggressive when allocating below
 protection limit
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
References: <20260302-dmemcg-aggressive-protect-v5-0-ffd3a2602309@gmx.de>
 <20260302-dmemcg-aggressive-protect-v5-5-ffd3a2602309@gmx.de>
 <86ef0e02-ac40-4bd4-bfcb-173d4312acb2@ursulin.net>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <86ef0e02-ac40-4bd4-bfcb-173d4312acb2@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ByeW9p98JP/bT5PtUIMlOQ6D62CFsNOpqdt0VavYjXC3qaW3GRZ
 Yx3hUTKgosEwuyqfN4oHipJoGchIHwailTDmo03iCgKN+uuApSlezitTwxneclVXjGLxkCH
 MKyUJSuT81T0pZ4ZQLVVe/33IYpxpP1a63P/hL0rz27oaZdurXzNUkN/Prhji3qCn6hMyDZ
 HI+bhig283tkeZ8B69IRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eOiezUcl2zg=;WYcBBURLaXvjYchnBtz1ECy0DHZ
 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
 tq10DGT66mqBPisOvRhsdvUU3XZ8LkYCA==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14799-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:dkim,gmx.de:email,gmx.de:mid]
X-Rspamd-Queue-Id: 01F94282569
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/2/26 18:02, Tvrtko Ursulin wrote:
>=20
> On 02/03/2026 12:37, Natalie Vock wrote:
>> When the cgroup's memory usage is below the low/min limit and allocatio=
n
>> fails, try evicting some unprotected buffers to make space. Otherwise,
>> application buffers may be forced to go into GTT even though usage is
>> below the corresponding low/min limit, if other applications filled VRA=
M
>> with their allocations first.
>>
>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>> ---
>> =C2=A0 drivers/gpu/drm/ttm/ttm_bo.c | 52 ++++++++++++++++++++++++++++++=
++++=20
>> +++++-----
>> =C2=A0 1 file changed, 47 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.=
c
>> index 53c4de4bcc1e3..86f99237f6490 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -494,6 +494,10 @@ struct ttm_bo_alloc_state {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dmem_cgroup_pool_state *charge_po=
ol;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /** @limit_pool: Which pool limit we sho=
uld test against */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dmem_cgroup_pool_state *limit_poo=
l;
>> +=C2=A0=C2=A0=C2=A0 /** @only_evict_unprotected: If only unprotected BO=
s, i.e. BOs=20
>> whose cgroup
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0 is exceeding its dmem low/min protect=
ion, should be=20
>> considered for eviction
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 bool only_evict_unprotected;
>> =C2=A0 };
>> =C2=A0 /**
>> @@ -598,8 +602,12 @@ static int ttm_bo_evict_alloc(struct ttm_device=20
>> *bdev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 evict_walk.walk.arg.trylock_only =3D tru=
e;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lret =3D ttm_lru_walk_for_evict(&evict_w=
alk.walk, bdev, man, 1);
>> -=C2=A0=C2=A0=C2=A0 /* One more attempt if we hit low limit? */
>> -=C2=A0=C2=A0=C2=A0 if (!lret && evict_walk.hit_low) {
>> +=C2=A0=C2=A0=C2=A0 /* If we failed to find enough BOs to evict, but we=
 skipped over
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * some BOs because they were covered by dmem =
low protection, retry
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * evicting these protected BOs too, except if=
 we're told not to
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * consider protected BOs at all.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (!lret && evict_walk.hit_low && !state->only_evi=
ct_unprotected) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 evict_walk.try_l=
ow =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lret =3D ttm_lru=
_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -620,7 +628,8 @@ static int ttm_bo_evict_alloc(struct ttm_device=20
>> *bdev,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (!lret && evict_walk.evicted);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We hit the low limit? Try once more *=
/
>> -=C2=A0=C2=A0=C2=A0 if (!lret && evict_walk.hit_low && !evict_walk.try_=
low) {
>> +=C2=A0=C2=A0=C2=A0 if (!lret && evict_walk.hit_low && !evict_walk.try_=
low &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !st=
ate->only_evict_unprotected) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 evict_walk.try_l=
ow =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto retry;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -730,7 +739,7 @@ static int ttm_bo_alloc_at_place(struct=20
>> ttm_buffer_object *bo,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_resource **res,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ttm_bo_alloc_state *alloc_s=
tate)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 bool may_evict;
>> +=C2=A0=C2=A0=C2=A0 bool may_evict, below_low;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 may_evict =3D (force_space && place->mem=
_type !=3D TTM_PL_SYSTEM);
>> @@ -749,9 +758,42 @@ static int ttm_bo_alloc_at_place(struct=20
>> ttm_buffer_object *bo,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * cgroup protection plays a special role in e=
viction.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Conceptually, protection of memory via the =
dmem cgroup controller
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * entitles the protected cgroup to use a cert=
ain amount of memory.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * There are two types of protection - the 'lo=
w' limit is a
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * "best-effort" protection, whereas the 'min'=
 limit provides a hard
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * guarantee that memory within the cgroup's a=
llowance will not be
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * evicted under any circumstance.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * To faithfully model this concept in TTM, we=
 also need to take=20
>> cgroup
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * protection into account when allocating. Wh=
en allocation in one
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * place fails, TTM will default to trying oth=
er places first before
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * evicting.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If the allocation is covered by dmem cgroup=
 protection, however,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * this prevents the allocation from using the=
 memory it is=20
>> "entitled"
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * to. To make sure unprotected allocations ca=
nnot push new=20
>> protected
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * allocations out of places they are "entitle=
d" to use, we should
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * evict buffers not covered by any cgroup pro=
tection, if this
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * allocation is covered by cgroup protection.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Buffers covered by 'min' protection are a s=
pecial case - the=20
>> 'min'
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * limit is a stronger guarantee than 'low', a=
nd thus buffers=20
>> protected
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * by 'low' but not 'min' should also be consi=
dered for eviction.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Buffers protected by 'min' will never be co=
nsidered for eviction
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * anyway, so the regular eviction path should=
 be triggered here.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Buffers protected by 'low' but not 'min' wi=
ll take a special
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * eviction path that only evicts buffers cove=
red by neither=20
>> 'low' or
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * 'min' protections.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 may_evict |=3D dmem_cgroup_below_min(NULL, alloc_st=
ate->charge_pool);
>=20
> It may make sense to group the two lines which "calculate" may_evict=20
> together. which would probably mean also pulling two lines below to=20
> before try charge, so that the whole logical block is not split.

This is unfortunately not possible, because this logic depends on the=20
charge_pool which we don't have before try_charge.

>=20
>> +=C2=A0=C2=A0=C2=A0 below_low =3D dmem_cgroup_below_low(NULL, alloc_sta=
te->charge_pool);
>> +=C2=A0=C2=A0=C2=A0 alloc_state->only_evict_unprotected =3D !may_evict =
&& below_low;
>=20
> Would it work to enable may_evict also if below_low is true, and assign=
=20
> below_low directly to only_evict_unprotected? I mean along the lines of:
>=20
> may_evict =3D force_space && place->mem_type !=3D TTM_PL_SYSTEM;
> may_evict |=3D dmem_cgroup_below_min(NULL, alloc_state->charge_pool);
> alloc_state->only_evict_unprotected =3D dmem_cgroup_below_low(NULL,=20
> alloc_state->charge_pool);
>=20
> It would allow the if condition below to be simpler. Evict callback=20
> would remain the same I guess.
>=20
> And maybe only_evict_unprotected could be renamed to "try_low" to align=
=20
> with the naming in there? Then in the callback the condition would be li=
ke:
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0 /* We hit the low limit? Try once more */
>  =C2=A0=C2=A0=C2=A0=C2=A0if (!lret && evict_walk.hit_low &&
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(evict_walk.try_low | state=
->try_low))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 evict_walk.try_low =3D=
 true;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto retry;
>=20
> Give or take.. Would that be more readable eg. obvious? Although I am=20
> endlessly confused how !try_low ends up being try_low =3D true in this=
=20
> condition so maybe I am mixing something up. You get my gist though?=20
> Unifying the naming and logic for easier understanding in essence if you=
=20
> can find some workable way in this spirit I think it is worth thinking=
=20
> about it.

Maybe that becomes clearer in v6, I'll include some cleanups based on=20
your suggestions here.

Thanks,
Natalie

>=20
> Regards,
>=20
> Tvrtko
>=20
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ttm_resource_alloc(bo, place, re=
s, alloc_state->charge_pool);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -ENOSPC && m=
ay_evict)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -ENOSPC && (=
may_evict || below_low))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ret =3D -EBUSY;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>=20



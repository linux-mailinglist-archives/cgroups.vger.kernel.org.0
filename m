Return-Path: <cgroups+bounces-14757-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPtbIEUqsWkBrgIAu9opvQ
	(envelope-from <cgroups+bounces-14757-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 09:39:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E371B25F7E9
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 09:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AA373040F81
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 08:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E3D3C13FF;
	Wed, 11 Mar 2026 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="ppfOhwOf"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA443B9D93
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218061; cv=none; b=YY+lcy9r6wNdDPP6w7RqKGfZxSdKqeDMc6oHKqD1Skui7URDJ1HiMfuXRc6INaRI3B/fpv888mL7+YDtUoK21gjnlnkbMzYGUIupQvq4GlT7rsKpP4IbhoDs2FNJ/jCzTcW/c7QoFM/Grb6KpmCU3dmJDSl1BX3VskniIfWKje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218061; c=relaxed/simple;
	bh=PopoGSZ2e1W7NNJxmvOPDpG3+G56KTggHWviMQZFST4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRzBXGFRl85EfkJvEVyIUb4O16PRA1daCD7LsAbHhC0U9vb5BuqrZ3Sy/oj0igXiBb9Zzv6a+oGszDjgiCMg7kw8XOE2aU2sZyJUn1eFzrOWEUyU+qPwpQ2p4G1EAGs6SAlksRL8T9keO71PidMpZNyZ1xyFm1H144Jwjp/h7zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=ppfOhwOf; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773218023; x=1773822823; i=natalie.vock@gmx.de;
	bh=jkptTJcd5Q+ivcnvJBGvTsG0edSF6nRUs5nOlThf7Yk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ppfOhwOfKxCghUXqPolPtSX/t8t45DW7GM4xl82eezDJFs/+OWFr5N/a/mSNMPb4
	 1FYdHYkyZ3a+Uay7axqvQOM12qRwPZgapPJi5Hsh0vh6oT5NyFiGMovRjUxc54e8W
	 q8VQkGXtn+8jZp9/DUaeb72s7kg1JBLogeiVEARvukyue5msccBzTqj+SMEhHejck
	 DvIgHv/1XhYu9TGF10QJfP5vcFJC8mtXA5k/nZprMmwxZ+u8mYf4EfF1kEtIgoEQC
	 lvLrGiyzeXwmPdC+ZKDkAw7wFpHqCNwNJXHqnvNafb0nTYAMdXa0zpQzLSZbxxh20
	 VKOKoWGjMc1ifxAfMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS9I-1vL5cy3cTa-00kibs; Wed, 11
 Mar 2026 09:33:42 +0100
Message-ID: <be9b9446-c835-4ab9-8f19-906f842414dd@gmx.de>
Date: Wed, 11 Mar 2026 09:33:40 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] cgroup/dmem: Add queries for protection values
To: Chen Ridong <chenridong@huaweicloud.com>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260302-dmemcg-aggressive-protect-v5-0-ffd3a2602309@gmx.de>
 <20260302-dmemcg-aggressive-protect-v5-1-ffd3a2602309@gmx.de>
 <47edbd3d-e681-4999-b1ad-ba7c987e3430@huaweicloud.com>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <47edbd3d-e681-4999-b1ad-ba7c987e3430@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F03s1QPXXRKCTcXKiFqMcB05PMf8MM7YBa8+RRGqAlpPatKE2hT
 3sBSiKV4uSM+mtGavrHrPbrAI13HfSX+DzL6224lvi/qrJd50N+ShZe7qPv3nAnxB3Rlwrs
 0aX769o5aYzYd6xgInnoCdZ3aqagP0kODL0sgSe/ApZkuZzD1HxIg8l7BOMSv2jLwchtc6n
 gHD0P2t9T7sDKOqKnjLoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pM1wodrJSvY=;ZCTZ2zlDF1NgZX+C07FLylQGWqf
 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
 0R86XWyU5xY9qvviyu/mHi5FMS6LRQt1Q==
X-Rspamd-Queue-Id: E371B25F7E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14757-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[huaweicloud.com,lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid]
X-Rspamd-Action: no action

On 3/11/26 02:12, Chen Ridong wrote:
>=20
>=20
> On 2026/3/2 20:37, Natalie Vock wrote:
>> Callers can use this feedback to be more aggressive in making space for
>> allocations of a cgroup if they know it is protected.
>>
>> These are counterparts to memcg's mem_cgroup_below_{min,low}.
>>
>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>> ---
>>   include/linux/cgroup_dmem.h | 16 ++++++++++++
>>   kernel/cgroup/dmem.c        | 62 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>   2 files changed, 78 insertions(+)
>>
>> diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
>> index dd4869f1d736e..1a88cd0c9eb00 100644
>> --- a/include/linux/cgroup_dmem.h
>> +++ b/include/linux/cgroup_dmem.h
>> @@ -24,6 +24,10 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_st=
ate *pool, u64 size);
>>   bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *=
limit_pool,
>>   				      struct dmem_cgroup_pool_state *test_pool,
>>   				      bool ignore_low, bool *ret_hit_low);
>> +bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
>> +			   struct dmem_cgroup_pool_state *test);
>> +bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
>> +			   struct dmem_cgroup_pool_state *test);
>>  =20
>>   void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
>>   #else
>> @@ -59,6 +63,18 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cg=
roup_pool_state *limit_pool,
>>   	return true;
>>   }
>>  =20
>> +static inline bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state=
 *root,
>> +					 struct dmem_cgroup_pool_state *test)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state=
 *root,
>> +					 struct dmem_cgroup_pool_state *test)
>> +{
>> +	return false;
>> +}
>> +
>>   static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool=
_state *pool)
>>   { }
>>  =20
>> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
>> index 9d95824dc6fa0..28227405f7cfe 100644
>> --- a/kernel/cgroup/dmem.c
>> +++ b/kernel/cgroup/dmem.c
>> @@ -694,6 +694,68 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_regi=
on *region, u64 size,
>>   }
>>   EXPORT_SYMBOL_GPL(dmem_cgroup_try_charge);
>>  =20
>> +/**
>> + * dmem_cgroup_below_min() - Tests whether current usage is within min=
 limit.
>> + *
>> + * @root: Root of the subtree to calculate protection for, or NULL to =
calculate global protection.
>> + * @test: The pool to test the usage/min limit of.
>> + *
>> + * Return: true if usage is below min and the cgroup is protected, fal=
se otherwise.
>> + */
>> +bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
>> +			   struct dmem_cgroup_pool_state *test)
>> +{
>> +	if (root =3D=3D test || !pool_parent(test))
>> +		return false;
>> +
>> +	if (!root) {
>> +		for (root =3D test; pool_parent(root); root =3D pool_parent(root))
>> +			{}
>> +	}
>=20
> It seems we don't have find the global protection(root), since the root'=
s
> protection can not be set. If !root, we can return false directly, right=
?
>=20
> Or do I miss anything?
>=20
> ```
> 	{
> 		.name =3D "min",
> 		.write =3D dmem_cgroup_region_min_write,
> 		.seq_show =3D dmem_cgroup_region_min_show,
> 		.flags =3D CFTYPE_NOT_ON_ROOT,
> 	},
> 	{
> 		.name =3D "low",
> 		.write =3D dmem_cgroup_region_low_write,
> 		.seq_show =3D dmem_cgroup_region_low_show,
> 		.flags =3D CFTYPE_NOT_ON_ROOT,
> 	},
> ```

That's not quite how it works. You're correct that the min/low=20
properties don't exist on the root cgroup, but we don't use the root for=
=20
that.

The reason we have a root here in the first place has to do with how=20
recursive memory protection works in cgroups. Note that for the test=20
cgroup, we don't read the literal min/low protection setting, but the=20
"emin"/"elow" value, referring to effective protection. The effective=20
protection value depends not just on the settings of the "test" cgroup,=20
but also its ancestors (and potentially, their sibling groups). See [1]=20
for some documentation on how effective protection varies with different=
=20
cgroup relationships.

The "root" parameter here refers to the root of the common subtree=20
between the test cgroup and what the documentation refers to as the=20
"reclaim target". For device memory there usually isn't really any=20
reclaim happening in the traditional sense, but e.g. TTM evictions=20
follow the same principle (the reclaim target is simply the cgroup=20
owning the buffer that is to be evicted).

Sometimes, precise reclaim targets may not really be known yet (or we=20
want to try evicting different buffers originating from different=20
cgroups). In that case, the "root" parameter here is NULL. However, we=20
obviously know that all cgroups must be descendants of the root cgroup,=20
so the root cgroup is a guaranteed safe value for the shared subtree=20
between the test cgroup and any potential reclaim target.

In practice, this means that the effective min/low protection will be=20
capped by the protection value specified in all ancestors, which is the=20
most conservative estimate.

Regards,
Natalie

[1] https://docs.kernel.org/admin-guide/cgroup-v2.html#reclaim-protection

>=20
>> +
>> +	/*
>> +	 * In mem_cgroup_below_min(), the memcg pendant, this call is missing=
.
>> +	 * mem_cgroup_below_min() gets called during traversal of the cgroup =
tree, where
>> +	 * protection is already calculated as part of the traversal. dmem cg=
roup eviction
>> +	 * does not traverse the cgroup tree, so we need to recalculate effec=
tive protection
>> +	 * here.
>> +	 */
>> +	dmem_cgroup_calculate_protection(root, test);
>> +	return page_counter_read(&test->cnt) <=3D READ_ONCE(test->cnt.emin);
>> +}
>> +EXPORT_SYMBOL_GPL(dmem_cgroup_below_min);
>> +
>> +/**
>> + * dmem_cgroup_below_low() - Tests whether current usage is within low=
 limit.
>> + *
>> + * @root: Root of the subtree to calculate protection for, or NULL to =
calculate global protection.
>> + * @test: The pool to test the usage/low limit of.
>> + *
>> + * Return: true if usage is below low and the cgroup is protected, fal=
se otherwise.
>> + */
>> +bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
>> +			   struct dmem_cgroup_pool_state *test)
>> +{
>> +	if (root =3D=3D test || !pool_parent(test))
>> +		return false;
>> +
>> +	if (!root) {
>> +		for (root =3D test; pool_parent(root); root =3D pool_parent(root))
>> +			{}
>> +	}
>> +
>> +	/*
>> +	 * In mem_cgroup_below_low(), the memcg pendant, this call is missing=
.
>> +	 * mem_cgroup_below_low() gets called during traversal of the cgroup =
tree, where
>> +	 * protection is already calculated as part of the traversal. dmem cg=
roup eviction
>> +	 * does not traverse the cgroup tree, so we need to recalculate effec=
tive protection
>> +	 * here.
>> +	 */
>> +	dmem_cgroup_calculate_protection(root, test);
>> +	return page_counter_read(&test->cnt) <=3D READ_ONCE(test->cnt.elow);
>> +}
>> +EXPORT_SYMBOL_GPL(dmem_cgroup_below_low);
>> +
>>   static int dmem_cgroup_region_capacity_show(struct seq_file *sf, void=
 *v)
>>   {
>>   	struct dmem_cgroup_region *region;
>>
>=20



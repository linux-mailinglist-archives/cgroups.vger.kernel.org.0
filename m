Return-Path: <cgroups+bounces-14830-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMpnM9XFt2kkVQEAu9opvQ
	(envelope-from <cgroups+bounces-14830-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 09:56:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6490F296871
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 09:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C096E300679E
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2026 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B21382362;
	Mon, 16 Mar 2026 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="jvlakwtn"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190A382368
	for <cgroups@vger.kernel.org>; Mon, 16 Mar 2026 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651412; cv=none; b=Dlts6CPffV3vmGkq3hbfiOOyBt7xEs/TX69bIX3Ey4bRKYwy2m6iSsbVideXG3XdjawqBDAv1mOeYssfD8wUcOeWAaT+kbGGQgmDTm1/j6o5HWn7diqd2cF6/PKZVCtSfICAIr2wbjlW/Li9unK5etmo+pnGBBi14baQa/H/5RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651412; c=relaxed/simple;
	bh=ORjrHol2pPJ+ZvcRBEm/kojoG4ascInD/YG2Hc/BcIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWegZE/NYs7gZPGs+zulGPPBC62iWMGQzzDjUIgJcKq8BWPSoA3jpzMplT15LoJBu56Sf2/rMuCAExhrkLmcGuPSf9QWcDNZBGpyIRWwa1Zl1owsUFTwzPkDCr8mBWKsNrWBSXKXahJfEebYO3xPrAIQMiwtKBN1Ug6BGx0rM00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=jvlakwtn; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773651400; x=1774256200; i=natalie.vock@gmx.de;
	bh=yyqVtQeCEjoypG+BjKKAA69XbPhzxMYMMxjC7ZVluw0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jvlakwtnCBmDBLucH1TVtu64sArtryicsVnEEKvk97NY5ubg5g588/GLxcfUvYlf
	 GQzwvNfGwEAoReGMPG3A169gFMyMEDwdhabN9xOeEhBsmQFDapzz9nxOlwe4hK4fY
	 Uoo44Yl5Tf0gW48blaIMmL9gehoWfaH123ZH4kci7Ql/JOPmNtAqoZXxwZPylo2IF
	 CTVwr02QVfKuwVI8otOaNfRZjve6F04bW4Vd7HyaNgPRhklZVt7Cw3tKzTdgF7Ccu
	 m3leWu6PhryYdHvfS3Ow0hsEFMiuZB2I3aKBx23wZxhPNwukkLbxEHAwCDksBlvLO
	 Kkymq4ECzQalig9lDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfUe-1vvVFQ1BX6-00AIGX; Mon, 16
 Mar 2026 09:56:40 +0100
Message-ID: <1e02c50a-c2cb-44da-8bd7-dcd5ce9ada05@gmx.de>
Date: Mon, 16 Mar 2026 09:56:38 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/ttm: Use common ancestor of evictor and
 evictee as limit pool
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-6-7c71cc1492db@gmx.de>
 <i2n5xfy5fmb2vwbh7xvyjmrz5vn35i7m7yw6uom3vmgb2l6xzm@rpgdwahd2lt4>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <i2n5xfy5fmb2vwbh7xvyjmrz5vn35i7m7yw6uom3vmgb2l6xzm@rpgdwahd2lt4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rDDcNo8PfBjWVgoSr3bVfsrbgM0yeJEIefXv/MpuO/hHE+JtOI4
 J//rC4x03eKTlmfWnou5Ysnfx8SV04EB/B0ULIvsxjzrgIqIbg/4dmJq/ADOLKAWxGyQ7o3
 AAQNQA4Hu/bPk90M6E4k7Ydkl8MRw1CtvNQTjCvI2/NdW566IVt/iSKGVygfJX1Hp6fIDd4
 TM/zhWVFR4X9r7ymPhcEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NQiHfdQLlyI=;KQvEBXaKy6DV7Uhg9vshavMrsbG
 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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14830-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,cmpxchg.org,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,vger.kernel.org,lists.freedesktop.org];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:dkim,gmx.de:email,gmx.de:mid]
X-Rspamd-Queue-Id: 6490F296871
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 15:16, Michal Koutn=C3=BD wrote:
> Hi.
>=20
> On Fri, Mar 13, 2026 at 12:40:05PM +0100, Natalie Vock <natalie.vock@gmx=
.de> wrote:
>> However, if we always calculate protection from the root cgroup, this
>> breaks prioritization of sibling cgroups: If one cgroup was explicitly
>> protected and its siblings were not, the protected cgroup should get
>> higher priority, i.e. the protected cgroup should be able to steal from
>> unprotected siblings. This only works if we restrict the protection
>> calculation to the subtree shared by evictor and evictee.
>=20
> When there are thee siblings A, B, C where A has protection and C is
> doing a new allocation (evictor) but hits a limit on L, what effective
> values to A would be applied in the respective cases below?
>=20
> Case 1)
>=20
>    L    dmem.max
>    `- A dmem.low
>    `- B
>    `- C (alloc)
>=20
> Case 2)
>=20
>    L       dmem.max
>    `- M    // dmem.low=3D0
>       `- A dmem.low
>       `- B
>       `- C (alloc)
>=20
> I think it should be the configured A:dmem.low in the first case but
> zero in the latter case because M has no protection configured. -- Is
> that correct?

Yeah, I think so too. In the former case, A hits the shortcut for parent=
=20
=3D=3D root in page_counter_calculate_protection(), so the effective=20
protection is set to the low setting directly. In case 2, they don't,=20
and since M:dmem.low is 0, M's effective low is also zero, and all its=20
children's protection is 0 as well.

Thanks,
Natalie

>=20
> Thanks,
> Michal



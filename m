Return-Path: <cgroups+bounces-14735-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAELNoIfsGmCgAIAu9opvQ
	(envelope-from <cgroups+bounces-14735-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 14:41:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4CB2509DD
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 14:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08493314DE56
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 13:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6416D40DFA9;
	Tue, 10 Mar 2026 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="Pok7/Mg8"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D8A40DFA6
	for <cgroups@vger.kernel.org>; Tue, 10 Mar 2026 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146942; cv=none; b=SJT63dXn/Qflayr7Kp2GPkdiOhjG9j4ExdGFogBE4BN5aupfg0lYNUIbi7TXfFhNEevH2uscOTqlAU2FpbW+10dP31uzkzuyB/kxi0F27HpQ6raMbY6ARaGNh8v5rmVZk74ly3+5VRx51mQ7fQmFdRm5zO2HCbaqot4nnfIc1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146942; c=relaxed/simple;
	bh=s2t4fNf2a4vyuaRwxETZr0zkU+pV+8tuMpozQt0/3+k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fjFtM7DnF1wnAUzctwXVOWnq6DVVANJaxS6r78f+C2AfuR/UZgT0pRLiHLU5VwyfZOKELM+rc1ET8wYfuxftXzp/nPL9KvDr7ceJFyRdOmN4Zw6HfM6ajYISMeS06iQrHSPWbyjcDHrRgVUqgHy8Yzo8GaY/JRv4tbCEQaGTQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=Pok7/Mg8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773146932; x=1773751732; i=natalie.vock@gmx.de;
	bh=s2t4fNf2a4vyuaRwxETZr0zkU+pV+8tuMpozQt0/3+k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Pok7/Mg8pbLEtEfFEhN+I+r0NAmDM6RME1DG8XrYVrcroO7rJw+LpYN0088IvkEX
	 QhkFv7degZKJ2XN3Tz3cuDAQnz/i60zWHjSSxtByxm0unyCgFEkWTIP6J2vJ/Zzha
	 NFVYApToGEvJEZ47auIg9e79bl3dRlAlGVw3OUj6eZGzNWBroeZzd1hRurflgUtTx
	 3u4JsS7Ox1rVzD6rHnphtAzdiA1Sj3LpeZveMxT2oi3wR5H6IsTlRctKCTqKMynYd
	 mGy4inKxpDPcnfFwQB8m+0dk7a1p6MSODaTWzUQ7mNmnUuaGPTo+t76zMCfxe672F
	 0pe2GhYIOHbJYybQGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbRm-1vqcZe04oI-00E9Oe; Tue, 10
 Mar 2026 13:48:52 +0100
Message-ID: <5b8f3944-edb3-4b14-85a6-060295e0237a@gmx.de>
Date: Tue, 10 Mar 2026 13:48:47 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] cgroup,cgroup/dmem: Add
 (dmem_)cgroup_common_ancestor helper
From: Natalie Vock <natalie.vock@gmx.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260302-dmemcg-aggressive-protect-v5-0-ffd3a2602309@gmx.de>
 <20260302-dmemcg-aggressive-protect-v5-2-ffd3a2602309@gmx.de>
 <c87a99bc-5481-444e-8841-b09d20016cfd@linux.intel.com>
 <893f4113-bbc9-4947-8bb2-a4d02d9714fb@gmx.de>
Content-Language: en-US
In-Reply-To: <893f4113-bbc9-4947-8bb2-a4d02d9714fb@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aPGHXVOrkHQEHBkWyLEwzx66sFHnlS4cuckQg5QW+8c4CmKT/28
 oqfiWg/FlYXdmiWhfMZBVJHIescnwvTyjU4V4GoRH0aykuplHjsxHyLhNJPbyfQINHDgqmC
 BHaDXhsrXeTaGBCA/OAMI5GBPj0gA8LsP/GijNMaNAhwez8AIyFsAtbSMB8VpUq12wrjJY4
 ztp6vXasHKTRb6xvPZI4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:soDGUfucB7c=;0LVekh2QGYJWLcTdIXSoK252jG8
 9jVS9TuUrJitt2HJNitfAoUtd413hXUHXGmfwbXopdoMxhICVAkQz4NBRxNbH7BqEl1Q1AVYk
 3sYgLS1xsyDDUaJhLA7AURsGJnHvCjj1NpiUzhGJhw3qF6IypCDRBYi7LtZv8XX53NOrROU2B
 9dB0XCxqlf2Jt9rUIa+iQNf+qCYmdt2pVXy+nMZ2LY6RAiS4vzaw8Twj0HbICtJn4U7zUrMFU
 q3U3ln5Hreaiqg2AbkXNtCVmKGzGOVGoqU2py4zENv5QrL44qmR9wP//sl4u1aBqktxpV/ieK
 WJb89prr304KIVG1IYZvArtawMHBoX4pfpn1jtfK8WexV+UuZMF/8I4roqD0hipuG8qNQLVe6
 U6Oim3f37IM26o4Av4Yrfh97z1OXmC3ST9BPKC2ekQp/GIPJsne81OhK/b1RPIkKV+tZkF+Ih
 MSd2dpQnvTpEJg/TvXPYD+L4/2nFmKzOxEeX2BICz1nTlmYyEDlqfM9XtUmfcb5NV4fZl0F4u
 LdtPpSrpgofHWV5rRNjrUv+yjl1oMpvkEO4H435wNKq2+eri8A29qf+iWx0028lEckN5HFHvN
 3ghkGZKLVwbCerbmXuUj0istxScXAGlLWReGhocEZf+N7R+UCdY6LWr4jhbnEiGveSFeZsxGg
 kopfEscO8IQu5wU99S36naPnUIfna0f99tqiaxL4Zr2f5LyJuLDD8Cx30pSBTJiOVkK19g5+0
 BwqSMXGF5Ouvsll8nYNMpeXjA5GGENcIZsomyBwNHy09S9guEz8GieqfNmqeBYqTLI+vachb4
 fJbvuKSBKM6hCVv4lLfCGL92pAA5NegiAqYfPJ/4fMnGkPBliLGwQ9FK1jHHEpj9EfX19oroU
 gP3wklSHtI2bHiMdPhI0klAdZ+4NswaR/SQTwSj8uV+nInARjD0vsudm0JcJ6rkbw8EOwCaDz
 X4ObyhLx7ITOV9xFc3dlqh643YV8xRdnUb6yChMcGnQlUfZSzbIzeUQxGJfkSsKezYDy9QBNz
 rw8ZOpJ7tXLdXEQBCn3WA2ZDcM0bL8Zo0x0LNDr+RwxeMDbAkgMU7v42qj3wyQ92f+axM9TdG
 Oi0TstgMsa9Ad8yTjbJHPZ3K//IuhTbD5FYGLVBd3CsVFfXJlj8AfOv4/0BX5VE0uWTPkWkXH
 CtWu7lMGNdZ5IrnCK2zA0gWb9DdLtJaxlaE6O1ufejbmSWngmwMqD/bJ/mlDe+4+d/2xGguhL
 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
 N3ayYyzr60RQt4GXtn5UNV5H195DW
X-Rspamd-Queue-Id: 7B4CB2509DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14735-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[linux.intel.com,lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gmx.de:dkim,gmx.de:mid]
X-Rspamd-Action: no action

Hi,

On 3/5/26 21:02, Natalie Vock wrote:
> On 3/2/26 15:38, Maarten Lankhorst wrote:
>> Hey,
>>
>> This should probably have a Co-developed-by: Tejun Heo <tj@kernel.org>
>=20
> Oh, that's a good point, sorry!
>=20
> Although, I think I also need to add a S-o-b tag, then, don't I?
>=20
> Tejun, just to confirm, would you be fine with that? Wouldn't want to=20
> claim people certify something without talking to them first :P

Friendly ping on this :)

I intend to send out a new version with the outstanding feedback=20
addressed, although I'd like to resolve this before I do that.

Thanks,
Natalie


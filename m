Return-Path: <cgroups+bounces-3875-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AC593ABA3
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 05:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC351F233FD
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 03:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72201CD3B;
	Wed, 24 Jul 2024 03:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tCiY9V6s"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD731B285;
	Wed, 24 Jul 2024 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721792820; cv=none; b=jHx35pOY0bfhAo9g10Sz7MGLM1Q+gOQKjD30kCTdnp1s5mzdbCU/z8XL6peYKwIBJmWcSys06ZHEfAITDcQ5hzsosndM61gC7/duPJV4WmXaHunWEOju9vtOkcfsFhSI4QuSpd5UcIQ8c2ML/1qvGRTSTuegu6w6LOBAO0bbaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721792820; c=relaxed/simple;
	bh=r1gqDA51I/Qx5mahrKge4HsiYFKz3ZMSO63/mMofe1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doE8bxA59v1uyYHr0Npkv5tCmVr6Fn44LtoNqdwO44UFx5UvVXt/VpuQ1vUruOJjmxOnzZLUNnKD1H82vK68M+Ji4tWmmCd5gTXqpOJwgzXprkBZPtXJ8UNeuW9QANwZXVa3LwuXBVR496b5RP4hK10KaMK9vrwZdgUgDl3rtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tCiY9V6s; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721792805; x=1722397605; i=quwenruo.btrfs@gmx.com;
	bh=5COIPdxbke0HcTy52KHjcp2kmblo3UOlKNse3xpAJl4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tCiY9V6s3hrCM6ftU1MPvz6KyxSNrnWYhw59LMaoSDYkI2+tdozGtGd3m+GzIjJs
	 KzC4T0qny4lErRR4ry6/vHmR82o5OGE97FBfI1VvN6yfRXCTvENepbPzIDivCcP0O
	 YP8NrBNLOfqu+i3b6Ofb81xSSv3ExIy9JCwUtr7QTPz/GjmgHJd6czgQ9ecDlNlkB
	 J0Rp+qk/J92AaexlEOnbjt2uK5Nq0Lh3LVux3e47MrHu2DaTRdoUKRK+wtuSMfTA3
	 CjNXesie7Tft9zlqwbr11NKe2BpVHiYGqmKmpevumHdyuNahmgccGD1onOUdV+vKe
	 6vsDlGkpy809pt/FeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4hzj-1s82793fHz-00whU1; Wed, 24
 Jul 2024 05:46:45 +0200
Message-ID: <b01886c2-d9ba-4797-a188-7bc1c83eef71@gmx.com>
Date: Wed, 24 Jul 2024 13:16:39 +0930
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] btrfs: always uses root memcgroup for
 filemap_add_folio()
To: Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 Vlastimil Babka <vbabka@kernel.org>
References: <cover.1721384771.git.wqu@suse.com>
 <6a9ba2c8e70c7b5c4316404612f281a031f847da.1721384771.git.wqu@suse.com>
 <20240719170206.GA3242034@cmpxchg.org> <Zpqs0HdfPCy2hfDh@tiehlicka>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <Zpqs0HdfPCy2hfDh@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cufQEFUiWyiNRwrKWsJrP956F/8BUG8pJdhep4wjcGYVs+RLB+n
 cdmZYjO3sMKOwzd2iMW1ty3VOXGVkBULK7BvajJbgSUfhLFgDAiYswNH/GLjdF6l7WZKuXg
 jclkazR2XlGaL7rl6NUk1gQvpVJ6L5q4IYBE3xXHPJC1KM38EtgmCIGU0vq5fZptN/taRrD
 VSNdhpNVexH5C1mdvbhug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:09GX5YJsgFc=;IYmFeiA0pRqhJIq0QKlGa8WF0L6
 /rfWIzI7OF2y2N9OVuOEsVOu01zlUPaPJTbHN8Hpkh0BLaA4uGhXd437WXJP99DmijdLUsIYU
 OxDpzuD2isDcU0xunAOLdvTZJY1TRPxsrUZtKfMAcWZ/tlxx9rkl/BUUURt22y8KnEJQtO8T1
 XBt0FMytSTn0NwUwF7OIUKNFpJzjWtVU1iXauFXKSKFtux6kHTRe0lSyQlEmqMssTL7ljyPtf
 dtCVslO3+XE0xtlp6nXjUd5Z8Nmqc7yJwg/KZPxxbsPyN5PIeoW8XjmMdtvEPiYdaxIi7+MqJ
 PvAAO07A6WcdwKHj0xtUdr63yRwXlTF0zzzZeN6spgYQE8wY1xUxAJZqQ2meY5lOBTGCjtEVN
 glv2Haa1dJwDzgZ+g8nGFiKkTslsXnJz8IlFEGL8STZNpKNv1VXAV658xfMbHxulutnaGUhIk
 77kc8y8q74Vj9x4zIHZ2i8uoYp07F+DYy7WUb3+vjxCPatvlrPpxJjK22O/UgqqCxgXBWMVK/
 Ku6SXXfuZNH8aSmWu3945eDIXa7dVXs1NLaZdAfymPZRPJgM7zqtlxjWlwmZlG7tSqnqRpaG8
 ad2G4uIyaaEPqhKk8PcF9hnw9i2vhZDAu/zeMe298XDq4yhnhImmBFb+V8yuUnxEhxWOgW8Y6
 YQeSSyl5Q0R+lsbWUjOBkSC5Cj5pRs+qEsxUpb/bKTogie2R7vMGzJm1IulT1UxybegqVQU9o
 E70U5mhgbI2cAh+Byj1GeNsI2sNa71+LhjJx7ko+/SqI/I7+Dn69Ukgmp+DZALz0sg/prcirQ
 WtGitbWf/d8fpGsB/P3cPuaw==



=E5=9C=A8 2024/7/20 03:43, Michal Hocko =E5=86=99=E9=81=93:
[...]
>
>>> +	set_active_memcg(old_memcg);
>>
>> It looks correct. But it's going through all dance to set up
>> current->active_memcg, then have the charge path look that up,
>> css_get(), call try_charge() only to bail immediately, css_put(), then
>> update current->active_memcg again. All those branches are necessary
>> when we want to charge to a "real" other cgroup. But in this case, we
>> always know we're not charging, so it seems uncalled for.
>>
>> Wouldn't it be a lot simpler (and cheaper) to have a
>> filemap_add_folio_nocharge()?
>
> Yes, that would certainly simplify things. From the previous discussion
> I understood that there would be broader scopes which would opt-out from
> charging. If this is really about a single filemap_add_folio call then
> having a variant without doesn't call mem_cgroup_charge sounds like a
> much more viable option and also it doesn't require to make any memcg
> specific changes.
>

Talking about skipping mem cgroup charging, I still have a question.

[MEMCG AT FOLIO EVICTION TIME]
Even we completely skip the mem cgroup charging, we cannot really escape
the eviction time handling.

In fact if we just skip the mem_cgroup_charge(), kernel would crash when
evicting the folio.
As in lru_gen_eviction(), folio_memcg() would just return NULL, and
mem_cgroup_id(memcg) would trigger a NULL pointer dereference.

That's why I sent out a patch fixing that first:
https://lore.kernel.org/linux-mm/e1036b9cc8928be9a7dec150ab3a0317bd7180cf.=
1720572937.git.wqu@suse.com/

I'm not sure if it's going to cause any extra problems even with the
above fix.

And just for the sake of consistency, it looks more sane to have
root_mem_cgroup for the filemap_add_folio() operation, other than leave
it empty, especially since most filemaps still need proper memcg handling.


[REALLY EXPENSIVE?]
Another question is, is the set_active_memcg() and later handling really
that expensive?

set_active_memcg() is small enough to be an inline function, so is the
active_memcg(), css_get() and the root memcg path of try_charge().

Later commit part is not that expensive either, mostly simple member or
per-cpu assignment.

According to my very little knowledge about mem cgroup, most of the
heavy lifting part is in the slow path of try_charge_memcg().

Even with all the set_active_memcg(), the whole extra overhead still
look very tiny.
And it should already be a big win for btrfs to opt-out the regular
charging routine.

Thanks,
Qu


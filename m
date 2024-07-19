Return-Path: <cgroups+bounces-3824-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784BE937DC7
	for <lists+cgroups@lfdr.de>; Sat, 20 Jul 2024 00:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E1C1F21BD9
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 22:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C40148848;
	Fri, 19 Jul 2024 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AmPrHers"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B4F1487C6;
	Fri, 19 Jul 2024 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721427103; cv=none; b=cwOLeH8uMPG9nBOWZmlOt8hESSULuyCa78fdBtERjO5wzyQT4dUAlezd6kX4itCmLPapTpINwKE1FIbIbnj+bXfWkwM19hEw9TSIEtpQPmyMVNcpDmJRzneDs80DaI/UZxfzfyg5McTWpAHaq0omHn3MTK9rEqIP3bA+l9Y+tvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721427103; c=relaxed/simple;
	bh=k62itpuy/WU6dh5tPyJKZbJAQfl+m0mGmnVrVifGt6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7uaxbTXYNUNsExfuvTI7AH+9oY10QK9UOj2VKdaDGN2YDXfV1bhJFIxCYAh6d1IUp1ZdFPG50SxyoydQJMwy9vmiV6LUy0I/rEGoL1eAzTDaYACFzWElXlurdrOASin4yOJ543GSG9oLTyY5dV3/pR2nzKvQmr5zIOTYzbUfr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AmPrHers; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721427086; x=1722031886; i=quwenruo.btrfs@gmx.com;
	bh=ZuSxAnc/rQvOJnLFXNjkp1Fn2JaFckf83jiMCcZh4RQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AmPrHersyb/pJHomWq9wlHhR2DTM553XhKMcAMoWerYkj/oS9Rv80fY+whLbbIpw
	 I4DlpPvpvbmdq3z9witaSxikBCVgQebFWBPZg16rHFTr2jxVCOBysM+gv/liRZFgA
	 Nn22Z30fHzDy2nvoa2B3F39O6cim/Ku72LrPbtjl/1GTnAj3nkf9YnW15tWTo7pbV
	 t5HPDoJgXzaKUbxyjcN6vdBaG5KU3OdzEV8tKufRFtCzB20TUqBo8/R+gI4eD+lTc
	 XrnCQscF4spo3404FblENhIRsPFhqhIksQzVjKs8omUo+P7UZ0mHUsu+FeZYBRhUO
	 btsmZbXpp1GnnTqoDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAwXh-1sbmWC1K7l-002vHK; Sat, 20
 Jul 2024 00:11:25 +0200
Message-ID: <9202429f-e933-4212-a513-e065ba02517a@gmx.com>
Date: Sat, 20 Jul 2024 07:41:19 +0930
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
X-Provags-ID: V03:K1:xJGJ0OsWRSLgXs7lhWWAbKtmZhh7MyDQHINvVBiRPu7n0XsdrwD
 nH7WByJmcFCofShCQQjN1Cw7GhoYe1Ii9FiLfLGqL/o8RjeI3ew3t63KVpZDVZfDNCpyuda
 n0vgvgvTJD8lnmtg7Sw097xp9ZqK5zOGfvtg/y4SU26KahS/MDWd6QXZ2YaOS9a1ujkOcDK
 2G4CWVLLQVEyfhF54oMag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L5D8nlnwTk8=;h0yJEecA5TFY/TlfCud3gFhyPzL
 ZdENGqyjhdUy5Kwn0bg64/E/5N/9KKJIF4aO75NjLq+Yvo5f1/shsICSCSF8hHopPBTPjU+xo
 5BA5mLgv88BrzeXxjtdryth3u5pIfu2cRtgZAYIUs5/wLfxKU8ijf6rwVVNQ2NyNCmvTXNPel
 iK7DNQiWJJYDHHoyO2/cBgLnPZBBkMXf25nHtA76PkwpchL094ZLYjQt2QBnvLtqMribuuAQC
 CTzox6EynC9vAoPcR4pUGQHAJgjTpOiMbNNa2kjXxnFQaw2MbcF5I6jZ1xIQ3PxsBnb90Y3Oi
 t9d+vCxvHOTh8WtCQnNJ4NAXlPInYFoNvM5DlS8I2aDBSzv4/xkNrEZmWDTq4sT7RB39UPhvm
 Min5OUuqOhOnUiEG2kW/8HWuCtsJOF4kiFKG6wtZmR9Q/GrkRiIBbGtP4Zr97pcCZwgNGCmUU
 dQiITcZa1kcCdL1jOLTiMsMbThifhVbkeaqoZIp5fOpufqKVDvj92Azd8zJBnnO7jOZwMXqQ1
 MBRnNe5OoxQw+AD57adik9jd4ZRaYOndZe4nBdxVKj4BxX25+uhJRYSJYTzyRy/xISplwjK1F
 wCddAeGBVUcdEjd/DYlpt/o4WWJXs03o/4UEECpl85jAdLCz2vLq5jDeibNP6SYkdR8PAq2ns
 arvC9tMez5b6k43bKCoETQjmCxyuXq0LZcxdN5EgRKKO37I0Q3CXlD1bzwKnP3/qR2LXeYLAF
 K3/hB9k4Vsyqy33ksRITYJ2y6pNf8JpLjxbWHusDijkvHBNfAArsoIOWz3baVdZEAoIpZAEtN
 h9lQyCizy+Fp3jcU2pmYFOdg==



=E5=9C=A8 2024/7/20 03:43, Michal Hocko =E5=86=99=E9=81=93:
> On Fri 19-07-24 13:02:06, Johannes Weiner wrote:
>> On Fri, Jul 19, 2024 at 07:58:40PM +0930, Qu Wenruo wrote:
>>> [BACKGROUND]
>>> The function filemap_add_folio() charges the memory cgroup,
>>> as we assume all page caches are accessible by user space progresses
>>> thus needs the cgroup accounting.
>>>
>>> However btrfs is a special case, it has a very large metadata thanks t=
o
>>> its support of data csum (by default it's 4 bytes per 4K data, and can
>>> be as large as 32 bytes per 4K data).
>>> This means btrfs has to go page cache for its metadata pages, to take
>>> advantage of both cache and reclaim ability of filemap.
>>>
>>> This has a tiny problem, that all btrfs metadata pages have to go thro=
ugh
>>> the memcgroup charge, even all those metadata pages are not
>>> accessible by the user space, and doing the charging can introduce som=
e
>>> latency if there is a memory limits set.
>>>
>>> Btrfs currently uses __GFP_NOFAIL flag as a workaround for this cgroup
>>> charge situation so that metadata pages won't really be limited by
>>> memcgroup.
>>>
>>> [ENHANCEMENT]
>>> Instead of relying on __GFP_NOFAIL to avoid charge failure, use root
>>> memory cgroup to attach metadata pages.
>>>
>>> With root memory cgroup, we directly skip the charging part, and only
>>> rely on __GFP_NOFAIL for the real memory allocation part.
>>>
>>> Suggested-by: Michal Hocko <mhocko@suse.com>
>>> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/extent_io.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>> index aa7f8148cd0d..cfeed7673009 100644
>>> --- a/fs/btrfs/extent_io.c
>>> +++ b/fs/btrfs/extent_io.c
>>> @@ -2971,6 +2971,7 @@ static int attach_eb_folio_to_filemap(struct ext=
ent_buffer *eb, int i,
>>>
>>>   	struct btrfs_fs_info *fs_info =3D eb->fs_info;
>>>   	struct address_space *mapping =3D fs_info->btree_inode->i_mapping;
>>> +	struct mem_cgroup *old_memcg;
>>>   	const unsigned long index =3D eb->start >> PAGE_SHIFT;
>>>   	struct folio *existing_folio =3D NULL;
>>>   	int ret;
>>> @@ -2981,8 +2982,17 @@ static int attach_eb_folio_to_filemap(struct ex=
tent_buffer *eb, int i,
>>>   	ASSERT(eb->folios[i]);
>>>
>>>   retry:
>>> +	/*
>>> +	 * Btree inode is a btrfs internal inode, and not exposed to any
>>> +	 * user.
>>> +	 * Furthermore we do not want any cgroup limits on this inode.
>>> +	 * So we always use root_mem_cgroup as our active memcg when attachi=
ng
>>> +	 * the folios.
>>> +	 */
>>> +	old_memcg =3D set_active_memcg(root_mem_cgroup);
>>>   	ret =3D filemap_add_folio(mapping, eb->folios[i], index + i,
>>>   				GFP_NOFS | __GFP_NOFAIL);
>
> I thoutght you've said that NOFAIL was added to workaround memcg
> charges. Can you remove it when memcg is out of the picture?

Sure, but that would be a dedicated patch, as we need to add the -ENOMEM
handling.
I already have such a patch before:
https://lore.kernel.org/linux-btrfs/d6a9c038e12f1f2dae353f1ba657ba0666f0aa=
aa.1720159494.git.wqu@suse.com/

But that's before the memcgroup change.

I'd prefer to have all the larger folio fully tested and merged, then
cleanup the NOFAIL flags.

>
> It would be great to add some background about how much memory are we
> talking about. Because this might require memcg configuration in some
> setups.
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

I'm not 100% sure if the VFS guys are happy with that.

The current filemap folio interfaces are already much concentraced,
other than all the various page based interfaces for different situations.

E.g. we have the following wrappers related to filemap page cache
search/creation:

- find_get_page() and find_get_page_flags()
- find_lock_page()
- find_or_create_page()
- grab_cache_page_nowait()
- grab_cache_page()

Meanwhile just two folio interfaces:

- filemap_get_folio()
- __fielmap_get_folio()

So according to the trend, I'm pretty sure VFS people will reject such
new interface just to skip accounting.

Thus the GFP_NO_ACCOUNT solution looks more feasible.

Thanks,
Qu


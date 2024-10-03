Return-Path: <cgroups+bounces-5021-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D17B98EB1D
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 10:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBE51F22D49
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 08:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2179B136E0E;
	Thu,  3 Oct 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="IP4uwj6s"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E0C131E38;
	Thu,  3 Oct 2024 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943122; cv=none; b=T7dHAJlhBf25MfbdHs87W1sSlLumAVfLDEjbufJ8lCRG2vCVTOdNZCjTW95W5QXcaRazbC7POHBHmMRuIN0a3KwlkbrKQXSMk80PVXDFGlfIN/tQwQlLiFPCNm4BYuBuLPn8qdw2NTBfimfP1mHhnEEqMej7q32acM22JTp4sdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943122; c=relaxed/simple;
	bh=ENyaE3t7cCXyN6WULDY6v3rh4JS5RE5XB0Pg77rgMR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kACFUowmIwTuniT6RMVBqAeY8Eofo9iC/ceOpjNXvX8+iXKOnKAbh/sdTqnHom6u37WiFTfBm7ivItI5lK7JJmmJYzrvK/33PwkZlJ/1eNeDWvntnYyc+rMR2iQjR2RxKKLnMr24rPiFbG+BajFTfcEVqLSTRCk+7MM97+zPpQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=IP4uwj6s; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727943092; x=1728547892; i=quwenruo.btrfs@gmx.com;
	bh=a1Fzgkit5lvWIHytOqDhEjkY3yDGZB+SfoLZDv4mfMY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IP4uwj6sAhDMIVEl3Iv0GrkJ5ajpEEnh+BfVV9s9AiO4hziC7WokAQ82mwmtenGY
	 H6ZnB6rFirs5tOOduFJDtMvFqcJkI/y894caK8c8aL9VZQGJKArsCod3yB0XvNZhX
	 Wb8A9vjp8yMKDaVqz9s/nbjL7plI7yfkNJMonEPorlVPQ1UWQTyIOSMZ41jSmkqim
	 ix+pUN5ZLnkyH4JeQ8N5BNsY4v3XWgsWwkFXiVnpZ/Fa5iI8so368gnfjbfToOOpH
	 akN5aRBz96yIIs7stShNIDFGBXNoDcCuoshH55CQ1IeFI2dGkY50jgEywLHqzd5Uz
	 jNb9XaYxHhgJFdOq1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWigq-1sPEPD216G-00Ua8t; Thu, 03
 Oct 2024 10:11:32 +0200
Message-ID: <b43527db-e763-4e95-8b0c-591afc0e059c@gmx.com>
Date: Thu, 3 Oct 2024 17:41:23 +0930
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
References: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
 <Zvu-n6NFL8wo4cOA@infradead.org>
 <5d3f4dca-f7f3-4228-8645-ad92c7a1e5ac@gmx.com>
 <Zvz5KfmB8J90TLmO@infradead.org>
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
In-Reply-To: <Zvz5KfmB8J90TLmO@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dnsQgpasv6erigLeI2k2mH9d730EYfl9W7PI31gNxv9EHN5LGq4
 oHrIYvLzPL4C718bYa+80VbhcM6WZN5A9z+0d3lJUI/MKslVDLi9YgO81BEWGLqzWorLhbz
 W3WmvM48VXeHlwK8zgCrvP1hF0ILsdBkkuL5lJA5sb4ETAIxIwx5l21QKTj64KdJH1VoSjv
 cM6DKwBtlz4WMBpZ2yUvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hRxHCDcwPhM=;d4G780tRx9bxmkismLoRd7wZQx9
 npeWQW/WU/ovwOZKnzAHhF6+jXNXASkyVtY4MZ1fPzUsWXl7L6PYLcACcrACoWeMlY4x40ADx
 1+RcKb8zM0U1ubMl3PdpAZekDbBffcGlZXa1j3RvTbRPG11/DJ5AgBtAjUiKJlDnXb0UO/4xl
 hbqz7aJx4YjtjdS3++IcHP+MGqVNRl+Y1BcgG6v/Ac/nrYfGI4TorUsZmYgD+R/CvYIVhJrk+
 j4A5KHbW4u88sVaXjO6sGRX1IW8eUzXYrndFMkoKhzQaK/TUcYTdy6Wke7mRDk0H01lmydE1f
 DaDURS3dP9YXe04dTPh/c8i/nN7gkCqDt6zZFpqRc8AVZ6+LwJvFCbA39m2H3bY26m94eA5qc
 0tyai0SrBlXAA8d0E873CsZWf16uCunPHGykUvrfVNBqjR5KI1Rl4RGLJXoe3XpNNnC2rljFQ
 VPHkd4TZ2xeW2umO/0kPDlugGRrrBdtWlbmzOkZlmnUAsLionZI6xwfEtaG51gyBHAhLUu/7I
 pADtBunW4CeIB8pWf3nKk6CFBJDnOpsQ+4I8p3OQZKRxZH9DnrEyRhxOUAvkkPPEJwuCP2Np6
 MqBM/O9wjNNqO5w2XrUTFQbw078k3JYhyab92sit0e7OJgMXTH/Y7iz2szWyYYk8moj01noq0
 sSyu8gP+BaROlM0mdy3CBanx6T3oHFmGPMfScEDnhH9s/R8HRmHbfwejMJksYl7O45sB6NW0g
 y5otAUpr89OKuO3JI+IGuz2zO2ae6edEewVvSg3QAmD/Tr2fyGrg6T16R+2t9GI/Ngl6M44HV
 WS7knCBHkk2/M9v+HcUTIqzQ==



=E5=9C=A8 2024/10/2 17:11, Christoph Hellwig =E5=86=99=E9=81=93:
> On Tue, Oct 01, 2024 at 07:10:07PM +0930, Qu Wenruo wrote:
>>> This looks pretty ugly.  What speaks against a version of
>>> filemap_add_folio that doesn't charge the memcg?
>>>
>>
>> Because there is so far only one caller has such requirement.
>
> That is a good argument to review the reasons for an interface, but
> not a killer argument.
>
>> Furthermore I believe the folio API doesn't prefer too many different
>> functions doing similar things.
>>
>> E.g. the new folio interfaces only provides filemap_get_folio(),
>> filemap_lock_folio(), and the more generic __filemap_get_folio().
>>
>> Meanwhile there are tons of page based interfaces, find_get_page(),
>> find_or_create_page(), find_lock_page() and flags version etc.
>
> That's a totally different argument, tough.  Those functions were
> trivial wrappers around a more versatile low-level function.
>
> While this is about adding clearly defined functionality, and
> more importantly not exporting totally random low-level data.
>
> What I'd propose is something like the patch below, plus proper
> documentation.  Note that this now does the uncharge on the unlocked
> folio in the error case.  From a quick look that should be fine, but
> someone who actually knows the code needs to confirm that.

The interface looks good to me, especially we completely skip the
charging, which is even better than the current form.

And since Michal is also happy with this idea, I can definite go this path=
.

Just a little curious, would it be better to introduce a flag for
address_space to indicate whether the folio needs to be charged or not?

Thanks,
Qu
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 68a5f1ff3301c6..70da62cf32f6c3 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1284,6 +1284,8 @@ int add_to_page_cache_lru(struct page *page, struc=
t address_space *mapping,
>   		pgoff_t index, gfp_t gfp);
>   int filemap_add_folio(struct address_space *mapping, struct folio *fol=
io,
>   		pgoff_t index, gfp_t gfp);
> +int filemap_add_folio_nocharge(struct address_space *mapping,
> +		struct folio *folio, pgoff_t index, gfp_t gfp);
>   void filemap_remove_folio(struct folio *folio);
>   void __filemap_remove_folio(struct folio *folio, void *shadow);
>   void replace_page_cache_folio(struct folio *old, struct folio *new);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 36d22968be9a1e..0a1ae841e8c10f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -958,20 +958,15 @@ noinline int __filemap_add_folio(struct address_sp=
ace *mapping,
>   }
>   ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
>
> -int filemap_add_folio(struct address_space *mapping, struct folio *foli=
o,
> -				pgoff_t index, gfp_t gfp)
> +int filemap_add_folio_nocharge(struct address_space *mapping,
> +		struct folio *folio, pgoff_t index, gfp_t gfp)
>   {
>   	void *shadow =3D NULL;
>   	int ret;
>
> -	ret =3D mem_cgroup_charge(folio, NULL, gfp);
> -	if (ret)
> -		return ret;
> -
>   	__folio_set_locked(folio);
>   	ret =3D __filemap_add_folio(mapping, folio, index, gfp, &shadow);
>   	if (unlikely(ret)) {
> -		mem_cgroup_uncharge(folio);
>   		__folio_clear_locked(folio);
>   	} else {
>   		/*
> @@ -989,6 +984,22 @@ int filemap_add_folio(struct address_space *mapping=
, struct folio *folio,
>   	}
>   	return ret;
>   }
> +EXPORT_SYMBOL_GPL(filemap_add_folio_nocharge);
> +
> +int filemap_add_folio(struct address_space *mapping, struct folio *foli=
o,
> +		pgoff_t index, gfp_t gfp)
> +{
> +	int ret;
> +
> +	ret =3D mem_cgroup_charge(folio, NULL, gfp);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D filemap_add_folio_nocharge(mapping, folio, index, gfp);
> +	if (ret)
> +		mem_cgroup_uncharge(folio);
> +	return ret;
> +}
>   EXPORT_SYMBOL_GPL(filemap_add_folio);
>
>   #ifdef CONFIG_NUMA
>



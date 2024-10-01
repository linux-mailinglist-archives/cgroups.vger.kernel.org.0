Return-Path: <cgroups+bounces-5001-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF2498B87B
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2024 11:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53912282388
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2024 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8B19DF7A;
	Tue,  1 Oct 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZAIcb04j"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE319DFAE;
	Tue,  1 Oct 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775639; cv=none; b=aeVz2gMZwURqja9m6Ip1MxIyKleMvMzWhb/e4J/XZVSTHpA5n3l4kYISZEs13oh3HNqtxknX4gpVwofDH6+eT2l/dwhvQAkD4vk3v+psQHyKr8+hUx6I4vGip9Dbe9xL37gwCHUOer0B+VUWUwSTizhHaeCMFVMzP1DN3cgV6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775639; c=relaxed/simple;
	bh=utOuGAHDzZVUxbLWXYQmG5SmNid8OI+IWix3DyOXjcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnBtqqQtsiWHURpDC8bEazHws2PJwnejGfvHuwwNl0RjmaWcnB0XlVvEfm8HFZoc5FZ5ebagRsrfwHhlYmZ2/Ji/j/13i5KQGxJFOugsG9Y1m9uezVo5HdCjYEh+hIfrWupEpM6iP3LBvETv2kf1C/9qQ1qM5KrieUMSryJ45Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ZAIcb04j; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727775615; x=1728380415; i=quwenruo.btrfs@gmx.com;
	bh=IfGAGOIYYuqBWkCtoXPPwiYwgrjz3A5ckBd5Hy1y424=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZAIcb04jWb+rVwj+5EktR9OwhNmL4WOI6rLPdkV3+nHoTzxDVuxIzhKM8xbJQNI0
	 ysnVrfp3TP0/LbuLx+ygOa9lvA0GRG1cp5bFMslpzA0dQd60dBrLtph2pmsYSc+8C
	 2of7u7/Ob1ayB34xjeh8e69qtUnSYLYdKnK4drzDNUthkuT0+NJY/tExvnIIi3DUL
	 EHXi7tzPHRVkJl+CAbM77gIFlPH9I79xWdiSiQuoE1WSXyzsHvhzEnSlFlyHFd2y8
	 d1cFtQTCSixkNgxeaIA9ad3UfqFDDSRyMALc+mg0wNzK37TZLk3+jQJD2TYB3xGad
	 Y9Eu12/BBSEJR3bvlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6bjy-1rpmPQ3N30-012G4f; Tue, 01
 Oct 2024 11:40:15 +0200
Message-ID: <5d3f4dca-f7f3-4228-8645-ad92c7a1e5ac@gmx.com>
Date: Tue, 1 Oct 2024 19:10:07 +0930
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 akpm@linux-foundation.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
References: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
 <Zvu-n6NFL8wo4cOA@infradead.org>
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
In-Reply-To: <Zvu-n6NFL8wo4cOA@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:czho8s/wZSHZPASACleHkjuRw7Wwzp5kzCYw05Fv9AKZI3BCtlD
 b+LqTUtHn+jTBCE6Q4mXyrXkiLX+NYg+xNM8d86zcabWqPNcX4NzELNKyKqQ0zKzTRTDfS4
 X3JXGUGTexiwyFWVVgmVch29YrCzC1IA92EdON0kDGwqTdSvYlK0URnx2j9COB+empTFr7n
 8zURrUqeBedUehXf0ZchA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JUlayBcxy2Y=;XT9Ty0sIEGRbzmS80ksymiBMi7D
 jOwwhQY775AE0Ri1rCK9shB1sGEg0x0dYcfrOUFiL+yjByLdKk6hLFsoDox79lqSe+2i0M6Z6
 aEWUI67EzPyh/yA39FbGUgN5Xwt8Uh0XhvDSB3u4a39mAWPdBC9Ka8m/AGd4MDJlL4lXpYFvV
 7gVeCUKitmQ6TcvD9pHa8sQoEUA79kX8WDOgsrZAdg6fZj6hc/iDnG8mRdhA5ZAYhot4TcRh0
 e+cPuzjSGHXu6vtztFEfacGaUOgIFQQ0guMjB4/RZSldE7Gz9Ug0wk/ZLlJSiJ6lst7So9PFd
 UhYc6CL8+D6vKXuY4vZZrwaQmeumBDfYiBjiMQan1FbtPq3sNvqCKoaxloXPDwCfeoVmD4bEO
 V011JZ6BRjcer2ekEPm/3ATdsrUhDHbIg5quf54Ziw/wj4w+jsuOlRt6ffmiCfirAjp4Hz8LC
 4QkT0Z4mA2132+xYG2ZyPFSxmwbV2bTsZ8EmCNStHqlIi5HRTKU9g5JXLBYKaBOQz07yVHIxm
 CpxcfDwIEh/8KcYv/3rZ0IhyLbqM6RmquK8nArdmeWD7vKzynrx14TVeO6KTzqJWrnzRLI/q/
 BfbSA6tIZB6kejCJlNJUU9gkHrzdivWUzM+MFeb8VIWV0EtZne+ILdZbn2XpAERfKpEdN+zzN
 kj0t5+3zOr4xqOHjG17zHSuyQduq5b5SwL5pPUaIS4N03V/EF7ewEpof8mxRGA/VgHlk1u2yd
 sLnbsfkyvi6DynrSAD+Vx8EGrnvqIyNoYJDqCL8D76mTemT+MJIRGXWXqfcsCPQTCc8BiB9h6
 WwYTmAEtBWs4WTYcd2lmR7oA==



=E5=9C=A8 2024/10/1 18:49, Christoph Hellwig =E5=86=99=E9=81=93:
> On Sat, Sep 28, 2024 at 02:15:56PM +0930, Qu Wenruo wrote:
>> [BACKGROUND]
>> The function filemap_add_folio() charges the memory cgroup,
>> as we assume all page caches are accessible by user space progresses
>> thus needs the cgroup accounting.
>>
>> However btrfs is a special case, it has a very large metadata thanks to
>> its support of data csum (by default it's 4 bytes per 4K data, and can
>> be as large as 32 bytes per 4K data).
>> This means btrfs has to go page cache for its metadata pages, to take
>> advantage of both cache and reclaim ability of filemap.
>
> FYI, in general reclaims for metadata work much better with a shrinker
> than through the pagecache, because it can be object based and
> prioritized.
>
>> [ENHANCEMENT]
>> Instead of relying on __GFP_NOFAIL to avoid charge failure, use root
>> memory cgroup to attach metadata pages.
>>
>> Although this needs to export the symbol mem_root_cgroup for
>> CONFIG_MEMCG, or define mem_root_cgroup as NULL for !CONFIG_MEMCG.
>>
>> With root memory cgroup, we directly skip the charging part, and only
>> rely on __GFP_NOFAIL for the real memory allocation part.
>
> This looks pretty ugly.  What speaks against a version of
> filemap_add_folio that doesn't charge the memcg?
>

Because there is so far only one caller has such requirement.


Furthermore I believe the folio API doesn't prefer too many different
functions doing similar things.

E.g. the new folio interfaces only provides filemap_get_folio(),
filemap_lock_folio(), and the more generic __filemap_get_folio().

Meanwhile there are tons of page based interfaces, find_get_page(),
find_or_create_page(), find_lock_page() and flags version etc.

Thus I think something like filemap_add_folio_no_memcg_charge() will be
rejected.


Finally, it's not feasible to go with a new GFP flag either.

We already have __GFP_ACCOUNT for memcg charging purposes, but for
filemap_add_folio() even if we do not pass __GFP_ACCOUNT, the memcg will
still be charged.

It will be even more ugly if we add a __GFP_NO_ACCOUNT, and such attempt
is already rejected before IIRC.

Thanks,
Qu


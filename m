Return-Path: <cgroups+bounces-3823-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490B0937D91
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 23:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720BE1C2139C
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 21:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493C014885E;
	Fri, 19 Jul 2024 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lrmPSCYD"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5111B86EC;
	Fri, 19 Jul 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721426342; cv=none; b=MY4vnzo9MAwIEe7QkG0/gO3eSREn1zp4kNyx3lI+nSkJycfe+UCzdO6H5eze788w72zXvGXAAtzeHOvtip5PsQKDmoqXkkB33rfu/dm3H6T5vEiFsJrHTMhqjVweA9aO2yVlktfOngybHEMEqrzOH/sP+wm1tQtTBd92u/7ZvvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721426342; c=relaxed/simple;
	bh=Ey0LPAaCK2zc899oZ6nd5JXfenvs8mTMm4+ql0q86h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNOLak6JZEAKD4/XG/9WZmKzxayMsYLsvSakpPVmW+HRPI5xXe3O/51mBf4LMgi2zgduHia+ahbbYb7IxgHnSH7HkIoahFXzevGm5p0+H1LD4tN3SmonwQue7SSqsMBxUlQtI2um/4QMy7SFvIATDYjqQN5nlgX1NFQW+wa7t8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lrmPSCYD; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721426331; x=1722031131; i=quwenruo.btrfs@gmx.com;
	bh=Ey0LPAaCK2zc899oZ6nd5JXfenvs8mTMm4+ql0q86h8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lrmPSCYDNKKSHUNbe4ktxjScf/FUIiVBLCeu5WjkiooTVVSXKRh+B/mpSbqi3bqB
	 W9heaPWPeVw7XuS3+vwGum43SChcqpkyAwIPKI/nshL0D03ctl7ySed1dCX4hdvsv
	 O2+rDAChAnzuCu2hadnsQ1aNsrlz5qKDaQuHM9rddGKSx/kqx8na4Pzk+qsbjHXph
	 HVYxI0WBksnXBuJlC4dBa1Y8wZxHs27aHZUwTgCzEZdd1PJ0CD2AjascxxyP582xZ
	 FnwSwPQ98j8WjoILUnt6/6vNaE0zO5KRpcBeJOi7X+IeMN6P9z/xC49brJLacQf6/
	 Qdndc3/Cw4dWsvY0Xg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQvD5-1siuGj3Svn-00S24k; Fri, 19
 Jul 2024 23:58:51 +0200
Message-ID: <54b7d944-37eb-4c3f-a994-13212aa3ed13@gmx.com>
Date: Sat, 20 Jul 2024 07:28:45 +0930
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] memcontrol: define root_mem_cgroup for
 CONFIG_MEMCG=n cases
To: Michal Hocko <mhocko@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org
References: <cover.1721384771.git.wqu@suse.com>
 <2050f8a1bc181a9aaf01e0866e230e23216000f4.1721384771.git.wqu@suse.com>
 <ZppKZJKMcPF4OGVc@tiehlicka>
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
In-Reply-To: <ZppKZJKMcPF4OGVc@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+rwUS6pqYSlruSzT3uI2slOzqyDeM7QHQ+J8pURnGMaSZ5Gz0ct
 FC5zpWqqOpXSe82Wu5LnUcHZxz1OwdDb/REVPCRE7oQtfWSRLwzkKpYFzNo7ZM3mrPbLPX+
 eLYl0NkaSfUJzkyeXotBVxfwD5c00K4CNAj0zvqdqu6tz9z+2cehm6WWcKPALJW32d1d224
 BP42f0OLwAW2qN8Ne1JfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GLm5/WW0PR0=;k4TBVCug4O1/KN7+3QMogE2fpN4
 NUsQ4XyPaBlLSJKYduISod1VJoBJzhKtn0rO0mVMKUeVZZuXgstfIG+OCpsanfcufvkwKUK0D
 3TKFShSU74B/zEAXsTS4xwS+aNtmLTPfBoptTvX050jRlfhL1A1ImidqFAiJhLWK/zCby7hOk
 a1z7axN6OWNS9OCnRUGPoZ8P7RALstGs1m/MwcKDWsinzCNw2Fpd7Hg9ONXXEWK7yQPuLJJeA
 rfIcH3f5UwkmwPQ7Ec3bMgvPDMXjG3Ys+XsG3ygPX1McZYGST4wiXWltNSxwlDVXAg9MvBUF6
 a1Cz3Ilwyy3dhfal6CrcMqDB+h5Tdnz3p16I3aVUnletYLE2QgVtVoXFtTPNNJ6wBz+3khFKu
 9hT3cnIIB+fcMrWUYbgsVIdkvobTZy105vXYL8zf5zD7k63AIpC1tDHgJrw4EAyoNNuGS2v+q
 WnzKyqWJsYUe75OLCigZDVuiZkUmwunQ8p4z90bFUkWq9ZR2GvJjUcDOypxtc3cKZAY9FavdR
 uVciWuBP/cEXIPJ0Oj6pmm0oPy2J+wmi/cLIdOSA/KWZ70xOb7JhaZ14xBjyvis4mJ9qd1buX
 X43JblFqHCRC0AyAw3ObzNCuiKD/hEGilwGS3ZTDJHp9knsMc4FsKVCAo48MZ4wzqnfzgc85s
 P234k7P3cad6aJdP2kBF8Lz6N0gytUIEidTVpODcQTW3VGKL9CBd8whcoEH52f7lSUed4yENh
 je7V6lbN7vOgzGj/1e72so5FAJ1cNMY30V86PVFip2HW5l6UitK32RuKOutpIP3DO/p02bXSd
 dhnRCzErwjaROir78/5fC20w==



=E5=9C=A8 2024/7/19 20:43, Michal Hocko =E5=86=99=E9=81=93:
> On Fri 19-07-24 19:58:39, Qu Wenruo wrote:
>> There is an incoming btrfs patchset, which will use @root_mem_cgroup as
>> the active cgroup to attach metadata folios to its internal btree
>> inode, so that btrfs can skip the possibly costly charge for the
>> internal inode which is only accessible by btrfs itself.
>>
>> However @root_mem_cgroup is not always defined (not defined for
>> CONFIG_MEMCG=3Dn case), thus all such callers need to do the extra
>> handling for different CONFIG_MEMCG settings.
>>
>> So here we add a special macro definition of root_mem_cgroup, making it
>> to always be NULL.
>
> Isn't just a declaration sufficient? Nothing should really dereference
> the pointer anyway.
>
That can pass the compile, but waste the extra bytes for the pointer in
the data section, even if no one is utilizing that pointer.

Thanks,
Qu


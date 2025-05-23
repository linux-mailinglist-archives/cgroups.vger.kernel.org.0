Return-Path: <cgroups+bounces-8322-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB18AC1A2C
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 04:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83FF168A0F
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 02:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8627F20FAA8;
	Fri, 23 May 2025 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AHPdndVK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5B62036EC
	for <cgroups@vger.kernel.org>; Fri, 23 May 2025 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747968044; cv=none; b=KWGpr8nwR7iuKQytK80uG0KaoA1lVHYNOQb8Eg2ckPGd/zNZ5b6GG0TfVxTBeMLdRHSDWYjlCYSRWedyhvMPyznuXZujK4q6YnuIIJizNpSDSnNyGJaaYmEJENU8MQb5J4l8wEi3Xq/tHBdtJW+DoIwD1oG7wdP0eeOKk8VQ8cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747968044; c=relaxed/simple;
	bh=z8DCYt8LI8PKx6Er4leJ+unqZrPaxylMfSdyLfKl2No=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pHEhgKUcsuhaeSu42Y9A82KJihuCLVpgnBPrW7iN5lKjfcmBoEgpCZrKJKNXM1l0rFZ5rpNwKOmseBF+TBH1TzzevEaVUorpsTVydTZk2QmICzFrN6OR82HChGSDKQtDt+ZdxuDZYqtgrXPM1gkaDi28rsEwDHv+TpnRzFZR5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AHPdndVK; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747968039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ExKQDu/QVAaNGZZ21ymKeIRIUkQjlnYFZrthUN5LOOg=;
	b=AHPdndVKjx22GhUixbVWcTUUBkt5txacCmcxOn9eShMc5ije1MuX0G5n/frWJNEAHPUtMO
	mypLklg11EbPqp+r2tzrQbbspQVz1WRUe1jLE7s/cFsDC5YNSSbvFC4x+BXeV5UdOfYPfs
	0OV/QFgG89cdblHTqXtTYf2od+RpktY=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <aC_OF2hYWawIdb-_@harry>
Date: Fri, 23 May 2025 10:39:58 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 hannes@cmpxchg.org,
 mhocko@kernel.org,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 akpm@linux-foundation.org,
 david@fromorbit.com,
 zhengqi.arch@bytedance.com,
 yosry.ahmed@linux.dev,
 nphamcs@gmail.com,
 chengming.zhou@linux.dev,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F626EF89-1EA4-4A4E-85D6-93691B681E66@linux.dev>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <aC_OF2hYWawIdb-_@harry>
To: Harry Yoo <harry.yoo@oracle.com>
X-Migadu-Flow: FLOW_OUT



> On May 23, 2025, at 09:23, Harry Yoo <harry.yoo@oracle.com> wrote:
>=20
> On Tue, Apr 15, 2025 at 10:45:04AM +0800, Muchun Song wrote:
>> This patchset is based on v6.15-rc2. It functions correctly only when
>> CONFIG_LRU_GEN (Multi-Gen LRU) is disabled. Several issues were =
encountered
>> during rebasing onto the latest code. For more details and =
assistance, refer
>> to the "Challenges" section. This is the reason for adding the RFC =
tag.
>>=20
>=20
> [...snip...]
>=20
>> ## Fundamentals
>>=20
>> A folio will no longer pin its corresponding memory cgroup. It is =
necessary
>> to ensure that the memory cgroup or the lruvec associated with the =
memory
>> cgroup is not released when a user obtains a pointer to the memory =
cgroup
>> or lruvec returned by folio_memcg() or folio_lruvec(). Users are =
required
>> to hold the RCU read lock or acquire a reference to the memory cgroup
>> associated with the folio to prevent its release if they are not =
concerned
>> about the binding stability between the folio and its corresponding =
memory
>> cgroup. However, some users of folio_lruvec() (i.e., the lruvec lock)
>> desire a stable binding between the folio and its corresponding =
memory
>> cgroup. An approach is needed to ensure the stability of the binding =
while
>> the lruvec lock is held, and to detect the situation of holding the
>> incorrect lruvec lock when there is a race condition during memory =
cgroup
>> reparenting. The following four steps are taken to achieve these =
goals.
>>=20
>> 1. The first step  to be taken is to identify all users of both =
functions
>>   (folio_memcg() and folio_lruvec()) who are not concerned about =
binding
>>   stability and implement appropriate measures (such as holding a RCU =
read
>>   lock or temporarily obtaining a reference to the memory cgroup for =
a
>>   brief period) to prevent the release of the memory cgroup.
>>=20
>> 2. Secondly, the following refactoring of folio_lruvec_lock() =
demonstrates
>>   how to ensure the binding stability from the user's perspective of
>>   folio_lruvec().
>>=20
>>   struct lruvec *folio_lruvec_lock(struct folio *folio)
>>   {
>>           struct lruvec *lruvec;
>>=20
>>           rcu_read_lock();
>>   retry:
>>           lruvec =3D folio_lruvec(folio);
>>           spin_lock(&lruvec->lru_lock);
>>           if (unlikely(lruvec_memcg(lruvec) !=3D folio_memcg(folio))) =
{
>>                   spin_unlock(&lruvec->lru_lock);
>>                   goto retry;
>>           }
>>=20
>>           return lruvec;
>>   }
>=20
> Is it still required to hold RCU read lock after binding stability
> between folio and memcg?

No. The spin lock is enough. The reason is because the introducing
of lock assertion in commit:

  02f4bbefcada ("mm: kmem: add lockdep assertion to obj_cgroup_memcg")

The user may unintentionally call obj_cgroup_memcg() with holding
lruvec lock, if we do not hold rcu read lock, then obj_cgroup_memcg()
will complain about this.

>=20
> In the previous version of this series, folio_lruvec_lock() is =
implemented:
>=20
> struct lruvec *folio_lruvec_lock(struct folio *folio)
> {
> 	struct lruvec *lruvec;
>=20
> 	rcu_read_lock();
> retry:
> 	lruvec =3D folio_lruvec(folio);
> 	spin_lock(&lruvec->lru_lock);
>=20
> 	if (unlikely(lruvec_memcg(lruvec) !=3D folio_memcg(folio))) {
> 		spin_unlock(&lruvec->lru_lock);
> 		goto retry;
> 	}
> 	rcu_read_unlock();
>=20
> 	return lruvec;
> }
>=20
> And then this version calls rcu_read_unlock() in lruvec_unlock(),
> instead of folio_lruvec_lock().
>=20
> I wonder if this is because the memcg or objcg can be released without
> rcu_read_lock(), or just to silence the warning in
> =
folio_memcg()->obj_cgroup_memcg()->lockdep_assert_once(rcu_read_lock_is_he=
ld())?

The latter is right.

Muchun,
Thanks.

>=20
>>   =46rom the perspective of memory cgroup removal, the entire =
reparenting
>>   process (altering the binding relationship between folio and its =
memory
>>   cgroup and moving the LRU lists to its parental memory cgroup) =
should be
>>   carried out under both the lruvec lock of the memory cgroup being =
removed
>>   and the lruvec lock of its parent.
>>=20
>> 3. Thirdly, another lock that requires the same approach is the =
split-queue
>>   lock of THP.
>>=20
>> 4. Finally, transfer the LRU pages to the object cgroup without =
holding a
>>   reference to the original memory cgroup.
>=20
> --=20
> Cheers,
> Harry / Hyeonggon



Return-Path: <cgroups+bounces-6196-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82913A13D58
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 16:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C260218880E3
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CDA22B8C0;
	Thu, 16 Jan 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="lHrEONPS"
X-Original-To: cgroups@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890B1F37DF;
	Thu, 16 Jan 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040380; cv=none; b=ei9Zx8+FxHI/GvPA8z/JCXdWT/eBRZ/7TqNCm27d7X2hFSxzMgrFoU+ZqCqZEASJa2q7rCQU5NoZ+9Chd9BinlciuCQnhDf3+Ry7nrJwHAX+mmfWXFtGSrj3QiGFOh6bik3KPojtgTFVojYfuH1OutzYwJoVuJ7QlSstWJAfWbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040380; c=relaxed/simple;
	bh=BgR+Q0rqHO3yn7oTJrTT+nZcexOYnQlFrn8MElwBYCo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CxeX66V/fLE8nEkyxtoyuFMkVDR28dpnAESnZu1JJvUh5ewUrPNkC72rup/GAnXzTqLYGF3GtXyoMUWEGxraaEidJobpp3Kly4FWUxZ1PqDoJkefGBR1w7E6VaKE5d3QW/jL3WUQ+BFY+CrE6b/zK93U2qjVFUQyZyqaO3fqn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=lHrEONPS; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7522840403
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1737040372; bh=Xu3VpRKC0nGpvG7JARJUJcZK5zO7ngHw6Wu7UN8oHAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lHrEONPSjWgmlBNliBMVniHhNRQG7AQuv5eYRSxxModvh+Nu8QVjoSySnPSxWlaS7
	 87nzEsqXtcksi2ej52rg5HT6biVP14P8Asj/SEf5u0q091A+EgNcVlFr7jd2iEfIsn
	 DL9JAzEwJ3P3S2ebsCWvpgZLyMVB51WZlNl4+sBbq8vwLjIR0KvBax5NsdkgD/KNQZ
	 3bADFvJUwjTgGs9Mm6bZxpA1LAZrh0KVg5JACO3M/qzzZF4g1G2+iCPSlUMDY8lVjE
	 VJ1k8fsKv0/WJ4UtUjMJf5VYzuyDTnRlNwiq25AnHp5sMdGtnzNQk99cIPVBDiWwi8
	 KH+um3gI4r2WQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7522840403;
	Thu, 16 Jan 2025 15:12:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 "mkoutny@suse.com" <mkoutny@suse.com>, "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Waiman Long <llong@redhat.com>
Subject: Re: [PATCH v2] Documentation/cgroup-v2: Update
 memory.{stat,numa_stat} description to reflect possible units
In-Reply-To: <4e96a241-a996-4289-9ac5-dc1ff65cbff8@fujitsu.com>
References: <20250110123019.423725-1-lizhijian@fujitsu.com>
 <20250113010530.432396-1-lizhijian@fujitsu.com>
 <871px6bo3v.fsf@trenco.lwn.net>
 <4e96a241-a996-4289-9ac5-dc1ff65cbff8@fujitsu.com>
Date: Thu, 16 Jan 2025 08:12:51 -0700
Message-ID: <87frli3i8c.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> Hi Jonathan,
>
>
> On 14/01/2025 01:49, Jonathan Corbet wrote:
>> Li Zhijian <lizhijian@fujitsu.com> writes:
>> 
>>> The description of the memory.{stat,numa_stat} file has been updated to
>>> clarify that the output values can be in bytes or pages.
>>> This change ensures that users are aware that the unit of measurement for
>>> memory values can vary and should be verified by consulting the memory.stat
>>>
>>> It's known that
>>> workingset_*, pg* are counted in pages
>>>
>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>a
>>> ---
>>> V2: updated the document as suggestion from Michal
>>>      updated subject and commit log
>>> ---
>>>   Documentation/admin-guide/cgroup-v2.rst | 9 +++++----
>>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>>> index 315ede811c9d..0a43be0c32d1 100644
>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>> @@ -1427,7 +1427,7 @@ The following nested keys are defined.
>>>   	types of memory, type-specific details, and other information
>>>   	on the state and past events of the memory management system.
>>>   
>>> -	All memory amounts are in bytes.
>>> +	All memory amounts are in bytes unless said otherwise.
>>>   
>>>   	The entries are ordered to be human readable, and new entries
>>>   	can show up in the middle. Don't rely on items remaining in a
>>> @@ -1673,11 +1673,12 @@ The following nested keys are defined.
>>>   	application performance by combining this information with the
>>>   	application's CPU allocation.
>>>   
>>> -	All memory amounts are in bytes.
>>> -
>>>   	The output format of memory.numa_stat is::
>>>   
>>> -	  type N0=<bytes in node 0> N1=<bytes in node 1> ...
>>> +	  type N0=<value for node 0> N1=<value for node 1> ...
>>> +
>>> +        The 'value' can be in bytes or pages, depending on the specific
>>> +        type of memory. To determine the unit, refer to the memory.stat.
>> 
>> This seems like useful information - but can we really not give better
>> guidance to our readers on how to interpret this value?  What in "the
>> memory.stat" will tell them which units are in use?
>
> Let me quote a piece of the numa.stat:
>
> In pages:
>>          pgdemote_khugepaged                                                   
>>                Number of pages demoted by khugepaged.
>
> In bytes:
>>          file                                                                  
>>                Amount of memory used to cache filesystem data,                 
>>                including tmpfs and shared memory. 
>
> Prior to this reference to `memory.stat`, the previous `memory.numa_stat` also
> relied on `memory.stat` to determine which entries were present.
> Therefore, adding this current reference to `memory.stat` does not introduce
> additional complexity.
>
> 1680         The 'value' can be in bytes or pages, depending on the specific
> 1681         type of memory. To determine the unit, refer to the memory.stat.
> 1682
> 1683         The entries are ordered to be human readable, and new entries
> 1684         can show up in the middle. Don't rely on items remaining in a
> 1685         fixed position; use the keys to look up specific values!
> 1686
> 1687         The entries can refer to the memory.stat.   <<< the original reference

...but neither does it help our reader.  Can we at least point to
something that would help them to make sense of this value?

>> (Even better, could we fix the code to always return the same units
>> without breaking something somewhere?)
>
> Of course, I am not opposed to having all entries use the same unit.
> At a glance, there are quite a few entries within `memory.stat` that are
> actually measured in pages. Do we truly request to this significant modification?

No, I am not asking you to do that - I was just thinking that it could
be a good idea.  But there may be reasons for why things are the way
they are, and I do not know if such a change would be accepted by the
relevant maintainers or not.

jon


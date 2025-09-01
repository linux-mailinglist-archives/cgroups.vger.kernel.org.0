Return-Path: <cgroups+bounces-9575-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B98BB3EB72
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 17:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E1A1B254CB
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1692D5923;
	Mon,  1 Sep 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="qIIGPcEK"
X-Original-To: cgroups@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09DF2D5924
	for <cgroups@vger.kernel.org>; Mon,  1 Sep 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741485; cv=none; b=uE2WD3q5vpDqI34WBUxymVpmg7d0B51Z9T/PG+k5/EiObkqEMEQsIV1ZrTlt7rl7puR30wkriw9O7vX6YfuQz0mEJc+rAzdcqJhSDMs2AOq0qOH6SN9u+xUXJB0o+GbgdXzWcZuKYz9t9fp0HZ3lBASNpKWFhB2AdsQTWFxrrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741485; c=relaxed/simple;
	bh=A9EKq0I5E2JqhctkfhXR8yJuNBIk9mw9nW66Iu8wRGc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BO3LDB9ZiyxHzr491z0Usr0VALMa9EtCo3jxWpvfUZTwvbR08vFL/yinIygGxXJY14QLnIgqV+9HAVWR3UZYob/3VvPywHaypyMOAuvADvEn2jh0hqWVTr2Xct8qN5FchjNNTle2iLMXMwY7AWtfrWosogPgZHLKQ4g1s99JFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=qIIGPcEK; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id t2hduPkLESkcft6i2ugVhi; Mon, 01 Sep 2025 15:44:42 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id t6i2urbr7Qb4It6i2uRqc4; Mon, 01 Sep 2025 15:44:42 +0000
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=68b5bf6a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=XW3vq5T86JFyMsJaYQInbg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=_Wotqz80AAAA:8
 a=MP2rF-h271nBIuJ3T_AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y0fsRvmPrAhs1h6DvVbgVFFtiRUzzd01crsN+voeioY=; b=qIIGPcEKmL7xagz1V7tLDOT4ai
	U/8DHANdLET5przFAB3wZxByyiTjgjqvcegRElvQVgFfhDKNu1GcncMrN9qdhed+SruYr0kJbwxL5
	gCuj50bDVaYGh0+2fyXcg1BoAVIUaDvhV1a3ePRRRIHR8mYnYSTG6VD1Rf2nDGcKpLtpIvjeeMyb9
	E0ZIyPW2/Xu2P9u68PkpU/LrDcm7qmxVs3tgZFUDg2NBBfkMi/rwNqpumI2Grqm5FjiCklbwxHMc9
	W87V0vbvuKZdS1dDapwV/eyn55GDgkJtFTz0TGIekEpjUsQJ+cyz5kZhq6hTaDK9mZ1RXh81IbpXH
	POaREHAQ==;
Received: from d4b26982.static.ziggozakelijk.nl ([212.178.105.130]:43450 helo=[10.233.40.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1ut6i1-00000003Cuy-2AmN;
	Mon, 01 Sep 2025 10:44:41 -0500
Message-ID: <4546ce0f-8f29-4708-8af6-82fd1003e4bb@embeddedor.com>
Date: Mon, 1 Sep 2025 17:44:38 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
 <wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
 <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>
Content-Language: en-US
In-Reply-To: <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 212.178.105.130
X-Source-L: No
X-Exim-ID: 1ut6i1-00000003Cuy-2AmN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: d4b26982.static.ziggozakelijk.nl ([10.233.40.44]) [212.178.105.130]:43450
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG/G6eXC80jKvvVN5sPe6yQxSjYAHISQt/16dHLiFvg4SmbqlWHtzpS2eSV+139Iirb+22MItc6ocaeWHdiTS4WUiAy85pi+Jx+ABS1LLjFqJr3uiByf
 Rkg8YSciAoYZQr/Hi1EFAu90E6ADeSXG1M9qHlYZbVKw+kM6ZsydOGbCgxbCXOdoIflKzk1Ny3G3ilDCSi6WenH56X0hD6EpNEk=



On 9/1/25 17:21, Gustavo A. R. Silva wrote:
> 
> 
> On 9/1/25 15:37, Michal Koutný wrote:
>> On Sat, Aug 30, 2025 at 03:30:11PM +0200, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>>> Based on the comments above, it seems that the original code was expecting
>>> cgrp->ancestors[0] and cgrp_ancestor_storage to share the same addres in
>>> memory.
>>
>> Fortunately, it doesn't matter what the address of cgrp_ancestor_storage
>> is. The important effect is that cgroup_root::cgrp is followed by
>> sufficient space to store a pointer (accessed via cgroup::ancestors[0]).
>>
>>> However when I take a look at the pahole output, I see that these two members
>>> are actually misaligned by 56 bytes. See below:
>>
>> So the root cgroup's ancestry may be saved inside the padding instead of
>> the dedicated storage. I don't think it causes immediate issues but it'd
>> be better not to write to these bytes. (Note that the layout depends on
>> kernel config.) Thanks for the report Gustavo!
>>
>>
>>> So, one solution for this is to use the TRAILING_OVERLAP() helper and
>>> move these members at the end of `struct cgroup_root`. With this the
>>> misalignment disappears (together with the 14722 warnings :) ), and now
>>> both cgrp->ancestors[0] and cgrp_ancestor_storage share the same address
>>> in memory. See below:
>>
>> I didn't know TRAILING_OVERLAP() but it sounds like the tool for such
>> situations.
> 
> I recently introduced it. :)
> 
>> Why do you move struct cgroup at the end of struct cgroup_root?
> 
> Because struct cgroup ends in a flexible-array member `ancestors`.
> This triggers the -Wflex-array-member-not-at-end warns about. So,
> while `ancestors` is indeed a flexible array, any instance of
> cgroup embedded in another struct should be placed at the end.
> 
> However, if we change it to something like this (and of course
> updating any related code, accordingly):
> 
> -       struct cgroup *ancestors[];
> +       struct cgroup **ancestors;
> 
> Then the flex in the middle issue goes away, and we can have
> struct cgroup embedded in another struct anywhere.
> 
> The question is if this would be an acceptable solution?
> 
> I'd probably prefer this to remain a flexible-array member,
> but I'd like to hear people's opinions and feedback. :)
> 
>>
>> (Actually, as I look at the macro's implementation, it should be
>> --- a/include/linux/stddef.h
>> +++ b/include/linux/stddef.h
>> @@ -110,7 +110,7 @@ enum {
>>                  struct {                                                        \
>>                          unsigned char __offset_to_##FAM[offsetof(TYPE, FAM)];   \
>>                          MEMBERS                                                 \
>> -               };                                                              \
>> +               } __packed;                                                     \
>>          }
>>
>>   #endif
>> in order to avoid similar issues, no?)
> 
> The way to do it is like this:
> 
> +       TRAILING_OVERLAP(struct cgroup, cgrp, ancestors,
> +               /* must follow cgrp for cgrp->ancestors[0], see above */
> +               struct cgroup *cgrp_ancestor_storage;
> +       ) __packed;

Oh, a correction about this. Actually, if we need to use __packed, we would
have to pass it as an argument to TRAILING_OVERLAP(), like this:

-#define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS)                             \
+#define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS, ATTRS)                              \
         union {                                                                 \
                 TYPE NAME;                                                      \
                 struct {                                                        \
                         unsigned char __offset_to_##FAM[offsetof(TYPE, FAM)];   \
                         MEMBERS                                                 \
-               };                                                              \
+               } ATTRS;                                                                \
         }

However, in this case MEMBERS is only cgrp_ancestor_storage, and it's correctly
aligned to __offset_to_##FAM[offsetof(TYPE, FAM)]; inside the helper. So, we
don't really need to pack that internal struct.

Thanks
-Gustavo

> 
> 
> and this get us to the following:
> 
> struct cgroup_root {
> ...
>          /* --- cacheline 65 boundary (4160 bytes) was 56 bytes ago --- */
>          union {
>                  struct cgroup      cgrp __attribute__((__aligned__(1))); /*  4216  8192 */
>                  struct {
>                          unsigned char __offset_to_ancestors[5784]; /*  4216  5784 */
>                          /* --- cacheline 156 boundary (9984 bytes) was 16 bytes ago --- */
>                          struct cgroup * cgrp_ancestor_storage; /* 10000     8 */
>                  };                                       /*  4216  5792 */
>          } __attribute__((__aligned__(1)));               /*  4216  8192 */
> 
>          /* size: 12408, cachelines: 194, members: 10 */
>          /* forced alignments: 2 */
>          /* last cacheline: 56 bytes */
> } __attribute__((__aligned__(8)));
> 
> Notice the change in alignment in struct cgroup_root from
> 4096 (page alignment) to 8 bytes alignment. In any case,
> the size (still) increases from 6400 to 12408 bytes.
> 
> Thanks
> -Gustavo



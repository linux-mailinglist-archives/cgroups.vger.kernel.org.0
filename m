Return-Path: <cgroups+bounces-14346-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIScAq+9nmnYXAQAu9opvQ
	(envelope-from <cgroups+bounces-14346-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 10:15:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE0D194BDD
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 10:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 289DB302C5D7
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3F7327BF3;
	Wed, 25 Feb 2026 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DMeXPNVJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312E36EAB6
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010895; cv=none; b=d7KlC+/mUx+Kw18sGaLTtNn6VPwxVzVp9Cb2SR8iVymZ2Mo+cG8BqS3ScLGxmBlV7/p9dVCosHelVejNPQ0UjnP+msLJexqnwOhwaILUVneZPdMISSXdCSNvQ1l4p4wsIQFTie5OQYqCgZCoFYoZDkB3Fb2txsMjQheptMRQxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010895; c=relaxed/simple;
	bh=QCb9hjarkQn/R+TQsmqSt5WyFIxWWjxuM8EWZMjZ9C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9yACdHU/fEkln2V4pq1N7mhqO+2d1ZjGTtnmEZQBjLTADJkPzOX1mHV23SD5308YMrySp8lRVWOpwyJU5/f56XUgxjpT9wvV9UOQOMpb7qiwPi2rwkKamft6Gvyc0mMs99AsVC+1l7kAAw98zQap+M6URaokxRlSA5JEMwSDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DMeXPNVJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OJTZCS1879767;
	Wed, 25 Feb 2026 09:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Qm3zRW
	f7FXHZ3PWwM1vuxpueRYbxSMDKvASENPHBNrg=; b=DMeXPNVJbQt85WBJhThrMc
	xXR4BlN1U8BQQQFS19xvPOwukG8hSAlM1KPp0lYomMzSK+9LVccxXL04rSRdBeXO
	n9aN+0faZGtjK1tFeGO4VDMChA5QlD8Lz1Dp9wC8JNiUs1IYUxRWN5pbnryUkBEz
	MT7fDOB7dSdJYK+sdh7goW1rQBFvRfESoexd+ktUBM6OPqVflqODpk5czGMMl2Up
	qymznejnCNSHWFBp7qvNCtzMGXTUq+4N0Zjn6N9N9+hZId8RYhEIzXZKPqr8Upj2
	FtR9q9lhqF2K437644E4yGNSxE7nOFeIu87HARlhE4kwgGHF0FLFnBtAMEmuyILw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c6tgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 09:14:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61P7hCxY001653;
	Wed, 25 Feb 2026 09:14:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1n4nhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 09:14:32 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61P9EVRS17433272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 09:14:32 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFA9558052;
	Wed, 25 Feb 2026 09:14:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B60758056;
	Wed, 25 Feb 2026 09:14:27 +0000 (GMT)
Received: from [9.109.248.127] (unknown [9.109.248.127])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 09:14:27 +0000 (GMT)
Message-ID: <84492f08-04c2-485c-9a18-cdafd5a9c3e5@linux.ibm.com>
Date: Wed, 25 Feb 2026 14:44:24 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: initialize slab->stride early to avoid memory
 ordering issues
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter
 <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt
 <shakeel.butt@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20260223075809.19265-1-harry.yoo@oracle.com>
 <2d106583-4ec6-4da0-87ea-4ecad893b24f@linux.ibm.com>
 <aZ2Gwie5dpXotxWc@hyeyoo>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <aZ2Gwie5dpXotxWc@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA4OSBTYWx0ZWRfX+krDo4RDgKdb
 SB/fcBcdwgVQA90A2mfw8YUJ0UzXpYyZRP0U+UxiKpHy7yMftBmDU5HErkwadv/SgH7ESdwKN1G
 rTwVSgTGAzS+kW645Y4zv8hfwCMySVIRAuFbjO50YBjg3x8ixxkylm85cWfaJu5RibXQ5j0DFIE
 3VARzEk7tb5ocVPEMPLP/HcP5nhxK8O+WeL+O9EP1ZEXFHKZFKYhi1JMl8wUrHUep7JD9mjqVj3
 jJdHCSzqu6yKYrHUq31YFdj53ZM3ARhYjr0Anl58myJSCtcThIBk9kav/GONxJ04Ew3f71w3h6T
 AtE1ieiQyQAdV8G6ya+Z5rxGU9ba6eLZ0JKBcNok/cdsVIClCyzk5WHGBXv0X7D/GYdDvaMHcCA
 q5KYNFKqKKhgBPB4uRIge++9cKbXB422ijyWNN8CPS+RbnLCTJ1Al3YwJ1lfs2qNt0cIiZ4Urmi
 4fusAsELnfV4Amg4mhg==
X-Proofpoint-ORIG-GUID: S5laykw_LH9AfdhDpzLDtY82s3ZNgtqJ
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699ebd79 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=Uv5aZE12QK5TszxNbi4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tqe1vJgN43gb2ZvQrZbTIl8i_YUBt-Oz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-14346-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[venkat88@linux.ibm.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 5EE0D194BDD
X-Rspamd-Action: no action


On 24/02/26 4:40 pm, Harry Yoo wrote:
> On Tue, Feb 24, 2026 at 02:34:41PM +0530, Venkat Rao Bagalkote wrote:
>> On 23/02/26 1:28 pm, Harry Yoo wrote:
>>> When alloc_slab_obj_exts() is called later in time (instead of at slab
>>> allocation & initialization step), slab->stride and slab->obj_exts are
>>> set when the slab is already accessible by multiple CPUs.
>>>
>>> The current implementation does not enforce memory ordering between
>>> slab->stride and slab->obj_exts. However, for correctness, slab->stride
>>> must be visible before slab->obj_exts, otherwise concurrent readers
>>> may observe slab->obj_exts as non-zero while stride is still stale,
>>> leading to incorrect reference counting of object cgroups.
>>>
>>> There has been a bug report [1] that showed symptoms of incorrect
>>> reference counting of object cgroups, which could be triggered by
>>> this memory ordering issue.
>>>
>>> Fix this by unconditionally initializing slab->stride in
>>> alloc_slab_obj_exts_early(), before the need_slab_obj_exts() check.
>>> In case of SLAB_OBJ_EXT_IN_OBJ, it is overridden in the same function.
>>>
>>> This ensures stride is set before the slab becomes visible to
>>> other CPUs via the per-node partial slab list (protected by spinlock
>>> with acquire/release semantics), preventing them from observing
>>> inconsistent stride value.
>>>
>>> Thanks to Shakeel Butt for pointing out this issue [2].
>>>
>>> Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>> Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com
>>> Link: https://lore.kernel.org/linux-mm/aZu9G9mVIVzSm6Ft@hyeyoo
>>> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
>>> ---
>>>
>>> I tested this patch, but I could not confirm that this actually fixes
>>> the issue reported by [1]. It would be nice if Venkat could help
>>> confirm; but perhaps it's challenging to reliably reproduce...
>>
>> Thanks for the patch. I did ran the complete test suite, and unfortunately
>> issue is reproducing.
> Oops, thanks for confirming that it's still reproduced!
> That's really helpful.
>
> Perhaps I should start considering cases where it's not a memory
> ordering issue, but let's check one more thing before moving on.
> could you please test if it still reproduces with the following patch?
>
> If it's still reproducible, it should not be due to the memory ordering
> issue between obj_exts and stride.
>
> ---8<---
> From: Harry Yoo <harry.yoo@oracle.com>
> Date: Mon, 23 Feb 2026 16:58:09 +0900
> Subject: mm/slab: enforce slab->stride -> slab->obj_exts ordering
>
> I tried to avoid unnecessary memory barriers for efficiency,
> but the original bug is still reproducible.
>
> Probably I missed a case where an object is allocated on a CPU
> and then freed on a different CPU without involving spinlock.
>
> I'm not sure if I did not cover edge cases or if it's caused by
> something other than memory ordering issue.
>
> Anyway, let's find out by introducing heavy memory barriers!
>
> Always ensure that updates to stride is visible before obj_exts.
>
> ---
>   mm/slab.h |  1 +
>   mm/slub.c | 10 +++++++---
>   2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 71c7261bf822..aacdd9f4e509 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -565,6 +565,7 @@ static inline void slab_set_stride(struct slab *slab, unsigned short stride)
>   }
>   static inline unsigned short slab_get_stride(struct slab *slab)
>   {
> +	smp_rmb();
>   	return slab->stride;
>   }
>   #else
> diff --git a/mm/slub.c b/mm/slub.c
> index 862642c165ed..c7c8b660a994 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2196,7 +2196,6 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>   retry:
>   	old_exts = READ_ONCE(slab->obj_exts);
>   	handle_failed_objexts_alloc(old_exts, vec, objects);
> -	slab_set_stride(slab, sizeof(struct slabobj_ext));
>
>   	if (new_slab) {
>   		/*
> @@ -2272,6 +2271,10 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
>   	void *addr;
>   	unsigned long obj_exts;
>
> +	slab_set_stride(slab, sizeof(struct slabobj_ext));
> +	/* pairs with smp_rmb() in slab_get_stride() */
> +	smp_wmb();
> +
>   	if (!need_slab_obj_exts(s))
>   		return;
>
> @@ -2288,7 +2291,6 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
>   		obj_exts |= MEMCG_DATA_OBJEXTS;
>   #endif
>   		slab->obj_exts = obj_exts;
> -		slab_set_stride(slab, sizeof(struct slabobj_ext));
>   	} else if (s->flags & SLAB_OBJ_EXT_IN_OBJ) {
>   		unsigned int offset = obj_exts_offset_in_object(s);
>
> @@ -2305,8 +2307,10 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
>   #ifdef CONFIG_MEMCG
>   		obj_exts |= MEMCG_DATA_OBJEXTS;
>   #endif
> -		slab->obj_exts = obj_exts;
>   		slab_set_stride(slab, s->size);
> +		/* pairs with smp_rmb() in slab_get_stride() */
> +		smp_wmb();
> +		slab->obj_exts = obj_exts;
>   	}
>   }
>
> --
> 2.43.0
>

With this patch, issue is not reproduced. So looks good.


Regards,

Venkat.



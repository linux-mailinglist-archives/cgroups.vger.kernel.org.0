Return-Path: <cgroups+bounces-15027-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOZfCrGzwmkvlAQAu9opvQ
	(envelope-from <cgroups+bounces-15027-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 16:54:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA9F3186DC
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 16:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3001D30297B1
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0FE2773C3;
	Tue, 24 Mar 2026 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nIeCWc6R"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7B29ACC6;
	Tue, 24 Mar 2026 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367270; cv=none; b=I85vsmQH7vDXngKay9qyR+dCV7pSQiDAza/jQyWbUyIF8XscOM9/3dovHLedC9XpA0D0wPwBqSOwzklNleRHTmumKvaIMpIA8HfXZcRumgYySk+vJBs/UaBgpdwi5uBl3Oj70kNltKy0gGT7E7sfWYeHjOSkSm4pQW8+hRWgg5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367270; c=relaxed/simple;
	bh=d9hMfezXmreGlpwJ2fZfYIYHB5ksi38AVQoG5a+cqXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRLak8TsT4o/Acatvwidn8puHWKZ5mL/Uj93RTOv5MCfEqGSQjaBwJzwICrhRZssNQ18TZwq8GDgXHzLBBt3iQLnv8f0p8uWcnr136uIHQuPInieukZkaBIl1mR56YZdPpGwSEg+pIVTEKdwMsiu12lmV5iuf76K/GZeoZ4SNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nIeCWc6R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O5TmJ0556595;
	Tue, 24 Mar 2026 15:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nR9MIX
	G5cbSNnabzc/Wmq/ZEfcuykgTeKIrZ+2D7JWc=; b=nIeCWc6R3MwyeJCONqz0ET
	v1g1hlulkdHkxmzgrreYFO4GCNkMfSnMj7wv28bOFXhxjW84wEv0aZSGhsyATnob
	xUywx1MxRkgtQ9kzOT2DdhLFIDp5YiYZLqe2spiijHoPxjlrGt2I3hBH5/W1wXF8
	bubF702lCFNckMyi6YfABFTtyW7Lx9v0fBS62/O8GtVO4PP9ck6DaEnLm9EIPly3
	nvAVR0e3K+TG1wGEykfWjF1HfS+1rc84ng+KwbhtELCPiT6972gIGGHRr/4v44Bs
	gA8pQZA4RUAxZZYXtnicZ6vQOglA6ejVBGsal1jVYDHRda4A48B/WyS45HnGHSYA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqcbkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:47:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OFJ7mB031687;
	Tue, 24 Mar 2026 15:47:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nstq4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:47:06 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OFl6wO22414060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 15:47:06 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 885C758056;
	Tue, 24 Mar 2026 15:47:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A5965803F;
	Tue, 24 Mar 2026 15:47:01 +0000 (GMT)
Received: from [9.39.25.178] (unknown [9.39.25.178])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 15:47:00 +0000 (GMT)
Message-ID: <5bf5a4f2-0505-44ef-9cea-df6ec25d9603@linux.ibm.com>
Date: Tue, 24 Mar 2026 21:16:59 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/6] mm/memcontrol: Make memory.high tier-aware
To: Gregory Price <gourry@gourry.net>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
 <20260223223830.586018-7-joshua.hahnjy@gmail.com>
 <90749965-ebc8-43b2-92e3-baec5f6e3de0@linux.ibm.com>
 <acKsb06lnywch8DV@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <acKsb06lnywch8DV@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: LVdurRN2EDTT67M7-3BJiK4bPS0nldWJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX1s3/DoQnR89W
 4OyHHua3rqv4GFjhuCfmRD+wRHyX9XpxaUnWFV0CjxWxY0+qaGst+wECvYnFNnS+P1R2KSqWsmy
 hF4WEydo5virXXt1dSZuQjbQRTFL7y/deW0iHb6zb7lw7UrKZyhgwzO6jn6GaMwRc6hShSUnHpU
 351n0cZgj2fEY1jC0dFDy66jrgwZS/lw2F1uwYYWynlpy8vmYJJnPhbv3TYd3wGPFS7n3lwWrOR
 /BHtI2xJiY9+yrhU3mr25Q0irzNJL92D+PeX9sChTnAVDnyBoRk8MZtgZvbnn8Wx2HzikRkOJ/t
 EdQ1tMNsslsL7N6g5SohPrK6zddkVGCIyhzBsC31BUhnH8sorqp0XoIE99oC1vQI6WkYjyVWsKm
 D8ZU5HsUDQ2rII9G4sbSgg0TjmEHpLKzIrva4HV4Eh6b835F8OWON4m2VPi9Hd/NCzK3er7f1Z2
 eWwRupQX2Pgw93AT88A==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c2b1fc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=0D6tOVm0XesP3UCEPNQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BF40lhA_4j4DGEWWyDFDVxmTk2uqOXny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240119
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15027-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,oracle.com,cmpxchg.org,suse.com,linux.dev,bytedance.com,google.com,kvack.org,vger.kernel.org,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donettom@linux.ibm.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 7CA9F3186DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/24/26 8:53 PM, Gregory Price wrote:
> On Tue, Mar 24, 2026 at 04:21:06PM +0530, Donet Tom wrote:
>> IIUC The intent of this patch is to partition cgroup memory such that
>> 0 → toptier_high is backed by higher-tier memory, and
>> toptier_high → max is backed by lower-tier memory.
>>
>> Based on this:
>>
>> 1.If top-tier usage exceeds toptier_high, pages should be
>>    demoted to the lower tier.
>>
>> 2. If lower-tier usage exceeds (max - toptier_high), pages
>>    should be swapped out.
>>
> This is not accurate and an incorrect heuristic.
>
> Transiently, lower-tier usage may exceed (max - toptier_high) for any
> number of reasons which should not be used as signal for pushing swap.
>
> driving swap usage is a function of (usage > memory.high) without regard
> for toptier / lowtier.
>
>> 3. If total memory usage exceeds max, demotion should be
>>    avoided and reclaim should directly swap out pages.
>>
> This is also incorrect, as it would drive agingin inversions.
> Demotion is a natural extension of the LRU infrastructure:
>
> toptier active -> toptier inactive -> lowtier inactive -> swap
>
> if you do (toptier inactive -> swap) you have inverted the LRU.


Thanks, Gregory, for the clarification.

One remaining concern is that under cgroup memory pressure,
demotion to the lower tier can still happen. Since demotion
does not uncharge the memcg, this could still trigger OOM.

Is this an issue we should address?


>
> As far as I know, from testing, we retain all the existing behavior - we
> are just managing a limited resource (top tier memory) to manage the
> noisy-neighbor issue.  So...
>
>
>> Should we also handle cases (2) and (3) in this patch?
> No, I don't think we should
>
> ~Gregory
>


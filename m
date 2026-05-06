Return-Path: <cgroups+bounces-15637-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPIrKcov+2lxXQMAu9opvQ
	(envelope-from <cgroups+bounces-15637-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 14:10:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F5F4D9FBD
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 14:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75DE8300601F
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC72425CFD;
	Wed,  6 May 2026 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kgiI15yA"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E16270540;
	Wed,  6 May 2026 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069445; cv=none; b=g+8twWLtXoM7KTk91N1xCqsCYgPPyfJo+OEUdx18jljDnMHVl1fBIBLeGS/m9p1NkshRLDv4Gr8oE3eVSEl9bW2VwZhXpOD7Nk38nwQwkrajAzu1S/7C64aqEtxNUcvmejefJ9bVFQkuKetxtEhHx/cOyQF9mDTXwtXC+YSC7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069445; c=relaxed/simple;
	bh=PtupoXMIdRE7Lp16scxC4gNRHteSsm6mTgsMr0hm4hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJbxgdmoNWr/0zGlqkEjPv9xbrCYT7X7u6vIPkGWe9TTo2UerHZ57uKdqy0CpGYnoewsF0MO21OyaH7dAd8YUyxHBqQTukxk2Wlk+fN74yTm68wjoNuriGK6iZDqPpVG/THbjGgmmpxyWQwwywUK/U61GHQfIWUGbHfJR+keVRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kgiI15yA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645K6q8H2808530;
	Wed, 6 May 2026 12:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZtwzGj
	/Cax+3P4OOw+bfUOBHyFVXjSFJ4a1rGiao3GA=; b=kgiI15yA44suZPvLptSlax
	kSGnWLjQcWrmE1mE0wp6Wh+xcTHItOj2CJM094z4sx1rrAdtuap/2D3jP61eDexE
	twQ/4OzS0eQFDc3a5rQC+6nZjYzaDj8zESMM0uJ1Dw+DoMlQPYx4kNlgpIvgih9P
	p4vs15lTPbnHbt9AHg4IuYUOWSGL2nl/JBJ5nmmPorGO68+9EOAcrlxha4Jv7CQx
	k1bwIw/ie1sEdTqyEGOqiUkIHCwdZgAyZ21Z1aeIIgYPQpuByviwqLeLskyfjMHW
	r1pBhEEgfEV+sPvATwNxdPuV0KZScgxDi/RB6W6vxoYGhe2hxGhlHTX8iQsYYMXQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1ggw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 12:10:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646C5QqM032540;
	Wed, 6 May 2026 12:10:09 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjx3eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 12:10:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646CA92B34144898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 12:10:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0489C58055;
	Wed,  6 May 2026 12:10:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 208C65804B;
	Wed,  6 May 2026 12:10:03 +0000 (GMT)
Received: from [9.123.3.209] (unknown [9.123.3.209])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 12:10:02 +0000 (GMT)
Message-ID: <5308bbfc-286b-45a9-b527-c282ce95a028@linux.ibm.com>
Date: Wed, 6 May 2026 17:40:01 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/cgroup: Fix hardcoded page size in
 test_percpu_basic
To: Li Wang <li.wang@linux.dev>, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
        shuah@kernel.org
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>, Christoph Lameter <cl@linux.com>,
        Shakeel Butt <shakeelb@google.com>, Vlastimil Babka <vbabka@suse.cz>
References: <20260501022058.18024-1-li.wang@linux.dev>
 <20260501022058.18024-2-li.wang@linux.dev>
Content-Language: en-IN
From: Sayali Patil <sayalip@linux.ibm.com>
In-Reply-To: <20260501022058.18024-2-li.wang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: JJimJ3U9Ee2f75fvJNMoQyEthf9nE0cr
X-Proofpoint-GUID: JpMACp870QKhw6LAYNdgB11JVvGe__yj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDExOSBTYWx0ZWRfX+7mLPDG8OGPN
 pcmFBnQ03nwA0nYPv4Y505miok8pUv0+rKoRywZfZlh378cPqj/GlnvirMpBMOcopToCFZqAG7H
 5RsFbgG/AiFGejzMzhpNF1svhVvCRHIt0SVYuIGb2aHGMCGyaZIXt27TttnrbQD7ZG+1g90RpPm
 iRqK7HP8lTsn/Z4W+dpwTN1cBgDmPcpwYu9w919k98QWSDFrJicZHyVnAn/huEZ4S+GubK8cVjm
 HP8TK0yi8EdMXQ2HF3TP6XxjfZpEyD9YSOqMz5JkS57lPp9aS3OSM88cIKimAiZt2GV0qsflPqu
 dNoqJp/hcU0luEE6yKOy2aCB1hN08rrmdbwPatuVH9s4Z21tnYbwuCPmmhSvMwzJfsYxElcAue3
 14ynO/pJhWrzmuqv6b9cL8Wc1yvh42CodcuORry8BGMG5PzyDCxPW8NN015So9h4FfEikwIXXXM
 Zdxqvk6AIb2sPTcDCPw==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fb2fa3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=NufY4J3AAAAA:8 a=ufHFDILaAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=3SF8d-dLAay7TFkNkXcA:9 a=QEXdDO2ut3YA:10
 a=TPcZfFuj8SYsoCJAFAiX:22 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060119
X-Rspamd-Queue-Id: A4F5F4D9FBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-15637-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sayalip@linux.ibm.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[11]



On 01/05/26 07:50, Li Wang wrote:
> MAX_VMSTAT_ERROR uses a hardcoded page size of 4096, which assumes
> 4K pages. This causes test_percpu_basic to fail on systems where
> the kernel is configured with a larger page size, such as aarch64
> systems using 16K or 64K pages, where the maximum permissible
> discrepancy between memory.current and percpu charges is
> proportionally larger.
> 
> Replace the hardcoded 4096 with sysconf(_SC_PAGESIZE) to correctly
> derive the page size at runtime regardless of the underlying
> architecture or kernel configuration.
> 
> Signed-off-by: Li Wang <li.wang@linux.dev>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Waiman Long <longman@redhat.com>
> ---
>   tools/testing/selftests/cgroup/test_kmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> index eeabd34bf08..249d7911306 100644
> --- a/tools/testing/selftests/cgroup/test_kmem.c
> +++ b/tools/testing/selftests/cgroup/test_kmem.c
> @@ -24,7 +24,7 @@
>    * the maximum discrepancy between charge and vmstat entries is number
>    * of cpus multiplied by 64 pages.
>    */
> -#define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
> +#define MAX_VMSTAT_ERROR (sysconf(_SC_PAGESIZE) * 64 * get_nprocs())
>   
>   #define KMEM_DEAD_WAIT_RETRIES        80
>   

Reviewed-by: Sayali Patil <sayalip@linux.ibm.com>

Thanks,
Sayali


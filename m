Return-Path: <cgroups+bounces-14464-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC1SEBlQoWkfsAQAu9opvQ
	(envelope-from <cgroups+bounces-14464-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 09:04:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 957511B43BF
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 09:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41FD230125CB
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 08:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F94331B131;
	Fri, 27 Feb 2026 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TfwXkisZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B133123F
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179382; cv=none; b=Hs6TtSEmi6aOHPNhVveZZa8+1zBFD7Vy7xcir61GXs2HNcr+wS2C56eQgbqs0qB3AAstI1xBWawB5gvfPOmobvIKHy3AfPjEkePpaet+PwPAUYWagi2OaATOhF8n6gRz9Bw8r/4M/sELVU+Eg4gfhls0QWPcgPO/moS9p6RpvQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179382; c=relaxed/simple;
	bh=Lk06f5LAenTX+TVKh5SQ/bnuDS5qp0FnMMz3jTJiXpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lClIZGCxEQl2p3Nrof3/y1x2wCrFYmczFx7HqwU7LG1V/pqzsXwD6jWHbzlsC22s5W0el9YCMV5wsOBn+nqYgsMNM6zXPhiDEKbLo19J3R7MTtr+b9s/IxMGtTaLv+vsG6ysOapiaGPnMUAQ7c6aH8CViswmSmenFZDTA9kOeew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TfwXkisZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R3DveF2848171;
	Fri, 27 Feb 2026 08:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=il6r1v
	FMAYqm1JRXq9G41GUF0Xx8t8+WFnEYpvQ7ULE=; b=TfwXkisZYq7Ezmkhr2OdoI
	VHJ2GKUpL/dThRjWS3qeDODJqaU5j/y9dIrQ3YHJjUtllEcfmDQu5z7frb9f/aTb
	dBZ5CLfSS0hbt1qrUbTeKEktCiJ1KAhG22h2TxAYUF6BYKcTOPFZIlkq0vLm8Uir
	7r2oPp4BI7eHORXSaeKoJq4AdlSRUAITYYZNdjrRKkbDiEv1PwJ+NzANAZMQOeDx
	LZM8OgeNmWZdes4wPaww8VMNSZetyd+fydB+otUom7BZtuaxoVcH+hVUJHNKeJKX
	KCN4b1X+9n284rvcvIKZMPoA1T/vFF2XZIoKuGrPITEk1l2XI2f5Gx9hg7ZKFubw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34cjkd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 08:02:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R7xVME027794;
	Fri, 27 Feb 2026 08:02:36 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr28rm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 08:02:36 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61R82ZTx51315058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 08:02:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FC34581C7;
	Fri, 27 Feb 2026 08:02:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFE3D581C1;
	Fri, 27 Feb 2026 08:02:30 +0000 (GMT)
Received: from [9.61.248.160] (unknown [9.61.248.160])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 08:02:30 +0000 (GMT)
Message-ID: <dc88bc66-77ad-4762-80f6-18a1262d5355@linux.ibm.com>
Date: Fri, 27 Feb 2026 13:32:29 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: a debug patch to investigate the issue further
Content-Language: en-GB
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, ast@kernel.org, cgroups@vger.kernel.org,
        cl@gentwo.org, hannes@cmpxchg.org, hao.li@linux.dev,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        rientjes@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        surenb@google.com, vbabka@suse.cz
References: <84492f08-04c2-485c-9a18-cdafd5a9c3e5@linux.ibm.com>
 <20260227030733.9517-1-harry.yoo@oracle.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20260227030733.9517-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA2NCBTYWx0ZWRfX++2rvsaEOQ5e
 2u5EC+ssmYQcYLx91j0h9yMhyED3FKdECyWbvri6YrGoCcdhSApEyONHFjR5TF9JyKC2MKvZUK5
 W1COtaTP6gmH1YeTOZmywvdwdFE6zm6b1q0mPNEibPz8zjpe+Ysex6176gR4e2264wey6odJY8m
 1BaxW6lO+DtkSpMcP3j6TnmKo5WZYNVKvPf2xksfCrhYtkB9J3hKjPhLU2gA5IRYRJoQVz3X9Mx
 RJQ5LG7WfPCoe8fMHnzUE6hs94moJ0PRdqsVFbn+eIoci88NNBS8WP7vlL1FAPTRrO+B7/SWn8D
 W8sxZZNLtISwpLjrfys6XAcgDa15qWC5JOQ67p2zb4N+I/7IO0U3ahyKgVRaVXJQYzmJOB2e83f
 tuLnkpVdAz5IRH+kZprU6Zdqatr9InD4V4narGTq4E7zWeOOR1BxiTjSrlszwcZ3RuW5YbB24G7
 JHw1yY3hN1TxgC1aJxw==
X-Proofpoint-ORIG-GUID: AY74pt8E8C9QDZvphaxTWzgiKXMr-to0
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=69a14f9d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=j6Jcq4vt9KwSvEVgIq8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wCspGPMxLyjdQvxmzDYg9d52jyYZ_-Fk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602270064
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-14464-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[venkat88@linux.ibm.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 957511B43BF
X-Rspamd-Action: no action


On 27/02/26 8:37 am, Harry Yoo wrote:
> Hi Venkat, could you please help testing this patch and
> check if it hits any warning? It's based on v7.0-rc1 tag.
>
> This (hopefully) should give us more information
> that would help debugging the issue.
>
> 1. set stride early in alloc_slab_obj_exts_early()
> 2. move some obj_exts helpers to slab.h
> 3. in slab_obj_ext(), check three things:
>     3-1. is the obj_ext address is the right one for this object?
>     3-2. does the obj_ext address change after smp_rmb()?
>     3-3. does obj_ext->objcg change after smp_rmb()?
>
> No smp_wmb() is used, intentionally.
>
> It is expected that the issue will still reproduce.
>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>


Hello Harry,

I’ve restarted the test, but there are continuous warning prints in the 
logs, and they appear to be slowing down the test run significantly.


Warnings:

[ 3215.419760] obj_ext in object
[ 3215.419774] WARNING: mm/slab.h:710 at slab_obj_ext+0x2e0/0x338, 
CPU#26: grep/103571
[ 3215.419783] Modules linked in: xfs loop dm_mod bonding tls rfkill 
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink 
sunrpc pseries_rng vmx_crypto dax_pmem fuse ext4 crc16 mbcache jbd2 
sd_mod nd_pmem sg papr_scm libnvdimm ibmvscsi ibmveth scsi_transport_srp 
pseries_wdt
[ 3215.419852] CPU: 26 UID: 0 PID: 103571 Comm: grep Kdump: loaded 
Tainted: G        W           7.0.0-rc1+ #3 PREEMPTLAZY
[ 3215.419859] Tainted: [W]=WARN
[ 3215.419862] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[ 3215.419866] NIP:  c0000000008a9ff4 LR: c0000000008a9ff0 CTR: 
0000000000000000
[ 3215.419870] REGS: c0000001f9d37670 TRAP: 0700   Tainted: G   W        
     (7.0.0-rc1+)
[ 3215.419874] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
24002404  XER: 20040000
[ 3215.419889] CFAR: c0000000001bc194 IRQMASK: 0
[ 3215.419889] GPR00: c0000000008a9ff0 c0000001f9d37910 c00000000243a500 
c000000127e8d600
[ 3215.419889] GPR04: 0000000000000004 0000000000000001 c0000000001bc164 
0000000000000001
[ 3215.419889] GPR08: a80e000000000000 0000000000000000 0000000000000007 
a80e000000000000
[ 3215.419889] GPR12: c00e0001a1a48fb2 c000000d0dde7f00 c000000004e49960 
0000000000000001
[ 3215.419889] GPR16: c00000006e6e0000 0000000000000010 c000000007017fa0 
c000000007017fa4
[ 3215.419889] GPR20: 0000000000000001 c000000007017f88 0000000000080000 
c000000007017f80
[ 3215.419889] GPR24: c00000006e6f0010 c0000000aef32800 c00c0000001b9a2c 
c00000006e690010
[ 3215.419889] GPR28: 0000000000000003 0000000000080020 c00000006e690010 
c00c0000001b9a00
[ 3215.419960] NIP [c0000000008a9ff4] slab_obj_ext+0x2e0/0x338
[ 3215.419966] LR [c0000000008a9ff0] slab_obj_ext+0x2dc/0x338
[ 3215.419972] Call Trace:
[ 3215.419975] [c0000001f9d37910] [c0000000008a9ff0] 
slab_obj_ext+0x2dc/0x338 (unreliable)
[ 3215.419983] [c0000001f9d379c0] [c0000000008b9a64] 
__memcg_slab_free_hook+0x1a4/0x3dc
[ 3215.419990] [c0000001f9d37a90] [c0000000007f8270] kfree+0x454/0x600
[ 3215.419998] [c0000001f9d37b20] [c000000000989724] 
seq_release_private+0x98/0xd4
[ 3215.420005] [c0000001f9d37b60] [c000000000a7adb4] 
proc_map_release+0xa4/0xe0
[ 3215.420012] [c0000001f9d37ba0] [c00000000091edf0] __fput+0x1e8/0x5cc
[ 3215.420019] [c0000001f9d37c20] [c000000000915670] sys_close+0x74/0xd0
[ 3215.420025] [c0000001f9d37c50] [c00000000003aeb0] 
system_call_exception+0x1e0/0x4b0
[ 3215.420033] [c0000001f9d37e50] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[ 3215.420041] ---- interrupt: 3000 at 0x7fff9bd34ab4
[ 3215.420045] NIP:  00007fff9bd34ab4 LR: 00007fff9bd34ab4 CTR: 
0000000000000000
[ 3215.420050] REGS: c0000001f9d37e80 TRAP: 3000   Tainted: G   W        
     (7.0.0-rc1+)
[ 3215.420054] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44002402  XER: 00000000
[ 3215.420077] IRQMASK: 0
[ 3215.420077] GPR00: 0000000000000006 00007fffe2939800 00007fff9bf37f00 
0000000000000003
[ 3215.420077] GPR04: 00007fff9bfe077f 000000000000f881 00007fffe2939820 
000000000000f881
[ 3215.420077] GPR08: 000000000000077f 0000000000000000 0000000000000000 
0000000000000000
[ 3215.420077] GPR12: 0000000000000000 00007fff9c0ab0e0 0000000000000000 
0000000000000000
[ 3215.420077] GPR16: 0000000000000000 00000001235700f0 0000000000000100 
0000000000000001
[ 3215.420077] GPR20: 00000000ffffffff 00000001235702ef 0000000000000000 
fffffffffffffffd
[ 3215.420077] GPR24: 00007fffe2939890 0000000000000000 00007fffe2939978 
00007fff9bf12a88
[ 3215.420077] GPR28: 00007fffe2939974 0000000000010000 0000000000000003 
0000000000010000
[ 3215.420144] NIP [00007fff9bd34ab4] 0x7fff9bd34ab4
[ 3215.420148] LR [00007fff9bd34ab4] 0x7fff9bd34ab4
[ 3215.420151] ---- interrupt: 3000
[ 3215.420154] Code: 4e800020 60000000 60000000 7f18e1d6 7b180020 
7f18f214 7c3bc000 4182febc 3c62ff7a 386336c0 4b9120a9 60000000 
<0fe00000> eac10060 4bffff58 3d200001
[ 3215.420183] ---[ end trace 0000000000000000 ]---

Regards,

Venkat.

> ---
>   mm/slab.h | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   mm/slub.c | 100 ++---------------------------------------
>   2 files changed, 130 insertions(+), 101 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 71c7261bf822..d1e44cd01ea1 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -578,6 +578,101 @@ static inline unsigned short slab_get_stride(struct slab *slab)
>   }
>   #endif
>   
> +#ifdef CONFIG_SLAB_OBJ_EXT
> +
> +/*
> + * Check if memory cgroup or memory allocation profiling is enabled.
> + * If enabled, SLUB tries to reduce memory overhead of accounting
> + * slab objects. If neither is enabled when this function is called,
> + * the optimization is simply skipped to avoid affecting caches that do not
> + * need slabobj_ext metadata.
> + *
> + * However, this may disable optimization when memory cgroup or memory
> + * allocation profiling is used, but slabs are created too early
> + * even before those subsystems are initialized.
> + */
> +static inline bool need_slab_obj_exts(struct kmem_cache *s)
> +{
> +	if (s->flags & SLAB_NO_OBJ_EXT)
> +		return false;
> +
> +	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> +		return true;
> +
> +	if (mem_alloc_profiling_enabled())
> +		return true;
> +
> +	return false;
> +}
> +
> +static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
> +{
> +	return sizeof(struct slabobj_ext) * slab->objects;
> +}
> +
> +static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
> +						    struct slab *slab)
> +{
> +	unsigned long objext_offset;
> +
> +	objext_offset = s->size * slab->objects;
> +	objext_offset = ALIGN(objext_offset, sizeof(struct slabobj_ext));
> +	return objext_offset;
> +}
> +
> +static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
> +						     struct slab *slab)
> +{
> +	unsigned long objext_offset = obj_exts_offset_in_slab(s, slab);
> +	unsigned long objext_size = obj_exts_size_in_slab(slab);
> +
> +	return objext_offset + objext_size <= slab_size(slab);
> +}
> +
> +static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
> +{
> +	unsigned long obj_exts;
> +	unsigned long start;
> +	unsigned long end;
> +
> +	obj_exts = slab_obj_exts(slab);
> +	if (!obj_exts)
> +		return false;
> +
> +	start = (unsigned long)slab_address(slab);
> +	end = start + slab_size(slab);
> +	return (obj_exts >= start) && (obj_exts < end);
> +}
> +#else
> +static inline bool need_slab_obj_exts(struct kmem_cache *s)
> +{
> +	return false;
> +}
> +
> +static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
> +{
> +	return 0;
> +}
> +
> +static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
> +						    struct slab *slab)
> +{
> +	return 0;
> +}
> +
> +static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
> +						     struct slab *slab)
> +{
> +	return false;
> +}
> +
> +static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
> +{
> +	return false;
> +}
> +
> +#endif
> +
>   /*
>    * slab_obj_ext - get the pointer to the slab object extension metadata
>    * associated with an object in a slab.
> @@ -592,13 +687,41 @@ static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
>   					       unsigned long obj_exts,
>   					       unsigned int index)
>   {
> -	struct slabobj_ext *obj_ext;
> +	struct slabobj_ext *ext_before;
> +	struct slabobj_ext *ext_after;
> +	struct obj_cgroup *objcg_before;
> +	struct obj_cgroup *objcg_after;
>   
>   	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
>   
> -	obj_ext = (struct slabobj_ext *)(obj_exts +
> -					 slab_get_stride(slab) * index);
> -	return kasan_reset_tag(obj_ext);
> +	ext_before = (struct slabobj_ext *)(obj_exts +
> +					    slab_get_stride(slab) * index);
> +	objcg_before = ext_before->objcg;
> +	// re-read things after rmb
> +	smp_rmb();
> +	// is ext_before the right obj_ext for this object?
> +	if (obj_exts_in_slab(slab->slab_cache, slab)) {
> +		struct kmem_cache *s = slab->slab_cache;
> +
> +		if (obj_exts_fit_within_slab_leftover(s, slab))
> +			WARN(ext_before != (struct slabobj_ext *)(obj_exts + sizeof(struct slabobj_ext) * index),
> +			     "obj_exts array in leftover");
> +		else
> +			WARN(ext_before != (struct slabobj_ext *)(obj_exts + s->size * index),
> +			     "obj_ext in object");
> +
> +	} else {
> +		WARN(ext_before != (struct slabobj_ext *)(obj_exts + sizeof(struct slabobj_ext) * index),
> +		     "obj_exts array allocated from slab");
> +	}
> +
> +	ext_after = (struct slabobj_ext *)(obj_exts +
> +					   slab_get_stride(slab) * index);
> +	objcg_after = ext_after->objcg;
> +
> +	WARN(ext_before != ext_after, "obj_ext pointer has changed");
> +	WARN(objcg_before != objcg_after, "obj_ext->objcg has changed");
> +	return kasan_reset_tag(ext_before);
>   }
>   
>   int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> diff --git a/mm/slub.c b/mm/slub.c
> index 862642c165ed..8eb64534370e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -757,101 +757,6 @@ static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
>   	return *(unsigned long *)p;
>   }
>   
> -#ifdef CONFIG_SLAB_OBJ_EXT
> -
> -/*
> - * Check if memory cgroup or memory allocation profiling is enabled.
> - * If enabled, SLUB tries to reduce memory overhead of accounting
> - * slab objects. If neither is enabled when this function is called,
> - * the optimization is simply skipped to avoid affecting caches that do not
> - * need slabobj_ext metadata.
> - *
> - * However, this may disable optimization when memory cgroup or memory
> - * allocation profiling is used, but slabs are created too early
> - * even before those subsystems are initialized.
> - */
> -static inline bool need_slab_obj_exts(struct kmem_cache *s)
> -{
> -	if (s->flags & SLAB_NO_OBJ_EXT)
> -		return false;
> -
> -	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> -		return true;
> -
> -	if (mem_alloc_profiling_enabled())
> -		return true;
> -
> -	return false;
> -}
> -
> -static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
> -{
> -	return sizeof(struct slabobj_ext) * slab->objects;
> -}
> -
> -static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
> -						    struct slab *slab)
> -{
> -	unsigned long objext_offset;
> -
> -	objext_offset = s->size * slab->objects;
> -	objext_offset = ALIGN(objext_offset, sizeof(struct slabobj_ext));
> -	return objext_offset;
> -}
> -
> -static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
> -						     struct slab *slab)
> -{
> -	unsigned long objext_offset = obj_exts_offset_in_slab(s, slab);
> -	unsigned long objext_size = obj_exts_size_in_slab(slab);
> -
> -	return objext_offset + objext_size <= slab_size(slab);
> -}
> -
> -static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
> -{
> -	unsigned long obj_exts;
> -	unsigned long start;
> -	unsigned long end;
> -
> -	obj_exts = slab_obj_exts(slab);
> -	if (!obj_exts)
> -		return false;
> -
> -	start = (unsigned long)slab_address(slab);
> -	end = start + slab_size(slab);
> -	return (obj_exts >= start) && (obj_exts < end);
> -}
> -#else
> -static inline bool need_slab_obj_exts(struct kmem_cache *s)
> -{
> -	return false;
> -}
> -
> -static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
> -{
> -	return 0;
> -}
> -
> -static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
> -						    struct slab *slab)
> -{
> -	return 0;
> -}
> -
> -static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
> -						     struct slab *slab)
> -{
> -	return false;
> -}
> -
> -static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
> -{
> -	return false;
> -}
> -
> -#endif
> -
>   #if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
>   static bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
>   {
> @@ -2196,7 +2101,6 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>   retry:
>   	old_exts = READ_ONCE(slab->obj_exts);
>   	handle_failed_objexts_alloc(old_exts, vec, objects);
> -	slab_set_stride(slab, sizeof(struct slabobj_ext));
>   
>   	if (new_slab) {
>   		/*
> @@ -2272,6 +2176,9 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
>   	void *addr;
>   	unsigned long obj_exts;
>   
> +	/* Initialize stride early to avoid memory ordering issues */
> +	slab_set_stride(slab, sizeof(struct slabobj_ext));
> +
>   	if (!need_slab_obj_exts(s))
>   		return;
>   
> @@ -2288,7 +2195,6 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
>   		obj_exts |= MEMCG_DATA_OBJEXTS;
>   #endif
>   		slab->obj_exts = obj_exts;
> -		slab_set_stride(slab, sizeof(struct slabobj_ext));
>   	} else if (s->flags & SLAB_OBJ_EXT_IN_OBJ) {
>   		unsigned int offset = obj_exts_offset_in_object(s);
>   


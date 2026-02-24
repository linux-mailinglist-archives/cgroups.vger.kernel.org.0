Return-Path: <cgroups+bounces-14211-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIXZNcBqnWnhPwQAu9opvQ
	(envelope-from <cgroups+bounces-14211-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 10:09:20 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 590EC18446F
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 10:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0B433012BE2
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 09:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2428336996A;
	Tue, 24 Feb 2026 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gder/YIx"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899636605E
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923905; cv=none; b=KpOBHBO9ukWgz5lshMUY8WAYvSQkGGlm4gghjXosGPdjh9rxmfk2W49AjyD3F+QwJu1NtMK/3rBSua6IBYLu+CQ4HrZyI276cZjK9lPR69bY1BI71nRh1YUrSE88HxLlzmavHESw3EZj1uBiTwHKKXCBMch/8qUvqjEGixQXclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923905; c=relaxed/simple;
	bh=iQlxHyaQElO7wOY19pBq6EplZGn2ni0XOTr8ZW/mTM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgPoSXAXngabpP+pmSl3v5nc+IzB82UtAvAQyiy3pLnwas6cdYtZMeGlcRClvJpecob10GgTzLnjctjcxd5feSGbBxxIC80ZBsb/9C4Vd3SvZ9tkv6M3oELZ7MaZZu7UCjQ8HooQvVYIWh1CoP2q+D65ZMk6s+hsyt//ZWY1XvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gder/YIx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O40HCF1659923;
	Tue, 24 Feb 2026 09:04:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=elcVGD
	XADB6ATou4SMJURL6SYr1e1xq9kOIssIYuBFE=; b=Gder/YIxBZDQXR9+Ry1Isj
	20gPyMguG94Ksb00pZtkro3+4cfiUxK60KfX9HHdQJ5I6kWdG+pvE2gVyW5qAJAF
	qnztDnQL3hkws00k3SJKAuF9hoBpj5BnWL5F/8/T/HZcyGXcldqh93YUf2RNNlUp
	6A4MwL4NS5oht7iCo1IKfEl4Q1NLFvFiN7XMTM7N1dZRyKILJq8eGRJIx4WAxYL5
	Mo1YshQHoroFmnguTdWuZU84QVWtHx7IQNece4jnALNU9Z3PSBWdLPh6RFLBj5Vb
	ayEaIHSFPP40quvWrDVpH9NqO9rHpqZDll1ezKVqhr4Um1C2lKq4FfOPiFp+ZaWA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4brt69k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 09:04:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61O6vwIi013419;
	Tue, 24 Feb 2026 09:04:49 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdy0a53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 09:04:49 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61O94nBI57606520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 09:04:49 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6331A580FA;
	Tue, 24 Feb 2026 09:04:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91D72580FB;
	Tue, 24 Feb 2026 09:04:43 +0000 (GMT)
Received: from [9.61.255.62] (unknown [9.61.255.62])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Feb 2026 09:04:43 +0000 (GMT)
Message-ID: <2d106583-4ec6-4da0-87ea-4ecad893b24f@linux.ibm.com>
Date: Tue, 24 Feb 2026 14:34:41 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: initialize slab->stride early to avoid memory
 ordering issues
Content-Language: en-GB
To: Harry Yoo <harry.yoo@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt
 <shakeel.butt@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20260223075809.19265-1-harry.yoo@oracle.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20260223075809.19265-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Z5nSWCu63VrFa_2fiJdaA71YPDtpVQGk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA3MiBTYWx0ZWRfXxveHu2FahzTA
 eQ+f+ksa90RYxDbUoLfiaupxah+g6FZOLGAOMh77ZV7PooOvlgPuiTjqsvWJ1GJOgW42mA3OZPd
 EnN67QEzEfGFiUupGZbW3YF2SuzHiRXYhTCCsutfmgEG9SaZTG+/5L9m8XxuALKaoxYin5gkqit
 lcTp53+9UBtCUWQC+iO17Vt2U8xwkQ/FLMwKz0aDgZhCosTvFVa9LHctLMfFAGfauW+ENUjUtOG
 S3bzZjE8uW7Pn9r4Cqodec2yusERb6uszM0mo0/6CwcGNtoPnfe5e6Tr8yJT3zjhl6RDu2X+o1f
 /9S2+3gNEl1EzyqgTJgHiR3/n0RdEx8U6YLaF+aG4l0IkC6LEnZpw0wubfcVuw3Jif4fhysw93U
 lsEL6DCtJnN2tRzE5yxvPRFfZWdHUWFJlzPRAf4W4QHTgMNwCvDmQWmSnd0+PodGvCV+GqXfnQ/
 gImlBDAmzqKj7UCSo1w==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=699d69b2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=_LULtc8Kd5tF9QE_vaIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zbF5URYQJdRdQDJ5THosgT2RZEH91lM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240072
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-14211-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[venkat88@linux.ibm.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 590EC18446F
X-Rspamd-Action: no action


On 23/02/26 1:28 pm, Harry Yoo wrote:
> When alloc_slab_obj_exts() is called later in time (instead of at slab
> allocation & initialization step), slab->stride and slab->obj_exts are
> set when the slab is already accessible by multiple CPUs.
>
> The current implementation does not enforce memory ordering between
> slab->stride and slab->obj_exts. However, for correctness, slab->stride
> must be visible before slab->obj_exts, otherwise concurrent readers
> may observe slab->obj_exts as non-zero while stride is still stale,
> leading to incorrect reference counting of object cgroups.
>
> There has been a bug report [1] that showed symptoms of incorrect
> reference counting of object cgroups, which could be triggered by
> this memory ordering issue.
>
> Fix this by unconditionally initializing slab->stride in
> alloc_slab_obj_exts_early(), before the need_slab_obj_exts() check.
> In case of SLAB_OBJ_EXT_IN_OBJ, it is overridden in the same function.
>
> This ensures stride is set before the slab becomes visible to
> other CPUs via the per-node partial slab list (protected by spinlock
> with acquire/release semantics), preventing them from observing
> inconsistent stride value.
>
> Thanks to Shakeel Butt for pointing out this issue [2].
>
> Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com [1]
> Link: https://lore.kernel.org/linux-mm/aZu9G9mVIVzSm6Ft@hyeyoo [2]
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>
> I tested this patch, but I could not confirm that this actually fixes
> the issue reported by [1]. It would be nice if Venkat could help
> confirm; but perhaps it's challenging to reliably reproduce...


Thanks for the patch. I did ran the complete test suite, and 
unfortunately issue is reproducing.

I applied this patch on mainline repo for testing.

Traces:

[ 9316.514161] BUG: Kernel NULL pointer dereference on read at 0x00000000
[ 9316.514169] Faulting instruction address: 0xc0000000008b2ff4
[ 9316.514176] Oops: Kernel access of bad area, sig: 7 [#1]
[ 9316.514182] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[ 9316.514189] Modules linked in: overlay dm_zero dm_thin_pool 
dm_persistent_data dm_bio_prison dm_snapshot dm_bufio dm_flakey xfs loop 
dm_mod nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat 
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set bonding nf_tables tls 
sunrpc rfkill nfnetlink pseries_rng vmx_crypto dax_pmem fuse ext4 crc16 
mbcache jbd2 nd_pmem papr_scm sd_mod libnvdimm sg ibmvscsi ibmveth 
scsi_transport_srp pseries_wdt [last unloaded: scsi_debug]
[ 9316.514295] CPU: 16 UID: 0 PID: 0 Comm: swapper/16 Kdump: loaded 
Tainted: G        W           7.0.0-rc1+ #1 PREEMPTLAZY
[ 9316.514306] Tainted: [W]=WARN
[ 9316.514311] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[ 9316.514318] NIP:  c0000000008b2ff4 LR: c0000000008b2fec CTR: 
c00000000036d680
[ 9316.514326] REGS: c000000d0dcb7870 TRAP: 0300   Tainted: G   W        
     (7.0.0-rc1+)
[ 9316.514333] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
84042802  XER: 20040000
[ 9316.514356] CFAR: c000000000862e94 DAR: 0000000000000000 DSISR: 
00080000 IRQMASK: 0
[ 9316.514356] GPR00: c0000000008b2fec c000000d0dcb7b10 c00000000243a500 
0000000000000001
[ 9316.514356] GPR04: 0000000000000008 0000000000000001 c0000000008b2fec 
0000000000000001
[ 9316.514356] GPR08: a80e000000000000 0000000000000001 0000000000000007 
a80e000000000000
[ 9316.514356] GPR12: c00e00000e7b6cd5 c000000d0ddf4700 c000000129a98e00 
0000000000000006
[ 9316.514356] GPR16: c000000007012fa0 c000000007012fa4 c000000005160980 
c000000007012f88
[ 9316.514356] GPR20: c00c000000021bec c000000d0d07f008 0000000000000001 
ffffffffffffff78
[ 9316.514356] GPR24: 0000000000000005 c000000d0d58f180 c0000000032cf000 
c000000d0ddf4700
[ 9316.514356] GPR28: 0000000000000088 0000000000000000 c000000129a98e00 
c000000d0d07f000
[ 9316.514457] NIP [c0000000008b2ff4] refill_obj_stock+0x5b4/0x680
[ 9316.514467] LR [c0000000008b2fec] refill_obj_stock+0x5ac/0x680
[ 9316.514476] Call Trace:
[ 9316.514481] [c000000d0dcb7b10] [c0000000008b2fec] 
refill_obj_stock+0x5ac/0x680 (unreliable)
[ 9316.514494] [c000000d0dcb7b90] [c0000000008b9598] 
__memcg_slab_free_hook+0x238/0x3ec
[ 9316.514505] [c000000d0dcb7c60] [c0000000007f3d90] 
__rcu_free_sheaf_prepare+0x314/0x3e8
[ 9316.514516] [c000000d0dcb7d10] [c0000000007fc2ec] 
rcu_free_sheaf+0x38/0x170
[ 9316.514528] [c000000d0dcb7d50] [c000000000334570] 
rcu_do_batch+0x2ec/0xfa8
[ 9316.514538] [c000000d0dcb7e50] [c000000000339a08] rcu_core+0x22c/0x48c
[ 9316.514548] [c000000d0dcb7ec0] [c0000000001cfeac] 
handle_softirqs+0x1f4/0x74c
[ 9316.514559] [c000000d0dcb7fe0] [c00000000001b0cc] 
do_softirq_own_stack+0x60/0x7c
[ 9316.514570] [c0000000096c7930] [c00000000001b0b8] 
do_softirq_own_stack+0x4c/0x7c
[ 9316.514581] [c0000000096c7960] [c0000000001cf168] 
__irq_exit_rcu+0x268/0x308
[ 9316.514592] [c0000000096c79a0] [c0000000001d0be4] irq_exit+0x20/0x38
[ 9316.514602] [c0000000096c79c0] [c0000000000315f4] 
interrupt_async_exit_prepare.constprop.0+0x18/0x2c
[ 9316.514614] [c0000000096c79e0] [c000000000009ffc] 
decrementer_common_virt+0x28c/0x290
[ 9316.514626] ---- interrupt: 900 at plpar_hcall_norets_notrace+0x18/0x2c
[ 9316.514635] NIP:  c00000000012d9f0 LR: c00000000135c0a8 CTR: 
0000000000000000
[ 9316.514642] REGS: c0000000096c7a10 TRAP: 0900   Tainted: G   W        
     (7.0.0-rc1+)
[ 9316.514649] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  
CR: 24000804  XER: 00000000
[ 9316.514678] CFAR: 0000000000000000 IRQMASK: 0
[ 9316.514678] GPR00: 0000000000000000 c0000000096c7cb0 c00000000243a500 
0000000000000000
[ 9316.514678] GPR04: 0000000000000000 800400002fe6fc10 0000000000000000 
0000000000000001
[ 9316.514678] GPR08: 0000000000000030 0000000000000000 0000000000000090 
0000000000000001
[ 9316.514678] GPR12: 800400002fe6fc00 c000000d0ddf4700 0000000000000000 
000000002ef01a00
[ 9316.514678] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[ 9316.514678] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000001
[ 9316.514678] GPR24: 0000000000000000 c000000004d7a760 000008792ad04b82 
0000000000000000
[ 9316.514678] GPR28: 0000000000000000 0000000000000001 c0000000032b18d8 
c0000000032b18e0
[ 9316.514774] NIP [c00000000012d9f0] plpar_hcall_norets_notrace+0x18/0x2c
[ 9316.514782] LR [c00000000135c0a8] cede_processor.isra.0+0x1c/0x34
[ 9316.514792] ---- interrupt: 900
[ 9316.514797] [c0000000096c7cb0] [c0000000096c7cf0] 0xc0000000096c7cf0 
(unreliable)
[ 9316.514808] [c0000000096c7d10] [c0000000019af170] 
dedicated_cede_loop+0x90/0x170
[ 9316.514819] [c0000000096c7d60] [c0000000019aeb20] 
cpuidle_enter_state+0x394/0x480
[ 9316.514830] [c0000000096c7e00] [c00000000135864c] cpuidle_enter+0x64/0x9c
[ 9316.514840] [c0000000096c7e50] [c000000000284b0c] call_cpuidle+0x7c/0xf8
[ 9316.514852] [c0000000096c7e90] [c0000000002903e8] 
cpuidle_idle_call+0x1c4/0x2b4
[ 9316.514862] [c0000000096c7f00] [c00000000029060c] do_idle+0x134/0x208
[ 9316.514872] [c0000000096c7f50] [c000000000290a5c] 
cpu_startup_entry+0x60/0x64
[ 9316.514882] [c0000000096c7f80] [c000000000074738] 
start_secondary+0x3fc/0x400
[ 9316.514894] [c0000000096c7fe0] [c00000000000e258] 
start_secondary_prolog+0x10/0x14
[ 9316.514904] Code: eba962a0 4bfffe40 60000000 387e0008 4bfae7c1 
60000000 ebbe0008 38800008 7fa3eb78 4bfafe85 60000000 39200001 
<7d40e8a8> 7d495214 7d40e9ad 40c2fff4
[ 9316.514941] ---[ end trace 0000000000000000 ]---


Regards,

Venkat.

>
> Since this logically makes sense, it would be worth fix it anyway.
>
>   mm/slub.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 18c30872d196..afa98065d74f 100644
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
> @@ -2272,6 +2271,9 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
>   	void *addr;
>   	unsigned long obj_exts;
>   
> +	/* Initialize stride early to avoid memory ordering issues */
> +	slab_set_stride(slab, sizeof(struct slabobj_ext));
> +
>   	if (!need_slab_obj_exts(s))
>   		return;
>   
> @@ -2288,7 +2290,6 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
>   		obj_exts |= MEMCG_DATA_OBJEXTS;
>   #endif
>   		slab->obj_exts = obj_exts;
> -		slab_set_stride(slab, sizeof(struct slabobj_ext));
>   	} else if (s->flags & SLAB_OBJ_EXT_IN_OBJ) {
>   		unsigned int offset = obj_exts_offset_in_object(s);
>   


Return-Path: <cgroups+bounces-14467-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MIWOatloWkCsgQAu9opvQ
	(envelope-from <cgroups+bounces-14467-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 10:36:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0BA1B56DC
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 10:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8911B3012808
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 09:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C0E38BF63;
	Fri, 27 Feb 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XNqPdVPf"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B53563E5
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184996; cv=none; b=Ns2cNDJAipVFJjQxZyuSsBAR9tbGaZV03tGcZbdrSPxkXalAPe3Fe1MGSc/cW/RJvkr41KXPkRsM7GgbsWCv7RCe8n2NmWac3KoB/asog7jfbX2lx4rAET/ld15nkXBS0U4HIJaB0ciKQYxIsRUIbcKwc8ncI3Yenx95o3aieQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184996; c=relaxed/simple;
	bh=DvOLkzBAUhktKXypBD49thWh9IsiynOHyjBH3vLg5fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfMpyDtHVLv1Q+yNRycdae6BKvpZoHykLJljjZt7Tv9QTAGkp8XWvUiN5oUsYPCpv/UKlmfSQqHUN1Y8a+1zngcSZANfeyBIJbJGY4u8S9j0Zee+sYIHbpVEQU5sBIenq/upiFL8QKav1rH89OnNI87h9jaTzdHjia/Q/TbEYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XNqPdVPf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QMIqcc2822762;
	Fri, 27 Feb 2026 09:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rXT+wH
	XTHEeqHaoiG9BqzYfep5ZpY23UCejcjQ9wVdw=; b=XNqPdVPfiYhSjetJv664fp
	yfcw+mEUgw0CPgYSQeT0DD5niz76S53TbPr7jvnnE3g5dJS8xe+KKdnAJUzFKZc4
	vOaW7JMFiA9aX9NwwE1nQPmRkqAOBUnI1ZwAGbcPRc2j13SRgihJajPTyw7sA0a+
	ZVM6yDdcQ6QPuxpEeptCl6L+CPVnV1qbdXGcNJ78HP57K9BTJE47Q3guq1HoGST4
	J5gs7zv0Vg/EZJbZsoxD7q2hhEzTcMTeY8OvW07LfrBupu3mmEEh8A3iZjEJhDrN
	77gseJcvLDdxfw5+b+dxY/XrE1M67YQayNg+SWn7bOmDUsGaYULPVm3bjS+an6EQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gu6qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:36:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R74pT7013448;
	Fri, 27 Feb 2026 09:36:15 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdyhgw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:36:15 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61R9aEiL32768548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 09:36:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA6805805A;
	Fri, 27 Feb 2026 09:36:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0776B5805F;
	Fri, 27 Feb 2026 09:36:10 +0000 (GMT)
Received: from [9.61.248.160] (unknown [9.61.248.160])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Feb 2026 09:36:09 +0000 (GMT)
Message-ID: <69961f16-3c2e-4734-9ddf-2d406a57c7d1@linux.ibm.com>
Date: Fri, 27 Feb 2026 15:06:08 +0530
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
 <dc88bc66-77ad-4762-80f6-18a1262d5355@linux.ibm.com>
 <aaFRycdCdrsjED2r@hyeyoo>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <aaFRycdCdrsjED2r@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=69a16590 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8
 a=Mbj8pcPIKCW-We4bv7oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TEHR5DQ5Jdc_s09MK4FWC1PUfzW3lLaL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA3OCBTYWx0ZWRfX45uX84dPif6N
 kMLrbCK5D1APV2evJLbN5RYIHENgz0QHu2xlQypsGpREuqlCtP4hgb0LqhPP1wuguB09m92jawy
 Gb+tm9fDTQD9mfAngFrBfZwk2CqP4azWCEnqnOVndWhGoefETbnbTowHf7fb02RxwUPB6UO7CGw
 Am9NB8zJj+I/lBo3FM0Z2AqHfYgOPc8EYwYDUHVYtim7itKbZkX2ZmbL0Uwg/RUK5zECPRa3aaV
 Lld0maY+KMKUjy5lHVCJTCfIAUZzj9JkBFg4kWqJ8wgcUdx54U+Zugx0Udn2YSGETf5N41VmRd0
 MjGCkZr0nKYWtUvPcUO8UVafbMiSrWLz165ljso51AypQ7hF+YOzsIEPqDS8ZT/ghKGnI6DsQca
 QxIvVOqKlO58zuKIP87NndcgvXP6UQa0Cw/2baI8TrDNkEMfTuUEuWBPdpPxyOkuJ89ecdRZM4A
 p39lgT7ZqklsQyDwcmg==
X-Proofpoint-ORIG-GUID: iioHsRvUlTxlRTJfw065uklTrOrIR_bf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270078
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-14467-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[venkat88@linux.ibm.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1B0BA1B56DC
X-Rspamd-Action: no action


On 27/02/26 1:41 pm, Harry Yoo wrote:
> On Fri, Feb 27, 2026 at 01:32:29PM +0530, Venkat Rao Bagalkote wrote:
>> On 27/02/26 8:37 am, Harry Yoo wrote:
>>> Hi Venkat, could you please help testing this patch and
>>> check if it hits any warning? It's based on v7.0-rc1 tag.
>>>
>>> This (hopefully) should give us more information
>>> that would help debugging the issue.
>>>
>>> 1. set stride early in alloc_slab_obj_exts_early()
>>> 2. move some obj_exts helpers to slab.h
>>> 3. in slab_obj_ext(), check three things:
>>>      3-1. is the obj_ext address is the right one for this object?
>>>      3-2. does the obj_ext address change after smp_rmb()?
>>>      3-3. does obj_ext->objcg change after smp_rmb()?
>>>
>>> No smp_wmb() is used, intentionally.
>>>
>>> It is expected that the issue will still reproduce.
>>>
>>> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
>>
>> Hello Harry,
> Hello Venkat!
>
>> I’ve restarted the test
> Thanks :)
>
>> but there are continuous warning prints in the
>> logs, and they appear to be slowing down the test run significantly.
> It's okay! the purpose of this patch is to see if there's any warning
> hitting, rather than triggering the kernel crash.
>
>> Warnings:
>>
>> [ 3215.419760] obj_ext in object
> The patch adds five different warnings:
>
> 1) "obj_exts array in leftover"
> 2) "obj_ext in object"
> 3) "obj_exts array allocated from slab"
> 4) "obj_ext pointer has changed"
> 5) "obj_ext->objcg has changed"
>
> Is 2) the only warning that is triggered?
>
> Also, the warning below says it's triggered by proc_map_release().
>
> Are there any other call stacks, or is this the only caller that hits
> this warning?

I’m continuing to see only warning (2) – “obj_ext in object”, but it is 
being triggered from multiple different callers.

So far I have observed the warning originating from the following call 
paths:


kfree → seq_release_private → proc_map_release → __fput


kfree → seq_release_private → mounts_release → __fput


__memcg_slab_post_alloc_hook → __kvmalloc_node_noprof → seq_read_iter → 
vfs_read


There are many other WARN splats in the logs due to repeated hits, but 
the only warning string I’ve seen is (2) “obj_ext in object”, just 
triggered from different code paths


Regards,

Venkat.

>
> Thanks!
>
>> [ 3215.419774] WARNING: mm/slab.h:710 at slab_obj_ext+0x2e0/0x338, CPU#26:
>> grep/103571 >
>> [ 3215.419783] Modules linked in: xfs loop dm_mod bonding tls rfkill
>> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
>> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat
>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc
>> pseries_rng vmx_crypto dax_pmem fuse ext4 crc16 mbcache jbd2 sd_mod nd_pmem
>> sg papr_scm libnvdimm ibmvscsi ibmveth scsi_transport_srp pseries_wdt
>> [ 3215.419852] CPU: 26 UID: 0 PID: 103571 Comm: grep Kdump: loaded Tainted:
>> G        W           7.0.0-rc1+ #3 PREEMPTLAZY
>> [ 3215.419859] Tainted: [W]=WARN
>> [ 3215.419862] Hardware name: IBM,9080-HEX Power11 (architected) 0x820200
>> 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
>> [ 3215.419866] NIP:  c0000000008a9ff4 LR: c0000000008a9ff0 CTR:
>> 0000000000000000
>> [ 3215.419870] REGS: c0000001f9d37670 TRAP: 0700   Tainted: G   W
>> (7.0.0-rc1+)
>> [ 3215.419874] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24002404
>> XER: 20040000
>> [ 3215.419889] CFAR: c0000000001bc194 IRQMASK: 0
>> [ 3215.419889] GPR00: c0000000008a9ff0 c0000001f9d37910 c00000000243a500
>> c000000127e8d600
>> [ 3215.419889] GPR04: 0000000000000004 0000000000000001 c0000000001bc164
>> 0000000000000001
>> [ 3215.419889] GPR08: a80e000000000000 0000000000000000 0000000000000007
>> a80e000000000000
>> [ 3215.419889] GPR12: c00e0001a1a48fb2 c000000d0dde7f00 c000000004e49960
>> 0000000000000001
>> [ 3215.419889] GPR16: c00000006e6e0000 0000000000000010 c000000007017fa0
>> c000000007017fa4
>> [ 3215.419889] GPR20: 0000000000000001 c000000007017f88 0000000000080000
>> c000000007017f80
>> [ 3215.419889] GPR24: c00000006e6f0010 c0000000aef32800 c00c0000001b9a2c
>> c00000006e690010
>> [ 3215.419889] GPR28: 0000000000000003 0000000000080020 c00000006e690010
>> c00c0000001b9a00
>> [ 3215.419960] NIP [c0000000008a9ff4] slab_obj_ext+0x2e0/0x338
>> [ 3215.419966] LR [c0000000008a9ff0] slab_obj_ext+0x2dc/0x338
>> [ 3215.419972] Call Trace:
>> [ 3215.419975] [c0000001f9d37910] [c0000000008a9ff0]
>> slab_obj_ext+0x2dc/0x338 (unreliable)
>> [ 3215.419983] [c0000001f9d379c0] [c0000000008b9a64]
>> __memcg_slab_free_hook+0x1a4/0x3dc
>> [ 3215.419990] [c0000001f9d37a90] [c0000000007f8270] kfree+0x454/0x600
>> [ 3215.419998] [c0000001f9d37b20] [c000000000989724]
>> seq_release_private+0x98/0xd4
>> [ 3215.420005] [c0000001f9d37b60] [c000000000a7adb4]
>> proc_map_release+0xa4/0xe0
>> [ 3215.420012] [c0000001f9d37ba0] [c00000000091edf0] __fput+0x1e8/0x5cc
>> [ 3215.420019] [c0000001f9d37c20] [c000000000915670] sys_close+0x74/0xd0
>> [ 3215.420025] [c0000001f9d37c50] [c00000000003aeb0]
>> system_call_exception+0x1e0/0x4b0
>> [ 3215.420033] [c0000001f9d37e50] [c00000000000d05c]
>> system_call_vectored_common+0x15c/0x2ec
>> [ 3215.420041] ---- interrupt: 3000 at 0x7fff9bd34ab4
>> [ 3215.420045] NIP:  00007fff9bd34ab4 LR: 00007fff9bd34ab4 CTR:
>> 0000000000000000
>> [ 3215.420050] REGS: c0000001f9d37e80 TRAP: 3000   Tainted: G   W
>> (7.0.0-rc1+)
>> [ 3215.420054] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>
>> CR: 44002402  XER: 00000000
>> [ 3215.420077] IRQMASK: 0
>> [ 3215.420077] GPR00: 0000000000000006 00007fffe2939800 00007fff9bf37f00
>> 0000000000000003
>> [ 3215.420077] GPR04: 00007fff9bfe077f 000000000000f881 00007fffe2939820
>> 000000000000f881
>> [ 3215.420077] GPR08: 000000000000077f 0000000000000000 0000000000000000
>> 0000000000000000
>> [ 3215.420077] GPR12: 0000000000000000 00007fff9c0ab0e0 0000000000000000
>> 0000000000000000
>> [ 3215.420077] GPR16: 0000000000000000 00000001235700f0 0000000000000100
>> 0000000000000001
>> [ 3215.420077] GPR20: 00000000ffffffff 00000001235702ef 0000000000000000
>> fffffffffffffffd
>> [ 3215.420077] GPR24: 00007fffe2939890 0000000000000000 00007fffe2939978
>> 00007fff9bf12a88
>> [ 3215.420077] GPR28: 00007fffe2939974 0000000000010000 0000000000000003
>> 0000000000010000
>> [ 3215.420144] NIP [00007fff9bd34ab4] 0x7fff9bd34ab4
>> [ 3215.420148] LR [00007fff9bd34ab4] 0x7fff9bd34ab4
>> [ 3215.420151] ---- interrupt: 3000
>> [ 3215.420154] Code: 4e800020 60000000 60000000 7f18e1d6 7b180020 7f18f214
>> 7c3bc000 4182febc 3c62ff7a 386336c0 4b9120a9 60000000 <0fe00000> eac10060
>> 4bffff58 3d200001
>> [ 3215.420183] ---[ end trace 0000000000000000 ]---
>>
>> Regards,
>>
>> Venkat.


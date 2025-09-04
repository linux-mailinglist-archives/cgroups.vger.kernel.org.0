Return-Path: <cgroups+bounces-9702-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EAFB4374F
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 11:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0F6188CBC7
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 09:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2A52F7455;
	Thu,  4 Sep 2025 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aPK/l/nE"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22F2C08A8;
	Thu,  4 Sep 2025 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978643; cv=none; b=WAfzmx8Hcg+j3IMdKhRIn5GUony/5KoCR7iBH/uGrpDdoc+nS3rCqY7pqXTBsLTBSGbm4BKqwhHeMXsbei+5EgQNZeZgD4kpwQkBiglfMFolT3EuOjkgtzrXBVtNI7bhvPJuIoaW8RDnNwXVuBst0cPvBlK5VrSn+9xI7CKFbtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978643; c=relaxed/simple;
	bh=Ru8LuNV8bt6ini4vsqcji1npJYCBupUTZdYydr2pSVs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boebUQT8Qxm7s4wVO/9mfOS684timi+DV1s/4iO909uyxP78Cy8p8vDJlcvmiOwi/vri18ywyEykIPQ+C6nzEMHqQFHhm+9JXCCqKWfxQgc/yN67Q2R9LPabEy4SxLQWn8173v8sEIIKMV35augFTZO76jdifpZg3+rWeVkI/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aPK/l/nE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849XbGE032532;
	Thu, 4 Sep 2025 09:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ut+Aq//GktFW68mBohguf53n8Nv4N9BK/1mX88xZtS0=; b=aPK/l/nEmuI9qdyo
	sb6kfBbDR+diWqBAiKVD9tuCFBBOg6C1Mog2HBXSSv59tuJhm6lv6SSA8fRI/yfz
	LLk5r6ZqPLQ7FUwhvmFQn3QxjvUWJ/Vzh4IHXcJ8CiWPSwdbiCtWHZGXxNfUayJw
	JJcrNEyULEkGjz2uvZnBctk70AOhWgvw5XC0vetD/U5O7nv+ikzLY2+SKUIelEOW
	RJTv4hLS6uQTtpOBBtAXEi0IC6Lx2XVMqD8rkoBfVxr8Sdw+HjNDnaKQjgDhUk3b
	gxgOImLVwJZV+dCHEE0W1j2/6gjoEAsMcdeylTQ0/KDZwOUjdTgc2OcnSn5uyW8h
	0lUK+w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpf55y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 09:37:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5849b85O025642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Sep 2025 09:37:08 GMT
Received: from hu-ashayj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 4 Sep 2025 02:37:05 -0700
Date: Thu, 4 Sep 2025 15:07:02 +0530
From: Ashay Jaiswal <quic_ashayj@quicinc.com>
To: Waiman Long <llong@redhat.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?=
	<mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)"
	<peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] cpuset: prevent freeing unallocated cpumask in hotplug
 handling
Message-ID: <aLldvhYAYwHIlvXi@hu-ashayj-hyd.qualcomm.com>
References: <20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com>
 <533633c5-90cc-4a35-9ec3-9df2720a6e9e@redhat.com>
 <927f1afc-4fd4-4d42-948b-5da355443a4a@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <927f1afc-4fd4-4d42-948b-5da355443a4a@redhat.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xClNHPCjTsBaVIK_VtBh9cwVmHqsRmcj
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b95dc5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=8nJEP1OIZ-IA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=Sa9plrczSu04kPGlYXoA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: xClNHPCjTsBaVIK_VtBh9cwVmHqsRmcj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX1ChNzD/vSgso
 le0JInI+0Cv1heh4ap4Aq8nV0KuVZRrlXH3IRlQQKm/wnurRbejhYkkRKd8cucgQdqsT4k/yUa1
 ogXu/vW/PxaAnMW2fwU5ZWxhaw9R4j48wY3c1g3NT/ijheXD3PExzRtHTC9Rw3Tqu1jYzWVBtJt
 b9UMcMWsgp2coi58VEyJKo8ttsngvBYm1Crdr3ttPiDH3sWrNbsWmALiGDmVlSP0Y5RanUtj+VS
 SltmV6bNFa9toPMrxNKWSjvnZIMkJu3T/oWs/IIVb8n0ORp5xCv3BUlG63JkEOI+qvNtVYtKNej
 9/HAQuD4kKN087Szh+p9NnyK90auofGilIuziEmJxvI/RqBpCQYTA8QRIS34cQzY8qqlFIm71wV
 2eEAJ5+8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On Tue, Sep 02, 2025 at 02:21:25PM -0400, Waiman Long wrote:
> On 9/2/25 1:14 PM, Waiman Long wrote:
> > 
> > On 9/2/25 12:26 AM, Ashay Jaiswal wrote:
> > > In cpuset hotplug handling, temporary cpumasks are allocated only when
> > > running under cgroup v2. The current code unconditionally frees these
> > > masks, which can lead to a crash on cgroup v1 case.
> > > 
> > > Free the temporary cpumasks only when they were actually allocated.
> > > 
> > > Fixes: 4b842da276a8 ("cpuset: Make CPU hotplug work with partition")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
> > > ---
> > >   kernel/cgroup/cpuset.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > > index a78ccd11ce9b43c2e8b0e2c454a8ee845ebdc808..a4f908024f3c0a22628a32f8a5b0ae96c7dccbb9
> > > 100644
> > > --- a/kernel/cgroup/cpuset.c
> > > +++ b/kernel/cgroup/cpuset.c
> > > @@ -4019,7 +4019,8 @@ static void cpuset_handle_hotplug(void)
> > >       if (force_sd_rebuild)
> > >           rebuild_sched_domains_cpuslocked();
> > >   -    free_tmpmasks(ptmp);
> > > +    if (on_dfl && ptmp)
> > > +        free_tmpmasks(ptmp);
> > >   }
> > >     void cpuset_update_active_cpus(void)
> > The patch that introduces the bug is actually commit 5806b3d05165
> > ("cpuset: decouple tmpmasks and cpumasks freeing in cgroup") which
> > removes the NULL check. The on_dfl check is not necessary and I would
> > suggest adding the NULL check in free_tmpmasks().
> 
> As this email was bounced back from your email account because it is full, I
> decide to send out another patch on your behalf. Note that this affects only
> the linux-next tree as the commit to be fixed isn't merged into the mainline
> yet. There is no need for stable branch backport.
>

Thank you for your help, and I apologize for the email bouncing back.

> Cheers,
> Longman
> 


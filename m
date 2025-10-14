Return-Path: <cgroups+bounces-10722-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 205EBBD8DC8
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 13:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952D11924D31
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E222FE588;
	Tue, 14 Oct 2025 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H/Vlu1n3"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861B42FC87F;
	Tue, 14 Oct 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439529; cv=none; b=f4ZJRAR8WcAJLNy1AKP3rnasGPkFeobk243ea1E08APjQhK+5eGOeQ1IxhzRAsrBLfmu/4QwCfoahBQu2DwpDXA9S+s6edqpCUzfdbXvxjKAwGRuR1Nrs06tN4X4ExUXFaVe2nC6t12+2T9SJPqH0HzMLfehzvibXHkmdpYT8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439529; c=relaxed/simple;
	bh=5rqwZvjKItbDOtzZ0xHughjl/U2NF1KesCWEd0aoUlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/q1m++K/Jl1bfn77b0G/Qg/MF8ACZvGMUF3LPdFVhX6gOcUjX9k9OyAT08+hxDZFVrbuC+e+ryqH1FMLQjJ17NhpnC/CG1oRjs/Bvjha/N7jUBp/3ob+RdRtcrJ2LzSk4Nb4+3ywHHRzQ1Z5U+n2cwWh0UmuRwPvtxNv5qlSVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H/Vlu1n3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E6YYhZ007910;
	Tue, 14 Oct 2025 10:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F7V/Rx
	o+tXczlthz44MQCgbOQzSNuAsO8TQ1Q1KuhA0=; b=H/Vlu1n3ELLfLyr5CKfojW
	EuqBNuwwW6n9D9f3GDVTdFdAs9kRMtEzPmCfSf848a2tXGudiJBVSIzt8mPa7uQj
	HaEggFsb2w1wIR35YJdbXM+vmP8c7/OOOYrSP1pMxuw6Lsqxy9yIFxPhH6dNVZOs
	BFgYXeEms0pOR4AvLIqGsppjAYVsI3IDKgIsTtR1Sef2/NQ4fqu+OTPLS8aKXllK
	qvfh1m/3xRQgkrK+TaBGu2HBHaBGGsSKvD1mpe1SRw1ME69zCw5kYXElGYbFRuO8
	K74K/ZyThYJfss4leS3aVJWYwp5+euvIRKlpkE8ytUIOYZOiCystMNrBc7Wc28aQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp7rysg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 10:58:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59E7hOEj016759;
	Tue, 14 Oct 2025 10:58:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jtds9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 10:58:24 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59EAwN6e10617642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 10:58:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4AC958043;
	Tue, 14 Oct 2025 10:58:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2220E58059;
	Tue, 14 Oct 2025 10:58:20 +0000 (GMT)
Received: from [9.109.198.148] (unknown [9.109.198.148])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 10:58:19 +0000 (GMT)
Message-ID: <d4fe218b-9fc5-4466-ac56-0d4c5a8ccd96@linux.ibm.com>
Date: Tue, 14 Oct 2025 16:28:18 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] blk-rq-qos: fix possible deadlock
To: Yu Kuai <yukuai3@huawei.com>, ming.lei@redhat.com, tj@kernel.org,
        josef@toxicpanda.com, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20251014022149.947800-1-yukuai3@huawei.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251014022149.947800-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HILzvO3m92YdpNkRJP-yfc3N3mCh1eXG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfXwlT+flw60rH5
 L9DmuLWcTn1ryN2smAC9aKRM6GrHX95Hp+IuiRVXk/Xl33CwEebNSwZ/ir+Md+vx6TmMmY6kzXG
 NyuRt/EvOl846ECK6NCH7uDtagi0vHN4Y6Zfm40K6TXc0fjAiUvMSe/dHadaCmCbM95uDvHqYte
 gMbw5PpZkaymC8LGTsBh/wAb5hvJTjVtJqGs3abCyizSWIQ0ApKYSEqQKUl6E+vTnOZJzbgjDA1
 WlXsWJiSbaXKy5ZUT7Z1LEW0qXSr41zeLwtdCaSRU87o+QxW/QBemxgMlzMKLYwTMKuph1/ymAY
 /xP+SdLzzozWXRzK90dNeJqr52WK92tjUf7HeG6U/mzE7+ozLj0FHwI9mOvgrfYJ9kz/hI6eV/g
 w+ExbyDow4vsEre7xhiJVzxdt+/7cA==
X-Proofpoint-GUID: HILzvO3m92YdpNkRJP-yfc3N3mCh1eXG
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68ee2cd1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=9q18dwRBEjaL5AJRs_kA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084



On 10/14/25 7:51 AM, Yu Kuai wrote:
> Currently rq-qos debugfs entries is created from rq_qos_add(), while
> rq_qos_add() requires queue to be freezed. This can deadlock because
> 
> creating new entries can trigger fs reclaim.
> 
> Fix this problem by delaying creating rq-qos debugfs entries until
> it's initialization is complete.
> 
> - For wbt, it can be initialized by default of by blk-sysfs, fix it by
>   delaying after wbt_init();
> - For other policies, they can only be initialized by blkg configuration,
>   fix it by delaying to blkg_conf_end();
> 
> Noted this set is cooked on the top of my other thread:
> https://lore.kernel.org/all/20251010091446.3048529-1-yukuai@kernel.org/
> 
> And the deadlock can be reporduced with above thead, by running blktests
> throtl/001 with wbt enabled by default. While the deadlock is really a
> long term problem.
> 
While freezing the queue we also mark GFP_NOIO scope, so doesn't that
help avoid fs-reclaim? Or maybe if you can share the lockdep splat 
encountered running throtl/001?

Thanks,
--Nilay


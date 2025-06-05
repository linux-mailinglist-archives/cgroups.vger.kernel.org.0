Return-Path: <cgroups+bounces-8442-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B173ACF263
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 16:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5203188FD1C
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30CD19047F;
	Thu,  5 Jun 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GVDE04oH"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740415746F;
	Thu,  5 Jun 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135322; cv=none; b=ApyjGp2FW3epAy1IoFkWPKltqF0lvGRp1HjH0I47CU+hWYG2QZnQqVmcSMtoIdm5+SKIAbjpHB+X2ObqVa+DsqwPRQQ4BdWRKTTB9pCJuHjd1s5JEfPTutAYQouhG90gV1NfMra0wGDKsYW7F2XILhgya7z86OU2Vlw8OVuQxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135322; c=relaxed/simple;
	bh=p0T6YklgVc/kE7J3KrEpxvJGi7M9mrfxVk2al7JemAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MybjXOIrh6PHYr16a3p9A86rY+WqDBOsWInswrVhqJg49mhLcWHmLb1TyXTzISNkAtD1RORPC7iN3XaLpz5uTnQ2Zo+qnF6XdlH8+axsjKqWqCE2SoxeB9oumNv014IUV6WdMAl1OA+WXeocwVTQcUHPDJtfz8NzW7DCikb1Kjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GVDE04oH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5557HZMJ023831;
	Thu, 5 Jun 2025 14:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p0T6Yk
	lgVc/kE7J3KrEpxvJGi7M9mrfxVk2al7JemAE=; b=GVDE04oHO+Aqj9r4AsvLj6
	OeyOJhNsHFM+5YHGpmU1A3PM0g/Zd2pnqCO1Wd4zkU9kExs7GlJ6G1fCF7So7ida
	YVa4JnQxXNdEdKwK1X9A63a9X7lbAnd81tv44pEVRlXCD5V/iQ8H/KkLYkfMRVwP
	W7ZFzSCXf85untp3wkHSO/q3vocuHaG01ovvQZBcagTTNzwNeTFTPczBd5AdWavs
	b30fz3Q8WK5dR1KXemAwHf2Va3lSl/B/nrNQtE9tl9KRTwqAfmarvKVyYlH9RJJM
	PrDjZ4jRD/lcknWMKgOHGCbFuvn2m92jZXV75PRf+HChr0VlYpUP9YY+uUnznQDw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf01d31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 14:55:15 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 555EtEWQ032175;
	Thu, 5 Jun 2025 14:55:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf01d2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 14:55:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 555DPqMa024899;
	Thu, 5 Jun 2025 14:55:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmn3k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 14:55:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 555EtBYE45220144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Jun 2025 14:55:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5116C20043;
	Thu,  5 Jun 2025 14:55:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C51520040;
	Thu,  5 Jun 2025 14:55:09 +0000 (GMT)
Received: from [9.124.213.71] (unknown [9.124.213.71])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Jun 2025 14:55:08 +0000 (GMT)
Message-ID: <9cf8f840-ff3f-4978-a454-9f2bba28c763@linux.ibm.com>
Date: Thu, 5 Jun 2025 20:25:07 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: cgroup: add section explaining controller
 availability
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, llong@redhat.com
References: <20250604054352.76641-2-vishalc@linux.ibm.com>
 <mzki6zhrnxdvuqgu56rztrkw473u2r4uqt5mu3t3nv2afyhaub@4qneqmlxgwog>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <mzki6zhrnxdvuqgu56rztrkw473u2r4uqt5mu3t3nv2afyhaub@4qneqmlxgwog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pq2TbxM3 c=1 sm=1 tr=0 ts=6841afd3 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=GxmAIsd5OcVHd3j8ewQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDEyNSBTYWx0ZWRfX0ceUVp5Pc7CD Ufya8y2QyGeGhLdJ4N/fVahHIC/UMkGanajrXI8QpUVXtsguVGS7NarUk2IanQjYPWMAE+SkzGg HSWqMtpSacnl/Uw3ks33AwnSdF4DCxNCFJ86JMt2abu0hHSnStW/LWLf4QMvTh5H4PNPSaOTTmt
 MytnECdeAunIlEAvlpmaKyWLm90om6s2G6sigdbCfcpTcENB7An0GJVR3kKeySvwcoMz8ZliIBs E6PaXUyL1etee/JTeWj6rOeOzA+oNqJyHi+BOpdYJFNrBEpbp5FLWNlu7d3o5YLXJL/ceQk/uyd u0caMyTwduv4eny98mf8V/7ikNYilTpITBcsdXxpyQo1C01V1OpoT7kVdTW+u6JPigKB2vyXRUt
 IRZS9AKClInfiOberTx2m+bapYRnh2p/4FnJ5yQOSz7JqHhrSSPnqtBwZGCfu4zH2xNs+UoV
X-Proofpoint-GUID: LMrcLdyAHaGgPgMDpd8JoeeMvrlp64Ll
X-Proofpoint-ORIG-GUID: OnE3_pgoGwbZ84Kiv2IEI_khJbzI1N8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=886
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050125

On 05/06/25 15:15, Michal Koutný wrote:
> On Wed, Jun 04, 2025 at 11:13:53AM +0530, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
>> +Availablity
>> +~~~~~~~~~~~
>> +
>> +A controller is available in a cgroup when it is supported by the kernel and
> +A controller is available in a cgroup when it is supported by the
> +kernel (compiled, not disabled and not attached to a v1 hierarchy) and
>
> Maybe this point about v1 exclusion. But altogether this section as
> drafted looks sensible to me.

I will add this.

Thanks,
Vishal

>
> Thanks,
> Michal


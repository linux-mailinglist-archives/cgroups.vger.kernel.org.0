Return-Path: <cgroups+bounces-8703-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EEEAFFE75
	for <lists+cgroups@lfdr.de>; Thu, 10 Jul 2025 11:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AA556306A
	for <lists+cgroups@lfdr.de>; Thu, 10 Jul 2025 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D9A2D3EF4;
	Thu, 10 Jul 2025 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dz/tHtfs"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C74A11;
	Thu, 10 Jul 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141057; cv=none; b=Rwmwe/SDZeMZBMSNZyFJh/15sUJojQtKOugQl2eCG+7Six+0Oib+myIBBl9CRrE1CSCBLDoItMOcOTpN7RTfSsjaJYVfr1mfv6KCklGt4/8p1oOerRi7WDBDTqDknP9eJ/veLlEglbdpkhpwDYI88JU7hNPSIICuQ/QY6i9eXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141057; c=relaxed/simple;
	bh=FpT+jkighMwN4936cVVCdocWGRGjYS5xU037MXQrt8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLBAVLCUVv0C2e+/35R+hYSyv5Rhzmm0dJV5qv1wKjx0/iGRDv6GRLe9Cs7dt+abILa7LyV8RHudB5iqmDRTMo3YXpvQZWeWH9pu3F6qAG2VFK5oAqL08dXoHv1ybWGV2nduZQailya6yjkwQyQfbp6suXeQHRR4G5PQx20JZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dz/tHtfs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A1PjcK003075;
	Thu, 10 Jul 2025 09:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yS+RP2
	AH/ulsBTN4WON0HsS7IC9PRhmNrkj7+r3DxWM=; b=dz/tHtfsyT1AV2jFLk/fmu
	YSqMwM2fSCS0AqTNDGb+oeF/VSlJP8x2L3RivTMqL4IfC42KyN5VYhlXOiSvMOy1
	xUj/qFMmKx1NuKT6dKUBsru/G2H/BbPTC1+MN3+TrGEI2ad3JggBHrCybcBJzaxZ
	nasmn9KnCr5wLQZlJdVdbPPvYAzg1oOicyl1f6s2Wj7P2RaPIad9HACAxZnrdt8v
	d4Ovd/IOSzYl5/dKvyR7HEQnXf1cXHhIBeE3fQBTGyf+ACEca4QqyRGlYcpMNR6g
	H76aM5SZrpRZyCrHCH/EC5UqKaDFbJfHzZlKY+C34lnKNHquM4TK58qvFWoWpCrg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk4c39h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 09:50:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56A7nPE3013555;
	Thu, 10 Jul 2025 09:50:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkm4t2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 09:50:42 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56A9ofS351773742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 09:50:41 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B4565805E;
	Thu, 10 Jul 2025 09:50:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B1EA58051;
	Thu, 10 Jul 2025 09:50:38 +0000 (GMT)
Received: from [9.79.194.103] (unknown [9.79.194.103])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Jul 2025 09:50:38 +0000 (GMT)
Message-ID: <c7a7998c-2a40-4d0d-bc73-91794ce75632@linux.ibm.com>
Date: Thu, 10 Jul 2025 15:20:36 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [block] 245618f8e4: stress-ng.fpunch.fail
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org
References: <202505221030.760980df-lkp@intel.com>
 <95753732-9714-42e0-8097-e2b4c3dd5820@linux.ibm.com>
 <aDe9y3Ef+TEacRr3@xsang-OptiPlex-9020>
 <f33af0f8-6d7b-479c-9d57-e5fd485d0f6e@linux.ibm.com>
 <aG98fj7phkM1PojW@xsang-OptiPlex-9020>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aG98fj7phkM1PojW@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA4MyBTYWx0ZWRfXzBz5LolWDTdz p6uSJMUW2pty20yyNwboW2V2KHMCN87f6zee6qoNBPoGgxNmO9LpBiqFFjFAurhNQTBex/mTO3O Y5WEsd8YamnkULxcQ0CxUt4CZLICuRPluUo1+Aweeo9OH8YJnVdDRyWIy84HUd5nmorpXjamE5B
 VnH+F9CjRKz+EBriHFhnWeG6EwAbZIA/MaLip6SHs2D70WQcuLXEd3cThnXEvNx46iYg6oCFRna A1+hn5z4kK39x558gY+CJDNQh2biKxT5fPyrFUsCR+DkFsDa2F+FHvLcl84VdUr8W3iBEpleM8X fMY+hvN+PIkM2zZOiCPPrSK8ucK18YEhJbRghMjHpHzsFMFu47pVscMMZnAZjdRWF5SdpLEnTT2
 kbdZj/kEqOVTcaBEtyzUhHKZMfUuxlgGPdvvFXy6ejN91K//TqsmDOMxSx/j8/6NaAIQdLox
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686f8cf3 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=rX9-azYFNISHy5ivgxsA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: r6s97XftVFUxg5xm3UKul7t8KUfSAJ56
X-Proofpoint-GUID: r6s97XftVFUxg5xm3UKul7t8KUfSAJ56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1011
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100083



On 7/10/25 2:10 PM, Oliver Sang wrote:
> hi, Nilay,
> 
> really sorry for long delay. we are blocked by other issues for a long time.
> 
> for this report, the test machine is redeployed for other usages, and I tried
> the same stress-ng fpunch test on another Ice Lake server, cannot reproduce the
> issue again on 245618f8e4 or latest mainline.
> 
> seems the previous test machine has some problem. sorry for our env problem.

Okay, no issues... glad to know that you're no longer encountering the same issue.

Thanks,
--Nilay


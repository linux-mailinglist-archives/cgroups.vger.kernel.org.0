Return-Path: <cgroups+bounces-11421-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFCDC1E75C
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 06:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCBB188903A
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 05:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C025293C4E;
	Thu, 30 Oct 2025 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wd7gVS89"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A788D37A3BB;
	Thu, 30 Oct 2025 05:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761803365; cv=none; b=GdS/3tDjV3gqNPJwYnsVVt8HwK/ioJuFsOLh62jgPjwtFARtT/dPy0JI+I25SfjaWZqzPCP2Pkzgz++C15Ua5ZYYyBzlraEw50cqES4rFALmB1DO4+FzryvzNB4lx3RSshfqa4VhrFJNr0M3109O92el+OA2gNWz8PmR/UuwM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761803365; c=relaxed/simple;
	bh=Lq/LBeiS9LAVCxiDbuPdhKp2+aH2lE5mBeLQBiP8qm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyeU8FgrHoCbAvd/hCtbOoR2CVQINxBmvhEjj/WcgiiY7Lrla7j/4owSslfjiC/UVJ+n2l4Wq5gPirS+SttM26CqTOCmNyfrV+3wEvg+YRiJb0c8ezhggtC3720XaqQcTxahfMRdCHiMPgFJTJr7EODDD+bKV1MNLveJmB53DJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wd7gVS89; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TMfRBJ019802;
	Thu, 30 Oct 2025 05:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X8Ei9e
	sppa0RKeFtgzVtNBEWvlVXzVV21vq8eSCV3Jo=; b=Wd7gVS89Wzz6QQhsLeGLaN
	ckQdqYrpgL+U7KY5SzZLIy6PUdASgzTKYYWMeZSeJq8bdWnEUH1PelvHIsaSc7Iq
	uk4HiWQYXe2xagcleNJbQWLD2peH0pFqKspvKxhuaPQlVwA/Fy0+x/Ufw2hm/D+4
	t7c6mmGA/3qbPibC2PJtLEUpt9RHGLxgvL6UqqAO83AYr1BcPhMTy4hls1EHF2k4
	SM6Eo1gp09vDLC8/6RlkXr6+iIhPuXRSvtWaXMdP3bEOGih5bbfIAyBkxBCBloO0
	rdc/OLGcVw4TzFBwzcBXqMzZcbcuH/omtgG6Z4Kpi1DWHU7URws5Ij7gSPjb/JQw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agpm11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 05:48:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U1hLWd019170;
	Thu, 30 Oct 2025 05:48:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xy713h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 05:48:53 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59U5mrgq46465398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 05:48:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAEC458058;
	Thu, 30 Oct 2025 05:48:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A32E5805C;
	Thu, 30 Oct 2025 05:48:48 +0000 (GMT)
Received: from [9.109.198.245] (unknown [9.109.198.245])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Oct 2025 05:48:47 +0000 (GMT)
Message-ID: <ed1d37dc-e24d-4514-ba70-21ff1dc61381@linux.ibm.com>
Date: Thu, 30 Oct 2025 11:18:46 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REPORT] Possible circular locking dependency on 6.18-rc2 in
 blkg_conf_open_bdev_frozen+0x80/0xa0
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>, David Wei <dw@davidwei.uk>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org, hch@lst.de,
        hare@suse.de, dlemoal@kernel.org, axboe@kernel.dk, tj@kernel.org,
        josef@toxicpanda.com, gjoyce@ibm.com, lkp@intel.com,
        oliver.sang@intel.com, yukuai@fnnas.com
References: <63c97224-0e9a-4dd8-8706-38c10a1506e9@davidwei.uk>
 <5b403c7c-67f5-4f42-a463-96aa4a7e6af8@linux.ibm.com>
 <5c29fa84-3a2c-44be-9842-f0230e7b46dd@acm.org>
 <544b60be-376c-4891-95a4-361b4a207b8a@linux.ibm.com>
 <aQHPgJNUW8aPPXTO@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aQHPgJNUW8aPPXTO@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K+gv3iWI c=1 sm=1 tr=0 ts=6902fc46 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=O3u3lyOBOEInR-bzjhIA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: MretWpkvEj0PpNKjTGasGnimotDX7Sz6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX69+iXaDJhVKN
 M9uC2p2LrcvMeExjIlJBlwpaHUKSth3QHJ2XaPaGL0Cxu6w0PND9qkmNZXLzWjtAAx4r/7T5Owg
 xw+VLwNv4NBp9SzeOI8ulvFIyyHAiwLyovcdvxl2Hle3GIx4R7Kt9TEXFXAH9MqgKaD25Yw4zQN
 lyhXbgzbYeQvhE1MObvF9mrb4Ex4zogRXHmrSAXLruipYCEfDBdbG+XoBLgPgXSDH0yGh0jAJI4
 3nYu36YtzBMoEyeynt3iIXtXvAU+iBo80XBDg80oqkcJ2++hKHMIXOgX+CACfNdoQSNdHJWMTni
 vVfXigCT99d6gn4+btdEWL6IKy/Q8Agmzv6l+Mr5ybot/LuvbIfge9rUjJcNXzlFpdpRqsomQQ/
 vcqokJYSsGBH76GdiSLerSrKu1VHKg==
X-Proofpoint-GUID: MretWpkvEj0PpNKjTGasGnimotDX7Sz6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166



On 10/29/25 1:55 PM, Ming Lei wrote:
> On Tue, Oct 28, 2025 at 06:36:20PM +0530, Nilay Shroff wrote:
>>
>>
>> On 10/28/25 2:00 AM, Bart Van Assche wrote:
>>> On 10/23/25 9:54 PM, Nilay Shroff wrote:
>>>> IMO, we need to make lockdep learn about this differences by assigning separate
>>>> lockdep key/class for each queue's q->debugfs_mutex to avoid this false positive.
>>>> As this is another report with the same false-positive lockdep splat, I think we
>>>> should address this.
>>>>
>>>> Any other thoughts or suggestions from others on the list?
>>>
>>> Please take a look at lockdep_register_key() and
>>> lockdep_unregister_key(). I introduced these functions six years ago to
>>> suppress false positive lockdep complaints like this one.
>>>
>> Thanks Bart! I'll send out patch with the above proposed fix.
> 
> IMO, that may not be a smart approach, here the following dependency should
> be cut:
> #4 (&q->q_usage_counter(io)#2){++++}-{0:0}:
> 
> ...
> 
> #1 (&q->debugfs_mutex){+.+.}-{4:4}:
> #0 (&q->rq_qos_mutex){+.+.}-{4:4}:
> 
> Why is there the dependency between `#1 (&q->debugfs_mutex)` and `#0 (&q->rq_qos_mutex)`?
> 
Okay this also makes sense: if we could remove the ->rq_qos_mutex depedency on
->debug_fs_mutex. However I also think lockdep may, even after cutting depedency,
still generate spurious splat (due to it's not able to distinguish between 
distinct ->debugfs_mutex instances). We may check that letter if that really
happens.  

> I remember that Yu Kuai is working on remove it:
> 
> https://lore.kernel.org/linux-block/20251014022149.947800-1-yukuai3@huawei.com/
> 
Let me add Yu Kuai in the Cc. BTW, of late I saw my emails to Yu are bouncing.
But I found another email of Yu from lore, so I am adding it here - hope, this
is the correct email.

Thanks,
--Nilay



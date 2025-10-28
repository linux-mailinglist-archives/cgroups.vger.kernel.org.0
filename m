Return-Path: <cgroups+bounces-11243-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FECFC14C22
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 14:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47AAE4E81E1
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FC9330B14;
	Tue, 28 Oct 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WGi+3WJ9"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E433031E;
	Tue, 28 Oct 2025 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656807; cv=none; b=Kvj2U1ZkSYLiTIBeD86g0obFOIzNnKE3V+HAtzoqT7aLWbrW7QgKXFK9fTJKzkU2KiFZYPl6YlFMheXS8EpO5xXR3xueI6ieWwt8Q7D6Sau8kCZd2ic7clNsoJXsDrbC9N/bg9sgmnQGRU45OGdvTJNWvVME3gtasrkoGUgsr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656807; c=relaxed/simple;
	bh=7vB9WSLdaId0S4kzNtTPDpMUfT1DBxQg+ULFJ8/2J1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IoR093AUyi91/vSl1ysRDtiuZso6TLy6I0s3W7pi9g2eaOBCN1PVJ8nS6NL6ndx6F7TnHKybPN1jba/YOem7T2sdNba2tq6DBVMeqG/osEHN1z4jQH6cvfAdUD+FpLBThMAsAStDc/k/pzwC6V4e7R5FqgF43CPJDvqUqeUJtAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WGi+3WJ9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S47CRS014181;
	Tue, 28 Oct 2025 13:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=96JQNh
	KOUBLMAp+sGP4AUbbzpGWvaanYUgX6geyOwcY=; b=WGi+3WJ9h3oOk6GmUladXN
	wT3MctSZDpOkSGAtOupKO2qPxu7wt7zEKo4uyneSdiCiKUsbeYPVqbsoFLCXm0FI
	h0KUaH2JReq0xqZlTLlM/kBxXK5GHydUMrcDrQu4LIGaAYZwyi9C1st0GNuH8zYc
	3mQ6J5SYurC/6hh2zbhhNNG/heUr8hh1QPTQx7gVF8B7bQcP+DvoZSZghf0ZR0H7
	IyQ+ZgZVfITXsAog94+YdmDosfXw7MEXA9VhwJRKCwC1OEf1rSaAvuCBBrwjK9Pi
	w7fMBPOFxVTFAjpXH0ec6PKI0yS3CxXbBMnmpMFAgkiv07v2hkgko/nHzGoSNJeQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81v24v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 13:06:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59SBcCZe021604;
	Tue, 28 Oct 2025 13:06:27 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a18vs2y4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 13:06:27 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59SD6QIs21758700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 13:06:27 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8834358056;
	Tue, 28 Oct 2025 13:06:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEEBA5805D;
	Tue, 28 Oct 2025 13:06:21 +0000 (GMT)
Received: from [9.109.198.245] (unknown [9.109.198.245])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 13:06:21 +0000 (GMT)
Message-ID: <544b60be-376c-4891-95a4-361b4a207b8a@linux.ibm.com>
Date: Tue, 28 Oct 2025 18:36:20 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REPORT] Possible circular locking dependency on 6.18-rc2 in
 blkg_conf_open_bdev_frozen+0x80/0xa0
To: Bart Van Assche <bvanassche@acm.org>, David Wei <dw@davidwei.uk>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, gjoyce@ibm.com,
        lkp@intel.com, oliver.sang@intel.com
References: <63c97224-0e9a-4dd8-8706-38c10a1506e9@davidwei.uk>
 <5b403c7c-67f5-4f42-a463-96aa4a7e6af8@linux.ibm.com>
 <5c29fa84-3a2c-44be-9842-f0230e7b46dd@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <5c29fa84-3a2c-44be-9842-f0230e7b46dd@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=6900bfd4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PGCdswBLe-Oi2NptYxEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 2BwY0Bm3qfLhk62aaeYB__bxQ_OJEtHC
X-Proofpoint-GUID: 2BwY0Bm3qfLhk62aaeYB__bxQ_OJEtHC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfXwDiLLcg2bSMH
 1glaaqGVuuVKUNkV+BE1FT5PB0yPDM5d32LRdRMFHIMry5p++gYI3NeObdvIxaJZPUNJKBW+tHf
 CsO3BzoDscLKZ17EDtH9x479Zn+UKxN6VhRMmI2mXda6A5ALpg5Bz1dNdrDPF06c3vaT0XJIdTb
 qYd45Mo5X/IiUi6ScPP2n2Vhy/llBYHcieGCR+atx79EndKf6aaHuEL2H3+57IlWPgeCdUoOOwo
 WncBl26n8fa9mHOpBR7XNNioeikBLmjkJ61bpchHicXdb9579XDCGncHo4dssifK3osN2QEgL+8
 dgsyosQvQYidXb49zP97agmFM57Z28EXLUNu1hlWiazByqNUq20pQk3ffjcb8Ostg6r22CpQxIS
 osfqvBfyZbxSBFdGPxLNSZjVqul2VQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024



On 10/28/25 2:00 AM, Bart Van Assche wrote:
> On 10/23/25 9:54 PM, Nilay Shroff wrote:
>> IMO, we need to make lockdep learn about this differences by assigning separate
>> lockdep key/class for each queue's q->debugfs_mutex to avoid this false positive.
>> As this is another report with the same false-positive lockdep splat, I think we
>> should address this.
>>
>> Any other thoughts or suggestions from others on the list?
> 
> Please take a look at lockdep_register_key() and
> lockdep_unregister_key(). I introduced these functions six years ago to
> suppress false positive lockdep complaints like this one.
> 
Thanks Bart! I'll send out patch with the above proposed fix.

Thanks,
--Nilay


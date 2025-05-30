Return-Path: <cgroups+bounces-8395-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289BDAC90D8
	for <lists+cgroups@lfdr.de>; Fri, 30 May 2025 16:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FADE3BCB7F
	for <lists+cgroups@lfdr.de>; Fri, 30 May 2025 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF6E22CBD0;
	Fri, 30 May 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FWqJRA8w"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3967FBF0;
	Fri, 30 May 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613710; cv=none; b=RfXci0DCIYT+UCLDA1/apXVwMi3gn0Vi69Iy/jO+mxwTnpRAvtVDI/IHfAqANOVsh1woDQoAAngZpA+l/Fp7loBPaa2R7y/Z3NEgFKaR3QiVPtGfaHuZc412Q3dvkaWV9QJHpuwbSAun5dB5CX41+6hzlsxARCij1QzChGJ2Tgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613710; c=relaxed/simple;
	bh=IiWa3QYm+SUHUfGrRvdvNCqI8L5mMRzMn8FrCEm9dMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cENqEtKyzG9n0GiXpoYwf5IutSLgVzPqkRRt8Pzg0+GdqOCDYwpWvXKQ7MijINPPR68WveUCYjqXAUiEzLedJHTBP9ZOicFhBi6fO+4GDvNAts5lHjukMfZPhNaQH+cEEuvvWWNNsyzo8UVWG8IAuAbRcSZd4nQYvJulKpAYfuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FWqJRA8w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UCUU3v016369;
	Fri, 30 May 2025 14:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6hHECg
	npQEPXpU2l4pVIj6oEuY8kux5ThRyZ5rj5SM0=; b=FWqJRA8wMcLzzcu9gK/yag
	96Poaw/AoeKadZdfLGfUKXOMVJF+nwXKHb78cGh6IVhBvqCzuu++I+YfFNabfnFu
	xuHeQ2i/w0KBGQLCjhE2KcX+1iVObZhc2iMzkcD1LH9HHhVp/NDcOdgyUZNMFt7L
	qhrSFfiVUVKPL0OLb1VRr7bBpDXekbfSujCLrQhI+dgE+jYlkZmCUkUX2iEcq6Qw
	pGMLiMgfazOzKqUvU0Ahn7MSywZdScPu8XXCeEQ8C5Z8j+0w6Nfar/DelcJLYsXr
	64++q+66dXjDinlOUFGnQSrMkjtfgX8UMP7Pqw/pTFpXFgAZoYS9/fdaXqD+vyFg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40kkxa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 14:01:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54UBMU6U027314;
	Fri, 30 May 2025 14:01:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46useq9meg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 14:01:34 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54UE1YS441353562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 14:01:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AE9458059;
	Fri, 30 May 2025 14:01:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B3665806F;
	Fri, 30 May 2025 14:01:30 +0000 (GMT)
Received: from [9.67.145.202] (unknown [9.67.145.202])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 May 2025 14:01:29 +0000 (GMT)
Message-ID: <f33af0f8-6d7b-479c-9d57-e5fd485d0f6e@linux.ibm.com>
Date: Fri, 30 May 2025 19:31:28 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aDe9y3Ef+TEacRr3@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qbn8N2la_ccNjfFWSCbkNQG9aciyTlrs
X-Authority-Analysis: v=2.4 cv=fuPcZE4f c=1 sm=1 tr=0 ts=6839ba40 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=CJm8QiaJa0guGxYXfB8A:9 a=QEXdDO2ut3YA:10
 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-GUID: qbn8N2la_ccNjfFWSCbkNQG9aciyTlrs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDExOSBTYWx0ZWRfXxukEhbtcb9tu 0AaTGS/i8A2WZ1oNPnnB36fITs2g4pOgUmd9bWlV2Qx/zzapmEqoVr4u0fr+1bfOkaSAvW/d/Bv nlLEZ2ywOawmFRpEhL7Rqxi5gpsDGsX3heI2aeCVA8hmYQvc/PAkZGq7/6rcJR4O9VqKH9Z1G4A
 3/i7xkydqUD3R3saf+aHXl6VHCntPdSxGLLBOkSH3j4+Ko6EUPQxWDjreRxtOA236vvHqWKuhsx tKfd0ersEv/d9SO4nk+CBb45xjQDcLeOmiTABGUj5EsEE/6boB3wwwI2g0A5Xt1Qd3S498NHvf1 /YguK0b8oT7RILhW67h/yvoGxn8geqxpIVPZ0yfca7e8PrOplojUpEev1dyNPA/LMLYkZmJ6aGp
 dAPFthvw9vjlavhuy71PLhUDX2PTHGPiX0Hu0XRO6s8BtbCr6Mf0NpSkcAsi4dGhcd8Fcjbz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300119



On 5/29/25 7:22 AM, Oliver Sang wrote:
> hi, Nilay,
> 
> sorry for late.
No worries... 

[...]
>>>
>>> The kernel config and materials to reproduce are available at:
>>> https://download.01.org/0day-ci/archive/20250522/202505221030.760980df-lkp@intel.com
>>>
>>
>> I tried reproducing this issue but I couldn't recreate it. Is it possible
>> for you to run this test on your setup using stress-ng option "--iostat 1"
>> as shown below ?
>>
>> # stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --fpunch 128 --iostat 1
>>
>> If you can run test with above option then please collect logs and share it.
>> That might help to further debug this.
> 
> the log is attached as stress-ng-245618f8e4.
> also attached the dmesg-245618f8e4.xz.
> 
> another log from parent is attached as stress-ng-3efe7571c3.
> 
Thanks for trying out --iostat option and sharing logs. I looked through logs and it seems 
that (my guess) in case of failures (i.e. bogo ops reported as 0) disk read operations are
either blocked or never completed. However it might be useful to further debug this. 
Unfortunately, I tried hard but failed to recreate on my setup, so need your help. 

I have few follow up questions:
1. Are you able to recreate this issue even on the recent upstream kernel?
2. Did you try formatting the disk using ext4 instead of xfs?

Anyways, is it possible to rerun test with following options to further analyze it?
# stress-ng --timeout 60 --times --metrics --verify --no-rand-seed --fpunch 128 --verbose --klog-check --stressor-time --status 1

Above options shall help generate verbose output as well as log why stressors are not exiting 
after timeout of 60 seconds. Moreover, it'd be helpful if you can also repeat the test specifying 
"--fpunch 1". Just wanted to see whether limiting stressors to only 1 recreate the issue. 

Thanks,
--Nilay



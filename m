Return-Path: <cgroups+bounces-7969-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396EAA623A
	for <lists+cgroups@lfdr.de>; Thu,  1 May 2025 19:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF134A46B1
	for <lists+cgroups@lfdr.de>; Thu,  1 May 2025 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAEB214228;
	Thu,  1 May 2025 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IjqL74YY"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1191D63C2;
	Thu,  1 May 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746120047; cv=none; b=b3WsssbTPiwQ9sqd2fcWuzHf3E/4Dyc2mdYmrK2bJXarSOpuFDR04ekbR2NzurNSJVY9qsBjTHZ/oAlVKXz+GS3/+u1or3KgJh7+mW7lwEquV3F9Z30jH82aeGGdPy+chQx+Rq/LdIq3yxu/4qMC/scFb5PKdMQCsvw8Ra7LzaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746120047; c=relaxed/simple;
	bh=acBPApzxTpprHyo+6xpY5LPCWh0/CkNHXvy88Ue/ESc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mT6JQxn6CgD1JxGcduc8oBeblFIG1+qoE7I14al+8dwHEU2NXvRn34zN7vOo0y4uKhJw29HXZAn8CYsxrOZBK+KA85Dy+7JIUGjWZntP4pai7UVccY6vvhMIQUPrimD6JqbHN6MltrQTgoR62gB+DxXA9Cddq+kucoGvprE0o7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IjqL74YY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Bowar027369;
	Thu, 1 May 2025 17:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OsoKPL
	+baE+yVMzmUQNx2jGhX/elt6Pm7VwccCxz0zA=; b=IjqL74YYFmK0evfgbTEmcY
	C4VnB1dUqbag6KxQg8nKZyeByW6XSRwgOoMpQD+DoswIG5Q/JFQa9ZLpzq98Erz7
	FZ5oE5dtIuSYwpJT1iCIZzQR9Ef+shipZDibO3SFV2ajzEf2k2nN7vinw1V0QFVJ
	K3WE2k5ZsVzUz+OICZRgS9Yukl+vWp6E32aNXnYZMJjl0+4OYBxyJk5MixTrNUw5
	MqWaDfSLKHVm/IGQzxlolm6RTyma541EZBlvOADITznPmNlqQBh2s3hDkUCPZ4oV
	SEgJKmZdL7pk8FrCrTNSnaFPVFpMrWxtYQ594RmxnfEmQXDx3WtkMA0t4xcDtcPA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46buy94c4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 17:20:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 541HIJku001880;
	Thu, 1 May 2025 17:20:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bamx10f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 17:20:35 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 541HKZBc27394802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 17:20:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C2795805D;
	Thu,  1 May 2025 17:20:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4088158052;
	Thu,  1 May 2025 17:20:32 +0000 (GMT)
Received: from [9.67.25.149] (unknown [9.67.25.149])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 May 2025 17:20:31 +0000 (GMT)
Message-ID: <03cf3cd2-8ddc-45ed-81ee-3cf8537f4163@linux.ibm.com>
Date: Thu, 1 May 2025 22:50:30 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] Circular locking dependency involving, elevator_lock,
 rq_qos_mutex and pcpu_alloc_mutex
To: Tejun Heo <tj@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
References: <Z_QjW7zJLsuO0xp6@slm.duckdns.org>
 <Z_QjxCZW7dh_v22Z@slm.duckdns.org>
 <16ed195d-7f26-41bb-86d6-ea961b3fa691@linux.ibm.com>
 <aBOosuedqt15xS1K@slm.duckdns.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aBOosuedqt15xS1K@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEzMCBTYWx0ZWRfX0JDWXh1wxDHm 634egpdyDBc66J+9W+T+lNNaVlqmksFIAAbdListyuYjFnCgffb4OBOfW/+/qmfvW3UCnaDoLgF bxS6FM5Vw9FJz5n7SL2DoKTaeAUxc7zzKah6rh4XGuv0JvLLcNA6UrWH2kj3DcbVcQhwmpJkCwP
 tXLeiDHF4zsydfdbeCjfuOXutFEUv+o3rKlAlN+Ypy0W5a3nk4NxY/3uJYZLis+1+rSRaJLOPGj atg5lXT0skIMSsTAy8G/kwfMQL3QFMWvaYLuhfbR8Ywbu3JV9EAi5KsgPnwKcQjk2Ejud86ZLq8 qz8TFkyux9fYweaJuWeTQsMef0R1u8j1rzq2cAJcKCFpkpyrQjMVy0ak2quwk6k1s43ZZpKyygn
 YuIiX2ZTZpJnChuayR65GrhgYkJb9md6Hz0TqaQDVrrHo9El8/mf/banrNxb1FoOHmBoVbFc
X-Authority-Analysis: v=2.4 cv=FOYbx/os c=1 sm=1 tr=0 ts=6813ad65 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=_59lq8m8a_vSe2DXwIAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: r-WYz8SopHU7u6eDCPTtrQgAzrVM9WOt
X-Proofpoint-GUID: r-WYz8SopHU7u6eDCPTtrQgAzrVM9WOt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=810 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010130



On 5/1/25 10:30 PM, Tejun Heo wrote:
> Hello,
> 
> On Tue, Apr 08, 2025 at 12:32:50PM +0530, Nilay Shroff wrote:
>> Thanks for the report! This is now a known issue. And we're currently working on
>> it to cut dependency of q->io_lockdep_map (or queue freeze-lock) on q->elevator_lock. 
>> Please see below :https://lore.kernel.org/linux-block/67e6b425.050a0220.2f068f.007b.GAE@google.com/
>> https://lore.kernel.org/all/20250403105402.1334206-1-ming.lei@redhat.com/
> 
> Any progress on this? The last activity on the threads seems to be back on
> Apr 10th and we're getting close to rc5. If we need to revert, I think it's
> about time to decide.
> 
> Thanks.
> 
This is currently actively being worked upon. 
Please see here : https://lore.kernel.org/all/20250430043529.1950194-1-ming.lei@redhat.com/
We expect it to be soon ready for merge.

Thanks,
--Nilay


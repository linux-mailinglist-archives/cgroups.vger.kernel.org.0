Return-Path: <cgroups+bounces-10757-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 831D1BDC96E
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 07:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69FA14EB99F
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 05:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B892E30214D;
	Wed, 15 Oct 2025 05:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KkQBWon8"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFFA302153;
	Wed, 15 Oct 2025 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505443; cv=none; b=Zt8TMMs65TjRN2DbaXOT/dzNWJA8bNmjVk2Va2BIKcVlJtsXPXhdEqiq070YQvtCC+fwHI1YFimmdmSC0bfrzz2gbGiRy2yE5HzLNf+0EYnMES7zU9e3Svthn0yZkgeQ01JmzAe7ZutOeBOGPN7pgBuSM9Aks3mbe4Q1skq3jW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505443; c=relaxed/simple;
	bh=KBn1NI0MslRpwkIKjP85hfKxUr3ZH8ZbEaOfqOowPxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mo0jVgDnI7Uuqe7G9aaPaKOGzlK1M9OP+zQ4eDE7I3Ia+8xQ1WWC0RtLDGL7o+1R0gm2yP8N+9WA8e96AUsLSnx4CjvLClU3ytv3co4TcxP0Hlt7hcL7xGs7ja9yrCGX4z5M3ekC2y4kWicr15H11VFP6KTk1Ftiy/1VPudUIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KkQBWon8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ELSglJ001958;
	Wed, 15 Oct 2025 05:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v3CUfn
	qMmIPljFIbsPFL2OQA8vjZLUfTEyKegPKIrzo=; b=KkQBWon82D+wiaD1HlUFcS
	sfNihuC/2JFjUGSLJU84CyOdTnos1wwW6AkZG1EDQP5ykhcOrBMysQc1yKOnY/9o
	aZLjn0NZJhbQd35rw7LbuaIBROu9fm1SFETak86zp25dcLWN1ld9Rr6mIxBbhZ9l
	7UqIiY10/mp7dYSVAEdsa+jLdp7c4eiCW8j7xoPHXwoGJKKr+hDvi7RofS1bEXQc
	iU+lxe/mVXMXklDFQN1aIPPV/+cmga4ozVMP1P0kIfuCYB2aUyI2Dfgvstz/4y3a
	+2mkej5nlyBhUkC57kLj9IddhXzx35CErSPOQ0vG7DZPk37pyZOrqWjvKgum78dg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew01t18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 05:16:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59F1sqO0003613;
	Wed, 15 Oct 2025 05:16:58 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xxxrwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 05:16:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59F5Gjsq7209600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 05:16:46 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 980BD5805F;
	Wed, 15 Oct 2025 05:16:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D01958051;
	Wed, 15 Oct 2025 05:16:53 +0000 (GMT)
Received: from [9.61.83.49] (unknown [9.61.83.49])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Oct 2025 05:16:53 +0000 (GMT)
Message-ID: <4b8aab6f-f341-49af-9ccb-d592e1a40fe5@linux.ibm.com>
Date: Wed, 15 Oct 2025 10:46:51 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] blk-rq-qos: fix possible deadlock
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <hailan@yukuai.org.cn>
Cc: Yu Kuai <yukuai3@huawei.com>, tj@kernel.org, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <d4fe218b-9fc5-4466-ac56-0d4c5a8ccd96@linux.ibm.com>
 <e5e7ac3f-2063-473a-aafb-4d8d43e5576e@yukuai.org.cn>
 <aO78EFfuT_o5Gcng@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aO78EFfuT_o5Gcng@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ON7qE31g4JazAWBRM_nHlsyVuuSpgzFm
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68ef2e4a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=MnOlfWbweaj5Mct8PNcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX6Y/eZd3s/iP7
 cJKOKvSctiN2l7z6DubL1XW5Ir+Q2XalnSU5Lql4o9Gvd3MkI0CUjFkzcbuVR8eqKyTI1+SliMo
 fZsP3Hxa4mHuxpqXVO3zPzsxVV1+z8PUZz2Og0VJVjmUpWuqmq+E8GKVKuONkXl3nVnMDzgoa3G
 t8HIUBYJGIesjdqIdvcwJoVMBJ2YDAakLZfP7t5Job0nhraCBN17Dfs2Nt9bNA38UNTsFnx8ZPD
 a9zuhy8W0VaIQBq9bTpTKrpt2PsdHVQzQJLJjlntxP7q3UKTZ6jyHTVUZuCrEmBqYZLFqMptZLO
 20/YSlQWPm3hOijK+NS1JtfTYYklFnDVq2cVWnOpw1G37lYIA4qvD+JHmvctc93W9pMvG0tJuAN
 wNojyxcF4xDX17CR/4QP4OR5RVDhMw==
X-Proofpoint-GUID: ON7qE31g4JazAWBRM_nHlsyVuuSpgzFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014



On 10/15/25 7:12 AM, Ming Lei wrote:
> On Tue, Oct 14, 2025 at 07:14:16PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/10/14 18:58, Nilay Shroff 写道:
>>>
>>> On 10/14/25 7:51 AM, Yu Kuai wrote:
>>>> Currently rq-qos debugfs entries is created from rq_qos_add(), while
>>>> rq_qos_add() requires queue to be freezed. This can deadlock because
>>>>
>>>> creating new entries can trigger fs reclaim.
>>>>
>>>> Fix this problem by delaying creating rq-qos debugfs entries until
>>>> it's initialization is complete.
>>>>
>>>> - For wbt, it can be initialized by default of by blk-sysfs, fix it by
>>>>    delaying after wbt_init();
>>>> - For other policies, they can only be initialized by blkg configuration,
>>>>    fix it by delaying to blkg_conf_end();
>>>>
>>>> Noted this set is cooked on the top of my other thread:
>>>> https://lore.kernel.org/all/20251010091446.3048529-1-yukuai@kernel.org/
>>>>
>>>> And the deadlock can be reporduced with above thead, by running blktests
>>>> throtl/001 with wbt enabled by default. While the deadlock is really a
>>>> long term problem.
>>>>
>>> While freezing the queue we also mark GFP_NOIO scope, so doesn't that
>>> help avoid fs-reclaim? Or maybe if you can share the lockdep splat
>>> encountered running throtl/001?
>>
>> Yes, we can avoid fs-reclaim if queue is freezing, however,
>> because debugfs is a generic file system, and we can't avoid fs reclaim from
>> all context. There is still
>>
>> Following is the log with above set and wbt enabled by default, the set acquire
>> lock order by:
>>
>> freeze queue -> elevator lock -> rq_qos_mutex -> blkcg_mutex
>>
>> However, fs-reclaim from other context cause the deadlock report.
>>
>>
>> [   45.632372][  T531] ======================================================
>> [   45.633734][  T531] WARNING: possible circular locking dependency detected
>> [   45.635062][  T531] 6.17.0-gfd4a560a0864-dirty #30 Not tainted
>> [   45.636220][  T531] ------------------------------------------------------
>> [   45.637587][  T531] check/531 is trying to acquire lock:
>> [   45.638626][  T531] ffff9473884382b0 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_
>> conf_start+0x116/0x190
>> [   45.640416][  T531]
>> [   45.640416][  T531] but task is already holding lock:
>> [   45.641828][  T531] ffff9473884385d8 (&q->elevator_lock){+.+.}-{4:4}, at: blkg
>> _conf_start+0x108/0x190
>> [   45.643322][  T531]
>> [   45.643322][  T531] which lock already depends on the new lock.
>> [   45.643322][  T531]
>> [   45.644862][  T531]
>> [   45.644862][  T531] the existing dependency chain (in reverse order) is:
>> [   45.646046][  T531]
>> [   45.646046][  T531] -> #5 (&q->elevator_lock){+.+.}-{4:4}:
>> [   45.647052][  T531]        __mutex_lock+0xd3/0x8d0
>> [   45.647716][  T531]        blkg_conf_start+0x108/0x190
>> [   45.648395][  T531]        tg_set_limit+0x74/0x300
>> [   45.649046][  T531]        kernfs_fop_write_iter+0x14a/0x210
>> [   45.649813][  T531]        vfs_write+0x29e/0x550
>> [   45.650413][  T531]        ksys_write+0x74/0xf0
>> [   45.651032][  T531]        do_syscall_64+0xbb/0x380
>> [   45.651730][  T531] entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Not sure why elevator lock is grabbed in throttle code, which looks a elevator lock
> misuse, what does the elevator try to protect here?
> 
> The comment log doesn't explain the usage too:
> 
Lets go back to the history:
The ->elevator_lock was first added in the wbt code path under this commit 
245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock"). It was
introduced to protect the wbt latency and state updates which could be 
simultaneously accessed from elevator switch path and from sysfs write method
(queue_wb_lat_store()) as well as from cgroup (ioc_qos_write()).

Later above change caused a lockdep splat and then we updated the code 
to fix locking order between ->freeze_lock, ->elevator_lock and ->rq_qos_mutex
and that was implemented in this commit 9730763f4756 ("block: correct locking
order for protecting blk-wbt parameters"). With this change we set the 
locking order as follows: 
->freeze_lock ->elevator_lock ->rq_qos_mutex

Then later on under this commit 78c271344b6f ("block: move wbt_enable_default()
out of queue freezing from sched ->exit()") we moved the wbt latency/stat
update code out of the ->freeze_lock and ->elevator_lock from elevator switch
path. So essentially with this commit now in theory we don't need to acquire
->elevator_lock while updating wbt latency/stat values. In fact, we also removed
->elevator_lock  from queue_wb_lat_store() in this commit but I think we missed
to remove ->elevator_lock from cgroup (ioc_qos_write()). 

> 
> I think it is still order issue between queue freeze and q->rq_qos_mutex
> first, which need to be solved first.
> 
So yes we should first target to get rid off the use of ->elevator_lock
from ioc_qos_write(). Later we can decide on locking order between
->freeze_lock, ->rq_qos_mutex and ->debugfs_mutex. 

Thanks,
--Nilay






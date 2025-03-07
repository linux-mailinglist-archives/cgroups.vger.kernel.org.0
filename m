Return-Path: <cgroups+bounces-6883-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E0CA56329
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 10:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CD91894E1A
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 09:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD52D1DE3AB;
	Fri,  7 Mar 2025 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NmH0zNM0"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF704642D;
	Fri,  7 Mar 2025 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338179; cv=none; b=ZVwQIE287m5Gg+naLNXJSHZ9MvO5H2UjCYmWcMUduzpH3g2kvnm6hrt84aArq5kTT583UWcV0zkaDpflV1VEivvQeVoXsMckpo+KEwe2Tx/h1jTCGoQbiPQL5UC83WPvj1F91MoSp+48i9H9gweFrVnG9tZXmKa05nWaQayR4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338179; c=relaxed/simple;
	bh=eV3n2HAcmSw+Vwc1yMcQjLfUT+MAq7suMInx0fD4LQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPuy5la9L6JH00fq/6coqwewYvy3fZbRxKCJ5FR4JqM0OENRo3Aqz02XE0ks/r/ug2IJZK/bPkU2GOE0S1G2l4hSiFV8SrcBJDvh2q0U/201E9fYavgrMGpWfKBMj5SjQe1pdiJTJ7vKE9WucgBbx01Qrkr4O/yf+fgbPP/vvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NmH0zNM0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5273kG32017968;
	Fri, 7 Mar 2025 09:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NEH/IN
	zjebO8vGISVxFxMe3qFzWDvkkJzI+MLGJy0Rc=; b=NmH0zNM0cAPL357cqUo5W5
	5AAeJfueNoxdF22XahOaGO2/tWmox3Jj4AztThxImTw/iyCXh5CHLdC1/xh2NsKB
	XCS38QeLlvfwuwNizR7fdig9NUaE88ypXRICugxjPy1JwktRQ6QBMfzi7dk03kxz
	eAu7e0SeLdVRnXor9RV2E60McjKPdn4msE9vaaPSK+m/+X+JWWrj+XFf0zeLNkwh
	YizqhteGK+inb4zBXb6wD7Sx7Dgva5/iQNxvbObmPPMQ1M7SzY7YOA73iyIBn7f6
	y3whA8au1CMvoUQXFrrq64nkuRhvABz0KMN63Kv1GVDYszesxf77upedaTwFzugw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457s6a19tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 09:02:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5277HxXv025044;
	Fri, 7 Mar 2025 09:02:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f92dbtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 09:02:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52792fEd41943414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 09:02:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E517F20040;
	Fri,  7 Mar 2025 09:02:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98F9D2004B;
	Fri,  7 Mar 2025 09:02:36 +0000 (GMT)
Received: from [9.124.218.213] (unknown [9.124.218.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Mar 2025 09:02:36 +0000 (GMT)
Message-ID: <ab67eb4d-0940-4278-b84f-20dbaf0560cf@linux.ibm.com>
Date: Fri, 7 Mar 2025 14:32:35 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] sched/topology: Wrappers for sched_domains_mutex
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>,
        Qais Yousef <qyousef@layalina.io>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>, Phil Auld <pauld@redhat.com>,
        luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
        Jon Hunter <jonathanh@nvidia.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-3-juri.lelli@redhat.com>
 <6894861a-4a40-4c6d-8f48-997b999f5778@linux.ibm.com>
 <Z8q0Alpk8AXbGxgW@jlelli-thinkpadt14gen4.remote.csb>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <Z8q0Alpk8AXbGxgW@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fD1SQWSDcbG-VxvWoKrq5-xBE3Qrc7vD
X-Proofpoint-ORIG-GUID: fD1SQWSDcbG-VxvWoKrq5-xBE3Qrc7vD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_03,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=854 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070064



On 3/7/25 14:23, Juri Lelli wrote:
> Hi,
> 
> Thanks for the overall review!
> 
> On 07/03/25 12:04, Shrikanth Hegde wrote:
>> Hi Juri.
>>
>> On 3/6/25 19:40, Juri Lelli wrote:
>>> Create wrappers for sched_domains_mutex so that it can transparently be
>>> used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
>>> do.
> 
> ...
> 
>> Maybe sched_domains_mutex can be static since its only used in topology.c ?
> 
> We have a lockdep_assert in cpuset.c, don't we? We can create another
> wrapper for that, but I am not sure it is going to be cleaner.

Ok. Sorry, my bad. I searched only in kernel/sched. You can ignore this 
comment.

> 
> Thanks,
> Juri
> 



Return-Path: <cgroups+bounces-11242-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC7AC14627
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 12:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07F2620A0E
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45AD3081A9;
	Tue, 28 Oct 2025 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ui5STRnS"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221FB304982;
	Tue, 28 Oct 2025 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651013; cv=none; b=W11T2oX7pBT+js47/UkNbxusczW5f4wNkQrMKYIlruwBiCM/5X9xxAswibUGDmQDdJpD4nu9bZm2VMZtLA72MsCrlP3ZGTgNNjDFckWDqQQZ5ZqeiKwWdpo/ehsA6lZpoyM3WGWIjTmdABFiz83jvd2EqoSuUtDYiXBZ1QFfL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651013; c=relaxed/simple;
	bh=RYyZ8LxwRvrHfyL3AnEZcTl4DBVEIygndMncgI0gpA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0Je8XsKR7jhsilWDqDqEjqQpKma5vJFOr4bFl31GKAaMATXUQpvx41N8ny4Erw6WwS86Euiw4HXjpRwh7S0ougSLAMhcRkyrkPhYaoKLkyVAhzS791hrsmsJyFwY0JBf2d6j87mJNE0TqFhDr4SXyqeIrk/WakolXm3lbJNZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ui5STRnS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S41A9X019381;
	Tue, 28 Oct 2025 11:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RYyZ8L
	xwRvrHfyL3AnEZcTl4DBVEIygndMncgI0gpA0=; b=Ui5STRnSff13qOdsAiUUqR
	HKT8I0s7Ks1Elb9hEMOGYisfKhF6qjoi5lvAJrSJhtsbtW/SX+KaMDvV+NteHFpv
	ftfiOL8zscCuaI7e3fPTvMv8Fs7MSTFIvjpu18RFMk7W4VUhHbkRujFnFC24EBnw
	RKSnd7x1r3DXUYtcLbUqvNQSUZKGgHJdP01blDigGed+Tga8oKagWaORjE9n9iaH
	57p/OabpebbUqPvl9vyrh4cCAai2wsShOuO8a4Zniik6+Y+FIh/tW7cfZaM6vg1i
	A3rTUjM0EI5Sk96Vxh/83UutATbSFcM2aVYt4y/xwXhkkSOGLm49aICbr2TlQ8TQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0mys3egy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 11:29:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S9uOqR006796;
	Tue, 28 Oct 2025 11:29:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1bk124ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 11:29:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59SBTqWm39977448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 11:29:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EF922004B;
	Tue, 28 Oct 2025 11:29:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 200B520040;
	Tue, 28 Oct 2025 11:29:52 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.155.201.149])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Oct 2025 11:29:52 +0000 (GMT)
Date: Tue, 28 Oct 2025 12:29:50 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, cgroups@vger.kernel.org,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [tip:sched/core] [sched]  b079d93796:
 WARNING:possible_recursive_locking_detected_migration_is_trying_to_acquire_lock:at:set_cpus_allowed_force_but_task_is_already_holding_lock:at:cpu_stopper_thread
Message-ID: <aQCpLifOIy1Ct4tL@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <202510271206.24495a68-lkp@intel.com>
 <20251027110133.GI3245006@noisy.programming.kicks-ass.net>
 <20251028090324.GQ4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028090324.GQ4068168@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BnQHA89s6j3pnB4fu31QcCgwqTPIlcYA
X-Authority-Analysis: v=2.4 cv=ct2WUl4i c=1 sm=1 tr=0 ts=6900a932 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=-MEPCI2RMl-VrW-zF0sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMCBTYWx0ZWRfXyjhRkgSjL5cA
 VNzoMBa6acvDZ3/4iat8ipQUSmf2Vsq99hX6wOUF5cZaWAHV1VNGJksdkd2VE2f0gXgO0N2JeVk
 LZfhKmIGxWYap1gYZwstoFRA4YOk9M8LSdAvHv18PeC31PDDQpWq00ot1qxs/LecXmlfF9ZnyfQ
 ileNQEKWx4Ig2cpZFAJyPKQOH9H11quQK2QFfnQ7tx/mAUVWmoGaxGpp66oZBRHDpUgEBAfyetQ
 O6YvCOU5fYE/e4676+HFdHK4J8HGFc3Y+MqWkg7PD6eT9slFcq80U/qOyNJ7IT3l7K4cUmNKAK2
 63uR4SvgYRoClsb1AF3LjTJAvrPixM5mxIifHDmp13D555wQkTvDWgHmqLe97MW+WjaJS4nbOgj
 fVd6N6iCcKrbOWrBuxoLXmnXjqzgFg==
X-Proofpoint-GUID: BnQHA89s6j3pnB4fu31QcCgwqTPIlcYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250010

On Tue, Oct 28, 2025 at 10:03:24AM +0100, Peter Zijlstra wrote:
> On Mon, Oct 27, 2025 at 12:01:33PM +0100, Peter Zijlstra wrote:
>
> Could someone confirm this fixes the problem?
>
Tested-by: Jan Polensky <japo@linux.ibm.com>

Thank you for the quick fix. I’ve verified the patch on s390x and can confirm that it resolves the
spin lock issue.


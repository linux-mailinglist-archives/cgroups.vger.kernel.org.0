Return-Path: <cgroups+bounces-8377-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 684A4AC6F7D
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 19:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDFB1BA636C
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 17:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802A128DEF4;
	Wed, 28 May 2025 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G9c10NYO"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC269199939;
	Wed, 28 May 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453866; cv=none; b=cwMuSgfxPr7mY5XHw37xbKHNRmLU7+LODp3+l0NgUnDykF/ZA8/LtsFAGsIn8le2YfFm8muZU8zRyqO1XBjd+eFDwmnOYYyj0tEH/OoOhNMcEb/TOXSTi24A48gfS3RjpZmA9l2fmwTPQ2Cy0HFngJ1IhMgGbUew5a5wbwE4is0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453866; c=relaxed/simple;
	bh=CIw7ASx2rLLyfF4nLng8it7E4a96P952Wi8WzNEa/lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uz9TtoNJu3/f/T6jBoijX+9Oj5sbtyLzeZCKrGAAJvWVVaoZIuw2kMZ13YyQzGljh66Adv2VGbwAq0YGsJ6LaK331kyNHaFp5P5VUXXSdCbPOK8TJHVsh5cPLAmvuM1qElW4CqwGHSVJH2ssqZcF9rdyQoS9A5BiFyDWA8zcRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G9c10NYO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE9QQT022351;
	Wed, 28 May 2025 17:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mrve+4iTNvB6RRvFk7zMr+O7LxdCHK
	vtxs8I5e3L/hk=; b=G9c10NYO66vBWrcZrkMb9iJ8J5ZZXsUTuFZBq+SOSmIB60
	+aqlIH4G2md28bkpIT85E5MDInp9IZzgYV6D2RuF5y5CT77TW2Udl+LlDpXra4+L
	voI2GETWLFElLjgTh3Z23cHNabo6ACjLIAoT1xK88FwBzKzu1tKW96eZgAAj5Ibn
	FIXzMXKlKGPXKAaaEwY4qfbe0boXL4ocb8hY3whfXY6H3miSkWX9Y06xvYfMr3oc
	YmcXGiJpeyibEeukCcD6LTqeVIKaIHhp2ifVCDcgKDxPAEbqElwwVMHRxKuJU6Xv
	FuTFGlq3R9Vovy1Yo0TcpyQFGxSrYJ9dbGBwB5dA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40k93d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 17:37:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SF8RNi016192;
	Wed, 28 May 2025 17:37:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46uru0rq0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 17:37:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SHbY7n32899668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 17:37:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DACC2004B;
	Wed, 28 May 2025 17:37:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3883120043;
	Wed, 28 May 2025 17:37:32 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.209.136])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 May 2025 17:37:31 +0000 (GMT)
Date: Wed, 28 May 2025 23:07:29 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: cgroup: clarify controller enabling
 semantics
Message-ID: <aDdJ2apexd2sJmm3@linux.ibm.com>
References: <20250527085335.256045-2-vishalc@linux.ibm.com>
 <99be9c8e-a5c4-4378-b03b-2af01608de9f@redhat.com>
 <a9d0e503-ec70-41a7-adb2-989082e4d9f2@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9d0e503-ec70-41a7-adb2-989082e4d9f2@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 07MnXplC8qaEHDlvpX1_ZIA1E6zqfb5m
X-Authority-Analysis: v=2.4 cv=fuPcZE4f c=1 sm=1 tr=0 ts=683749e2 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=2OsMLQx6joTeCsTfgE4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 07MnXplC8qaEHDlvpX1_ZIA1E6zqfb5m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE1MiBTYWx0ZWRfX9zkU4XEbjh8o JeGFIAZEBJcq0ASzKm8jLkdwab5KvMty0iJti1K3nSCnD5GFJq78ZU51jM0KlzNm4MXQXMMtLer m2OQjb8CzNbojh3RyXOcC64BRVwZXODdHnYUiOalljVOsgNKor9wFyO/Y4aFWIEgY+C2H1Ha9gr
 8RMIJT2qkIBd5GdpxPacalNr4xA84+pVSMexyvS7yeUpaAgO92UKZ8or8q49I0KcyaiyKrB3COL FJmyi3iIiBWnq7cEres1VrAoKf8m8ztQUnLnZZCI8FOMgmXhf4fvv2mh7t95DFGl5ygPOqLUo+o rlUW1PITuH/p7oybpFhPimsDwsVwWjO43Ucy8WBs/bOCeUeLWD+HXrZqWm8Dn+xm88wGW1Wk7Vd
 Qss8JYmCLMW9MylplkGo3IaXMdZeaNti6Es21OOswumpH5zukUVuHE9ALdRa6ItK3VsiaqkF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=346 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280152

Hi Longman,
On Wed, May 28, 2025 at 11:45:29AM -0400, Waiman Long wrote:
> 
> On 5/28/25 11:23 AM, Waiman Long wrote:
> > I believe breaking the sentence into two separate components
> > is actually making it less correct. There are implicit
> > controllers that are always enabled and do not show up in
> > cgroup.controllers. Prime examples are perf_event and
> > freezer. IOW, only controllers that are available and need
> > to be explicitly enabled will show up.
> 
> A correction: The cgroup.controllers file shows the controllers
> that are available in the current cgroup and which have to be
> explicitly enabled in cgroup.subtree_control to make them
> available in the child cgroups.
 
Thank you for pointing it out.

Vishal
> 
> Cheers,
> Longman
> 


Return-Path: <cgroups+bounces-8371-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9EAAC6A7C
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AE11BC3F0C
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 13:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8661E286D42;
	Wed, 28 May 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OYjcPFjF"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139428689D;
	Wed, 28 May 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748439132; cv=none; b=l/QSac6TBV0XGuJMeCL+c0lmPE/eEqC8UT+ncgCmwPABm73y2laX25sdGBGWbpoubH8fYq8WMce6E5ZcakE5xbV5gQF6MZpWzRluvi5f2jojfIy2aRZsM466nw+E1deGjuODRo1M7wjOyw4ARuiwCuosjunVUzVFoXJL4bL/JhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748439132; c=relaxed/simple;
	bh=eX/daBorH/smLCo4dfPUeMY+z3xMXmm8aak/L0nuKGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am3MJB6AIk3LpXO+aZp4CjSS81ZVxG6GRTyYblAg3DEQxulHHPXQN2PNkQTzIEgnbRqIfslUIPYdXAA66rSwq0tw+5RqW3eqrgY8+sxJk/vDyR6sCuAOnXFxoyxjyHtzvCaoggy8JH9M3iqCcu+1fClha0RxgJjNQXZUcNBfW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OYjcPFjF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SD66uW012388;
	Wed, 28 May 2025 13:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X6d7v5
	KHeDqP4SfAbwNK+BtPEbep1L/+/1PYfLP9vuQ=; b=OYjcPFjFymhSOiNINpxnAg
	Fa7AzXrjoVg7P8Gspa+aXvxb7LqsIHZgkGQ72Kc0skhoC/g8pzEvuV0EfqB6sg1k
	Z8lNGym27uzLwSG+O/3UeqVe/Ng+PoV9mltivBaiOnWJ+C5lDnfQlifpXeTnm6Pm
	EAmFXGHy7FUNVXsq+pJQ323rIuYCZfNBBu4jXUieYRCCOZTGdMVEdLjoQqcvfLJU
	KE+XQ8Lx+1z+DtIWXkduSBs0mUGaPr078t5u1JwFglGA/lcBO7c6msJwnRQ+MWaI
	fzwDRxMvHKayXvyPOzXLLKH8An15VHdCSbpo4cws/7FY/o7ys6vx2aigfok0zGYg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wgsgd3je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 13:32:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SAcxke015803;
	Wed, 28 May 2025 13:31:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46uu537bc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 13:31:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SDVlR254198746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 13:31:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94E7E2004D;
	Wed, 28 May 2025 13:31:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A16EB20043;
	Wed, 28 May 2025 13:31:45 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.209.136])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 May 2025 13:31:45 +0000 (GMT)
Date: Wed, 28 May 2025 19:01:42 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: cgroup: clarify controller enabling
 semantics
Message-ID: <aDcQPgjzx-X2Kj5s@linux.ibm.com>
References: <20250527085335.256045-2-vishalc@linux.ibm.com>
 <vzdrzqphpjnvrfynx7ajdrgfraavebig4edipde3kulxp2euqh@7p32zx7ql6k6>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vzdrzqphpjnvrfynx7ajdrgfraavebig4edipde3kulxp2euqh@7p32zx7ql6k6>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OIIn3TaB c=1 sm=1 tr=0 ts=68371055 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=ihcwlhghPN_qPqRxoEcA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: a6VRcOVsuolG0IXKqeIGJA0iNkgN6ltU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDExOSBTYWx0ZWRfXwGHLpxZXd/i6 s3cO+s3LPeKtfBoDgsO2WPbPiDDxoS8QnHOrtE257zpWQeaPZX97O4M2pqT7ImqlbDFEvDuVtNi 7lGwd1TWV5fA9dAwFRswII3VSNrg/EkyEgIWzMbRlKgcJdckwfYawa9uQaeYHLtPuomhDWHhCNK
 0WyIlh1ZsmhuO5gLKOpOc0LbJEdd+fejNmJcCJ0urwn7Ot2t5jdioe683qChfBFTp5fzmHjK9eq CGeCoexuWpOhsb+t5M5EOuSXai0+lTjLcrnl56phjufPoah37hnHUKWkvOayS2SbDHparR27Clx +H94sccmp2mQNXv22vol8KmjJsrHlQZLGyU/ThMqOBXykm8umnQb4raZNIBuCL+xocdrWb+iBIk
 VJHDBV9SzPSxReP3ulc+pMb934Se6bilCO+tg/BJvMgcjKWhlbalodgyKMkXLecDPBCTViyf
X-Proofpoint-ORIG-GUID: a6VRcOVsuolG0IXKqeIGJA0iNkgN6ltU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 mlxlogscore=371 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280119

On Tue, May 27, 2025 at 11:58:50AM +0200, Michal Koutný wrote:
> Hello.
> 
> On Tue, May 27, 2025 at 02:23:36PM +0530, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -438,8 +438,8 @@ Controlling Controllers
> >  Enabling and Disabling
> >  ~~~~~~~~~~~~~~~~~~~~~~
> >  
> > -Each cgroup has a "cgroup.controllers" file which lists all
> > -controllers available for the cgroup to enable::
> > +Each cgroup has a cgroup.controllers file, which lists all the controllers
> > +available for that cgroup and which can be enabled for its children.
> >  
> >    # cat cgroup.controllers
> >    cpu io memory
> 
> Honestly, I see little difference between the two resulting formulations.
> Could you perhaps add an example where the documentation confused you or
> behavior was not what you expected based on the docs?

You are right, there is little difference. I wanted to highlight the
point, that, Availablity means controller can be used to resource
control a cgroup, while Enablement means controller is now "availble" to
children of the cgroup.

Regards,
Vishal

> 
> Thanks,
> Michal




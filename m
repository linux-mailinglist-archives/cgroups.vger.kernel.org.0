Return-Path: <cgroups+bounces-7456-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE9A8458C
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 16:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1933B128A
	for <lists+cgroups@lfdr.de>; Thu, 10 Apr 2025 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2CA2857ED;
	Thu, 10 Apr 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OpVVKr0B"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BCF284B3D;
	Thu, 10 Apr 2025 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293513; cv=none; b=rfQ8A9TEXQdqcydH4F3hrfbxRv42X0TTBcxF3qV1k7Ex7o2QVHcUcA9XeZEV6AOYM3LePF3cYyVx2RK8X/LbHtta+3BufT48VioeYZ7HzHrrBLzMNz1ZExvBs5tmU4ydsmRjiX8ZewSxi8df3YyIOGAe6u5wWM/X9KQn0orT6/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293513; c=relaxed/simple;
	bh=yCmoVsBset/qt1RxJ6GlsGyFRfgaOPxZBecAiL0QW1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN1RxcA4LCA+Hfch2jPzioy+PwFcQKu5pz/W09QDRDIozQxDdKa+S2n7xquNX3p63AztUaKhmWIJvLMyNEYrGb9dc+qAfF9gfPPHq3JVzQedrtw0AKkLTmHXtnLNJBBRkhVCcG8uBm8N2XxaZVIEOp7nrS7P1reRQCCn7wsR3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OpVVKr0B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ACS1JJ002961;
	Thu, 10 Apr 2025 13:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Dzww3L
	KlrnUtIm0R5u+tO3syAZ1j8WxAkgmrtRtvAXs=; b=OpVVKr0B+wsZSXCfUeVbj+
	yfR3I3kKvHuPRc6MiyESZAE05QJWqgry+iGJPe3f9u5qSYYpJkWnBPChJxuqB9IF
	pqU7MH5OXj08qbxJz/75onxa5ckaikhGzFkZOSAi6avGuEYWNLkp9gquQzu1y3ND
	1emlopCT8zAQIY4Qo/YKCztxvRIH5iVIZGb3ntVPRRKB087WozQWBe2Ek8UuxbJ0
	cMLgnOzl8gIWQl4qx/y8wbEDwzOEF+89d0KkxQ4sfjKLv8DDpSnKLRkOkXvmxp2B
	iWoylT0jt1pDTy1kcDb3nfcGBuKEDwtVxn2LTwmVPzhlrqD1JjBHgmpFtpd3rc8w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xe13rfg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 13:58:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ADaXAE025510;
	Thu, 10 Apr 2025 13:58:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbm67c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 13:58:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ADwN2B35652118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 13:58:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17CED2004B;
	Thu, 10 Apr 2025 13:58:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3244C20043;
	Thu, 10 Apr 2025 13:58:21 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.245.223])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 10 Apr 2025 13:58:21 +0000 (GMT)
Date: Thu, 10 Apr 2025 19:28:18 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, corbet@lwn.net, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc,cgroup-v2: memory.max is reported in multiples of
 page size
Message-ID: <Z_fOenjfni55JsbV@linux.ibm.com>
References: <20250410133439.4028817-2-vishalc@linux.ibm.com>
 <la6q2koug4ohzcfc5eqguod7x6fdwhndqkhzfrttsfnjo5fbb3@xzxodtpjl6ww>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <la6q2koug4ohzcfc5eqguod7x6fdwhndqkhzfrttsfnjo5fbb3@xzxodtpjl6ww>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4Gk_z1bq9BSjNQCwh15X2ZYL-Z3CsoPH
X-Proofpoint-GUID: 4Gk_z1bq9BSjNQCwh15X2ZYL-Z3CsoPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100101

On Thu, Apr 10, 2025 at 03:47:06PM +0200, Michal Koutný wrote:
> Hello.
> 
> On Thu, Apr 10, 2025 at 07:04:40PM +0530, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> > Update documentation for memory.max to clarify that the reported value
> > is in multiples of the system page_size. The following example
> > demonstrates this behavior:
> 
> This applies to any of page_counter-based attribute, not only
> memory.max.
> 
Yes. This is already documented, and I missed it.

From Documentation/admin-api/cgroup-v2.rst:
...
Memory Interface Files
~~~~~~~~~~~~~~~~~~~~~~

All memory amounts are in bytes.  If a value which is not aligned to
PAGE_SIZE is written, the value may be rounded up to the closest
PAGE_SIZE multiple when read back.
...
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1316,6 +1316,9 @@ PAGE_SIZE multiple when read back.
> >  	Caller could retry them differently, return into userspace
> >  	as -ENOMEM or silently ignore in cases like disk readahead.
> >  
> > +        Note that the value set for memory.max is reported in units
> > +        corresponding to the system's page size.
> > +
> 
> There seems to be mismatch in whitespace to surrounding text.
> 
> Also the wording would be more precise if it referred to 'multiples',
> not 'units' (units are simply bytes).
> 
> Michal
>
Got it. But, it seems this patch is redundant. So, I won't be sending
another version.

Thanks,
Vishal



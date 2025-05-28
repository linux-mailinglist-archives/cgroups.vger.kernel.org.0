Return-Path: <cgroups+bounces-8376-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505C5AC6F5F
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 19:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867B51674CB
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 17:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B5A28D8C6;
	Wed, 28 May 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ctfhsTSU"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01782288505;
	Wed, 28 May 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453315; cv=none; b=na1KfpxT70tkRacZBYxvg41zi7y4BOc2Ebi2zxNk4nWgqj3OvAqPo9tuETMp9Pi+rho+MIbF0mOCEOzFKpPvt/XV9Pm1pT02q6sb7O0gY9qdNNZ+WBLtpag0m5hzeP6pFjFmyX3MDVFlplS134gKzEhzuPILkMDtYSLWUnoGD24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453315; c=relaxed/simple;
	bh=fWIYq5ECxN2AGf5gxzO23hUlkvFsN/oUI+0sOSb6zD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nlivq07uDdeAlHAgdx7GmMt/Ee2+lXincka8AUHt0qf6qytmhXovxl4FdXhSeWVWoGaxkyD5kNP9rPWLPImSBWgVjPO6xZBGmK2R9qBnqNiBJrt/BEClj9Fm0gIKHfj8MLHgXXVrTNH3lMpDK9Z1FAUJ071Cm3teXwxth2+1Nf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ctfhsTSU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE9QiE022135;
	Wed, 28 May 2025 17:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=64/K8ak+yOyahUYoENBTpoMzyz/iFI
	3LNDRjB4erHzI=; b=ctfhsTSU8z4sPp67UowuaU7R7sUCKVi0r93k4XAxcbR/5v
	tteUjbk7YRQPXPUYgnpi3KrzlTv7lKt0Fv45ovgergoPYnAlWc9fefimDbAposeS
	Bdu0/oP8bph44kBGWrOxazrMNx1j5bcV307ZJNaCYzhT/DmIWZi62dVJOxLBzNId
	c6BbFZxmZF2uLjEMl4jlYgnPb1dl87dtatnDAvfamxN6eV2fNNHc9nii6tHbHvyz
	pw0I9WoGKGBw9Gl4+gr6oi6SDgsbnq48OlJ/KAUGsaRwa0H3j/J2Fhde6QM0KxHJ
	wAXbJXhYKko+hdiDJn4jp3pznGca9QRgyxshetng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40k91wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 17:28:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54SHKguD021321;
	Wed, 28 May 2025 17:28:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40k91w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 17:28:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SF2FO9026406;
	Wed, 28 May 2025 17:28:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46usxn0gcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 17:28:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SHSOFh53281216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 17:28:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAA8220043;
	Wed, 28 May 2025 17:28:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B563D20040;
	Wed, 28 May 2025 17:28:22 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.209.136])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 May 2025 17:28:22 +0000 (GMT)
Date: Wed, 28 May 2025 22:58:19 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: cgroup: clarify controller enabling
 semantics
Message-ID: <aDdHsysOaByXs8lC@linux.ibm.com>
References: <20250527085335.256045-2-vishalc@linux.ibm.com>
 <aDWOLU4qjhl0ds0U@archie.me>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDWOLU4qjhl0ds0U@archie.me>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ut7APT4aulch68BeKfh4JCmHE87TFuDx
X-Authority-Analysis: v=2.4 cv=fuPcZE4f c=1 sm=1 tr=0 ts=683747bd cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=ZoejU5DVn5JL-iuchh8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: pJh6KV1fmZ82sZmRfkKgCeurAxgXf6sl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0OCBTYWx0ZWRfX2dWhfbMYHsdf crOmxU3pvze9FNBdsXFctokU/R0hLrDSImQD1HszpzOxbrypvIigfWzcqfkJ9Vl6OqwCqFweODs in2qMug93t1mxFvp4sK6zaYHS3qrdVOYUC6DxvlZBD5apujhxasTVkv9Grytonlzq8VwJ5HZFlM
 f/Chz0lQMiuY3T47MN41O9PPVycnXkLL3RAYzAXTcgBizvCPM67EOp0sWfueCWYeW6JTcTVY9cO Ndmv97FkMiEsA8qDbG28Q7BswqgP5iFSJ5kP6LWVVZAKH/3H3yy2Rrgy8RXLKLpvpQsCodxndoj NAPCsb50JYodcS5HR/AjSqi8tI0PmAy84vCZ5RDXLglXnj6jAGiMbeacX/u5YhkOPjGUELKoMLR
 HRtM4omQoMU9wDbAV8Ui7ExFyvqZAA5CJO8ZcBNcP2L4Sc6zB5d4MWI5+a7Y2xqQZjyTq4Hx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=604 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280148

On Tue, May 27, 2025 at 05:04:29PM +0700, Bagas Sanjaya wrote:
> On Tue, May 27, 2025 at 02:23:36PM +0530, Vishal Chourasia wrote:
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 1a16ce68a4d7..0e1686511c45 100644
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
> 
> Keep the double colon (literal code block).
Sure, thanks!

Vishal
> 
> >  
> >    # cat cgroup.controllers
> >    cpu io memory
> > -- 
> > 2.49.0
> > 
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara




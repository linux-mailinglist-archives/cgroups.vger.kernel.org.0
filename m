Return-Path: <cgroups+bounces-8370-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BEBAC6A2F
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 15:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E17E1BC23DF
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EE2286D69;
	Wed, 28 May 2025 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="swqB3TSB"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17349279903;
	Wed, 28 May 2025 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438332; cv=none; b=gFkpm5dbBshHgN6LsuzYaNBWcf+AhqvMCXR8ic8ZVDLTvdcZfOhXmfceRMie3oXPVBoEPo7km2cMiAwGNYeFGpeOoYRCAqbVdOX4+rQOvvkxwa/++lOy7q6/2jZix+iFu2gRq/3qIP8gvby02Apgy3fi0KbjKAS51NUlWK+5/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438332; c=relaxed/simple;
	bh=7HyDbaSY7vbBw4ErHLqBEibTA7gjG9fAwM9QL6eQWEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udMn2d7KxXelz7xFMPWr3zspSUSMmT7HDlbE8aF+6iGWQJtoKISiMRLOYvfjvvMb+xLAy8Dx8q+rArzhvyhk4QLapr+bXLxzgs3OrHU2/fu4aOqwaPL2J/udguXjSE41zenrPqFyXAl8xdIaAiqSOO7kQMpi9PSiDCVNxjzFaC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=swqB3TSB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S2XrjN012354;
	Wed, 28 May 2025 13:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i7TrvR
	j1Oh8eIIYCbVDuZ00tzac1Amn0ypbuJeHijFo=; b=swqB3TSB/cWJG8cQzXKMJb
	uGGBXFDlHgDAs2WkR7xFdENjsZ7CUZ2d+bLeKV1H0u63Srbo3Qjmfr5hJ5xLbcj8
	WXqssT+eo1Abhhf1C+FPXp38wB1sfT3VlCLEtnmBqnZqe6PHm7aTb2xe3IvyJTPW
	N8s28tnNZXys7tqWiMQe3dc/9Gy1n4FOOD2Lq/QQZkzuSMxqgDQTzDXXr3QfdhkI
	xwpmfh7yrNrULImZr7Dgs59qttHKFGgSjagMvKu/XuMgsLFrr1et07aQO+DbZPFj
	Xa07F5o8pLINVX69ZqHUqO6bYeajXVgQmDY+YlCcweLE1m29qcWFccWWx+uI9feg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wgsgd19b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 13:18:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SAhupU021309;
	Wed, 28 May 2025 13:18:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46utnmqds9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 13:18:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SDIgXZ22086032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 13:18:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9583120043;
	Wed, 28 May 2025 13:18:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B454E20040;
	Wed, 28 May 2025 13:18:40 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.209.136])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 May 2025 13:18:40 +0000 (GMT)
Date: Wed, 28 May 2025 18:48:37 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: cgroup: clarify controller enabling
 semantics
Message-ID: <aDcNLTA2JfoLXdIM@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=OIIn3TaB c=1 sm=1 tr=0 ts=68370d35 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=sJNq94hGihU767Vwfd0A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: gZa7q5qYtC7tZPcdzV8irWfpZBYMoIy-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDExNCBTYWx0ZWRfX2i0x2PtMVyNe WNd4x+G9moReVzqwHJVaW2rnDGAFW7ON7PDNgUJuHf1CpZ0u1346LDUK9PWNBUH6kuRJUf2jGFm Dy4g4lYq8Xt+I3wr6U09pbljwqD84IHGVD5j3B9VMLXz1NG8TpCj+E3tw8KLJPhC7VVm8bej4L1
 4bj7dZvbaPoKPOkP+Z/hiDmk9+7nkTU3Pgk2vWAmlFGSFHHC0sWsj/5EV8hr6mpO/39OCBtAMa2 q0ndco+fi8G86dOfc5GfpT89+xXE9tGeL40E9MEyAdTnu8F3+WNVA8HaZt531bq0GBT0mbxf1hB 0DJOeI/JutGdo7YonxPMwhiinqzmltpKB18gqPS/dGJEMfyLzB0RAdTNDA6xgpGz/sZKMCwGryJ
 u+bJ7aCGxsuwq+ZMNVKqhsbk21BDz5XV2K5CIkAQ8qLP13qgyR2Skg6z9m3iu2gDtJRdtL3+
X-Proofpoint-ORIG-GUID: gZa7q5qYtC7tZPcdzV8irWfpZBYMoIy-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 mlxlogscore=478 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280114

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
Hello Michal,

The part that was confused me, was the meaning behind controller being
available vs. enabled in a cgroup.

Though, the documentation does mention what it means for a controller to
be enabled in a cgroup later in the text. But at the point of the
change it is unclear.

Thanks
Vishal


> 
> Thanks,
> Michal




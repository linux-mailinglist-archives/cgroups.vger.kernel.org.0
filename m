Return-Path: <cgroups+bounces-8378-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88276AC70B7
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 20:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C36A26913
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AC328E59B;
	Wed, 28 May 2025 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ALGUjlWf"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA928E573;
	Wed, 28 May 2025 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455694; cv=none; b=f5PA+OLy62+62KXtB5qswl1iUEiaEC2axUPQuGPCo559viB3OhAZIjoGDt1IFkmMkj5umWiEo/RiYjmQHB24e24GRbinMfbyS/7pmTflti53+Nl3MGexvqSPJX7roClKeLi6kVyAFOdXfmm+6kxtvjc8QBo5SjZn3lbNnHg6L1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455694; c=relaxed/simple;
	bh=n7qvY25wzU4LBN1V7seQQRsvaX0gcd8CSYPUS3iqD3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/6u/d5kL5nSGjwT6keTspB2+KKK2RbQF7sWzA2IDr3kR1DJdpxriJ6eAlXAM6AjUr4mhsg4Rh1ssgYvEGDYljkqextnwI7yWAk7gzSKkTJvyw7OUuZ32PIp+V4zk2pogRofmt7MnoGuEQdBsfD0WJMlqnQh7kMuphD0h3iLTro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ALGUjlWf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE9Zie032044;
	Wed, 28 May 2025 18:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SXk6xY
	TCJrBiRraj2g3E97hdrA+qVzMbgY3MR8FW4gA=; b=ALGUjlWf8ERxczbOOQZIIQ
	uhjC1OUxMQqHGYtb834u0O1o5EmvANTZ5SEa3j3gTbwhkhcUxi1p+FMDpfIEI9u+
	dLiZhvmjX4ZR+AJoZhTS1+jOyISg9m9xQ/BlBbwcEJyJXgKVxnQPNFh6QKRj1bpQ
	fPqP0WvE0RM8xKeNFDWLCz48+nJ8zOtnywSQW0KAE7odQODAd9crtauRn3H4VNH1
	ihAFDdT4sNyUrbt+hLPeGs8KKB59XXTuKljd7TBZF+Xvl1yxkjXgkYyvIVcxau4r
	RuqZTlTp1UlZXxGCJcYcAGE8zuwD2uUjcRHhhjRzAVSddq69oFhulqcpr8Fkcf4A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40js81e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 18:08:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SElXZt015798;
	Wed, 28 May 2025 18:08:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46uu538d9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 18:08:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SI85np34013522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 18:08:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6266D20040;
	Wed, 28 May 2025 18:08:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A93D20043;
	Wed, 28 May 2025 18:08:03 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.209.136])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 May 2025 18:08:03 +0000 (GMT)
Date: Wed, 28 May 2025 23:38:00 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: cgroup: clarify controller enabling
 semantics
Message-ID: <aDdRAFMFY5hI2uNn@linux.ibm.com>
References: <20250527085335.256045-2-vishalc@linux.ibm.com>
 <vzdrzqphpjnvrfynx7ajdrgfraavebig4edipde3kulxp2euqh@7p32zx7ql6k6>
 <aDcNLTA2JfoLXdIM@linux.ibm.com>
 <bdstku24kbgj2oalpbzw62uohq7centgaz7fbeatnuymjr2qct@gp2vah7mumk3>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdstku24kbgj2oalpbzw62uohq7centgaz7fbeatnuymjr2qct@gp2vah7mumk3>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SdL3duRu c=1 sm=1 tr=0 ts=68375108 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=8nJEP1OIZ-IA:10 a=dt9VzEwgFbYA:10 a=KSb9T-wMAAAA:8 a=VnNF1IyMAAAA:8 a=fKiKOXW4520yZCUzCKYA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=KF4VuIdXkMyp4E_ug72i:22
X-Proofpoint-GUID: yBv1QbkSCPABfv32Vs5UbabjPFZrMY4Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE1NyBTYWx0ZWRfX7Y0ha3Ip/EK0 r7HpOSWDq3b/bM7Q0Y/81nx88O+SoPRF8urRF9BZY6He6lTjOeOVBAOIWCNjsa39ExQbwoyvjgu WJP71cjwVZ1/hTvOgQ9wc0KvlacFG+63mDojoNcYMc1bYqqTPc0jL94+O8t+Tux1uNgcuY53Qlh
 Shym0lz+BISWiNk3XkJpsg0KFbRHlknMTFCfbEzMlR6TZWN9FXNYPr0GuF+sOFuqmauMz29Vv72 wFqBb59h1ABSr4jGy9QZFKqXiT03GqNd41cLXKKQsmHj+tEuFFBb4jDfUETXMJWsd8V5DmvffZp MRLcio/xd/q2o68rvjEKZrcvIChW6YdJg1d2thni7uCDgvEDcK7HHmuhvvhlANTaFurhq+VhHV2
 SOdyeqR5p8eyPUPVHTtzaUbzb/tRTO5Cgb7F8Ae4fhXv3b9abZKASK9F96jsSks1Wg35dCF1
X-Proofpoint-ORIG-GUID: yBv1QbkSCPABfv32Vs5UbabjPFZrMY4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_09,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=354 suspectscore=0 bulkscore=0
 spamscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280157

On Wed, May 28, 2025 at 07:05:06PM +0200, Michal Koutný wrote:
> On Wed, May 28, 2025 at 06:48:37PM +0530, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> > The part that was confused me, was the meaning behind controller being
> > available vs. enabled in a cgroup.
> > 
> > Though, the documentation does mention what it means for a controller to
> > be enabled in a cgroup later in the text. But at the point of the
> > change it is unclear.
> 
> There's a picture [1] that may be more descriptive than the docs (on
> which it is based).
Thanks for the reference. 

I didn't get the part about "io controller enabling memory controller
too". Is it referring to the fact that multiple controller can work
together in a cgroup? Because, enabling just the io controller does not
automatically enable memory controller too.

Okay, what do you suggest, should I send out V2 taking corrections from
others?

Regards,
Vishal

> 
> HTH,
> Michal
> 
> [1] https://paste.opensuse.org/pastes/987b665209bb




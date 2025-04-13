Return-Path: <cgroups+bounces-7505-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1534CA870D2
	for <lists+cgroups@lfdr.de>; Sun, 13 Apr 2025 07:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BEA460AC8
	for <lists+cgroups@lfdr.de>; Sun, 13 Apr 2025 05:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264151465AE;
	Sun, 13 Apr 2025 05:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SX73jVdk"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D366383A5;
	Sun, 13 Apr 2025 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744521872; cv=none; b=oXy5jyigts2H0EbidUW1xEbvFlyrU9pgRhBVPX96gmItJYHdtz0Z/6yrVds0Zr4nIUu7rL5XV8bmITgyIhOtIcgJPtj0NTAtvA7e9Dj2Y7Ox86kEl5iea7p/igkFWwwa1estnzud01sq7s/kNHJAnnoWkROeslw02ExhrdgfnXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744521872; c=relaxed/simple;
	bh=qZhI4IXGj1ogzGsDmvbazAqTwkKx0Yng6YYZBfWidbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoAaDiT6eO954aZy0EFuVjqq5iiyp7n06s5bbaZ6GCTBT23jwt8MmVWO/aFrgNm0EmbEXCll1VIVJT1DJVfnEcgIhfm6nx6Yp2pdkLHh8jEZB0etajg3nroCumXywEpgVqobWOdydJ0I26e5sx5khn0IBxOyLrWAe9V5d5fubM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SX73jVdk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53D4hQsm007253;
	Sun, 13 Apr 2025 05:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IqmDGU
	YrifZwhEU6eK/b+avFqWBbgtTr3cfUl9X8Mh0=; b=SX73jVdkHZ7OOzEAc8mwsa
	P/H6HCHoYeOt2X5ofAgSm+9VL9JJIyZ7ipy5SUEIHNCaHalA8TXVcCQfzF8sLg8V
	vN87IBvbrjduWW+EHl5HfJZjAZGuuKreeYQfYLCrWTrzrOHsuSJkIdgulMdbOmI3
	V2u0/y3pRHlj9vegU1lOsqpDTezLh7JSz38lMbnf1ogFSETG2ggrK31C0EWDosRm
	cqcIlYXmzX68Ta1srNOGqkwnjj4IInLYKabdfuMjXM0cFcGJqfT93fz+dNScRXhA
	wwamDFAoXu1MqVZ9Ux0vR6deJptkC7gWUCShJHPzzNfVtX2XiMfpwGzsYALYDSdQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46024x95h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Apr 2025 05:24:04 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53D5O3Sf017611;
	Sun, 13 Apr 2025 05:24:03 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46024x95gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Apr 2025 05:24:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53D2gRPk010435;
	Sun, 13 Apr 2025 05:24:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qjrdb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Apr 2025 05:24:02 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53D5O1jN30868176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Apr 2025 05:24:01 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AFF558052;
	Sun, 13 Apr 2025 05:24:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DA155805D;
	Sun, 13 Apr 2025 05:23:55 +0000 (GMT)
Received: from [9.124.209.25] (unknown [9.124.209.25])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 13 Apr 2025 05:23:54 +0000 (GMT)
Message-ID: <f4131737-fe1b-46a9-acde-73d1e29cda98@linux.ibm.com>
Date: Sun, 13 Apr 2025 10:53:48 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 0/6] Promotion of Unmapped Page Cache Folios.
To: Matthew Wilcox <willy@infradead.org>, Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, akpm@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        Huang Ying <ying.huang@linux.alibaba.com>,
        Keith Busch <kbusch@meta.com>, Feng Tang <feng.tang@intel.com>,
        Neha Gholkar <nehagholkar@meta.com>
References: <20250411221111.493193-1-gourry@gourry.net>
 <Z_mqfpfs--Ak8giA@casper.infradead.org>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <Z_mqfpfs--Ak8giA@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6dsAiMeB33E3lh-bj9ZwhYx2gUIGJIgE
X-Proofpoint-GUID: GELQ2W6CYobMvDj3cE-s1NHetRq3AAmh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-13_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 spamscore=0 impostorscore=0 mlxlogscore=688 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504130036


On 4/12/25 5:19 AM, Matthew Wilcox wrote:
> On Fri, Apr 11, 2025 at 06:11:05PM -0400, Gregory Price wrote:
>> Unmapped page cache pages can be demoted to low-tier memory, but
> No.  Page cache should never be demoted to low-tier memory.
> NACK this patchset.

Hi Mathew,

I have one doubt. Under memory pressure, page cache allocations can
fall back to lower-tier memory, right? So later, if those page cache pages
become hot, shouldn't we promote them?

Thanks
Donet



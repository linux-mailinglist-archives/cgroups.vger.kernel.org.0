Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4057C52CFF3
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 11:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiESJ5N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 05:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiESJ5M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 05:57:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D8C92D32;
        Thu, 19 May 2022 02:57:11 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J9mmV3001105;
        Thu, 19 May 2022 09:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=cKPPLtUhn1Zdq9Oika82pAtq/kD+uaRcTWRlgTUcvuE=;
 b=ZpDHUadAU6pwtWhT2zKhV4nm6iGq0zAoMYSHrl73AwJTteBFxmJJYaILbI9rtcLcWqBU
 bIAl6pQAVHsaKYFmRmwUu9fE7CP0+GSveQRjj39PiBoxvCR1+0YgwHNZYmTD1OrmOzu5
 O2bNplUCc/SwPgB9ggkYMmrICTV+wBkadCYbWkQYDDxHnq7qqWwY4AMOITe+Xd6PXgOZ
 dglAMLKOzl+eiR9Yhkl6ElvIDu5EZNIRK53EpzHNSsEi3roZHlWTIHE1itLeFHlP8k32
 7KyPMKAc0asMSl2i8NUw3UlZa0z9aBgClpna8ftcc8bIQhbJwshLs7nrlHqz7dmgSjsN 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5kkc84vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 09:57:04 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24J9rDSK011040;
        Thu, 19 May 2022 09:57:04 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5kkc84us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 09:57:04 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24J9qSfk011879;
        Thu, 19 May 2022 09:57:01 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3g2429f2fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 09:57:01 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24J9uwUg38207958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 09:56:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9518FA405B;
        Thu, 19 May 2022 09:56:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6F66A4054;
        Thu, 19 May 2022 09:56:53 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.43.20.227])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 19 May 2022 09:56:53 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 19 May 2022 15:26:52 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Greg Thelen <gthelen@google.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
In-Reply-To: <xr937d6ic5qk.fsf@gthelen2.svl.corp.google.com>
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
 <xr937d6ic5qk.fsf@gthelen2.svl.corp.google.com>
Date:   Thu, 19 May 2022 15:26:52 +0530
Message-ID: <8735h5hml7.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 52ju57apf4Eux7cGM7kXvW_O-BDPKUUI
X-Proofpoint-GUID: i_wj5J-0QfvOAm51WZkh71nEImRo5w5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_02,2022-05-19_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

Thanks for looking into this patch,

Greg Thelen <gthelen@google.com> writes:

> Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
>> [1] Provides a way for user-space to trigger proactive reclaim by introducing
>> a write-only memcg file 'memory.reclaim'. However reclaim stats like number
>> of pages scanned and reclaimed is still not directly available to the
>> user-space.
>>
>> This patch proposes to extend [1] to make the memcg file 'memory.reclaim'
>> readable which returns the number of pages scanned / reclaimed during the
>> reclaim process from 'struct vmpressure' associated with each memcg. This should
>> let user-space asses how successful proactive reclaim triggered from memcg
>> 'memory.reclaim' was ?
>>
>> With the patch following command flow is expected:
>>
>>  # echo "1M" > memory.reclaim
>>
>>  # cat memory.reclaim
>>    scanned 76
>>    reclaimed 32
>
> I certainly appreciate the ability for shell scripts to demonstrate
> cgroup operations with textual interfaces, but such interface seem like
> they are optimized for ease of use by developers.
>
Agree that directly exposing nr_scanned/reclaimed might not be a useful
for users and certainly looks like a dev interface

> I wonder if for runtime production use an ioctl or netlink interface has
> been considered for cgroup? I don't think there are any yet, but such
> approaches seem like a more straightforward ways to get nontrivial
> input/outputs from a single call (e.g. like this proposal). And they
> have the benefit of not requiring ascii serialization/parsing overhead.

I think to a large degree eBPF and existing static tracepoints in vmscan
can provide access to these metrics as Shakeel Bhat pointed to earlier.

<snip>

-- 
Cheers
~ Vaibhav

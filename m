Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2EE52E434
	for <lists+cgroups@lfdr.de>; Fri, 20 May 2022 07:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345345AbiETFQK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 May 2022 01:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343793AbiETFQI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 May 2022 01:16:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3D61CFE3;
        Thu, 19 May 2022 22:16:06 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K3219w022525;
        Fri, 20 May 2022 05:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=JJh4foNOJwG8ay+rF9OREYoAAGUcy1t9u8UYkcLppDI=;
 b=ELKkv1yz+L8SWhSgdtOrbEXtZvOD+cENx24BoptdFKJngLJFqAFk4gTXTNJ6tG6EB0yF
 JiGrfsBf6gJRSVo7Sb1bkQ6AA1pAL/oR4vJgpke7pfbmhCC/IKyTRKSr4Q4nMWe/kgav
 AIkMzmFjMhAr3rpEbF+raurSOIPtWvkV5AvXlTlmSrLKtmWPUDLhr87OYLEou6LuhXqq
 A5ltkwBf131kfTnPReceOVT54PMoIJCJQejCoP6dewY4M8lJ8otOYiRATJaw/68W5uz+
 RUDj2K+tBQMdhkp8xdt8a93uCsBYzSc48p+lnt+bei2JmuVKNjFB8+u5c0Q3PngIdWYK ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g62qn9x50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 05:15:55 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24K51Q2l030637;
        Fri, 20 May 2022 05:15:54 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g62qn9x4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 05:15:54 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24K5DW8S032186;
        Fri, 20 May 2022 05:15:52 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3g4j3gjx92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 05:15:51 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24K51rQg27197884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 05:01:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91DC342042;
        Fri, 20 May 2022 05:15:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B5734203F;
        Fri, 20 May 2022 05:15:45 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.43.28.38])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 20 May 2022 05:15:44 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Fri, 20 May 2022 10:45:43 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
In-Reply-To: <YoYj4sLJfGke5IGT@dhcp22.suse.cz>
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
 <YoYj4sLJfGke5IGT@dhcp22.suse.cz>
Date:   Fri, 20 May 2022 10:45:43 +0530
Message-ID: <87zgjcg4xs.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5T_FrutWWajenUiwrEh1WQrKQwHVVumD
X-Proofpoint-GUID: Tqq3v_2AuLsqGIjRi0bMvCf5ZZ4XM941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_01,2022-05-19_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1011 impostorscore=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=691 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205200036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Thanks for looking into this patch Michal,

Michal Hocko <mhocko@suse.com> writes:

> On Thu 19-05-22 04:08:15, Vaibhav Jain wrote:
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
> Why cannot you use memory.stat? Sure it would require to iterate over
> the reclaimed hierarchy but the information about scanned and reclaimed
> pages as well as other potentially useful stats is there.

Agree that "memory.stat" is more suitable for scanned/reclaimed stats as
it already is exposing bunch of other stats.

The discussion on this patch however seems to have split into two parts:

1. Is it a good idea to expose nr_scanned/nr_reclaimed to users-space
and if yes how ?

IMHO, I think it will be better to expose this info via 'memory.stat' as it
can be useful insight into the reclaim efficiency  and vmpressure.


2. Will it be useful to provide feedback to userspace when it writes to
'memory.reclaim' on how much memory has been reclaimed ?

IMHO, this will be a useful feeback to userspace to better adjust future
proactive reclaim requests via 'memory.reclaim'


-- 
> Michal Hocko
> SUSE Labs
>

-- 
Cheers
~ Vaibhav

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6978E52CEAF
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 10:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiESIvb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 04:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbiESIvT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 04:51:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DB61EC64;
        Thu, 19 May 2022 01:51:18 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J8g0aX019006;
        Thu, 19 May 2022 08:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=socf21ni5+/NQUYujP3bagP571P0CjAgkZfi4zqTir0=;
 b=rOOUDQo6Z5DXAI+f5cS5iGTGJzMRZyIRzmWkNu71yV7sKQxRXsWTSEcyeyxcYNydQ4b5
 XbwjLz1qisOMWuvioTimZXTepinPvHY9rzzO2sH8ZfkB8pecgk7eh4r1IxxVHBeRgNHz
 OOuOSzQJOEVpj2cp7j3EbX2hD8hTmdnWlgT6dYAExBKmxdRTuZ4yiNIf48B8Ovhbslch
 eZtu7VDXImH7JjzzlX9EsfVgqRx5xzoeqskeAoYC4BW47TIebBulVTczHk5DRO06d/eT
 cRNpeczwkdGwpkpFEEQbAxq13FBds9Fa9/spo7XenH4fp4GPeAOlBsc4dTmkPy8iyLy2 ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5jkxr6m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 08:51:12 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24J8gnox020872;
        Thu, 19 May 2022 08:51:11 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5jkxr6j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 08:51:09 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24J8oC0F016289;
        Thu, 19 May 2022 08:51:07 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3g2429exwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 08:51:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24J8p4qc48103836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 08:51:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C60825204F;
        Thu, 19 May 2022 08:51:04 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.43.20.227])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 5CCAD5204E;
        Thu, 19 May 2022 08:51:00 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 19 May 2022 14:20:58 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
In-Reply-To: <CAJD7tkZSgRs6T60Gv4dZR5xBemxgCB_2s8hz8zB0F_nakN5aTQ@mail.gmail.com>
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
 <CAJD7tkZSgRs6T60Gv4dZR5xBemxgCB_2s8hz8zB0F_nakN5aTQ@mail.gmail.com>
Date:   Thu, 19 May 2022 14:20:58 +0530
Message-ID: <878rqxhpn1.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vvo-JFnOjIqVRaGtOVrFtRpNmEHvUHhd
X-Proofpoint-GUID: _U42p40mTk_VCPyg3m7n7K6jfuXG3VUg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_01,2022-05-19_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190049
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

Yosry Ahmed <yosryahmed@google.com> writes:

> On Wed, May 18, 2022 at 3:38 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>>
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
>
> Isn't this a racy read? struct vmpressure can be changed between the
> write and read by other reclaim operations, right?
Read/write of vmpr stats is always done in context of vmpr->sr_lock
which is also the case for this patch. So not sure how the read is racy
?.

>
> I was actually planning to send a patch that does not updated
> vmpressure for user-controller reclaim, similar to how PSI is handled.
>
Ok, not sure if I am inferring correctly as to how how that would be
useful. Can you please provide some more context.

The primary motivation for this patch was to expose the vmpressure stats
to user space that are available with cgroup-v1 but not with cgroup-v2
AFAIK

> The interface currently returns -EBUSY if the entire amount was not
> reclaimed, so isn't this enough to figure out if it was successful or
> not?
Userspace may very well want to know the amount of memory that was
partially reclaimed even though write to "memory.reclaim" returned
'-EBUSY'. This feedback can be useful info for implementing a retry
loop.

> If not, we can store the scanned / reclaim counts of the last
> memory.reclaim invocation for the sole purpose of memory.reclaim
> reads.
Sure sounds reasonable to me.

> Maybe it is actually more intuitive to users to just read the
> amount of memory read? In a format that is similar to the one written?
>
> i.e
> echo "10M" > memory.reclaim
> cat memory.reclaim
> 9M
>
Agree, I will address that in v2.

<snip>

-- 
Cheers
~ Vaibhav

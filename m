Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA752CF94
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 11:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiESJmG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiESJmF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 05:42:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9083C68F82;
        Thu, 19 May 2022 02:42:04 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J9CQhj012521;
        Thu, 19 May 2022 09:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=OJteXu18Mv+sn23pdhZQcdzdXFdGcyM9JOV5loEpHpk=;
 b=E9lrofY1GFhlXL1u+ccKtgGozb6tczzv0sXWdh/8z6/sni2D8WKZRbk+0xxqC6PREdA5
 hKqVML5YJKrLG+zKyTMibSol3ByZI1nr4W12Pfpv6NnaooTQSXZ7dF6xvrvlXpS73iJR
 yB++dUCc/JPs3iAxZ9WsW20lk3vXBXN2RyBWC8ZvNOZfs2pu/Y2gkQWl0MmJqVDr0zky
 R8zvAb7CQd86cowK+wiiBgzSRN/vyM4A6BLducb3c8++bD/wnICsW0mlNF2c+nMJtJ/d
 brGN+fNw25c1SWpEMLnCpJE4x2ckWxqRb5yJ0ItgxH+ZijcSntbNSLCueXr8TGnlM9nQ jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5k25rkxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 09:41:52 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24J9fq0L015293;
        Thu, 19 May 2022 09:41:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5k25rkwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 09:41:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24J9Slkf014816;
        Thu, 19 May 2022 09:41:49 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3g23pjf1u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 09:41:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24J9RqVS46399838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 09:27:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A58B11C04C;
        Thu, 19 May 2022 09:41:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C18E511C050;
        Thu, 19 May 2022 09:41:42 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.43.20.227])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 19 May 2022 09:41:42 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 19 May 2022 15:11:41 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
In-Reply-To: <20220519050835.ebpiukexgiys6t57@google.com>
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
 <20220519050835.ebpiukexgiys6t57@google.com>
Date:   Thu, 19 May 2022 15:11:41 +0530
Message-ID: <875ym1hnai.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w9gfG1UIEqtLgIyzzT7XtvqSo6EaqHG1
X-Proofpoint-ORIG-GUID: UnqzvSwZfeeq5_Jio2nJQgQmTtH6NjIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_02,2022-05-19_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=802
 clxscore=1015 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190055
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

Shakeel Butt <shakeelb@google.com> writes:

> On Thu, May 19, 2022 at 04:08:15AM +0530, Vaibhav Jain wrote:
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
>> 
>
> Yosry already mentioned the race issue with the implementation and I
> would prefer we don't create any new dependency on vmpressure which I
> think we should deprecate.
Ok,

>
> Anyways my question is how are you planning to use these metrics i.e.
> scanned & reclaimed? I wonder if the data you are interested in can be
> extracted without a stable interface. Have you tried BPF way to get
> these metrics? We already have a tracepoint in vmscan tracing the
> scanned and reclaimed. 
>
Agree that there are enough static trace_mm_vmscan_ tracepoints in
vmscan to get that info.

Also agree that exposing nr_scanned/nr_reclaimed directly to userspace may not
be a good idea but knowing the amount of memory reclaimed might be
useful.

With user-space triggered proactive reclaim user-space code can try to
write a certain value to "memory.reclaim" in a loop till it returns
'-EBUSY'.

Right now there is no direct way for it to get feedback on the progress
of the requested reclaim. Providing a stable interface to ascertain the
progress of reclaim lets that userspace provide smaller values for
proactive reclaim 

-- 
Cheers
~ Vaibhav

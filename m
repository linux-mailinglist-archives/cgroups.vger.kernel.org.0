Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FF160E0D3
	for <lists+cgroups@lfdr.de>; Wed, 26 Oct 2022 14:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiJZMgk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Oct 2022 08:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiJZMgb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Oct 2022 08:36:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB2C8E442;
        Wed, 26 Oct 2022 05:36:23 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QCZoXE004892;
        Wed, 26 Oct 2022 12:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LoNYjlvw7n7AAaxNgSQnxhM7o1qFq0VL7RM3za1O2Yo=;
 b=hm+19J7JgVA0+Lihb+CZfSSiRdzSrxBX9XCM/+hbFMxA7MMCdht3dhn4KzJE3wIGDO+n
 HEbdsQTOfUePta5ZFDtwOpoEJ2+e9jQtxp9fvtklFLU9hR93NfZBB8vuc8KvtDnhoAhO
 XJagtI0c93lj6KerCHSXf4hVrefPyZ17BhisD0WHLEOST//rMRdTQGTGeRzMB/Yi0v9O
 YabPvIU5SblaT+dTvY3/UGq4J/MNSMXB30AeGqoEerg97zYujoKYmfo0iy0YKw1H9TKX
 Yd0zSEDvhs3N6NnZ4ZJRhyF5cTHmSjvxgD82aRG8FP9obnmE08/suvzz8qwPjzF2v9uf UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kf3n5tue3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 12:36:14 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29QCa8Up007547;
        Wed, 26 Oct 2022 12:36:13 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kf3n5ttup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 12:36:13 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29QCYul0005032;
        Wed, 26 Oct 2022 12:35:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3kc7sj7eh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 12:35:53 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29QCZpuZ2163298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 12:35:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C03EAE053;
        Wed, 26 Oct 2022 12:35:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D438AE045;
        Wed, 26 Oct 2022 12:35:48 +0000 (GMT)
Received: from [9.43.91.80] (unknown [9.43.91.80])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Oct 2022 12:35:47 +0000 (GMT)
Message-ID: <22590f74-ec91-e673-32df-8a04b4ab3931@linux.ibm.com>
Date:   Wed, 26 Oct 2022 18:05:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>
References: <20221026074343.6517-1-feng.tang@intel.com>
 <dc453287-015d-fd1c-fe7f-6ee45772d6aa@linux.ibm.com>
 <Y1jpDfwBQId3GkJC@feng-clx> <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
 <d17698d2-c1b5-9aa3-6271-838830d36cc5@linux.ibm.com>
 <Y1kTz1qjfsY1UBPf@dhcp22.suse.cz>
 <44e485d4-acf5-865d-17fe-13be1c1b430b@linux.ibm.com>
 <Y1kmOaXvzwRv/tza@dhcp22.suse.cz>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <Y1kmOaXvzwRv/tza@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1Q9pvveorLwz4xerIDi54tOgfrFYTHPz
X-Proofpoint-ORIG-GUID: y98Ye8vStkw9KLE5ZWvS4COwtqur_lej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 mlxlogscore=995 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/26/22 5:51 PM, Michal Hocko wrote:
> On Wed 26-10-22 17:38:06, Aneesh Kumar K V wrote:
>> On 10/26/22 4:32 PM, Michal Hocko wrote:
>>> On Wed 26-10-22 16:12:25, Aneesh Kumar K V wrote:
>>>> On 10/26/22 2:49 PM, Michal Hocko wrote:
>>>>> On Wed 26-10-22 16:00:13, Feng Tang wrote:
>>>>>> On Wed, Oct 26, 2022 at 03:49:48PM +0800, Aneesh Kumar K V wrote:
>>>>>>> On 10/26/22 1:13 PM, Feng Tang wrote:
>>>>>>>> In page reclaim path, memory could be demoted from faster memory tier
>>>>>>>> to slower memory tier. Currently, there is no check about cpuset's
>>>>>>>> memory policy, that even if the target demotion node is not allowd
>>>>>>>> by cpuset, the demotion will still happen, which breaks the cpuset
>>>>>>>> semantics.
>>>>>>>>
>>>>>>>> So add cpuset policy check in the demotion path and skip demotion
>>>>>>>> if the demotion targets are not allowed by cpuset.
>>>>>>>>
>>>>>>>
>>>>>>> What about the vma policy or the task memory policy? Shouldn't we respect
>>>>>>> those memory policy restrictions while demoting the page? 
>>>>>>  
>>>>>> Good question! We have some basic patches to consider memory policy
>>>>>> in demotion path too, which are still under test, and will be posted
>>>>>> soon. And the basic idea is similar to this patch.
>>>>>
>>>>> For that you need to consult each vma and it's owning task(s) and that
>>>>> to me sounds like something to be done in folio_check_references.
>>>>> Relying on memcg to get a cpuset cgroup is really ugly and not really
>>>>> 100% correct. Memory controller might be disabled and then you do not
>>>>> have your association anymore.
>>>>>
>>>>
>>>> I was looking at this recently and I am wondering whether we should worry about VM_SHARE
>>>> vmas. 
>>>>
>>>> ie, page_to_policy() can just reverse lookup just one VMA and fetch the policy right?
>>>
>>> How would that help for private mappings shared between parent/child?
>>
>>
>> this is MAP_PRIVATE | MAP_SHARED?
> 

Sorry, I meant MAP_ANONYMOUS | MAP_SHARED. 

> This is not a valid combination IIRC. What I meant is a simple
> MAP_PRIVATE|MAP_ANON that is CoW shared between parent and child.
> 
> [...]


-aneesh

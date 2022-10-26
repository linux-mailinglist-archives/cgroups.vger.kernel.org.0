Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F18460DEF0
	for <lists+cgroups@lfdr.de>; Wed, 26 Oct 2022 12:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiJZKmu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Oct 2022 06:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiJZKmt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Oct 2022 06:42:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94833ABD72;
        Wed, 26 Oct 2022 03:42:48 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q9Xsos002280;
        Wed, 26 Oct 2022 10:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WNgUFtjWGH9USvKvZLQ17iS+WULiQ+H9RzkSYjfcDn8=;
 b=c8MXXqzI14y8fJvfgYIuPrKptVGE6dvAYHqTKDmIr1boC1ayA2Yrp5P2qLc8l9uMFTFE
 E1fi/3qACWZ8OAzACJ55CXsl9fzlI3E1MjGXy738PoUI9CT8nw4N/j3cCaYTo+mHVB2l
 GC08DHre0ltr6IRrIZnZqoiXCG1yu9HD+SfA6B+XCBgTrMAo75ZLZbguZF3OpHjSAAbI
 wpdnX4f+DbyGCRlBMMCeyAPW4GeA2+Y98ZN0mXtR8YrfCVzI8ZCzJolr7f9qhXZELR16
 lp0K49WbgcDIrf4HViMxzutJtbiBfNEmEG7pK9JDEfP+G7Dop7w76SX7ODaBikQl06ba Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kewph29xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 10:42:36 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29QAJlcP023694;
        Wed, 26 Oct 2022 10:42:35 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kewph29ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 10:42:35 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29QAYsSd012673;
        Wed, 26 Oct 2022 10:42:33 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3kdugaux0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 10:42:32 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29QAgUQg42205620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 10:42:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C42DAE051;
        Wed, 26 Oct 2022 10:42:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AA93AE045;
        Wed, 26 Oct 2022 10:42:26 +0000 (GMT)
Received: from [9.43.91.80] (unknown [9.43.91.80])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Oct 2022 10:42:26 +0000 (GMT)
Message-ID: <d17698d2-c1b5-9aa3-6271-838830d36cc5@linux.ibm.com>
Date:   Wed, 26 Oct 2022 16:12:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <Y1j7tsj5M0Md/+Er@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B8Yy4Vryoz1bfCOlBhP62fdAHQVDl50e
X-Proofpoint-ORIG-GUID: gsWuB0QGRMpc6iSOccX_MWZSRDyoKLb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_05,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210260057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/26/22 2:49 PM, Michal Hocko wrote:
> On Wed 26-10-22 16:00:13, Feng Tang wrote:
>> On Wed, Oct 26, 2022 at 03:49:48PM +0800, Aneesh Kumar K V wrote:
>>> On 10/26/22 1:13 PM, Feng Tang wrote:
>>>> In page reclaim path, memory could be demoted from faster memory tier
>>>> to slower memory tier. Currently, there is no check about cpuset's
>>>> memory policy, that even if the target demotion node is not allowd
>>>> by cpuset, the demotion will still happen, which breaks the cpuset
>>>> semantics.
>>>>
>>>> So add cpuset policy check in the demotion path and skip demotion
>>>> if the demotion targets are not allowed by cpuset.
>>>>
>>>
>>> What about the vma policy or the task memory policy? Shouldn't we respect
>>> those memory policy restrictions while demoting the page? 
>>  
>> Good question! We have some basic patches to consider memory policy
>> in demotion path too, which are still under test, and will be posted
>> soon. And the basic idea is similar to this patch.
> 
> For that you need to consult each vma and it's owning task(s) and that
> to me sounds like something to be done in folio_check_references.
> Relying on memcg to get a cpuset cgroup is really ugly and not really
> 100% correct. Memory controller might be disabled and then you do not
> have your association anymore.
> 

I was looking at this recently and I am wondering whether we should worry about VM_SHARE
vmas. 

ie, page_to_policy() can just reverse lookup just one VMA and fetch the policy right?
if it VM_SHARE it will be a shared policy we can find using vma->vm_file? 

For non anonymous and anon vma not having any policy set  it is owning task vma->vm_mm->owner task policy ? 
We don't worry about multiple tasks that can be possibly sharing that page right? 

> This all can get quite expensive so the primary question is, does the
> existing behavior generates any real issues or is this more of an
> correctness exercise? I mean it certainly is not great to demote to an
> incompatible numa node but are there any reasonable configurations when
> the demotion target node is explicitly excluded from memory
> policy/cpuset?

I guess vma policy is important. Applications want to make sure that they don't
have variable performance and they go to lengths to avoid that by using MEM_BIND.
So if they access the memory they always know access is satisfied from a specific
set of NUMA nodes. Swapin can cause performance impact but then all continued
access will be from a specific NUMA nodes. With slow memory demotion that is
not going to be the case. Large in-memory database applications are observed to
be sensitive to these access latencies. 


-aneesh

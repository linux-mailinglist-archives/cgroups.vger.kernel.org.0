Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9928E610997
	for <lists+cgroups@lfdr.de>; Fri, 28 Oct 2022 07:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJ1FKR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Oct 2022 01:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJ1FKH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Oct 2022 01:10:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7D92B636;
        Thu, 27 Oct 2022 22:10:04 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S4g4Gj029904;
        Fri, 28 Oct 2022 05:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mC2HFC3gAoqIozZrCZ1GBd6I46486FF/GbrfZbHoDJs=;
 b=sORyH0u7NNmXJ2xhjH2ho9CGfQC2uXTTsV6CCo/wUNjh93gWjsOOergxQFNQ0dGJ+brs
 Sk6ThQx3eCPe0YtR0s/fvl2YLEW4Pb095jSEbrVjXEG5wJ0NVIwkCI7GCLEz/QetJtYF
 q9Yn6cvxHNMTsFgojdXw7jBRBgY89a3aXoRMsdeAoQFrmP0FyI+/ndrpcT/6Fg8k6+Az
 FNLGrmbdQSSW+qhAmSWP9E2Foqa5+MAz3T4g2qPzCD5t+9iL0sZBmVZugSwsMOrwL/NZ
 tvbr6nv4A2EAS7p1Nq8EIvRDMOF4TR+Fmq40JGckJnJGoGaMGYdweYMIM6DRk0pJrF8O vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kg89m0tf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 05:09:42 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29S4gBlO030364;
        Fri, 28 Oct 2022 05:09:40 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kg89m0t8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 05:09:40 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29S563XT023854;
        Fri, 28 Oct 2022 05:09:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3kftf1s332-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 05:09:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29S59YYd2228778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 05:09:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50367A4040;
        Fri, 28 Oct 2022 05:09:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8ABBA404D;
        Fri, 28 Oct 2022 05:09:31 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 05:09:31 +0000 (GMT)
Message-ID: <7b5f533d-4b2e-b45b-ee42-5e1cc3e8a279@linux.ibm.com>
Date:   Fri, 28 Oct 2022 10:39:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] mm/vmscan: respect cpuset policy during page demotion
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc:     "Hocko, Michal" <mhocko@suse.com>,
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
 <Y1kl8VbPE0RYdyEB@feng-clx> <Y1lZV6qHp3gIINGc@dhcp22.suse.cz>
 <CAHbLzkppDPm87dx9-a7t3oP9DuZ0xCPC1UWr+E-s+vh12Gwb+w@mail.gmail.com>
 <Y1ovOeEPXT1fxCuc@feng-clx>
 <CAHbLzkqvh3ry=FjQGuG--As2yYF2NU+bfvORqk1FyfE_vvTwXw@mail.gmail.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <CAHbLzkqvh3ry=FjQGuG--As2yYF2NU+bfvORqk1FyfE_vvTwXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ASFUWSHe5MjllGjLmOisvHNof7sieJp4
X-Proofpoint-GUID: BJChHJSB3LO7Isg854w_XwBD54gS9x6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_02,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280031
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/27/22 11:25 PM, Yang Shi wrote:
> On Thu, Oct 27, 2022 at 12:12 AM Feng Tang <feng.tang@intel.com> wrote:
>>
>> On Thu, Oct 27, 2022 at 01:57:52AM +0800, Yang Shi wrote:
>>> On Wed, Oct 26, 2022 at 8:59 AM Michal Hocko <mhocko@suse.com> wrote:
>> [...]
>>>>>> This all can get quite expensive so the primary question is, does the
>>>>>> existing behavior generates any real issues or is this more of an
>>>>>> correctness exercise? I mean it certainly is not great to demote to an
>>>>>> incompatible numa node but are there any reasonable configurations when
>>>>>> the demotion target node is explicitly excluded from memory
>>>>>> policy/cpuset?
>>>>>
>>>>> We haven't got customer report on this, but there are quite some customers
>>>>> use cpuset to bind some specific memory nodes to a docker (You've helped
>>>>> us solve a OOM issue in such cases), so I think it's practical to respect
>>>>> the cpuset semantics as much as we can.
>>>>
>>>> Yes, it is definitely better to respect cpusets and all local memory
>>>> policies. There is no dispute there. The thing is whether this is really
>>>> worth it. How often would cpusets (or policies in general) go actively
>>>> against demotion nodes (i.e. exclude those nodes from their allowes node
>>>> mask)?
>>>>
>>>> I can imagine workloads which wouldn't like to get their memory demoted
>>>> for some reason but wouldn't it be more practical to tell that
>>>> explicitly (e.g. via prctl) rather than configuring cpusets/memory
>>>> policies explicitly?
>>>>
>>>>> Your concern about the expensive cost makes sense! Some raw ideas are:
>>>>> * if the shrink_folio_list is called by kswapd, the folios come from
>>>>>   the same per-memcg lruvec, so only one check is enough
>>>>> * if not from kswapd, like called form madvise or DAMON code, we can
>>>>>   save a memcg cache, and if the next folio's memcg is same as the
>>>>>   cache, we reuse its result. And due to the locality, the real
>>>>>   check is rarely performed.
>>>>
>>>> memcg is not the expensive part of the thing. You need to get from page
>>>> -> all vmas::vm_policy -> mm -> task::mempolicy
>>>
>>> Yeah, on the same page with Michal. Figuring out mempolicy from page
>>> seems quite expensive and the correctness can't be guranteed since the
>>> mempolicy could be set per-thread and the mm->task depends on
>>> CONFIG_MEMCG so it doesn't work for !CONFIG_MEMCG.
>>
>> Yes, you are right. Our "working" psudo code for mem policy looks like
>> what Michal mentioned, and it can't work for all cases, but try to
>> enforce it whenever possible:
>>
>> static bool  __check_mpol_demotion(struct folio *folio, struct vm_area_struct *vma,
>>                 unsigned long addr, void *arg)
>> {
>>         bool *skip_demotion = arg;
>>         struct mempolicy *mpol;
>>         int nid, dnid;
>>         bool ret = true;
>>
>>         mpol = __get_vma_policy(vma, addr);
>>         if (!mpol) {
>>                 struct task_struct *task;
>>                 if (vma->vm_mm)
>>                         task = vma->vm_mm->owner;
> 
> But this task may not be the task you want IIUC. For example, the
> process has two threads, A and B. They have different mempolicy. The
> vmscan is trying to demote a page belonging to thread A, but the task
> may point to thread B, so you actually get the wrong mempolicy IIUC.
> 

But if we swap out this page and fault back in via thread B the page would
get allocated as per thread B mempolicy. So if we demote based on thread B
policy are we breaking anything? 

-aneesh



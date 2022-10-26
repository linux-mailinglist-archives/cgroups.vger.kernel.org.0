Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0A60E061
	for <lists+cgroups@lfdr.de>; Wed, 26 Oct 2022 14:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiJZMKU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Oct 2022 08:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiJZMJm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Oct 2022 08:09:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BA1DAC73;
        Wed, 26 Oct 2022 05:08:31 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QB1IWN005693;
        Wed, 26 Oct 2022 12:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0rJQ/6J/iAuAghzMH2H1VY1tj1eMIaXDuK47l5fCiHI=;
 b=WPItwFK951AcqgUHkXPYrro1TsotRWSRuvlT5KouMPXRYv6dYn2vaPVoUZ+ODpEA3WsW
 GHMmoS1RtS6JuM7MTFvzZ0ObPy8L/o3MmFRHSBoFXH1h0R94Cpy0YhlxaAnguHyK6CM7
 OXqH8PiHthhVvnYq0eaYrJQFVeNUMzINQbq305/B3nu22qle9v+buajQr/CayAyKqlyP
 oI0vIdi/u1XFovQUB5b168anO0IxY1BPfervjbp7CNE2JpVR/FJ5R9mJhyiz0yOdcenP
 ZZuveNQLA4LAh+j7YEuMNjFMkqdvgAv2OYNqclnjMm/v1njDIP/dN/I5aBHhPAAezG8X kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kf3n5t0b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 12:08:16 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29QBGlvg016869;
        Wed, 26 Oct 2022 12:08:16 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kf3n5t0aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 12:08:16 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29QC6n3D008659;
        Wed, 26 Oct 2022 12:08:14 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3kc7sj5c54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Oct 2022 12:08:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29QC2ugM36962706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 12:02:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFE69AE056;
        Wed, 26 Oct 2022 12:08:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9652FAE045;
        Wed, 26 Oct 2022 12:08:07 +0000 (GMT)
Received: from [9.43.91.80] (unknown [9.43.91.80])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Oct 2022 12:08:07 +0000 (GMT)
Message-ID: <44e485d4-acf5-865d-17fe-13be1c1b430b@linux.ibm.com>
Date:   Wed, 26 Oct 2022 17:38:06 +0530
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
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <Y1kTz1qjfsY1UBPf@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0feQP62859vfw4VBbcGLSHVwjlk74-Su
X-Proofpoint-ORIG-GUID: pfrcUVjngqeirxHYx2Dm8-xZ0KzHE9Hc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/26/22 4:32 PM, Michal Hocko wrote:
> On Wed 26-10-22 16:12:25, Aneesh Kumar K V wrote:
>> On 10/26/22 2:49 PM, Michal Hocko wrote:
>>> On Wed 26-10-22 16:00:13, Feng Tang wrote:
>>>> On Wed, Oct 26, 2022 at 03:49:48PM +0800, Aneesh Kumar K V wrote:
>>>>> On 10/26/22 1:13 PM, Feng Tang wrote:
>>>>>> In page reclaim path, memory could be demoted from faster memory tier
>>>>>> to slower memory tier. Currently, there is no check about cpuset's
>>>>>> memory policy, that even if the target demotion node is not allowd
>>>>>> by cpuset, the demotion will still happen, which breaks the cpuset
>>>>>> semantics.
>>>>>>
>>>>>> So add cpuset policy check in the demotion path and skip demotion
>>>>>> if the demotion targets are not allowed by cpuset.
>>>>>>
>>>>>
>>>>> What about the vma policy or the task memory policy? Shouldn't we respect
>>>>> those memory policy restrictions while demoting the page? 
>>>>  
>>>> Good question! We have some basic patches to consider memory policy
>>>> in demotion path too, which are still under test, and will be posted
>>>> soon. And the basic idea is similar to this patch.
>>>
>>> For that you need to consult each vma and it's owning task(s) and that
>>> to me sounds like something to be done in folio_check_references.
>>> Relying on memcg to get a cpuset cgroup is really ugly and not really
>>> 100% correct. Memory controller might be disabled and then you do not
>>> have your association anymore.
>>>
>>
>> I was looking at this recently and I am wondering whether we should worry about VM_SHARE
>> vmas. 
>>
>> ie, page_to_policy() can just reverse lookup just one VMA and fetch the policy right?
> 
> How would that help for private mappings shared between parent/child?


this is MAP_PRIVATE | MAP_SHARED? and won't they get converted to shared policy for the backing shmfs? via

	} else if (vm_flags & VM_SHARED) {
		error = shmem_zero_setup(vma);
		if (error)
			goto free_vma;
	} else {
		vma_set_anonymous(vma);
	}



> Also reducing this to a single VMA is not really necessary as
> folio_check_references already does most of that work. What is really
> missing is to check for other memory policies (i.e. cpusets and per-task
> mempolicy). The later is what can get quite expensive.
> 


I agree that walking all the related vma is already done in folio_check_references. I was
checking do we really need to check all the vma in case of memory policy.


>> if it VM_SHARE it will be a shared policy we can find using vma->vm_file? 
>>
>> For non anonymous and anon vma not having any policy set  it is owning task vma->vm_mm->owner task policy ? 
> 
> Please note that mm can be shared even outside of the traditional thread
> group so you would need to go into something like mm_update_next_owner
> 
>> We don't worry about multiple tasks that can be possibly sharing that page right? 
> 
> Why not?
> 

On the page fault side for non anonymous vma we only respect the memory policy of the
task faulting the page in. With that restrictions we could always say if demotion
node is allowed by the policy of any task sharing this vma, we can demote the
page to that specific node? 

>>> This all can get quite expensive so the primary question is, does the
>>> existing behavior generates any real issues or is this more of an
>>> correctness exercise? I mean it certainly is not great to demote to an
>>> incompatible numa node but are there any reasonable configurations when
>>> the demotion target node is explicitly excluded from memory
>>> policy/cpuset?
>>
>> I guess vma policy is important. Applications want to make sure that they don't
>> have variable performance and they go to lengths to avoid that by using MEM_BIND.
>> So if they access the memory they always know access is satisfied from a specific
>> set of NUMA nodes. Swapin can cause performance impact but then all continued
>> access will be from a specific NUMA nodes. With slow memory demotion that is
>> not going to be the case. Large in-memory database applications are observed to
>> be sensitive to these access latencies. 
> 
> Yes, I do understand that from the correctness POV this is a problem. My
> question is whether this is a _practical_ problem worth really being
> fixed as it is not really a cheap fix. If there are strong node locality
> assumptions by the userspace then I would expect demotion to be disabled
> in the first place.

Agreed. Right now these applications when they fail to allocate memory from
the Node on which they are running, they fallback to nearby NUMA nodes rather than
failing the database query. They would want to prevent fallback of some allocation
to slow cxl memory to avoid hot database tables getting allocated from the cxl
memory node. In that case one way they can consume slow cxl memory is to partition
the data structure using membind and allow cold pages to demoted back to
slow cxl memory making space for hot page allocation in the running NUMA node. 

Other option is to run the application using fsdax.

I am still not clear which option will get used finally. 


-aneesh


 


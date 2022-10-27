Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D8E60F4B3
	for <lists+cgroups@lfdr.de>; Thu, 27 Oct 2022 12:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiJ0KQv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Oct 2022 06:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbiJ0KQu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Oct 2022 06:16:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E88DB546;
        Thu, 27 Oct 2022 03:16:48 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RABcjr003224;
        Thu, 27 Oct 2022 10:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=f4tgvmYBFxXfft5Mybi5Aij8o0xpC0kpuLEaSBc9Rwo=;
 b=Uy7twgmedret5C+/JjPRsw88hU2t6zdgfhd08a45v9wczvIigEiYoh8HW4vls42ifOnP
 pS8M9bVWznY7Mn6wYQmd16gk6arS0EvS3jm9VVVWLkAnfNsWuo2z00iprObiqFKDjmxY
 drgZBU3rMg5xOjocfHX5tF95LfI34zpLRYmlwmF1zw9G3On0hdi5DBYl8vXzOh8G+QYx
 +JfpADeBpbT70bknNYwsZ1fCC8zFNkqoUVzwmQH38yRpsR8tpo3aR24MGIHxQ2Z0C+6f
 mx/u14bH5oWBVHmVTrP8MchrsPokhVqSHYe9H9Tk6q2UPHGGwj3Md3RlENsBTzeoWUhd Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kfr13g525-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 10:16:17 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29RAF9rY023973;
        Thu, 27 Oct 2022 10:16:16 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kfr13g513-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 10:16:16 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29RA6gmo022678;
        Thu, 27 Oct 2022 10:16:13 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3kfahp148k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 10:16:13 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29RAGBBo34865882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 10:16:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DFF54C040;
        Thu, 27 Oct 2022 10:16:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8630E4C044;
        Thu, 27 Oct 2022 10:16:08 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Oct 2022 10:16:08 +0000 (GMT)
Message-ID: <5a6c29f9-1154-03af-c22e-55108feb155f@linux.ibm.com>
Date:   Thu, 27 Oct 2022 15:46:07 +0530
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
 <22590f74-ec91-e673-32df-8a04b4ab3931@linux.ibm.com>
 <Y1pJG+d+kXJgjNMc@dhcp22.suse.cz>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <Y1pJG+d+kXJgjNMc@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BdHHrRJz8WCpOrpyAy38UGfm1s0Ila3f
X-Proofpoint-ORIG-GUID: z_W7hIf_3DFk-J421gmKvuOyWGS6Y-H9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_04,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=981 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/27/22 2:32 PM, Michal Hocko wrote:

>>
>> Sorry, I meant MAP_ANONYMOUS | MAP_SHARED. 
> 
> I am still not sure where you are targeting to be honest. MAP_SHARED or
> MAP_PRIVATE both can have page shared between several vmas.


What I was checking was w.r.t demotion and shared pages do we need to
cross-check all the related memory policies? On the page fault side, we don't do that.
ie, if the vma policy or the faulting task policy allowed pages to be allocated
from the demotion node, then we allocate the page even if there is a conflicting
policy from another thread. 

For ex: in the case of MAP_ANON | MAP_PRIVATE cow shared pages if the parent 
did allow allocation from the demotion node we can have pages in the demotion node
even though the child memory policy doesn't have the node in the node mask.

-aneesh

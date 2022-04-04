Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD554F0DC7
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 05:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbiDDDxE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 3 Apr 2022 23:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244598AbiDDDwp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 3 Apr 2022 23:52:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376CE2B25E;
        Sun,  3 Apr 2022 20:50:49 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23421a85025755;
        Mon, 4 Apr 2022 03:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=9dfEKjiqJk7peBrMbPWk18ZVy+8Q9UvJWWfMRHUvo6k=;
 b=BmhSMTkV4aoD1xA4JdlOkFBk33G1s0UQNOSavGiLW4aOEhSuC4jwUg+FABcgc7aDxbru
 H99MrhYeN6HqwAnTKjoB1W/DYRIh+k21qapAByc6gB1Bh+IKiJakFbKrVvtKrZPsWUiT
 89KRrpPtO00R3pq0xYQHFUwaoo33d8Lw4J7BKawk1bHjIK/4915rerisvd5q2145wg2I
 9/8lkLGYhs1ntgmr0Rs48coRyVl+KGHaExQuQbfKR7nvvBNo1JhzWNvyvH7i1M8QtM5w
 S+U5wecnCelw0GhRnO26XBS1kwbZuL60JZcAKt1x6sL0bC/lifhVhPu/EN99gbmamj0D GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f6nfpvp53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 03:50:38 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2343UtTf008172;
        Mon, 4 Apr 2022 03:50:37 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f6nfpvp4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 03:50:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2343l1Cw003155;
        Mon, 4 Apr 2022 03:50:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3f6drhjr7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 03:50:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2343oXk827066768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Apr 2022 03:50:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67E074203F;
        Mon,  4 Apr 2022 03:50:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 253F542047;
        Mon,  4 Apr 2022 03:50:19 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.163.10.247])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  4 Apr 2022 03:50:18 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Mon, 04 Apr 2022 09:20:16 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
In-Reply-To: <CAJD7tka1UstKYBVrie-_1CgvtaLtVD1uwgzfk5SifxW4FQbOVw@mail.gmail.com>
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <874k3d6vuq.fsf@vajain21.in.ibm.com>
 <CAJD7tka1UstKYBVrie-_1CgvtaLtVD1uwgzfk5SifxW4FQbOVw@mail.gmail.com>
Date:   Mon, 04 Apr 2022 09:20:16 +0530
Message-ID: <871qyd7bif.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ybb_MQUKKWwZFcBFzRMKgA5MhWXOPkvA
X-Proofpoint-GUID: tW5oG1MSxam5HKOk6A0N5UjV35bOag7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_01,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 mlxlogscore=593
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040018
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Apologies for the delayed response,

Yosry Ahmed <yosryahmed@google.com> writes:

> On Fri, Apr 1, 2022 at 1:39 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>>
>>
>> Yosry Ahmed <yosryahmed@google.com> writes:
>> > From: Shakeel Butt <shakeelb@google.com>
>> >
>> > Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
>> <snip>
>>
>> > +
>> > +     while (nr_reclaimed < nr_to_reclaim) {
>> > +             unsigned long reclaimed;
>> > +
>> > +             if (signal_pending(current))
>> > +                     break;
>> > +
>> > +             reclaimed = try_to_free_mem_cgroup_pages(memcg,
>> > +                                             nr_to_reclaim - nr_reclaimed,
>> > +                                             GFP_KERNEL, true);
>> > +
>> > +             if (!reclaimed && !nr_retries--)
>> > +                     break;
>> > +
>> > +             nr_reclaimed += reclaimed;
>>
>> I think there should be a cond_resched() in this loop before
>> try_to_free_mem_cgroup_pages() to have better chances of reclaim
>> succeding early.
>>
> Thanks for taking the time to look at this!
>
> I believe this loop is modeled after the loop in memory_high_write()
> for the memory.high interface. Is there a reason why it should be
> needed here but not there?
>

memory_high_write() calls drain_all_stock() atleast once before calling
try_to_free_mem_cgroup_pages(). This would drain all percpu stocks
for the given memcg and its descendents, giving a high chance
try_to_free_mem_cgroup_pages() to succeed quickly. Such a functionality
is missing from this patch.

Adding a cond_resched() would atleast give chance to other processess
within the memcg to run and make forward progress thereby making more
pages available for reclaim.

Suggestion is partly based on __perform_reclaim() issues a cond_resche()
as it may get called repeatedly during direct reclaim path.


>> <snip>
>>
>> --
>> Cheers
>> ~ Vaibhav
>

-- 
Cheers
~ Vaibhav

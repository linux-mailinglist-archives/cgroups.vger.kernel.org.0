Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A0362E054
	for <lists+cgroups@lfdr.de>; Thu, 17 Nov 2022 16:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiKQPvd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Nov 2022 10:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbiKQPv2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Nov 2022 10:51:28 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6BA701B1
        for <cgroups@vger.kernel.org>; Thu, 17 Nov 2022 07:51:27 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHF9MVh024666;
        Thu, 17 Nov 2022 15:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VSvo3DzzZ6W9Zwu6bf+7BT7BTowY6XloRvx0HAp2VXg=;
 b=Vp0Lm778Lb7Zr6NKKi4EiSBOCzUMqRjaNe9XDOf5HYK+s4e3f4Hfz66Cg5l/5l2+z4pu
 VQ6O09uvEcmfUkSM4F1UirtN5TJzDlK0RiyzV/D3UPRKtTPtb/4DXXspIWtUHbBjK/P0
 THf01wX6EInqYCyyDNnAXyA57US4/u98ozO9kx0n/f4PPVM+QrOQmEFdmuA9YTq0K4kd
 EfzR5VJLYmGZEgDuNe56iJmBRoFEH5txT1snAEHpeVdLWlxovnFsCLfcKSkp7ip/l7La
 CB6sBhu+yy1ZxyAk0XLcIr+9u5okQPIzvoSi8+DKGgVDBtAYFD2grT2aSEQ7ugi5uRnI QA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwptvhyy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 15:51:16 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHFp9OA011099;
        Thu, 17 Nov 2022 15:51:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3kt348wtxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 15:51:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHFpCLW65995188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 15:51:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 622BBA405C;
        Thu, 17 Nov 2022 15:51:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EBB3A4054;
        Thu, 17 Nov 2022 15:51:11 +0000 (GMT)
Received: from [9.43.118.125] (unknown [9.43.118.125])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 15:51:10 +0000 (GMT)
Message-ID: <9fb5941b-2c74-87af-a476-ce94b43bb542@linux.ibm.com>
Date:   Thu, 17 Nov 2022 21:21:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: cgroup v1 and balance_dirty_pages
Content-Language: en-US
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org
References: <87wn7uf4ve.fsf@linux.ibm.com> <Y3ZPZyaX1WN3tad4@cmpxchg.org>
 <697e50fd-1954-4642-9f61-1afad0ebf8c6@linux.ibm.com>
In-Reply-To: <697e50fd-1954-4642-9f61-1afad0ebf8c6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UR7AIZarpvWBtg2xnyhQzA5pa5B8zsrV
X-Proofpoint-ORIG-GUID: UR7AIZarpvWBtg2xnyhQzA5pa5B8zsrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=759 clxscore=1011
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/17/22 9:12 PM, Aneesh Kumar K V wrote:
> On 11/17/22 8:42 PM, Johannes Weiner wrote:
>> Hi Aneesh,
>>
>> On Thu, Nov 17, 2022 at 12:24:13PM +0530, Aneesh Kumar K.V wrote:
>>> Currently, we don't pause in balance_dirty_pages with cgroup v1 when we
>>> have task dirtying too many pages w.r.t to memory limit in the memcg.
>>> This is because with cgroup v1 all the limits are checked against global
>>> available resources. So on a system with a large amount of memory, a
>>> cgroup with a smaller limit can easily hit OOM if the task within the
>>> cgroup continuously dirty pages.
>>
>> Page reclaim has special writeback throttling for cgroup1, see the
>> folio_wait_writeback() in shrink_folio_list(). It's not as smooth as
>> proper dirty throttling, but it should prevent OOMs.
>>
>> Is this not working anymore?
> 
> The test is a simple dd test on on a 256GB system.
> 
> root@lp2:/sys/fs/cgroup/memory# mkdir test
> root@lp2:/sys/fs/cgroup/memory# cd test/
> root@lp2:/sys/fs/cgroup/memory/test# echo 120M > memory.limit_in_bytes 
> root@lp2:/sys/fs/cgroup/memory/test# echo $$ > tasks 
> root@lp2:/sys/fs/cgroup/memory/test# dd if=/dev/zero of=/home/kvaneesh/test bs=1M 
> Killed
> 
> 
> Will it hit the folio_wait_writeback, because it is sequential i/o and none of the folio
> we are writing will be in writeback?

Other way to look at this is, if the writeback is never started via balance_dirty_pages,
will we be finding folios in shrink_folio_list that is in writeback? 

> 
>>
>>> Shouldn't we throttle the task based on the memcg limits in this case?
>>> commit 9badce000e2c ("cgroup, writeback: don't enable cgroup writeback
>>> on traditional hierarchies") indicates we run into issues with enabling
>>> cgroup writeback with v1. But we still can keep the global writeback
>>> domain, but check the throtling needs against memcg limits in
>>> balance_dirty_pages()?
>>
>> Deciding when to throttle is only one side of the coin, though.
>>
>> The other side is selective flushing in the IO context of whoever
>> generated the dirty data, and matching the rate of dirtying to the
>> rate of writeback. This isn't really possible in cgroup1, as the
>> domains for memory and IO control could be disjunct.
>>
>> For example, if a fast-IO cgroup shares memory with a slow-IO cgroup,
>> what's the IO context for flushing the shared dirty data? What's the
>> throttling rate you apply to dirtiers?
> 
> I am not using I/O controller at all. Only cpu and memory controllers are
> used and what I am observing is depending on the system memory size, the container
> with same memory limits will hit OOM on some machine and not on others.
> 
> One of the challenge with the above test is, we are not able to reclaim via
> shrink_folio_list() because these are dirty file lru pages and we take the
> below code path
> 
> 	if (folio_is_file_lru(folio) &&
> 			    (!current_is_kswapd() ||
> 			     !folio_test_reclaim(folio) ||
> 			     !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
> 	......
> 				goto activate_locked;
> 	}
> 
>  
> 
> -aneesh


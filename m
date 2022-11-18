Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230F762EC96
	for <lists+cgroups@lfdr.de>; Fri, 18 Nov 2022 04:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbiKRD5W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Nov 2022 22:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbiKRD5P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Nov 2022 22:57:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8502A905A6
        for <cgroups@vger.kernel.org>; Thu, 17 Nov 2022 19:57:14 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AI2Dbs0039129;
        Fri, 18 Nov 2022 03:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+OlmRwhv1JUQ0IRPgAVeFsCWRQ3D77HqxBzZtnsNbBw=;
 b=pZhh+fl+SD7CKNk7p5bgNBBYbBLsVmm/5nyT02zUFA94QtwPrDNQ3kJ+RyijV3YfLeLi
 RKxhCb719M4gUgDOQUpbmo5PhbVbYpJwC7KypG4OlaSBhtycdAOE++/LOc9LHbxOgn+9
 +aWMVuA2NpkQRkdtfHXjrahcV1FgE+LrACpjumVSjwIzj//Mtp3Sa/GsmUaLt/FyaIDc
 yJgBWvsLt4I98j+2cJjhfp9BsabbsWsR2Tkj9U7yXMcjfA8xsqak4VMdx9Pvuf4yyb5n
 tUxrdiUnddbwDx7kxCqGGmM8MNTpqWJkkjz8JzvXdq7VAO5MAc6n0lPaL9S6qcAbXbco eQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx132hncm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 03:57:07 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AI3ouFt029821;
        Fri, 18 Nov 2022 03:57:03 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3kwsse0bag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 03:57:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AI3v1mP39977514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 03:57:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78F674C044;
        Fri, 18 Nov 2022 03:57:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58FB34C040;
        Fri, 18 Nov 2022 03:57:00 +0000 (GMT)
Received: from [9.43.38.233] (unknown [9.43.38.233])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Nov 2022 03:57:00 +0000 (GMT)
Message-ID: <c7bd9e56-d49b-f68c-3c98-e345ed21680b@linux.ibm.com>
Date:   Fri, 18 Nov 2022 09:26:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: cgroup v1 and balance_dirty_pages
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org
References: <87wn7uf4ve.fsf@linux.ibm.com> <Y3ZPZyaX1WN3tad4@cmpxchg.org>
 <697e50fd-1954-4642-9f61-1afad0ebf8c6@linux.ibm.com>
 <9fb5941b-2c74-87af-a476-ce94b43bb542@linux.ibm.com>
 <Y3ZhyfROmGKn/jfr@cmpxchg.org>
 <db372090-cd6d-32e9-2ed1-0d5f9dc9c1df@linux.ibm.com>
 <Y3Z0ZIroRFd1B6ad@cmpxchg.org>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <Y3Z0ZIroRFd1B6ad@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: unY5WEhLQ3DKwQTVCzZ4I_B7M3dbT-rw
X-Proofpoint-ORIG-GUID: unY5WEhLQ3DKwQTVCzZ4I_B7M3dbT-rw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=807 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180021
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/17/22 11:20 PM, Johannes Weiner wrote:
> On Thu, Nov 17, 2022 at 10:46:53PM +0530, Aneesh Kumar K V wrote:
>> On 11/17/22 10:01 PM, Johannes Weiner wrote:
>>> On Thu, Nov 17, 2022 at 09:21:10PM +0530, Aneesh Kumar K V wrote:
>>>> On 11/17/22 9:12 PM, Aneesh Kumar K V wrote:
>>>>> On 11/17/22 8:42 PM, Johannes Weiner wrote:
>>>>>> Hi Aneesh,
>>>>>>
>>>>>> On Thu, Nov 17, 2022 at 12:24:13PM +0530, Aneesh Kumar K.V wrote:
>>>>>>> Currently, we don't pause in balance_dirty_pages with cgroup v1 when we
>>>>>>> have task dirtying too many pages w.r.t to memory limit in the memcg.
>>>>>>> This is because with cgroup v1 all the limits are checked against global
>>>>>>> available resources. So on a system with a large amount of memory, a
>>>>>>> cgroup with a smaller limit can easily hit OOM if the task within the
>>>>>>> cgroup continuously dirty pages.
>>>>>>
>>>>>> Page reclaim has special writeback throttling for cgroup1, see the
>>>>>> folio_wait_writeback() in shrink_folio_list(). It's not as smooth as
>>>>>> proper dirty throttling, but it should prevent OOMs.
>>>>>>
>>>>>> Is this not working anymore?
>>>>>
>>>>> The test is a simple dd test on on a 256GB system.
>>>>>
>>>>> root@lp2:/sys/fs/cgroup/memory# mkdir test
>>>>> root@lp2:/sys/fs/cgroup/memory# cd test/
>>>>> root@lp2:/sys/fs/cgroup/memory/test# echo 120M > memory.limit_in_bytes 
>>>>> root@lp2:/sys/fs/cgroup/memory/test# echo $$ > tasks 
>>>>> root@lp2:/sys/fs/cgroup/memory/test# dd if=/dev/zero of=/home/kvaneesh/test bs=1M 
>>>>> Killed
>>>>>
>>>>>
>>>>> Will it hit the folio_wait_writeback, because it is sequential i/o and none of the folio
>>>>> we are writing will be in writeback?
>>>>
>>>> Other way to look at this is, if the writeback is never started via balance_dirty_pages,
>>>> will we be finding folios in shrink_folio_list that is in writeback? 
>>>
>>> The flushers are started from reclaim if necessary. See this code from
>>> shrink_inactive_list():
>>>
>>> 	/*
>>> 	 * If dirty folios are scanned that are not queued for IO, it
>>> 	 * implies that flushers are not doing their job. This can
>>> 	 * happen when memory pressure pushes dirty folios to the end of
>>> 	 * the LRU before the dirty limits are breached and the dirty
>>> 	 * data has expired. It can also happen when the proportion of
>>> 	 * dirty folios grows not through writes but through memory
>>> 	 * pressure reclaiming all the clean cache. And in some cases,
>>> 	 * the flushers simply cannot keep up with the allocation
>>> 	 * rate. Nudge the flusher threads in case they are asleep.
>>> 	 */
>>> 	if (stat.nr_unqueued_dirty == nr_taken)
>>> 		wakeup_flusher_threads(WB_REASON_VMSCAN);
>>>
>>> It sounds like there isn't enough time for writeback to commence
>>> before the memcg already declares OOM.
>>>
>>> If you place a reclaim_throttle(VMSCAN_THROTTLE_WRITEBACK) after that
>>> wakeup, does that fix the issue?
>>
>> yes. That helped. One thing I noticed is with that reclaim_throttle, we
>> don't end up calling folio_wait_writeback() at all. But still the
>> dd was able to continue till the file system got full. 
>>
>> Without that reclaim_throttle(), we do end up calling folio_wait_writeback()
>> but at some point hit OOM 
> 
> Interesting. This is probably owed to the discrepancy between total
> memory and the cgroup size. The flusher might put the occasional
> cgroup page under writeback, but cgroup reclaim will still see mostly
> dirty pages and not slow down enough.
> 
> Would you mind sending a patch for adding that reclaim_throttle()?
> Gated on !writeback_throttling_sane(), with a short comment explaining
> that the flushers may not issue writeback quickly enough for cgroup1
> writeback throttling to work on larger systems with small cgroups.

I will do that. 

-aneesh



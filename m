Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2109162E2BA
	for <lists+cgroups@lfdr.de>; Thu, 17 Nov 2022 18:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiKQRRM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Nov 2022 12:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbiKQRRK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Nov 2022 12:17:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779C2786CA
        for <cgroups@vger.kernel.org>; Thu, 17 Nov 2022 09:17:05 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHFKKU0020609;
        Thu, 17 Nov 2022 17:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=G42eGkTrJWE0iG6kWjtf0l7dlQaK+fb/nW8gTJGtue0=;
 b=Py4yNrKfMI1th2KaLu9DfKjTQoVlCp7+BGVCD2ribEJ7Ucr2GQFua4Q/f6SICU3ouqUZ
 KCAmjw8AfcY7CVWub5N+R++MbtWtl9QtoxVVG9C1PE0TODHmfx9cyeIWWDZ90Lalc+ou
 56XGrU2tq6pNkwo2B4bhcQKK4SmxzmcyKum+EF2szJqbZVbk1BvxuoCrOhfpFF/k/vjD
 t/Dt2D/fBptU4wb8AJ7mTeD8DoDG5dhQ3CvftkEwcn7n9NUycxfvB7dYznT4FP4TJFtZ
 wsfrjHM7vTtkaOYGWM0Df9CcFU07xDrtnxML1bE9NcH8SUjSiaZa2EkZUT9+VTPSOqKW cw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwqguu5hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 17:17:00 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHH74xg014108;
        Thu, 17 Nov 2022 17:16:58 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3kt348yv66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 17:16:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHHGu7k6685322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 17:16:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2332A405F;
        Thu, 17 Nov 2022 17:16:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6FC0A405B;
        Thu, 17 Nov 2022 17:16:54 +0000 (GMT)
Received: from [9.43.118.125] (unknown [9.43.118.125])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 17:16:54 +0000 (GMT)
Message-ID: <db372090-cd6d-32e9-2ed1-0d5f9dc9c1df@linux.ibm.com>
Date:   Thu, 17 Nov 2022 22:46:53 +0530
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
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <Y3ZhyfROmGKn/jfr@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YXYI1UqDVa2YoVTu3r-pLLWbhll8T90R
X-Proofpoint-ORIG-GUID: YXYI1UqDVa2YoVTu3r-pLLWbhll8T90R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=646 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/17/22 10:01 PM, Johannes Weiner wrote:
> On Thu, Nov 17, 2022 at 09:21:10PM +0530, Aneesh Kumar K V wrote:
>> On 11/17/22 9:12 PM, Aneesh Kumar K V wrote:
>>> On 11/17/22 8:42 PM, Johannes Weiner wrote:
>>>> Hi Aneesh,
>>>>
>>>> On Thu, Nov 17, 2022 at 12:24:13PM +0530, Aneesh Kumar K.V wrote:
>>>>> Currently, we don't pause in balance_dirty_pages with cgroup v1 when we
>>>>> have task dirtying too many pages w.r.t to memory limit in the memcg.
>>>>> This is because with cgroup v1 all the limits are checked against global
>>>>> available resources. So on a system with a large amount of memory, a
>>>>> cgroup with a smaller limit can easily hit OOM if the task within the
>>>>> cgroup continuously dirty pages.
>>>>
>>>> Page reclaim has special writeback throttling for cgroup1, see the
>>>> folio_wait_writeback() in shrink_folio_list(). It's not as smooth as
>>>> proper dirty throttling, but it should prevent OOMs.
>>>>
>>>> Is this not working anymore?
>>>
>>> The test is a simple dd test on on a 256GB system.
>>>
>>> root@lp2:/sys/fs/cgroup/memory# mkdir test
>>> root@lp2:/sys/fs/cgroup/memory# cd test/
>>> root@lp2:/sys/fs/cgroup/memory/test# echo 120M > memory.limit_in_bytes 
>>> root@lp2:/sys/fs/cgroup/memory/test# echo $$ > tasks 
>>> root@lp2:/sys/fs/cgroup/memory/test# dd if=/dev/zero of=/home/kvaneesh/test bs=1M 
>>> Killed
>>>
>>>
>>> Will it hit the folio_wait_writeback, because it is sequential i/o and none of the folio
>>> we are writing will be in writeback?
>>
>> Other way to look at this is, if the writeback is never started via balance_dirty_pages,
>> will we be finding folios in shrink_folio_list that is in writeback? 
> 
> The flushers are started from reclaim if necessary. See this code from
> shrink_inactive_list():
> 
> 	/*
> 	 * If dirty folios are scanned that are not queued for IO, it
> 	 * implies that flushers are not doing their job. This can
> 	 * happen when memory pressure pushes dirty folios to the end of
> 	 * the LRU before the dirty limits are breached and the dirty
> 	 * data has expired. It can also happen when the proportion of
> 	 * dirty folios grows not through writes but through memory
> 	 * pressure reclaiming all the clean cache. And in some cases,
> 	 * the flushers simply cannot keep up with the allocation
> 	 * rate. Nudge the flusher threads in case they are asleep.
> 	 */
> 	if (stat.nr_unqueued_dirty == nr_taken)
> 		wakeup_flusher_threads(WB_REASON_VMSCAN);
> 
> It sounds like there isn't enough time for writeback to commence
> before the memcg already declares OOM.
> 
> If you place a reclaim_throttle(VMSCAN_THROTTLE_WRITEBACK) after that
> wakeup, does that fix the issue?

yes. That helped. One thing I noticed is with that reclaim_throttle, we
don't end up calling folio_wait_writeback() at all. But still the
dd was able to continue till the file system got full. 

Without that reclaim_throttle(), we do end up calling folio_wait_writeback()
but at some point hit OOM 

[   78.274704] vmscan: memcg throttling                                               
[   78.422914] dd invoked oom-killer: gfp_mask=0x101c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), order=0, oom_score_adj=0
[   78.422927] CPU: 33 PID: 1185 Comm: dd Not tainted 6.0.0-dirty #394
[   78.422933] Call Trace:   
[   78.422935] [c00000001d0ab1d0] [c000000000cbcba4] dump_stack_lvl+0x98/0xe0 (unreliable)
[   78.422947] [c00000001d0ab210] [c0000000004ef618] dump_header+0x68/0x470
[   78.422955] [c00000001d0ab2a0] [c0000000004ed6e0] oom_kill_process+0x410/0x440
[   78.422961] [c00000001d0ab2e0] [c0000000004eedf0] out_of_memory+0x230/0x950
[   78.422968] [c00000001d0ab380] [c00000000063e748] mem_cgroup_out_of_memory+0x148/0x190
[   78.422975] [c00000001d0ab410] [c00000000064b54c] try_charge_memcg+0x95c/0x9d0
[   78.422982] [c00000001d0ab570] [c00000000064c83c] charge_memcg+0x6c/0x180
[   78.422988] [c00000001d0ab5b0] [c00000000064f9b8] __mem_cgroup_charge+0x48/0xb0
[   78.422993] [c00000001d0ab5f0] [c0000000004dfedc] __filemap_add_folio+0x2cc/0x870
[   78.423000] [c00000001d0ab6b0] [c0000000004e04fc] filemap_add_folio+0x7c/0x130
[   78.423006] [c00000001d0ab710] [c0000000004e1d4c] __filemap_get_folio+0x2dc/0xb00
[   78.423012] [c00000001d0ab840] [c000000000771f64] iomap_write_begin+0x2a4/0xba0
[   78.423018] [c00000001d0ab9a0] [c000000000772a28] iomap_file_buffered_write+0x1c8/0x460
[   78.423024] [c00000001d0abb60] [c0000000009c1bf8] xfs_file_buffered_write+0x158/0x4f0



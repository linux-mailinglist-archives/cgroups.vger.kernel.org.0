Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55025ACB33
	for <lists+cgroups@lfdr.de>; Mon,  5 Sep 2022 08:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiIEGpJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Sep 2022 02:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbiIEGpI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Sep 2022 02:45:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502AE88;
        Sun,  4 Sep 2022 23:45:05 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2855tSmt032206;
        Mon, 5 Sep 2022 06:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gW1gPnN7kNxb4y8nk4Ee1k+14vlMGf9KzqKgmTTkmfk=;
 b=ndjjL+KyQbOBGlfcl4LoT+aXBtejkdmx2C8FujeGUh7i3DChmOtIY2eqeYe52MsagCHU
 h2A4R3+TPgWjc614GcylobB1OU6D7Sf1GyYaHY5AVL21NKC7LZ3fTqaR3umpdEF+GLPT
 oHBj2/Ww7uD2nMQsnCCXj3xzTqoFP9kzBbc7gMfwdKIRzzSw8wovJI/GUbXdJC0wxM21
 DfmTW4KDKq/QV9xrZGk3XVLPy3CDaSUwuQ5jbei6F7sFdM97vvHeIISqAkVWIWN/+gV+
 5Wl6wj3zGqR+84Ao+OvYUoXnsofAx0ZuD6t3uuO81wyjlFQ+Y+H7Uya7w0D3/zx5ndmC QQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jbvmnbm4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 06:44:40 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2856e8RS004289;
        Mon, 5 Sep 2022 06:44:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jc00kyg7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 06:44:39 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2856idaj012725;
        Mon, 5 Sep 2022 06:44:39 GMT
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 2856idT6012689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 06:44:39 +0000
Received: from [10.216.60.176] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 4 Sep 2022
 23:44:30 -0700
Message-ID: <b605c3ec-94ab-a55f-5825-9b370d77ecf3@quicinc.com>
Date:   Mon, 5 Sep 2022 12:14:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: BUG: HANG_DETECT waiting for migration_cpu_stop() complete
Content-Language: en-US
To:     Jing-Ting Wu <jing-ting.wu@mediatek.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>
CC:     <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Jonathan.JMChen@mediatek.com>,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vdonnefort@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        <cgroups@vger.kernel.org>, <lixiong.liu@mediatek.com>,
        <wenju.xu@mediatek.com>
References: <88b2910181bda955ac46011b695c53f7da39ac47.camel@mediatek.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <88b2910181bda955ac46011b695c53f7da39ac47.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gDtQSrWiUSF1RBPYBKPWmgoWj36ZEP6c
X-Proofpoint-ORIG-GUID: gDtQSrWiUSF1RBPYBKPWmgoWj36ZEP6c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_04,2022-09-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=628 lowpriorityscore=0 phishscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050032
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


This is fixed by this.

https://lore.kernel.org/lkml/YvrWaml3F+x9Dk+T@slm.duckdns.org/

-Mukesh

On 9/5/2022 8:17 AM, Jing-Ting Wu wrote:
> Hi,
> 
> We meet the HANG_DETECT happened in T SW version with kernel-5.15.
> Many tasks have been blocked for a long time.
> 
> 
> Root cause:
> migration_cpu_stop() is not complete due to is_migration_disabled(p) is
> true, complete is false and complete_all() never get executed.
> It let other task wait the rwsem.
> 
> Detail:
> system_server waiting for cgroup_threadgroup_rwsem.
> OomAdjuster is holding the cgroup_threadgroup_rwsem and waiting for
> cpuset_rwsem.
> cpuset_hotplug_workfn is holding the cpuset_rwsem and waiting for
> affine_move_task() complete.
> affine_move_task() waiting for migration_cpu_stop() complete.
> 
> The backtrace of system_server:
> __switch_to
> __schedule
> schedule
> percpu_rwsem_wait
> __percpu_down_read
> cgroup_css_set_fork => wait for cgroup_threadgroup_rwsem
> cgroup_can_fork
> copy_process
> kernel_clone
> 
> The backtrace of OomAdjuster:
> __switch_to
> __schedule
> schedule
> percpu_rwsem_wait
> percpu_down_write
> cpuset_can_attach => wait for cpuset_rwsem
> cgroup_migrate_execute
> cgroup_attach_task
> __cgroup1_procs_write => hold cgroup_threadgroup_rwsem
> cgroup1_procs_write
> cgroup_file_write
> kernfs_fop_write_iter
> vfs_write
> ksys_write
> 
> The backtrace of cpuset_hotplug_workfn:
> __switch_to
> __schedule
> schedule
> schedule_timeout
> wait_for_common
> affine_move_task => wait for complete
> __set_cpus_allowed_ptr_locked
> update_tasks_cpumask
> cpuset_hotplug_update_tasks => hold cpuset_rwsem
> cpuset_hotplug_workfn
> process_one_work
> worker_thread
> kthread
> 
> 
> In affine_move_task() will call migration_cpu_stop() and wait for it
> complete.
> In normal case, if migration_cpu_stop() complete it will inform
> everyone that he is done.
> But there is an exception case that will not notify.
> If is_migration_disabled(p) is true and complete will always is false,
> then complete_all() never get executed.
> 
> static int migration_cpu_stop(void *data)
> {
> ...
>      bool complete = false;
> ...
> 
>      if (task_rq(p) == rq) {
>          if (is_migration_disabled(p))
>                goto out; => is_migration_disabled(p) = true,
>                             so complete = false.
>              ...
>          }
> ...
> 
> out:
> ...
>      if (complete) => complete = false,
>                       so complete_all() never get executed.
>          complete_all(&pending->done);
> 
>          return 0;
> }
> 
> 
> Review the code, we found that there are many places can change
> is_migration_disabled() value.
> (such as: __rt_spin_lock(), rt_read_lock(), rt_write_lock(), ...)
> 
> Do you have any suggestion for this issue?
> Thank you.
> 
> 
> 
> 
> Best regards,
> Jing-Ting Wu
> 
> 

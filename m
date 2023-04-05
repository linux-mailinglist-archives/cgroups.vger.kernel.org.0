Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B636D7E40
	for <lists+cgroups@lfdr.de>; Wed,  5 Apr 2023 16:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbjDEOAK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Apr 2023 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbjDEOAJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Apr 2023 10:00:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1604C19
        for <cgroups@vger.kernel.org>; Wed,  5 Apr 2023 07:00:02 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335DSHOg019545;
        Wed, 5 Apr 2023 13:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fD0dMCOCx7i40ZidMOGq2NKWQVPbl6GsrCKyMB4DxUA=;
 b=P/emUiIL6ZYxQEE4Fi8t0E4oZ6P118SH02ihR933Rqm2YMdLi1GtKz6ToLZi5DrIx+Ch
 LJAdZL5YigsDmdA45aG33GPS0V8MCL30DF2Bbx+5wazYSswsVtU54+Yn/I2b2Cg5ckux
 QH0vjLbvmVCskBNh/1ZqpwjFTgUzvMXWOcE/T//oUrP1N3qe9WP2UWsAVNlfgp5l09og
 9wf5eyDM8GnG/GiUcQOzwC4LSkZ20KWbbVU8UFYX/5mGOpRFACLp3US1UavWLakRD3Rh
 PoX5R9XpDl2TC2KfeJOluaAhu7dKz03rCJ3IL/HLCKZ5wNahRvEt3Cxhka5iw8ozYeNl mQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prgveute9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 13:58:16 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 335DwFdL024218
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 13:58:15 GMT
Received: from [10.216.43.4] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 5 Apr 2023
 06:58:11 -0700
Message-ID: <f7ffb989-cae4-c708-51d9-25aca0822aa4@quicinc.com>
Date:   Wed, 5 Apr 2023 19:27:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] cgroup,freezer: hold cpu_hotplug_lock before
 freezer_mutex
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
CC:     Cgroups <cgroups@vger.kernel.org>,
        syzbot <syzbot+c39682e86c9d84152f93@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hillf Danton <hdanton@sina.com>
References: <00000000000009483d05ec7a6b93@google.com>
 <695b8d1c-6b7a-91b1-6941-c459cab038b0@I-love.SAKURA.ne.jp>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <695b8d1c-6b7a-91b1-6941-c459cab038b0@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sMI5XoV-Jo3sSc63MIE_bUFDeaAE7vnW
X-Proofpoint-GUID: sMI5XoV-Jo3sSc63MIE_bUFDeaAE7vnW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=645
 clxscore=1011 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304050126
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 4/5/2023 6:45 PM, Tetsuo Handa wrote:
> syzbot is reporting circular locking dependency between cpu_hotplug_lock
> and freezer_mutex, for commit f5d39b020809 ("freezer,sched: Rewrite core
> freezer logic") replaced atomic_inc() in freezer_apply_state() with
> static_branch_inc() which holds cpu_hotplug_lock.
> 
> cpu_hotplug_lock => cgroup_threadgroup_rwsem => freezer_mutex
> 
>    cgroup_file_write() {
>      cgroup_procs_write() {
>        __cgroup_procs_write() {
>          cgroup_procs_write_start() {
>            cgroup_attach_lock() {
>              cpus_read_lock() {
>                percpu_down_read(&cpu_hotplug_lock);
>              }
>              percpu_down_write(&cgroup_threadgroup_rwsem);
>            }
>          }
>          cgroup_attach_task() {
>            cgroup_migrate() {
>              cgroup_migrate_execute() {
>                freezer_attach() {
>                  mutex_lock(&freezer_mutex);
>                  (...snipped...)
>                }
>              }
>            }
>          }
>          (...snipped...)
>        }
>      }
>    }
> 
> freezer_mutex => cpu_hotplug_lock
> 
>    cgroup_file_write() {
>      freezer_write() {
>        freezer_change_state() {
>          mutex_lock(&freezer_mutex);
>          freezer_apply_state() {
>            static_branch_inc(&freezer_active) {
>              static_key_slow_inc() {
>                cpus_read_lock();
>                static_key_slow_inc_cpuslocked();
>                cpus_read_unlock();
>              }
>            }
>          }
>          mutex_unlock(&freezer_mutex);
>        }
>      }
>    }
> 
> Swap locking order by moving cpus_read_lock() in freezer_apply_state()
> to before mutex_lock(&freezer_mutex) in freezer_change_state().
> 
> Reported-by: syzbot <syzbot+c39682e86c9d84152f93@syzkaller.appspotmail.com>
> Link: https://syzkaller.appspot.com/bug?extid=c39682e86c9d84152f93
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>   kernel/cgroup/legacy_freezer.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
> index 1b6b21851e9d..936473203a6b 100644
> --- a/kernel/cgroup/legacy_freezer.c
> +++ b/kernel/cgroup/legacy_freezer.c
> @@ -22,6 +22,7 @@
>   #include <linux/freezer.h>
>   #include <linux/seq_file.h>
>   #include <linux/mutex.h>
> +#include <linux/cpu.h>
>   
>   /*
>    * A cgroup is freezing if any FREEZING flags are set.  FREEZING_SELF is
> @@ -350,7 +351,7 @@ static void freezer_apply_state(struct freezer *freezer, bool freeze,
>   
>   	if (freeze) {
>   		if (!(freezer->state & CGROUP_FREEZING))
> -			static_branch_inc(&freezer_active);
> +			static_branch_inc_cpuslocked(&freezer_active);
>   		freezer->state |= state;
>   		freeze_cgroup(freezer);
>   	} else {
> @@ -361,7 +362,7 @@ static void freezer_apply_state(struct freezer *freezer, bool freeze,
>   		if (!(freezer->state & CGROUP_FREEZING)) {
>   			freezer->state &= ~CGROUP_FROZEN;
>   			if (was_freezing)
> -				static_branch_dec(&freezer_active);
> +				static_branch_dec_cpuslocked(&freezer_active);
>   			unfreeze_cgroup(freezer);
>   		}
>   	}
> @@ -379,6 +380,7 @@ static void freezer_change_state(struct freezer *freezer, bool freeze)
>   {
>   	struct cgroup_subsys_state *pos;
>   
> +	cpus_read_lock();
>   	/*
>   	 * Update all its descendants in pre-order traversal.  Each
>   	 * descendant will try to inherit its parent's FREEZING state as
> @@ -407,6 +409,7 @@ static void freezer_change_state(struct freezer *freezer, bool freeze)
>   	}
>   	rcu_read_unlock();
>   	mutex_unlock(&freezer_mutex);
> +	cpus_read_unlock();
>   }
>   
>   static ssize_t freezer_write(struct kernfs_open_file *of,

This was reported here as well

https://lore.kernel.org/lkml/90147a2b-982e-ae57-9b7c-062bee0fab07@redhat.com/

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

--Mukesh


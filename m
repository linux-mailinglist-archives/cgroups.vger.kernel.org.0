Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF36455E078
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiF0Gua (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 02:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiF0Gua (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 02:50:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F3726C5;
        Sun, 26 Jun 2022 23:50:28 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LWdYs5GQtzShYT;
        Mon, 27 Jun 2022 14:46:57 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 14:50:26 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 14:50:25 +0800
Message-ID: <5987be34-b527-4ff5-a17d-5f6f0dc94d6d@huawei.com>
Date:   Mon, 27 Jun 2022 14:50:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
From:   Zhang Qiao <zhangqiao22@huawei.com>
Subject: [Question] The system may be stuck if there is a cpu cgroup
 cpu.cfs_quato_us is very low
To:     Tejun Heo <tj@kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        <vschneid@redhat.com>, <dietmar.eggemann@arm.com>,
        <bristot@redhat.com>, <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

I'm working on debuging a problem.
The testcase does follew operations:
1) create a test task cgroup, set cpu.cfs_quota_us=2000,cpu.cfs_period_us=100000.
2) run 20 test_fork[1] test process in the test task cgroup.
3) create 100 new containers:
   for i in {1..100}; do docker run -itd  --health-cmd="ls" --health-interval=1s ubuntu:latest  bash; done

These operations are expected to succeed and 100 containers create success. however, when creating containers,
the system will get stuck and create container failed.

After debug this, I found the test_fork process frequently sleep in freezer_fork()->mutex_lock()->might_sleep()
with taking the cgroup_threadgroup_rw_sem lock, as follow:

copy_process():
	cgroup_can_fork()			---> lock cgroup_threadgroup_rw_sem
	sched_cgroup_fork();
	  ->task_fork_fair(){
	      ->update_curr(){
		  ->__account_cfs_rq_runtime() {
			resched_curr();		---> the quota is used up, and set flag TIF_NEED_RESCHED to current
		   }
	cgroup_post_fork();   		
	  ->feezer_fork()
	      ->mutex_lock() {	
		  ->might_sleep()  		---> schedule() and the current task will be throttled long time.

	  ->cgroup_css_set_put_fork()    	---> unlock cgroup_threadgroup_rw_sem


Becuase the task cgroup's cpu.cfs_quota_us is very small and test_fork's load is very heavy, the test_fork
may be throttled long time, therefore, the cgroup_threadgroup_rw_sem read lock is held for a long time, other
processes will get stuck waiting for the lock:

1) a task fork child, will wait at copy_process()->cgroup_can_fork();

2) a task exiting will wait at exit_signals();

3) a task write cgroup.procs file will wait at cgroup_file_write()->__cgroup1_procs_write();
...

even the whole system will get stuck.

Anyone know how to slove this? Except for changing the cpu.cfs_quota_us.


[1] test_fork.c

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

int main(int argc, char **argv)
{
    pid_t pid;
    int count = 20;

    while(1) {
        for (int i = 0; i < count; i++) {
            if ((pid = fork()) <0) {
                printf("fork error");
                return 1;
            } else if (pid ==0) {
                exit(0);
            }
        }

        for (int i = 0; i < count; i++) {
            wait(NULL);
        }
	sleep(1);
    }
    return 0;
}

Thanks a lot.
-Qiao
-

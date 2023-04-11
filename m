Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AE26DDFCC
	for <lists+cgroups@lfdr.de>; Tue, 11 Apr 2023 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjDKPic (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 11:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDKPib (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 11:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22881997
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681227465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTDsV2/tX8haDNnpkjSlLgt775sitOFHSkt/SKuZWFs=;
        b=K6dwkkWfc5NWhd8ZjiR1Lwg9NO8XdOOGHvDHkgogr8Xjz5aQq44OO2eH5pOGkyjdrSeOSL
        fWAE2ITP1qTPKa++2s9TeYuO8wzEelal8jEUAsXHN/czVTl0GaxmLghYghdsQf+O912Shj
        FKqxhDY1chSvV7mrT5rRF1tI/U7FGXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-mnOGPvgQMKOfRKxs-eFBAw-1; Tue, 11 Apr 2023 11:37:42 -0400
X-MC-Unique: mnOGPvgQMKOfRKxs-eFBAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B79578996E4;
        Tue, 11 Apr 2023 15:37:40 +0000 (UTC)
Received: from [10.22.33.155] (unknown [10.22.33.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52BF61121320;
        Tue, 11 Apr 2023 15:37:40 +0000 (UTC)
Message-ID: <490db90c-6afd-d934-4cd2-2722579f377d@redhat.com>
Date:   Tue, 11 Apr 2023 11:37:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: When processes are forked using clone3 to a cgroup in cgroup v2
 with a specified cpuset.cpus, the cpuset.cpus doesn't take an effect to the
 new processes
Content-Language: en-US
To:     "Kernel.org Bugbot" <bugbot@kernel.org>, tj@kernel.org,
        bugs@lists.linux.dev, cgroups@vger.kernel.org, hannes@cmpxchg.org,
        lizefan.x@bytedance.com
References: <20230411-b217305c0-44d643ccee27@bugzilla.kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230411-b217305c0-44d643ccee27@bugzilla.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/11/23 11:04, Kernel.org Bugbot wrote:
> tcao34 writes via Kernel.org Bugzilla:
>
> When using Linux Kernel 6.0 or 6.3-rc5, we found an issue related to clone3 and cpuset subsystem of cgroup v2. When I'm trying to use clone3 with flags "CLONE_INTO_CGROUP" to clone a process into a cgroup, the cpuset.cpus of the cgroup doesn't take an effect to the new processes.

This is a known issue and have been reported before. An upstream patch 
to fix this problem is being discussed [1].

[1] 
https://lore.kernel.org/lkml/20230411133601.2969636-1-longman@redhat.com/

Cheers,
Longman

>
> Reproduce
> ==============
> 1) I'm using kernel 6.0 and kernel 6.3-rc5. When booting the kernel, I add the command "cgroup_no_v1=all" to disable cgroup v1.
>
> 2) We create a cgroup named 't0' and set cpuset.cpus as the first cpu:
>
> echo '+cpuset' > /sys/fs/cgroup/cgroup.subtree_control
> mkdir /sys/fs/cgroup/t0
> echo 0 > /sys/fs/cgroup/t0/cpuset.cpus
>
> 2) we run the belowing c program, in which we use clone3 system call to clone 9 processes into cgroup 't0':
>
> #define _GNU_SOURCE
>
> #include <time.h>
> #include <stdio.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <stdint.h>
> #include <sys/syscall.h>
> #include <sys/wait.h>
> #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
>
> #define __aligned_u64 uint64_t __attribute__((aligned(8)))
>
> int dirfd_open_opath(const char *dir)
> {
>          return open(dir, O_RDONLY | O_PATH);
> }
>
> struct __clone_args {
>          __aligned_u64 flags;
>          __aligned_u64 pidfd;
>          __aligned_u64 child_tid;
>          __aligned_u64 parent_tid;
>          __aligned_u64 exit_signal;
>          __aligned_u64 stack;
>          __aligned_u64 stack_size;
>          __aligned_u64 tls;
>          __aligned_u64 set_tid;
>          __aligned_u64 set_tid_size;
>          __aligned_u64 cgroup;
> };
>
> pid_t clone_into_cgroup(int cgroup_fd)
> {
>          pid_t pid;
>          struct __clone_args args = {
>                  .flags = CLONE_INTO_CGROUP,
>                  .exit_signal = SIGCHLD,
>                  .cgroup = cgroup_fd,
>          };
>      	pid = syscall(SYS_clone3, &args, sizeof(struct __clone_args));
>
>          if (pid < 0)
>                  return -1;
>
>          return pid;
> }
>
>
> int main(int argc, char *argv[]) {
>      int i, n = 9;
>      int status = 0;
>      pid_t pids[9];
>      pid_t wpid;
>      char cgname[100] = "/sys/fs/cgroup/t0";
>      int cgroup_fd;
>
>      for (i = 0; i < n; ++i) {
>          cgroup_fd = dirfd_open_opath(cgname);
>          pids[i] = clone_into_cgroup(cgroup_fd);
>          close(cgroup_fd);
>          if (pids[i] < 0) {
>              perror("fork");
>              abort();
>          } else if (pids[i] == 0) {
>              printf("fork successfully %d\n", getppid());
>              while(1);
>          }
>      }
>      while ((wpid = wait(&status)) > 0);
>
> }
>
> 3) Use 'ps' command, we get the pids of the new forked processes are: 1816, 1817, 1818, 1819, 1820, 1821, 1822, 1823, 1824
>
> 4) When we call "cat /sys/fs/cgroup/t0/cgroup.procs", the results show that all new forked processes are attached to the cgroup 't0':
> root@node0:/sys/fs/cgroup/t0# cat /sys/fs/cgroup/t0/cgroup.procs
> 1816
> 1817
> 1818
> 1819
> 1820
> 1821
> 1822
> 1823
> 1824
>
> 5) However, when we use taskset to check the cpu affinity, all new forked processes are allowed to use all available cpus.
> root@node0:/sys/fs/cgroup/t0# taskset -p 1816
> pid 1816's current affinity mask: ffffffffff
>
> 6) Also, if we check by 'top', each task is using 100% cpu time, rather than 9 tasks share the first cpu.
>      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>     1816 root      20   0    2496    960    960 R 100.0   0.0   4:04.08 test
>     1817 root      20   0    2496    960    960 R 100.0   0.0   4:04.08 test
>     1818 root      20   0    2496    960    960 R 100.0   0.0   4:04.08 test
>     1819 root      20   0    2496    960    960 R 100.0   0.0   4:04.08 test
>     1820 root      20   0    2496    960    960 R 100.0   0.0   4:04.08 test
>     1821 root      20   0    2496    960    960 R 100.0   0.0   4:04.08 test
>     1822 root      20   0    2496    960    960 R 100.0   0.0   4:04.08 test
>     1823 root      20   0    2496    960    960 R 100.0   0.0   4:04.08 test
>     1824 root      20   0    2496    960    960 R 100.0   0.0   4:04.08 test
>
> root cause
> ==============
> In $Linux_DIR/kernel/cgroup/cpuset.c, function cpuset_fork works as:
> static void cpuset_fork(struct task_struct *task)
> {
> 	if (task_css_is_root(task, cpuset_cgrp_id))
> 		return;
>
> 	set_cpus_allowed_ptr(task, current->cpus_ptr);
> 	task->mems_allowed = current->mems_allowed;
> }
>
> It directly set the allowed cpus of the new forked task as the cpus_ptr of current task (aka parent task). However, if we use clone3() to clone a task to a different cgroup, a task still inherits the parent's allowed_cpus rather than the allowed_cpus of the cgroup clone3() specified.
>
> Fix
> ==============
> We add a patch to the commit 148341f0a2f53b5e8808d093333d85170586a15d and it can fix the issue in this senarior.
>
> ---
>   kernel/cgroup/cpuset.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 636f1c682ac0..fe03c21ba1af 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3254,10 +3254,12 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
>    */
>   static void cpuset_fork(struct task_struct *task)
>   {
> +       struct cpuset * cs;
>          if (task_css_is_root(task, cpuset_cgrp_id))
>                  return;
>
> -       set_cpus_allowed_ptr(task, current->cpus_ptr);
> +       cs = task_cs(task);
> +       set_cpus_allowed_ptr(task, cs->effective_cpus);
>          task->mems_allowed = current->mems_allowed;
>   }
>


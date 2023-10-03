Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4998E7B7012
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 19:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjJCRlO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 13:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjJCRlN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 13:41:13 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C76A6
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 10:41:09 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d81afd5273eso1254850276.3
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696354868; x=1696959668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N6KiyoUKCFZalb1pJlrvprAUrotFN5kiod+0EeRYx44=;
        b=IEpuyu3+xNMnygAvv8YbImv50804pkUV5ThU7gXfwQyRe6tqvhxAQegeUjEBwsXP2S
         Z2Pt1YCr2qBRncKnVYnct5PrFXgzFyJ4CBQ8+LLHPSpcG5aRCdrmyzrckfgtwi3jUenf
         dFaZes0QS+qK6t8Y92aojUAyLXe0ptT8fHNvZhGhjoNZBq7b9ajW6dKw7fUMxpzKqcke
         8zVDMYgdJOleTuFyhd+C+eYbHUqw7sF6R8DZEf2Ava2INRic3IfkEu1p3RmNi/fxFlsC
         lfzgI8QwVR4B/nrVCDbjjR6nxrjxRqJyo4JluOL87QeXSh/NmAE42a6uY05Xc+02Hi5U
         +jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696354868; x=1696959668;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6KiyoUKCFZalb1pJlrvprAUrotFN5kiod+0EeRYx44=;
        b=gPo6uUMEGc4ZAmFTyYiHS35EQjhVyI5lGK5X1Jo2r8Zgex8Pz78yknLu9bM5PdvZLw
         Hm2C2JwTuF5Gg1mkQha+rzbpDBQYGK9wTm4q8UCUwZAUpYvoqVFHaLdUVtmRuF4Bllhz
         FxVI7Oxc+MorifjtfFjY0eoT+I/7XrA/2O7TljHARefvVcPC1WPzbgthncpirEsMCLlc
         6IitslgW0WKGCISTWQA7lp0gzF9oGvY+Q1meBSQHjajpNiTd9QFwN1+EaaPKkx6Izy5w
         mm7WcK3z9RCauexzFxvjFfh1CCZxWt95/liDCtIQxuz5lDZ+c1fnn2WUD7+ZlfkTzlDM
         OTFQ==
X-Gm-Message-State: AOJu0YzUDZPcIpU1f09JipDAHW+WgSSH4sBCeVd3GNcnJHrVe1St/VIn
        q8JiI17d5V8HuzONEkSt4RctlWY8qMBH0T5rgB1ayg==
X-Google-Smtp-Source: AGHT+IFHhnjkmEDP5u3/R+OL/nONLkynZxVrxTF/RKRmkxIk/omRjdayLZp5ilwY4ls7xhsuzTxSaUn06nkaJEnL0ow=
X-Received: by 2002:a25:df91:0:b0:d86:9c13:4210 with SMTP id
 w139-20020a25df91000000b00d869c134210mr16420765ybg.56.1696354868045; Tue, 03
 Oct 2023 10:41:08 -0700 (PDT)
MIME-Version: 1.0
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 3 Oct 2023 10:40:56 -0700
Message-ID: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
Subject: [Bug Report] EBUSY for cgroup rmdir after cgroup.procs empty
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org
Cc:     Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

Samsung reported an Android bug where over 1000 cgroups were left
empty without being removed. These cgroups should have been removed
after no processes were observed to be remaining in the cgroup by this
code [1], which loops until cgroup.procs is empty and then attempts to
rmdir the cgroup. That works most of the time, but occasionally the
rmdir fails with EBUSY *after cgroup.procs is empty*, which seems
wrong. No controllers are enabled in this cgroup v2 hierarchy; it's
currently used only for freezer. I spoke with Suren about this, who
recalled a similar problem and fix [2], but all the kernels I've
tested contain this fix. I have been able to reproduce this on 5.10,
5.15, 6.1, and 6.3 on various hardware. I've written a reproducer
(below) which typically hits the issue in under a minute.

The trace events look like this when the problem occurs. I'm guessing
the rmdir is attempted in that window between signal_deliver and
cgroup_notify_populated = 0.

           a.out-3786312 [120] ..... 629614.073808: task_newtask:
pid=3786313 comm=a.out clone_flags=1200000 oom_score_adj=200
           a.out-3786312 [120] ..... 629614.073832:
sched_process_fork: comm=a.out pid=3786312 child_comm=a.out
child_pid=3786313
           a.out-3786313 [028] d..2. 629614.074712:
cgroup_notify_populated: root=0 id=240416 level=1 path=/B val=1
           a.out-3786313 [028] dN.1. 629614.074742:
cgroup_attach_task: dst_root=0 dst_id=240416 dst_level=1 dst_path=/B
pid=3786313 comm=a.out
           a.out-3786312 [120] d..1. 629614.302764: signal_generate:
sig=9 errno=0 code=0 comm=a.out pid=3786313 grp=1 res=0
           <...>-3786313 [028] d..1. 629614.302789: signal_deliver:
sig=9 errno=0 code=0 sa_handler=0 sa_flags=0
           a.out-3786313 [028] ..... 629614.303007:
sched_process_exit: comm=a.out pid=3786313 prio=120
           a.out-3786313 [028] dN.2. 629614.303039:
cgroup_notify_populated: root=0 id=240416 level=1 path=/B val=0
           a.out-3786313 [028] dN.2. 629614.303057: signal_generate:
sig=17 errno=0 code=2 comm=a.out pid=3786312 grp=1 res=0
          <idle>-0       [120] ..s1. 629614.333591:
sched_process_free: comm=a.out pid=3786313 prio=120

However on Android we retry the rmdir for 2 seconds after cgroup.procs
is empty and we're still occasionally hitting the failure. On my
primary phone with 3 days of uptime I see a handful of cases, but the
problem is orders of magnitude worse on Samsung's device.

panther:/ $ find /sys/fs/cgroup/ -path "*/pid_*/cgroup.procs" -exec sh
-c 'return $(wc -l $0 | cut -f1 -d" ")' {} \; -print
/sys/fs/cgroup/uid_10133/pid_19665/cgroup.procs
/sys/fs/cgroup/uid_10133/pid_19784/cgroup.procs
/sys/fs/cgroup/uid_10133/pid_13124/cgroup.procs
/sys/fs/cgroup/uid_10133/pid_15176/cgroup.procs
/sys/fs/cgroup/uid_10274/pid_12322/cgroup.procs
/sys/fs/cgroup/uid_1010120/pid_13631/cgroup.procs
/sys/fs/cgroup/uid_10196/pid_27894/cgroup.procs
/sys/fs/cgroup/uid_1010133/pid_16103/cgroup.procs
/sys/fs/cgroup/uid_1010133/pid_29181/cgroup.procs
/sys/fs/cgroup/uid_10129/pid_7940/cgroup.procs
/sys/fs/cgroup/uid_10266/pid_11765/cgroup.procs

Please LMK if there's any more info I can provide.

[1] https://android.googlesource.com/platform/system/core/+/3483798fd9045f93e9095e5b09ffe4f59054c535/libprocessgroup/processgroup.cpp#522
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/cgroup/cgroup.c?id=9c974c77246460fa6a92c18554c3311c8c83c160

// Run with: while sudo ./a.out; do :; done
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include <atomic>
#include <chrono>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <thread>
#include <vector>

static bool cgroupHasProcs(std::filesystem::path cgroup_path, bool
print = false) {
    cgroup_path /= "cgroup.procs";
    std::ifstream procs(cgroup_path);

    std::string line;
    bool populated = false;
    while(std::getline(procs, line)) {
        populated = true;
        if (print)
            std::cout << "Found " << line << " in " << cgroup_path << '\n';
        else
            break;
    }
    return populated;
}

static void SigChldHandler(int /*signal_number*/, siginfo_t* /*info*/,
void* /*ucontext*/) {
    pid_t pid;
    int status;
    while((pid = waitpid(-1, &status, WNOHANG)) > 0) {
        if (WIFEXITED(status))
            std::cout << "Process " << pid << " exited cleanly (" <<
WEXITSTATUS(status) << ")\n";
        else if (WIFSIGNALED(status))
            std::cout << "Process " << pid << " exited due to signal "
<< WTERMSIG(status) << " (" << strsignal(WTERMSIG(status)) << ")\n";
    }
}

static bool migrateToCgroup(std::filesystem::path cgroup_path) {
    cgroup_path /= "cgroup.procs";
    std::ofstream procs(cgroup_path);
    procs << getpid();
    procs.flush();
    return static_cast<bool>(procs);
}

static std::atomic<bool> noProcs = false;
static const std::filesystem::path CG_A_PATH = "/sys/fs/cgroup/A";
static const std::filesystem::path CG_B_PATH = "/sys/fs/cgroup/B";

static void readProcs() {
    while (cgroupHasProcs(CG_B_PATH))
        std::this_thread::sleep_for(std::chrono::milliseconds(5));
    noProcs = true;
}

int main()
{
    struct sigaction sig_chld = {};
    sig_chld.sa_sigaction = SigChldHandler;
    sig_chld.sa_flags = SA_SIGINFO;

    if (sigaction(SIGCHLD, &sig_chld, nullptr) < 0) {
        std::cerr << "Error setting SIGCHLD handler: " <<
std::strerror(errno) << std::endl;
        return EXIT_FAILURE;
    }

    if (std::error_code ec;
!std::filesystem::create_directory(CG_A_PATH, ec) && ec) {
        std::cerr << "Error creating cgroups (Are you root?): " <<
ec.message() << std::endl;
        return EXIT_FAILURE;
    }

    if (std::error_code ec;
!std::filesystem::create_directory(CG_B_PATH, ec) && ec) {
        std::cerr << "Error creating cgroups (Are you root?): " <<
ec.message() << std::endl;
        return EXIT_FAILURE;
    }

    if (!migrateToCgroup(CG_A_PATH)) {
        std::cerr << "Failed to migrate to " << CG_A_PATH << " (Are
you root?): " << std::strerror(errno) << std::endl;
        return EXIT_FAILURE;
    }

    const pid_t pid = fork();
    if (pid == -1) {
        std::cerr << "Failed to fork child process: " <<
std::strerror(errno) << std::endl;
        return EXIT_FAILURE;
    } else if (pid == 0) {
        migrateToCgroup(CG_B_PATH);
        pause();
        return EXIT_SUCCESS;
    } else {
        int ret = EXIT_SUCCESS;

        std::vector<std::thread> threads(2*std::thread::hardware_concurrency());
        for (std::thread &t : threads)
            t = std::thread(readProcs);

        std::this_thread::sleep_for(std::chrono::milliseconds(200));
        kill(pid, SIGKILL);

        while(!noProcs)
            std::this_thread::sleep_for(std::chrono::milliseconds(1));

        if(std::error_code ec; !std::filesystem::remove(CG_B_PATH, ec)) {
            std::cerr << "Cannot remove " << CG_B_PATH << ": " <<
ec.message() << std::endl;
            ret = EXIT_FAILURE;
        }

        for(std::thread &t : threads)
            if(t.joinable())
                t.join();
        return ret;
    }
}

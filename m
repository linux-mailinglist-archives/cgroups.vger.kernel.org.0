Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CCD7B7078
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 20:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbjJCSCF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 14:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbjJCSCE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 14:02:04 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C628E
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 11:01:59 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d8a000f6a51so1366847276.3
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696356118; x=1696960918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GJ9wBzWEYGYDTmAIvy592ie31KMhgP0u9XFlEA8QiQ=;
        b=jfUcD5jER1InUYI1lU2BYvfFOAQJL8Gj8CVqzj5zcHhfacJjoGqJ9XXLmVef5Qdog3
         GkkJEhawdPUcYFvyFTL36NRdjoi4IeI8bnMDMZS9jZbIvCCbvNfL/UQD9dSAMXlEnHBw
         UCjnrMawAyTApzYorblHLXcjj4VynMiBsLUC56kbSpLE2Oa3Ck+MN4KROKyslI5FKhl/
         4ut9gjHK5uX9wcHhsDuxNc7qvYRh2JMsvEL06mabqKmQNW53/jUkZdDRY4z65cmPAlmy
         ZTJjk0Pen6jh6XJNIKm6R0X3PlV+eq7CWyDviUrz1Kqdh7SdmU+IYQqSc5OlXoLEWxcZ
         NGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696356118; x=1696960918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GJ9wBzWEYGYDTmAIvy592ie31KMhgP0u9XFlEA8QiQ=;
        b=OOuSqgFY+Q3yc+xPQQTtuV6zQuOe3gYtuTDmdtTz1V8JHLy9qN3fmXoGgpJRB5CZIV
         FYVZztcQxtZUm4k5zeoI821FWjaZWMTZjRYPfXoC5gt43evBmhgIxj9b9OMNFU/QizPR
         6QFRlN5+7oeko6xS1mtEHPGntHE6UDzWhkir6ovDICvMqF6ME2AS3CXgrB932Ks3zVSO
         mc5kNKQo/S33bZMtVTQ5nzu75BrRH5lqTZOBTuRyfoaoL8VQG0/gMdQ34G1NAVdvzFON
         iUp3tHxw5BG2KSk+pmsWV/xYPr87GlwyHuFgv67pFyPTkpdYpR2aCWJRCLSBAxj3xVjO
         ICww==
X-Gm-Message-State: AOJu0YwlV0RkcA5fStNPSwvtUvnEOwQ+7D0w46Z5SxhT2ydPD3FW2jIV
        ES8n0EqQ4Hoa+Zs3rfXXAnNP3maZZkoXvda2hRLuaQ==
X-Google-Smtp-Source: AGHT+IE4P5btapf9VxAUnMTNhebfiipAdUsjbwVboVxNN96TyxptdUBPfM4DUcXamsgzQx7bVCQ26qRDXua3zJq3Y0U=
X-Received: by 2002:a25:bbcd:0:b0:d89:4d9b:c492 with SMTP id
 c13-20020a25bbcd000000b00d894d9bc492mr2758ybk.22.1696356118126; Tue, 03 Oct
 2023 11:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
In-Reply-To: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 3 Oct 2023 11:01:46 -0700
Message-ID: <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
Subject: Re: [Bug Report] EBUSY for cgroup rmdir after cgroup.procs empty
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 3, 2023 at 10:40=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> Hi all,
>
> Samsung reported an Android bug where over 1000 cgroups were left
> empty without being removed. These cgroups should have been removed
> after no processes were observed to be remaining in the cgroup by this
> code [1], which loops until cgroup.procs is empty and then attempts to
> rmdir the cgroup. That works most of the time, but occasionally the
> rmdir fails with EBUSY *after cgroup.procs is empty*, which seems
> wrong. No controllers are enabled in this cgroup v2 hierarchy; it's
> currently used only for freezer. I spoke with Suren about this, who
> recalled a similar problem and fix [2], but all the kernels I've
> tested contain this fix. I have been able to reproduce this on 5.10,
> 5.15, 6.1, and 6.3 on various hardware. I've written a reproducer
> (below) which typically hits the issue in under a minute.
>
> The trace events look like this when the problem occurs. I'm guessing
> the rmdir is attempted in that window between signal_deliver and
> cgroup_notify_populated =3D 0.
>
>            a.out-3786312 [120] ..... 629614.073808: task_newtask:
> pid=3D3786313 comm=3Da.out clone_flags=3D1200000 oom_score_adj=3D200
>            a.out-3786312 [120] ..... 629614.073832:
> sched_process_fork: comm=3Da.out pid=3D3786312 child_comm=3Da.out
> child_pid=3D3786313
>            a.out-3786313 [028] d..2. 629614.074712:
> cgroup_notify_populated: root=3D0 id=3D240416 level=3D1 path=3D/B val=3D1
>            a.out-3786313 [028] dN.1. 629614.074742:
> cgroup_attach_task: dst_root=3D0 dst_id=3D240416 dst_level=3D1 dst_path=
=3D/B
> pid=3D3786313 comm=3Da.out
>            a.out-3786312 [120] d..1. 629614.302764: signal_generate:
> sig=3D9 errno=3D0 code=3D0 comm=3Da.out pid=3D3786313 grp=3D1 res=3D0
>            <...>-3786313 [028] d..1. 629614.302789: signal_deliver:
> sig=3D9 errno=3D0 code=3D0 sa_handler=3D0 sa_flags=3D0
>            a.out-3786313 [028] ..... 629614.303007:
> sched_process_exit: comm=3Da.out pid=3D3786313 prio=3D120
>            a.out-3786313 [028] dN.2. 629614.303039:
> cgroup_notify_populated: root=3D0 id=3D240416 level=3D1 path=3D/B val=3D0
>            a.out-3786313 [028] dN.2. 629614.303057: signal_generate:
> sig=3D17 errno=3D0 code=3D2 comm=3Da.out pid=3D3786312 grp=3D1 res=3D0
>           <idle>-0       [120] ..s1. 629614.333591:
> sched_process_free: comm=3Da.out pid=3D3786313 prio=3D120
>
> However on Android we retry the rmdir for 2 seconds after cgroup.procs
> is empty and we're still occasionally hitting the failure. On my
> primary phone with 3 days of uptime I see a handful of cases, but the
> problem is orders of magnitude worse on Samsung's device.
>
> panther:/ $ find /sys/fs/cgroup/ -path "*/pid_*/cgroup.procs" -exec sh
> -c 'return $(wc -l $0 | cut -f1 -d" ")' {} \; -print
> /sys/fs/cgroup/uid_10133/pid_19665/cgroup.procs
> /sys/fs/cgroup/uid_10133/pid_19784/cgroup.procs
> /sys/fs/cgroup/uid_10133/pid_13124/cgroup.procs
> /sys/fs/cgroup/uid_10133/pid_15176/cgroup.procs
> /sys/fs/cgroup/uid_10274/pid_12322/cgroup.procs
> /sys/fs/cgroup/uid_1010120/pid_13631/cgroup.procs
> /sys/fs/cgroup/uid_10196/pid_27894/cgroup.procs
> /sys/fs/cgroup/uid_1010133/pid_16103/cgroup.procs
> /sys/fs/cgroup/uid_1010133/pid_29181/cgroup.procs
> /sys/fs/cgroup/uid_10129/pid_7940/cgroup.procs
> /sys/fs/cgroup/uid_10266/pid_11765/cgroup.procs
>
> Please LMK if there's any more info I can provide.
>
> [1] https://android.googlesource.com/platform/system/core/+/3483798fd9045=
f93e9095e5b09ffe4f59054c535/libprocessgroup/processgroup.cpp#522
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/kernel/cgroup/cgroup.c?id=3D9c974c77246460fa6a92c18554c3311c8c83c160
>
> // Run with: while sudo ./a.out; do :; done
> #include <signal.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <unistd.h>
>
> #include <atomic>
> #include <chrono>
> #include <cstdlib>
> #include <cstring>
> #include <filesystem>
> #include <fstream>
> #include <iostream>
> #include <thread>
> #include <vector>
>
> static bool cgroupHasProcs(std::filesystem::path cgroup_path, bool
> print =3D false) {
>     cgroup_path /=3D "cgroup.procs";
>     std::ifstream procs(cgroup_path);
>
>     std::string line;
>     bool populated =3D false;
>     while(std::getline(procs, line)) {
>         populated =3D true;
>         if (print)
>             std::cout << "Found " << line << " in " << cgroup_path << '\n=
';
>         else
>             break;
>     }
>     return populated;
> }
>
> static void SigChldHandler(int /*signal_number*/, siginfo_t* /*info*/,
> void* /*ucontext*/) {
>     pid_t pid;
>     int status;
>     while((pid =3D waitpid(-1, &status, WNOHANG)) > 0) {
>         if (WIFEXITED(status))
>             std::cout << "Process " << pid << " exited cleanly (" <<
> WEXITSTATUS(status) << ")\n";
>         else if (WIFSIGNALED(status))
>             std::cout << "Process " << pid << " exited due to signal "
> << WTERMSIG(status) << " (" << strsignal(WTERMSIG(status)) << ")\n";
>     }
> }
>
> static bool migrateToCgroup(std::filesystem::path cgroup_path) {
>     cgroup_path /=3D "cgroup.procs";
>     std::ofstream procs(cgroup_path);
>     procs << getpid();
>     procs.flush();
>     return static_cast<bool>(procs);
> }
>
> static std::atomic<bool> noProcs =3D false;
> static const std::filesystem::path CG_A_PATH =3D "/sys/fs/cgroup/A";
> static const std::filesystem::path CG_B_PATH =3D "/sys/fs/cgroup/B";
>
> static void readProcs() {
>     while (cgroupHasProcs(CG_B_PATH))
>         std::this_thread::sleep_for(std::chrono::milliseconds(5));
>     noProcs =3D true;
> }
>
> int main()
> {
>     struct sigaction sig_chld =3D {};
>     sig_chld.sa_sigaction =3D SigChldHandler;
>     sig_chld.sa_flags =3D SA_SIGINFO;
>
>     if (sigaction(SIGCHLD, &sig_chld, nullptr) < 0) {
>         std::cerr << "Error setting SIGCHLD handler: " <<
> std::strerror(errno) << std::endl;
>         return EXIT_FAILURE;
>     }
>
>     if (std::error_code ec;
> !std::filesystem::create_directory(CG_A_PATH, ec) && ec) {
>         std::cerr << "Error creating cgroups (Are you root?): " <<
> ec.message() << std::endl;
>         return EXIT_FAILURE;
>     }
>
>     if (std::error_code ec;
> !std::filesystem::create_directory(CG_B_PATH, ec) && ec) {
>         std::cerr << "Error creating cgroups (Are you root?): " <<
> ec.message() << std::endl;
>         return EXIT_FAILURE;
>     }
>
>     if (!migrateToCgroup(CG_A_PATH)) {
>         std::cerr << "Failed to migrate to " << CG_A_PATH << " (Are
> you root?): " << std::strerror(errno) << std::endl;
>         return EXIT_FAILURE;
>     }
>
>     const pid_t pid =3D fork();
>     if (pid =3D=3D -1) {
>         std::cerr << "Failed to fork child process: " <<
> std::strerror(errno) << std::endl;
>         return EXIT_FAILURE;
>     } else if (pid =3D=3D 0) {
>         migrateToCgroup(CG_B_PATH);
>         pause();
>         return EXIT_SUCCESS;
>     } else {
>         int ret =3D EXIT_SUCCESS;
>
>         std::vector<std::thread> threads(2*std::thread::hardware_concurre=
ncy());
>         for (std::thread &t : threads)
>             t =3D std::thread(readProcs);
>
>         std::this_thread::sleep_for(std::chrono::milliseconds(200));
>         kill(pid, SIGKILL);
>
>         while(!noProcs)
>             std::this_thread::sleep_for(std::chrono::milliseconds(1));
>
>         if(std::error_code ec; !std::filesystem::remove(CG_B_PATH, ec)) {
>             std::cerr << "Cannot remove " << CG_B_PATH << ": " <<
> ec.message() << std::endl;
>             ret =3D EXIT_FAILURE;
>         }
>
>         for(std::thread &t : threads)
>             if(t.joinable())
>                 t.join();
>         return ret;
>     }
> }

+ Zefan and Johannes who I missed

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E6420AC9
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfEPPM2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 11:12:28 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:34641 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfEPPM2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 11:12:28 -0400
Received: by mail-lf1-f46.google.com with SMTP id v18so2956834lfi.1;
        Thu, 16 May 2019 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gkh9T1Pf1TZ58K6YO+MkSR4mW1twy0xAjhb82p+QvNo=;
        b=tzgTxOhp4Ro1XDxk6wlZ8SQ9qZM1m2aK5iY6/mvOOY2a/9wPIt/Cjl5p8aS9fZH1dc
         JsBH+qBeT1NdZjvbxvEX2VAHFs/k4ekOvofwjgINNRoWu/Y5aC9UEagR98EjDEDbja+D
         kMujsHloSrfohM9QDxi3uA1Bc1xNj2Cjplh6PtaEmc3pGAfuB23KvM8/iNGe6dkbbBTj
         Up4AJQASg6+tGXe+IWyLQzJHR5llFuOJE8JEb//D003KiXc3QhbF9Mg6sshGAZLwW/vH
         W5+ZbqrdCLjiX+Nfhmqm9EWACFFxLEAqqTEFp1LtbJR+PjFE6SZwvRLQOGsHJFINVQxG
         UnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gkh9T1Pf1TZ58K6YO+MkSR4mW1twy0xAjhb82p+QvNo=;
        b=fqA7ppqVGX2QPBGT3IfW/aS8jkkjccWUMTGZRgwhUOrY3q/hLVhy82fWNsoBH9AM+8
         ja7iVI6+uhqBxqQnlJY+qsGe2Qd9VsCdKwx+kI1jPd51M9zOVbjaiGngNLc/ppJdWz94
         BDqPUEhHKOu9PXRJb7DLw0fW3choC+QmBJ1OezFcuPOJ8ZgI6DI2u4OCEQ4LTQjvRd0v
         IHfjbQfEVQv05iSPrboJkYv/rZ1h7etnyaU6mQKXF5m+uVBSE+nUki7QwUccb4WnaOQ2
         kS3HvDNbnvA2WY2Rwb+/EG9XkSeU6/RTWMtLF2rGvJSuiYgAfe9m7vklTqQu3A7w83L/
         DI9A==
X-Gm-Message-State: APjAAAX2qY2P4SM2lYcfvwya2PZ56feHXhz+Kgqnaikp71LIF1dlxGGP
        i7Uz3GPLzOnGU6TDBsTwrramVxijD8Hqa0wGh18=
X-Google-Smtp-Source: APXvYqyRJIHp/LGo0xfFDd+wsy5z6PCQHBlHqdMk6M+nKjU81x0ekM9bvQpPP20l3YTKL4CaMVFvF14QwWDuebomLz4=
X-Received: by 2002:a19:8:: with SMTP id 8mr24147995lfa.125.1558019545170;
 Thu, 16 May 2019 08:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190516103915.GB27421@krava>
In-Reply-To: <20190516103915.GB27421@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 May 2019 08:12:13 -0700
Message-ID: <CAADnVQ+3rBfhJ=L=ZECUNss8Vdsu5snacT8-SqSwnjGHbUna+g@mail.gmail.com>
Subject: Re: [RFC] cgroup gets release after long time
To:     Jiri Olsa <jolsa@redhat.com>, Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Daniel Mack <daniel@zonque.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Pavel Hrdina <phrdina@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 16, 2019 at 3:39 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> hi,
> Pavel reported an issue with bpf programs (attached to cgroup)
> not being released at the time when the cgroup is removed and
> are still visible in 'bpftool prog' list afterwards.

right. the workaround systemd and others are using today is
to detach bpf prog before rmdir of cgroup.
Roman has patches to do this automatically.

> It seems like this is not bpf specific, because I was able
> to cut the bpf code from his example and still see delayed
> release of cgroup.
>
> It happens only on cgroup2 fs (booted with systemd.unified_cgroup_hierarchy=1
> kernel command line option), please check the attached program
> below and following scenario:
>
> TERM 1
> # gcc -o test test.c
>
>                         TERM 2
>                         # cd /sys/kernel/debug/tracing
>                         # echo 1 > events/cgroup/cgroup_release/enable
>
> TERM 1 -> create and remove cgroup1
> # ./test group1
> qemu-system-x86_64: terminating on signal 15 from pid 1775 (./test)
>
>                         TERM 2
>                         # cat trace_pipe
>                         <nothing>
>
> TERM 1 -> create and remove cgroup2
> # ./test group2
> qemu-system-x86_64: terminating on signal 15 from pid 1783 (./test)
>
>                         TERM 2  - group1 being released
>                         # cat trace_pipe
>                         kworker/22:2-1135  [022] ....  2947.375526: cgroup_release: root=0 id=78 level=1 path=/group1
>
> TERM 1 -> create and remove cgroup3
> # ./test group3
> qemu-system-x86_64: terminating on signal 15 from pid 1798 (./test)
>
>                         TERM 2 - group2 being released
>                         # cat trace_pipe
>                         kworker/22:2-1135  [022] ....  2947.375526: cgroup_release: root=0 id=78 level=1 path=/group1
>                         kworker/22:0-1787  [022] ....  2961.501261: cgroup_release: root=0 id=78 level=1 path=/group2
>
>
> Looks like the previous cgroup release is triggered by creating
> another cgroup.  If I don't do anything the cgroup is released
> (tracepoint shows) in about 90 seconds.
>
> The cgroup_release tracepoint is triggered in css_release_work_fn,
> the same function where the cgroup_bpf_put is called, hence the
> delay in releasing of the bpf programs.
>
> Is this expected or somehow configurable? It's confusing seeing
> all the bpf programs from removed cgroups being around. In Pavel's
> setup it's about 100 of them.
>
> Note, I could reproduce this only with qemu-kvm being run in child
> process in the example below.
>
> thoughts? thanks,
> jirka
>
>
> ---
> #include <fcntl.h>
> #include <signal.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <unistd.h>
>
> #define CGROUP_PATH "/sys/fs/cgroup"
>
> int
> main(int argc, char **argv)
> {
>         pid_t pid = -1;
>         char path[1024];
>         int rc;
>
>         pid = fork();
>
>         if (pid == 0) {
>                 execl("/usr/bin/qemu-kvm",
>                       "/usr/bin/qemu-kvm",
>                       "-display", "none",
>                       NULL);
>                 fprintf(stderr, "failed to start qemu process\n");
>                 _exit(-1);
>         } else {
>                 int filefd = -1;
>                 char proc[1024];
>
>                 snprintf(path, 1024, "%s/%s", CGROUP_PATH, argv[1]);
>
>                 sleep(1);
>
>                 if (mkdir(path, 0755) < 0) {
>                         fprintf(stderr, "failed to create cgroup '%s'\n", path);
>                         return -1;
>                 }
>
>                 snprintf(proc, 1024, "%s/cgroup.procs", path);
>
>                 filefd = open(proc, O_WRONLY|O_TRUNC);
>                 if (filefd > 0) {
>                         dprintf(filefd, "%u", pid);
>                         close(filefd);
>                 }
>
>                 sleep(1);
>         }
>
>         if (pid > 0)
>                 kill(pid, SIGTERM);
>         do {
>                 rc = rmdir(path);
>         } while (rc != 0);
>
>         return 0;
> }

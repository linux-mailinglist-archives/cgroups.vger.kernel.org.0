Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE7203AD
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 12:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfEPKjT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 06:39:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfEPKjT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 16 May 2019 06:39:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B9B43179164;
        Thu, 16 May 2019 10:39:18 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 47273983F;
        Thu, 16 May 2019 10:39:16 +0000 (UTC)
Date:   Thu, 16 May 2019 12:39:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Daniel Mack <daniel@zonque.org>
Cc:     cgroups@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Pavel Hrdina <phrdina@redhat.com>
Subject: [RFC] cgroup gets release after long time
Message-ID: <20190516103915.GB27421@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 16 May 2019 10:39:18 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

hi,
Pavel reported an issue with bpf programs (attached to cgroup)
not being released at the time when the cgroup is removed and
are still visible in 'bpftool prog' list afterwards.

It seems like this is not bpf specific, because I was able
to cut the bpf code from his example and still see delayed
release of cgroup.

It happens only on cgroup2 fs (booted with systemd.unified_cgroup_hierarchy=1
kernel command line option), please check the attached program
below and following scenario:

TERM 1
# gcc -o test test.c

			TERM 2
			# cd /sys/kernel/debug/tracing
			# echo 1 > events/cgroup/cgroup_release/enable

TERM 1 -> create and remove cgroup1
# ./test group1
qemu-system-x86_64: terminating on signal 15 from pid 1775 (./test)

			TERM 2
			# cat trace_pipe
			<nothing>

TERM 1 -> create and remove cgroup2
# ./test group2
qemu-system-x86_64: terminating on signal 15 from pid 1783 (./test)

			TERM 2  - group1 being released
			# cat trace_pipe
			kworker/22:2-1135  [022] ....  2947.375526: cgroup_release: root=0 id=78 level=1 path=/group1

TERM 1 -> create and remove cgroup3
# ./test group3
qemu-system-x86_64: terminating on signal 15 from pid 1798 (./test)

			TERM 2 - group2 being released
			# cat trace_pipe
			kworker/22:2-1135  [022] ....  2947.375526: cgroup_release: root=0 id=78 level=1 path=/group1
			kworker/22:0-1787  [022] ....  2961.501261: cgroup_release: root=0 id=78 level=1 path=/group2


Looks like the previous cgroup release is triggered by creating
another cgroup.  If I don't do anything the cgroup is released
(tracepoint shows) in about 90 seconds.

The cgroup_release tracepoint is triggered in css_release_work_fn,
the same function where the cgroup_bpf_put is called, hence the
delay in releasing of the bpf programs.

Is this expected or somehow configurable? It's confusing seeing
all the bpf programs from removed cgroups being around. In Pavel's
setup it's about 100 of them.

Note, I could reproduce this only with qemu-kvm being run in child
process in the example below.

thoughts? thanks,
jirka


---
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define CGROUP_PATH "/sys/fs/cgroup"

int
main(int argc, char **argv)
{
	pid_t pid = -1;
	char path[1024];
	int rc;

	pid = fork();

	if (pid == 0) {
		execl("/usr/bin/qemu-kvm",
		      "/usr/bin/qemu-kvm",
		      "-display", "none",
		      NULL);
		fprintf(stderr, "failed to start qemu process\n");
		_exit(-1);
	} else {
		int filefd = -1;
		char proc[1024];

		snprintf(path, 1024, "%s/%s", CGROUP_PATH, argv[1]);

		sleep(1);

		if (mkdir(path, 0755) < 0) {
			fprintf(stderr, "failed to create cgroup '%s'\n", path);
			return -1;
		}

		snprintf(proc, 1024, "%s/cgroup.procs", path);

		filefd = open(proc, O_WRONLY|O_TRUNC);
		if (filefd > 0) {
			dprintf(filefd, "%u", pid);
			close(filefd);
		}

		sleep(1);
	}

	if (pid > 0)
		kill(pid, SIGTERM);
	do {
		rc = rmdir(path);
	} while (rc != 0);

	return 0;
}

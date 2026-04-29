Return-Path: <cgroups+bounces-15558-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIAtKvF08mkHrgEAu9opvQ
	(envelope-from <cgroups+bounces-15558-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 23:15:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA0049A7CB
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 23:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 734BD301F9F9
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 21:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A673AD520;
	Wed, 29 Apr 2026 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7LDmZZK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB63AD53B;
	Wed, 29 Apr 2026 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497304; cv=none; b=KAqHDk4fFthwHeT9wEX8ptutpL9iXdRvtJogLZqCATkb31mRmr10Fj4Y6nXJgJW+2mz4Qa12mtZ1blKlFK+I9fUU2NnSA5bGDhcLxZYMqa3kCcWczElPtKr+AtSPS6jnLVixTj6XdC+0AHm0K41bLdb3TryFCejkFdniLOUIHdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497304; c=relaxed/simple;
	bh=rcmPdl53ACE8rMRw190SHxJ9XhLeqWSrk5Jk80PuOME=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=K23zGZv3AS6zvh1ZoTH/ywQIDggflxXxWvTIwaTz5HpFWzZFkVfIXlUR1orQPV898wC3/KrQEYPBg/LajBQOYay/znBzOWwYGKdSubiSIr/YTkk6+/de6/2afRGBH2f+HhWlQL8zGNaKRHS7DNsrOmD4tx55rS6Ka59muhL7Ur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7LDmZZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B597C2BCB3;
	Wed, 29 Apr 2026 21:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777497304;
	bh=rcmPdl53ACE8rMRw190SHxJ9XhLeqWSrk5Jk80PuOME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K7LDmZZKB/I8+3uemoOBioOk2fv9IfeItIHL1S+ylIkxJy/SnyPErZFk1stxWDOOk
	 M+bKsj5h69A46uBM46q7sv7b1cCFIl4gJ63yVZk/G9QkByvgZ4V+uyggDGeBH7TqZc
	 8QUSd1No27ijOUcb19qQpMjS5qyyg/A6sB5rYO9pCJLLkGOvl0vKuqLmltRrf+LKmv
	 dEOZ5d4qMmNHbKubVHSucsy3og6kuBtoTh0x7r9rtS8p9hJmxbrG+1LOoJyGFipFdq
	 5cPGI0I3VaCE+rOU9ThP8E87o20J44WJeI6S/Hv11+uRK8T5Os4scEox2k0gZp8b0m
	 oZ6OZ+jdqnyLw==
Date: Wed, 29 Apr 2026 11:15:03 -1000
Message-ID: <35e0670adb4abeab13da2c321582af9f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Martin Pitt <martin@piware.de>
Cc: regressions@lists.linux.dev, cgroups@vger.kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [REGRESSION] 6.9.11: systemd hangs in cgroup_drain_dying during cleanup after podman operations
In-Reply-To: <f19d08689301f9cc0211e6273f833246@kernel.org>
References: <afHNg2VX2jy9bW7y@piware.de> <f19d08689301f9cc0211e6273f833246@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 0FA0049A7CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15558-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello,

I think I have the mechanism. The deadlock chains three things together.

1. Host PID 1 systemd is doing rmdir on user-1001.slice. rmdir enters
   cgroup_drain_dying() which waits until nr_populated_csets drops to
   0. The wait was added in 1b164b876c36 ("cgroup: Wait for dying
   tasks to leave on rmdir") so that rmdir doesn't succeed while
   dying tasks are still on the cgroup's css_set - the controller
   invariant being kept is "no tasks running in an offlined css"
   (see d245698d727a for where that got established on the dying-task
   side).

2. nr_populated_csets only drops when cgroup_task_dead() runs, which
   happens from finish_task_switch() after the dying task's
   do_task_dead() - i.e., after the very last context switch out of
   the task.

3. The container's PID 1 (whatever the entrypoint runs) is in
   do_exit() but parked in zap_pid_ns_processes' second wait loop:

       for (;;) {
           set_current_state(TASK_INTERRUPTIBLE);
           if (pid_ns->pid_allocated == init_pids)
               break;
           schedule();
       }

   pid_allocated stays > init_pids because at least one struct pid in
   the namespace is still in the idr - i.e., its task hasn't been
   reaped (release_task -> free_pid hasn't run).

The unreaped task is the host parent of one of the container helpers
- in the podman case, an exec session child whose host parent died
during the pkill cascade (conmon, the user manager, etc.) and got
re-parented to host PID 1. PID 1 was supposed to wait4() it as part of
normal reaping, but PID 1 is blocked in (1). Chicken-and-egg.

Why fuse-overlayfs masks it: with fuse-overlayfs the container
teardown finishes fast enough that the container's PID 1 reaches
do_task_dead before host PID 1 has had time to become the reaper of
the orphan. With kernel-overlayfs the teardown drags long enough that
the reparent + drain wait land in the iterator-hidden window
simultaneously, and once they do, the wedge is permanent.

I have a minimal C reproducer (~150 lines, no podman, no daemons,
runs as root) that hits the exact same code paths. The shape: A
unshares a pid namespace and forks B (PID 1 of the namespace) and C
(PID 2; A is C's host parent, NOT B). Both run in an inner cgroup. A
SIGKILLs both, then calls rmdir() without wait4()-ing C. C becomes a
zombie pinning pid_allocated; B parks in zap_pid_ns_processes; A's
rmdir parks in cgroup_drain_dying. Verified on stock 6.19.14 and
mainline 7.1-rc1+, also under virtme-ng. Source inlined at the bottom
of this mail.

For the fix, I'm still thinking. The rough direction is to split
cgroup rmdir: the user-visible side (directory unlink, cgroup.procs
disappears, the cgroup looks gone to userspace) completes as soon as
the iterator goes empty, while the backend teardown (kill_css /
css_offline) gets deferred until nr_populated_csets actually drops to
0. That keeps the "no running tasks in an offlined css" invariant
intact while letting the rmdir syscall return so host PID 1 can
resume reaping. Need to look at what shapes this cleanly without
breaking other cgroup core
expectations.

Thanks for the report.

--
tejun

----- min-repro.c -----

/*
 * Minimal reproducer for cgroup_drain_dying / zap_pid_ns_processes
 * deadlock. No podman, no daemons.
 *
 *   A — host process. Forks B (PID 1 of new pidns) and C (PID 2 of
 *       same pidns, but with A as host-side parent). After unshare,
 *       A's nsproxy->pid_ns_for_children is the level-1 namespace,
 *       so each subsequent fork lands a new task there.
 *   B — A's first child after unshare. PID 1 of new pidns.
 *   C — A's second child. PID 2 of same pidns, but parented to A
 *       at the host level (not to B). When C dies, SIGCHLD goes to
 *       A, NOT to B's zap_pid_ns_processes loop.
 *
 * Sequence:
 *   1. A puts itself in inner cgroup; B and C inherit on fork.
 *   2. A unshares CLONE_NEWPID, forks B and C.
 *   3. A moves out of inner so inner can be rmdir'd later.
 *   4. A SIGKILLs B and C. Both are killed.
 *   5. B's exit invokes zap_pid_ns_processes. zap walks idr, sees C
 *      (already SIGKILL'd), but C is NOT B's child — kernel_wait4(-1)
 *      returns -ECHILD immediately. zap reaches second loop:
 *      `pid_allocated > 1` because C's struct pid is still in idr
 *      (C is zombie awaiting A's wait4). zap sleeps.
 *   6. A calls rmdir(inner) WITHOUT calling wait4. cgroup_drain_dying
 *      sees nr_populated_csets > 0 (B still on cset->tasks; C may or
 *      may not be), iterator empty (B has PF_EXITING && live==0).
 *      Drain sleeps waiting for cgroup_task_dead, which only fires
 *      after B reaches do_task_dead, which it can't until zap returns,
 *      which it can't until pid_allocated drops to 1, which won't
 *      happen until A reaps C — but A is stuck in rmdir.
 *
 * Run as root.
 */

#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <sched.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

static void die(const char *msg)
{
	perror(msg);
	exit(1);
}

static void write_str(const char *path, const char *s)
{
	int fd = open(path, O_WRONLY);
	if (fd < 0)
		die(path);
	if (write(fd, s, strlen(s)) < 0)
		die(path);
	close(fd);
}

int main(int argc, char **argv)
{
	const char *cgroot = (argc > 1) ? argv[1] : "/sys/fs/cgroup/drain-min";
	char cginner[256], path[300], buf[32];

	snprintf(cginner, sizeof(cginner), "%s/inner", cgroot);

	mkdir(cgroot, 0755);
	if (mkdir(cginner, 0755) < 0 && errno != EEXIST)
		die("mkdir inner");

	snprintf(path, sizeof(path), "%s/cgroup.procs", cginner);
	snprintf(buf, sizeof(buf), "%d", getpid());
	write_str(path, buf);

	if (unshare(CLONE_NEWPID) < 0)
		die("unshare CLONE_NEWPID");

	pid_t b = fork();
	if (b < 0)
		die("fork B");
	if (b == 0) {
		/* B: PID 1 of new pidns */
		pause();
		_exit(0);
	}

	pid_t c = fork();
	if (c < 0)
		die("fork C");
	if (c == 0) {
		/* C: PID 2 of new pidns, host parent is A */
		pause();
		_exit(0);
	}

	snprintf(path, sizeof(path), "%s/cgroup.procs", cgroot);
	write_str(path, buf);

	fprintf(stderr, "A: B host pid=%d, C host pid=%d\n", b, c);

	/* Briefly verify pidns membership */
	for (int i = 0; i < 2; i++) {
		pid_t p = (i == 0) ? b : c;
		char dpath[64], dbuf[256];
		snprintf(dpath, sizeof(dpath), "/proc/%d/status", p);
		int fd = open(dpath, O_RDONLY);
		if (fd >= 0) {
			ssize_t n = read(fd, dbuf, sizeof(dbuf) - 1);
			close(fd);
			if (n > 0) {
				dbuf[n] = 0;
				char *l = strstr(dbuf, "NSpid:");
				if (l) {
					char *e = strchr(l, '\n');
					if (e) *e = 0;
					fprintf(stderr, "  pid=%d %s\n", p, l);
				}
			}
		}
	}

	/* SIGKILL both. After this, B starts zap_pid_ns_processes; C
	 * dies and becomes a zombie waiting for A's wait4. */
	kill(b, SIGKILL);
	kill(c, SIGKILL);

	usleep(500000);

	fprintf(stderr, "A: rmdir(%s) — wedges if bug present "
		"(deliberately NOT wait4-ing C)\n", cginner);

	int rc = rmdir(cginner);
	int saved_errno = errno;
	fprintf(stderr, "A: rmdir returned %d (errno=%d %s)\n", rc,
		saved_errno, strerror(saved_errno));

	/* For cleanup if rmdir succeeded */
	waitpid(c, NULL, WNOHANG);
	waitpid(b, NULL, WNOHANG);
	rmdir(cgroot);
	return rc;
}
----- end min-repro.c -----


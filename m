Return-Path: <cgroups+bounces-11651-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35BEC3D8AA
	for <lists+cgroups@lfdr.de>; Thu, 06 Nov 2025 23:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FB41884D96
	for <lists+cgroups@lfdr.de>; Thu,  6 Nov 2025 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C830AAA9;
	Thu,  6 Nov 2025 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ9YhUyH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6752773FE;
	Thu,  6 Nov 2025 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762466867; cv=none; b=EVHbzpeC9Pe9Jv6lzQMfDF63giA1SeNyPU1BthPQTngN29kiWnx3gefOZVHR/9s/3xruQLM4xL3bsrlM+PuW5FnZxQDMVFGW+0P4zOZut1W0B1MK0N5ImkdIy1EzWjI7EsFHxIheblQBMkMHONOJumQi59PbT07qt9tx13q6ExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762466867; c=relaxed/simple;
	bh=gRPsRjzM6vLUG6pr47XDgUugAM8FFr90lWaQXYl15PE=;
	h=Date:Message-ID:From:To:Cc:Subject; b=UpIPEUTUIeHP4c4VtExfe8O5R8cCaN0R6olyX4oU+ZwzMpptW4X/DlAElIJg0zmHzfInfAG2I9qSyOBxAtlmNcjmIjTZEdhC5npov7xIqXXp1bTjdH3vPcZtlCOsMyOQ00cY4dymTfpDCLs8adA663ljHKvCY1fzzSjoyAVs6II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ9YhUyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75275C4CEF7;
	Thu,  6 Nov 2025 22:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762466866;
	bh=gRPsRjzM6vLUG6pr47XDgUugAM8FFr90lWaQXYl15PE=;
	h=Date:From:To:Cc:Subject:From;
	b=jJ9YhUyHowqwxIsRwvnciX/DGVLhHYPtX1eQ4G6f5olzUr3XqV8EyxJoH+yUv8cHv
	 N5e210zunKliB7anu7wiH/kB7bYqxuvMQEd8XVfHbbidkGz5L24fUY4a1obJKFfXNq
	 P6MscJKe2gbi/DpLNZ+qrFx43jNgiSZuZNS7sCCxsZj6Rlgtq6sPp38F4mjkt1A/04
	 UqBvDSDaz3Y3a9d4P8D9jI5kd3k6OJCnT0dA9/DVFxHcpwBRcF7rK+YTp2IB6m20Uu
	 IBKatSGf6tODyCico+cktXBijptqJeUXx03BMx3bdUm4NgKcAvWfiVsCo+1xagupjv
	 vpivCAm797xgw==
Date: Thu, 06 Nov 2025 12:07:45 -1000
Message-ID: <2016aece61b4da7ad86c6eca2dbcfd16@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Koutný <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH cgroup/for-6.18-fixes] cgroup: Skip showing PID 0 in cgroup.procs and cgroup.threads
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

css_task_iter_next() pins and returns a task, but the task can do whatever
between that and cgroup_procs_show() being called, including dying and
losing its PID. When that happens, task_pid_vnr() returns 0.

d245698d727a ("cgroup: Defer task cgroup unlink until after the task is
done switching out") makes this more likely as tasks now stay iterable with
css_task_iter_next() until the last schedule is complete, which can be
after the task has lost its PID.

Showing "0" in cgroup.procs or cgroup.threads is confusing and can lead to
surprising outcomes. For example, if a user tries to kill PID 0, it kills
all processes in the current process group.

Skip entries with PID 0 by returning SEQ_SKIP.

Cc: stable@vger.kernel.org
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/cgroup.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5287,6 +5287,17 @@ static void *cgroup_procs_start(struct s

 static int cgroup_procs_show(struct seq_file *s, void *v)
 {
+	pid_t pid = task_pid_vnr(v);
+
+	/*
+	 * css_task_iter_next() could have visited a task which has already lost
+	 * its PID but is not dead yet or the task could have been unhashed
+	 * since css_task_iter_next(). In such cases, $pid would be 0 here.
+	 * Don't confuse userspace with it.
+	 */
+	if (unlikely(!pid))
+		return SEQ_SKIP;
+
 	seq_printf(s, "%d\n", task_pid_vnr(v));
 	return 0;
 }


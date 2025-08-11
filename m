Return-Path: <cgroups+bounces-9072-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF3EB20D46
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 17:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906CD1620C1
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A1E2DEA65;
	Mon, 11 Aug 2025 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WeuM+lO7"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8831C4EB38;
	Mon, 11 Aug 2025 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925277; cv=none; b=lEHlIsZGapRYVlOsAMqAxEQFLuthHkHo77at7GyYUQf2iERnE7AsIBZBqGFSsdylyn3xYuqvD/pRrmm2V3+GLEFwlN4ZjLQmvPb7b7yKh38MmSXU6ebVge8dVERYLgK5aubkMYAldDltQ1wX7x/A4k9HSjOBRFeRtW0hZAtFz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925277; c=relaxed/simple;
	bh=aTsbw2smJ5VIymi9ayK2LE0nzymwzY8VncqZhJ3BXqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aqG551zUfqWNDTQQqDd1J/FxOE6DAgxcmsyVn6vnYTgxIeNdsPs2ohQeoo09WWPC9VB4hILsxCeoT9gXjwLmrZCsmjenGMgilWO0vjOT+Syqy1l4VsoxTawvzMl/iNqlMGVOZRT6qyvdIkMKTGXYLfsxYiVinERtlpwBA4s6GNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WeuM+lO7; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aT
	sbw2smJ5VIymi9ayK2LE0nzymwzY8VncqZhJ3BXqI=; b=WeuM+lO7vqO8Cpljb+
	8ozhdmhynoSpVq9NUOLBe0UyWUQYuQZztKLlFHwlQKwnvfNFGEeoGLhYLERdgrlG
	g/5O1D3FFNrrOt+MjJ+8W4DGhVYP36mzV70pumCa3D9To5fooESLnsWSCb1nmANH
	yAA9ux82qbiR3L2KvTPVNi/VY=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDn5+2MCJposuAOAw--.27979S2;
	Mon, 11 Aug 2025 23:13:17 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com,
	longman@redhat.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/cgroup: Lock optimize for cgroup cpu throttle
Date: Mon, 11 Aug 2025 23:13:16 +0800
Message-Id: <20250811151316.838707-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn5+2MCJposuAOAw--.27979S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW8Kr4xGw4UKFWDJFyDAwb_yoW8XF1xp3
	90vF43trs5ZF1IqF109w4ftay8Z395J3y5G3Z8GrW5Cr1Yq3WIyrsYgayY9an8Gws3ua1j
	vr1jq3ZrGayYvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8xhLUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbioxWmCmiaBhczAwAAsJ

On Mon, 2025-08-11 at 16:36 +0800, Sebastian wrote:

> What about using task_work_add() and throttling the task on its way to
> userland? The callback will be invoked without any locks held.


Dear Sebastian,

I believe what you mentioned is related to the same issue that Valentin
brought up later, which is the current solution of "delaying CPU throttling
through the task_work mechanism until returning to user mode."
My colleagues and I indeed noticed this from the beginning. However, on our
6.1.134 RT-Linux system, we have tried new versions of this solution one by
one, but they have all failed during basic script tests, so none have reached
the stage of being used in our project. I see that this modification has been
promoted in the community for more than two years, yet it remains in a state
that doesn't work well (on our 6.1.134 RT-Linux system). I wonder if the
changes require too many considerations or if this modification simply isn't
suitable for running on RT-Linux. Our project cannot afford to wait, and
there are many performance issues in RT-Linux.
Therefore, I focused on making minimal changes to a complex and stable
scheduling system (at least not altering the complex management logic of
nr_running and related logic) and instead worked on the code of lock module
and the logic of adjusting priorities, which are relatively easier to
understand and modify.
As a result, I implemented a patch that runs stably on 6.1.134 RT-Linux and
meets the demands.


Thanks
Xin Zhao



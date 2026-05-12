Return-Path: <cgroups+bounces-15813-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMBLI8TGAmp7wQEAu9opvQ
	(envelope-from <cgroups+bounces-15813-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:20:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A0251ADB1
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 08:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4E3E301BA7E
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 06:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270224C9565;
	Tue, 12 May 2026 06:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="KABNQ6Np"
X-Original-To: cgroups@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2005l-snip4-11.eps.apple.com [57.103.89.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD04657C8
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566843; cv=none; b=GC8XDgCS4YDmljtiNmeBsJzwXq5AFjyNFERbzRSnFwzAhmncjEu892Kbfath0XqMNMcz2ReVnAY6r47AS2IqW8UP+Bd2qZzPgA1VOXG2mnhdziNA266Ba8pMKnsJR6ZvtPtKLi7I9SC4MO2tm2279+dYusq5tQZjA/JXQCrBVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566843; c=relaxed/simple;
	bh=ci4WjXNg/xa1ziA/Xx2xCDkI467Kw3pR1atl99yWTyk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GOi1foJgULJ2W0TCJjK/PEI/Tr3U6AKlRpIfFzVTJcTnGpcfUbKArsyWQr0UqFMRmYbGXxyaupEwfDyDydsWLsrPKUPVFb+6jac0zSj2JpDxWVYAh2+XNBw+lDpa0xP+vkvWYv0Om1J4u8URQbKbU7sBc9Q5kr0ZjiQ2B/NBbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=KABNQ6Np; arc=none smtp.client-ip=57.103.89.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPS id 166D71800100;
	Tue, 12 May 2026 06:20:10 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJB0MFXwReC0sKQw5eEhVdRV8YXApUH1oNQC1eCF4fTBwdDlgGEhZdRV8YXApUH1oNQC1eCF4fTBwdDlgGEgJaRQFbFwNXHFZFXBhDCV0FVxwdDl5FWxNVF0YJGQhdHRkIRx8KMANCDlYDQwdFAC0ZHFdQXgheH0wcHQ5YBhIdUBwOUQVbAEYJTQJfGhtBGWYRXh1FRkRBFEgeX1VcVEEJHlcLVg8HME0dXQ5SBUZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778566814; x=1781158814; bh=5IsHEhVfaI6bVZ7tmEfuZb+RHPYOBLYDdITx1t1qzII=; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme; b=KABNQ6NpOhMCpupldAmoU110TcV3li+jHP2lIwPbGjiIPnoQV00fEse37jYGRF+aW2bCcjQAjH0sJHgOmpZK2R3sgKX/mE5LL8ep3HnYXBJb5wxZcunfPC+nvZwCFMcHuRxglZgM41/JVk7eTolP0qh1wFLRD/SQLkSmoA9sJ5vXuQcVMV/qfMgVM0dDHMhPJhXzYVRBznpvqb9BNnua2XFhfZNFPOyhIEtdon2ltwwYxuilqoSm2rBYi7Yq0N/keQg65+Svxv31e4zR+dr+PNmX3yAS6VR/qLm1GtIs+37vi2zhk0okey8KxS/Kk8W2rRMyZh3kFhi30JXvOop/tA==
Received: from [127.0.0.1] (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-4 (Postfix) with ESMTPSA id B82D61800103;
	Tue, 12 May 2026 06:20:02 +0000 (UTC)
From: Luka Bai <lukafocus@icloud.com>
Subject: [PATCH 0/6] psi: slightly improve performance of psi
Date: Tue, 12 May 2026 14:19:56 +0800
Message-Id: <20260512-psi_impr-v1-0-2b7f10fdfad5@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBAFf4Xs2ZqWClJO/ochBssia0Jp2ko0p
 P9ui1ePk8ybt4FHR+ihLTZwuJKnxSQQhwL01JsHMhoSQ8nLmleiZNbTjWbr2FidZC+UGqUaIOn
 W4UjvPXXtfuxf9yfqkPfZmMiHxX32r1Vk7092FYwzcVY11lJVTdNfAhqNJhz1MkMXY/wCJUdiw
 LQAAAA=
X-Change-ID: 20260512-psi_impr-f543a199f39d
To: linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Peter Ziljstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Kees Cook <kees@kernel.org>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 Luka Bai <lukabai@tencent.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778566802; l=3066;
 i=lukabai@tencent.com; s=20260501; h=from:subject:message-id;
 bh=ci4WjXNg/xa1ziA/Xx2xCDkI467Kw3pR1atl99yWTyk=;
 b=4mOUTIgTAH/zXfT/d+n0G3x2kWmcSCfHUmXs/JwXmnUvayovFnyDuk393TPIzJTzzLG1qOAmT
 iWNgeKkd7CDCUKnYdahnZJq1fW4EyYLEkrLQArH9XBLyQV0dAe+brl7
X-Developer-Key: i=lukabai@tencent.com; a=ed25519;
 pk=KeaVteSWd00GIAjFyWZnuFsKAKixjga1ZkLMcI66nPM=
X-Authority-Info-Out: v=2.4 cv=RM6+3oi+ c=1 sm=1 tr=0 ts=6a02c69c
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=GvQkQWPkAAAA:8 a=LkPULGn0saSIAVzmwMwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2MCBTYWx0ZWRfX2OG75N2wOc4y
 mc7l5eN1znKUyodZ6gefFtOIGmR/xasVao9Dm6cA+1XFc2WXRqnaHtMSoTvfTEolU3f+LYILzcL
 gHYlxtU7swPdIIZtlUhOSzn0ar59VnrPg8pjaISkZ/LgG1y0gA+ajDvjVjV4lcNM63X/dT9x8yB
 7rvN/Y/XeWxYCtUkaPXgmQehWHUMevkkgR2AuuF+zd3kQM7wD+zyZP6/Vfk/6o27pD0xyzeS47Y
 StokzTkWrOvXRxzR4gto9IVvzxJ47e0wk5U+1gzAWT2b8PIRAad4iKRQiVhYTQPW109K96CgNqi
 mCxsrqmU0Qnpby798R9y+iyAuyZLHPDO2E8EZGlMdidqAkbchIjCW7rEyy8mXA=
X-Proofpoint-ORIG-GUID: TMG7ZIqH4sJCib-B3Djn0w9JZzBlrPNS
X-Proofpoint-GUID: TMG7ZIqH4sJCib-B3Djn0w9JZzBlrPNS
X-Rspamd-Queue-Id: F0A0251ADB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15813-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukafocus@icloud.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[icloud.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,icloud.com:dkim,tencent.com:email,tencent.com:mid]
X-Rspamd-Action: no action

PSI is useful for resource pressure monitoring. But the callbacks are
distributed among all the common calling paths, some of which are quite
performance critical. The hottest callback like psi_group_change is
called by both psi_task_switch and psi_task_change, which are parts of
task_switch, enqueue, dequeue. So the cpu usage of psi is quite
important.

We initialized a common hackbench test using the following command:

perf record --kernel-callchains -a -g hackbench -s 512 -P -g 10 -f 30 \
        -l 1000 --pipe

In a machine setup with 8 cores, 16GB with two numa node(each node 8GB),
we saw a cpu usage of 4.3% for psi using the flame graph of the perf
data, which can make some observable influence to the actual workloads.

In this patchset, we did some improvement for the performance of hot
path, which slightly improves the performance for the psi. With a same
setup of 8 cores + 16GB, the cpu usage of psi becomes 3.4%, which has
a 20% improvement. In the future patches we may try to do more
adjustment to go further (Like add switches for different types of PSI
resources maybe).

Patch Details:
========
* Patch 1 moves the judgement of cpu_curr(cpu)->in_memstall from
  psi_group_change outside to eliminate some repeated memory access.
* Patch 2 adds a bit variable need_psi to help judge whether we need
  to do psi accouting for the cgroup. we move it and psi_flags, which
  currently only has 5 bits, close to the bitfield variable in_memstall
  together. This way they will be cacheline aligned together.
* Patch 3 adds a prefetch logic before actually accessing the parent
  cgroups, since the parent cgroups will always be accessed in the
  following step.
* Patch 4 only calls record_times when the state actually changes to
  save some uncessary accesses.
* Patch 5 adds psi_group for the root cgroup to remove the uncessary
  if condition.
* Patch 6 uses printk_deferred_once to replace the psi_bug variable
  and moves tasks[NR_RUNNING] which is most likely to happen ahead
  in the if condition.

Thanks for reading. Comments and suggestions are very welcome!

Signed-off-by: Luka Bai <lukabai@tencent.com>
---
Luka Bai (6):
      psi: move curr_in_memstall out of psi_group_change
      psi: reorganize the psi members for cacheline benifits
      psi: use prefetch to preread the parent groupc
      psi: do not call record_times when the state is not changed
      psi: add psi group for the root cgroup
      psi: remove psi_bug and moves checking of NR_RUNNING ahead.

 include/linux/psi.h       |  2 +-
 include/linux/psi_types.h | 20 +------------
 include/linux/sched.h     | 29 ++++++++++++++++---
 kernel/cgroup/cgroup.c    |  3 ++
 kernel/fork.c             | 10 +++++++
 kernel/sched/psi.c        | 71 ++++++++++++++++++++++++++++++-----------------
 6 files changed, 85 insertions(+), 50 deletions(-)
---
base-commit: 972c53e0ec3abfc6f5fe2cb503640710fb23cf95
change-id: 20260512-psi_impr-f543a199f39d

Best regards,
--  
Luka Bai <lukabai@tencent.com>



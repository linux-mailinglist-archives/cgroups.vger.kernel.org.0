Return-Path: <cgroups+bounces-16126-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OZIFBecDWoS0AUAu9opvQ
	(envelope-from <cgroups+bounces-16126-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 13:33:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B846358C916
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 13:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED87300AB29
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2261F3F54C3;
	Wed, 20 May 2026 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2JJsoBD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6173F4DDA;
	Wed, 20 May 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276052; cv=none; b=r7Lm8Q1/s08acCroip7rFshfV3a++czqyKg9ZDUCC9Ni3ZN+5XqIjj9mTMUy7jwVbM7lQMQeBNYMjPdqJ7Qn2kfPD44wDCadv4N7uohzJbPnTUEuMIwbr28vaZeUGZTSqW8wOojDMekcEN2hRGNA0j543QYopf4eZngL7tm1vB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276052; c=relaxed/simple;
	bh=+1K3xzKc9yYNe28p++pqbq2IcZ6bVjyp7z8BcBLV8Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+ytT/KLYc2beewvWHrECRzfcFBtmEKIPjXabkuYwztqgH5gBvT55/jOnURhdjr1NxK0ViCkv9ykVOsSS+0VmKYNs7t6xFjEbneWpcZ95Iaw7lIPBSGz4D94vSo1kz1jHD615ITz+1ZmoqdgcVQJIgwFVJ7DdvrZYKsRxcdadwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2JJsoBD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C9F1F00896;
	Wed, 20 May 2026 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779276050;
	bh=U18dZuuZa3R2JvYSOS7+K27vfZvR7silqEUP8iBbIpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a2JJsoBDzIVKu4SAcpaAxi/B+fbFDN4uta0YbAsSMafNbSrkIffk6MRU34IOdYGoG
	 Pj11unGh9O1efCz79r9prKG7NCUTQH6B21T32EbDjU650KQyDVFa3kpm4RQJOndf6s
	 YIoFW2uy2Wa7g6PeRbGBULlicz4UHFpEQNi8SpOLOVGBA7Bm9hkQ4t9CkjOlNpnQz+
	 8pUkcWoBph8e5YoPYhTWQ2qHvF5hjEHVL7tXoQSf5fD+k5MF5ZNbKg6Nugw1o7VlMl
	 jRxsjYu++6ssa5LecOCZme2EdE0FI1Iwa83XyGaFd0sa5h9rRocqRtn4vZPh6hb8Bk
	 RgeYZCXcCXTtA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chen Wandun <chenwandun@lixiang.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-5.10] cgroup/cpuset: move PF_EXITING check before __GFP_HARDWALL in cpuset_current_node_allowed()
Date: Wed, 20 May 2026 07:19:18 -0400
Message-ID: <20260520111944.3424570-46-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520111944.3424570-1-sashal@kernel.org>
References: <20260520111944.3424570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0.9
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16126-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lixiang.com:email]
X-Rspamd-Queue-Id: B846358C916
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chen Wandun <chenwandun@lixiang.com>

[ Upstream commit dde2f938d02f2c740d49bb5113dea941f941026a ]

Since prepare_alloc_pages() unconditionally adds __GFP_HARDWALL for the
fast path when cpusets are enabled, the __GFP_HARDWALL check in
cpuset_current_node_allowed() causes the PF_EXITING escape path to be
skipped on the first allocation attempt.  This makes it unreachable in
the common case, so dying tasks can get stuck in direct reclaim or even
trigger OOM while trying to exit, despite being allowed to allocate from
any node.

Move the PF_EXITING check before __GFP_HARDWALL so that dying tasks
can allocate memory from any node to exit quickly, even when cpusets
are enabled.

Also update the function comment to reflect the actual behavior of
prepare_alloc_pages() and the corrected check ordering.

Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
Acked-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Phase 1: Commit Message Forensics
Step 1.1 Record: Subsystem is `cgroup/cpuset`; action verb is “move”;
claimed intent is to move the `PF_EXITING` allowance before the
`__GFP_HARDWALL` rejection in `cpuset_current_node_allowed()` so exiting
tasks can allocate outside their cpuset and finish exiting.

Step 1.2 Record: Tags present in `dde2f938d02f2`:
- `Signed-off-by: Chen Wandun <chenwandun@lixiang.com>`
- `Acked-by: Michal Koutný <mkoutny@suse.com>`
- `Acked-by: Waiman Long <longman@redhat.com>`
- `Signed-off-by: Tejun Heo <tj@kernel.org>`
No `Fixes:`, `Reported-by:`, `Tested-by:`, `Reviewed-by:`, `Link:`, or
`Cc: stable@vger.kernel.org` tags in the committed message.

Step 1.3 Record: The body describes a real liveness/allocation bug:
`prepare_alloc_pages()` sets `__GFP_HARDWALL` when cpusets are enabled,
so the existing hardwall rejection returns `false` before the later
`PF_EXITING` escape is reached. The described failure mode is dying
tasks getting stuck in direct reclaim or triggering OOM while trying to
exit.

Step 1.4 Record: This is a hidden bug fix despite the subject saying
“move”: it restores an existing intended exception for `PF_EXITING`
tasks that was unreachable for hardwall allocations.

## Phase 2: Diff Analysis
Step 2.1 Record: One file changed, `kernel/cgroup/cpuset.c`, 8
insertions and 6 deletions. The only functional change is inside
`cpuset_current_node_allowed()`. Scope is single-file, surgical.

Step 2.2 Record: Before, for a node outside `current->mems_allowed`, the
code checked `tsk_is_oom_victim()`, then rejected `__GFP_HARDWALL`, then
checked `PF_EXITING`. After, `PF_EXITING` is checked before
`__GFP_HARDWALL`. Comment updates match the behavior change.

Step 2.3 Record: Bug category is logic/liveness correctness in memory
allocation policy. The broken mechanism was an intended “dying task may
allocate anywhere” path being shadowed by an earlier hardwall return.

Step 2.4 Record: The fix is obviously correct by inspection: it only
reorders two independent boolean exits, introduces no locking, no data
structure changes, and no API changes. Regression risk is very low; the
only behavioral relaxation is for tasks already marked `PF_EXITING`.

## Phase 3: Git History Investigation
Step 3.1 Record: `git blame` shows the hardwall rejection is old cpuset
logic from `9bf2229f881767` in 2005; the `PF_EXITING` allowance was
added by `5563e77078d8` in 2005; the OOM-victim allowance was added by
`c596d9f320aa` in 2007. `prepare_alloc_pages()` currently sets
`*alloc_gfp |= __GFP_HARDWALL`; that structure was introduced by
`9cd7555875bb` in 2017, and checked tags show equivalent hardwall first-
attempt behavior exists at least back to `v4.4`.

Step 3.2 Record: No `Fixes:` tag, so there was no specific target commit
to follow.

Step 3.3 Record: Recent `kernel/cgroup/cpuset.c` history shows normal
cpuset churn and a 2025 rename from `cpuset_node_allowed()` to
`cpuset_current_node_allowed()` in `8adce0857769`. That rename is a
backport context issue for older trees, not a semantic dependency.

Step 3.4 Record: `git log --author='Chen Wandun' -10 linux-next/master
-- kernel/cgroup/cpuset.c mm/page_alloc.c` found this commit and one
unrelated page allocator simplification. The author is not shown as the
subsystem maintainer in the checked history; the patch was acked/applied
by cgroup maintainers/reviewers.

Step 3.5 Record: No functional prerequisite found. Older stable branches
may need the function-name/context adjusted because the function is
named `cpuset_node_allowed()` or `__cpuset_node_allowed()` there.

## Phase 4: Mailing List And External Research
Step 4.1 Record: `b4 dig -c dde2f938d02f2` found the original
submission:
`https://patch.msgid.link/20260507105434.3266234-1-
chenwandun@lixiang.com`
`b4 dig -a` found only v1.

Step 4.2 Record: `b4 dig -w` showed the patch was sent to Chen Wandun,
Waiman Long, Chen Ridong, Tejun Heo, Johannes Weiner, Michal Koutný,
`cgroups@vger.kernel.org`, and `linux-kernel@vger.kernel.org`.

Step 4.3 Record: No separate bug-report link or `Reported-by:` tag. The
thread includes Chen Ridong asking how it was found; the author replied
it was found while reviewing cpuset node-allowed logic during
investigation of a memory allocation issue, not as that investigation’s
root cause.

Step 4.4 Record: Thread review: Michal Koutný acked and said it “makes
sense,” while noting OOM could eventually select the task and bypass
hardwall, so this expedites rather than necessarily being the only
unblock. Waiman Long acked. Chen Ridong gave `Reviewed-by` in the
thread. Tejun Heo applied it to `cgroup/for-7.1-fixes`. No NAKs or
objections found.

Step 4.5 Record: WebFetch for lore/stable was blocked by Anubis;
WebSearch found no useful stable-specific objection or discussion. This
is an external-search limitation.

## Phase 5: Code Semantic Analysis
Step 5.1 Record: Modified function: `cpuset_current_node_allowed()`.

Step 5.2 Record: Callers verified: `__cpuset_zone_allowed()` wraps it in
`include/linux/cpuset.h`; `get_page_from_freelist()` and reclaim retry
logic call `__cpuset_zone_allowed()` when cpusets are enabled and
`ALLOC_CPUSET` is set.

Step 5.3 Record: Key callees in `cpuset_current_node_allowed()` are
`in_interrupt()`, `node_isset()`, `tsk_is_oom_victim()`,
`nearest_hardwall_ancestor()`, `task_cs()`, and `spin_lock_irqsave()`
around ancestor scanning.

Step 5.4 Record: Reachability verified through the allocator:
`prepare_alloc_pages()` sets `__GFP_HARDWALL`;
`__alloc_frozen_pages_noprof()` calls `prepare_alloc_pages()` then
`get_page_from_freelist()`. `PF_EXITING` is set in `exit_signals()`
during `do_exit()` before later exit cleanup. I did not verify a
specific later cleanup function that always allocates; the allocator
path and `PF_EXITING` timing are verified.

Step 5.5 Record: Similar pattern found: `c596d9f320aa` allowed OOM-
killed tasks to allocate anywhere to avoid exit/deadlock problems, and
current `show_mem()` treats `PF_EXITING` as an exception allowed outside
node filters.

## Phase 6: Stable Tree Analysis
Step 6.1 Record: Checked `v4.4`, `v4.9`, `v4.14`, `v4.19`, `v5.4`,
`v5.10`, `v5.15`, `v6.1`, `v6.6`, `v6.12`, and `v7.0`; all checked trees
have the old ordering where `__GFP_HARDWALL` returns before
`PF_EXITING`, and allocator code setting/using `__GFP_HARDWALL`.

Step 6.2 Record: `git apply --check` of the upstream patch succeeds on
the current `v7.0.9` checkout with line offsets. Older branches need at
most minor context/name adjustment because the function name differs,
but the relevant body is present.

Step 6.3 Record: No separate alternative technical fix for this bug was
found by subject/bug-text searches. I did not use any branch-
selection/pipeline presence as decision evidence.

## Phase 7: Subsystem Context
Step 7.1 Record: Subsystem is cgroup/cpuset with page allocator
interaction. Criticality is important to core: it affects memory
allocation behavior for systems using cpusets, especially NUMA/cgroup-
managed systems.

Step 7.2 Record: The cpuset file has active recent development, but the
affected allocation policy logic is mature and present across many
stable-era tags.

## Phase 8: Impact And Risk
Step 8.1 Record: Affected users are systems with cpusets enabled where
exiting tasks allocate while outside their allowed memory nodes or while
their allowed nodes are depleted. This is config/setup-specific, not
universal.

Step 8.2 Record: Trigger requires `PF_EXITING`, cpusets enabled, and an
allocation path where hardwall cpuset filtering checks a node outside
`current->mems_allowed`. Exiting is user-triggerable, but cpuset
placement usually depends on administrator/container-manager
configuration.

Step 8.3 Record: Failure mode is high severity: direct reclaim stalls
and possible OOM while a task is trying to exit. The thread reviewer
caveat means this may expedite exit in some OOM cases rather than prove
every instance is permanently stuck, but the liveness benefit is real.

Step 8.4 Record: Benefit is high for affected systems; risk is very low
because the change is a two-line ordering fix plus comments and only
broadens allocation eligibility for dying tasks.

## Phase 9: Final Synthesis
Step 9.1 Record:
Evidence for backporting: fixes a real allocation/liveness bug; small
one-function change; no API or feature addition; acknowledged by cgroup
reviewers; present in many stable-era tags; clean on `v7.0`; older trees
have the same logic.
Evidence against: no explicit `Fixes:`/`Cc: stable`/`Reported-
by`/`Tested-by`; no concrete reproducer in commit or thread; older trees
may need minor context adjustment.
Unresolved: I could not use WebFetch on lore/stable due Anubis; I did
not verify behavior earlier than `v4.4`; I did not run runtime tests.

Step 9.2 Stable rules:
1. Obviously correct and tested? Obviously correct by inspection; no
   explicit test tag.
2. Fixes a real bug? Yes, unreachable `PF_EXITING` allocation escape
   under hardwall cpuset filtering.
3. Important issue? Yes, can cause direct reclaim stalls or OOM during
   task exit.
4. Small and contained? Yes, one file, one function, 8 insertions/6
   deletions mostly comments.
5. No new features/APIs? Yes.
6. Can apply to stable? Yes for current `v7.0`; older trees likely need
   minor backport context due function naming.

Step 9.3 Exception category: No special exception category; this is a
normal bug fix.

Step 9.4 Decision: Backport. The fix restores intended dying-task
allocation behavior, is narrowly scoped, has strong reviewer confidence,
and addresses a serious liveness failure with minimal regression risk.

## Verification
- Phase 1: Parsed `git show --format=fuller` for `dde2f938d02f2`;
  confirmed tags and absence of `Fixes:`/`Reported-by:`/`Tested-by:`.
- Phase 2: Inspected the diff; confirmed only `kernel/cgroup/cpuset.c`
  changes and functional reorder in `cpuset_current_node_allowed()`.
- Phase 3: Ran `git blame` on `kernel/cgroup/cpuset.c` and
  `mm/page_alloc.c`; inspected historical commits `5563e77078d8`,
  `c596d9f320aa`, `9bf2229f8817`, `9cd7555875bb`, and `8adce0857769`.
- Phase 4: Ran `b4 dig -c`, `b4 dig -a`, `b4 dig -w`, and saved/read the
  mbox; confirmed v1 only, maintainer/reviewer acks, and no NAKs.
- Phase 5: Used repository search and file reads to trace
  `cpuset_current_node_allowed()` through `__cpuset_zone_allowed()` into
  `get_page_from_freelist()` and allocator preparation.
- Phase 6: Used `git grep` on stable tags from `v4.4` through `v7.0`;
  confirmed the old ordering and allocator hardwall behavior exist. Ran
  `git apply --check` successfully on current `v7.0.9`.
- Phase 7: Checked recent cpuset history to assess activity and context.
- Phase 8: Verified `PF_EXITING` is set in `exit_signals()` during
  `do_exit()` before later exit cleanup.
- UNVERIFIED: Lore/stable WebFetch was blocked by Anubis; no runtime
  reproducer or test result was found; exact pre-`v4.4` introduction was
  not verified.

**YES**

 kernel/cgroup/cpuset.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1335e437098e8..d2d2c7126638a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4171,11 +4171,11 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  * current's mems_allowed, yes.  If it's not a __GFP_HARDWALL request and this
  * node is set in the nearest hardwalled cpuset ancestor to current's cpuset,
  * yes.  If current has access to memory reserves as an oom victim, yes.
- * Otherwise, no.
+ * If the current task is PF_EXITING, yes. Otherwise, no.
  *
  * GFP_USER allocations are marked with the __GFP_HARDWALL bit,
  * and do not allow allocations outside the current tasks cpuset
- * unless the task has been OOM killed.
+ * unless the task has been OOM killed or is exiting.
  * GFP_KERNEL allocations are not so marked, so can escape to the
  * nearest enclosing hardwalled ancestor cpuset.
  *
@@ -4189,7 +4189,9 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  * The first call here from mm/page_alloc:get_page_from_freelist()
  * has __GFP_HARDWALL set in gfp_mask, enforcing hardwall cpusets,
  * so no allocation on a node outside the cpuset is allowed (unless
- * in interrupt, of course).
+ * in interrupt, of course).  The PF_EXITING check must therefore
+ * come before the __GFP_HARDWALL check, otherwise a dying task
+ * would be blocked on the fast path.
  *
  * The second pass through get_page_from_freelist() doesn't even call
  * here for GFP_ATOMIC calls.  For those calls, the __alloc_pages()
@@ -4199,6 +4201,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  *	in_interrupt - any node ok (current task context irrelevant)
  *	GFP_ATOMIC   - any node ok
  *	tsk_is_oom_victim   - any node ok
+ *	PF_EXITING   - any node ok (let dying task exit quickly)
  *	GFP_KERNEL   - any node in enclosing hardwalled cpuset ok
  *	GFP_USER     - only nodes in current tasks mems allowed ok.
  */
@@ -4218,11 +4221,10 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	 */
 	if (unlikely(tsk_is_oom_victim(current)))
 		return true;
-	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
-		return false;
-
 	if (current->flags & PF_EXITING) /* Let dying task have memory */
 		return true;
+	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
+		return false;
 
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
 	spin_lock_irqsave(&callback_lock, flags);
-- 
2.53.0



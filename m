Return-Path: <cgroups+bounces-16125-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMQXBiWZDWoMzwUAu9opvQ
	(envelope-from <cgroups+bounces-16125-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 13:21:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC01058C4BE
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 13:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1CB0304F740
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E5E3D9026;
	Wed, 20 May 2026 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oppyVCP4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F1E3A9633;
	Wed, 20 May 2026 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276000; cv=none; b=DlfO+SBBpACbct2sUj9ePrmh0a9X0fBmCMxzLyPuKJmVHr4wD2VGRNIwjRjb61TZmPSJawaY42iKHaZO5X4rGg3VtzSviDzAF8Z1VJ1VutLWzHMl3Ft7SKxTZYKj7QY9qnIzOyHDWT3gBeBTfnZTd6iZcuJzOn3hVRCsWQMFF+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276000; c=relaxed/simple;
	bh=MNnI0yfp4HL9JvMQJhtnBDP+XiDP1g05bZVIKRJla8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ony6Ank+7u6ItFSt8G59oDMtR9NGcYl/aEYLdqP+1CsReBsnPnbId4QoaPB1NkLR9FWg2IqwY8bA6dXU3qj8G4s8F89ftw1iEr9Q91TJR7402O4m5Z1gZwXuh3pxn20+q8kw1Q7JRlN+qP/tAAksEOH18C+IYcp32ppyc9eugnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oppyVCP4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E364D1F00894;
	Wed, 20 May 2026 11:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779275995;
	bh=1ygI4seEk1TqIOMzl4yzboMtxPWNVHrpIpoLyuWmM1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oppyVCP4qo06thYJE6TqXTVERDc+n3k+oPT2wj2FvBRP0wDZqAcaC1jqPp/bQAThz
	 mID478TC2q+QYxFW9LFl+r+sgA1EJOHC3xXgqe4qKen0fNrLPWg4+nzrYgbUF1Tg1S
	 0ANzmZaP6rvj04V4WtDwg+TLKM5HHtfklODJ2FABhFkrMg4n/P7foe1d59sbQBMCxO
	 t7lPqTHjOYY9SGMLrpojUA6N9iE5L/g9F2vmbu1FQoGN50CsXFz6mK+0M8Zf6gbeSY
	 k/Bya0uLjD/eA2R2Yg9QndG5E5wZI7RqDH+8ILKf2zIkmPXmgnHGzJQZbdSTeaGTnc
	 WF6zs77RtnBmg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hongfu Li <lihongfu@kylinos.cn>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-5.10] selftests/cgroup: Fix cg_read_strcmp() empty string comparison
Date: Wed, 20 May 2026 07:18:39 -0400
Message-ID: <20260520111944.3424570-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520111944.3424570-1-sashal@kernel.org>
References: <20260520111944.3424570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 7.0.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16125-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,kylinos.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EC01058C4BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hongfu Li <lihongfu@kylinos.cn>

[ Upstream commit e32e6f02168f2ad7991eb5d160d312d2001520c8 ]

cg_read_strcmp() allocated a buffer sized to strlen(expected) + 1,
then passed it to read_text() which calls read(fd, buf, size-1).

When comparing against an empty string (""), strlen("") = 0 gives a
1-byte buffer, and read() is asked to read 0 bytes.  The file content
is never actually read, so strcmp("", buf) always returns 0 regardless
of the real content.  This caused cg_test_proc_killed() to always
report the cgroup as empty immediately, making OOM tests pass without
verifying that processes were killed.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Phase 1: Commit Message Forensics

Step 1.1 Record: Subsystem `selftests/cgroup`; action verb `Fix`; intent
is to correct empty-string comparison in `cg_read_strcmp()`.

Step 1.2 Record: Tags present are:
- `Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>`
- `Signed-off-by: Tejun Heo <tj@kernel.org>`

No `Fixes:`, `Reported-by:`, `Tested-by:`, `Reviewed-by:`, `Acked-by:`,
`Link:`, or `Cc: stable@vger.kernel.org` tags are present.

Step 1.3 Record: The commit describes a concrete selftest bug: for
expected `""`, `strlen(expected) + 1` allocates one byte, and
`read_text()` calls `read(fd, buf, size - 1)`, so zero bytes are read.
The symptom is false success: `cg_test_proc_killed()` can report a
cgroup as empty immediately, so OOM tests can pass without verifying
process death.

Step 1.4 Record: This is a direct bug fix, not hidden cleanup. It fixes
incorrect test validation logic.

## Phase 2: Diff Analysis

Step 2.1 Record: One file changed:
`tools/testing/selftests/cgroup/lib/cgroup_util.c`, with 3 insertions
and 2 deletions. Modified function: `cg_read_strcmp()`. Scope: single-
file surgical selftest helper fix.

Step 2.2 Record: Before, non-NULL `expected` always used
`strlen(expected) + 1`; for `""`, that meant `size == 1` and `cg_read()`
read zero bytes. After, empty expected strings use `size == 2`, allowing
one byte to be read so non-empty file contents are detected.

Step 2.3 Record: Bug category is logic/correctness in a userspace
selftest helper. No kernel runtime locking, refcounting, memory safety,
or API behavior changes.

Step 2.4 Record: The fix is obviously correct for the described case:
empty file still compares equal, non-empty file no longer compares equal
after reading at least one byte. Regression risk is very low and limited
to cgroup selftests.

## Phase 3: Git History Investigation

Step 3.1 Record: Blame shows `cg_read_strcmp()` came from `84092dbcf901`
in v4.18-rc1, and the `size = strlen(expected) + 1` logic was last
touched by `48c2bb0b9cf86` in v4.19-rc5. The bug has therefore existed
across many stable releases.

Step 3.2 Record: No `Fixes:` tag is present. I inspected related commits
anyway: `84092dbcf901` introduced the selftest utility, `48c2bb0b9cf86`
tried to fix `cg_read_strcmp()` but still checked `!expected` rather
than empty `expected`, and `d830020656c5b` changed the NULL case to
return `-1`.

Step 3.3 Record: Recent related history includes `6680c162b4850` adding
`cg_read_strcmp_wait()` and `2c754a84ff16a` moving the utility into
`lib/`. No functional prerequisite for this fix was identified.

Step 3.4 Record: No prior Hongfu Li commits under
`tools/testing/selftests/cgroup` were found. The commit was applied by
Tejun Heo, who is listed as a cgroup maintainer in `MAINTAINERS`.

Step 3.5 Record: No dependent code changes are required for the logic
itself. Older stable trees before the selftest library move need a path-
only backport adjustment.

## Phase 4: Mailing List And External Research

Step 4.1 Record: `b4 dig -c e32e6f02168f2...` found the original
submission at
`https://patch.msgid.link/20260509080328.632007-1-lihongfu@kylinos.cn`.
`b4 dig -a` found only v1. The saved mbox shows Tejun replied: “Applied
to cgroup/for-7.1-fixes.” No NAKs or concerns were present in the
fetched thread.

Step 4.2 Record: `b4 dig -w` showed the patch was sent to Tejun Heo,
Johannes Weiner, Michal Koutný, Shuah Khan, cgroups, linux-kselftest,
and linux-kernel, so the right maintainers/lists were included.

Step 4.3 Record: No separate bug report, syzbot report, or bugzilla link
was present.

Step 4.4 Record: No multi-patch series or related required patches were
found; this is standalone.

Step 4.5 Record: Lore WebFetch was blocked by Anubis for stable search.
WebSearch did not find stable-specific discussion for this exact 2026
commit.

## Phase 5: Code Semantic Analysis

Step 5.1 Record: Modified function: `cg_read_strcmp()`.

Step 5.2 Record: Callers found include `cg_read_strcmp_wait()`,
`test_memcontrol.c`, `test_core.c`, `test_kill.c`, `test_pids.c`, and
`test_zswap.c`. Empty-string `cgroup.procs` checks are in
`test_memcontrol.c`.

Step 5.3 Record: The relevant callees are `malloc()`, `cg_read()`,
`read_text()`, `read()`, `strcmp()`, and `free()`.

Step 5.4 Record: Verified call chain: `test_memcontrol` main test loop
-> OOM tests such as `test_memcg_oom_events()` / `cg_test_proc_killed()`
-> `cg_read_strcmp()` -> `cg_read()` -> `read_text()`. This is reachable
by running cgroup kselftests, not by normal kernel runtime use.

Step 5.5 Record: Similar affected pattern exists in stable branches
where `cg_read_strcmp(..., "cgroup.procs", "")` is used and the helper
still has `size = strlen(expected) + 1`.

## Phase 6: Stable Tree Analysis

Step 6.1 Record: I verified the buggy helper and affected empty
`cgroup.procs` checks exist in `stable/linux-5.4.y`, `5.10.y`, `5.15.y`,
`6.1.y`, `6.6.y`, `6.12.y`, `6.17.y`, `6.18.y`, `6.19.y`, and `7.0.y`.

Step 6.2 Record: The patch applies cleanly to current
`stable/linux-7.0.y` with `git apply --check`. Branches using
`tools/testing/selftests/cgroup/cgroup_util.c` instead of
`lib/cgroup_util.c` need a trivial path adjustment.

Step 6.3 Record: Related older fixes are present, but no checked stable
branch contained the candidate’s `expected[0] == '\0'` fix.

## Phase 7: Subsystem Context

Step 7.1 Record: Subsystem is cgroup selftests. Runtime criticality is
peripheral, but test criticality is meaningful for memcg/cgroup
validation.

Step 7.2 Record: The subsystem is active; recent stable history includes
multiple cgroup selftest fixes, and `MAINTAINERS` lists
`tools/testing/selftests/cgroup/` under maintained cgroup ownership.

## Phase 8: Impact And Risk

Step 8.1 Record: Affected users are kernel developers, distributions, CI
systems, and stable maintainers running cgroup kselftests.

Step 8.2 Record: Trigger is running affected cgroup OOM selftests that
compare `cgroup.procs` with `""`. This is not an unprivileged runtime
kernel trigger.

Step 8.3 Record: Failure mode is false PASS / missed test validation,
not a kernel crash or data corruption. Severity: MEDIUM for stable
validation quality.

Step 8.4 Record: Benefit is medium because it prevents false success in
OOM-related stable testing. Risk is very low because the change is tiny,
userspace-only, and does not affect kernel runtime behavior.

## Phase 9: Final Synthesis

Evidence for backporting: fixes a real, verified selftest correctness
bug; bug exists in many stable trees; affects OOM/memcg validation;
patch is tiny and obvious; reviewed/applied by the cgroup maintainer; no
runtime regression risk.

Evidence against backporting: it does not fix a production kernel
crash/security/data-corruption bug directly, only test correctness.

Stable rules checklist:
1. Obviously correct and tested by review? Yes, obviously correct by
   code inspection; no explicit `Tested-by`.
2. Fixes a real bug? Yes, false empty-string comparison in selftests.
3. Important issue? Medium: prevents false PASS in OOM selftests, not
   runtime-critical.
4. Small and contained? Yes, 5-line single-function change.
5. No new features/APIs? Yes.
6. Can apply to stable? Yes for 7.0 cleanly; older branches need trivial
   path adjustment.

Exception category: Not a device ID, quirk, DT, build, or documentation
fix. It is a selftest correctness fix.

## Verification

- Phase 1: `git show e32e6f02168f2...` verified subject, body, tags,
  author, committer, and no `Fixes:`/stable tags.
- Phase 2: `git show --patch` verified the 3 insertion / 2 deletion
  change in `cg_read_strcmp()`.
- Phase 3: `git blame -L 99,123 e32e6f^ --
  tools/testing/selftests/cgroup/lib/cgroup_util.c` verified line
  history.
- Phase 3: `git show 84092dbcf901`, `git show 48c2bb0b9cf86`, and `git
  show d830020656c5b` verified related history.
- Phase 4: `b4 dig -c`, `b4 dig -a`, `b4 dig -w`, and saved mbox
  verified lore URL, v1-only series, recipients, and Tejun’s applied
  reply.
- Phase 5: `rg "cg_read_strcmp\\(" tools/testing/selftests/cgroup` and
  file reads verified callers and empty-string uses.
- Phase 6: Python checks against stable branches verified buggy code and
  affected tests in listed stable trees.
- Phase 6: `git diff e32e6f^ e32e6f | git apply --check` verified clean
  application to `stable/linux-7.0.y`.
- Phase 7: `rg` in `MAINTAINERS` verified cgroup maintainers and
  selftest path ownership.
- Phase 8: Impact classification is based on verified file path under
  `tools/testing/selftests`, verified test call chain, and no kernel
  runtime files changed.
- UNVERIFIED: I did not run the cgroup selftests, and Lore WebFetch was
  blocked by Anubis for direct stable archive browsing.

**YES**

 tools/testing/selftests/cgroup/lib/cgroup_util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
index 6a7295347e90b..42f54936f4bbd 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -106,8 +106,9 @@ int cg_read_strcmp(const char *cgroup, const char *control,
 	/* Handle the case of comparing against empty string */
 	if (!expected)
 		return -1;
-	else
-		size = strlen(expected) + 1;
+
+	/* needs size > 1, otherwise cg_read() reads 0 bytes */
+	size = (expected[0] == '\0') ? 2 : strlen(expected) + 1;
 
 	buf = malloc(size);
 	if (!buf)
-- 
2.53.0



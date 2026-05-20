Return-Path: <cgroups+bounces-16124-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDQCB8iZDWoMzwUAu9opvQ
	(envelope-from <cgroups+bounces-16124-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 13:23:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1432058C56B
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 13:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC4C23062C51
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AA33D565C;
	Wed, 20 May 2026 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHuMJxRP"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0139658D;
	Wed, 20 May 2026 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275997; cv=none; b=fnU1fLQEBvElOrB/HZg+l4YnCtUUWY3tb3ZfWZKUr2mCFSyQCrV7ogCvVuVkRWytNsCRKM5b5Lu0m0MQEv4gkv3CQLLkVT3Bx8MCinBNddCyTmo29QIai+/vrIrK4uTYHoY1hCKmuoKq6R/8XKErdus7FAKgeA6jKp/4Uv1Vnmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275997; c=relaxed/simple;
	bh=RQNb7GGy+bNMh/3tLvKifE9HAoNS+QkXX2pfhribtes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpEcO7vAQTSkcaii+5x/9wukBA1I1vLlC6bggq+Iof61Bc/wmg+2DSBVrzH1RpZtqZMOQTSovDjFYXQX4mY6VNWn8i9t96Cx5kyZcXo+HpmNkMdeUYHkQd7bn7M6gPdnMa8ROK6oIYq+XZLQVyYTrLkqT9uTaXEwZ+MEf1eLMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHuMJxRP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5E11F00896;
	Wed, 20 May 2026 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779275990;
	bh=8UWgSKkIXnrTfv+q9nLslYDYdVCevJUvbhSLAj4hwo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jHuMJxRPdYnzH6HeBPmjKHi8AtaTvt7MOIHxe68KW36WzSeTko0iZ3PfhmITyiGRI
	 lpi5ZRBMr3Dt9AYr99cGZlm+nRt4XUcWumx+Cx2c2GmPbI8+7Mnm68cQRizGOadoU6
	 0RGOxiZ3/v2FODpGks4b0K+anpdSQI6+rwLrr5nFMNsx12J/2HlVMCi2RbhdfU+LgZ
	 0SL+MRdghV6SyY2Yi6tQ6q5fHD1ZrTRZdxwrf2XHE2EpfWmFiDucNse2AkXyRMVS9w
	 J3DaI4DX+4gRSFmZsNWwk9tBsWy60v1G+nJQxQI2nqTDpFXIl4qCijI99E0T3IiZm5
	 9r9X+4qjdS5HQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	corbet@lwn.net,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 7.0-6.6] docs: cgroup-v1: Update charge-commit section
Date: Wed, 20 May 2026 07:18:36 -0400
Message-ID: <20260520111944.3424570-4-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16124-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:email,msgid.link:url,linuxfoundation.org:email,cmpxchg.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:email]
X-Rspamd-Queue-Id: 1432058C56B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "T.J. Mercier" <tjmercier@google.com>

[ Upstream commit d8769544bde51b0ac980d10f8fe9f9fed6c95995 ]

Commit 1d8f136a421f ("memcg/hugetlb: remove memcg hugetlb
try-commit-cancel protocol") removed mem_cgroup_commit_charge() and
mem_cgroup_cancel_charge(), but the docs still refer to those functions.
There is no longer any charge cancellation.

Update the docs to match the code.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Phase 1: Commit Message Forensics
Step 1.1 Record: subsystem `docs: cgroup-v1`; action verb `Update`;
intent: update `Documentation/admin-guide/cgroup-v1/memcg_test.rst` so
the charge-commit section matches current memcg code.

Step 1.2 Record: tags present: `Signed-off-by: T.J. Mercier
<tjmercier@google.com>` and `Signed-off-by: Tejun Heo <tj@kernel.org>`.
No `Fixes:`, `Reported-by:`, `Tested-by:`, `Reviewed-by:`, `Acked-by:`,
`Link:`, or `Cc: stable@vger.kernel.org` tags in the committed message.

Step 1.3 Record: the body says commit `1d8f136a421f` removed
`mem_cgroup_commit_charge()` and `mem_cgroup_cancel_charge()`, while the
cgroup-v1 memcg docs still name them and describe cancellation.
Symptom/failure mode: incorrect documentation only. Version information:
the referenced removal commit is from 2025-01-13 in the local object
database; candidate commit is from 2026-04-30. Root cause: docs were not
updated when the code was changed.

Step 1.4 Record: this is not a hidden runtime bug fix. It is an explicit
documentation correctness fix.

## Phase 2: Diff Analysis
Step 2.1 Record: one file changed: `Documentation/admin-
guide/cgroup-v1/memcg_test.rst`, `2 insertions(+), 4 deletions(-)`. No
functions modified. Scope: single-file documentation-only surgical
change.

Step 2.2 Record: before, the section was titled `charge-commit-cancel`,
listed `mem_cgroup_commit_charge()` or `mem_cgroup_cancel_charge()`, and
described `cancel()`. After, it is titled `charge-commit`, lists
`commit_charge()`, and removes the cancellation text.

Step 2.3 Record: bug category is documentation/comment correctness.
Specific mechanism: removes stale references to APIs that are absent in
current `6.19.y`/`7.0.y` code and in `origin/master`.

Step 2.4 Record: fix quality is obviously correct for trees whose memcg
code no longer has `mem_cgroup_commit_charge()` /
`mem_cgroup_cancel_charge()`. Regression risk is zero runtime risk, but
there is a branch-selection concern: `stable/linux-6.12.y` still
contains those functions, so this exact doc update would be misleading
there.

## Phase 3: Git History Investigation
Step 3.1 Record: `git blame` before the candidate shows the stale doc
lines came from `f3f5edc5e41e` in this repository’s history. `git blame
origin/master` shows the changed lines attributed to `d8769544bde51`.

Step 3.2 Record: no `Fixes:` tag. I still inspected referenced commit
`1d8f136a421f26747e58c01281cba5bffae8d289`; it removed prototypes and
implementations for `mem_cgroup_commit_charge()`,
`mem_cgroup_cancel_charge()`, and related hugetlb try/commit/cancel
helpers.

Step 3.3 Record: recent history for `Documentation/admin-
guide/cgroup-v1/memcg_test.rst` on `origin/master` has only the file
introduction/import commit and this candidate. Related path history
shows the candidate was merged via `cgroup-for-7.1-rc2-fixes`. No
prerequisite doc series found.

Step 3.4 Record: author `T.J. Mercier` has at least one other cgroup-
related commit in `origin/master`; Tejun Heo is listed in `MAINTAINERS`
as cgroup maintainer and committed the patch.

Step 3.5 Record: no code dependencies for the patch itself. It can apply
standalone to the current `stable/linux-7.0.y` checkout. Applicability
must be gated by whether the target tree’s code has removed the old
APIs.

## Phase 4: Mailing List And External Research
Step 4.1 Record: `b4 dig -c d8769544bde51...` found the original
submission at
`https://patch.msgid.link/20260430201142.240387-1-tjmercier@google.com`.
`b4 dig -a` found only v1 of a single-patch series. The mbox contains
Tejun’s reply: “Applied to cgroup/for-7.1-fixes.” No NAKs or concerns
found in the saved thread.

Step 4.2 Record: `b4 dig -w` shows recipients included cgroup
maintainers/list and docs list: `tj@kernel.org`, `hannes@cmpxchg.org`,
`mkoutny@suse.com`, `cgroups@vger.kernel.org`, `corbet@lwn.net`,
`skhan@linuxfoundation.org`, `linux-doc@vger.kernel.org`, `linux-
kernel@vger.kernel.org`.

Step 4.3 Record: no `Reported-by` or bug-report `Link:` tags. No syzbot,
bugzilla, or user-impact bug report applies.

Step 4.4 Record: b4 found a standalone single-patch series, not part of
a multi-patch dependency chain.

Step 4.5 Record: web search did not find stable-list discussion for this
exact patch. `WebFetch` to lore/patch.msgid was blocked by Anubis, but
b4 successfully fetched the mbox.

## Phase 5: Code Semantic Analysis
Step 5.1 Record: no functions modified by the diff.

Step 5.2 Record: no callers affected by the diff. For documentation
accuracy, I verified current `stable/linux-7.0.y` code has
`commit_charge()` callers in `charge_memcg()`,
`mem_cgroup_replace_folio()`, and `mem_cgroup_migrate()`.

Step 5.3 Record: no changed callees. The relevant current code has
`commit_charge()` assigning `folio->memcg_data`, and callers also invoke
`memcg1_commit_charge()` where appropriate.

Step 5.4 Record: runtime reachability is not relevant because no
executable code changes.

Step 5.5 Record: similar stale docs pattern exists in stable branches;
however code state differs by branch. `6.19.y`/`7.0.y` have stale docs
and no old API. `6.12.y` still has `mem_cgroup_commit_charge()` and
`mem_cgroup_cancel_charge()` in code.

## Phase 6: Cross-Referencing And Stable Tree Analysis
Step 6.1 Record: buggy stale documentation exists in
`stable/linux-7.0.y`, `stable/linux-6.19.y`, `stable/linux-6.18.y`,
`stable/linux-6.6.y`, `stable/linux-6.1.y`, `stable/linux-5.15.y`, and
`stable/linux-5.10.y` by exact doc grep. I verified the old APIs are
absent in several of those trees, but `stable/linux-6.12.y` still
contains `mem_cgroup_commit_charge()` and `mem_cgroup_cancel_charge()`,
so this exact upstream text is not universally correct for all
maintained stable lines.

Step 6.2 Record: `git apply --check` of the candidate diff succeeds on
the current `stable/linux-7.0.y` checkout. Expected backport difficulty:
clean for trees with matching doc context; branch-specific review needed
for `6.12.y`.

Step 6.3 Record: no related stable fix for this exact doc update found
by local stable branch ancestry checks or web search.

## Phase 7: Subsystem And Maintainer Context
Step 7.1 Record: subsystem is cgroup-v1 memcg documentation.
Criticality: peripheral/runtime-none; important only for documentation
correctness.

Step 7.2 Record: cgroup and memcg areas are active; recent
`origin/master` history includes multiple cgroup/mm fixes. The candidate
was applied by the cgroup maintainer.

## Phase 8: Impact And Risk Assessment
Step 8.1 Record: affected population is documentation readers and
developers/admins consulting old cgroup-v1 memcg internals. No kernel
runtime users are affected.

Step 8.2 Record: trigger condition is reading or relying on the stale
documentation. Unprivileged users cannot trigger a kernel failure
because there is no runtime behavior.

Step 8.3 Record: failure mode is incorrect documentation. Severity: LOW.
It can mislead developers/admins, but it does not fix crash, corruption,
leak, deadlock, or security behavior.

Step 8.4 Record: benefit is low but real for documentation correctness,
especially because the stable rules exception allows
documentation/comment fixes and runtime risk is zero. Risk is very low
for branches whose code matches the new text; risk is documentation-
regression risk if applied to a branch like `6.12.y` where cancellation
APIs still exist.

## Phase 9: Final Synthesis
Step 9.1 Record: evidence for backporting: tiny docs-only patch;
corrects verified stale references in current `7.0.y` and `6.19.y`;
applied by cgroup maintainer; no runtime regression risk; documentation
fixes are allowed. Evidence against: no runtime bug or user-visible
stability issue; not correct for every stable branch, specifically
verified `6.12.y` still has the old commit/cancel APIs. Unresolved: I
did not exhaustively validate every maintained stable branch’s memcg API
state.

Step 9.2 Stable rules checklist:
1. Obviously correct and tested? Yes for matching-code branches;
   verified by code grep, `git diff --check`, and `git apply --check` on
   `7.0.y`.
2. Fixes a real bug that affects users? It fixes incorrect
   documentation, not runtime behavior.
3. Important issue? No runtime severity; LOW documentation correctness
   issue.
4. Small and contained? Yes, 6-line docs-only diff in one file.
5. No new features or APIs? Yes.
6. Can apply to stable trees? Yes to at least current `7.0.y`; should
   not be applied blindly to `6.12.y`.

Step 9.3 Record: exception category is documentation fix.

Step 9.4 Decision: backport is acceptable for stable trees whose memcg
implementation no longer has charge cancellation APIs. It should be
excluded from trees like `6.12.y` where the old APIs still exist. With
that branch-selection caveat, this qualifies under the documentation-fix
exception.

Verification:
- [Phase 1] Parsed candidate commit
  `d8769544bde51b0ac980d10f8fe9f9fed6c95995`: only two Signed-off-by
  tags, no bug/report/stable tags.
- [Phase 2] `git show --stat --patch`: confirmed one docs file, `2
  insertions(+), 4 deletions(-)`.
- [Phase 3] `git show 1d8f136a421f...`: confirmed referenced commit
  removed `mem_cgroup_commit_charge()` and `mem_cgroup_cancel_charge()`
  from mainline code.
- [Phase 3] `git log origin/master --grep`: found candidate and merge
  via `cgroup-for-7.1-rc2-fixes`.
- [Phase 4] `b4 dig`: found lore thread and exact patch-id match.
- [Phase 4] `b4 dig -a`: only v1 single-patch series.
- [Phase 4] `b4 dig -w`: relevant cgroup and docs maintainers/lists were
  included.
- [Phase 4] Saved mbox: confirmed Tejun replied “Applied to
  cgroup/for-7.1-fixes”; no NAKs or stable nomination found.
- [Phase 5] `rg`/`git grep`: confirmed current code uses
  `commit_charge()` and no longer has old API names in `7.0.y`.
- [Phase 6] `git apply --check`: candidate applies cleanly to current
  `7.0.y`.
- [Phase 6] Branch checks: `6.12.y` still has
  `mem_cgroup_commit_charge()` and `mem_cgroup_cancel_charge()`, so this
  patch must not be applied there unchanged.
- [Phase 8] Runtime impact verified as none because only
  `Documentation/admin-guide/cgroup-v1/memcg_test.rst` changes.

**YES**

 Documentation/admin-guide/cgroup-v1/memcg_test.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
index 9f8e27355cba5..7c7cd457cf695 100644
--- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
+++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
@@ -47,21 +47,19 @@ Please note that implementation details can be changed.
 	  Called when swp_entry's refcnt goes down to 0. A charge against swap
 	  disappears.
 
-3. charge-commit-cancel
+3. charge-commit
 =======================
 
 	Memcg pages are charged in two steps:
 
 		- mem_cgroup_try_charge()
-		- mem_cgroup_commit_charge() or mem_cgroup_cancel_charge()
+		- commit_charge()
 
 	At try_charge(), there are no flags to say "this page is charged".
 	at this point, usage += PAGE_SIZE.
 
 	At commit(), the page is associated with the memcg.
 
-	At cancel(), simply usage -= PAGE_SIZE.
-
 Under below explanation, we assume CONFIG_SWAP=y.
 
 4. Anonymous
-- 
2.53.0



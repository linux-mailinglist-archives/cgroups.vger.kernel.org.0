Return-Path: <cgroups+bounces-13956-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ2xDcfLj2nMTgEAu9opvQ
	(envelope-from <cgroups+bounces-13956-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 02:11:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE50C13A999
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 02:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A73A43106208
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 01:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEE222259F;
	Sat, 14 Feb 2026 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLuH2gg0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7672264A3;
	Sat, 14 Feb 2026 01:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771031212; cv=none; b=lY2oBXOsLH7pt9FObg5s3tY5FVN3fUzrXpcXCz/ZTd8UIdlrlVlCQt11fAocbdrr75vy36XMyHN5KpWOM5/XKY7mpgdcEDEt+2Nr9TbD0luhwDCpuifLsbzl7b3cmYLGROqg+La6/KXQsaygATs6ckiaGP528mSFG5kuDr/KrHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771031212; c=relaxed/simple;
	bh=iVThhwFOqsUkb2fyANB+PPN6+XSMm/QNOOgEEFjWtFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jdgr8GaibuhdUTpa8GDhPBbFkmgtgIeSewRjFZ1fXKts2sY5lVqKJtHz5Kz5EHg6l5a0E6EJdFOTfR7AxJGbcjmZ7TzauosbCRXBl2ZAjkdU3z8KznBUnCIeMls79K9Uz25Kys9D6p547BKs5SmlDNq1X23LgOS8CHMkvmXd97w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLuH2gg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F4FC116C6;
	Sat, 14 Feb 2026 01:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771031212;
	bh=iVThhwFOqsUkb2fyANB+PPN6+XSMm/QNOOgEEFjWtFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLuH2gg0WgLR5qvxP5MU/vBbY9fij3Xc4fv6zezsu1Xl+db0ZONsjefm6M5d9LTI/
	 U3lAzbFHDtzBFuN80yjM6DddjgxIyQS1b00Xh7iZe5a9bfZV8hSK4IFKGEHndnCwPY
	 9vlUOF/TBQswKAiPtqqmKxVRSX3//7XQWCq0rddQAixCGU8ejLL/CUbjH68oS1OmFl
	 mOGgsx0ZY56+4R0Bj5uj25Y/shk/+pFIFO1KChO3psptXtE/BgDktv6wSZm3O6zyYE
	 K0W32PbtlpOqimBmvrN8zIffqmKDTxbAuTKUxM6zV+UfoukOt6TzMCL1x9Y+f2+oy2
	 74IISln/BjmWQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] cgroup/cpuset: Don't fail cpuset.cpus change in v2
Date: Fri, 13 Feb 2026 19:59:45 -0500
Message-ID: <20260214010245.3671907-105-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214010245.3671907-1-sashal@kernel.org>
References: <20260214010245.3671907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13956-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE50C13A999
X-Rspamd-Action: no action

From: Waiman Long <longman@redhat.com>

[ Upstream commit 6e6f13f6d5095f3a432da421e78f4d7d51ef39c8 ]

Commit fe8cd2736e75 ("cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE
until valid partition") introduced a new check to disallow the setting
of a new cpuset.cpus.exclusive value that is a superset of a sibling's
cpuset.cpus value so that there will at least be one CPU left in the
sibling in case the cpuset becomes a valid partition root. This new
check does have the side effect of failing a cpuset.cpus change that
make it a subset of a sibling's cpuset.cpus.exclusive value.

With v2, users are supposed to be allowed to set whatever value they
want in cpuset.cpus without failure. To maintain this rule, the check
is now restricted to only when cpuset.cpus.exclusive is being changed
not when cpuset.cpus is changed.

The cgroup-v2.rst doc file is also updated to reflect this change.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

This is important. The `cpus_excl_conflict()` helper function was only
introduced in v6.18-rc1 (commit `8daab66eb329`). The current fix
**modifies this helper**. This means the fix as-is only applies cleanly
to v6.18+. For earlier stable trees (6.11.y through 6.17.y), the bug
exists but the code structure is different — the fix would need to be
adapted to the inline code in `validate_change()` directly.

### 8. SUMMARY

**What the bug is**: In cgroup v2, changing `cpuset.cpus` to a value
that happens to be a subset of a sibling's `cpuset.cpus.exclusive`
incorrectly fails with `-EINVAL`. This violates the cgroup v2 API
contract that `cpuset.cpus` can be set to any value without failure.

**Who is affected**: Any cgroup v2 user (containers, Kubernetes,
systemd) who has cpusets with `cpuset.cpus.exclusive` set and tries to
change `cpuset.cpus` on a sibling.

**Severity**: Medium-high. It's a regression that breaks expected
behavior — operations that should succeed are failing. While not a crash
or data corruption, it can break container orchestration workflows.

**Fix quality**: The fix is small, well-understood, and correctly
targeted. It adds a boolean guard (`xcpus_changed`) so the restrictive
check only applies when `cpuset.cpus.exclusive` is being changed, not
when `cpuset.cpus` is being changed.

**Risk**: Low. The change makes validation less restrictive in a
controlled way. It's authored by the cgroup/cpuset maintainer and
reviewed.

**Dependencies**: The fix as written depends on the
`cpus_excl_conflict()` helper introduced in v6.18-rc1 (`8daab66eb329`).
For stable trees before 6.18, the fix would need adaptation. However,
the underlying bug exists since v6.11.

### Decision

This is a clear regression fix for a user-visible behavioral change in
cgroup v2. It's small, well-scoped, fixes a real API contract violation
that affects container workloads, authored by the subsystem maintainer,
and reviewed. The only concern is the dependency on the helper
refactoring commit for clean backporting to pre-6.18 stable trees, but
that's a mechanical backporting issue, not a reason to reject. The fix
meets all stable kernel criteria.

**YES**

 Documentation/admin-guide/cgroup-v2.rst |  8 +++----
 kernel/cgroup/cpuset.c                  | 30 ++++++++++++-------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 7f5b59d95fce5..510df2461aff2 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2561,10 +2561,10 @@ Cpuset Interface Files
 	Users can manually set it to a value that is different from
 	"cpuset.cpus".	One constraint in setting it is that the list of
 	CPUs must be exclusive with respect to "cpuset.cpus.exclusive"
-	of its sibling.  If "cpuset.cpus.exclusive" of a sibling cgroup
-	isn't set, its "cpuset.cpus" value, if set, cannot be a subset
-	of it to leave at least one CPU available when the exclusive
-	CPUs are taken away.
+	and "cpuset.cpus.exclusive.effective" of its siblings.	Another
+	constraint is that it cannot be a superset of "cpuset.cpus"
+	of its sibling in order to leave at least one CPU available to
+	that sibling when the exclusive CPUs are taken away.
 
 	For a parent cgroup, any one of its exclusive CPUs can only
 	be distributed to at most one of its child cgroups.  Having an
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c06e2e96f79dc..dc3ac38c5d160 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -603,33 +603,31 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
 
 /**
  * cpus_excl_conflict - Check if two cpusets have exclusive CPU conflicts
- * @cs1: first cpuset to check
- * @cs2: second cpuset to check
+ * @trial:	the trial cpuset to be checked
+ * @sibling:	a sibling cpuset to be checked against
+ * @xcpus_changed: set if exclusive_cpus has been set
  *
  * Returns: true if CPU exclusivity conflict exists, false otherwise
  *
  * Conflict detection rules:
  * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
  * 2. exclusive_cpus masks cannot intersect between cpusets
- * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
+ * 3. The allowed CPUs of a sibling cpuset cannot be a subset of the new exclusive CPUs
  */
-static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
+static inline bool cpus_excl_conflict(struct cpuset *trial, struct cpuset *sibling,
+				      bool xcpus_changed)
 {
 	/* If either cpuset is exclusive, check if they are mutually exclusive */
-	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
-		return !cpusets_are_exclusive(cs1, cs2);
+	if (is_cpu_exclusive(trial) || is_cpu_exclusive(sibling))
+		return !cpusets_are_exclusive(trial, sibling);
 
 	/* Exclusive_cpus cannot intersect */
-	if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))
+	if (cpumask_intersects(trial->exclusive_cpus, sibling->exclusive_cpus))
 		return true;
 
-	/* The cpus_allowed of one cpuset cannot be a subset of another cpuset's exclusive_cpus */
-	if (!cpumask_empty(cs1->cpus_allowed) &&
-	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
-		return true;
-
-	if (!cpumask_empty(cs2->cpus_allowed) &&
-	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
+	/* The cpus_allowed of a sibling cpuset cannot be a subset of the new exclusive_cpus */
+	if (xcpus_changed && !cpumask_empty(sibling->cpus_allowed) &&
+	    cpumask_subset(sibling->cpus_allowed, trial->exclusive_cpus))
 		return true;
 
 	return false;
@@ -666,6 +664,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 {
 	struct cgroup_subsys_state *css;
 	struct cpuset *c, *par;
+	bool xcpus_changed;
 	int ret = 0;
 
 	rcu_read_lock();
@@ -722,10 +721,11 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	 * overlap. exclusive_cpus cannot overlap with each other if set.
 	 */
 	ret = -EINVAL;
+	xcpus_changed = !cpumask_equal(cur->exclusive_cpus, trial->exclusive_cpus);
 	cpuset_for_each_child(c, css, par) {
 		if (c == cur)
 			continue;
-		if (cpus_excl_conflict(trial, c))
+		if (cpus_excl_conflict(trial, c, xcpus_changed))
 			goto out;
 		if (mems_excl_conflict(trial, c))
 			goto out;
-- 
2.51.0



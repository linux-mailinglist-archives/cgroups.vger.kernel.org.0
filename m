Return-Path: <cgroups+bounces-10568-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7BEBBEF0A
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 20:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3B774F1004
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 18:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5032DFA3A;
	Mon,  6 Oct 2025 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgcCLchI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B92D6E66;
	Mon,  6 Oct 2025 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774769; cv=none; b=bU5R/DjlE+Xxlt93ZZwFZpC7bDYMatCKpf9ZV91yMHlh8dNQJAHzWhRTywMuuRJSr04eBvsUsxoP8iEJfSnSC4o/CVPIyMDNy0Ckx3TVZzMPQGN6zkCk7xSrK8omo8Ri/sQuQc23FMUIkVZSC+NbUCaID8BnRtxiR/F+JXLOkio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774769; c=relaxed/simple;
	bh=N+1Fud0ZOw3fujZjMOhn3VLYI23bDuryBshBwc6HzJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L85UqCPygoZdnv12/iEwDG2KFrK9rgeLKIJrFFyyRqqo5cyf2wtR7KpoBOOG+o0L/pIBi1WixGvVuKiCU89LOl+R2LzgT8forWTD8i6wYt2PDixOVte7kjmRLdkpLLzQo4C+27ad8667dNzcqMHKy+wGjasnUfpxc92h5+aiPBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgcCLchI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E625C4CEF5;
	Mon,  6 Oct 2025 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759774769;
	bh=N+1Fud0ZOw3fujZjMOhn3VLYI23bDuryBshBwc6HzJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NgcCLchI/EHubaVjzkXq+YHIUqrIlqr4Pm10z8i6kaw2mqnmuYufof+JKWpyLJ2Dm
	 ktmN/dAN4xUnJiAcFqDEa5tAmg2jHFVlZVYvhBTnYlldFZ9FuF77PE/gzauM45y9Jk
	 XeXtkv1D34scA/t/jnt0Rh2a/Gc3PYw8qYubj9trALKSgbOFu/8RqPhhb7tczcZzod
	 5yoh+kYFT9BxTiJm3iZ/rKOgYq3csFmxUfak+Sicoo5h/QO+PNgGIaSX/hxVlhLEMq
	 FwpvZ35hCunqMyrhecKu1g+x6thZXk/3etHT+hMEaEGAAftdyE84TshQP0YerdKpj3
	 0C2xsn5xeBz8Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chen Ridong <chenridong@huawei.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] cpuset: Use new excpus for nocpu error check when enabling root partition
Date: Mon,  6 Oct 2025 14:17:52 -0400
Message-ID: <20251006181835.1919496-20-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006181835.1919496-1-sashal@kernel.org>
References: <20251006181835.1919496-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chen Ridong <chenridong@huawei.com>

[ Upstream commit 59d5de3655698679ad8fd2cc82228de4679c4263 ]

A previous patch fixed a bug where new_prs should be assigned before
checking housekeeping conflicts. This patch addresses another potential
issue: the nocpu error check currently uses the xcpus which is not updated.
Although no issue has been observed so far, the check should be performed
using the new effective exclusive cpus.

The comment has been removed because the function returns an error if
nocpu checking fails, which is unrelated to the parent.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I'll provide my comprehensive analysis and recommendation.

## BACKPORT RECOMMENDATION

**YES**

## EXTENSIVE ANALYSIS

### 1. Bug Origin and Timeline

The bug was introduced in commit **86888c7bd117c** ("cgroup/cpuset: Add
warnings to catch inconsistency in exclusive CPUs") which first appeared
in **v6.16-rc1** (April 2025).

**Critical code change that introduced the bug:**
```c
- xcpus = tmp->new_cpus;
+               xcpus = tmp->delmask;
                if (compute_effective_exclusive_cpumask(cs, xcpus,
NULL))
```

This commit changed how `xcpus` is calculated during partition root
enabling. The variable `xcpus` was reassigned to `tmp->delmask` and then
recomputed by `compute_excpus()`, but the `nocpu` error checking was
still using the stale `nocpu` boolean calculated earlier with the old
xcpus value.

### 2. Detailed Code Flow Analysis

**Before the fix (bugged code):**

At line ~1742 (before partcmd_enable block):
```c
xcpus = user_xcpus(cs);  // Initial xcpus
nocpu = tasks_nocpu_error(parent, cs, xcpus);  // Calculate nocpu with
OLD xcpus
```

Inside partcmd_enable block (lines ~1747-1826):
```c
xcpus = tmp->delmask;  // **REASSIGN xcpus**
if (compute_excpus(cs, xcpus))  // **RECOMPUTE into NEW xcpus**
    WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;

if (cpumask_empty(xcpus))
    return PERR_INVCPUS;

if (prstate_housekeeping_conflict(new_prs, xcpus))
    return PERR_HKEEPING;

if (nocpu)  // **BUG: Using OLD nocpu calculated with OLD xcpus**
    return PERR_NOCPUS;
```

**After the fix:**
```c
if (tasks_nocpu_error(parent, cs, xcpus))  // Recalculate with NEW xcpus
    return PERR_NOCPUS;
```

### 3. Bug Impact Assessment

**Severity:** Medium

**Potential manifestations:**
1. **False negatives:** A partition change could be allowed when it
   should be rejected if:
   - Old xcpus had no nocpu error
   - New xcpus (after compute_excpus) would have a nocpu error
   - Result: Parent or child tasks left without CPUs → system
     instability

2. **False positives:** A valid partition change could be rejected if:
   - Old xcpus had a nocpu error
   - New xcpus (after compute_excpus) would have no nocpu error
   - Result: Legitimate partition changes fail

**Observed impact:** According to the commit message, "Although no issue
has been observed so far," suggesting this is a latent bug that hasn't
manifested in testing or production yet.

### 4. Why This Should Be Backported

**Strong YES indicators:**

1. **Logical correctness bug**: The code is provably incorrect - using
   stale data for validation after that data has been updated

2. **Part of a bug fix series**: This commit is the second in a series
   fixing related issues:
   - Commit 216217ebee16: Fixed new_prs not being assigned before
     housekeeping check
   - Commit 59d5de36556986: Fixed nocpu not using updated xcpus

3. **Low risk change**:
   - Only 1 line of actual code changed (plus comment removal)
   - Changes `if (nocpu)` → `if (tasks_nocpu_error(parent, cs, xcpus))`
   - Function `tasks_nocpu_error()` already exists and is well-tested

4. **Confined scope**: Only affects cpuset partition root enabling path

5. **Prevents potential system instability**: If manifested, could leave
   tasks without CPUs

6. **Stable tree criteria compliance:**
   - Important bugfix: ✓ (correctness issue in resource management)
   - Minimal risk: ✓ (one line change)
   - No new features: ✓
   - Confined to subsystem: ✓ (cpuset only)

### 5. Related Context

This fix is directly related to and depends on the understanding of:
- Commit 216217ebee16 which fixed a similar issue with new_prs
- The refactoring series by Chen Ridong that reorganized cpuset
  exclusive CPU handling
- The tasks_nocpu_error() function introduced in v6.7 (commit
  e2ffe502ba450)

### 6. Versions Affected

The bug exists in:
- v6.16-rc1 through v6.16-rc4
- v6.16 (final)
- Any stable trees that have backported commit 86888c7bd117c

### 7. Technical Rationale

The `tasks_nocpu_error()` function checks if enabling a partition would
leave the parent or child without CPUs when they have tasks. The check
must use the **final computed** exclusive CPUs (`xcpus` after
`compute_excpus()`), not the initial user-specified exclusive CPUs. The
bug causes the check to use the wrong cpumask, potentially making
incorrect decisions about partition validity.

### 8. Recommendation Summary

**This commit should be backported because:**
- Fixes a logical correctness bug in critical resource management code
- Minimal risk (one line change, well-tested function)
- Prevents potential system instability
- Part of a coherent bug fix series
- Affects a relatively new feature (v6.16-rc1)
- Reviewed by cpuset maintainer (Waiman Long)
- Signed-off-by cgroup maintainer (Tejun Heo)

 kernel/cgroup/cpuset.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 27adb04df675d..50f1d33d31bc9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1727,11 +1727,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		if (prstate_housekeeping_conflict(new_prs, xcpus))
 			return PERR_HKEEPING;
 
-		/*
-		 * A parent can be left with no CPU as long as there is no
-		 * task directly associated with the parent partition.
-		 */
-		if (nocpu)
+		if (tasks_nocpu_error(parent, cs, xcpus))
 			return PERR_NOCPUS;
 
 		/*
-- 
2.51.0



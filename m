Return-Path: <cgroups+bounces-12944-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3937DCFF9B9
	for <lists+cgroups@lfdr.de>; Wed, 07 Jan 2026 20:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A53A733F7091
	for <lists+cgroups@lfdr.de>; Wed,  7 Jan 2026 18:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EBF37997E;
	Wed,  7 Jan 2026 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2Md2+Sb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE7C3A1E8A;
	Wed,  7 Jan 2026 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801222; cv=none; b=iPOuC2ZR1305UWwbQACoyrTjV3+4Xu5t+fQqnoSDvg3sEZCGuDcuiO5LOpdQ3hHl+PwrAUGXCDQn0EejdIah7M/kcMDH7IefSLdbeEiMNNsBkzhin3Ndkb3pJ3Pq5qjj4wrOEGW3eG7lSFB2gYVsWoXjC0onhYzg4sAVgCYnHgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801222; c=relaxed/simple;
	bh=qQGX8sJg7E+NIZxbnSahNhBWSN94VZt80XshswfflZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiNsa8TYWtnRFYlzQAspNBwJkSLHS+qQ6h1f43Yb4o8YDWRNYvkGHBXBHwrBpGHCBeAbaz4nrcEkWeNgT2qbUtv562s3TBs+/A5oZsBpoYd/AuyO3IWK5qhnJdyxnYknPG3J5WBQwKQJXuky0h98+Vx5RHVcOhOeJCEt9fuEOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2Md2+Sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A06C19422;
	Wed,  7 Jan 2026 15:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767801220;
	bh=qQGX8sJg7E+NIZxbnSahNhBWSN94VZt80XshswfflZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2Md2+SbVS2RYfE0WhtZbDgiq7LKhj2JQ1Le19TWForiKAyMcc9CpiJITOBAUqYan
	 YCQsGNvLB8saf300p63M7B4trx25YiD+G6i5YqLueLmasEORHdXi79bH7EakFSc9Hk
	 NlmtyzYMEGUGBgGzA1AYP5xQhnjECVs2LbURr18vJCWwpvwvQZJiuqWR3vXWsUuuPb
	 gPllsy074hzDxaQhFX0FnX6opSh1gZldjiRQhenM/MV0S5FkQcU4YXKH0C6ksHlRaA
	 SB9sggfXYs7lMfGNQnlMOYUSgxh2CfPda/NHanb01mpA3766XND2x3jTBxzJOfArJq
	 3B87/HxVGBjdw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: shechenglong <shechenglong@xfusion.com>,
	Yu Kuai <yukuai@fnnas.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	tj@kernel.org,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] block,bfq: fix aux stat accumulation destination
Date: Wed,  7 Jan 2026 10:53:09 -0500
Message-ID: <20260107155329.4063936-7-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260107155329.4063936-1-sashal@kernel.org>
References: <20260107155329.4063936-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: shechenglong <shechenglong@xfusion.com>

[ Upstream commit 04bdb1a04d8a2a89df504c1e34250cd3c6e31a1c ]

Route bfqg_stats_add_aux() time accumulation into the destination
stats object instead of the source, aligning with other stat fields.

Reviewed-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: shechenglong <shechenglong@xfusion.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of Commit: block,bfq: fix aux stat accumulation destination

### 1. COMMIT MESSAGE ANALYSIS

The commit message clearly indicates this is a bug fix: "fix aux stat
accumulation destination". It describes that `bfqg_stats_add_aux()` was
routing time accumulation into the wrong destination (source instead of
destination). The fix aligns this field with all other stat fields in
the same function.

- Has `Reviewed-by: Yu Kuai` - BFQ subsystem expertise
- Signed off by Jens Axboe (block subsystem maintainer)

### 2. CODE CHANGE ANALYSIS

The change is a single-line fix in `block/bfq-cgroup.c`:

```c
- bfq_stat_add_aux(&from->time, &from->time);
+       bfq_stat_add_aux(&to->time, &from->time);
```

**The Bug:** The function `bfqg_stats_add_aux()` is documented with `/*
@to += @from */` - it should add stats FROM source TO destination. The
buggy line was adding `from->time` to itself (`&from->time,
&from->time`), which is clearly wrong.

**Root Cause:** A simple typo - `from` was used instead of `to` for the
first argument.

**Pattern Evidence:** Looking at surrounding code, every other line
follows the correct pattern:
- `blkg_rwstat_add_aux(&to->merged, &from->merged)`
- `blkg_rwstat_add_aux(&to->service_time, &from->service_time)`
- `bfq_stat_add_aux(&to->avg_queue_size_sum, &from->avg_queue_size_sum)`
- etc.

Only `time` had the incorrect `&from` as the first argument.

### 3. CLASSIFICATION

- **Bug type:** Logic error (typo) causing incorrect stat accumulation
- **Category:** Clear bug fix - not a feature, not a cleanup
- **Subsystem:** BFQ I/O scheduler cgroup support (debug statistics)

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed:** 1 line, essentially a single character change
  (`from` → `to`)
- **Files touched:** 1 file
- **Risk level:** Extremely LOW
- **Code location:** Under `CONFIG_BFQ_CGROUP_DEBUG` - debug statistics
  only

This is about as surgical as a fix can get. Even if the fix were somehow
wrong (which it clearly isn't), it only affects debug statistics output,
not actual I/O scheduling behavior.

### 5. USER IMPACT

- **Affected users:** Those using BFQ I/O scheduler with cgroup
  debugging enabled
- **Symptom:** The `time` statistic would be lost (not transferred to
  parent) when a BFQ cgroup is destroyed, causing inaccurate cumulative
  statistics
- **Severity:** Low to moderate - affects accuracy of debug/monitoring
  data, not data integrity or system stability

### 6. STABILITY INDICATORS

- Reviewed by Yu Kuai (BFQ expert)
- Accepted by Jens Axboe (block maintainer)
- Trivially correct fix - the pattern is obvious from surrounding code

### 7. DEPENDENCY CHECK

- **Dependencies:** None - this is a self-contained fix
- **Affected code existence:** BFQ cgroup code has existed in stable
  trees for years
- **Clean backport:** Should apply cleanly to any kernel with BFQ cgroup
  support

### VERDICT

**Pros:**
- Obviously correct fix (typo/copy-paste error)
- Minimal change (1 line)
- Zero regression risk
- Fixes incorrect behavior in statistics accumulation
- Well-reviewed and accepted by maintainers
- No dependencies on other commits

**Cons:**
- Only affects debug code (`CONFIG_BFQ_CGROUP_DEBUG`)
- Low-impact bug (statistics accuracy, not data/system integrity)

This commit meets all stable kernel criteria:
1. ✅ Obviously correct - trivially evident typo fix
2. ✅ Fixes a real bug - stats were accumulated to wrong destination
3. ✅ Small and contained - single line change
4. ✅ No new features - pure bug fix
5. ✅ Should apply cleanly to stable

While the impact is limited to debug statistics users, the fix is so
trivially correct and low-risk that there's no reason not to backport
it. Users relying on BFQ cgroup statistics for monitoring or debugging
would benefit from accurate data.

**YES**

 block/bfq-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fb9f3533150..6a75fe1c7a5c 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -380,7 +380,7 @@ static void bfqg_stats_add_aux(struct bfqg_stats *to, struct bfqg_stats *from)
 	blkg_rwstat_add_aux(&to->merged, &from->merged);
 	blkg_rwstat_add_aux(&to->service_time, &from->service_time);
 	blkg_rwstat_add_aux(&to->wait_time, &from->wait_time);
-	bfq_stat_add_aux(&from->time, &from->time);
+	bfq_stat_add_aux(&to->time, &from->time);
 	bfq_stat_add_aux(&to->avg_queue_size_sum, &from->avg_queue_size_sum);
 	bfq_stat_add_aux(&to->avg_queue_size_samples,
 			  &from->avg_queue_size_samples);
-- 
2.51.0



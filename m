Return-Path: <cgroups+bounces-12690-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4BACDD2B9
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 02:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A5F730065AB
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 01:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D4D1F4CB3;
	Thu, 25 Dec 2025 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvHowpI1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9793C2A1B2;
	Thu, 25 Dec 2025 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766624959; cv=none; b=nc4PZD1Svd+XGcsyoIjFrSvMiU4M85UeRIgqfKdz5rL7wBhcrXxiUMRCrycbQsZw3c/dDH9A3XP27BimnCf+bd+hy8b4ZgGfzkR2XMQf0MrC4CKYdLmOzNzQSaUTfw3rHcbIX9VVOZK0EDXQxTHlgyGz1rktiUKd+DFYpjxYALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766624959; c=relaxed/simple;
	bh=atWqVlWPztPoWYujNROViEXfGrgp/U62OsSEy8tkX3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzUGlJ6ek2GfAiwaIJHvIPtEeczE88h+4N7dcUEMC2LN42cqd0yqrMOr5Ee964KQWUeJ/VNk8A5l0H0VIZblzB/tK2ZELYeul+dTcIDZRQ+EkKzG3SlZ6QQUshPaKw9IeGXRynQgFPz9HM8Z/gFoTByuKHL4T+gAgdS2E/6Gpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvHowpI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCBBC4CEF7;
	Thu, 25 Dec 2025 01:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766624959;
	bh=atWqVlWPztPoWYujNROViEXfGrgp/U62OsSEy8tkX3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mvHowpI159bC3FUzbJxJyAsjQqUBJVErhgJe73iBenOlg30DvBSdeH4J/pPUKaKqG
	 7SQTcEvF+ja8qWAxLYL3SJCHpYs5wC/buIYAqrabvzJkeHvWAIAAiDYVVuNdD+nTvq
	 pI1UblYcF4DBJLR3qNQXsFBJkBY53EvzpZO4lo3EzSQCfa98cDDTbrl/uN+1X8bFpg
	 IS/wMs+P+l1nMvj1U65XcTrD+iJtu3xKU2nzF/s7bpettmU9wJvvzS+OoV1mV3kYby
	 Whtfp3LuI+3LKPkcvuGIHBbcLl025E0qcUEVFd2HX+YMlx8M1aok1Pgiv/KMU3dj5n
	 3LywKB2PguV0w==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] mm/damon/core: get memcg reference before access
Date: Wed, 24 Dec 2025 17:09:14 -0800
Message-ID: <20251225010915.14866-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251225002904.139543-1-shakeel.butt@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Dec 2025 16:29:04 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> The commit b74a120bcf507 ("mm/damon/core: implement
> DAMOS_QUOTA_NODE_MEMCG_USED_BP") added accesses to memcg structure
> without getting reference to it. This is unsafe. Let's get the reference
> before accessing the memcg.
> 
> Fixes: b74a120bcf507 ("mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> ---
> Changes since v1:
> - Changed the subject as requested by SJ.

Thank you, Shakeel!


Thanks,
SJ

[...]


Return-Path: <cgroups+bounces-10451-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB13B9F95E
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 15:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094BE4E4C58
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCF2261B94;
	Thu, 25 Sep 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgrO8NGZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F43230D1E;
	Thu, 25 Sep 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807196; cv=none; b=RhcWXtr/OYeO2GlIoRqbiZgIaM7eu9xYVlbKfHDS9x/QbMFutIsvhqw8GTBXsiRWlQA8zR8h0l3Bs8kr4FRIaASWe4j/yo4NWjBlQY9tEgdTEeLs5dlSfQycI/64NX1AcUkwuPR6Eol4bRV94DOeSyLcsDU+GqMbfnwcFie8fVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807196; c=relaxed/simple;
	bh=wjriDi598cbHvL0FHK+c0DDXmoMdDEm35C7AQyt1pbA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BEaGIy6JOIDwd9/3AoT/HgMmLhdC+m2wHnxdCjP5BfbUgBPYFNeqv28eFE+0TbGBQXIZ0CAVYN7a+8GDq1fiBVSXG++vwzXKB7MRr/BtJsdB4+5+4vPQBJ3ysU4RfZvpoMVo9mENfKqks1CXzIFGOmvjAWvSdunHd6f0/vMV5Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgrO8NGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B5CC4CEF0;
	Thu, 25 Sep 2025 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758807196;
	bh=wjriDi598cbHvL0FHK+c0DDXmoMdDEm35C7AQyt1pbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YgrO8NGZCZcHji+EammpDndoXMerNwi7orZ7M8Mz151WGxr4ZGI+YIqAOYwhUk9Me
	 /XI42gu6oR7hNTz6fL+Eu4z47fzQp2HOi/Stl7K8RzJB7AIduo0jci3FtOThbXMHX2
	 i44IefRwT8XRmC5ur3wAMsfH7mZ4refLCqhevsKMIR1DpwDA5WUNw0vZdVxPucoEgL
	 M9+zpJpSfK+bH0CWN0q7jveBM//Va6V8f/vfXbwepIDuwmeV/zYpyntA5qvXAGT3zB
	 cOIMjqOAvCIgOGe1JOgbUfRv92CfJWH1zgPtWKoqhqbxzh8F6lemPR79l7HCKC0dza
	 kZSQtc7RLrWFg==
Date: Thu, 25 Sep 2025 22:33:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, lance.yang@linux.dev, mhiramat@kernel.org,
 yangyicong@hisilicon.com, will@kernel.org, dianders@chromium.org,
 mingo@kernel.org, lihuafei1@huawei.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, tj@kernel.org, peterz@infradead.org
Subject: Re: [PATCH v2 1/2] hung_task: Introduce touch_hung_task_detector().
Message-Id: <20250925223310.66e769299f7d07491578151d@kernel.org>
In-Reply-To: <20250924034100.3701520-2-sunjunchao@bytedance.com>
References: <20250924034100.3701520-1-sunjunchao@bytedance.com>
	<20250924034100.3701520-2-sunjunchao@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 11:40:59 +0800
Julian Sun <sunjunchao@bytedance.com> wrote:

> In the kernel, long waits can trigger hung task warnings. However, some
> warnings are undesirable and unnecessary - for example, a hung task
> warning triggered when a background kworker waits for writeback
> completion during resource cleanup(like the context of
> mem_cgroup_css_free()). This kworker does not affect any user behavior
> and there is no erroneous behavior at the kernel code level, yet it
> triggers an annoying hung task warning.
> 
> To eliminate such warnings, this patch introduces
> touch_hung_task_detector() to allow some tasks ignored by hung task
> detector.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Suggested-by: Lance Yang <lance.yang@linux.dev>
> ---
>  include/linux/nmi.h |  2 ++
>  kernel/hung_task.c  | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index cf3c6ab408aa..61fc2ad234de 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -59,8 +59,10 @@ static inline void touch_all_softlockup_watchdogs(void) { }
>  
>  #ifdef CONFIG_DETECT_HUNG_TASK
>  void reset_hung_task_detector(void);
> +void touch_hung_task_detector(struct task_struct *t);
>  #else
>  static inline void reset_hung_task_detector(void) { }
> +static inline void touch_hung_task_detector(struct task_struct *t) { }
>  #endif
>  
>  /*
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 8708a1205f82..6409d3d4bd36 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -184,6 +184,11 @@ static inline void debug_show_blocker(struct task_struct *task)
>  }
>  #endif
>  
> +void touch_hung_task_detector(struct task_struct *t)
> +{
> +	t->last_switch_count = ULONG_MAX;
> +}
> +
>  static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  {
>  	unsigned long switch_count = t->nvcsw + t->nivcsw;
> @@ -203,6 +208,10 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  	if (unlikely(!switch_count))
>  		return;
>  
> +	/* The task doesn't want to trigger the hung task warning. */
> +	if (unlikely(t->last_switch_count == ULONG_MAX))
> +		return;
> +
>  	if (switch_count != t->last_switch_count) {
>  		t->last_switch_count = switch_count;
>  		t->last_switch_time = jiffies;
> @@ -317,6 +326,10 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>  		    !(state & TASK_WAKEKILL) &&
>  		    !(state & TASK_NOLOAD))
>  			check_hung_task(t, timeout);
> +		else if (unlikely(t->last_switch_count == ULONG_MAX)) {
> +			t->last_switch_count = t->nvcsw + t->nivcsw;
> +			t->last_switch_time = jiffies;
> +		}
>  	}
>   unlock:
>  	rcu_read_unlock();
> -- 
> 2.39.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


Return-Path: <cgroups+bounces-10343-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2094DB914AE
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 15:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A2054E0F29
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DAF30AACB;
	Mon, 22 Sep 2025 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b7Xag655"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FA309F0E
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546434; cv=none; b=U/E+Qw9WdNt4pXYvwp/uVN1u+aJMvPMasRLv9aoRn9l9zgwpXEj4C7EQKavvv6g26FaXbfVuJdgrXKJgcWULIssSi9B0tsQNqNwrZxr0ptfH8NWxaNUGmIjOluu5XeJyr7cZlktm/WpZPsyoe2tfDWTOTb0Er57G6qYfWHVphYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546434; c=relaxed/simple;
	bh=zv879v8IpLvhbadVbPUjTIXbDPFELh7WD4HC8x/76us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAbAW2w7iE82gbffXn9uu197caV961Mr0KY5UnaCLHpMLNheKkgloB8+Hx91bQURV22Vc12a2DqiBLUdkv1fNZYcrsXdURbG/8gKCdZ8zKnOk04aSeKHHwclXDH1ek2pB2uoaNqeMFHUdhbS2u+VS4Lc9aVb59ouIaQ1SEow0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b7Xag655; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fc14af3fbso6433197a12.3
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758546430; x=1759151230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V5I0E6zUKzQLaX/EzSWa7WfLXYyAGyIhbG839ROFjSY=;
        b=b7Xag655ujxeaHHd0nYiQRUs9TVEYWKtYCm00NYFkGsKq2edg4tYdqcnkIkyZtxGjO
         tkduQ+yHkBBhUZUWYzNDfE3j/osAwZWmr78spqrMi11jhNo5lVk+hjom8Ue3xz2tbQUu
         UUWp0DMQjf6QGUgbSFUVLquCOA64Jvu/DJzItbpvSLBbCxbr3n9UCqbkTgfSMnHDrZnQ
         ule8MLzVLhbgz6FWT+lyEnb5gWVWjIdFzte8sybPZOVQLFv5u2CkSmw0GAns9C0XbBPg
         SZBO1JQNlIfCkcqJlz0Tlnjdai9MqpHiisDN7igKuPU2g4zPXLmAe4WRCLZaxwN5Cs/m
         8bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546430; x=1759151230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5I0E6zUKzQLaX/EzSWa7WfLXYyAGyIhbG839ROFjSY=;
        b=Jyqv49b+9bZZxndggvhdTaxinMUHbqX1awtLMrjfPhfqBpM+qa7c5JdnjYgggwdWCc
         a4X8zDGxYHjue4CmKT0pHnYvmqYaO+yE2Zfo35ov7M/FCdsTIDxDi0MwOvXxQCGEvJkW
         osUQIYcjJ94TQAhYag0hYgnkQQHtHeG4zJeO3z3dMai6nlRfSOYtCUtmQvPnKHCBJY0N
         ZbDZdOjpmEJ1098HFvPrKHmiHIMve46TghGBkxcMaKL04qmvnBH5uLpG5kuaXFpw3N4t
         p7sQ4R1J9OtLxWcBjtyul0jbsdABSSwCufnLTZWLczlhRQ3zhGwB6B2qEqoGfBibFPtp
         EMgQ==
X-Gm-Message-State: AOJu0YwWXGmicWAG32fLfS8SAekIaqGvQMQl3DcLfVOq92vfQ3L0tSP5
	Gpe2oZH+Q2aAL4pDq1kXun76QmLKv75TJU4lo+4FuGn5hEbtrtTvcpH7It5ONOkQsL4=
X-Gm-Gg: ASbGncsizevkL3KjE6pj4CpL60qHI+iExMA/o5ziSDWX9mtOxJ8j+OCbkV1+iaMOLT/
	bgRS2w1aYewCqi3w7uQH1kckZYsFZi12IZI62zxtZLien8FsH1Wcju1Gwf11tJnG4zmdpYP4Kxh
	rE2gYbZB86Y96Tm33FfnLOERlV6MkPGSnh6U0rUwkjFY9vSjADYsrwtEqYqI7+PuiuQaodQCTwK
	GqHzfyQ2buEVuznouowHF+ljBTajutlW2M2WNCPXMRzdta7ZR2Z+qDpz28tRpXukHS0u34uDEyt
	0M9osn6Tgm78EvP8Hbf76FJAsJFlfVfaSwfbKutTY6lwBugY5lrui8CEmT0sK7hOgEFQf/Ab2z4
	KsdXS5lq4HtwGioe2GKdLORioa5ii6NhZ0Q==
X-Google-Smtp-Source: AGHT+IHjQTvK8GvwSXsCGHP+yjQ8SIPT2LP8nwGDGqdQKPBmQ+zHQYGgHfCPA13wqo8OaxL+Zcu3vg==
X-Received: by 2002:a05:6402:5212:b0:634:4d7b:45c2 with SMTP id 4fb4d7f45d1cf-6344d7b4f0bmr1491168a12.0.1758546429819;
        Mon, 22 Sep 2025 06:07:09 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62fa5f4173csm9072355a12.49.2025.09.22.06.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:07:09 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:07:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, akpm@linux-foundation.org,
	lance.yang@linux.dev, mhiramat@kernel.org, agruenba@redhat.com,
	hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Message-ID: <aNFJ_EKj4fnRDg1_@tiehlicka>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922094146.708272-1-sunjunchao@bytedance.com>

On Mon 22-09-25 17:41:43, Julian Sun wrote:
> As suggested by Andrew Morton in [1], we need a general mechanism 

what is the reference?

> that allows the hung task detector to ignore unnecessary hung 
> tasks. This patch set implements this functionality.
> 
> Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will 
> ignores all tasks that have the PF_DONT_HUNG flag set.
> 
> Patch 2 introduces wait_event_no_hung() and wb_wait_for_completion_no_hung(), 
> which enable the hung task detector to ignore hung tasks caused by these
> wait events.
> 
> Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of memcg 
> teardown to eliminate the hung task warning.
> 
> Julian Sun (3):
>   sched: Introduce a new flag PF_DONT_HUNG.
>   writeback: Introduce wb_wait_for_completion_no_hung().
>   memcg: Don't trigger hung task when memcg is releasing.
> 
>  fs/fs-writeback.c           | 15 +++++++++++++++
>  include/linux/backing-dev.h |  1 +
>  include/linux/sched.h       | 12 +++++++++++-
>  include/linux/wait.h        | 15 +++++++++++++++
>  kernel/hung_task.c          |  6 ++++++
>  mm/memcontrol.c             |  2 +-
>  6 files changed, 49 insertions(+), 2 deletions(-)
> 
> -- 
> 2.39.5

-- 
Michal Hocko
SUSE Labs


Return-Path: <cgroups+bounces-10338-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D9EB9127E
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 14:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BDC4202BE
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA5130AAC8;
	Mon, 22 Sep 2025 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JIWNC9vW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE7308F23
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544829; cv=none; b=cMLIPG3+ffeNAsFcSgbU5LBbElyD6xjrJia9x8zCsNXcbyC/QDEFfifF/EONfq51bc/GOzz3g33vrgmKS8zVPHclcieJ0ZVPFPWT/TFG4SyZhZb8ESIKFFd8yZvNTiBG1I80PT3ufs28yIaudLeoym8cF2OaU1fK4nI/jAYqx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544829; c=relaxed/simple;
	bh=oLCLpX2jtMBtuMbPjtYboKL7moJwuIOjpinv3gJLa8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOlYj3gGEcZIT+httFXMDDGhNjsFhISrZrIPDbvvi0J+4lIuJZ1q49ZFcR44oBE+16kAZRBZXxvgN6nklsnQ1vtfvywFvdN+ObiSP33UL5N8M5dChuC3Hfh7mK/mGMdXdqPn67eajHyUtx8OJtKf9XkbSTHtNQPV3IE90PrKvCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JIWNC9vW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b555b0fb839so155333a12.3
        for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758544827; x=1759149627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RdyyD1EXBlvIemsVmbrmNlfheta51vslsx7KshN1DY=;
        b=JIWNC9vWKgq4nJ4XGZi+fLxUA7972ER4xbpiw1wdSiQt/xQVsbuRznugYEUa90+ucv
         0ZSR4QsJq3Sp4n1xMAsuO1vsritkMSfdJVWafay0mc5hgnbakceN5gFTQfyoFqy0RFNb
         DfIgEmgLxplEHXMsXO7QYFRBq0GInJYD6bne/Z46WhrtK1PvhS6oNcgXaiM2xC9HOUPK
         rX5hSgfZ05NPDxUeCOCYj293GRgxjwdMuchbVNcQA5CmYxAdVjbAVRGEmrbCzKeTdRsm
         UThbeKOw1xZ15eo5ca+hyFN2152Y/VvHdhOFSLUP/2nnPkijbwbgtKOmeNYiwHBeASWO
         3nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758544827; x=1759149627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/RdyyD1EXBlvIemsVmbrmNlfheta51vslsx7KshN1DY=;
        b=tj5IuhVMp7SrWNd2MIoQRscWRKK3sHy7Ev/ZktSx2Xf2bYzAr9Yn3+VOVHprtuhPAH
         hybSHjr4PPhmKtKF3bkAN/pNa7Ycr6lhQU6wLDmSMIzL6nCkn5gSr4pn0eQs1+dAMi+R
         RZZQiGO2CAeRky2X2mRTijNO1CbtkWw+ZOfKwCWW9Bkiwli1BJCj6bx2ETKbKhyo0bsW
         gLMtFTkShFTbJj7938N+Lc3VWhqzVn/8uMNLwZ/doEYkKGSwC8FerSgM/V98RhOjCidz
         rQoI9qaJc3r2iTPLrDkpg64dQlxYu2MSPjHWr360ZfoczOSEqj3UmgsvHNfwmVQIXfN1
         D/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXM8zNjB/u2mTUQTbLcr9kCvpZDSepGPtcqll6ppLh/de0xY/lkPslTLgRNkZK7jujOwQeILYt6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx85oILv8zbDcdpTwUUomrLAJTxYsBE2SuRSAMBn2C22fy42IM
	2+p0a10kuKqAZ5OsS+XZBkWMaBJasmSDkwQ1wtglL8InpdSi/Pn3DpvDH8bLQrdDbW8=
X-Gm-Gg: ASbGncsqLSL8EfXQY9LEHIaM660LjNWNh1HGsOJBbb5hWGPIFoP3IcjjIkpbT/RgUGP
	PhcIGEEn78ECFh+O6rInRK6fGUgHaHUEjeuuYz1eiIsQU4904dTieqfG2m0f1rIIJULWBxwCsye
	E9jxqg0fiYaI0cx+r2uG/hKVuerAs0qcl5oxHICIaoWNbdXt+C8JqqLUy2lGe/2QbeKbw9C9GuP
	Lbjgj5EsNi08Ay9Fn3517OcVPkl1jl23Mks626GEll1eg48TCaRP2rmVZLgy7TFmQSQl3rx4j9L
	vDKw5ndcLfefnd5ood9cvmtgy2VpqWN0W9LzqMhoUkXIwB4XqeWGUv7dsNvWKR+V90SKQeLX+uP
	vZad6Qbz9sxiEHl92cz1E/fdG34GKPDY1CBBUge77HBNL4+XYhAR2mobjtWNhqJ3IWAIP3eqAG1
	SH7Q==
X-Google-Smtp-Source: AGHT+IEGBrT3SnJhTkV8mglXja6cN7Am5iY4FgOJYWx37m7MRPV6ezOU1/PoiKvENYX09R5NpTy6hA==
X-Received: by 2002:a17:902:bd87:b0:250:5ff5:3f4b with SMTP id d9443c01a7336-269ba467e97mr116112925ad.15.1758544826621;
        Mon, 22 Sep 2025 05:40:26 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980179981sm131280655ad.54.2025.09.22.05.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 05:40:26 -0700 (PDT)
Message-ID: <fd12dd70-5de8-43bb-a4d8-610b5f5251fa@bytedance.com>
Date: Mon, 22 Sep 2025 20:40:15 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
To: Lance Yang <lance.yang@linux.dev>, mhiramat@kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 akpm@linux-foundation.org, agruenba@redhat.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
 <b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/22/25 7:38 PM, Lance Yang wrote:

Hi, Lance

Thanks for your review and comments.

> Hi Julian
> 
> Thanks for the patch series!
> 
> On 2025/9/22 17:41, Julian Sun wrote:
>> As suggested by Andrew Morton in [1], we need a general mechanism
>> that allows the hung task detector to ignore unnecessary hung
> 
> Yep, I understand the goal is to suppress what can be a benign hung task
> warning during memcg teardown.
> 
>> tasks. This patch set implements this functionality.
>>
>> Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will
>> ignores all tasks that have the PF_DONT_HUNG flag set.
> 
> However, I'm concerned that the PF_DONT_HUNG flag is a bit too powerful
> and might mask real, underlying hangs.

The flag takes effect only when wait_event_no_hung() or 
wb_wait_for_completion_no_hung() is called, and its effect is limited to 
a single wait event, without affecting subsequent wait events. So AFAICS 
it will not mask real hang warnings.>
>>
>> Patch 2 introduces wait_event_no_hung() and 
>> wb_wait_for_completion_no_hung(),
>> which enable the hung task detector to ignore hung tasks caused by these
>> wait events.
> 
> Instead of making the detector ignore the task, what if we just change
> the waiting mechanism? Looking at wb_wait_for_completion(), we could
> introduce a new helper that internally uses wait_event_timeout() in a
> loop.
> 
> Something simple like this:
> 
> void wb_wait_for_completion_no_hung(struct wb_completion *done)
> {
>          atomic_dec(&done->cnt);
>          while (atomic_read(&done->cnt))
>                  wait_event_timeout(*done->waitq, !atomic_read(&done- 
>  >cnt), timeout);
> }
> 
> The periodic wake-ups from wait_event_timeout() would naturally prevent
> the detector from complaining about slow but eventually completing 
> writeback.

Yeah, this could definitely eliminate the hung task warning complained here.
However what I aim to provide is a general mechanism for waiting on 
events. Of course, we could use code similar to the following, but this 
would introduce additional overhead from waking tasks and multiple 
operations on wq_head—something I don't want to introduce.

+#define wait_event_no_hung(wq_head, condition) \
+do {                   \
+       while (!(condition))    \
+               wait_event_timeout(wq_head, condition, timeout); \
+}

But I can try this approach or do not introcude wait_event_no_hung() if 
you want.>
>>
>> Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of memcg
>> teardown to eliminate the hung task warning.
>>
>> Julian Sun (3):
>>    sched: Introduce a new flag PF_DONT_HUNG.
>>    writeback: Introduce wb_wait_for_completion_no_hung().
>>    memcg: Don't trigger hung task when memcg is releasing.
>>
>>   fs/fs-writeback.c           | 15 +++++++++++++++
>>   include/linux/backing-dev.h |  1 +
>>   include/linux/sched.h       | 12 +++++++++++-
>>   include/linux/wait.h        | 15 +++++++++++++++
>>   kernel/hung_task.c          |  6 ++++++
>>   mm/memcontrol.c             |  2 +-
>>   6 files changed, 49 insertions(+), 2 deletions(-)
>>
> 

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>


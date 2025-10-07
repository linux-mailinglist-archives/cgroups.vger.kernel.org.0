Return-Path: <cgroups+bounces-10577-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47327BC0EE6
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 11:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28D3D4F411E
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F2B257844;
	Tue,  7 Oct 2025 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmaUOTHZ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E1FF9D6
	for <cgroups@vger.kernel.org>; Tue,  7 Oct 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830866; cv=none; b=Pdg5gLTPE0naxJkbAKSDzgCWp3dMPNqSnbWRwQbF2Ui5ny/T+CuxiZcW464u1zpWULClvAYDDwPe8Lrv1z5wonPFriYRQe7mMX8FIyQDpxgbWTAZ9p8JfVbOYixYoHKddg6OKbuBG04pG9BNTl4KvPLVWkP2zWn3WKoO0vq6cgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830866; c=relaxed/simple;
	bh=U/DiYplYwAEDQ0sSvEmC0Falh8sTDF6ELFWedBoYj5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zmfub8IVtOF1/z7x3vUSAMgBBjGcGKEAt96d5Sq7TD8uj0+N6bIToLmY4BYCUkVH3a6M1essHLDb4W63h18buDhuBcRq9A2bAW/Dr0E0YefeGhBgUBI1yKB6KupcIZCweoYG6B+PStxMbkBbEwQRtKe+Scss8NeDcnQLQhAcRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gmaUOTHZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759830863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0ukjdOyTbIVpXUnl0KJJD0YmKPrBUCxZHTQ8ntUf9E=;
	b=gmaUOTHZAxR+aFyIml0+4Lbm4stsuKrRpRWKSWy0QbiGz29gdk6ecKerlNG9KoqJ4yYMgD
	ek9lcj26J2Fu9VOVpm19Lec3ZYIr3tKC1Zc8CXiNIqvIEYaC4sUTVcLkIhdrMWNYUKsq38
	ubrM4LJGTFZo+I4AIZFEsRxKRGYQGS0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-uZRv7VEFOq22TnPaR_0dJw-1; Tue, 07 Oct 2025 05:54:22 -0400
X-MC-Unique: uZRv7VEFOq22TnPaR_0dJw-1
X-Mimecast-MFC-AGG-ID: uZRv7VEFOq22TnPaR_0dJw_1759830861
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e38957979so22405275e9.3
        for <cgroups@vger.kernel.org>; Tue, 07 Oct 2025 02:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759830861; x=1760435661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0ukjdOyTbIVpXUnl0KJJD0YmKPrBUCxZHTQ8ntUf9E=;
        b=hX0fJEPkfX8C2YOdBwE7D2T7hHstGAYL1aoiz4JsCPyB9qyI/d411+N7GV/JehTWSa
         d7iHkkzAveW8hjL/aleE9EtKy4WDI1fkGGmE9K4VXW5Kisl1e6JBKbg8l0lhU29GAuMR
         kllHT0oDsGyTqyAS1IqHELWQEtSDa7mRE+9czyQSGxzvZfDCiYlWKlVkvPvYTvRyDbmf
         iwszn3tAWBXy4OOP3pBuFLmU/jPUqDU/L7rsVVVzQhPdNIArYJOsgzEjbZjW/EXoENEw
         /YS23w9abekuGYUkTEerl8a7tubliGjGru6bHk3ccc3qpyJ3qpcznbHO8CSERnAn9w9M
         txYw==
X-Forwarded-Encrypted: i=1; AJvYcCV/fAoj9HybcpEGiiK37igfnyhGo6NsGZMOflNrIWmD7xk3XVjkEebXxSQEB7aOYI2hhwlzAWP7@vger.kernel.org
X-Gm-Message-State: AOJu0YyjhAaM2ZYNgJkRz5nOsGfpiVLNqFhl8rifXcC3JvsQdlL4U8SF
	DhC4KbgL8shbPUal35CzNCxd5IfI7AVZTWwhBbBUU0fvV9+h5rC6kNx6IJbI3mr4TeXwz5Rz/wj
	rKMH6qGZxAnDvaZWggCGjExLS43+kq+DNgdhgU2AAAwFNZXzMid3gW7l9JzA=
X-Gm-Gg: ASbGncs66xn5rUNsSl3qYEIU2f4/uQVUKYCUiE6vYR+2pO+WDPFK27Nl2hy9hobYxlX
	bgoK7jShcEmMgjbpMc1+Heou3q/VicuRFIbinLGhjfFMJ9FR+oOgRU1TTqN+Kr1W1CCwY0W0BGv
	Mo0hONcTawTohHQsUHedEHKshwXIo8ZmHy0RcMgAoswuWbEdfJFHvxuwcoCYbhf4FHyU0yh9WGr
	LQG0VzmptfHJyHv0K/Eztl+c+kBX7F340wjIRZCCLTkMbWlYSSWBUogz0wDSz7LtssWfj/hMd31
	7n2GmXnv/LZ4DalOikafuN0AoZdYgc4KV8EMhtGHnIT7w9p4SU7/tkapR9/WDq6QeeFSzxnnBI9
	bRQ==
X-Received: by 2002:a05:600c:154d:b0:46e:6c40:7377 with SMTP id 5b1f17b1804b1-46f9bb3fd36mr47610705e9.35.1759830861054;
        Tue, 07 Oct 2025 02:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS0VPrl4ggx5+ULavzMXJENjXtwRIeiQWoxBnhFL2h5ZR3YiycuAomMDj1/PqSGaQ8uE5JBg==
X-Received: by 2002:a05:600c:154d:b0:46e:6c40:7377 with SMTP id 5b1f17b1804b1-46f9bb3fd36mr47610485e9.35.1759830860568;
        Tue, 07 Oct 2025 02:54:20 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.135.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723591fcsm197344675e9.10.2025.10.07.02.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:54:20 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:54:18 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 10/12] sched: Add locking comments to sched_class methods
Message-ID: <aOTjSla1Yr3kz7op@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.694841522@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006104527.694841522@infradead.org>

Hi Peter,

On 06/10/25 12:44, Peter Zijlstra wrote:
> 'Document' the locking context the various sched_class methods are
> called under.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

...

> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2345,8 +2345,7 @@ extern const u32		sched_prio_to_wmult[40
>  /*
>   * {de,en}queue flags:
>   *
> - * DEQUEUE_SLEEP  - task is no longer runnable
> - * ENQUEUE_WAKEUP - task just became runnable
> + * SLEEP/WAKEUP - task is no-longer/just-became runnable
>   *
>   * SAVE/RESTORE - an otherwise spurious dequeue/enqueue, done to ensure tasks
>   *                are in a known state which allows modification. Such pairs
> @@ -2359,6 +2358,11 @@ extern const u32		sched_prio_to_wmult[40
>   *
>   * MIGRATION - p->on_rq == TASK_ON_RQ_MIGRATING (used for DEADLINE)
>   *
> + * DELAYED - de/re-queue a sched_delayed task
> + *
> + * CLASS - going to update p->sched_class; makes sched_change call the
> + *         various switch methods.
> + *
>   * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
>   * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
>   * ENQUEUE_MIGRATED  - the task was migrated during wakeup

Not for this patch, but I wondered if, while we are at it, we wanted to
complete documentation of these flags. My new AI friend is suggesting
the following, is it very much garbage? :)

Thanks,
Juri

---

From: Claude <claude-sonnet-4-5@anthropic.com>
Date: Mon, 7 Oct 2025 12:44:13 +0200
Subject: sched: Document remaining DEQUEUE/ENQUEUE flags

Complete the flag documentation by adding descriptions for the three
previously undocumented flags: DEQUEUE_SPECIAL, DEQUEUE_THROTTLE, and
ENQUEUE_INITIAL.

DEQUEUE_SPECIAL is used when dequeuing tasks in special states (stopped,
traced, parked, dead, or frozen) that don't use the normal wait-loop
pattern and must not use delayed dequeue.

DEQUEUE_THROTTLE is used when removing tasks from the runqueue due to
CFS bandwidth throttling, preventing delayed dequeue to ensure proper
throttling behavior.

ENQUEUE_INITIAL is used when enqueueing newly created tasks in
wake_up_new_task(), allowing the fair scheduler to give them preferential
initial placement (half vslice when PLACE_DEADLINE_INITIAL is enabled).

Signed-off-by: Claude <claude-sonnet-4-5@anthropic.com>
Not-so-sure-yet: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/sched.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c222fa8f908..1a2b3c8d9e4f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2364,10 +2364,20 @@ extern const u32		sched_prio_to_wmult[40];
  * CLASS - going to update p->sched_class; makes sched_change call the
  *         various switch methods.
  *
+ * DEQUEUE_SPECIAL - task is in a special state (STOPPED, TRACED, PARKED,
+ *                   DEAD, FROZEN) that doesn't use the normal wait-loop;
+ *                   disables delayed dequeue.
+ *
+ * DEQUEUE_THROTTLE - dequeuing due to CFS bandwidth throttling; disables
+ *                    delayed dequeue to ensure proper throttling.
+ *
  * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
  * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
  * ENQUEUE_MIGRATED  - the task was migrated during wakeup
+ * ENQUEUE_INITIAL   - enqueuing a newly created task in wake_up_new_task();
+ *                     fair scheduler may give preferential initial placement
+ *                     (e.g., half vslice with PLACE_DEADLINE_INITIAL).
  * ENQUEUE_RQ_SELECTED - ->select_task_rq() was called
  *
  */



Return-Path: <cgroups+bounces-9071-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8371EB20BAC
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 16:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F02A7890
	for <lists+cgroups@lfdr.de>; Mon, 11 Aug 2025 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973DF22652D;
	Mon, 11 Aug 2025 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O46E3yqr"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2562224B0C
	for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921919; cv=none; b=Uc95Xfq/wGNSyjNUSbJEzbGtcAAlQUAbS594vnTyJJsW0slImSKhqD6klBYFqbyeXOjtT1JzD5PCwQBN52HDSutKcLbC+Od/4u5dknrpmkcGNrbw/TxTiuSdtt3OSaPoHxM3vVTfgxAETc2ivUrna/hW8rdLQABwgBul6dQzU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921919; c=relaxed/simple;
	bh=fLFqwIZV2uYlQb+YviFhY9gzykROzOF8Yh8va2JTzPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QwZZt0s7Lp7Dse9GZiTdXIzffhr0YJQ/KR+ZqYMj91vKkTluVyKpSkEJhXVHEDg9pstFcGbYcumGxypoXSD1tybuMiYaOZ+xZqyhNtXs4RiBH5U3rBykWGAXNzJTXbeq3mvOg9anc2tvEFhkFMoC7PndLy986Pbwpd1EClq0fPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O46E3yqr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754921916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fLFqwIZV2uYlQb+YviFhY9gzykROzOF8Yh8va2JTzPo=;
	b=O46E3yqrxN2FoH/MUyxuiTuCR6qEjKgbpjgwzeXXEwjY/vQ/lkYUjpaI3akScuzMsd6I6j
	z4ccNlrKU+G3/eGSosmfZF4MpA84ozs/jXyso92ahBKSDz6Jg+vFGjhnDYlL6WHR/dC/kD
	h5B4qQBHaWWXuanOF5EVDI7pBAn/CnY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-9UyVA6gdOHuQkBJhLHZYug-1; Mon, 11 Aug 2025 10:18:35 -0400
X-MC-Unique: 9UyVA6gdOHuQkBJhLHZYug-1
X-Mimecast-MFC-AGG-ID: 9UyVA6gdOHuQkBJhLHZYug_1754921914
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459dfbece11so22842745e9.2
        for <cgroups@vger.kernel.org>; Mon, 11 Aug 2025 07:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921914; x=1755526714;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLFqwIZV2uYlQb+YviFhY9gzykROzOF8Yh8va2JTzPo=;
        b=O9NubCrtG0fpPBh2dM7MnypACRjbQDbTcWOH/h9GOMWybVbx5iu3tP8+95XV23iag3
         9JrEWot0Aw6M/OqDPNBOnyH2gEY4dTovx5T/GKzHuzjOYU2ViDvD7tUsonENGdSnJ3S4
         FQCAKOJKYvjOMjZ/BFh+EzayuewHbyL+BjDQ2u5B7wdLXK74HTjDiQpBLb6BrFpLjVJJ
         mx/J//wiZvwR6AEP2sIr2LGOXPqgomyZhb656Gb/ntu0wA56b/3hFSp3nnzCiyzkuGy3
         C+/qu/yWpf7k9zhDDVGD74THrPtf4/nOsEVDta3SKsuuJPHahQkEVkDi/IoOqnwBthKR
         bojw==
X-Forwarded-Encrypted: i=1; AJvYcCWrYGuQQLc0IkIWIJHbcwCuoDOJqePIz+W7ZyHwZuZdwfXaUbJqiEDHxwWYV41DdV4ctl1tvUhn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1PgffNGYiDpeBnjXoJXPOnQdSefKxCZhNf94+JwZ4x04Ax0gF
	tbBaFbnn14syE/DcqKhDhLewWiZs9xXUJM+oyEMUKajj3RASQOUZiWLkE64v3yd0amSd5iAMx7m
	2oT6UnSlJ0kbUYxS8hSGmhl59ZSmahuB23OSKdOce8RzsatDFvgptxkWdALD9wRq4ovM=
X-Gm-Gg: ASbGncvTpu+d88ehSAyvMNmWdIp78efOAjYbDwgF36ykLgRBOIO/8RAknbI/+5UXStQ
	3Yo3IEH0RbcvrCl0PnBCJKIsvxIuNFa7TTXm7CNKO+hWxjADuiOxaUfbBO1J3vd79jitfqVKx0L
	wnbVvIHxKIaFNfhx45tTxiVHyEEBfMnMiQG561X8+5Vrjjz2eGtmNs+6IXk55LCnlhJg/d9P4cC
	bOWuFNLqer0WznH3Ba/gMc1nmpLBmR8vCLhPPoEY2v8A82nCnu4eBgHu99G87Gfr9GWamRAvGnu
	2H6/wahKVlB58NNmbaeCNsgjlP5aMwcNF+gVz8jI2MXtuBoj+Ei26gdJSSHLYUlInyk5lx/PTqK
	PNU2L+OuNEo8bHtXG+i5JT37r
X-Received: by 2002:a05:600c:15d1:b0:459:e025:8c5b with SMTP id 5b1f17b1804b1-459f60d2211mr84932605e9.30.1754921913864;
        Mon, 11 Aug 2025 07:18:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK7xe2jj9RDZcj2jypfYQ8QNxrGhvt+A2f3vSrNMfxeIGmWZ42MdaPGKXHKFv5KHpImfzFjg==
X-Received: by 2002:a05:600c:15d1:b0:459:e025:8c5b with SMTP id 5b1f17b1804b1-459f60d2211mr84932405e9.30.1754921913488;
        Mon, 11 Aug 2025 07:18:33 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459ebede65asm208975165e9.8.2025.08.11.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:18:32 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Xin Zhao
 <jackzxcui1989@163.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, will@kernel.org, boqun.feng@gmail.com,
 longman@redhat.com, clrkwllms@kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/cgroup: Lock optimize for cgroup cpu throttle
In-Reply-To: <20250811083622.C29-WNtR@linutronix.de>
References: <20250811070838.416176-1-jackzxcui1989@163.com>
 <20250811083622.C29-WNtR@linutronix.de>
Date: Mon, 11 Aug 2025 16:18:31 +0200
Message-ID: <xhsmho6smhrgo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 11/08/25 10:36, Sebastian Andrzej Siewior wrote:
> On 2025-08-11 15:08:38 [+0800], Xin Zhao wrote:
>> After enabling PREEMPT_RT, ordinary spinlocks can also be subject to cgroup
>> limits during the lock-holding period. This can lead to seemingly unrelated
>> threads experiencing timing dependencies due to underlying logic, such as
>> memory allocation, resulting in delayed wake-up behaviors that are difficult
>> to understand when analyzing traces captured by tools like Perfetto.
>> Due to the prevalence of this performance issue when using cgroup CPU
>> throttling with PREEMPT_RT, the CGROUP_LOCK_OPTIMIZE configuration will be
>> enabled by default when both PREEMPT_RT and CFS_BANDWIDTH are activated.
>> This configuration option temporarily increases the priority of tasks to
>> SCHED_RR 1 if they hold a lock (excluding raw spinlocks, RCU, and seqlock)
>> and are limited by cgroup, provided they are SCHED_NORMAL. Once the lock is
>> released, the priority will be restored.
>> This patch is a derivative of the priority inheritance patch. While priority
>> inheritance can cover scenarios involving spinlocks and mutexes, it cannot
>> address the timing dependency issues between two SCHED_NORMAL tasks caused
>> by underlying locks. Additionally, the lazy_preempt feature does not cover
>> scenarios where a real-time task, such as a ktimer, interrupts a lock-holding
>> SCHED_NORMAL task, which is then throttled by cgroup cpu.
>> This patch not only addresses the issue of cgroup limits affecting spinlocks
>> under PREEMPT_RT but also resolves issues related to holding mutex or
>> semaphore locks, as well as other core rt_mutex locks under PREEMPT_RT.
>> The following stack trace illustrates the delayed wake-up behavior caused by
>> two seemingly unrelated threads due to underlying logic:
>
> urgh.
>
> What about using task_work_add() and throttling the task on its way to
> userland? The callback will be invoked without any locks held.
>

Yeah, please have a look at:
https://lore.kernel.org/lkml/20250715071658.267-1-ziqianlu@bytedance.com/

> Sebastian



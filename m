Return-Path: <cgroups+bounces-8436-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2EFACE521
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 21:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32123A91B0
	for <lists+cgroups@lfdr.de>; Wed,  4 Jun 2025 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA192212B28;
	Wed,  4 Jun 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5RvQoip"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411420DD63
	for <cgroups@vger.kernel.org>; Wed,  4 Jun 2025 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065973; cv=none; b=e69LjUiKhb8yw6ZWle/2cQKRR2ItGXQwLGQzuiG7z1Jw6zVTduy2ahzmi3ZgI4qAe89RseIMh9pF07OQU0Xgh6+Ui6+xBjJ6jqayqj8WSQobazQ1f34YYK2ywjx7x6KnwAX8yB1I+N7mwNLPyz+qLLe/MdyaA201REhnMqc4Sto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065973; c=relaxed/simple;
	bh=uqrrh5XKhj0JhJlvb7JWbUd5mMKx4NAS1ZTa4avFBd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NPwKP62j80iX34P2uswSuo1PuI5tZ+qVWseV+2bmyH1JT7SLJlVe1mscbb/HluLBHyTAMdA6Ju6hbWoRMfWDLiU1ImLxDs43RdpV5V1mVMHs3JJeH8+dr4hphWNkJr5+1Qc26lhHqb0McArWWVFn9alnc5sdPMIT6xDUEZeTu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5RvQoip; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso296888b3a.2
        for <cgroups@vger.kernel.org>; Wed, 04 Jun 2025 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749065971; x=1749670771; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WSxWqox5bdiWzZ5tn/4s8/4uvycqiAbImkblkNnSipg=;
        b=W5RvQoipny5k8mRsT1J6bTVWx1MFL8QGoOk0sehkgeBzzAty+hy+//w+g9R30otO0H
         7r44Y5FqsyLzz8ixUYh0I6KEc+NH7eXP5jKrlHGv0E1TjKVow+NHJtxEk6ijN2u6jMFm
         nMU6Jbw5hPKxopJmjjoBUmTzh1y1IpGAqiGvFeYOLdDUJ8Zpt8BCO1voaoqn1d2KGnjw
         taHHoPmCX5+MKWj9Ipshl4u9MvcY41XyqiM+XWdzHApm/NIzc747ZjT/eVMujojHQ4nV
         Wb8CjC2VY/sfLcg/t5Dg65lNrzVCRzoKKruW77XNzYoRQHTTVldQsG9NLqCEIUKlat3b
         KWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749065971; x=1749670771;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSxWqox5bdiWzZ5tn/4s8/4uvycqiAbImkblkNnSipg=;
        b=UCKjmlqBjTiokzvlQFMllH05IU025qoDJc8cpO5bDUF+sA2jNdncgq6biQN6NjMQsE
         eU3tUIq3uS8QghKhP3aZfyYowB0xbitscITZZJ65Xt1Ztxy2yYROlX+/GAvre2htManN
         o+XdyYOUsoKAlJUe3PzPq/RM+BrBp0wfcIzIB6JHXq2eF24kza82yad8xJ85wXVVVMkF
         pnnvyk3itXUcVFB+OLmhRv3yEi4QAu11c+etTK0L4rDycfIQCPHwgm7phTm7K8AFHyrb
         f3arq0wnx2l/PGp1Nnof04wwFTo4frax8pyhurmolTRlO4KhKYBZBNlxXMtnzKCNPTnp
         YsPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ7bAVoscyB0BBireUvIVGkuLOPOIeSNtifvBakstW39KoT42vD3keZ1K02j464Xm4V6G5e3RI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuj7VGtFrz4BhXY2g/uLgQWbpvbo6S700h2zsSq0P5ou+nBFEn
	4sL2mDNJFJMuPYJSYkqXQ+X3+3aCIH8W/jwzbFkkh06uIZf9Ncvx30oAZgP2nde7Ow==
X-Gm-Gg: ASbGncvQOBqoT5YEm6FXW8PTwLi8IfMfxzEUl7EAaWqOUpvEDYInuNMnrbwFuRpLkMH
	BSOoBdGUrKwW6aKE6i9TTadu9sVLsfM3ZNfkh8+AbjdPbt4s3tY34qIePfSdKRLvM9So8IigPr5
	cfzW3BgPA2ENYBArvr9YHPJK0bQJmcYB/tpPrzW2un959wDftx8v/P+rsEZLw+T/w+GejKGy2PC
	678/AXjs2UbJZrWReJVZFnjiTBAMoue26SVKje1A5sKK/Lov3dhps/KhG/jrn94qZyDP/gh4qK8
	P0zLaCT5DBRQNl21EP+GB980PdMUQGs9Miu8L7jwtINvWRtFIocNzcRdjUU8V1mz3dRxOOb91Gx
	5zbMRTaufD4pUWCDt1tVYm2Y4nfWHlrUc5+4eH4wnDVGFD6QVMlvjgh6VHGU=
X-Google-Smtp-Source: AGHT+IEUUgzAKKhwwQ9XugqEZgLxNnWmGOGv4hdFCRqrrqKmlL/qaqsBWbsCyy4gSxXaS0EWkVrpPg==
X-Received: by 2002:a05:6a00:4fc2:b0:736:34a2:8a20 with SMTP id d2e1a72fcca58-7480b46113bmr5411347b3a.21.1749065970983;
        Wed, 04 Jun 2025 12:39:30 -0700 (PDT)
Received: from ynaffit-andsys.c.googlers.com (163.192.16.34.bc.googleusercontent.com. [34.16.192.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeab4acsm11479575b3a.43.2025.06.04.12.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 12:39:30 -0700 (PDT)
From: Tiffany Yang <ynaffit@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org,  cgroups@vger.kernel.org,
  kernel-team@android.com,  John Stultz <jstultz@google.com>,  Thomas
 Gleixner <tglx@linutronix.de>,  Stephen Boyd <sboyd@kernel.org>,
  Anna-Maria Behnsen <anna-maria@linutronix.de>,  Frederic Weisbecker
 <frederic@kernel.org>,  Johannes Weiner <hannes@cmpxchg.org>,  Michal
 =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,
  Pavel Machek <pavel@kernel.org>,  Roman Gushchin
 <roman.gushchin@linux.dev>,  Chen Ridong <chenridong@huawei.com>,  Ingo
 Molnar <mingo@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,  Juri
 Lelli <juri.lelli@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Ben
 Segall <bsegall@google.com>,  Mel Gorman <mgorman@suse.de>,  Valentin
 Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH] cgroup: Track time in cgroup v2 freezer
In-Reply-To: <aD9_V1rSqqESFekK@slm.duckdns.org> (Tejun Heo's message of "Tue,
	3 Jun 2025 13:03:51 -1000")
References: <20250603224304.3198729-3-ynaffit@google.com>
	<aD9_V1rSqqESFekK@slm.duckdns.org>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Wed, 04 Jun 2025 19:39:29 +0000
Message-ID: <dbx8y0u7i9e6.fsf@ynaffit-andsys.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tejun Heo <tj@kernel.org> writes:

> On Tue, Jun 03, 2025 at 10:43:05PM +0000, Tiffany Yang wrote:
>> The cgroup v2 freezer controller allows user processes to be dynamically
>> added to and removed from an interruptible frozen state from
>> userspace. This feature is helpful for application management, as it
>> allows background tasks to be frozen to prevent them from being
>> scheduled or otherwise contending with foreground tasks for resources.
>> Still, applications are usually unaware of their having been placed in
>> the freezer cgroup, so any watchdog timers they may have set will fire
>> when they exit. To address this problem, I propose tracking the per-task
>> frozen time and exposing it to userland via procfs.
>
> Just on a glance, it feels rather odd to be tracking this per task given
> that the state is per cgroup. Can you account this per cgroup?
>
> Thanks.

Hi Tejun!

Thanks for taking a look! In this case, I would argue that the value we
are accounting for (time that a task has not been able to run because it
is in the cgroup v2 frozen state) is task-specific and distinct from the
time that the cgroup it belongs to has been frozen.

A cgroup is not considered frozen until all of its members are frozen,
and if one task then leaves the frozen state, the entire cgroup is
considered no longer frozen, even if its other members stay in the
frozen state. Similarly, even if a task is migrated from one frozen
cgroup (A) to another frozen cgroup (B), the time cgroup B has been
frozen would not be representative of that task even though it is a
member.

There is also latency between when each task in a cgroup is marked as
to-be-frozen/unfrozen and when it actually enters the frozen state, so
each descendant task has a different frozen time. For watchdogs that
elapse on a per-task basis, a per-cgroup time-in-frozen value would
underreport the actual time each task spent unable to run. Tasks that
miss a deadline might incorrectly be considered misbehaving when the
time they spent suspended was not correctly accounted for.

Please let me know if that answers your question or if there's something
I'm missing. I agree that it would be cleaner/preferable to keep this
accounting under a cgroup-specific umbrella, so I hope there is some way
to get around these issues, but it doesn't look like cgroup fs has a
good way to keep task-specific stats at the moment.

-- 
Tiffany Y. Yang


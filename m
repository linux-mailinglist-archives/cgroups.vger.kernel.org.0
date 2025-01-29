Return-Path: <cgroups+bounces-6370-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38855A2171A
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 05:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B99F1653BB
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 04:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D44418FDB9;
	Wed, 29 Jan 2025 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iDtyWtTK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75AEAF6
	for <cgroups@vger.kernel.org>; Wed, 29 Jan 2025 04:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738126099; cv=none; b=d0lk48PaOTI6WP07kepwToVcLviJhWXgxbSnATfXy85jVAolz5Z009VQRK7xqgTOoi5WI2Qcg3xZ99nahul/fDYy4ImQDOutZ9lU73CV71FVO/W9H2oiV1u5SNrWCJXLXPWqioFYEDA4oRzLLO2LKEL4EG3QEGlb5y+VvFeuxzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738126099; c=relaxed/simple;
	bh=gTUI/poBGUa4PGe9KeuiWxZj7DwD2823ZOFRNGEZjxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOAYbMD+oE4VUL6E88Q5jhATj8ZJ2RHjCSKbj04Y3rQ2Fkx37z3kaVi5IdU7rjl6gdg6D+wwvOt1eV8UudAYQ8WZzdaW3OQSs+M07O0S0oVEhtVHX0dfj7Mi0oWP6aNz4029clOm3uGMBp4tFirSV4Ei3QHO5wNJlaHhI6eeNj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iDtyWtTK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21a0374a1fcso12856915ad.2
        for <cgroups@vger.kernel.org>; Tue, 28 Jan 2025 20:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738126097; x=1738730897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqmunIpKWBlPQClE3jp80cOJ1ikHtuUrvUz3QQSshEM=;
        b=iDtyWtTKqx87DrXtpP5OgDlTcza3K4/YMYLGUypQ0w5flR1ZM1QMo+CAk2dn8UPo6v
         zpS4GNtbP5Dc00DE40drIBTTlTbi4GPye1VmlIXWXYAgZauk0HxAS/QjUc1rfo+VYxmg
         M/ioAg6DGi/0loJ3AbbyDGyBpROnFUeFFyIqTj/Vu7A4ExN8wjQ13Jy0p4jItFf/UQT/
         1RorCYZ8sHinD9Wn2BppXOMJTo1IV+RswhqDeI1fCay3NaRBAlW6PwDurZvVpM650QZZ
         P2aaXZ11izWtizPsS0F9cCBxuWTl2S/pJfJ2YG4lVm38RE26d9/atteABIzM6Bj9kVVG
         WpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738126097; x=1738730897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqmunIpKWBlPQClE3jp80cOJ1ikHtuUrvUz3QQSshEM=;
        b=pIPWCh77e2VLLvoQlY1NKAtG1WBFeNflGj7l/DEpnE/B7bPXfV50G9aCcSTBELIZDp
         jghbuuYsB3SAA9zCTaFlFDUoQ3B4PoSqExOSZXaYpIoLDD+ve1zQZ8A60HnDyINlhbdx
         IVQ9Wzl+b0i/gsPQt5OOUy5drWzbAxj4YidjEBrifFyRkJqNWcCtGm76IrtO7VQZFW3l
         WS+qkcyOIMW0Azi/a3vWK3HmM1p3NGB6TfwvTuVplA8mhqADuHqnBJh0r7biPK/Wg9Qc
         lLiJL3lLPgy2+lumikXyhuZ33ZRk6zRblhg5kIXQA+uGPKghlmxEceI3IqVE5aIpBu4I
         /r1w==
X-Forwarded-Encrypted: i=1; AJvYcCWud8NxiW0QSjS2UAxia55XLdvnlU6OpbvGz1xTf/DNa5ZpOZHJdlV930XchV/MRZOalDW3q4fK@vger.kernel.org
X-Gm-Message-State: AOJu0YyQKkwhpjIL5kIvLNy6OLhSUfQiM+/XgPfAZtMiBA30K2Z2M0QS
	oDe1AgfvwWq2OJwoAADzCaH2LxjLlWdStUHYLLdZ2Gq3404I7I+Vvnc3LBtZgL4=
X-Gm-Gg: ASbGncv1pxGsrdU2Y/UU+qFI0vF0VUdfz2FQkUBkiQGSiULBXPmlr4m6OqWfFVY00xM
	k38FbUvL9kS/iisla/GUwWQdpEpiTaXzmk5X9ORP/sLUdsIO421Ab+Gu8EFPBUc9sCPAgMN490J
	pJ1EQvoIwiCYsFt3h3es1ntsrjbGn1ZEmALLOuMfmNlCYAbMyCAXHwKlLqU41fDwug+S7xuMasu
	GjTqsPwlVK8iimlnoSxFYWFwZBF3gZBRVjAidVtGxTxYvr56pWbSPXrPEXDy5wO5lUlyPK6ccuS
	h6sqWnXhONbRq6m+iwoTGEF5siLMR7UCJMXiMMuw
X-Google-Smtp-Source: AGHT+IELS4KQ6Wvh+0VxMOQajNbXjiLISlc86qwEtSS6xVbj4i8kpeGIQZX4jNt1xWTUhKUd2xdyaQ==
X-Received: by 2002:a17:903:2282:b0:215:94e0:7 with SMTP id d9443c01a7336-21dd7d6f76fmr10500975ad.7.1738126096927;
        Tue, 28 Jan 2025 20:48:16 -0800 (PST)
Received: from [10.254.209.208] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424f39fsm89622785ad.249.2025.01.28.20.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 20:48:16 -0800 (PST)
Message-ID: <9515c474-366d-4692-91a7-a4c1a5fc18db@bytedance.com>
Date: Wed, 29 Jan 2025 12:48:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cgroup/rstat: Add run_delay accounting for cgroups
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yury Norov <yury.norov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bitao Hu
 <yaoma@linux.alibaba.com>, Chen Ridong <chenridong@huawei.com>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
 <20250125052521.19487-4-wuyun.abel@bytedance.com>
 <3wqaz6jb74i2cdtvkv4isvhapiiqukyicuol76s66xwixlaz3c@qr6bva3wbxkx>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <3wqaz6jb74i2cdtvkv4isvhapiiqukyicuol76s66xwixlaz3c@qr6bva3wbxkx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michal,

On 1/27/25 10:10 PM, Michal Koutný Wrote:
> Hello.
> 
> On Sat, Jan 25, 2025 at 01:25:12PM +0800, Abel Wu <wuyun.abel@bytedance.com> wrote:
>> The per-task and per-cpu accounting have already been tracked by
>> t->sched_info.run_delay and rq->rq_sched_info.run_delay respectively.
>> Extends this to also include cgroups.
>>
>> The PSI indicator, "some" of cpu.pressure, loses the insight into how
>> severely that cgroup is stalled. Say 100 tasks or just 1 task that gets
>> stalled at a certain point will show no difference in "some" pressure.
>> IOW "some" is a flat value that not weighted by the severity (e.g. # of
>> tasks).
> 
> IIUC below are three examples of when "some" tasks are waiting for CPU:
> 
> a)
>    t1 |----|
>    t2 |xx--|
> 
> b)
>    t1 |----|
>    t2 |x---|
>    t3 |-x--|
> 
> c)
>    t1 |----|
>    t2 |xx--|
>    t3 |xx--|
> 
> (- means runnable on CPU, x means runnable waiting on RQ)
> 
> Which pair from a), b), c) is indistinguishable via PSI? (Or can you
> please add your illustrative example?)

PSI tracks stall times for each cpu, and

	tSOME[cpu] = time(nr_delayed_tasks[cpu] != 0)

which turns nr_delayed_tasks[cpu] into boolean value, hence loses
insight into how severely this task group is stalled on this cpu.

Thanks,
	Abel



Return-Path: <cgroups+bounces-9395-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E9B34D37
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 23:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53327204641
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 21:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212F928751F;
	Mon, 25 Aug 2025 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQzUAXTy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2228C5AA
	for <cgroups@vger.kernel.org>; Mon, 25 Aug 2025 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756155630; cv=none; b=sXEdLfy3HKHfoWPBWS0uLT5zF8GozSI93sEVrbiNNu41y8+LRKbl6xo0oWh3dm74wCjA8Jkfk8zgPfzZ3Go4mY1fx6X93VXidtjI7tDdHPhL++cBrlq4vo8NX51P8wBBMjdQ0k5OPp3Rrf+KvsVMFVqgYlale0qU31FduNGHs0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756155630; c=relaxed/simple;
	bh=8/L1nD6fwcNCBonjJ/5ertVaeOR+ahaDa34IyMFnlZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QHf8U/+1NIrL4S+4QorV4c/4w7pX7huR5LwyPFmX29g9vigkO/vyhyilVz0qD7O69TntjARzvlo9mb0S0EhO/T+BRiT7QIkMQLsHALJnXPTL5nxIAzt9RGzSpT5qSFmMG1X+qORo67qko5UuFHj9jd57m/6I2uvdn7k823ki8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQzUAXTy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32515ec1faeso3422205a91.1
        for <cgroups@vger.kernel.org>; Mon, 25 Aug 2025 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756155629; x=1756760429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EajGDWl4bYdFnIYaGpVNH0fQHV+uFPvw1C8aIH8SGwE=;
        b=hQzUAXTyiuZ3Jb9Vj5S4MFw0rxCwcdFbgjYYBjzXqaO487SZuT1WvtenXG0v4goZXf
         Ny+Y216jjgC5wocoV5RCXti2KjSsy22orRGCuqgoIa5X2U+KO61FwGqILfkHaqo3+NgY
         KbAZ9GJiB+2N6fe4DdxE6887+OhBupOTHmufghu5iuzMWQWtM7Fb8OA33FQe7bX5wJcj
         zUdRabwZWKMXwZijyfxua+OciHYNspGrF1kVPSLmJWevCQJd4D8HX4yBJ7UJSOBmxjRe
         f8jFnm1WpCXr0Y6z2sehyFwltX4k0mmf9KfF8NlFgD7gwEoS4Ung8q+7YPab9dhkQtBd
         aj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756155629; x=1756760429;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EajGDWl4bYdFnIYaGpVNH0fQHV+uFPvw1C8aIH8SGwE=;
        b=tdL80LXK4LFSHlh7GP2omrMUJr21UWTz8VoDiKQaJ1MRuVPY/IHAfJKrAKEF8jum44
         9a2zPSezWwDeO9L0gc/VRYhFJaa9ed9ghVZtTpgu9NMJLffN+s3HX6qP0BGaMSFr7DGT
         xoRRSO79FXaktS9K+qa7lxE7Ap71QCILtwygvq122c4Ywbtif4bE748rWeqTSYoeVCng
         P8c6NhU8Jt7sFsetyNKu+RzaVlbtQqGFg4T6L74re3Y1bVIAdyXcu33IcnOYOXb48FJr
         xfnfBaAuZfloTvGB5JTU64hj8PS5OdOhD+gvh2XdDtmZdFeae02f64c9owhL3qFyK5/N
         zQbA==
X-Forwarded-Encrypted: i=1; AJvYcCUAY4HpoYth7MX6irDqrxoY5lY+0ITl/marCLhGwB08AAXU0GxneCumwbn6pZ5X1F/mq8cjt2az@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHJhp3JWHLn84eIulfq9yuk2gbK5m4YcmzMeiULzFVLZrVdTT
	cXItTEo5JSX9Mzxn2HSsHqtVkWnmIbnNYD2VsSFAmDxi9AGDqPCSyzIQac+443bH5uGcvksWcDA
	jvTldFblPlw==
X-Google-Smtp-Source: AGHT+IHfcHvufdfIXSHW6kSBSPN+UPpDISXjx0iJ8nMd5Gl1QjNxnfRrBYGYRdeOvhlCxZIcU1Bknm3SxCBw
X-Received: from pjl11.prod.google.com ([2002:a17:90b:2f8b:b0:325:1d7a:69ff])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c8:b0:323:7e82:fcd
 with SMTP id 98e67ed59e1d1-32517b2bba5mr18185189a91.37.1756155628647; Mon, 25
 Aug 2025 14:00:28 -0700 (PDT)
Date: Mon, 25 Aug 2025 14:00:27 -0700
In-Reply-To: <1b6498f3-ca07-41d5-9637-f20a58184e60@huaweicloud.com> (Chen
 Ridong's message of "Sat, 23 Aug 2025 09:45:26 +0800")
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822013749.3268080-6-ynaffit@google.com> <20250822013749.3268080-7-ynaffit@google.com>
 <552a7f82-2735-47a5-9abd-a9ae845f4961@huaweicloud.com> <a309c2b5-5425-428c-a034-d5ebc68cb304@huaweicloud.com>
 <dbx8ms7r885f.fsf@ynaffit-andsys.c.googlers.com> <1b6498f3-ca07-41d5-9637-f20a58184e60@huaweicloud.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8ldn7nml0.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH v4 1/2] cgroup: cgroup.stat.local time accounting
From: Tiffany Yang <ynaffit@google.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Chen Ridong <chenridong@huaweicloud.com> writes:

...


>> Thanks,

> What I mean by "stable" is that while cgroup 1 through n might be deleted  
> or have more descendants
> created. For example:

>           n  n-1  n-2  ... 1
> frozen   a  a+1  a+2     a+n
> unfozen  b  b+1  b+2  ... b+n
> nsec     b-a ...

> In this case, all frozen_nsec values are b - a, which I believe is  
> correct.
> However, consider a scenario where some cgroups are deleted:

>           n  n-1  n-2  ... 1
> frozen   a  a+1  a+2     a+n
> // 2 ... n-1 are deleted.
> unfozen  b               b+1

> Here, the frozen_nsec for cgroup n would be b - a, but for cgroup 1 it  
> would be (b + 1) - (a + n).
> This could introduce some discrepancy / timing inaccuracies.

Ah, I think I see what you're saying. I had a similar concern when I had
been looking to track this value per-task rather than per-cgroup (i.e.,
when there are many tasks, the frozen duration recorded for the cgroup
drifts from the duration that the task is actually frozen). Ultimately,
although those inaccuracies exist, for the time scales in our use case,
they would not grow large enough to make an appreciable
difference. To use your example, the ~(n - 1) difference between the
"true" frozen duration and the reported one is still effectively the
same (to us). For others, their systems may see a much larger "n" than
we might realistically see on ours, or they may need finer-grained
reporting, so this solution may not be adequate.

-- 
Tiffany Y. Yang


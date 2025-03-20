Return-Path: <cgroups+bounces-7199-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D44A6A97C
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 16:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0F718887A9
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5661E47CA;
	Thu, 20 Mar 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="m3izvTXp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173681DE3BA
	for <cgroups@vger.kernel.org>; Thu, 20 Mar 2025 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483313; cv=none; b=jHVjFviNInnFYHnoX4mheBbI1CzBibRk/JYfN2oQkBiTeKWib0+SkLr7gJXsCMDQOpc+b2qOhlnO+u+CVwDRo/0s5wJ9M9/gOljpRzQMMzTG3UlDL1hm9Vm7J5eZhmC1j5GlS7NMdJP+sLGvbxydD+35+Kfye/urJpWwz0Uje78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483313; c=relaxed/simple;
	bh=+wIue+d1fxHnxh1n/pxsYBdiSsRsmFYUmZTnYav+nCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8QHkoz/muhFOARfYffOQA06K8iWHpyXyVquBAXm3HNep/la5yHSm+po608IIxjE/YVzbJluxG4/gJMs8kjGSr7wzi9Gk1LNOmVTr1V11pncfMy6zGw90G/xyCHZ7jbM7MePhYlKzU0zEvEZXO+81slBFnFzqgpkN/wxHHKRX48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=m3izvTXp; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476b89782c3so10439501cf.1
        for <cgroups@vger.kernel.org>; Thu, 20 Mar 2025 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742483309; x=1743088109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wIue+d1fxHnxh1n/pxsYBdiSsRsmFYUmZTnYav+nCg=;
        b=m3izvTXpkq8MM8CAfUIKmfW77lVHpp7BZ+9eWIBDi4jytqMSeq5KvZgkm4JxUVgkr1
         01l5Hlm/rPlczg/x+65Ratws2+oHGqfdEw1wI2LHjVY+npMo9sssCXwR2UcQkTEIeTt3
         Nxt169msZ0nT28ER4yIZWQmsZPImwVQlzyIULufq76F1wGQKxRqFfwio1Frn0u3YFahF
         Qiv6UhkGM6r0suZnh6mKo+yeEl9iKnpzS2VQXALgrk+UXQIXj9BA78fDF99mKADy75AG
         2DiTDs99fomJHp8ODRsP2xATAjj1WJHydJN/ZNRaEhD+iZU4ttXFL5lJr9gC/WiOW48/
         2eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742483309; x=1743088109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wIue+d1fxHnxh1n/pxsYBdiSsRsmFYUmZTnYav+nCg=;
        b=UtRAMCI4BUFsQhcQm/ToVD3MNbdHwl4P/6Arcjyy3pDncZylYuUDB2pj+9flihWuWF
         ag1UEbHar5VbnP5RKdt9rIpIcPeOf+XSC6otME013/ywCNvW2HAeyfUJRJQ2/qzqMD22
         LVO4zHYKjl9/LLlBewNAA7sYjA9auWbwSaaAO9Vc6qHPO+/LGb1obeTTurqEdfF03zFk
         8bdTZjRCWC0rplcf6Vfo8rOPQ5Vf11Cjeve13X5g2cVYZ2M3MvWkIzOrpsWHA5wjH+OL
         5VCC1rgVK++xoNm4is6YbJSnxEvlPtKBM4xKmZSwm1NjVSzSjt4ZdrCXY+bqPLPsohT6
         Y3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVYlyLVKR4Ys2B+F24KwOAKA0V6D/smf+0UayAepX2MUZYza3pCCBqWWaOH5bKB2exMLpgiDnNK@vger.kernel.org
X-Gm-Message-State: AOJu0YxBFXD+lOBEfaxj5MGCKMonkM62e1KJTbR9eBPDdKJreHFn1H5S
	bXWAaEoJdifg3GioObpXcghWrqUFjdNEOsyNUgzWmsibVJkQPHvbxknKjWjbZlo=
X-Gm-Gg: ASbGncunBUTEOMg5D0TQNiuLr5YclNLyiC9Bowtyo5NiEuFN3XMQ+71pOSLhaprd2n3
	6K3XFeeFdt2IoZq4IX/nLeA0WYd3qZmq+uWG2FAu5YnMkKb9lxDVhuxQMzxRKG/zm4nXkom2H56
	bYwkqzFXVjvFA3DwvFW55TgX/yZK6jr65JML0VI6LbgYymQwrnnJPJXHxxKMUaGdDNoSlJR4A26
	2nqFaoudIJ33xnb7fVkUZMpYxfZm0JNOqvztGNyf3Tofqo6IYajtKOlhpFF0+MeAS/IoaaGmoQP
	Dq9xK8jpoEiAbYvPIoOtSpAtSFGCxYhzdRNf8mmq97k=
X-Google-Smtp-Source: AGHT+IEqDT7L31lKb+4Vt3imVDG99K/l6IxQtEuRxofKiOxuNW4VzwDmBVYfyocCiaVRZJSQ1vSRuw==
X-Received: by 2002:a05:622a:4cc5:b0:476:6d30:8aed with SMTP id d75a77b69052e-4770839bf5emr111115461cf.49.1742483308620;
        Thu, 20 Mar 2025 08:08:28 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4771d176113sm209421cf.17.2025.03.20.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:08:27 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:08:23 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, kasong@tencent.com,
	Zeng Jingxiang <linuszeng@tencent.com>
Subject: Re: [RFC 0/5] add option to restore swap account to cgroupv1 mode
Message-ID: <20250320144722.GH1876369@cmpxchg.org>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319193838.GE1876369@cmpxchg.org>
 <CAJqJ8ig7BrPp0H3Lzbd0u9R6RhS5V0-i3b4eMWf+4EhujRU-jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJqJ8ig7BrPp0H3Lzbd0u9R6RhS5V0-i3b4eMWf+4EhujRU-jw@mail.gmail.com>

On Thu, Mar 20, 2025 at 04:09:29PM +0800, jingxiang zeng wrote:
> If both memsw.max and swap.max are provided in cgroupv2, there will be some
> issues as follows:
> (1. As Shakeel Butt mentioned, currently memsw and swap share the page_counter,
> and we need to provide a separate page_counter for memsw.
> (2. Currently, the statistics for memsw and swap are mutually
> exclusive. For example,
> during uncharging, both memsw and swap call the __mem_cgroup_uncharge_swap
> function together, and this function currently only selects a single
> counter for statistics
> based on the static do_memsw_account.

My suggestion is to factor out from struct page_counter all the stuff
that is not necessary for all users, and then have separate counters
for swap and memsw.

The protection stuff is long overdue for this. It makes up nearly half
of the struct's members, but is only used by the memory counter. Even
before your patches this is unnecessary bloat in the swap/memsw, kmem
and tcpmem counters.

Fix that and having separate counters is a non-issue.

Overloading the memory.swap.* controls to mean "combined memory and
swap" is unacceptable to me. They have established meaning on v2. It
may well become a common setting, and there might well be usecases
where people want one setting for one cgroup and another setting for
another cgroup. Or maybe even both controls in one group. And why not?

This is a user-visible interface that we'll have to support forever,
and deployments will be forced to use forever. Tech debt in the
current implementation is not a convincing argument to forever trap us
all with a suboptimal choice.

Nacked-by: Johannes Weiner <hannes@cmpxchg.org>


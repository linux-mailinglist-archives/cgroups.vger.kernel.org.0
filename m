Return-Path: <cgroups+bounces-6136-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B3A10B70
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 16:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5581882B76
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA96157466;
	Tue, 14 Jan 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Icb77+Wq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C83596B
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869710; cv=none; b=pIzN2AAuPbL/sbn660er8l9l23fHm1Xf34SQeJLGLbu12X8cQsxkGd7TQMnt4hEWZxWmk7YnliK/4ucsbmteqAd2uxZBlKYdjgTg0JM5Qb14VgmhFqQx+4QsnssiIWLAIJ2dKGeCL4MO58wxUZcqmY67mgVn7i+Q8UipjedaDs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869710; c=relaxed/simple;
	bh=nNxchZmue09+aaMJIbjpZCfErXLcsYlOX1HTqcoSf+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2L0ttth7Bm8HeJcddEIm2aXa1rtozbC7Oyn6ald99VPZ3jVczn9+A0lD1BwHSUy+vNdkPZF4VB9Yvj4Zl/W1/FQwkSEF2perqiHSdfd5f0H4By+LdLr2rwP+Az8sujDUlc5bTUvwzoq8vHWTMQktEPYLgRUlklO5Oc399u7qDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Icb77+Wq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436a39e4891so39507635e9.1
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 07:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736869706; x=1737474506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BG6OPv+IrPEYkSpPvIRdrrdLfEGylbnftPcEWGEUYlg=;
        b=Icb77+Wq6TiW1+AHG4VI29yt/RBF7YILpNx6ugVNPoIXJQ+igR8s502MCshn/8oM8s
         iBAux0vBJq1FI2lmhEjYxveXD4BRpkVwk/9qMqilmz4co15FkeY+jW9ZtaqjPzQKkfwn
         rQYl5AwUFrmU8si7OFMJY8+cTq+yriruGXyWGAZFh7AY1aW1tSeiRJocz1f10TCMDaH2
         zAK0gt81uKB3So2S43DzqkmaHKHaehbZBrrH5npcSwB6/GTTkdASQzgNvdrF6l3wdqGA
         nhf45GjWEAbfUgNRbkRkWWriSSqj2COiTb5Cqa3y8HuSepagCZS+P4d3qHHfE2RIWb+D
         qIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869706; x=1737474506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BG6OPv+IrPEYkSpPvIRdrrdLfEGylbnftPcEWGEUYlg=;
        b=tbg1YZB5TbylvGo35DQkDKf0d7RsLVd0zMBoTcM9pA8FmU+JjIy9IbmuX1Ju5q8/Ci
         yAPTchVaj4kF0aawE2JaBjS53fwNUMBbCBvMHpbmGjM4QbSyWxX8KnGUEyq/zDfyQQpB
         Uilncey8yTMZyejuEXL/JRiB8g3fMAMpviDPh+/DJviCGXKtbavSO+PpfKTzmsPn6bDD
         /qLY29MmHYhUaivuovXctFtHMfQgs/+ejl0BN5W7BfXjC3rhnRZIjRYPJ3NSHNtTVaFu
         gKsw982mlK3SaozcArSvql4OBymkupGFZCpdzCnc5RzzICEZiDWJO8aVSp0lU3F0EymW
         56eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF1AV0+38OsliICQKkSZsFxPwWZ/HtYhCC4gRrujCZ/WfN4BZ6vV0McGJQoK0FHRYf73pID+ht@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdVFgL+vpOH9Yda2Sv4RNf7rCam/9iNiooCj8R5eSOHu19OrL
	ek6hjM5YYqhZORn6pH+/6NLUEAn8mc4/jf5K6OgfGFQLfrmz5Es44hngHQ3GRJY=
X-Gm-Gg: ASbGncuFz/KfB86JC/6+X1d7w1T3/vR84VGBMUPzz1VRnrRtDEVsrOAknPA3i0k4w1v
	Q1XqvbAppo5zeHRa6+YDERqtPjFVOKk0qyKP7wotBrywu+imr0fJqCBa+kDFSv9QPe+hg5ZzdnK
	tBeEqdJ24/DxcBIxUl3imetlVEKnyjl8dX6Q4fRaKKDR1jpvn2rj6nQ4K5pO/naoLz4Ytye0ha3
	IQYSD+8/x3fHf2sZ0U62kOn8fr1JtQXg+mC7EC8BVGcXEtc3jAFicl0CFs=
X-Google-Smtp-Source: AGHT+IGh+xsYs9Oq7gS9uzjGZc0VFfqM2x4R9iBvP41dezz9He2BEUpEk3+M0YjZ71DA5bH4B7Z6lg==
X-Received: by 2002:a5d:47c5:0:b0:38a:6161:2854 with SMTP id ffacd0b85a97d-38a872c944amr23607845f8f.1.1736869705544;
        Tue, 14 Jan 2025 07:48:25 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d007sm15067854f8f.20.2025.01.14.07.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:48:25 -0800 (PST)
Date: Tue, 14 Jan 2025 16:48:23 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	hannes@cmpxchg.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v8 4/4] sched: Fix cgroup irq time for
 CONFIG_IRQ_TIME_ACCOUNTING
Message-ID: <kc5uqohpi55tlv2ntmzlji7tkowxjja7swpwkyj6znmdw6rnjl@4wsolhiqbrss>
References: <20250103022409.2544-1-laoar.shao@gmail.com>
 <20250103022409.2544-5-laoar.shao@gmail.com>
 <z2s55zx724rsytuyppikxxnqrxt23ojzoovdpkrk3yc4nwqmc7@of7dq2vj7oi3>
 <CALOAHbAY8MLDT=EdzY6TzQv3ZF4OGXTWoWBEs45zQijZH4C0Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbAY8MLDT=EdzY6TzQv3ZF4OGXTWoWBEs45zQijZH4C0Gw@mail.gmail.com>

On Thu, Jan 09, 2025 at 09:46:23PM +0800, Yafang Shao <laoar.shao@gmail.com> wrote:
> No, in the case of !CONFIG_IRQ_TIME_ACCOUNTING, CPU usage will
> increase as we add more workloads. In other words, this is a
> user-visible behavior change, and we should aim to avoid it.

I wouldn't be excited about that -- differently configured kernel is
supposed to behave differently.

> Document it as follows?

That makes sense to me, with explanation of "where" the time
(dis)appears.

> 
> "Enabling CONFIG_IRQ_TIME_ACCOUNTING will exclude IRQ usage from the
> CPU usage of your tasks. In other words, your task's CPU usage will
> only reflect user time and system time."
          reflect proper user ...
  and IRQ usage is only attributed on the global level visible e.g. in
  /proc/stat or irq.pressure (possibly on cgroup level).

> If we document it clearly this way, I believe no one will try to enable it ;-)

I understand that users who want to have the insight between real system
time and IRQ time would enable it.


> It worked well before the introduction of CONFIG_IRQ_TIME_ACCOUNTING.
> Why not just maintain the previous behavior, especially since it's not
> difficult to do so?

Then why do you need CONFIG_IRQ_TIME_ACCOUNTING enabled? Bundling it
together with (not so) random tasks used to work for you.

> We’re unsure how to use this metric to guide us, and I don't think
> there will be clear guidance on how irq.pressure relates to CPU
> utilization. :(

(If irq.pressure is not useful in this case, then when is it useful? I
obviously need to brush up on this.)

Michal


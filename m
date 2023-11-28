Return-Path: <cgroups+bounces-606-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769E7FBFCA
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 17:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02401F20F57
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCA0443E;
	Tue, 28 Nov 2023 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo4QXgCv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8152810DF;
	Tue, 28 Nov 2023 08:56:10 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cbe68095a3so4377898b3a.3;
        Tue, 28 Nov 2023 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190570; x=1701795370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9nMu2b9XnNdD7wwpc++nEgEZUAhRsWBPvFZ/Lzv9fU=;
        b=Lo4QXgCvx2WCiRB8oO6oxd3mjwdJW7Qj69j9JAJ4ldMooqv9h4PDFoSNj91Yx5DGqZ
         O4qFChXx/gU7fFlT5uQhBit77Biv+YGjYDTKk28nambdWyirKPlaTtzqm57T8Iq4pWOp
         wtzr1fHQBfHvTcrHhYBMHDOfyDo4RFKezw5mlZvzpT45JUbZOTzhJq/tXvO0KCcVguj8
         Jgx/8Ld0i75T6SpTSr0r+KoleJdps/9J/Fox8g0t4rvYOHysZxMyAFYTMXdGPsHM2+4M
         FWPGBi2KRs2s0Hsf9RaCORB+5C5QEFZkRqKSwWO2GnGBxC3tu6ltLBpkGyZ63Y0+Dmmg
         0AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190570; x=1701795370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9nMu2b9XnNdD7wwpc++nEgEZUAhRsWBPvFZ/Lzv9fU=;
        b=UK2Svwi/7VtHoU0H8LKiG7O7FwiXPEFemZp5IkcbowSHW5Hvn0R1agbQAZLPQFS6XO
         hw9WZQimZfqBt2AanauY7zL1U/7vQT5awjPsOA5yZBPYfGMpFifgm/fhM1rBmchQ0DUs
         xLTRTlMMPHbIPc81XcJXjF/GMpp4fN/HB412jmmvlwiNwuvHNh7dh9rSA+5cBd2raeYZ
         QYL/gORjFqESwDnUyQxFfBmEAid0Vxi0gNrKIX89XfNjlaZl4Wvwio73Ax9ApK6QjsI0
         qLZS2zY+uv7+cGvY91kfmO7ykrxZIbniXw1qP8CT0kqvAtZ7zYAAvUdt46VqJY5AD2Te
         iJEA==
X-Gm-Message-State: AOJu0Yz9RWUesLIvGzmcUWNf4QgK316qYBDKP/6rmWi+e8MNwdbs3q8W
	FwcXAFsmECDsCMtYIYi5mZs=
X-Google-Smtp-Source: AGHT+IECbePOLzsM4J0Ktx1r5sk5ABhCCoNJdirIjQQSp8+v1zuJzbqUDRkvRuvPh0n2Sq5li0OJfQ==
X-Received: by 2002:a05:6a00:4396:b0:6cb:8bb7:dfb5 with SMTP id bt22-20020a056a00439600b006cb8bb7dfb5mr17375576pfb.25.1701190569871;
        Tue, 28 Nov 2023 08:56:09 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id q4-20020a631f44000000b005acd5d7e11bsm9690803pgm.35.2023.11.28.08.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:56:09 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Nov 2023 06:56:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>, Peter Hunt <pehunt@redhat.com>
Subject: Re: [PATCH-cgroup 2/2] cgroup/cpuset: Include isolated cpuset CPUs
 in cpu_is_isolated() check
Message-ID: <ZWYbqNnnt6gQOssK@slm.duckdns.org>
References: <20231127041956.266026-1-longman@redhat.com>
 <20231127041956.266026-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127041956.266026-3-longman@redhat.com>

Hello,

On Sun, Nov 26, 2023 at 11:19:56PM -0500, Waiman Long wrote:
> +bool cpuset_cpu_is_isolated(int cpu)
> +{
> +	unsigned int seq;
> +	bool ret;
> +
> +	do {
> +		seq = read_seqcount_begin(&isolcpus_seq);
> +		ret = cpumask_test_cpu(cpu, isolated_cpus);
> +	} while (read_seqcount_retry(&isolcpus_seq, seq));
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);

We're testing a bit in a bitmask. I don't think we need to worry about value
integrity from RMW updates being broken up. ie. We can just test the bit
without seqlock and drop the first patch?

Thanks.

-- 
tejun


Return-Path: <cgroups+bounces-11794-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA320C4B9E2
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 07:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B67954E3951
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 06:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7E42BE02D;
	Tue, 11 Nov 2025 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="jPejZi9O"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659C72BD5BD
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841544; cv=none; b=qudXvIjeCLHE2zi8MpTyMSozxMnlk+t/EHUUK3ZZwkhwqcf4YjKGRUZjFLjdt61BoN9aAdnQl2fIz2EIJHS2x5EiD1FFqD4Z2OtISn55HvsKYKBLmNWdgaSDlm1gplTOkktPhQ4PgZYmoRm/kjIOgcB5a5oNIhZGXbAl/TXv6uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841544; c=relaxed/simple;
	bh=FWwWHfVGkeFFK0gt3TeAwp+q+y/27u6YbRdVkJwdPgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HG22ZcJ2e6cs4PyVKhuIoySKE1lrvUizFQtg5ZJJAnrf4V4sBdINUq4Df5HbfluTKE4dkJbJT2lCyQUNFAS3nyhHYCEkTFdHoqlUtU2jV0u1FWj5qswq/w0UB1w8vQ9Y91kZ5nCvl3m3ru5YOv8GGkFQbAWgcp0Z5LlrhcThm7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=jPejZi9O; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1828489b3a.1
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 22:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762841543; x=1763446343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWwWHfVGkeFFK0gt3TeAwp+q+y/27u6YbRdVkJwdPgA=;
        b=jPejZi9OQ2F5tjT6Hh7i9Bww7Zd+0DWwHf5d3FUNRtsLrzhg/vDpVCwgYp5s2euxkR
         i8gwDZdAFrLhUxa9UfnRGvgIAFRCZI12EoRwwYnKSJmUAfHNZZ0KqHNCltaSEXaXqa+k
         iVjBnmLnnOY6ky8OibfIyuTIjrtFHA72WeIP7k0mZamBOU48/itNAsFaEmQTsJL7V0MH
         m8AmOZKIFypPT1agMwzgApKyBLihxgNnNKggaD+HwwRHlOW1CCOhWhQD5CFuyVSDma8P
         6FlkIfLOJnWRWZS7QQa+dElGO+WKkD7kvc5ps8Y7qsls8sCF66Ai4hZDm32oDoNtARg2
         FXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762841543; x=1763446343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FWwWHfVGkeFFK0gt3TeAwp+q+y/27u6YbRdVkJwdPgA=;
        b=HhBTvwoh8qiSBfbt8n76kP/rQ8/rarY6ToLWk+TUsamKKxJktnzt9PcUTycMT6xe7q
         Li/w8MlTIqskCPrT/q9MtTSd0DhXyBabFmfAORpJQkQzp6M73VDYmJMlof0PRZiDXAbr
         rk40Cf74eKU/JizdQ9a2xblI9rArWdpUXMw6sWYOEhbk0XdBNmzWT4Byrt+Hqmz7nARP
         q6uuSslzqUpXn1ySF0eyIGTVTspxAly6TJrX/88lSnHPodd2cbVt1FYICI7tyDCCppfA
         t2KNiECu0VbyrCUUOW+NEl6HP7zOTZYdk45suomwcjcnUaAGhFpIbXUFwD5wYpV2HUMJ
         aXeg==
X-Forwarded-Encrypted: i=1; AJvYcCXkYidq/yrQiHvO1YK5EdS1DRfZ6xTkmx+U+NZEZaKHd8/4j3rHpBs94HFypQ+A/9Jz8fMEnPJG@vger.kernel.org
X-Gm-Message-State: AOJu0YysR2SZfUWStAHvsNqd801Aohk5Eos5EL0WY13z2+BN9UAIUbVy
	MWC/P/UGmYg64/qGfoEPCnJpqG77avem7LfyRnNdWHt27+xBy3rJ5+o2A2Cvko+xWWM=
X-Gm-Gg: ASbGncsg0nfkJeG/OSNVTqtMcdewWyNK6IpzUjddEzMSQsrYfZBBs9hfKraELq5HAmR
	hQmk5bNueYgzjqFQZlmYI5vKzbX6nJG+oTS1wzMCqC9IGqaYpaZBLWcMW4fo7y/Eyr5G7K8QKDR
	8eJYqUfFFWU9oNFUD6Hy2ExWYHbCYe0Y18e88vIJtEdz3PxWlI6Wbh2hmK65CfVcLrD9ftHF7dw
	Ky0jZTNPL5/StE926VgCljZezInjIR9e6HIVlycw0cN+KYk31BlYkt3Z2fuMYoulYDdrOcVirVl
	SuaISsNo9adc3iF7n4If9LkQaQNuBPndA2+NQz/b08qlWikTxNYjrRp2jPSUq8hwDQqMODn9IOw
	TOd6HNyvMBeAQnVw/y8YO2qxhod3JnYroKSstJW8O//cjQUvR1mtufLG7M1AV1UdHNu+loqhsNw
	hToNbrtxbU46wYA6S4i7HD8LaD
X-Google-Smtp-Source: AGHT+IFvxypcxwiOfBwdgzPuM+j/Y1RLEUCRj28ISBfw3r7KvT4isOe0gB52rHuhHDaQS6UnBqQMLw==
X-Received: by 2002:a05:6a00:2d8b:b0:7aa:a2a8:9808 with SMTP id d2e1a72fcca58-7b22668efe6mr11556484b3a.20.1762841542634;
        Mon, 10 Nov 2025 22:12:22 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ca1e7b19sm13755722b3a.32.2025.11.10.22.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 22:12:22 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: mhocko@suse.com
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	hannes@cmpxchg.org,
	jack@suse.cz,
	joel.granados@kernel.org,
	kyle.meyer@hpe.com,
	lance.yang@linux.dev,
	laoar.shao@gmail.com,
	leon.huangfu@shopee.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mclapinski@google.com,
	mkoutny@suse.com,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	tj@kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for on-demand stats flushing
Date: Tue, 11 Nov 2025 14:12:13 +0800
Message-ID: <20251111061214.70785-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <aRHMWewcW41Vdzed@tiehlicka>
References: <aRHMWewcW41Vdzed@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Nov 10, 2025 at 7:28 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 10-11-25 18:19:48, Leon Huang Fu wrote:
> > Memory cgroup statistics are updated asynchronously with periodic
> > flushing to reduce overhead. The current implementation uses a flush
> > threshold calculated as MEMCG_CHARGE_BATCH * num_online_cpus() for
> > determining when to aggregate per-CPU memory cgroup statistics. On
> > systems with high core counts, this threshold can become very large
> > (e.g., 64 * 256 = 16,384 on a 256-core system), leading to stale
> > statistics when userspace reads memory.stat files.
> >
> > This is particularly problematic for monitoring and management tools
> > that rely on reasonably fresh statistics, as they may observe data
> > that is thousands of updates out of date.
> >
> > Introduce a new write-only file, memory.stat_refresh, that allows
> > userspace to explicitly trigger an immediate flush of memory statistics.
> > Writing any value to this file forces a synchronous flush via
> > __mem_cgroup_flush_stats(memcg, true) for the cgroup and all its
> > descendants, ensuring that subsequent reads of memory.stat and
> > memory.numa_stat reflect current data.
> >
> > This approach follows the pattern established by /proc/sys/vm/stat_refresh
> > and memory.peak, where the written value is ignored, keeping the
> > interface simple and consistent with existing kernel APIs.
> >
> > Usage example:
> >   echo 1 > /sys/fs/cgroup/mygroup/memory.stat_refresh
> >   cat /sys/fs/cgroup/mygroup/memory.stat
> >
> > The feature is available in both cgroup v1 and v2 for consistency.
> >
> > Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Thanks!
>

Thank you for your review.

Thanks,
Leon

[...]


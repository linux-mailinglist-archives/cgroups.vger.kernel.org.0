Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5197E10A5DF
	for <lists+cgroups@lfdr.de>; Tue, 26 Nov 2019 22:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKZVSI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Nov 2019 16:18:08 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42289 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKZVSI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Nov 2019 16:18:08 -0500
Received: by mail-qt1-f196.google.com with SMTP id g19so2831756qtv.9
        for <cgroups@vger.kernel.org>; Tue, 26 Nov 2019 13:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UxuYqAB1+sZp7JMrA723Vnvj2TJU247zW2JqXDmxh+Y=;
        b=MeFi57ksDzZuiI+rRmvnuaH9eGpOIA97ht+61CTJX3PjfQwas79hB4bfbcC+I121yD
         vrXmqV48XpL3ZRQmQdTbfGtRkgUsItjTnvzXnLV5kQO2fzN7qH4FjVR8uU8ATjTdI+cV
         H7ngHW6bt+TP3IgwpUy9/lMzb7NkwlJnW3nxq41TFkDZwucJPYliobKKOjXeTkWKOwVz
         kKF2FldCTyo3KHMCsHuPCwD0nc2adg6aiAtXCARYvReTkjZW644kF1sV6Gm8tBcVrzdf
         LvtIl/QPwqnjajm3krXrFBcLmm70qkMGZCrjZzI4dLsAMztPbAsvhJM2JZPOSCcv1p4F
         yGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UxuYqAB1+sZp7JMrA723Vnvj2TJU247zW2JqXDmxh+Y=;
        b=aQ4EN5jI6E+aVWG1LLoF0Qofq9ISPQ0EtyLO9RLR6ZBScZVMf2EFUGyn35oDR/V6dh
         dgEMVQtIVwbNnTYWC/NOll4f5mkJUEHZTNxxlH2BxFsOSicRSVRI167tBMfqX6bBMvxZ
         bo/Vs3+CXUlqUs1ynzCgdA/bMMhos7fcKlPSvxxglfUEaD6PZkKQmK1fc+MBpHOrPpJ3
         SRrLjfypzp4/7wt1TlWVi4weE7PDG/CTrEsUWit/Y6OEsKSkSwiYmvjGEf+As9BMTlEL
         ggWLS8nt7VUukt9rFOsTZcDLdD/SKXiv/PFBN/wCOViNNRtUilHnsiOfa3+g/ZHGeyS+
         S7QA==
X-Gm-Message-State: APjAAAX5eb11EZ52Kj5ht7BLYMUU2j+Q5M5WzJZ2E+A4ysJ04OoYSLxF
        wioB9hrIPltcEm2Bad6YW7OBeA==
X-Google-Smtp-Source: APXvYqxyv5KeSwe8ihxmxf1Vc6tW6II609qAUCHa7i47ZxJHvQYcw9SxHTKaRpdDojfUN5bAlD7smA==
X-Received: by 2002:ac8:53c5:: with SMTP id c5mr19807517qtq.348.1574803087005;
        Tue, 26 Nov 2019 13:18:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:4408])
        by smtp.gmail.com with ESMTPSA id r4sm5677411qkd.9.2019.11.26.13.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 13:18:06 -0800 (PST)
Date:   Tue, 26 Nov 2019 16:18:05 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     cgroups@vger.kernel.org, mike.kravetz@oracle.com, tj@kernel.org,
        lizefan@huawei.com, almasrymina@google.com
Subject: Re: [PATCH v2] mm: hugetlb controller for cgroups v2
Message-ID: <20191126211805.GA617882@cmpxchg.org>
References: <20191126195600.1453143-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126195600.1453143-1-gscrivan@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 26, 2019 at 08:56:00PM +0100, Giuseppe Scrivano wrote:
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 2ac38bdc18a1..5a6b381e9b92 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -283,10 +283,55 @@ static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
>  	}
>  }
>  
> +static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
> +{
> +	int idx;
> +	u64 val;
> +	bool write_raw = false;
> +	struct cftype *cft = seq_cft(seq);
> +	unsigned long limit;
> +	struct page_counter *counter;
> +	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(seq_css(seq));
> +
> +	idx = MEMFILE_IDX(cft->private);
> +	counter = &h_cg->hugepage[idx];
> +
> +	switch (MEMFILE_ATTR(cft->private)) {
> +	case RES_USAGE:
> +		val = (u64)page_counter_read(counter);
> +		break;
> +	case RES_LIMIT:
> +		val = (u64)counter->max;
> +		break;
> +	case RES_MAX_USAGE:
> +		val = (u64)counter->watermark;
> +		break;

This case is dead code now.

> +	case RES_FAILCNT:
> +		val = counter->failcnt;
> +		write_raw = true;
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	limit = round_down(PAGE_COUNTER_MAX,
> +			   1 << huge_page_order(&hstates[idx]));
> +
> +	if (val == limit && !write_raw)
> +		seq_puts(seq, "max\n");

This branch applies (or should apply!) only to RES_LIMIT, never
RES_USAGE or RES_FAILCNT.

> +	else if (write_raw)
> +		seq_printf(seq, "%llu\n", val);

This applies only to RES_FAILCNT

> +	else
> +		seq_printf(seq, "%llu\n", val * PAGE_SIZE);

And this applies to RES_USAGE and RES_LIMIT.

But this seems unnecessarily obscure. Can you just put the
seq_printf()s directly into the case statements?

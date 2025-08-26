Return-Path: <cgroups+bounces-9412-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E646AB3568F
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 10:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542691B63575
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A632F7454;
	Tue, 26 Aug 2025 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WtMtKhBF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ADE2F744D
	for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196356; cv=none; b=J3NhqB9W541AXdoFeoz5alvGf9KvvZu5C6984voNWs49eFGmSBgyT0y7PPiFH3BL0+g3P22DCn97zhEb/CX/uTTciI2SYvEkOVRten4ysejxgvDUesg6wC8qQKxBtTp86f9w/3VOCKq7Vugjwx7YoX9YUGDp5+46EfehY8zsyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196356; c=relaxed/simple;
	bh=JyZj+v7cjT+GKrDjqAL2pG7uhTQOzD4kZ8yNl3Oc02o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaS74tZaThdKm8S3WU+bvvjoWbsU8MK1pPf9lS9hoRtzNH6PNtzJa5nmu3juQ3da3qy8WpK7ciGCXPMIpMk3utncdOFThmVnurxN+XuKrVnINzY5FvXCZrw5Dv62gNZxsMNQ3ao+zTjnhQ8clpkcD/9O6R/Kj3RRJHu4CQECQog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WtMtKhBF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24456ce0b96so53085995ad.0
        for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 01:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756196353; x=1756801153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cMS0r+u2h/iTEEDa2JnG40IneRDk2Rmyb1TjG2qsrak=;
        b=WtMtKhBFG4/YlQPBlmUl2778f7BfIuEGoZPMhJvfFGrUhBpzAb3e7nIFuDcIzfgkDI
         b6fjuRrGjLsCXXQDciC5M4IQ3Teqzx4wVS3Dc46W4lJS1NL4k3XF7eaJ0ooVcTnIHfry
         Bg2MN4IOsM9ZujhWxlMpvkisFtMo8kny7foNqGj/KNNv0xwmKJ1+iC4wMIaGVsNmb1p1
         J/U63uKL6+lFAY6V0qF9QdOEbUsusnpfHOqX9mjE5H+mAgAGQBKIaROftfWggu5vNQ81
         V19JqJ3mItHYQ5mNEhn5uhk72a5jSgkzu9LN5y5uzBuINvrAXVgDO2X//E5oHd87JG0D
         +R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196353; x=1756801153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMS0r+u2h/iTEEDa2JnG40IneRDk2Rmyb1TjG2qsrak=;
        b=Bxa5N+B7Fn2nVc8+NRVM28Q7+cjLBpUnhzZ2HVUnZP7hAxB/7RYzwHT16KgDtRGlSP
         jv0l5XHV8erYMiYl/f7f1dzZHGKr0aX+uVsiRxFdRxBOc2H+q8KsEyxa+iIYL70UYXBK
         cj3wMAfltn7hBweLj3BEVDhbOEtR8ksMlgP0syQ+p2UEYXgL20tcZdAwyC7N4f+3L5nM
         /71y1Lu/HemBydAh01EMTbTQ0mjv7uc5moTy+vUq/+O6Vuy6BjGufgcjTX/wqtxYb9lY
         kz4vN4IT3PKZ3VFx7giY/UgHa4EtgnRoG44bnAik/85wjvY+qunLED41ogZvPw78gjkM
         C72w==
X-Forwarded-Encrypted: i=1; AJvYcCWFDzehdSLzdtKJx7HFu9nTZCQHdb0vo15496NU/0Dg3Bl89RvIRP/J/iJPoyVweqs+A8mdO+0Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxTyCKAN2/cKIpyeFWpFT9T/VuNbNnqYsBtQZjt4DgPJuepRmap
	bDzgd3s/ELEaxUFVTeY0Y/WPgfQAj7JCYh+ZpQm3NAV3OKsH+whPBHe/2AEDlsanoQ==
X-Gm-Gg: ASbGncu93Rmc79ZBtaZzZ36WcHtOTvHHyvAUCz8idO3r60rqRRQKF9l68mCxmNIKh/4
	bkQ5d7yNQ8zjtIFU3OC22VXvHjRQxnOCxoEk0i2PASoTDilefg9jlk2vfqNVB/6vMJNW9Nfr91/
	tIOxJQ7opuEsLpOSwbllTeES5kNR5+F4V2RGaOLDW5vCeVA568iUzQc8m+Hwy0tLVPIzo6woqBY
	S+jG280sUFDR6v8p8Z3DItW+E+qamZwaOw9HMMFpUfhVy5S3zpKVC4qVcBDb4EoJmkf+TWb2Rnl
	5ZNDi5Ci4gRjM6SGH3kvvjeDLq66tLL9rzJrpNzQxj2MSwK6TzQMsftNaJfoc212QTDN9yn3wmO
	dFCsrQSuJIOE0vMlryKqJsC8q+MiRu1zqHWh6VMKFQQReV60=
X-Google-Smtp-Source: AGHT+IERq7IbHI6i6QAceI8ZDKCRkfwD5BJDAiSoHTiLHlJxaHzCN4KTQ0KZLaUUWxCjumc1sgN4Gg==
X-Received: by 2002:a17:902:da84:b0:246:80ef:8808 with SMTP id d9443c01a7336-248753ada95mr7807865ad.3.1756196353414;
        Tue, 26 Aug 2025 01:19:13 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b0b04sm89237675ad.44.2025.08.26.01.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:19:12 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:19:04 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: xupengbo <xupengbo@oppo.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>, Aaron Lu <aaron.lu@intel.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	xupengbo1029@163.com
Subject: Re: [PATCH v3] sched/fair: Fix unfairness caused by stalled
 tg_load_avg_contrib when the last task migrates out.
Message-ID: <20250826081904.GB87@bytedance>
References: <20250826075743.19106-1-xupengbo@oppo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826075743.19106-1-xupengbo@oppo.com>

On Tue, Aug 26, 2025 at 03:57:42PM +0800, xupengbo wrote:
> When a task is migrated out, there is a probability that the tg->load_avg
> value will become abnormal. The reason is as follows.
> 
> 1. Due to the 1ms update period limitation in update_tg_load_avg(), there
> is a possibility that the reduced load_avg is not updated to tg->load_avg
> when a task migrates out.
> 2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
> calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
> function cfs_rq_is_decayed() does not check whether
> cfs->tg_load_avg_contrib is null. Consequently, in some cases,
> __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
> updated to tg->load_avg.
> 
> I added a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
> which blocks the case (2.) mentioned above.
> After some preliminary discussion and analysis, I think it is feasible to
> directly check if cfs_rq->tg_load_avg_contrib is 0 in cfs_rq_is_decay().
> So patch v3 was submitted.
> 
> Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
> Signed-off-by: xupengbo <xupengbo@oppo.com>

With the below typo fixed:

Tested-by: Aaron Lu <ziqianlu@bytedance.com>
Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>

> ---
> Changes:
> v1 -> v2: 
> - Another option to fix the bug. Check cfs_rq->tg_load_avg_contrib in 
> cfs_rq_is_decayed() to avoid early removal from the leaf_cfs_rq_list.
> - Link to v1 : https://lore.kernel.org/cgroups/20250804130326.57523-1-xupengbo@oppo.com/
> v2 -> v3:
> - Check if cfs_rq->tg_load_avg_contrib is 0 derectly.
> - Link to v2 : https://lore.kernel.org/cgroups/20250805144121.14871-1-xupengbo@oppo.com/
> 
> Please send emails to a different email address <xupengbo1029@163.com>
> after September 3, 2025, after that date <xupengbo@oppo.com> will expire
> for personal reasons.
> 
> Thanks,
> Xu Pengbo
> 
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..df348cb6a5f3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4062,6 +4062,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  	if (child_cfs_rq_on_list(cfs_rq))
>  		return false;
>  
> +	if (cfs_rq->tg_laod_avg_contrib)
                       ~~~~
typo: tg_load_avg_contrib

> +		return false;
> +
>  	return true;
>  }
>  
> 
> base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
> -- 
> 2.43.0
> 


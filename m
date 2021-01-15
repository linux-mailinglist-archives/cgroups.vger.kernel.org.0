Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9595C2F8681
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 21:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbhAOUUn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 15:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbhAOUUm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 15:20:42 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D14C061757
        for <cgroups@vger.kernel.org>; Fri, 15 Jan 2021 12:20:02 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id s6so4583595qvn.6
        for <cgroups@vger.kernel.org>; Fri, 15 Jan 2021 12:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=17vzS6L8VVV24OmDmZNyqFRhRB1Jb2yRyiJ9OkEqTr4=;
        b=tw6kLMYLoAN7TOMqUxemf47gDQUJB2azmtU+AzfA0VXBXz8CxnedZJBSc69EX+FaOW
         QT/5owhriHG938HeqiSNTNyWvCXlP0b0mBLNVjEkXM+U7hYdoGb7SPthhyxyfSAMUS0m
         NHWs2B31OgVB7A/p0glABnCQJTPzOsuQALdZTNI2yzXXWNIFC4syJHdOeo5EHL9Varvl
         0nHtsvz6MOswhCTa5T+lJFoAyXSna3lXzkQxP4LTWgMCJ3KsKxnClToL8CK+q0snAKgF
         yAU9x4kbNHKvu89Rg1CkEuaFnVqS2WVCsfgmXzJLHPlDyRrk1LkSXBGBB8zNyWT3mut/
         cRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=17vzS6L8VVV24OmDmZNyqFRhRB1Jb2yRyiJ9OkEqTr4=;
        b=crh8Oz6lNGo3hBsr+5c95guQRooyhb4z10Oos03yXUISOHjCG46coDpWab14YaZmP9
         T4FcnThH00yVjBY1htsxpNGpommT/oSZuVsEXJr7YO5Myq/1hvhKhYwP0tf2JjonQyg0
         V+q9SETAyKtgt7GQ50YJz54Uw9XeramyXR3uDaqbg1XWrA9UgH4ELetY3w6nR4moTJEL
         8+eh9m4KG03ZvVnyb5KjmLGwjRqX4KrIAnnKzWx9XXOXDXfMRAYPj3t/fujDvEcG9P2f
         xwOJS9T504iy6Nr74/qEPxseFbyeGwdTGuMCAW52ywg39GBO1H5uDQPGEdnYyw1yzBV7
         Huzg==
X-Gm-Message-State: AOAM533j+bIyy9XQOTWP8htO6evW3JoEq8fbHFCVQRppblrpba61VkaT
        FjYdx3Ynv70dcVgM7mfaRso=
X-Google-Smtp-Source: ABdhPJzCcdj4yC1yffBaQN9us1TRzp+wPlE72WwZ7MAPWirnHStj+95hjxIwMUbsPt/EMYvNoGUm8Q==
X-Received: by 2002:a0c:9e50:: with SMTP id z16mr13660432qve.13.1610742001423;
        Fri, 15 Jan 2021 12:20:01 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:97cc])
        by smtp.gmail.com with ESMTPSA id a3sm5405522qtp.63.2021.01.15.12.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:20:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 15 Jan 2021 15:19:15 -0500
From:   Tejun Heo <tj@kernel.org>
To:     wu860403@gmail.com
Cc:     cgroups@vger.kernel.org, 398776277@qq.com
Subject: Re: [PATCH] tg: add cpu's wait_count of a task group
Message-ID: <YAH4w5T3/oCTGJny@mtj.duckdns.org>
References: <20210115143005.7071-1-wu860403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115143005.7071-1-wu860403@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Jan 15, 2021 at 10:30:05PM +0800, wu860403@gmail.com wrote:
> -	seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
...
> +	seq_printf(sf, "nr_periods %d\n"
> +		   "nr_throttled %d\n"
> +		   "throttled_usec %llu\n",
> +		   cfs_b->nr_periods, cfs_b->nr_throttled,
> +		   throttled_usec);

This is interface breaking change. I don't think we can do this at this
point.

> @@ -8255,6 +8265,19 @@ static int cpu_extra_stat_show(struct seq_file *sf,
>  			   "throttled_usec %llu\n",
>  			   cfs_b->nr_periods, cfs_b->nr_throttled,
>  			   throttled_usec);
> +		if (schedstat_enabled() && tg != &root_task_group) {
> +			u64 ws = 0;
> +			u64 wc = 0;
> +			int i;
> +
> +			for_each_possible_cpu(i) {
> +				ws += schedstat_val(tg->se[i]->statistics.wait_sum);
> +				wc += schedstat_val(tg->se[i]->statistics.wait_count);
> +			}
> +
> +			seq_printf(sf, "wait_sum %llu\n"
> +				"wait_count %llu\n", ws, wc);
> +		}

What does sum/count tell?

Thanks.

-- 
tejun

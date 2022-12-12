Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAB664AA2B
	for <lists+cgroups@lfdr.de>; Mon, 12 Dec 2022 23:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiLLWYG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 17:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbiLLWYF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 17:24:05 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89988B7C1;
        Mon, 12 Dec 2022 14:24:04 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 142so9202799pga.1;
        Mon, 12 Dec 2022 14:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DduZ36/gNNuK+m5qHFBGb7Zr62cBswC5K6+2kXn9vQE=;
        b=KUybaHVVN3vB51GqoRWpHL2dDTx2qMFPypuONf/AmhxlZr55HRmLSgY5wpkSn1navb
         dyTi2H+7ZAZtAStM5HvFjAtD4ljlq5qcHJKd+rnNIe5MPoHkVUIrXEk2wYr8Qawciwe+
         F3wYqQXQWHtzDjn2y/qMSnQuc+Cr3KqWgWxsE+EdXuTMEG6aOD9xbM9akomuQE/5nRWp
         AnAhL9RTKC4y0TrpDLXYj32qftrZhQQcovsuqi1GPshjIQuvDA8BDqaQ8hm82Pasqk7i
         dyTvyXn8iL4x7CjRudvASM1DyVneJ5/3auOxORwtTNf6DmwJ9N3OBtW+09+w3T0We0bI
         ixVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DduZ36/gNNuK+m5qHFBGb7Zr62cBswC5K6+2kXn9vQE=;
        b=3IT0nUpMQdLuH+k6dyMwNhfWqgQM1Ju4+vcI0m/rpXH7ZgZo/JPlvGm6gY9gZY0fCG
         f9ini547kKPmZzamnuJ39cltLkjj6jlZwZ1OVw9jYFj7q1JLbPY7TV/nBD4GT18A7IRh
         oVpxjIwQh4AZ8dbBO4+bkRL6tTSUb3ibxyoChgbBMPSL6SLaapEGnjXJBZKKpbF8be08
         g55VMFllGo3bmDQkTWtqQWWn+5OIwYrhkxcSPTiEAqzPCbIbW8Jggof2b9Du1QGf0VH8
         N1WGDwI3JfShyor5+lBoyPLrEeHy+jKtVGWS3LepjJpHVNDb7MT4chSLRGj22y7o0LcS
         sb1Q==
X-Gm-Message-State: ANoB5pnXlLhwIdiNtq54hvT6867lVkV/k0kROGDzaDLr5WPgTH2B7Ye9
        OgNusj8Pi+CoBnQyCAommX5UAgKU4q4i5Q==
X-Google-Smtp-Source: AA0mqf7w2sY2+JO/aSuCD35Y2z4vdxNFK4vcVZCzRRxri3yF2qj1Wi8BtYvS1At5X0J6AEo3xIYmLg==
X-Received: by 2002:a05:6a00:84d:b0:566:900d:5ada with SMTP id q13-20020a056a00084d00b00566900d5adamr25516059pfk.10.1670883843884;
        Mon, 12 Dec 2022 14:24:03 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00000300b005758d26fbf7sm6301027pfk.58.2022.12.12.14.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 14:24:03 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 12:24:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: Re: [PATCH-block v2 3/3] blk-cgroup: Flush stats at blkgs
 destruction path
Message-ID: <Y5eqAtwnpfEUG0EL@slm.duckdns.org>
References: <20221211222058.2946830-1-longman@redhat.com>
 <20221211222058.2946830-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211222058.2946830-4-longman@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Dec 11, 2022 at 05:20:58PM -0500, Waiman Long wrote:
> As noted by Michal, the blkg_iostat_set's in the lockless list
> hold reference to blkg's to protect against their removal. Those
> blkg's hold reference to blkcg. When a cgroup is being destroyed,
> cgroup_rstat_flush() is only called at css_release_work_fn() which is
> called when the blkcg reference count reaches 0. This circular dependency
> will prevent blkcg from being freed until some other events cause
> cgroup_rstat_flush() to be called to flush out the pending blkcg stats.
> 
> To prevent this delayed blkcg removal, add a new cgroup_rstat_css_flush()
> function to flush stats for a given css and cpu and call it at the blkgs
> destruction path, blkcg_destroy_blkgs(), whenever there are still some
> pending stats to be flushed. This will ensure that blkcg reference
> count can reach 0 ASAP.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

But a nit below

> +	/*
> +	 * Flush all the non-empty percpu lockless lists.
> +	 */

Can you please explain the deadlock that's being avoided in the above
comment? ie. it should say why this flush is necessary.

> +	for_each_possible_cpu(cpu) {
> +		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
> +
> +		if (!llist_empty(lhead))
> +			cgroup_rstat_css_cpu_flush(&blkcg->css, cpu);
> +	}

Thanks.

-- 
tejun

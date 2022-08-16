Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85249596396
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 22:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiHPUPj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbiHPUPj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 16:15:39 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC277A776;
        Tue, 16 Aug 2022 13:15:38 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id z187so10256305pfb.12;
        Tue, 16 Aug 2022 13:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=zU1X1POINU9AFqquPUG2+wIDvwycYABzLVLgeZNxxE0=;
        b=e3Ei/n53VysaXj/X8x6hxVU3orxvP+NRLitVxM6miL6Z2bplRXrj59msWPDEv+TpZ0
         2yl6HS2NFS2NRG56vvkbWtxmHmtoPAWCYx2/I5NaQT20scQ8a/Du/5ipfD0JHD6EIThU
         b5LAgm7F2nRktClrucEeVGHdY2V48Ab3VWlkIfVCOAAmrL8c9PA/2N6l5fzSwQoWHrd0
         jGWz1XJ3OIkjLF1qqX1ue8vcvlPz1ljf5KX7n4xKC1MTXYaIpmO7xyf0jq93o0CqGe3M
         w1I3TKlJyXv9XsUfC+G6xivbZCl63jTICYtJVH8CizE3buHBcH3s8XiMU7BN16NA5zap
         pq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=zU1X1POINU9AFqquPUG2+wIDvwycYABzLVLgeZNxxE0=;
        b=oH8FEc+w688PjIJzD8LEqw7D6mCzrvaMgP/p7GsJinjPlz6IxMh/+w0jX2tHWaonHS
         iYwz4OQe5xhrqhg/p26GW7azMDs6pkG2IYgBtK4seFneYciZ4p8WvABIK9NVOJELEw84
         NW9AmN8c+UmZwIG9QK9X5Dbv039uhq7AOQvSvzjJUz3cl16+VYEveSwQDlnOcFRYSn/R
         NqHdyHdCRz/3DR2pa+2dDCX9tpYcHR0ze+STqw6dAjlSeqPTm+FI1pfSu+kNs0XTc+ks
         wYRT4/ntDzNaC9atv+gLN60J7PquKgeZaEgfhfcIvoFJQEbIfXV70vx5cosoomliCSoz
         i2DA==
X-Gm-Message-State: ACgBeo2r9Lfu/2L/kdYXQmQZL54YT59MIYmXjAnGMa8IORvvA5uPxJuj
        sOZFr3Rvxh/sq4FB2x/8xZI=
X-Google-Smtp-Source: AA6agR4wy5xaDqMLslgTGwBemunicFBuJMkswuk5RCzivgHcTvzbgianZH7PPy5j4hdCZxzcS88+kA==
X-Received: by 2002:a05:6a00:3106:b0:52d:53d4:ccc9 with SMTP id bi6-20020a056a00310600b0052d53d4ccc9mr22815752pfb.9.1660680938146;
        Tue, 16 Aug 2022 13:15:38 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090a70c500b001f23db09351sm6593841pjm.46.2022.08.16.13.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 13:15:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 10:15:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 3/3] cgroup/cpuset: Keep user set cpus affinity
Message-ID: <Yvv66EWygCwHUCqy@slm.duckdns.org>
References: <20220816192734.67115-1-longman@redhat.com>
 <20220816192734.67115-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816192734.67115-4-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 16, 2022 at 03:27:34PM -0400, Waiman Long wrote:
> +static int cpuset_set_cpus_allowed_ptr(struct task_struct *p,
> +				       const struct cpumask *mask)
> +{
> +	cpumask_var_t new_mask;
> +	int ret;
> +
> +	if (!READ_ONCE(p->user_cpus_ptr)) {
> +		ret = set_cpus_allowed_ptr(p, mask);
> +		/*
> +		 * If user_cpus_ptr becomes set now, we are racing with
> +		 * a concurrent sched_setaffinity(). So use the newly
> +		 * set user_cpus_ptr and retry again.
> +		 *
> +		 * TODO: We cannot detect change in the cpumask pointed to
> +		 * by user_cpus_ptr. We will have to add a sequence number
> +		 * if such a race needs to be addressed.
> +		 */

This is too ugly and obviously broken. Let's please do it properly.

Thanks.

-- 
tejun

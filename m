Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCA77BC8F4
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 17:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjJGP54 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 11:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbjJGP54 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 11:57:56 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409E5B9;
        Sat,  7 Oct 2023 08:57:55 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-577e62e2adfso2012293a12.2;
        Sat, 07 Oct 2023 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696694275; x=1697299075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqV8KtIkUDb0Wc1yq1sRlVDydB3Tj3UfRPNMUmN2hVY=;
        b=dgjaHjZfkMFOB7GGxYC3VsF0DZTdCAQmXAi+We6rmjz0hvDmcPSRge7SQInUgIWIkr
         OnIlwQELnqvLBuKlMGGMsC8JscwGcUq2eCVdjLt23hneCUUHJADyzbMlAasE6o3KR1mY
         X9UyAzpakYbugvWfVleiUms+d9hOHK0UYcdnRNEW3SyS7YCgfNFxEeenPzRaS3V4TSas
         8XuM6nevxurN6bseHa3ZFKrc5tTq5L5aaVz/NGR3ujnKtR7DQkjujrnBzmALq3Wd5xAP
         Iha9rV2yH0xS7FTmVr/Ij4mp6b6QHK1kmDuy00/0Q8AyiHL0mTBRd35ZNW7XtKUM0qqP
         NWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696694275; x=1697299075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqV8KtIkUDb0Wc1yq1sRlVDydB3Tj3UfRPNMUmN2hVY=;
        b=bvETHUvjHXZRl+dBvD5tl/U3wXcCX8n2X0I3pJPRspsL7uOwxZ0sv90D8kXkHtAq99
         1ahaiw3fslw3Ak/ZKBezcfZZ0JOAlm6iwFDKvX4YHcCzr8RixBju8HYFVbFDv+phLCnC
         yzBtqP+icGMsLGl2j5ambUorv5VYuC+Y69y3q+PMKY6/vo24SSBDGoXAttfqc3P7gKk6
         z+szcnsZP4KukLGHZRzfjVizqU/I0p32Hgvl4xkdSS0wGEemeTGTGo6IO085HH3J+qDM
         1WnrfWrfbVsCek+FnvK9GKzmAo/cR6x/nf9KrHTDs12ZgrYKukL8XCHxunrodE4gdEY/
         HjRA==
X-Gm-Message-State: AOJu0YzBBLVp+CmmMUgCpBE0rB0Xkovi2c6p8RnRb1NL960+/TYPMlc9
        Vn7dmj0QDFAgJtRptIzDS58=
X-Google-Smtp-Source: AGHT+IFN/gZY0+BJYYYR2WuThcx4S5VRT6cPHJ62Sqfs7KdKnp5mzkw0doBmVczEp+X5k3Z9wN/hTw==
X-Received: by 2002:a17:90a:b283:b0:274:c637:4b97 with SMTP id c3-20020a17090ab28300b00274c6374b97mr9958823pjr.16.1696694274640;
        Sat, 07 Oct 2023 08:57:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cced])
        by smtp.gmail.com with ESMTPSA id o24-20020a17090ad25800b00276b60aa43bsm7179307pjw.17.2023.10.07.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 08:57:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 7 Oct 2023 05:57:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
        sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 3/8] bpf: Add kfuncs for cgroup1 hierarchy
Message-ID: <ZSGAACHHNAYbk34i@slm.duckdns.org>
References: <20231007140304.4390-1-laoar.shao@gmail.com>
 <20231007140304.4390-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007140304.4390-4-laoar.shao@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Oct 07, 2023 at 02:02:59PM +0000, Yafang Shao wrote:
> +
> +/**
> + * bpf_task_cgroup_id_within_hierarchy - Retrieves the associated cgroup ID of a
> + * task within a specific cgroup1 hierarchy.
> + * @task: The target task
> + * @hierarchy_id: The ID of a cgroup1 hierarchy
> + */
> +__bpf_kfunc u64 bpf_task_cgroup1_id_within_hierarchy(struct task_struct *task, int hierarchy_id)
> +{
> +	return task_cgroup1_id_within_hierarchy(task, hierarchy_id);
> +}
> +
> +/**
> + * bpf_task_ancestor_cgroup_id_within_hierarchy - Retrieves the associated
> + * ancestor cgroup ID of a task within a specific cgroup1 hierarchy.
> + * @task: The target task
> + * @hierarchy_id: The ID of a cgroup1 hierarchy
> + * @ancestor_level: The cgroup level of the ancestor in the cgroup1 hierarchy
> + */
> +__bpf_kfunc u64 bpf_task_ancestor_cgroup1_id_within_hierarchy(struct task_struct *task,
> +							      int hierarchy_id, int ancestor_level)
> +{
> +	return task_ancestor_cgroup1_id_within_hierarchy(task, hierarchy_id, ancestor_level);
> +}

The same here. Please make one helper that returns a kptr and then let the
user call bpf_cgroup_ancestor() if desired.

Thanks.

-- 
tejun

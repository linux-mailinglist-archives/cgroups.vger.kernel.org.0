Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E9C7BC8EF
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 17:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343992AbjJGPzh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 11:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343934AbjJGPzh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 11:55:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6C0B9;
        Sat,  7 Oct 2023 08:55:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c5ff5f858dso23506695ad.2;
        Sat, 07 Oct 2023 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696694135; x=1697298935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1G8zMx/IRtCAaVCqJMlKRbbFzKuOBpfD13FT0bpaRA=;
        b=QvnsyW8Ddr4JEpEZDI6RKdDrI/UAEds9VNcK0cIrKHcY9onqZnJxNHdedy+FU66rsP
         RQIsKFchhxzOOqfNswThdGvEINDJtbh7eiYKGGLdWmyk7bs5Tgi0cQCdR7jk2tIjr/w4
         0ISunovSOumWioAdhP0q1b4wK81bWBxeKMUxEFenDIY/dTNoqHwJIG/vEkPy5E0QJkW7
         IWkjKMqlMUhaSY/Ly705bYSJWo64e/VhcoEyJC8BBMsemC8Rut4gkF6mvwM+j7EcloQG
         GSnKz1xneNR+wdABUuB5dSKPQtCTsy065izk31SqXfxmWPA5GcD+VALZ81jeC/lgcRH0
         EH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696694135; x=1697298935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1G8zMx/IRtCAaVCqJMlKRbbFzKuOBpfD13FT0bpaRA=;
        b=Ep4NG25S1ylYtAuOJDGuIpXaPwoAmpGlVHgGtT6Tht/w/zUv158FHD3Abx4iC+Vp4e
         BB3TPvNo4B0Zjmtp0t6eBnIMs3/Tz1woflZwAbGWMFSUWQi+d6UF+RW+fu1f2mqJSKJq
         kjCjN719kd4C1CfTQA8VRjTnEGONqxMXsZaD2CUIj305HGatH+5DKqOB2EniCBSmnC/p
         o6XRqhEIBQjFsARftIIO2DKMmGUlvRQxz/W+mN/jg/p+466KT1oEvaWY71VUM9jq5psS
         qLnpYskjXxT2VvIpk8mT2+/6hxodEd0aPsrvJm3sQ94c5DfxNrbh4LgFKN8EvzCv0Xzy
         mI9g==
X-Gm-Message-State: AOJu0Yznn4wi4JwngIMQHVT2XwAXEvwDQEG2SJmMG++iNO6iMjh9M4C5
        j9xO76MyNILjG9U9YQn2GrM=
X-Google-Smtp-Source: AGHT+IHPaFRpOWjSHaf2JZHgocMDfSOytigwtYZuNqiwwLbTCR3iFo74pw7MhbRZ7X52Mb1J1tYieg==
X-Received: by 2002:a17:902:ecc8:b0:1c4:4a4d:cda with SMTP id a8-20020a170902ecc800b001c44a4d0cdamr12645064plh.15.1696694134901;
        Sat, 07 Oct 2023 08:55:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cced])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902a5cc00b001bdb85291casm5996485plq.208.2023.10.07.08.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 08:55:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 7 Oct 2023 05:55:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
        sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 2/8] cgroup: Add new helpers for cgroup1
 hierarchy
Message-ID: <ZSF_daEXs8xpvlo0@slm.duckdns.org>
References: <20231007140304.4390-1-laoar.shao@gmail.com>
 <20231007140304.4390-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007140304.4390-3-laoar.shao@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Sat, Oct 07, 2023 at 02:02:58PM +0000, Yafang Shao wrote:
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index b307013b9c6c..65bde6eb41ef 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -71,6 +71,8 @@ struct css_task_iter {
>  extern struct file_system_type cgroup_fs_type;
>  extern struct cgroup_root cgrp_dfl_root;
>  extern struct css_set init_css_set;
> +extern struct list_head cgroup_roots;
> +extern spinlock_t css_set_lock;

css_set_lock was already out here but why do we need to move cgrou_roots to
this header?

> +/**
> + * task_cgroup_id_within_hierarchy - Retrieves the associated cgroup ID from
> + * a task within a specific cgroup1 hierarchy.
> + * @task: The task to be tested
> + * @hierarchy_id: The hierarchy ID of a cgroup1
> + *
> + * We limit it to cgroup1 only.
> + */
> +u64 task_cgroup1_id_within_hierarchy(struct task_struct *tsk, int hierarchy_id)
> +{
...
> +}
> +
> +/**
> + * task_ancestor_cgroup_id_within_hierarchy - Retrieves the associated ancestor
> + * cgroup ID from a task within a specific cgroup1 hierarchy.
> + * @task: The task to be tested
> + * @hierarchy_id: The hierarchy ID of a cgroup1
> + * @ancestor_level: level of ancestor to find starting from root
> + *
> + * We limit it to cgroup1 only.
> + */
> +u64 task_ancestor_cgroup1_id_within_hierarchy(struct task_struct *tsk, int hierarchy_id,
> +					      int ancestor_level)
> +{
...
> +}

I'd much prefer to have `struct group *task_get_cgroup1_within_hierarchy()`
then the caller can do cgroup_ancestor() itself.

Thanks.

-- 
tejun

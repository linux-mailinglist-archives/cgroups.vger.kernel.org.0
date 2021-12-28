Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C422480C05
	for <lists+cgroups@lfdr.de>; Tue, 28 Dec 2021 18:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhL1RRq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Dec 2021 12:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbhL1RRp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Dec 2021 12:17:45 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0757C06173F
        for <cgroups@vger.kernel.org>; Tue, 28 Dec 2021 09:17:45 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s1so14955976pga.5
        for <cgroups@vger.kernel.org>; Tue, 28 Dec 2021 09:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ivoEdS/CxNoGT7D8SqF0HNjUYAr9Hq6dlyJRhMADj5U=;
        b=mE6AwGIQ3sval0uBHIKCCq+gF2bQ7hglSjPsTsleu2wn0+ggU2al7iWlZSUBWYp6/U
         L2ClRIPzUoRTvHwD/IoZcmKsJvbS5ND/UrnQl+3+TfS3g6V8fIkCuLr2Fle/F2GL6D1y
         E6BXtrTkjuOBPsiaG0tMdkhQy+RW1SwuGVTxXj1KuwQaLfRc6I2IN+GUMo93p1EVtVyJ
         2FUGCZzPjE//OZQsKHMVP2fQbmyeOWU82IN/kXeEizDHzXnvqCziCoOIRj3799XlISo5
         aENIZTOWJLYG1KnocCv8m3Me3F4WGRrooPpJjvRFa6iM92TmU0WyOvaSVg6CdAuCgUPb
         l6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ivoEdS/CxNoGT7D8SqF0HNjUYAr9Hq6dlyJRhMADj5U=;
        b=XV0f3N+Rbs1i4rrXat1It3iWQEX1bJW5ccqdFNkr9Qn6SVFMldXLshH/aI6PbmF+ua
         /B5vTvST46l6GUqJA1IqqSwUKjXrit9oe3i7hXU+Nm4kjkhKmSgTyL2GQYjownlewg3Y
         nP/Rdp6hQwLKtXlCpyQSBlVmBGBAI3SVGyAwkRAruWrtX/IW9VivVpLdHukldeYvvKI8
         vaUs8f0GKHLThIpGCLx5cvTbYRz0NPBpAAAknKZhdFFNBGL71si20Zr03Wxg/cL5BIXT
         Lb73jNCjM7Wqy/3py9KIpYac+OLebda9OpvEW50oar40Qgibcbqc4J8Jvvzw2myyzzxN
         ylXQ==
X-Gm-Message-State: AOAM533ryj/FYi+97z/1VB+WKkPpgzwJiWyjLehHNYMcZLE0YBthLmYK
        EIgJnoBBLlGx5MCkAt21vi/yzw==
X-Google-Smtp-Source: ABdhPJxD3vDyn9OpaKKR9zvezH3CNjriesx8x9r68KUytLQi20VcY65aVOYCHnVEJaUNScucolLojA==
X-Received: by 2002:a63:8b4c:: with SMTP id j73mr19846740pge.81.1640711864988;
        Tue, 28 Dec 2021 09:17:44 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l6sm20339575pfu.63.2021.12.28.09.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 09:17:44 -0800 (PST)
Date:   Tue, 28 Dec 2021 17:17:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, dmatlack@google.com, jiangshanlai@gmail.com,
        kvm@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: Move VM's worker kthreads back to the original
 cgroups before exiting.
Message-ID: <YctGtWzYcNP2iTaN@google.com>
References: <20211222225350.1912249-1-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222225350.1912249-1-vipinsh@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 22, 2021, Vipin Sharma wrote:
> kthreadd_task is not an exported symbol which causes build errors if KVM
> is built as a loadable module. Both users (kvm_main & vhost) of
> cgroup_attach_task_all(), have the same issue, therefore, using
> kthreadd_task as a default option is chosen when the API is called with
> NULL argument.

...

> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index 81c9e0685948..81d4b2f2acf0 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -51,6 +51,8 @@ bool cgroup1_ssid_disabled(int ssid)
>   * @from: attach to all cgroups of a given task
>   * @tsk: the task to be attached
>   *
> + * If @from is NULL then use kthreadd_task for finding the destination cgroups.
> + *
>   * Return: %0 on success or a negative errno code on failure
>   */
>  int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
> @@ -58,6 +60,9 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
>  	struct cgroup_root *root;
>  	int retval = 0;
>  
> +	if (!from)
> +		from = kthreadd_task;

Rather than sully cgroup_attach_task_all() with this behavior, can't KVM do

	cgroup_attach_task_all(current->real_parent, current)

since AFAICT real_parent is guaranteed to point at kthreadd_task.

> +
>  	mutex_lock(&cgroup_mutex);
>  	percpu_down_write(&cgroup_threadgroup_rwsem);
>  	for_each_root(root) {
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index b0f7e6eb00ff..f7504578c374 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -5785,7 +5785,7 @@ static int kvm_vm_worker_thread(void *context)
>  	init_context = NULL;
>  
>  	if (err)
> -		return err;
> +		goto out;
>  
>  	/* Wait to be woken up by the spawner before proceeding. */
>  	kthread_parkme();
> @@ -5793,6 +5793,19 @@ static int kvm_vm_worker_thread(void *context)
>  	if (!kthread_should_stop())
>  		err = thread_fn(kvm, data);
>  
> +out:
> +	/*
> +	 * We need to move the kthread back to its original cgroups, so that it

Please state what is being done, not what "needs" to be done.  The need to do
something is implicit, otherwise we wouldn't be doing it.

> +	 * doesn't linger in the cgroups of the user process after the user
> +	 * process has already terminated.
> +	 *
> +	 * kthread_stop() waits on 'exited' completion condition which is set
> +	 * in exit_mm(), via mm_release(), in do_exit(). However, kthread
> +	 * is removed from cgroups in the cgroup_exit() which is called after
> +	 * exit_mm(). This causes lingering of kthreads in cgroups after main
> +	 * VM process has finished.
> +	 */
> +	WARN_ON(cgroup_attach_task_all(NULL, current));

This should not WARN, cgroup_attach_task_all() needs to perform allocations and
will fail with -ENOMEM even in the absense of kernel bugs.

>  	return err;
>  }
>  
> 
> base-commit: 5e4e84f1124aa02643833b7ea40abd5a8e964388
> -- 
> 2.34.1.307.g9b7440fafd-goog
> 

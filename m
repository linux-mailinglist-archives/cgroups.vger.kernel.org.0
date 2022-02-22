Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7753C4BF3C0
	for <lists+cgroups@lfdr.de>; Tue, 22 Feb 2022 09:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiBVIff (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Feb 2022 03:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiBVIff (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Feb 2022 03:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29860158E8B
        for <cgroups@vger.kernel.org>; Tue, 22 Feb 2022 00:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645518909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E30WgXgAZRS6lQUJeUsCZdCeBdcikCP7h9EfQ36uBTo=;
        b=UJMzrzulJM+sJcwYbHJ7oHygzi6LHm2GPOWWkp8P9E2wBv6YBEGMbFbr4cFubqKiuUOdZZ
        WWWs+4WvIobdLTQMQJuNtl2SRcTfep1422bJql3B1s/ySvb5xOwvpW+rBa7xovpQ9VBf7s
        z8uJNIENFv1/EpH+NQ5+6BREwyFPGyA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-1HXNWZrNPvCvU5OEN9wO8Q-1; Tue, 22 Feb 2022 03:35:08 -0500
X-MC-Unique: 1HXNWZrNPvCvU5OEN9wO8Q-1
Received: by mail-wr1-f70.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so8607747wrp.10
        for <cgroups@vger.kernel.org>; Tue, 22 Feb 2022 00:35:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E30WgXgAZRS6lQUJeUsCZdCeBdcikCP7h9EfQ36uBTo=;
        b=5F3ez9nxroDi63dCyspig1/w+SFqP7a6HBLH6z6Qs7lEQV9f4Idfyz3QCq05ZLSfe/
         RpNEh8G0TK1PA1k0qy20MqwMHGgRqn9TbwIz46bl2TahzD5OxBjBL1V/AJRAzfD1tjjL
         q16JTOUpziSR8LVPbCD4T8n3KW7fUQSZa1nYUgTv9h+gR+VTfEDMSj+YsisL6BhHKkNb
         onm17jymvX/5ewdbfSS7onDqe5SXHbF/C2x/G5yB5FBIYWs3hCyS0M30NXfP5VSRLAD6
         yZIPO1bZnnVgHjCNaTOjQWUh9YQAefI4O3iD+oC7fM/xOpl2iWVvtL5JGgM4tPOho2zk
         K/mQ==
X-Gm-Message-State: AOAM533dzVZldfkbLUwY7iwbz0rSiqMP18OOyT78LqlhdwVmbbBVRyHz
        9gWIYLFFjOSgQMF9I6kBGe/yYKmSk+OLSS3xEm++urWuFUWYjn7npWQMbJSNF3KBSYLyj/cQT3b
        ZeeMWkXAtNms+/usTDg==
X-Received: by 2002:a05:6000:1081:b0:1e3:16d0:1c47 with SMTP id y1-20020a056000108100b001e316d01c47mr18921361wrw.19.1645518906779;
        Tue, 22 Feb 2022 00:35:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTFqlbUoKjOmzD6tEVN0k7Dy726wJbHNF/nP2PKCvE89SzHXdNF5wf7IME2kP/sJ798r1zNg==
X-Received: by 2002:a05:6000:1081:b0:1e3:16d0:1c47 with SMTP id y1-20020a056000108100b001e316d01c47mr18921343wrw.19.1645518906513;
        Tue, 22 Feb 2022 00:35:06 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id v5sm32603727wrr.7.2022.02.22.00.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 00:35:05 -0800 (PST)
Message-ID: <53d4b30e-2563-c13b-eadc-8372ae965fcb@redhat.com>
Date:   Tue, 22 Feb 2022 09:35:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] KVM: Move VM's worker kthreads back to the original
 cgroup before exiting.
Content-Language: en-US
To:     Vipin Sharma <vipinsh@google.com>, seanjc@google.com
Cc:     mkoutny@suse.com, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, dmatlack@google.com, jiangshanlai@gmail.com,
        kvm@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220222054848.563321-1-vipinsh@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220222054848.563321-1-vipinsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/22/22 06:48, Vipin Sharma wrote:
> VM worker kthreads can linger in the VM process's cgroup for sometime
> after KVM terminates the VM process.
> 
> KVM terminates the worker kthreads by calling kthread_stop() which waits
> on the 'exited' completion, triggered by exit_mm(), via mm_release(), in
> do_exit() during the kthread's exit.  However, these kthreads are
> removed from the cgroup using the cgroup_exit() which happens after the
> exit_mm(). Therefore, A VM process can terminate in between the
> exit_mm() and cgroup_exit() calls, leaving only worker kthreads in the
> cgroup.
> 
> Moving worker kthreads back to the original cgroup (kthreadd_task's
> cgroup) makes sure that the cgroup is empty as soon as the main VM
> process is terminated.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> ---

Queued, thanks.

Paolo

> Thanks Sean, for the example on how to use the real_parent outside of the RCU
> critical region. I wrote your name in Suggested-by, I hope you are fine with
> it and this is the right tag/way to give you the credit.
> 
> v4:
> - Read task's real_parent in the RCU critical section.
> - Don't log error message from the cgroup_attach_task_all() API.
> 
> v3: https://lore.kernel.org/lkml/20220217061616.3303271-1-vipinsh@google.com/
> - Use 'current->real_parent' (kthreadd_task) in the
>    cgroup_attach_task_all() call.
> - Revert cgroup APIs changes in v2. Now, patch does not touch cgroup
>    APIs.
> - Update commit and comment message
> 
> v2: https://lore.kernel.org/lkml/20211222225350.1912249-1-vipinsh@google.com/
> - Use kthreadd_task in the cgroup API to avoid build issue.
> 
> v1: https://lore.kernel.org/lkml/20211214050708.4040200-1-vipinsh@google.com/
> 
>   virt/kvm/kvm_main.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 83c57bcc6eb6..cdf1fa3c60ae 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -5810,6 +5810,7 @@ static int kvm_vm_worker_thread(void *context)
>   	 * we have to locally copy anything that is needed beyond initialization
>   	 */
>   	struct kvm_vm_worker_thread_context *init_context = context;
> +	struct task_struct *parent;
>   	struct kvm *kvm = init_context->kvm;
>   	kvm_vm_thread_fn_t thread_fn = init_context->thread_fn;
>   	uintptr_t data = init_context->data;
> @@ -5836,7 +5837,7 @@ static int kvm_vm_worker_thread(void *context)
>   	init_context = NULL;
>   
>   	if (err)
> -		return err;
> +		goto out;
>   
>   	/* Wait to be woken up by the spawner before proceeding. */
>   	kthread_parkme();
> @@ -5844,6 +5845,25 @@ static int kvm_vm_worker_thread(void *context)
>   	if (!kthread_should_stop())
>   		err = thread_fn(kvm, data);
>   
> +out:
> +	/*
> +	 * Move kthread back to its original cgroup to prevent it lingering in
> +	 * the cgroup of the VM process, after the latter finishes its
> +	 * execution.
> +	 *
> +	 * kthread_stop() waits on the 'exited' completion condition which is
> +	 * set in exit_mm(), via mm_release(), in do_exit(). However, the
> +	 * kthread is removed from the cgroup in the cgroup_exit() which is
> +	 * called after the exit_mm(). This causes the kthread_stop() to return
> +	 * before the kthread actually quits the cgroup.
> +	 */
> +	rcu_read_lock();
> +	parent = rcu_dereference(current->real_parent);
> +	get_task_struct(parent);
> +	rcu_read_unlock();
> +	cgroup_attach_task_all(parent, current);
> +	put_task_struct(parent);
> +
>   	return err;
>   }
>   
> 
> base-commit: 1bbc60d0c7e5728aced352e528ef936ebe2344c0


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA65E7B5BDC
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 22:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjJBUNB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 16:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjJBUNA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 16:13:00 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52980AC
        for <cgroups@vger.kernel.org>; Mon,  2 Oct 2023 13:12:56 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7740cf93901so13228385a.2
        for <cgroups@vger.kernel.org>; Mon, 02 Oct 2023 13:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696277575; x=1696882375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ig8P4cQOGE/ZtlmRjRCjZeop9P1BTd8W7jj+VA+9aI=;
        b=0o3ncYFUuY+VowDql8yoKEm4jD156AkUWgkCakspTyKKENrQzoWyT9LVMULUFmoNAq
         65B4xG+Rw57tZewQ31g0/fXyOXx5MQTsIi45a/IjAqLTIETvhT0IsUQNAdLWASVYkAXS
         oXGn6kQHjyjA3+WTTDe6l/Kjk+Curm1vMk0O9hGsaLVdNnLjpHkiZ4cxfg1ZxfPku5uT
         5vJULhGHXmwgYAsk3/NyfH8tGgXtSvd79b4AQKB0Sx/8l8dqPN3M1X75VYsvj6n1WYVe
         1siVBFaRj3lqntyINalRF1J0gaH+FzV7tJMcrEUWtFGfEFMkrd80ESGCbLmetl7wFmJg
         MLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696277575; x=1696882375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ig8P4cQOGE/ZtlmRjRCjZeop9P1BTd8W7jj+VA+9aI=;
        b=oBFKvQ/f7v215G4rAUxvlSQGWUhKkiR9TyzWyWMAoxQaZsSCNUvc/RfbeMSvQYBon6
         Qx6zdiiM43UOgfh2QqHC06QpapBY58UFUcBcCjEZngOUIYORTrTj/2aa244QH4bTJUl3
         FizWKtEinqVQX0k7uQfZSAdkb0dEEIMQuZHKaoLsbfvAZ7/JJrfWjTyf3QidvJCs043r
         gohxH0hqWDEp/xHeE3gX2L7NutSDqmM8eKNw8HM2/88bQTlGoUkdJP4hXfwb27zk6DtA
         n7jlkghqcswFvyFLDfMJgi0OnkK+9Q+uTWRLM7qxC/VlWIFIBM1B3RMTAUBzEeNjvsmV
         gxIQ==
X-Gm-Message-State: AOJu0YwGXKTN/nXfPVRfuy6UORjuKAXhXjIn3h0VhW70e41EbP4z3Ar2
        SJ5IwakULrJycMnOqzwLE/pPZwcnT4hT9GkMgyA=
X-Google-Smtp-Source: AGHT+IEQxVBvmIIyECAYi31Co1WajvJKUAwk2DEdf2g2H2l51M3wsw7tatmmX4E/BLzu5B0qPOINzA==
X-Received: by 2002:a05:620a:854:b0:774:1d7f:2730 with SMTP id u20-20020a05620a085400b007741d7f2730mr10977679qku.46.1696277575439;
        Mon, 02 Oct 2023 13:12:55 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id c2-20020a05620a134200b007743360b3fasm6248556qkl.34.2023.10.02.13.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 13:12:55 -0700 (PDT)
Date:   Mon, 2 Oct 2023 16:12:54 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH rfc 2/5] mm: kmem: add direct objcg pointer to task_struct
Message-ID: <20231002201254.GA8435@cmpxchg.org>
References: <20230927150832.335132-1-roman.gushchin@linux.dev>
 <20230927150832.335132-3-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927150832.335132-3-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 27, 2023 at 08:08:29AM -0700, Roman Gushchin wrote:
> @@ -3001,6 +3001,47 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
>  	return objcg;
>  }
>  
> +static DEFINE_SPINLOCK(current_objcg_lock);
> +
> +static struct obj_cgroup *current_objcg_update(struct obj_cgroup *old)
> +{
> +	struct mem_cgroup *memcg;
> +	struct obj_cgroup *objcg;
> +	unsigned long flags;
> +
> +	old = current_objcg_clear_update_flag(old);
> +	if (old)
> +		obj_cgroup_put(old);
> +
> +	spin_lock_irqsave(&current_objcg_lock, flags);
> +	rcu_read_lock();
> +	memcg = mem_cgroup_from_task(current);
> +	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> +		objcg = rcu_dereference(memcg->objcg);
> +		if (objcg && obj_cgroup_tryget(objcg))
> +			break;
> +		objcg = NULL;
> +	}
> +	rcu_read_unlock();

Can this tryget() actually fail when this is called on the current
task during fork() and attach()? A cgroup cannot be offlined while
there is a task in it.

> @@ -6345,6 +6393,22 @@ static void mem_cgroup_move_task(void)
>  		mem_cgroup_clear_mc();
>  	}
>  }
> +
> +#ifdef CONFIG_MEMCG_KMEM
> +static void mem_cgroup_fork(struct task_struct *task)
> +{
> +	task->objcg = (struct obj_cgroup *)0x1;

dup_task_struct() will copy this pointer from the old task. Would it
be possible to bump the refcount here instead? That would save quite a
bit of work during fork().

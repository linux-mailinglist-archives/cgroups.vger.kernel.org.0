Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069227B6F26
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbjJCQ71 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 12:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240544AbjJCQ7Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 12:59:24 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2F39B
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 09:59:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77428510fe7so936285a.1
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696352360; x=1696957160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qjf57nVPafK9Z4I/viF94cG3rR6sZipxHJbMn8qgU2s=;
        b=JuccSD6IrqkOSYJ0fR67nAXu4Q+xv/oO1rMmQbH6j7QOk87jfRrutku4de5ueMCNxG
         yY46xuvTii3BkyCCj7khbYv7Y/3YhDWzYlMxxDRZYEgSbu1jbStHgMHrGkT8/4JAfG8J
         zSmEYDkjjgZA/txGnZ7b9lN881NaRIQM/Hk9rhw06tixTHI/hDyYtakXBSnsv2wBjd6i
         98GRYzO0es4nD4lncNKOBfg+r5yjcI01VvgefLKFYMREYDzX/J9Rv2dm6Qvs5BHGfCLF
         7wV6BQSo7cvVjxibJn4FJM+aMN5b8DQqriKAZVP1d7bXGRLmLa8JRapxBQs9X9XV4ty6
         MyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696352360; x=1696957160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qjf57nVPafK9Z4I/viF94cG3rR6sZipxHJbMn8qgU2s=;
        b=ZybTncESG0e4K3Z12zzF+lzFhiWnD62mMhEPdiXgcQla4H3crBJQ/VkQ8Y9pLuR5ot
         VqgvyrF2HrRbtSLgEL3WVs9Fw191i2JKZw1UeDc4B1qHiLm2gNNWT3FeyoNO2szRJflV
         ZIVAZWYqV1WQMGxuCEnltdNS8we/NMHsVYYZgnJfu/oXviDbOFebtCI3IGlZVk7JtnTo
         jEKlPjdSYO0T5U1TUU6guXhfmA8cKAJwJgyPBuZ+gvkILhjFEmnCtfY8ezzMfCWI18dX
         SVLdXLMwPT/aYyRf9Lby1Z9zI+7ZPmOeQWDAnlPlDZrNhPB6DaAF11qK6aAUiqgp59tt
         Serg==
X-Gm-Message-State: AOJu0YwstQcIuOMxJwKoJIVEL4HSQws3c3X/6NB+q+g7C/1dxXiWGZJS
        A/40pHCPPzUUjEICjDOepCHOwQ==
X-Google-Smtp-Source: AGHT+IEbPCOfzMpQJ91l0JA53AJl5n/TwHFD/8LajVttQ2sjiRlMa9UwFyAepiDMsF+8h0fuH9bv8g==
X-Received: by 2002:a05:620a:31a8:b0:76d:a27c:245 with SMTP id bi40-20020a05620a31a800b0076da27c0245mr3474195qkb.7.1696352360273;
        Tue, 03 Oct 2023 09:59:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:753d])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a004500b007742ad3047asm600617qkt.54.2023.10.03.09.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:59:20 -0700 (PDT)
Date:   Tue, 3 Oct 2023 12:59:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 2/5] mm: kmem: add direct objcg pointer to task_struct
Message-ID: <20231003165919.GB20979@cmpxchg.org>
References: <20230929180056.1122002-1-roman.gushchin@linux.dev>
 <20230929180056.1122002-3-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929180056.1122002-3-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 29, 2023 at 11:00:52AM -0700, Roman Gushchin wrote:
> @@ -553,6 +553,16 @@ static inline bool folio_memcg_kmem(struct folio *folio)
>  	return folio->memcg_data & MEMCG_DATA_KMEM;
>  }
>  
> +static inline bool current_objcg_needs_update(struct obj_cgroup *objcg)
> +{
> +	return (struct obj_cgroup *)((unsigned long)objcg & 0x1);
> +}
> +
> +static inline struct obj_cgroup *
> +current_objcg_without_update_flag(struct obj_cgroup *objcg)
> +{
> +	return (struct obj_cgroup *)((unsigned long)objcg & ~0x1);
> +}

I would slightly prefer naming the bit with a define, and open-coding
the bitops in the current callsites. This makes it clearer that the
actual pointer bits are overloaded in the places where the pointer is
accessed.

> @@ -3001,6 +3001,47 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
>  	return objcg;
>  }
>  
> +static struct obj_cgroup *current_objcg_update(struct obj_cgroup *old)
> +{
> +	struct mem_cgroup *memcg;
> +	struct obj_cgroup *objcg = NULL, *tmp = old;
> +
> +	old = current_objcg_without_update_flag(old);
> +	if (old)
> +		obj_cgroup_put(old);
> +
> +	rcu_read_lock();
> +	do {
> +		/* Atomically drop the update bit, */
> +		WARN_ON_ONCE(cmpxchg(&current->objcg, tmp, 0) != tmp);
> +
> +		/* ...obtain the new objcg pointer */
> +		memcg = mem_cgroup_from_task(current);
> +		for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> +			objcg = rcu_dereference(memcg->objcg);
> +			if (objcg && obj_cgroup_tryget(objcg))
> +				break;
> +			objcg = NULL;
> +		}

As per the other thread, it would be great to have a comment here
explaining the scenario(s) when the tryget could fail and we'd have to
defer to an ancestor.

> +
> +		/*
> +		 * ...and try atomically set up a new objcg pointer. If it
> +		 * fails, it means the update flag was set concurrently, so
> +		 * the whole procedure should be repeated.
> +		 */
> +		tmp = 0;
> +	} while (!try_cmpxchg(&current->objcg, &tmp, objcg));
> +	rcu_read_unlock();
> +
> +	return objcg;

Overall this looks great to me.

AFAICS the rcu_read_lock() is needed for the mem_cgroup_from_task()
and tryget(). Is it possible to localize it around these operations?
Or am I missing some other effect it has?

> @@ -6358,8 +6407,27 @@ static void mem_cgroup_move_task(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +static void mem_cgroup_fork(struct task_struct *task)
> +{
> +	/*
> +	 * Set the update flag to cause task->objcg to be initialized lazily
> +	 * on the first allocation.
> +	 */
> +	task->objcg = (struct obj_cgroup *)0x1;
> +}

I like this open-coding!

Should this mention why it doesn't need to be atomic? Task is in
fork(), no concurrent modifications from allocations or migrations
possible...

None of the feedback is a blocker, though.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

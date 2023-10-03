Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D117B6B56
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 16:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbjJCOXB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 10:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239535AbjJCOXB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 10:23:01 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A49BB
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 07:22:57 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-65b0dad1f98so6595796d6.0
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696342976; x=1696947776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQJcLp1PNbZ/HCxUuAL8GIttYWoNS8rEFxPDJqSSreg=;
        b=mCsHqU4TyV4ikwllGDTn0FCGSV87iPHWPpRwhJ8lUdb3OF2/hInibMKNtrA9fxkDRJ
         1WNmNp241LuiiBoCAs+1ZEQ5E/BvP15QOGezVGTOn4zQFIFfXY5hCemoVyR4fjt/O46F
         UA9nt5qv6D/LrKoqKL27RJ/Wc8HQ7COjjPk5/fPA7zg0ZLZ3JNGVf0n7z9ZXDmePWSSb
         ZZPUFUNyN7KNLcnQ5qeIiWYycDLK1EbjKIR0EVn3hRb4SVskcpV+BzhAouk/iGNok3Zo
         9oFkWZ/8JSzz7ymzQ3OF3FvDJk5R0uvWO8G/bcUI7MUVhE+yzrMLfbD8O9w3qoJ5ighl
         lCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696342976; x=1696947776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQJcLp1PNbZ/HCxUuAL8GIttYWoNS8rEFxPDJqSSreg=;
        b=KY4cY1/7Tm3t9g/bzGiGLiWscX4XyG4OjdrI7kjcbDqfdpfY7qzrrdBmCsvVqpeImu
         bzJwuNruo2BIpuFPXdm2P8B2hLOKK7q6mn+Xk1XItabVikUeNyCkxQq0x1qT/SG1S2MT
         ubXJcaRPcMP0WPr5K77ffovqZ8htcubI98dS6f3Qg8H8idKLcFKrKDLTOeBsAfPNxK9K
         JVYstZRMFQ6vkiVGUFgLgTeyCQIgVBa56Lxc3mX1mXScCRVO8lIDkqPut5fEXsOl9LQ/
         HR2wlJwOvJWRuUhgaLuF9BciR0C0ljws4+HaFEOaCx6gBvOUzxMLTR9mgjwPQAjXNVQH
         rgnA==
X-Gm-Message-State: AOJu0Yx56bxC8IRxO8LK/7A9g2qz1pT/yfj6RumRFtLQNKTBLqtnAhAD
        0caSR0tOIDCuLfDI2YJZwFA7ew==
X-Google-Smtp-Source: AGHT+IGv7PLU7uRYjnFUgK7YvvEdjfi3advrrLLcN7FRUz6vDMpEs0fGL3cW+2lAdwL2wIvXdR0haw==
X-Received: by 2002:a0c:e18a:0:b0:65d:d:a114 with SMTP id p10-20020a0ce18a000000b0065d000da114mr15681428qvl.55.1696342976103;
        Tue, 03 Oct 2023 07:22:56 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id h9-20020a0cab09000000b006616fbcc077sm519329qvb.129.2023.10.03.07.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:22:55 -0700 (PDT)
Date:   Tue, 3 Oct 2023 10:22:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH rfc 2/5] mm: kmem: add direct objcg pointer to task_struct
Message-ID: <20231003142255.GE17012@cmpxchg.org>
References: <20230927150832.335132-1-roman.gushchin@linux.dev>
 <20230927150832.335132-3-roman.gushchin@linux.dev>
 <20231002201254.GA8435@cmpxchg.org>
 <ZRs-RKsOhtO3eclx@P9FQF9L96D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRs-RKsOhtO3eclx@P9FQF9L96D>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 02, 2023 at 03:03:48PM -0700, Roman Gushchin wrote:
> On Mon, Oct 02, 2023 at 04:12:54PM -0400, Johannes Weiner wrote:
> > On Wed, Sep 27, 2023 at 08:08:29AM -0700, Roman Gushchin wrote:
> > > @@ -3001,6 +3001,47 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
> > >  	return objcg;
> > >  }
> > >  
> > > +static DEFINE_SPINLOCK(current_objcg_lock);
> > > +
> > > +static struct obj_cgroup *current_objcg_update(struct obj_cgroup *old)
> > > +{
> > > +	struct mem_cgroup *memcg;
> > > +	struct obj_cgroup *objcg;
> > > +	unsigned long flags;
> > > +
> > > +	old = current_objcg_clear_update_flag(old);
> > > +	if (old)
> > > +		obj_cgroup_put(old);
> > > +
> > > +	spin_lock_irqsave(&current_objcg_lock, flags);
> > > +	rcu_read_lock();
> > > +	memcg = mem_cgroup_from_task(current);
> > > +	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> > > +		objcg = rcu_dereference(memcg->objcg);
> > > +		if (objcg && obj_cgroup_tryget(objcg))
> > > +			break;
> > > +		objcg = NULL;
> > > +	}
> > > +	rcu_read_unlock();
> > 
> > Can this tryget() actually fail when this is called on the current
> > task during fork() and attach()? A cgroup cannot be offlined while
> > there is a task in it.
> 
> Highly theoretically it can if it races against a migration of the current
> task to another memcg and the previous memcg is getting offlined.

Ah right, if this runs between css_set_move_task() and ->attach(). The
cache would be briefly updated to a parent in the old hierarchy, but
then quickly reset from the ->attach().

Can you please add a comment along these lines?

> I actually might make sense to apply the same approach for memcgs as well
> (saving a lazily-updating memcg pointer on task_struct). Then it will be
> possible to ditch this "for" loop. But I need some time to master the code
> and run benchmarks. Idk if it will make enough difference to justify the change.

Yeah the memcg pointer is slightly less attractive from an
optimization POV because it already is a pretty direct pointer from
task through the cset array.

If you still want to look into it from a simplification POV that
sounds reasonable, but IMO it would be fine with a comment.

> > > @@ -6345,6 +6393,22 @@ static void mem_cgroup_move_task(void)
> > >  		mem_cgroup_clear_mc();
> > >  	}
> > >  }
> > > +
> > > +#ifdef CONFIG_MEMCG_KMEM
> > > +static void mem_cgroup_fork(struct task_struct *task)
> > > +{
> > > +	task->objcg = (struct obj_cgroup *)0x1;
> > 
> > dup_task_struct() will copy this pointer from the old task. Would it
> > be possible to bump the refcount here instead? That would save quite a
> > bit of work during fork().
> 
> Yeah, it should be possible. It won't save a lot, but I agree it makes
> sense. I'll take a look and will prepare a separate patch for this.

I guess the hairiest part would be synchronizing against a migration
because all these cgroup core callbacks are unlocked.

Would it make sense to add ->fork_locked() and ->attach_locked()
callbacks that are dispatched under the css_set_lock? Then this could
be a simple if (p && !(p & 0x1)) obj_cgroup_get(), which would
certainly be nice to workloads where fork() is hot, with little
downside otherwise.

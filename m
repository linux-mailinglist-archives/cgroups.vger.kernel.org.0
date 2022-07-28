Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535725844F5
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 19:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiG1RXL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 13:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiG1RXK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 13:23:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B254F2A27D;
        Thu, 28 Jul 2022 10:23:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b133so2479941pfb.6;
        Thu, 28 Jul 2022 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=N+EDZeN9hOjgggv+GakuBGOt5cAU+R6TAmQfKefuGy4=;
        b=Emg3DdK7LSA+NPGtwUNvKOne+VsyeeyNXbQvyE/VGpLz3/txaN1mHFE01gAsuDkCbB
         2K7lXPS/nzQZA2KQw6vB/AgSjSFuh5/PtFjUpNz/VSASorhlSmLD2FS3h2HbfMkcTDG2
         fxBFMM8xJyVClKV9xW3aMewFxSDcY7TeKGj4/W3nEqhO62yY+c9uMYLUim1v3S2aZWn2
         iguQ331j5j8wWHjY9b26yu1dsHepHq14knp9Lp2mh3CssireX5EasKZP+fh+IoToiO9d
         uOOzEZXLpe1nmRc16BoqGuojFL+81jyLgTuwt2FYlVdkxONSwxluMiO3xqYUjVk9MEFQ
         +7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=N+EDZeN9hOjgggv+GakuBGOt5cAU+R6TAmQfKefuGy4=;
        b=Kk+7gkYKa6CO+hfYwExgmlpOKVhCxRkihGiowlk/mkbTgb7iidzVleCsOeGltFKFI6
         nM0nvqezQZim3uUX0MGVKatasB3agMWcrTHr8QjmJC61YM2vDggWMkJwNWdpfPJ/FlhR
         g85EDKUkRQtg7AVhteTPw9bH7Q3eTrpKxnuBfQZ6ZkKVvj2LdUumwN9mVMfWJadNIp2b
         TLDv7WtbLifAAJqCzex049SG0UQypox3qR/8qq8VA7QXXq+fuCrysULe1IAVh7CLb4y+
         FcSzr/yjdlLPTeylLvQRc+XY4Q8c5ccCukiIi4SvHImwtxU9yMR1wcEqL6Ip7Pnrr07i
         QgOw==
X-Gm-Message-State: AJIora/I+uNPqfN2xJ1KgoywUayh7CbgeHbbwrb/d0Hq6WVb7a1ktu1U
        nh59TN9Gr+IIEpdU8RjY4Ak=
X-Google-Smtp-Source: AGRyM1vWAeNNMrOWt9hod6gzpgcnKjOTotfiqgHg0fz7dxoEyRqT93I9WP7AjN6lq33F38HaWSX6Uw==
X-Received: by 2002:a05:6a00:8cf:b0:522:93a6:46e9 with SMTP id s15-20020a056a0008cf00b0052293a646e9mr28490624pfu.62.1659028989086;
        Thu, 28 Jul 2022 10:23:09 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b0016dc808f29bsm1408662plg.13.2022.07.28.10.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:23:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 28 Jul 2022 07:23:07 -1000
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
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
Message-ID: <YuLF+xXaCzwWi2BR@slm.duckdns.org>
References: <20220728005815.1715522-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728005815.1715522-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Jul 27, 2022 at 08:58:14PM -0400, Waiman Long wrote:
> It was found that any change to the current cpuset hierarchy may reset
> the cpus_allowed list of the tasks in the affected cpusets to the
> default cpuset value even if those tasks have cpus affinity explicitly
> set by the users before. That is especially easy to trigger under a
> cgroup v2 environment where writing "+cpuset" to the root cgroup's
> cgroup.subtree_control file will reset the cpus affinity of all the
> processes in the system.
> 
> That is especially problematic in a nohz_full environment where the
> tasks running in the nohz_full CPUs usually have their cpus affinity
> explicitly set and will behave incorrectly if cpus affinity changes.
> 
> Fix this problem by adding a flag in the task structure to indicate that
> a task has their cpus affinity explicitly set before and make cpuset
> code not to change their cpus_allowed list unless the user chosen cpu
> list is no longer a subset of the cpus_allowed list of the cpuset itself.
> 
> With that change in place, it was verified that tasks that have its
> cpus affinity explicitly set will not be affected by changes made to
> the v2 cgroup.subtree_control files.

I think the underlying cause here is cpuset overwriting the cpumask the user
configured but that's a longer discussion.

> +/*
> + * Don't change the cpus_allowed list if cpus affinity has been explicitly
> + * set before unless the current cpu list is not a subset of the new cpu list.
> + */
> +static int cpuset_set_cpus_allowed_ptr(struct task_struct *p,
> +				       const struct cpumask *new_mask)
> +{
> +	if (p->cpus_affinity_set && cpumask_subset(p->cpus_ptr, new_mask))
> +		return 0;
> +
> +	p->cpus_affinity_set = 0;
> +	return set_cpus_allowed_ptr(p, new_mask);
> +}

I wonder whether the more predictable behavior would be always not resetting
the cpumask if it's a subset of the new_mask. Also, shouldn't this check
p->cpus_mask instead of p->cpus_ptr?

Thanks.

-- 
tejun

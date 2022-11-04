Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A3961A1BC
	for <lists+cgroups@lfdr.de>; Fri,  4 Nov 2022 21:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKDUBN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Nov 2022 16:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiKDUAy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Nov 2022 16:00:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD37445EED;
        Fri,  4 Nov 2022 13:00:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso9161797pjg.5;
        Fri, 04 Nov 2022 13:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5nCsQYl2chg/EUS/wN4WOUjHzC3DOYQXdNArjUPqD4=;
        b=h8ZfTZCn8t/w57ArpiD8nVNzrVfQicce6WQcDTZNCIwJQOnFJL3OUnRUi2+MwApRMd
         3o5jeFfSHLVGXoygB8+U2CENqI3roIwnH9x9M+K2E/Tg/u+JXQlVUC9YJwxmtjs0rV08
         929KkcjhLFCHh81gh6aTz1xYYED+Jp4yARUKiTMhci2ead4XxLs1LIf+1di0OF2l9lVf
         7TP5i7ZEHNCcsthnGt4ci5d06V/5W1xfe3R0E22f+H1Y/rnaovTEh+t2SAM8g5ZS4ZEG
         pAXjiXrZ64Zami+gBtIgonYUaGv6RrZjlKWThMv/1TXdTBaRSolUN7NWcTEV6FVaux6L
         opbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5nCsQYl2chg/EUS/wN4WOUjHzC3DOYQXdNArjUPqD4=;
        b=AoHT0bMhpzlJc4TW5JDZl3HVRQxJs+3Jij5RU9aKenWw8OWv4AS4SURvU/cjXTzSOD
         Zsz2AtPv2jXXTZ0RP6gMWe03TJ/3HGTkwfr7r7xri7l94vmf03UgqChSzbLo+2yploCg
         mzzekwMLyWhNQyEM1cBe5DMcZIe9HGYAfaNh7Uu7RLPLw8JvHAyefp4BIhanQ19gX37g
         fEdxX09m4qoKo0EorE/pXOQVojmzr77edfuS2kN6NLuH3hlWQdCF8cZ1Yvj7sTDrs4Tq
         M3WKJDzIx0mKKYZFOOieb/EGqHJH8dO7yB6mRzUI91bgsoVxDAlXRepYL7uGkHOB7n1L
         crUg==
X-Gm-Message-State: ACrzQf3JVwyTMeuXdoO92KA+yF9IArw/Li8uzYNDUnP2ekXcniFcwMPP
        nbK9YpHzoc3BbVhVBtpEIrE=
X-Google-Smtp-Source: AMsMyM6b1JJoHMSrutpB8G5B3ErqHBHA6d38sJwm7MyCn6PmCyOWtnLQn3d64sFuGtKB+q8P9OtzZA==
X-Received: by 2002:a17:90a:2bcb:b0:20a:ea55:32ef with SMTP id n11-20020a17090a2bcb00b0020aea5532efmr55158658pje.59.1667592048070;
        Fri, 04 Nov 2022 13:00:48 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g18-20020aa796b2000000b005622f99579esm15088pfk.160.2022.11.04.13.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 13:00:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 4 Nov 2022 10:00:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v9 3/3] blk-cgroup: Flush stats at blkgs destruction path
Message-ID: <Y2VvboMSxgF0pYpX@slm.duckdns.org>
References: <20221104182050.342908-1-longman@redhat.com>
 <20221104182050.342908-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104182050.342908-4-longman@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 04, 2022 at 02:20:50PM -0400, Waiman Long wrote:
> +/**
> + * cgroup_rstat_css_flush - flush stats for the given css and cpu
> + * @css: target css to be flush
> + * @cpu: the cpu that holds the stats to be flush
> + *
> + * A lightweight rstat flush operation for a given css and cpu.
> + * Only the cpu_lock is being held for mutual exclusion, the cgroup_rstat_lock
> + * isn't used.
> + */
> +void cgroup_rstat_css_flush(struct cgroup_subsys_state *css, int cpu)
> +{
> +	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
> +
> +	raw_spin_lock_irq(cpu_lock);
> +	rcu_read_lock();
> +	css->ss->css_rstat_flush(css, cpu);
> +	rcu_read_unlock();
> +	raw_spin_unlock_irq(cpu_lock);
> +}

Would it make sense to itereate CPUs within the helper rather than asking
the caller to do it? Also, in terms of patch sequencing, this introduces a
bug and then fixes it. Prolly better to not introduce the bug in the first
place.

Thanks.

-- 
tejun

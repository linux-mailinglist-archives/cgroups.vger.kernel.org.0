Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB16889D7
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 23:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjBBWfP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 17:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjBBWfO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 17:35:14 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2249369514;
        Thu,  2 Feb 2023 14:35:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so7096532pjq.0;
        Thu, 02 Feb 2023 14:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/vBtaUtvuAYUBDEagef+6G4CYpgzu4YV3aIy4NBUrk=;
        b=oq3M/1+tIFcjv9hjEaGa28A24jGTHUseAgRYiuLI/10z8o5Lu4Qv1oa6JxbgQXY8G/
         NWn04KLhk0SYfQ9EGUP/PUl6RXvmhYklHrGecdQSjHvDeGxa+23/5lw2SZDNNpP2G6Ex
         bXiRpKzgO0zlaxeKzE62bplLdiPUyA0NiWPWk6rqquMKzN/+0G1MZJ1g/HBunRJ7Vjpy
         2aF/039Mt6/+eZW5dumlEg3q8OiNbRBwGXKUfUiktWBQpxBo85aRZwaGVCyNPfa7N4HN
         VPiDYCFWuMcfQ64NEL+osMeaqbfpL7BPZy8kkFiWtYnvWtQKN7ZwtotoQmnj8jQ5Dquc
         +NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/vBtaUtvuAYUBDEagef+6G4CYpgzu4YV3aIy4NBUrk=;
        b=7AbRFQFwI8ryhSTt4ZOW0Opnp233g3WJPvHIBfixAUdJnrdSNJpaYNkkyrcgjTRr5O
         9M9L310TazReD9GJZctocFEvROJ5k1SWm1PZ6DXofB/8dWCDhSqMRaN1KHYtujYe67th
         r3wtIVdVpP4cEHtNC86Yv4KTL+Gr2l+lB/DjGjoQTXthniDr3zxXjiOZXizmL3YSCwpZ
         MUTPUL/jZ3LRSR8cUM31pYJHnnUDrtm3ebIL4A7xYnj0yvxa9d4eoIaRA9xkxDK+JlrM
         pag7qfv1UCu2EcHCNQ6spPaPyIEPOPkx8+iUznrk+pP8OtlcxFmn7QFy9mCX55IDP92I
         jwEg==
X-Gm-Message-State: AO0yUKWCEFD0U/t9EeBubOaLZL0cePAlrkx1AIdJSDSUTCxfCDQgFSIk
        5AvqcrWM/0jI34EU49BpCF0=
X-Google-Smtp-Source: AK7set9XeB2H6rlbYMld72Gb37KpJdEba3Et0ayGI0PwA1/E2XqT3/jRo8CMiqVfdd0b8evxuSZeJA==
X-Received: by 2002:a17:903:2341:b0:196:6398:97ad with SMTP id c1-20020a170903234100b00196639897admr7987227plh.40.1675377310453;
        Thu, 02 Feb 2023 14:35:10 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:48a9])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902684500b00192820d00d0sm176309pln.120.2023.02.02.14.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 14:35:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Feb 2023 12:35:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: Re: [PATCH v4 2/2] blk-cgroup: Flush stats at blkgs destruction path
Message-ID: <Y9w6nDJoekdCYZXr@slm.duckdns.org>
References: <20221215033132.230023-1-longman@redhat.com>
 <20221215033132.230023-3-longman@redhat.com>
 <Y9s4+Nop1eluWmJ4@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9s4+Nop1eluWmJ4@T590>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 02, 2023 at 12:15:52PM +0800, Ming Lei wrote:
> > @@ -1093,6 +1095,20 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
> >  
> >  	might_sleep();
> >  
> > +	/*
> > +	 * Flush all the non-empty percpu lockless lists to release the
> > +	 * blkg references held by those lists which, in turn, will
> > +	 * allow those blkgs to be freed and release their references to
> > +	 * blkcg. Otherwise, they may not be freed at all becase of this
> > +	 * circular dependency resulting in memory leak.
> > +	 */
> > +	for_each_possible_cpu(cpu) {
> > +		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
> > +
> > +		if (!llist_empty(lhead))
> > +			cgroup_rstat_css_cpu_flush(&blkcg->css, cpu);
> > +	}
> 
> I guess it is possible for new iostat_cpu to be added just after the
> llist_empty() check.

Ah, good point. Maybe:

* Move flush below the blkg kill loop.

* In blk_cgroup_bio_start(), use percpu_ref_tryget() to decide whether to
  add to llist or not.

-- 
tejun

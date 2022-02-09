Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2F64B0139
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 00:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiBIX3R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Feb 2022 18:29:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiBIX3Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Feb 2022 18:29:16 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1EFDF8E3D2;
        Wed,  9 Feb 2022 15:29:19 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y5so7094351pfe.4;
        Wed, 09 Feb 2022 15:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vyxdt1qWwEixzQmfvtesRM+4XY4WJ+b7HT9Q8ZLfLAs=;
        b=pZi+PzBgTTefzJeng26sb/vNM7MsBFngkh6o84QEptniKvStYo9EIzPewsyVg2dOyf
         fG/NKLlkk0Sprdqloz7mNTwVMJR93Fg2z8pNm6e2jqtpDYjBmhDJdNKfHQXmzFXDiXCv
         JA7Vtwt57onmIqPQYdaOknNh2Z6/sqm4jkjEAfQn4ynDMSIBekuHsbiByNBuXRcIF0EH
         FCAQ2Z9HJ9GOs9ZQenWKWEoyA6iNyKABSXd+9DLjeajfXBmFlYZvBxZBkBjK/Z855UvD
         kstoetOSqUgPaLcpDkWbIxoovoqKHk716dho+phSXFGtyI1CgQJ3M1+R2nypg592amPQ
         CiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Vyxdt1qWwEixzQmfvtesRM+4XY4WJ+b7HT9Q8ZLfLAs=;
        b=7m7Uyi7VT/Hx4sz3ie1wv8pFIyEw9luM5CaTuXOoTMNywn+XPccUgo5EErIiU5kT24
         RnUSA25SeWNRCBQA5aJCCKu/rzXAWfayDp/3AMxw13A1UOXV0rKmLw/+KlV4gAh0YyNY
         as6fgxhA4JuLLb7GlAeRHb8qHFITUxsItBF6QJGxJmrpfalYHm8Aguo3OMLpHVnWTONj
         +enXwLl73glVH3CgjNtTsIJuy5mwKiQ3oXj4ar8H2sBqha39k8mz2FoayyqLlpzk1hQW
         JgZ71A7KWkhuOGV9bU5cN/v5JaV5K/2Ph+BoVG4EMut6fzR7GnW4l5iPJHnGyH5ozLUe
         zTCQ==
X-Gm-Message-State: AOAM530TEBWtEKj3LVyEgBitJcTQUzF5t+CeyrpBItGd0iste+LwrVwf
        MBD+xPKtfAZ5Sff24dRaWdrpHx62J24=
X-Google-Smtp-Source: ABdhPJwN1FqlbLvru+RdaIITToi4kY4rSnARfUoR8U8SghkmHtwAHVYzs5D2kFAP90YsRg11gQPG2g==
X-Received: by 2002:a05:6a00:130a:: with SMTP id j10mr4697420pfu.32.1644449358438;
        Wed, 09 Feb 2022 15:29:18 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j185sm19558749pfd.85.2022.02.09.15.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:29:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 9 Feb 2022 13:29:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 02/12] cgroup: rstat: Make cgroup_rstat_cpu_lock name
 readable
Message-ID: <YgROTNCwS50FSCx9@slm.duckdns.org>
References: <20220208194324.85333-1-namhyung@kernel.org>
 <20220208194324.85333-3-namhyung@kernel.org>
 <4b58c74d-6ad6-3658-30fb-1957a7b212dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b58c74d-6ad6-3658-30fb-1957a7b212dc@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 09, 2022 at 03:20:42PM -0500, Waiman Long wrote:
> That is a standalone fix. Maybe Tejun can take it directly into the cgroup
> tree.
> 
> Acked-by: Waiman Long <longman@redhat.com>

Yeah, I sure can but the change is rather immaterial from cgroup POV and it
might be easier to route it with the rest of the patchset to avoid cross
tree pulls. I'd be happy either way. Please let me know once things settle
and the patchset is ready for merging.

Thanks.

-- 
tejun

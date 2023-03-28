Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B62E6CCA67
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 21:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjC1TGN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 15:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjC1TGL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 15:06:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39A5272D
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 12:06:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id er13so12857220edb.9
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680030365;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WQyIrdKCsHvb8zLTh5h/QnKicAPnjV8XyfAnbUhyqtc=;
        b=eGikLsGLFoVUkW6GbVQkOFBoDpp+W99UiFbI/1642zWEFZ3juLQaRaltNCn2wU02D4
         YL7jzA8mTQn67wxUeBcnWhvdMnr7A5ebifJPOyfQPIkEOzJxi6194cbH6C6j3kKl8Ywl
         XY3zE4et0pjZlCrDxONVchgaIVK8GzX60e6GQTpdrsOE/QF3qkhQESQeWnFpo7qhv9f7
         3d5b6XKEPzhosboezNX9Lu3mnNa36lMRugddSdn5yJmIE4bQr6mBDyVxDY/HWbX3+3KJ
         cJRFP4ssIfd/HvC3ZbE6cl+jYuymOoi7hkVc8hvAod8Y9FnsSo8mTPul4jkMAP7OITxv
         Ta/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680030365;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQyIrdKCsHvb8zLTh5h/QnKicAPnjV8XyfAnbUhyqtc=;
        b=YKhPVo1k0Q3e4D288NFbl/a/5uCnOSpRkdvdnMx6fUsxcD4fY21tvUuztjzcZHK3J2
         GhdARKlEUPh/jvsTiH56j19C5l08SzJ7SJePCG39LqCchkulZ84/lfLLQTg8IttJ96Tw
         3a+V8P+8F/pArSLzb+4gAJjGeyNMs5KosYhDWGSQ9RZFRsBpu5lEDH8mOLa1rl+l/lFX
         ai0ScOiT06OYnKUCUGjTJI270T0VvS26Wobj4baHnFo+ZS2VS7OSsmjqi0SKey6833Hs
         0VachZV3blCKCxFj7FZsVRjlRzd1J7w9mvw2Wldn+gHkbv5i67wQnAd7EQVCPbww4r8O
         vPmw==
X-Gm-Message-State: AAQBX9ct/iLKigW7BxR5e35iBojbu/abHrgM9SnSLV/6aCFhNdETs7GH
        Spy7rOVUOY9nqwrQZR11APBD+npFtfboS3Q2oxI=
X-Google-Smtp-Source: AKy350aw3p2OspiyiuuWmLGeQQA0Ae4PemXrygP5k1HGpsqdCzFAOkR4Ju/Zc6bJrxyK3dozuSVLvA==
X-Received: by 2002:a17:907:d402:b0:930:ca4d:f2bf with SMTP id vi2-20020a170907d40200b00930ca4df2bfmr19816432ejc.54.1680030365312;
        Tue, 28 Mar 2023 12:06:05 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id xh9-20020a170906da8900b009447277c26fsm3069805ejb.72.2023.03.28.12.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 12:06:05 -0700 (PDT)
Date:   Tue, 28 Mar 2023 15:06:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 6/9] memcg: sleep during flushing stats in safe
 contexts
Message-ID: <ZCM6m/4ujEqvFVsn@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-7-yosryahmed@google.com>
 <ZCMzfQuo9IhWVzRA@cmpxchg.org>
 <CAJD7tkZxEEcVZ9G7NSM56q_uOyL7e353NT06kD0mY5DyNmKTpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZxEEcVZ9G7NSM56q_uOyL7e353NT06kD0mY5DyNmKTpw@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 28, 2023 at 11:45:19AM -0700, Yosry Ahmed wrote:
> On Tue, Mar 28, 2023 at 11:35 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Tue, Mar 28, 2023 at 06:16:35AM +0000, Yosry Ahmed wrote:
> > >  void mem_cgroup_flush_stats_ratelimited(void)
> > >  {
> > >       if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> > > -             mem_cgroup_flush_stats();
> > > +             mem_cgroup_flush_stats_atomic();
> > > +}
> >
> > This should probably be mem_cgroup_flush_stats_atomic_ratelimited().
> >
> > (Whee, kinda long, but that's alright. Very specialized caller...)
> 
> It should, but the following patch makes it non-atomic anyway, so I
> thought I wouldn't clutter the diff by renaming it here and then
> reverting it back in the next patch.
> 
> There is an argument for maintaining a clean history tho in case the
> next patch is reverted separately (which is the reason I put it in a
> separate patch to begin with) -- so perhaps I should rename it here to
> mem_cgroup_flush_stats_atomic_ratelimited () and back to
> mem_cgroup_flush_stats_ratelimited() in the next patch, just for
> consistency?

Sounds good to me. It's pretty minor churn.

> > Btw, can you guys think of a reason against moving the threshold check
> > into the common function? It would then apply to the time-limited
> > flushes as well, but that shouldn't hurt anything. This would make the
> > code even simpler:
> 
> I think the point of having the threshold check outside the common
> function is that the periodic flusher always flushes, regardless of
> the threshold, to keep rstat flushing from critical contexts as cheap
> as possible.

Good point. Yeah, let's keep it separate then.

> > > @@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
> > >        * Flush the memory cgroup stats, so that we read accurate per-memcg
> > >        * lruvec stats for heuristics.
> > >        */
> > > -     mem_cgroup_flush_stats();
> > > +     mem_cgroup_flush_stats_atomic();
> >
> > I'm thinking this one could be non-atomic as well. It's called fairly
> > high up in reclaim without any locks held.
> 
> A later patch does exactly that. I put making the reclaim and refault
> paths non-atomic in separate patches to easily revert them if we see a
> regression. Let me know if this is too defensive and if you'd rather
> have them squashed.

No, good call. I should have just looked ahead first :-)

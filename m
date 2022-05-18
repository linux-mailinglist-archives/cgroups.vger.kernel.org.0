Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146A252B20B
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 08:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiERF6p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 01:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiERF6o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 01:58:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A962DC1ED8;
        Tue, 17 May 2022 22:58:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k16so1190072pff.5;
        Tue, 17 May 2022 22:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wvwoi2ieX1SAY39tBWj8LHG37asi931JP8mrlpfaKk4=;
        b=IYRMNrIiumsSaflitKrY0i7FLS+lQCNLzOzrzfpuDPHl8qKTyR2SruC/IiZPaWASLU
         h1814XYKS6hk+GXI8YmOfUnZZvmtntVApJKWkygY16itKnRQP2mlCzMkvZBUWHpeFhdf
         vxsTjQ/hFRdQmWf81TAcvUVbgUIqwgYy/P2macO/GgTqyvjwUq6j6rEzicfyDezBeCJh
         jalDG8dek+x5k4G1i6fjll8rsPu9bLOuh5MuDAsCSNI+H91QXyUx22iqd8m24ddtm7p9
         SQvgRYreW4YjQ3RNg+uvIuLy6RceXkwr/A5qYIInoXTV+YQHxzPC4L5WS8ySQpgc+F6R
         R5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wvwoi2ieX1SAY39tBWj8LHG37asi931JP8mrlpfaKk4=;
        b=xCX9NlvSF5v2EHSXkqW2W7By52Pssel/I3L1TpNUQop0PsCIdJ0KaswWdZmsYhT9UL
         ROCiwZqU9vDGnfnFLZjXK8LJ8lAg6d5nXXNzoGV3k+KOlpTwibI+LWnwf207VyrnvjKm
         qTCJfdnXurpPdzMrZhZ8gva4eY2/pzligiZc+uCbb/T+PKClqKt6sM1QRtxjiub3tIil
         Lps85V/5MzQ0GO9406X6z+rxUShcoL5F+bAdTJImJ+WBpejALcycdSIZYkKsLwW4+2h2
         DhN++/vmXwD86by/NM5gIAeAEJf9r54SB27Qa3Y7ScI0R+0HxmYlynT4iA0Ggt20b6iW
         54Ng==
X-Gm-Message-State: AOAM530R0N0HgWofdpR6aAGaAJCE9WMCiPMaI/Suj8jZVNiYJZ52yHGj
        E5+U2s0hBOBul3eS4h5oGKY=
X-Google-Smtp-Source: ABdhPJwr9HRFJAt/zhYuJZ10Py9yYXbZjFzFpTiFrytFhnSOVnn+LtwTvwpMfpIndB0c1Sf+6QiTvA==
X-Received: by 2002:a63:5d50:0:b0:3db:5325:b120 with SMTP id o16-20020a635d50000000b003db5325b120mr22910678pgm.212.1652853521830;
        Tue, 17 May 2022 22:58:41 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q13-20020a170903204d00b0015e8d4eb20asm649445pla.84.2022.05.17.22.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:58:41 -0700 (PDT)
Message-ID: <62848b11.1c69fb81.6ce50.2091@mx.google.com>
X-Google-Original-Message-ID: <20220518055839.GA1677365@cgel.zte@gmail.com>
Date:   Wed, 18 May 2022 05:58:39 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        shy828301@gmail.com, roman.gushchin@linux.dev, shakeelb@google.com,
        linmiaohe@huawei.com, william.kucharski@oracle.com,
        peterx@redhat.com, hughd@google.com, vbabka@suse.cz,
        songmuchun@bytedance.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
References: <20220505033814.103256-1-xu.xin16@zte.com.cn>
 <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
 <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
 <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
 <6278fa75.1c69fb81.9c598.f794@mx.google.com>
 <Ynj/l+pyFJxKfcbQ@dhcp22.suse.cz>
 <6279c354.1c69fb81.7f6c1.15e0@mx.google.com>
 <Yno3pNQOn1lAMPnu@dhcp22.suse.cz>
 <627a5214.1c69fb81.1b7fb.47be@mx.google.com>
 <YnpqYte2jLdcBiPg@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnpqYte2jLdcBiPg@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 10, 2022 at 03:36:34PM +0200, Michal Hocko wrote:
> On Tue 10-05-22 11:52:51, CGEL wrote:
> > On Tue, May 10, 2022 at 12:00:04PM +0200, Michal Hocko wrote:
> > > On Tue 10-05-22 01:43:38, CGEL wrote:
> > > > On Mon, May 09, 2022 at 01:48:39PM +0200, Michal Hocko wrote:
> > > > > On Mon 09-05-22 11:26:43, CGEL wrote:
> > > > > > On Mon, May 09, 2022 at 12:00:28PM +0200, Michal Hocko wrote:
> > > > > > > On Sat 07-05-22 02:05:25, CGEL wrote:
> > > > > > > [...]
> > > > > > > > If there are many containers to run on one host, and some of them have high
> > > > > > > > performance requirements, administrator could turn on thp for them:
> > > > > > > > # docker run -it --thp-enabled=always
> > > > > > > > Then all the processes in those containers will always use thp.
> > > > > > > > While other containers turn off thp by:
> > > > > > > > # docker run -it --thp-enabled=never
> > > > > > > 
> > > > > > > I do not know. The THP config space is already too confusing and complex
> > > > > > > and this just adds on top. E.g. is the behavior of the knob
> > > > > > > hierarchical? What is the policy if parent memcg says madivise while
> > > > > > > child says always? How does the per-application configuration aligns
> > > > > > > with all that (e.g. memcg policy madivise but application says never via
> > > > > > > prctl while still uses some madvised - e.g. via library).
> > > > > > >
> > > > > > 
> > > > > > The cgroup THP behavior is align to host and totally independent just likes
> > > > > > /sys/fs/cgroup/memory.swappiness. That means if one cgroup config 'always'
> > > > > > for thp, it has no matter with host or other cgroup. This make it simple for
> > > > > > user to understand or control.
> > > > > 
> > > > > All controls in cgroup v2 should be hierarchical. This is really
> > > > > required for a proper delegation semantic.
> > > > >
> > > > 
> > > > Could we align to the semantic of /sys/fs/cgroup/memory.swappiness?
> > > > Some distributions like Ubuntu is still using cgroup v1.
> > > 
> > > cgroup v1 interface is mostly frozen. All new features are added to the
> > > v2 interface.
> > >
> > 
> > So what about we add this interface to cgroup v2?
> 
> Can you come up with a sane hierarchical behavior?
> 
> [...]
> > > > For micro-service architecture, the application in one container is not a
> > > > set of loosely tight processes, it's aim at provide one certain service,
> > > > so different containers means different service, and different service
> > > > has different QoS demand. 
> > > 
> > > OK, if they are tightly coupled you could apply the same THP policy by
> > > an existing prctl interface. Why is that not feasible. As you are noting
> > > below...
> > > 
> > > >     5.containers usually managed by compose software, which treats container as
> > > > base management unit;
> > > 
> > > ..so the compose software can easily start up the workload by using prctl
> > > to disable THP for whatever workloads it is not suitable for.
> > 
> > prctl(PR_SET_THP_DISABLE..) can not be elegance to support the semantic we
> > need. If only some containers needs THP, other containers and host do not need
> > THP. We must set host THP to always first, and call prctl() to close THP for
> > host tasks and other containers one by one,
> 
> It might not be the most elegant solution but it should work.
> Maintaining user interfaces for ever has some cost and the THP
> configuration space is quite large already. So I would rather not add
> more complication in unless that is absolutely necessary.
>

By the way, should we let prctl() support PR_SET_THP_ALWAYS? Just likes
PR_TASK_PERF_EVENTS_DISABLE and PR_TASK_PERF_EVENTS_ENABLE. This would
make it simpler to let certain process use THP while others not use.

> > in this process some tasks that start before we call prctl() may
> > already use THP with no need.
> 
> As long as all those processes have a common ancestor I do not see how
> that would be possible.
> 
> -- 
> Michal Hocko
> SUSE Labs

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C2F6F5FDB
	for <lists+cgroups@lfdr.de>; Wed,  3 May 2023 22:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjECUMZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjECUMW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 16:12:22 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB78A7D
        for <cgroups@vger.kernel.org>; Wed,  3 May 2023 13:11:55 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-74e19dcf217so255418885a.2
        for <cgroups@vger.kernel.org>; Wed, 03 May 2023 13:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683144713; x=1685736713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6aQuySOZ5f1xPp5M/IH7FdCb3YCBcIXK77oTLJoa1To=;
        b=B77wj2uaBiAWD8idxLhj65ewWhJv33njFprJjaUykYSV+6Yt7L5dCUa5lIV4RnTCul
         77+cSySse1ya6C7PyiB0e9SPkdj1lshr0RenyoypDVR8ikg/OEorh8RVaMkmDyZXhpHv
         oV4cTXFAC8UYttofZrb1JTodalX4rrORDCcsv+1Jx7UbO7bLKPm1QGHzfh1gWH9APa83
         /Rf/B+R6oZeNNgEfgORGaxElO0hO+QyuC06nrse5RwbHwLMFubuPNkiSJbC3/nSMBWBu
         ZZk1an8YPsQoRYqubaG4Ci1ht8gXo9iEZqN3Zi7lvLJvcUkK5IQDe48usFI3QGu+5mjm
         PenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683144713; x=1685736713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6aQuySOZ5f1xPp5M/IH7FdCb3YCBcIXK77oTLJoa1To=;
        b=gR1glZ6viHnL+DPElqhvF81k8GJmc20Wh1PnU3xJoQq/vc9AOc5lzJzm8oTF/piF2W
         3n232cWLtuJXf/HM+U1xGZRPhD7oMwIjf+3h4t9gpbxOHeE/tEdcq04gT7mgPAT/6o+J
         wjShB//xmmU9kEExH0jyczBrAoCwKDiuxzDuCm4F1A8R58ZlOdNaTsQTJ85OLgcJy/e7
         SEL+ze04nFGySxVWGvusDucX/7OGoSmcqVO/lLYu/glTFiWQXN1Qm9GkPQfJzQ5o0tRD
         xSg0F32kZSLHOmZScRnaXsNgcM+lY4/mPbG1ra7sp6ow5aQ4hok9vCQphFJJHRLT7t6P
         ftTQ==
X-Gm-Message-State: AC+VfDyyc6M8sl5SaaeXxeXWMXYBv/jXJdHNTUZsvN+kRc/0s+KDCeag
        DQzP9FteQC8blaKsSrpfAJLzaA==
X-Google-Smtp-Source: ACHHUZ5CnnpIpmUeZ/FYpffmDL5OkaJstg4Fl9o3UD/YbGdgvGCcQtxmC6WZwKNTGrttYwJeKB4QiQ==
X-Received: by 2002:ac8:5e0d:0:b0:3e6:9716:ba58 with SMTP id h13-20020ac85e0d000000b003e69716ba58mr2436956qtx.26.1683144712859;
        Wed, 03 May 2023 13:11:52 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id ed27-20020a05620a491b00b0074e2da97de4sm10761665qkb.33.2023.05.03.13.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 13:11:52 -0700 (PDT)
Date:   Wed, 3 May 2023 16:11:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, muchun.song@linux.dev,
        rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
        yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 00/40] Memory allocation profiling
Message-ID: <20230503201150.GB197627@cmpxchg.org>
References: <ZFKNZZwC8EUbOLMv@slm.duckdns.org>
 <20230503180726.GA196054@cmpxchg.org>
 <ZFKlrP7nLn93iIRf@slm.duckdns.org>
 <ZFKqh5Dh93UULdse@slm.duckdns.org>
 <ZFKubD/lq7oB4svV@moria.home.lan>
 <ZFKu6zWA00AzArMF@slm.duckdns.org>
 <ZFKxcfqkUQ60zBB_@slm.duckdns.org>
 <CAJuCfpEPkCJZO2svT-GfmpJ+V-jSLyFDKM_atnqPVRBKtzgtnQ@mail.gmail.com>
 <ZFK6pwOelIlhV8Bm@slm.duckdns.org>
 <CAJuCfpG4TmRpT5iU7bJmKcjW2Tghstdo1b=qEG=tDsmtJQYuWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG4TmRpT5iU7bJmKcjW2Tghstdo1b=qEG=tDsmtJQYuWA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 03, 2023 at 01:08:40PM -0700, Suren Baghdasaryan wrote:
> On Wed, May 3, 2023 at 12:49 PM Tejun Heo <tj@kernel.org> wrote:
> > * Improving memory allocation visibility makes sense to me. To me, a more
> >   natural place for that feels like /proc/allocations next to other memory
> >   info files rather than under debugfs.
> 
> TBH I would love that if this approach is acceptable.

Ack

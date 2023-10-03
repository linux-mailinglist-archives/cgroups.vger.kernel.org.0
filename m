Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C860E7B69BD
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 15:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjJCNDa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 09:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjJCNDa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 09:03:30 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9989B
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 06:03:26 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4196c617ef0so6119571cf.1
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696338205; x=1696943005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCw89XvWZCHmndxFc4KWV08Rgyb0HbAqrU0uJncC/sk=;
        b=R3x3+1WOmaDwvO4JrHthVh4weHZSUqzDl0TSs7IdTMvdcrMY2l/F5vc2jbRGYNtBDE
         olUg2/H6b0x8/0Hzbpz3w0x6mznhxP2cpdDUK5loKE9er3KGsR/T10K1mUVtztBdJEpN
         tq4q1m0T5GdPIRjgnEb1to/4AnJMaMyxvBN7rMbEG81c5b4Pn6HxLLDTLmEzIVifhu0l
         x8eNyRWQNiICtcFjY/UkHxskFqKOe9BpuQbr3ayg0EeKcW1vjXVFU/gYa4kBdgT5uBW1
         DrMHjfRZ1IWov8fzjIu1+nVGDCq21r/9lNmRLsPwIS1ztHEZCcMu8MOmPVnqjc3TCNbf
         jQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696338205; x=1696943005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCw89XvWZCHmndxFc4KWV08Rgyb0HbAqrU0uJncC/sk=;
        b=DjqNVf/Rc0Awpuf8ZkNLRJRAayaEbGUEJozi0nIRSCdE2wnJ/W4hXhAhSXTerBTaZe
         f5uMzb3GGEaSJrGx9t69/v7LHvfiqnXzlhymeNIK73wp3v6IYqf/I2MTK8JpiF6WvOsO
         KSvxwm8RCeZkC7efNbpXm0jTGff5VF4kyFTJ6wtCVR4Y5FcPe1ELAz+4Ea5rv5kcdMdu
         YKqYsziqYk5MdIbsm4k8SKvCaE4Ge3d9Orhz9HkZfw7e3pqcuv8RunV84wyPK8lST9xz
         p8oX6wE4aryTMHU+4YHrndxoAgNlabEcnwnAyOFlFP+ipNYMVizKluw6QT2mTuDXKriz
         Q/GA==
X-Gm-Message-State: AOJu0YyMBL3P4vQ3ZmEKiBOklufFbsSEociWOU05TkSlA3n9+5a/NX/c
        c7ADKcSx8+/+Jjehd4IRRjkWQA==
X-Google-Smtp-Source: AGHT+IHJRnQwY/cLx6XnU1FucbI8lpoWcQVVxYTA0fLNl6NJEePNW8Yk3Bxbjfb+E/rxyi+rGXbwNQ==
X-Received: by 2002:ac8:7d44:0:b0:419:4c9d:8738 with SMTP id h4-20020ac87d44000000b004194c9d8738mr20418260qtb.46.1696338205642;
        Tue, 03 Oct 2023 06:03:25 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id z5-20020ac87105000000b004197a3872f9sm416244qto.86.2023.10.03.06.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 06:03:25 -0700 (PDT)
Date:   Tue, 3 Oct 2023 09:03:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: memcg: refactor page state unit helpers
Message-ID: <20231003130324.GC17012@cmpxchg.org>
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175741.635002-2-yosryahmed@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 22, 2023 at 05:57:39PM +0000, Yosry Ahmed wrote:
> memcg_page_state_unit() is currently used to identify the unit of a
> memcg state item so that all stats in memory.stat are in bytes. However,
> it lies about the units of WORKINGSET_* stats. These stats actually
> represent pages, but we present them to userspace as a scalar number of
> events. In retrospect, maybe those stats should have been memcg "events"
> rather than memcg "state".
> 
> In preparation for using memcg_page_state_unit() for other purposes that
> need to know the truthful units of different stat items, break it down
> into two helpers:
> - memcg_page_state_unit() retuns the actual unit of the item.
> - memcg_page_state_output_unit() returns the unit used for output.
> 
> Use the latter instead of the former in memcg_page_state_output() and
> lruvec_page_state_output(). While we are at it, let's show cgroup v1
> some love and add memcg_page_state_local_output() for consistency.
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

That's a nice cleanup in itself.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

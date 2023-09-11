Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284D479AF17
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 01:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377473AbjIKW0e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 18:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244399AbjIKUVb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 16:21:31 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A38E0;
        Mon, 11 Sep 2023 13:21:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c0ecb9a075so34417225ad.2;
        Mon, 11 Sep 2023 13:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694463687; x=1695068487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djFVbSPSCUqIznFcytjoMNrEsFpZVt4WCJe34ZTsb1w=;
        b=RSwAmzG8v/RqCT8e5xiIlSED1U2WtlkcohA8oOCPRcBgqo0YpBwFqq+LiCxbbofVqE
         x58Z7l/ELwkOhe5hNLVkTFD8NFeUplhHtv0/DzKf/WfSxj4tEZrPR9T+mRVUsnOjqSkw
         +sAfCCfuOPvMmXyGlcolRxuvyVJh0pGrmw5MlsooghFxVcMmZW/rnl6WeQVoGwPx3scG
         xae3habIc8WRwHw3tyqyaEToqY4cJ3Bzo3u6zb9f+jROIu7yvZOtORAZCck8/1NTB5O9
         h8WH64IFfMrdjZ1f16Kr1fDRZ81PtKksGft/ARURIAaRPbbw3pD+DVwSvFq6GS3Ks982
         gsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694463687; x=1695068487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djFVbSPSCUqIznFcytjoMNrEsFpZVt4WCJe34ZTsb1w=;
        b=c0gqG+vvQB+bgle0OyL57FNCZVi8SuOoQVrAZGo4q1ZUS9L4jd+m80ccYM8j/aQ9oa
         l89qQqaFlujyteWrdWh+Wmi/0iHj1pK/djWxdlGzjOxarrnz3WL2fKihU9bf1HpDb7ts
         gC4HGJlxBiINbYMILJ6w8KyfVn25JNK2yO/eTkC5WgfvKNfQVGtPP4/pRyKvYNzOBFzt
         bG203VsFttBV4yfNxHxxC7wh27gpPwNrWdHqR0c4dl4vXbHVMbPU+w/bE0DKS1TBRsx9
         QNfLZ5C+DCYcf2M+uF3N0+C1t35y+QfDj9e5vRLTWl/12xhEVKoKrWdiuoxmNiumkRzG
         DMOg==
X-Gm-Message-State: AOJu0Yymtg8d3/BwKv3zr11NHxhLG7PDLTHxMcaDyyCUwO/d02iJtRI5
        wRaBxzAcLoQaSmD06ijHQFg=
X-Google-Smtp-Source: AGHT+IFm3ORyZOdteaHbLXIuoVa/NrrR2S6J5B8bPeL3jC8guAY4KfF9nPYEgzTFr2rj3NbEjiNNWQ==
X-Received: by 2002:a17:902:e811:b0:1c3:2df4:8791 with SMTP id u17-20020a170902e81100b001c32df48791mr10280357plg.27.1694463686599;
        Mon, 11 Sep 2023 13:21:26 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902748800b001b8b2b95068sm6827631pll.204.2023.09.11.13.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 13:21:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 11 Sep 2023 10:21:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wei Xu <weixugc@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH v4 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <ZP92xP5rdKdeps7Z@mtj.duckdns.org>
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-5-yosryahmed@google.com>
 <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
 <CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com>
 <ZP8SDdjut9VEVpps@dhcp22.suse.cz>
 <CAAPL-u8NndkB2zHRtF8pVBSTsz854YmUbx62G7bpw6BMJiLaiQ@mail.gmail.com>
 <ZP9rtiRwRv2bQvde@dhcp22.suse.cz>
 <CAAPL-u9XwMcrqVRu871tGNKa3LKmJSy9pZQ7A98uDbG6ACzMxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAPL-u9XwMcrqVRu871tGNKa3LKmJSy9pZQ7A98uDbG6ACzMxQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Sep 11, 2023 at 01:01:25PM -0700, Wei Xu wrote:
> Yes, it is the same test (10K contending readers). The kernel change
> is to remove stats_user_flush_mutex from mem_cgroup_user_flush_stats()
> so that the concurrent mem_cgroup_user_flush_stats() requests directly
> contend on cgroup_rstat_lock in cgroup_rstat_flush().

I don't think it'd be a good idea to twist rstat and other kernel internal
code to accommodate 10k parallel readers. If we want to support that, let's
explicitly support that by implementing better batching in the read path.
The only guarantee you need is that there has been at least one flush since
the read attempt started, so we can do sth like the following in the read
path:

1. Grab a waiter lock. Remember the current timestamp.

2. Try lock flush mutex. If obtained, drop the waiter lock, flush. Regrab
   the waiter lock, update the latest flush time to my start time, wake up
   waiters on the waitqueue (maybe do custom wakeups based on start time?).

3. Release the waiter lock and sleep on the waitqueue.

4. When woken up, regarb the waiter lock, compare whether the latest flush
   timestamp is later than my start time, if so, return the latest result.
   If not go back to #2.

Maybe the above isn't the best way to do it but you get the general idea.
When you have that many concurrent readers, most of them won't need to
actually flush.

Thanks.

-- 
tejun

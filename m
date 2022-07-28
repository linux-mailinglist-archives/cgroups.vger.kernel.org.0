Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E795847D1
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 23:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiG1Vp1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 17:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiG1Vp1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 17:45:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E3A3120F
        for <cgroups@vger.kernel.org>; Thu, 28 Jul 2022 14:45:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w63-20020a17090a6bc500b001f3160a6011so4661920pjj.5
        for <cgroups@vger.kernel.org>; Thu, 28 Jul 2022 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=syTibly++ru0N5dyOkn/AFiof+YpFKyPJXjkdOxn6gY=;
        b=L3hxNosa6HA4NUd9AdAGbBt8zqIgmzSokN+t1MndZ5DH+YwDHtTfwjQ7ysWwnOQu6U
         egZdf6+7EyjXaFe8p/GKWXn8F0H28Ca6aTuWXhOncQugzVRY7tt/l0KTPDx4j1yBxsWK
         E49Vyt/Z8IBHE1uHPCIvfiV1tH2r9WVENn9uiVQuLzc8vunUHnqf3qUrNj44eE2rLws6
         RXyOv6WOCR3tsS0OuyVcYEdEBXqUUFr6v9FxyaOwGAg4Y8XlWcfUYCSq/vk6Y6jhZG/u
         Mz1IGyYWm+1WWkTEwb3VTI5ZrVMF7ALXOpCZQrvhwaQWGQHwpSFM5L43t3BqBH4+BmTG
         ymew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=syTibly++ru0N5dyOkn/AFiof+YpFKyPJXjkdOxn6gY=;
        b=f3Jsbpn60AS/BbV63icKA/gwh4rGW7iy33bRSPPbpDCaXpdskAOHV1CktO7/cNgrIW
         EWnZOS+aNfN2pzAdBqt6DthtBkJ738PHMTR1uWmShSf9jcINYmqQmkj1fmGkZo24Ojdz
         g40nzBgJ3B28yXCr46j2NhldqxqOfROQmTPUiv6R5jpEn2+gRATWXrHWFrPjLWv+xFsP
         3NgeLK7kqsNPwrZPCFg4y+atK/2zxztzMTJWgsDtvvnzDitt/WXI/VFTAoOQOpkLwLfl
         p4eCcmSzqyRI0k+zYXW5DXQz6RPfL0wFqa9mqAE27/ZXi74H8BHT9Gomf5KlHcqjbkpB
         yLkQ==
X-Gm-Message-State: ACgBeo0DkqHLS3CvcPmpEzCyQnLB2Iqu1JjL7pGoG4I00EYLUO5F9uSh
        Koi+V4Lq9cAlYOHowGuOy6dIdA==
X-Google-Smtp-Source: AA6agR4eChmymv69Y/dyrU+TW7AUx28+KYMTAoj0VCS7id8iD24Ny/uX3oO4MgWwj+9zXsJk8i8qbw==
X-Received: by 2002:a17:902:f70d:b0:16c:50a2:78d1 with SMTP id h13-20020a170902f70d00b0016c50a278d1mr784242plo.34.1659044725833;
        Thu, 28 Jul 2022 14:45:25 -0700 (PDT)
Received: from [2620:15c:29:203:7a4b:8126:8bad:d042] ([2620:15c:29:203:7a4b:8126:8bad:d042])
        by smtp.gmail.com with ESMTPSA id h131-20020a628389000000b00528d880a32fsm1264930pfe.78.2022.07.28.14.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 14:45:25 -0700 (PDT)
Date:   Thu, 28 Jul 2022 14:45:24 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5] mm: vmpressure: don't count proactive reclaim in
 vmpressure
In-Reply-To: <20220721173015.2643248-1-yosryahmed@google.com>
Message-ID: <539ddf30-160b-848d-5249-770963cba5ab@google.com>
References: <20220721173015.2643248-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 21 Jul 2022, Yosry Ahmed wrote:

> memory.reclaim is a cgroup v2 interface that allows users to
> proactively reclaim memory from a memcg, without real memory pressure.
> Reclaim operations invoke vmpressure, which is used:
> (a) To notify userspace of reclaim efficiency in cgroup v1, and
> (b) As a signal for a memcg being under memory pressure for networking
> (see mem_cgroup_under_socket_pressure()).
> 
> For (a), vmpressure notifications in v1 are not affected by this change
> since memory.reclaim is a v2 feature.
> 
> For (b), the effects of the vmpressure signal (according to Shakeel [1])
> are as follows:
> 1. Reducing send and receive buffers of the current socket.
> 2. May drop packets on the rx path.
> 3. May throttle current thread on the tx path.
> 
> Since proactive reclaim is invoked directly by userspace, not by
> memory pressure, it makes sense not to throttle networking. Hence,
> this change makes sure that proactive reclaim caused by memory.reclaim
> does not trigger vmpressure.
> 
> [1] https://lore.kernel.org/lkml/CALvZod68WdrXEmBpOkadhB5GPYmCXaDZzXH=yyGOCAjFRn4NDQ@mail.gmail.com/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: David Rientjes <rientjes@google.com>

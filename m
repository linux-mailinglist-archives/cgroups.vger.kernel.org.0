Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7BA9136081
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2020 19:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbgAISwE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Jan 2020 13:52:04 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38906 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388517AbgAISwE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Jan 2020 13:52:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id f20so2905473plj.5
        for <cgroups@vger.kernel.org>; Thu, 09 Jan 2020 10:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2BBH+3AnXzeFa/U3IS7qGFZcMtEqxZT7wCj3mRBcmeM=;
        b=eklIOp+zakQC1CE30sXqMuWzAwbyxZX8INDxq4BFkauoMMbdQ17lXR/YY65/cbXQ45
         WaN7oI/vJTlxvxToHdamg6mLQomJzQulnRCGUbZceY2CzjGzTD8sJeTKHRgIKWwwEevq
         rYiw6LQC0MJ7yxDH44OqGwqt74Nt03fWbVUE+CV+sFa+mMVT9MXWSPjDJB9QEKeWbMkS
         pu/xIlbtYzrdTy2A0YpgtvbfD6SPFwyDz7bhKJdo/Fqrxw9RrPP9Ya2Lv6KnwMa3B29w
         Q4qCIzysKksxVLY80Wshbr7UR+tk8nkzbwA6lSE1ht7jWyXNE8DH00YJQGQzk4S8T1hZ
         jd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2BBH+3AnXzeFa/U3IS7qGFZcMtEqxZT7wCj3mRBcmeM=;
        b=B0grMWtndxvJmiKjd29KeJ7secDYNV4pIKsLJ6QIXBMA7BtgU6ZZXkNI4jODwxkKSv
         94W/tw5xsdrHfw41HztFtQQTSo0iwjfk4zQYSSgqLqXN5mkNQb/Y6blxWP/pqhTe/7WP
         EvHs7zY1nk84vUekMQMIhxw8tfrjrR8AzUhaITWIwdjTJ9TDwUMk4Zg52PuiZpPU5Nr6
         OUtvGqn54BXa1xSL5Dz0/gkuetnNaEcMPDcDOm/cOi0OxUyXNvs82KXjRaPnk2qr+xZO
         5psL7ZMMUqecYMIL78cMYe4Whf60qKssu2sxXplqsKOGQ+8yV+BHl0Yyqeph/9dqHRz7
         TyjA==
X-Gm-Message-State: APjAAAXvA4UaiYD+rUTdFBUaHj3i2QZFvq9Ci+R24R9CTn7pBOQ5kvDN
        EkRIwh9cfJyJXX6qD8t+GkogBQ==
X-Google-Smtp-Source: APXvYqzu1AT5fUNssLnQhi7nJ1GkArk3aIGlfIGILpdyhzsUwYdHio63+zgbvvMa4cim9caHMu4yxw==
X-Received: by 2002:a17:902:6bc3:: with SMTP id m3mr12900090plt.185.1578595923103;
        Thu, 09 Jan 2020 10:52:03 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y14sm8351242pfe.147.2020.01.09.10.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 10:52:02 -0800 (PST)
Date:   Thu, 9 Jan 2020 10:52:01 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        alexander.duyck@gmail.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer
 list
In-Reply-To: <20200109143054.13203-1-richardw.yang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2001091051160.57374@chino.kir.corp.google.com>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 9 Jan 2020, Wei Yang wrote:

> As all the other places, we grab the lock before manipulate the defer list.
> Current implementation may face a race condition.
> 
> For example, the potential race would be:
> 
>     CPU1                      CPU2
>     mem_cgroup_move_account   split_huge_page_to_list
>       !list_empty
>                                 lock
>                                 !list_empty
>                                 list_del
>                                 unlock
>       lock
>       # !list_empty might not hold anymore
>       list_del_init
>       unlock
> 
> When this sequence happens, the list_del_init() in
> mem_cgroup_move_account() would crash if CONFIG_DEBUG_LIST since the
> page is already been removed by list_del in split_huge_page_to_list().
> 
> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Acked-by: David Rientjes <rientjes@google.com>

Thanks Wei!

Andrew, I'd also suggest:

Cc: stable@vger.kernel.org # 5.4+

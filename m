Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A66BD1260C9
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2019 12:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfLSL0V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Dec 2019 06:26:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40093 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfLSL0V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Dec 2019 06:26:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so5591390wrn.7
        for <cgroups@vger.kernel.org>; Thu, 19 Dec 2019 03:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZxINuY2pTedRL5AOR8tT78C1M2jclzElPJ7W9Ytee4A=;
        b=Nj6BUQEZ+CRfeqS8i/TOUwhdSD/LqqktFae+t7JfgDcNBTv07sDWW+AN6qK4jJxq2b
         bD96kwCBm+NCxbmhwMq95YWUG6nwJtQUz+B0gWcpUboDbYAvGxtqalmKIIDrPQsdQakD
         0vumq1+lukQ7gHQ8kRlgoND+EH8XGHRzhB5Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZxINuY2pTedRL5AOR8tT78C1M2jclzElPJ7W9Ytee4A=;
        b=aa7ekmAhdrG/IDx4bSk1c+QW7Fw+bcJNNUtjGtbAi+ub0YIkxHC+S6pgFCxNrRng4g
         zzsCjFEzTwbhyxzOGs8qiQCw+lpTx+zbkuPahTQQZMYB26adSQe3aifXMxu9Eayp2UkY
         Tbp9jMfzGY43AFqJc3A11LSf7OGU2vz9/yOlroSiE96DyWefe3d20ryH3X3lt/Xup0fD
         HGtLSgyCygyR5Epvcq5nvxjIciplU9X9kOseFKRYTtD2poPOD9jkTgQPeLURn9W6V3eA
         DU3NHziLpZDba9HCYbFkRdt9lW8H2BYOnoGM0+WgZ6sbirPFKX0jQ0EqVD/izqzZW4Rg
         KCpg==
X-Gm-Message-State: APjAAAWEmJQ2sAlqGkUe10NmPkuaBYz4pYlhEMO026ii0LJZnUlA/ykV
        Lg3HqUN/Bu42ipiGz/9tD7zr4A==
X-Google-Smtp-Source: APXvYqzYYXrskQ1fe2mPfv0sYrehg6SOYYoZVfiW64/lsm4OI0an3dqEGvYMZJ/Hh5HOscaWldIplg==
X-Received: by 2002:a05:6000:12ce:: with SMTP id l14mr9363595wrx.342.1576754779511;
        Thu, 19 Dec 2019 03:26:19 -0800 (PST)
Received: from localhost ([2620:10d:c092:200::1:c2e5])
        by smtp.gmail.com with ESMTPSA id a16sm6039042wrt.37.2019.12.19.03.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 03:26:18 -0800 (PST)
Date:   Thu, 19 Dec 2019 11:26:18 +0000
From:   Chris Down <chris@chrisdown.name>
To:     teawater <teawaterz@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, guro@fb.com, shakeelb@google.com,
        Yang Shi <yang.shi@linux.alibaba.com>, tj@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmscan: memcg: Add global shrink priority
Message-ID: <20191219112618.GA72828@chrisdown.name>
References: <1576662179-16861-1-git-send-email-teawaterz@linux.alibaba.com>
 <20191218140952.GA255739@chrisdown.name>
 <25AA9500-B249-42C2-B162-2B8D4EE83BB0@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25AA9500-B249-42C2-B162-2B8D4EE83BB0@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Hui,

teawater writes:
>Memory.min, low, high can affect the global shrink behavior.  They can help 
>task keep some pages to help protect performance.
>
>But what I want is the low priority tasks (the tasks that performance is not 
>very important) do more shrink first.  And when low priority tasks doesn’t 
>have enough pages to be dropped and system need more free page, shrink the 
>high priority task’s pages.  Because at this time, system’s stable is more 
>important than the performance of priority task.
>With memory.min and memory.low, I have no idea to config them to support this.  
>That is why I add global shrink priority.

For sure, that's what I'm suggesting you use memory.{min,low} for -- you define 
some subset of the cgroup hierarchy as "protected", and then you bias reclaim 
away from protected cgroups (and thus *towards* unprotected cgroups) by biasing 
the size of LRU scanning. See my patch that went into 5.4 and the examples in 
the commit message:

     commit 9783aa9917f8ae24759e67bf882f1aba32fe4ea1
     Author: Chris Down <chris@chrisdown.name>
     Date:   Sun Oct 6 17:58:32 2019 -0700

         mm, memcg: proportional memory.{low,min} reclaim

You can see how we're using memory.{low,min} to achieve this in this case 
study[0]. It's not exactly equivalent technically to your solution, but the end 
goals are similar.

Thanks,

Chris

0: https://facebookmicrosites.github.io/cgroup2/docs/overview.html#case-study-the-fbtax2-project

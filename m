Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8A1C065E
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2020 21:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgD3T3U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Apr 2020 15:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgD3T3U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Apr 2020 15:29:20 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B59C035495
        for <cgroups@vger.kernel.org>; Thu, 30 Apr 2020 12:29:19 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w29so6084074qtv.3
        for <cgroups@vger.kernel.org>; Thu, 30 Apr 2020 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/eq6aHDyq4eplML2a4cRLGlwq126IAji+Fvgv3MjJ3w=;
        b=b4OU7wwbA3wxPurcG9pIX2GntI2Xn9noV/RldtqK/ry2Aih34RZFyG37mvEUhqPgUJ
         FZuolZ4rblAdaMTfLS/iPurKZ2F/6LgIKXT/SPaEjMRd+QYwp0iY0BM+tlLBA7fvDX0b
         PoKDmL7E0sHYEdt3HL88joyXkVl1giGBlW/wGc0A4Z+11ui4tXTZR9v+/zrk6N9GA6vQ
         haEP1z4FLxKtLHf0Jh1JXqAuHFmIlunGDsdbG4opwBuPEkRLvy8YZ6HWRP9GmVpISVqB
         FH581z7KqQk9BGUSOLm3k9zUxr+9oN1hYP+uY2Iia++2Azdeu1TiYpS2K1o6nZxcsaMj
         dT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/eq6aHDyq4eplML2a4cRLGlwq126IAji+Fvgv3MjJ3w=;
        b=ou4JkCE+OpevVwKApHMkyCVRWRzvCGHr45R2cH0Iba9WO4LOouNJSY3v9XbbrdqqUq
         8c3GPjoi1McrqC1lBHQkHcL1wkzkxw4AsuKT2V6YJN/nmTE1MV4xbJ+cRCNAxc/o4J/O
         cA99DMdRzvJU4vf52w96cPLUWTO47Jz2aGxB/0yE+LyGhPcK7IiVpYlqjpuetTU0D5qA
         7gIKWAaNgibMj4QncD3ZGay8x0uLWEiT+JitjthqTj7ntTsThqVXwRlfuYe/SLO0pUgz
         oZVfVTvuILTTFlqZJUiDyzon81YNVRKiHoNcIBAGp9oqqLnp9EnEZowNEGKsGeu2Nh54
         ig2w==
X-Gm-Message-State: AGi0PuZ/+VCHvgOwG6N5IEHDiydiRqRhO6/mdS3pP4OBuYBj4IQUWJrE
        wloGN1gbRMA4ki6bnyxXfwxAxg==
X-Google-Smtp-Source: APiQypJkMljmJVrYuqw1/FA/joYSeHchiIXs0+3QO3JPks1R2xxvo8ZkpSGPuQBznRyTzHv3YCWvFw==
X-Received: by 2002:ac8:1885:: with SMTP id s5mr2430qtj.253.1588274958913;
        Thu, 30 Apr 2020 12:29:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:63a7])
        by smtp.gmail.com with ESMTPSA id u27sm543996qtc.73.2020.04.30.12.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:29:18 -0700 (PDT)
Date:   Thu, 30 Apr 2020 15:29:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200430192907.GA2436@cmpxchg.org>
References: <20200430182712.237526-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430182712.237526-1-shakeelb@google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 30, 2020 at 11:27:12AM -0700, Shakeel Butt wrote:
> Lowering memory.max can trigger an oom-kill if the reclaim does not
> succeed. However if oom-killer does not find a process for killing, it
> dumps a lot of warnings.
> 
> Deleting a memcg does not reclaim memory from it and the memory can
> linger till there is a memory pressure. One normal way to proactively
> reclaim such memory is to set memory.max to 0 just before deleting the
> memcg. However if some of the memcg's memory is pinned by others, this
> operation can trigger an oom-kill without any process and thus can log a
> lot un-needed warnings. So, ignore all such warnings from memory.max.

Can't you set memory.high=0 instead? It does the reclaim portion of
memory.max, without the actual OOM killing that causes you problems.

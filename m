Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B8F243C73
	for <lists+cgroups@lfdr.de>; Thu, 13 Aug 2020 17:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMP1n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Aug 2020 11:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMP1m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Aug 2020 11:27:42 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D588CC061757
        for <cgroups@vger.kernel.org>; Thu, 13 Aug 2020 08:27:41 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b79so5488638qkg.9
        for <cgroups@vger.kernel.org>; Thu, 13 Aug 2020 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G9xj0y6YeO21IlkG6XCM+8OPoUpTIPBGk2H9BHdLfSg=;
        b=HG4WQqEJcLlVKhUoZ+ZzL2ku31xqzCdktta2BUIcGHOHeXS2x+Z+bpSKozf/uKsSU6
         nH7FjwY8wREbLLxUQ0XutkdGbEKbrqq2maifB1FgpRjn0gi4ASzmNZTkeAoeONFbjGSK
         AMrXPvoE5cT0o0gmAciyEZSK5xawGLw+Qq7J6orOfK2N8RSPMApEKs3SQ6RnOIxcXOPO
         yJESYqBLxp2AeIhjY9Khe6Xzs/ORGoGruEctyh3JEfGl8DGxJk/Xe6vxtlES6FOFF7uD
         7L6Df9CYLSzw/igPnf62aobisTPa7qmceeUvn5HRLK8QZwqNHxCHgcSZtMeO6prczf3v
         GFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G9xj0y6YeO21IlkG6XCM+8OPoUpTIPBGk2H9BHdLfSg=;
        b=JXX2FtJBFTDpjpVZ4hza46gu9VJwq/hpsOu+Kc2o3oHt0v3vqANDcNHp+fgp4irJUE
         L9twvMR7yaQ6grGUzala39Oc9KToJ0ZYmhhC0DInlUhVlspAS8tQu00s178b5ApSK+QO
         +szBLsiBzThaCiKOM1xV/wbTxpLCQZHvVTzLIZgu30IlaDH7VmLN60uTekZtaRlsSijw
         5NpDto+SQCSb2rSp3/GryByHAtgQ3fYjcrI+hWYUBXQtMUy5GmuqaiUHlw95NSzZ6ALz
         o0ZZNmNBv1n6XktfRR3YjQdfiaIyYcM2whWDqAcPbjiABpzf9OB2vYzPL7g4GkckcF0Y
         4HPQ==
X-Gm-Message-State: AOAM532A0IPr/TpG9CdYGRMfB5Rb7Fztg/Mb/bRMb9vjPlZPuD3vt4lX
        h+2b7q2vACRVC7W+qyluWr/fNw9su1g=
X-Google-Smtp-Source: ABdhPJzR1UcCuoUmRFqwdqkJEoSmaPgweCv6fOxpFKvhmjozMwxU2Pt3O9TcNKReAtBXHTwq7sUN1g==
X-Received: by 2002:a37:a54b:: with SMTP id o72mr5037864qke.289.1597332460693;
        Thu, 13 Aug 2020 08:27:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:7cdc])
        by smtp.gmail.com with ESMTPSA id n184sm5795880qkn.49.2020.08.13.08.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 08:27:40 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:26:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     syzbot <syzbot+35d35ef677516d65bdda@syzkaller.appspotmail.com>,
        Roman Gushchin <guro@fb.com>, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        vdavydov.dev@gmail.com
Subject: Re: upstream boot error: WARNING in mem_cgroup_css_alloc
Message-ID: <20200813152634.GB701678@cmpxchg.org>
References: <00000000000019317f05acbf31bd@google.com>
 <20200813104416.GE9477@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813104416.GE9477@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 13, 2020 at 12:44:16PM +0200, Michal Hocko wrote:
> This smells like 3e38e0aaca9e ("mm: memcg: charge memcg percpu memory to
> the parent cgroup").

I just replied to the other thread on this issue here:

https://lore.kernel.org/lkml/20200813152033.GA701678@cmpxchg.org/

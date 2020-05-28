Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2CB1E6350
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 16:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390913AbgE1OHJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 10:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390838AbgE1OHH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 10:07:07 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ADDC05BD1E;
        Thu, 28 May 2020 07:07:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h9so104194qtj.7;
        Thu, 28 May 2020 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c5VdfREkwzP6jqIZOFDaLilS2V6xWZ7RlAK0qP0rVTk=;
        b=abkUbCeVYyXvcNltdNzDUgkNUMN3nP0G3xnhUGHnZUuEMdO6cRsZZ7n/D5Rg8eIbNO
         PacVhQuQPeB+TJiYa8kZyUeGuPxjdQY/gELpvgbCoMNtz8SUQmKZRrqI6M9CWx2gL8aV
         je+gLtCguH3qjw0tUkfwThHVHnDklXRC2D6GGPGIWyBXVjCBZR7C1ZDVgZD6ovLN/BIT
         16ld6VTwiz4Cl1I45loB2HA4yLHDyBxGZ9u39pWfemEE2/JIIdoNh0gDNniTuAJAFL80
         jOW8cM2fxAQQya/uxtGanKJ6yfJ4gChPso1P2Fa5PhyoJ3jtpYZzVWQ2BzgYrpGCR7Pr
         DS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=c5VdfREkwzP6jqIZOFDaLilS2V6xWZ7RlAK0qP0rVTk=;
        b=Y42W/maE+OLR5rD1+smIQOP5herxsiL3jh9j09zMbyWFS5TpFzfEYMDTczMLv/CxE6
         mHDqEJmyHruVDBCZKLiK7FicOjaPAH8v5z/cTe1CbcJ5gUxqzryJfuvU7p+jQxp5XYKQ
         QIlm62KZHA92CKctIrBfwCes5IDAAnakQXzHP5jzDxoWq1sVvsel++svUNL+TMrxKaQD
         Z0MvOp1JmQFry/nZ4+eHrwYAp4Ze0RQhlLVjQW5z+4QKzPcVCBaYAVi4BoPzaKrpOUJX
         cBskwub7617IIRHtH0E/3O1iLNh+sLG31BqIn6DhC4KmtQ1iJbUR9Eh3t3P8K8HXJy9Q
         8xJg==
X-Gm-Message-State: AOAM530WToqya1FDhWSbJu1RZwkGX8QX/mHQkwRpnL7M83IKotc3qwNk
        M6vNbRnxbUASFaDsul86TFs=
X-Google-Smtp-Source: ABdhPJx9AqNQeDf9fciJx3SDMxleg/u0TJjZ+jEiiOPW3cxsgZLFQKxCeDBOYtGjH666D5na98etJg==
X-Received: by 2002:ac8:2a55:: with SMTP id l21mr3220535qtl.151.1590674825723;
        Thu, 28 May 2020 07:07:05 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id e27sm4658703qkl.47.2020.05.28.07.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:07:04 -0700 (PDT)
Date:   Thu, 28 May 2020 10:07:01 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 cgroup/for-5.8] cgroup: add cpu.stat file to root
 cgroup
Message-ID: <20200528140701.GM83516@mtj.thefacebook.com>
References: <20200527160821.GC42293@cmpxchg.org>
 <20200527214316.524124-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527214316.524124-1-boris@bur.io>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 27, 2020 at 02:43:19PM -0700, Boris Burkov wrote:
> Currently, the root cgroup does not have a cpu.stat file. Add one which
> is consistent with /proc/stat to capture global cpu statistics that
> might not fall under cgroup accounting.
> 
> We haven't done this in the past because the data are already presented
> in /proc/stat and we didn't want to add overhead from collecting root
> cgroup stats when cgroups are configured, but no cgroups have been
> created.
> 
> By keeping the data consistent with /proc/stat, I think we avoid the
> first problem, while improving the usability of cgroups stats.
> We avoid the second problem by computing the contents of cpu.stat from
> existing data collected for /proc/stat anyway.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> Suggested-by: Tejun Heo <tj@kernel.org>

Applied to cgroup/for-5.8.

Thanks.

-- 
tejun

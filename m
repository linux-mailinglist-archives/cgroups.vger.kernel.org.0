Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988681A2F1
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2019 20:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfEJSYB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 14:24:01 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37352 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbfEJSYA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 14:24:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so7727642qtp.4
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sKS5Fj/EEtSMbliwSHz31jl5UWhgaLLNKzcdv3HiOg8=;
        b=AgdKZn6HYNv221xca0XVSBa2lJs6g9ZN/fDhC0UKtfgh86gPpSKySDa8EHoKdAkwXh
         OPUbb6rjj/0vZD/52ALcm64YAno6w2qlc0fZjC556wrBTip/57WnH2tDAaXD5ez1ykP8
         6Bp99KZjroFrISTsE/THxKq7QrHKJtfroBoHARBah1Wh6GBCOWku+dgatZbZfhyf0eB0
         AN5ykQG4Lvlbb9jLvV1MuBig9RfA6zoMDp19p9oQcsaMcNuI8AQdk0XWpINbpniDzEs0
         wsXTfIJ2mhbB3kKPHj+HwVBWOY/vqx1LhxJRZhVqxJ7lb3HYOLWt381D0k7h8ebVtWZ9
         EfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sKS5Fj/EEtSMbliwSHz31jl5UWhgaLLNKzcdv3HiOg8=;
        b=DA8Ym98czsfw0/j+CgcLccMYPTSUbxYiU32Po4Hh+YnNrKIXl7iOg5SaKsVwEnz4Fi
         i/+ZFCW7bPMmzifOCQeqAJn3ergPs6Bucz2gl9DlMLoYVE9ziKFfZem0NSt88PJ9JA+t
         IFYwkhyf/EOr6CFH5DhMtkckYqa81fK91dQyp0GCPFsLvtR9xayEAm2LBzIEF/OHfqXo
         Js9M4hP2XJS6aC2jinz/ARl3DSoOvv9sTemO9nqucNpZnRiDkjlK8NKYAPjXMGyciw8f
         hyFRWlAiqbyXEVKIl95mC2Lhb/YJXwVg/uqEevg7Y91sRpFiz4E0r6wjFynD3PQxB+dw
         SKAg==
X-Gm-Message-State: APjAAAWgGqz7Now3PFEchocBJ4P6rASTUGypGBI9ASwvowFsOL3pXEJT
        Q4IDJ94mnpsvHPgqyTEoq+yS/Q==
X-Google-Smtp-Source: APXvYqw7LGTG/ljbnARCaw3FB1QZV622KVj8crTejgs8O9VGh7OGeNSVMe79Qp0PZrvgjCfQAYrO+g==
X-Received: by 2002:a0c:b99c:: with SMTP id v28mr10440432qvf.10.1557512639945;
        Fri, 10 May 2019 11:23:59 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id x7sm3026823qkc.22.2019.05.10.11.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 11:23:59 -0700 (PDT)
Date:   Fri, 10 May 2019 14:23:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dan Schatzberg <dschatzberg@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] psi: Expose pressure metrics on root cgroup
Message-ID: <20190510182358.GA14027@cmpxchg.org>
References: <20190510174938.3361741-1-dschatzberg@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510174938.3361741-1-dschatzberg@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 10, 2019 at 10:49:34AM -0700, Dan Schatzberg wrote:
> Pressure metrics are already recorded and exposed in procfs for the
> entire system, but any tool which monitors cgroup pressure has to
> special case the root cgroup to read from procfs. This patch exposes
> the already recorded pressure metrics on the root cgroup.
> 
> Signed-off-by: Dan Schatzberg <dschatzberg@fb.com>

Looks good to me, thanks Dan!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

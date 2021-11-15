Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA89D4516CC
	for <lists+cgroups@lfdr.de>; Mon, 15 Nov 2021 22:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbhKOVpn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Nov 2021 16:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350819AbhKOVjt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Nov 2021 16:39:49 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4691EC0613B9;
        Mon, 15 Nov 2021 13:21:45 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c4so16164617pfj.2;
        Mon, 15 Nov 2021 13:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZUQPppR9ZjdFkfvvbN8Bq2EG2Ba0aYSmf4rrcM4Gmzw=;
        b=QtWenNQeXFjBE1vmgcC7t0MMDldUBUq9hovNAQXWl/AZPpQXLrm9PUGLdGxY47kUYT
         y2LDUJHzeO54cT5ezi2EW3SWD/blO+R2SQToifds73Sge4ro6JWPbCH9/IqUPPZ7PsGF
         xrDjZ6P6bJce25D0eKtzhbymuBuCt9OdEI4kmT1ij5gkD9PaONAVj47FghdY//lazm+P
         JkdSWQXKJ9r+xpXMmlcOcdlxw0YzaHxB0Jh+yz7+6fG2HZ0TLFD5UjMn6FmY6Ox9PFxy
         L+h/l4zBePwFwrOgD5m6AUGh2kXQ3ukcxvDaBLBj7k+DnooNzJR+LBuCG1OUeOhoQ5ci
         lfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZUQPppR9ZjdFkfvvbN8Bq2EG2Ba0aYSmf4rrcM4Gmzw=;
        b=gWXXFzE3+Takh1G2aBGuY3UpDhzs7i+Sza7Ux0Hd73HWqVZtcwPf6bT5IHFM3rzeC4
         uCUeD7Q/k1eRq5odsgti7uFBMb9mmX9nlDIL2nSpkXTUM4nybCKKB57zwO6B2yATp+7X
         YVe7RrDU83CtQ2zb8bZBOz6P17S9rperSn3ylkJBOiRDL9/KVkVmY5aHO6Qrgkn9EdbF
         BsoQsax9PDnrhI76egOVxTJWBYgA3CEB5h2Knz8zKLBqeisDHiF6rkuXDnqe5MTjTsKq
         cKcbdySnjcA8qlK9Hh6ca+LNA8FuzEx8MFUYYoCWapcbhwJdwX4Zx4vUvPWzviQEekGR
         1PtA==
X-Gm-Message-State: AOAM5326w9p+Pky8fWY/QqVTO+3YIZQOAE5ht86bOcI3slRzy68Hf8Nv
        cyGg8FEmmZJ5SZy82Y8MObU=
X-Google-Smtp-Source: ABdhPJwLT310i1EOhU9mMvrSU72+CwwgtalLzi4aKetYwy7iEKvuNXFly3Ym6+Z8d/Dj2w7ongIBNA==
X-Received: by 2002:a65:5a8e:: with SMTP id c14mr1311106pgt.241.1637011304718;
        Mon, 15 Nov 2021 13:21:44 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id i185sm16088670pfg.80.2021.11.15.13.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:21:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Nov 2021 11:21:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] cgroup: pretty format /proc/cgroups
Message-ID: <YZLPZwo7IkgctGwD@slm.duckdns.org>
References: <20211115011253.20778-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115011253.20778-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 15, 2021 at 01:12:53AM +0000, Wei Yang wrote:
> Current /proc/cgroups looks like this:
> 
>  subsys_name    hierarchy       num_cgroups     enabled
> cpuset  3       1       1
> cpu     2       1       1
> cpuacct 2       1       1
> memory  4       71      1
> freezer 5       1       1
> 
> Let's align the title and value. After this patch, it looks like this.
> 
>  subsys_name    hierarchy       num_cgroups     enabled
>       cpuset            5                 1           1
>          cpu            3                 1           1
>      cpuacct            3                 1           1
>       memory            2                71           1
>      freezer            4                 1           1
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

So, I know it's silly but the file is dumb \t formatted (ie. single \t
between fields) and am slightly worried that changing the format might break
some dumb userspace tooling. Given that the information isn't really needed
for cgroup2 anyway, it prolly is better to leave it as-is, I think.

Thanks.

-- 
tejun

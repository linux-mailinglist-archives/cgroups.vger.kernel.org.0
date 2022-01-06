Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8037C486BAB
	for <lists+cgroups@lfdr.de>; Thu,  6 Jan 2022 22:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbiAFVKh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jan 2022 16:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbiAFVKg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jan 2022 16:10:36 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AB8C061245;
        Thu,  6 Jan 2022 13:10:36 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q14so3362565plx.4;
        Thu, 06 Jan 2022 13:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MJG9lGZ6QLSV3BSYotGztqDw0fy0Zwnl6zTi3BAaNIs=;
        b=B1XPEpvAtkf3Q1a5/T7kG5xY8AU6SOVPZ1+GtVa82Sbi26LKm4UyCC7TliLFocG7cW
         huTZjXszQXSttUSSFiURgxdLRC6X7MW0YdVervf5CdOz0Q1iq7SpLuKXF0Q2PMKPPgzg
         NledNo2s88DkvZf76UPIJ4VwgTBDpkJp9Z5vbXeRKJqgQaJPZb9K1cpOIZwYyATsmBC9
         jJKa1nWLk1o24FDfnMjSux2DUWnVQynLrsbNyAH0Skb6sSOspjtXRRiE8DzA6c0uZr5S
         jqvlNpzMg9FyJrRqlN0ieSn14DWPER0NZKovM99TQzxnzGCEWIRENTbNbro3f2qXlveX
         t7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MJG9lGZ6QLSV3BSYotGztqDw0fy0Zwnl6zTi3BAaNIs=;
        b=UuN+JETLwvpLC2mYwujGB+w4LE94sNPrizS3Nc9ae/N2hhrOgTjuVhH9tWsuxlrqBx
         IJOYbE4XKeGvkH1PQ7XjmAa2ecvO6HfdW3ecvIoJXukhs1+JzQQG/83X2459tSrOOfTy
         mLqu4TkfzpW1QWe1mF9/DM/xL+UfGhLSdrg1OynRAqeqUtBMLXEpTdz8/DMY0SVyjs5G
         Y9glvU1qWb3NqZtRpeq6CWPoNdJpg9DRBJlFEE+OIkgX0sC5UCZOcgVxfv72wLM4J91d
         IdHzwnqUG6JgYaC1kFAdN7i8wk54JXkM9pvpUIe+RZpCtgfBxOgnTK8qJ1d+GI0Pc1QJ
         9vBQ==
X-Gm-Message-State: AOAM531AJo2eshgmX57EXG80hwE9L/2ESYPi0YWZG8VEWc5sGUKno9Gh
        +MeGHxyBOZVCicVwMYIZpn/yOokk/AW4rw==
X-Google-Smtp-Source: ABdhPJwioexe+oZfUL4Cmjysw3LKkZzIipK86Q8a80piE+NgY9kNq63ShAJHnvDJ+Eg8xewjlryLww==
X-Received: by 2002:a17:902:6ac1:b0:149:7087:7b8a with SMTP id i1-20020a1709026ac100b0014970877b8amr53932997plt.174.1641503435494;
        Thu, 06 Jan 2022 13:10:35 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id s12sm3662385pfg.148.2022.01.06.13.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:10:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 6 Jan 2022 11:10:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: rstat: explicitly put loop variant in while
Message-ID: <YddayTDXQd21lxvt@slm.duckdns.org>
References: <20211225000932.7253-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211225000932.7253-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 25, 2021 at 12:09:31AM +0000, Wei Yang wrote:
> Instead of do while unconditionally, let's put the loop variant in
> while.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Applied to cgorup/for-5.17.

Thanks.

-- 
tejun

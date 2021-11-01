Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3687441ECB
	for <lists+cgroups@lfdr.de>; Mon,  1 Nov 2021 17:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhKAQvC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Nov 2021 12:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhKAQvB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Nov 2021 12:51:01 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD6DC061714;
        Mon,  1 Nov 2021 09:48:28 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id o14so3481048pfu.10;
        Mon, 01 Nov 2021 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GAN7ragUqS7RMyIM/xoW1/S5P0b0rrl0CPmGeTnWNKg=;
        b=dBaz1vcEakAvLA+FtkUZ3pk4iNqiTCPVjL0p0ykkOk2pQ5Ty6DlmoIn6QArcNogoCg
         wTOD38PSesJAYljs/IvVMdBV51rdupL3RmFqbR/CMUOTu0kfCl9fN+GOAIlRqo+NwO1S
         zuQ878JLLuo9/BhRdq1zRgAjfELemeraLEUYY8pjEwcsSuj3zRvgzpSkT4LGE/Qa1Gjg
         +j2vpD6q4olXtmIoAcEKcRpi6eXDPZd1GRlv2IhTdVKcqP6spRZitb5qHc5Wt6UALv7N
         BgG46iX6l4TokTG0+H5XdQAxV1nKduBlDyTgqFwMX34Uhh1Xpgf/A14LI46A2rev+Trl
         hg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GAN7ragUqS7RMyIM/xoW1/S5P0b0rrl0CPmGeTnWNKg=;
        b=mGIaIzTZnILvWXDxpmw5jueVRome+WJrfRTT8d6P6CMvkW5Q+3mBZvCil3YbVaUQ4i
         uTnjTpaQs2d/nSYp3XMS9n19qH/k9LLUwa5BGLARaf8xlKVO8KFL73z9WISByFzUQdsD
         w/IGNEPaP5HgTheWOfdHSqjyBXgEpcZ323m6dVGWLYTEB1bgD1cpj6EA28eKKqJrNoRv
         Gyhwdx7SrSNyfkqelGiAmmfmBHLwiHzzUgtuzEw9Bo1MuA8qzd9Fp9koyUTq0Gy1ipKx
         +MnR4GIH0jIXjvc6k9lV0wHt6Q1wkjion46kmE+0oQlXbKFwAHDb0Flgz6LnAE9fuz5E
         vX2Q==
X-Gm-Message-State: AOAM53162bc2X2M+qVFF34vGs8prrvyp/0vXy6rbTAbnaS29UWsmcHQr
        m5uAQvZKCHjH9f9YwRLToF0cWt8zN6nmrQ==
X-Google-Smtp-Source: ABdhPJwumvgknTi9GjUqeom2CbF4Ugxsk2Yd2KU86zDRMdwkXT7g5+WGQcdtf+KqrJl0N0d2gHaYFg==
X-Received: by 2002:a63:2acb:: with SMTP id q194mr22706251pgq.384.1635785307631;
        Mon, 01 Nov 2021 09:48:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id md6sm29479pjb.22.2021.11.01.09.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:48:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 1 Nov 2021 06:48:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Boris Burkov <boris@bur.io>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup: Fix rootcg cpu.stat guest double counting
Message-ID: <YYAaWaYzyqloDRQY@slm.duckdns.org>
References: <20211028221528.2174284-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028221528.2174284-1-schatzberg.dan@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 28, 2021 at 03:15:27PM -0700, Dan Schatzberg wrote:
> In account_guest_time in kernel/sched/cputime.c guest time is
> attributed to both CPUTIME_NICE and CPUTIME_USER in addition to
> CPUTIME_GUEST_NICE and CPUTIME_GUEST respectively. Therefore, adding
> both to calculate usage results in double counting any guest time at
> the rootcg.
> 
> Fixes: 936f2a70f207 ("cgroup: add cpu.stat file to root cgroup")
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

Applying to cgroup/for-5.16.

Thanks.

-- 
tejun

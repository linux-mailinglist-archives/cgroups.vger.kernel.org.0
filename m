Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2721148EE5B
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 17:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbiANQjE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 11:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbiANQjE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 11:39:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BB3C061574;
        Fri, 14 Jan 2022 08:39:03 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso22517698pjo.5;
        Fri, 14 Jan 2022 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NvcSGZuMTabYgJIG/cRBMSHew1xOo2ElUfSvmL5LgS8=;
        b=WsfCzOserdaGV51/he50lnmACdXPaqlTCzdAc2zdb7pDME3Hdx2NJVcU6EOfuiKqQi
         2CKsqhifWXdwK5rHD+KfbZSHk2xX50BHOypk3cFHHU4FnbejzphJMphG/U1vSHpy61gS
         lQkpnFt9eGDXTLVQYjCqjRy8DraYdFw1W89Vl9qAMwOS+LGlU+w/9FK6W/a8TvnVFLNx
         elMeTeOd+D1rPdlNStBUrY8u3zsYstlhlaKCxDcT84cO1QN1damwktikxOfn4GM5fprz
         akMSllwzds7V1d+bjeOF6Jsc7rU1AOOwDFDv7ALoV01vgAJPKkE3NnVFq9TnOE22otWm
         HU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NvcSGZuMTabYgJIG/cRBMSHew1xOo2ElUfSvmL5LgS8=;
        b=1+CB+BuDz01gatNRVe/aJw7RuXqerpdMKDlfcSEdkmi8KOkYY4izjuddkEZFTm/ty6
         JtCVBwHg2wzkbq+meDG2msPIqVLgAWI12GUQJ3iX9utGcSxcETTPLxJCdsIwGRZH5KKy
         mb+uATTM/G3OACeNu/Z6qsghTOrJsPcwPkg96bH1xJDc5YhsBbbaMoP8yO7/0eJN+tkI
         YHzI0j0DZT2MmW6klYJn5vWkUV0dP0VADE1p+OHf6zH9CPJJukhSwWlASc4cUh3lPs05
         NIPfMilgETp2+ML/ZhswjQYdPigX17yNRpbl/N/Jx59FM7Onqlyv5BqN8ryZrzT3DiJR
         h5jg==
X-Gm-Message-State: AOAM531AqNKrlehhPWOXQLcNAMpl08bHpumjhrsmkFBD67o61KG4VDus
        iwfLdLlxt3lWIPc+ylJ6gyeatx40fbm+Qg==
X-Google-Smtp-Source: ABdhPJzvY4rvs41TdBK0I/E1+5T2bioDwHf7uk58OwcFUnX9Kb2pRgIlD5r+6vD1oklkPbUgK7Sylg==
X-Received: by 2002:a17:902:904b:b0:143:73ff:eb7d with SMTP id w11-20020a170902904b00b0014373ffeb7dmr10524138plz.85.1642178343336;
        Fri, 14 Jan 2022 08:39:03 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id m10sm5192453pgu.70.2022.01.14.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 08:39:02 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 14 Jan 2022 06:39:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     cruzzhao <cruzzhao@linux.alibaba.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, joshdon@google.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] sched/core: Force idle accounting per cgroup
Message-ID: <YeGnJe+JXlUlPvrH@slm.duckdns.org>
References: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1641894961-9241-4-git-send-email-CruzZhao@linux.alibaba.com>
 <Yd89Lv3VuaaFVm4h@slm.duckdns.org>
 <1cca28c3-c84d-415e-9b33-6687e4ff2cbb@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cca28c3-c84d-415e-9b33-6687e4ff2cbb@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 14, 2022 at 07:13:12PM +0800, cruzzhao wrote:
> Thanks for suggestions, I'll try to do this using rstat. BTW, is it ok
> to integrate it with cgroup_base_stat?

Yeah, I don't see a problem at least from cgroup / rstat POV.

Thanks.

-- 
tejun

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B306215B2DB
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2020 22:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgBLVg0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Feb 2020 16:36:26 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42369 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLVgZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Feb 2020 16:36:25 -0500
Received: by mail-qt1-f196.google.com with SMTP id r5so2794008qtt.9;
        Wed, 12 Feb 2020 13:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iBeSTprJEgkhPZLCbVo2vH4gD47fVWZXk0D/63E7q/E=;
        b=u2vGyuPYOVf8Rmx/bD+nZrJPyKgzpcQAucV+E89I+0VbBjaC7JDsg0R4oL58eiXRBR
         5NFyvjgdJp2dQzi72IL804HQKAbZY2dthM9WC+S8A70Re9ACGey4VMBJdtdOLZLFUma2
         EHTF+mgfQBIBphP0j9VAHOXSIpM8g6mtelcIVcE5ysde1cdsZ9vn7L1QBhaWSTAUB3UM
         5WD48B7NO6e/gZ00uVbN97wTwk1BzLNutcmJ41frW4YrMMFr1h8ZRIffu1BrPIF1BZSM
         sM7jpW836/Ff8sufIQfRsa9fH1sgH3jX2PXLUZJc4Xl2CnPCL+VELD0vNx3yHzyRQBtv
         y3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iBeSTprJEgkhPZLCbVo2vH4gD47fVWZXk0D/63E7q/E=;
        b=F8HseHIcytCAKLhPS2NES2t8UW5+1wTsB1oyhrhLkFtnlBmxfUhIhWOW2Rcifuxq3R
         vMPqzKjsSCrNBJwGI6GPn12bNdb1vJkbwpOU5V27AiNhBj1/iVtQ+XIXyKkOkFy55q96
         6e2qWBvZf3moln6QheqnoEyPNDiSzcQM2JKAHtvAZ6njziBh4t8q866VJm/cEoncb+GQ
         iuWU40F8ybNeBJCZEQdyMFD/zUHfWyyqkzaQjy3Rrec2Ty61ndJA+LHKGjPQluz3Gza/
         7BnQku6eI+db5nnewwLGGB0OCzcu3roaJO209QeBEP4Q3kehO6LhrHppvuzAi6a9OUL+
         1/sg==
X-Gm-Message-State: APjAAAXQ/TkzuC8AfM/4+yS28JUvrdj1Qtp7wZ+WFwkf3YmvWKdA5bSr
        RYdMC8awVb1rvUQqQdNG/M5NZQ2BWZk=
X-Google-Smtp-Source: APXvYqzodA0qG8UxndOqY4Z1I/K+EhgpqDqoAniaUWCZTFZowWYGO3/UrC+gYBomkZtVR/zixMosVQ==
X-Received: by 2002:ac8:65d4:: with SMTP id t20mr21522456qto.6.1581543384701;
        Wed, 12 Feb 2020 13:36:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id z21sm81006qka.122.2020.02.12.13.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:36:24 -0800 (PST)
Date:   Wed, 12 Feb 2020 16:36:23 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Prateek Sood <prsood@codeaurora.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: Make cpuset hotplug synchronous
Message-ID: <20200212213623.GF80993@mtj.thefacebook.com>
References: <1579878449-10164-1-git-send-email-prsood@codeaurora.org>
 <ee889f30-cb81-e0a8-6068-715ca3399fdd@codeaurora.org>
 <20200212211832.GC80993@mtj.thefacebook.com>
 <20200212213248.GE14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212213248.GE14897@hirez.programming.kicks-ass.net>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey, Peter.

On Wed, Feb 12, 2020 at 10:32:48PM +0100, Peter Zijlstra wrote:
> I think I have a similar patch in one of the many in-progress series I
> keep around; IIRC it is the one where I add per-cpu support to
> SCHED_DEADLINE. The hotplug accounting becomes easier if we do this.
> 
> Sadly this series is fairly low on the todo list atm though :/ I have no
> problems keeping it around until such a time though.

I see. I don't have anything against the change except that there
doesn't seem to be a good reason right now. If it's something which
can be useful for planned changes, might as well apply it and let it
cook upstream. Will apply to for-5.7.

Thanks.

-- 
tejun

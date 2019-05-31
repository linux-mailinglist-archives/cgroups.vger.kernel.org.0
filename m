Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0651331553
	for <lists+cgroups@lfdr.de>; Fri, 31 May 2019 21:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfEaT1n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 May 2019 15:27:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46868 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfEaT1n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 May 2019 15:27:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so6749006pfm.13
        for <cgroups@vger.kernel.org>; Fri, 31 May 2019 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3oPC7MpGNkmIv4lC37rTS0RoLjGGQjB5vfa5jgin/Xo=;
        b=SbI05ChMOHpTulNwmjhSR5ZbY9idO2IxEcT87P8CRpkS49RpLitZ6wSoqJeEdL1yVK
         cww6Si5nneZ2edimkGsX9/iIsmxdqDJDY5OVjkYb730pjSBbLnqr5fWiePVGdfkZ6x8p
         K2nnnRVs/YngzaK04SXScheJ4pWXrpnvyJLow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3oPC7MpGNkmIv4lC37rTS0RoLjGGQjB5vfa5jgin/Xo=;
        b=FuRpzokvkfPvsPIld4XVzRD9199T79g3dzAxOqUqZVfOk2GWeMgF2P+GgUujd3zpdp
         iecN6PXW/DGnjGh+Mfoqm9GipQlQrslCy3dywLQqO54EIrYTuUmD70Adzlf4wgc3S+gp
         PZhw2peYxM4UBwGFeW7r7W75baIXcduHMjIBz9CYG3Wcth3rS0GWbhzlA47zMnHEiRqA
         +DoCUxcqVmRfEo8uiPQD8uTObkCc3IzHyfk0t1+fcblVQKCpyUPCjIlqvUvaLWDfi4uJ
         L30DVHdmDEkuV2W1HVYHT1mCqJupAMvqO+FWJ42POjTjpxWEK1rTm5dxs+2uqk81XESc
         zaaw==
X-Gm-Message-State: APjAAAXTdVX5XsPWGKtmB+ddDeRkFCbBdtLBAaBt8j+eZwslmpwcQAVE
        NgRhNq3FiiPXC9FxS4eS3Qhz4yppcgBQtw==
X-Google-Smtp-Source: APXvYqx8hFRJFZmWhsZTcS5jPsQcgCdx6RY9Azo2rv/4QAY3o3jE3z984dUqq8bjDr4wU09ByZJlcQ==
X-Received: by 2002:a62:1885:: with SMTP id 127mr12522926pfy.48.1559330862439;
        Fri, 31 May 2019 12:27:42 -0700 (PDT)
Received: from localhost ([2620:10d:c090:200::3:3d82])
        by smtp.gmail.com with ESMTPSA id f2sm5497516pgs.83.2019.05.31.12.27.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 12:27:41 -0700 (PDT)
Date:   Fri, 31 May 2019 12:27:40 -0700
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH REBASED] mm, memcg: Make scan aggression always exclude
 protection
Message-ID: <20190531192740.GA286159@chrisdown.name>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
 <20190530061221.GA6703@dhcp22.suse.cz>
 <20190530064453.GA110128@chrisdown.name>
 <20190530065111.GC6703@dhcp22.suse.cz>
 <20190530205210.GA165912@chrisdown.name>
 <20190531062854.GG6896@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190531062854.GG6896@dhcp22.suse.cz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko writes:
>On Thu 30-05-19 13:52:10, Chris Down wrote:
>> Michal Hocko writes:
>> > On Wed 29-05-19 23:44:53, Chris Down wrote:
>> > > Michal Hocko writes:
>> > > > Maybe I am missing something so correct me if I am wrong but the new
>> > > > calculation actually means that we always allow to scan even min
>> > > > protected memcgs right?
>> > >
>> > > We check if the memcg is min protected as a precondition for coming into
>> > > this function at all, so this generally isn't possible. See the
>> > > mem_cgroup_protected MEMCG_PROT_MIN check in shrink_node.
>> >
>> > OK, that is the part I was missing, I got confused by checking the min
>> > limit as well here. Thanks for the clarification. A comment would be
>> > handy or do we really need to consider min at all?
>>
>> You mean as part of the reclaim pressure calculation? Yeah, we still need
>> it, because we might only set memory.min, but not set memory.low.
>
>But then the memcg will get excluded as well right?

I'm not sure what you mean, could you clarify? :-)

The only thing we use memory.min for in this patch is potentially as the 
protection size, which we then use to determine reclaim pressure. We don't use 
this information if the cgroup is below memory.min, because you'll never come 
in here. This is for if you *do* have memory.min or memory.low set and you are 
*exceeding* it (or we are in low reclaim), in which case we want it (or 
memory.low if higher) considered as the protection size.

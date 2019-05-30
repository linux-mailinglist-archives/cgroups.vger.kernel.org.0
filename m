Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64EFE30391
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 22:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfE3UwO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 May 2019 16:52:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41741 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3UwO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 May 2019 16:52:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so4705070pfq.8
        for <cgroups@vger.kernel.org>; Thu, 30 May 2019 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6xW2J8Id+5nx2KJz7k0sgVn959SqhmXLM/78ZxNyQrM=;
        b=P7oOZgl3CtO57JCewH/kKTPTub5g44+HbkPoxMUgXSg+G+mYhHLm56nrj0Ca0w4uXe
         1y5o+9cwnqcke09kZKrZ07g+cQivOFM52Jn56eiI9G38mT2W5A58AY/pnXbpMkHnaf6b
         YmGt4GV5AsM5rEH9QzxxTZrA7C0HqUi7G0YlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6xW2J8Id+5nx2KJz7k0sgVn959SqhmXLM/78ZxNyQrM=;
        b=h4W/+o0eAod0hwW+VkCs/k6ZWsfsXf5Ioa16YyImrYSDbsApUFyLdBSdHTnF8BATgj
         22zn6anf7gNSYKhNNF8lszGFLs54R6JSgbvcGVBflWIMdS7cS1IF1Ywg8fvR37nN4L0/
         Eb3x+80sM/+U6asd2cN+i3H/G1+qq7UJjOQ+fcTLDoDjY2y+aY+xI//awSKVN4VsiY4w
         Va77TcukzXxBIy2UDMy9kj/5/sKIimze6r2/93Jj7+xrjUFlc1VbilsG6Bp47UFTF/ih
         +5McLsF4iCZKeuLitzLXMJtrPolucpXN9kPGjNFlkMUEjm5Hyr0tvqraF+0Wqh4S+Crz
         gxXw==
X-Gm-Message-State: APjAAAUaaLzArdTOg+xISq7mvUnQRIpTvhFs07azqD/XFcJs1FwyZxJ9
        ZG+cCYnqgCQvKHWcqqa8tGo4kg==
X-Google-Smtp-Source: APXvYqw2Vrsl6MhrLN4N404XzV0x9D1AP5nF4XCE2sc5cXxgq1gpcLjWmpcQqB50nghux+A2TsCiFA==
X-Received: by 2002:a63:4006:: with SMTP id n6mr5564930pga.424.1559249533347;
        Thu, 30 May 2019 13:52:13 -0700 (PDT)
Received: from localhost ([2620:10d:c090:200::ca0f])
        by smtp.gmail.com with ESMTPSA id b3sm4127765pfr.146.2019.05.30.13.52.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 13:52:12 -0700 (PDT)
Date:   Thu, 30 May 2019 13:52:10 -0700
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH REBASED] mm, memcg: Make scan aggression always exclude
 protection
Message-ID: <20190530205210.GA165912@chrisdown.name>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
 <20190530061221.GA6703@dhcp22.suse.cz>
 <20190530064453.GA110128@chrisdown.name>
 <20190530065111.GC6703@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190530065111.GC6703@dhcp22.suse.cz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko writes:
>On Wed 29-05-19 23:44:53, Chris Down wrote:
>> Michal Hocko writes:
>> > Maybe I am missing something so correct me if I am wrong but the new
>> > calculation actually means that we always allow to scan even min
>> > protected memcgs right?
>>
>> We check if the memcg is min protected as a precondition for coming into
>> this function at all, so this generally isn't possible. See the
>> mem_cgroup_protected MEMCG_PROT_MIN check in shrink_node.
>
>OK, that is the part I was missing, I got confused by checking the min
>limit as well here. Thanks for the clarification. A comment would be
>handy or do we really need to consider min at all?

You mean as part of the reclaim pressure calculation? Yeah, we still need it, 
because we might only set memory.min, but not set memory.low.

>> (Of course, it's possible we race with going within protection thresholds
>> again, but this patch doesn't make that any better or worse than the
>> previous situation.)
>
>Yeah.
>
>With the above clarified. The code the resulting code is much easier to
>follow and the overal logic makes sense to me.
>
>Acked-by: Michal Hocko <mhocko@suse.com>

Thanks for your thorough review! :-)

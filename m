Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1721DCCC6
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgEUMYq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 08:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgEUMYp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 08:24:45 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCC1C061A0F
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 05:24:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id yc10so8506782ejb.12
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i8JutcblGoAISDN3hurAlHLL13/lujc4PGXCcoNOdiE=;
        b=ZskJd2rQupY8tV+of+gT2pNGrghG1kvcp0tUt8lYVHWX2N2357xtDLydnxma2icUrj
         b0RUe9qLlaHWLEn5ePS8DecHifXObN+IFUNHUwWuvKcDjwbkP7AMXFLIg+NakaL4dG4H
         XE7j3wic9ZZzBWOrSIpnnr08PFqEOA4rd/aeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i8JutcblGoAISDN3hurAlHLL13/lujc4PGXCcoNOdiE=;
        b=B2HgaVYAJ73Kb08pj4I3dDzBe8IbcTG3QQ2uUm+UOp3hfxbZBq5GUNH9gHl2ihblwp
         XnidgkrvzSzGMzQPy34HM6kWdSzeYmJiq2ss4Wtt7MRudPPRkYph25/bZ/6V0gEnRfE3
         Oz3EJVv2wqrGWzaOm2Min8IbevnyZ7IVsQrWPrlxge821QoI9+e9rbOVPTvegF/yVlMl
         vqplM5flaOOLDly32d3bNLPXCX3XfI+wBpr36uYpAt41il4JEXgok1Sr7V+5rD78dQl/
         SYumPIKVd7DsmaQBdBJA/FKGh1EOk/pv5jMMon76JCBISxI20/gghwHT6FvbxeGZamNI
         VMTw==
X-Gm-Message-State: AOAM531iPA4MwZ8vpzLnpUqil16zlB86uPyYByEVsn6EwjWPbCIHBARf
        3HKgI3bIKCkquX0n62LDfZaGUQ==
X-Google-Smtp-Source: ABdhPJz9jOOFoXAERCPYL+3i/XvpdtIhar1Xat8M0XTI6E609A9G6xutGG1kGY9fXEK4RxSZ9o8ukg==
X-Received: by 2002:a17:906:3b8d:: with SMTP id u13mr3240093ejf.256.1590063884112;
        Thu, 21 May 2020 05:24:44 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4262])
        by smtp.gmail.com with ESMTPSA id qn17sm4672101ejb.125.2020.05.21.05.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 05:24:43 -0700 (PDT)
Date:   Thu, 21 May 2020 13:24:38 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521122438.GC990580@chrisdown.name>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
 <20200521120455.GM6462@dhcp22.suse.cz>
 <20200521122327.GB990580@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200521122327.GB990580@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Chris Down writes:
>A cgroup is a unit and breaking it down into "reclaim fairness" for 
>individual tasks like this seems suspect to me. For example, if one 
>task in a cgroup is leaking unreclaimable memory like crazy, everyone 
>in that cgroup is going to be penalised by allocator throttling as a 
>result, even if they aren't "responsible" for that reclaim.

s/for that reclaim/for that overage/

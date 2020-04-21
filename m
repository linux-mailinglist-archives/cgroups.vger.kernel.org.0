Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A411B2B0B
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgDUPUv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 11:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgDUPUv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 11:20:51 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E9DC061A10
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 08:20:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id l60so11825078qtd.8
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jwGeQzDdrOzdJlAD0ghWVZoxVjm5XtEA2WK3XkkvxyQ=;
        b=FXrADtfByQlNUBEu1vViyehbFKOhBU4dp73jUXSMQGEAoigcpdrozcO5N83yOhXOq7
         +ukk+fWtA9qV3xkAfsTaSRJ9oHuy247FfqCAQoc9ctvnDd5qagUr9M9GMJRKjbEypcuE
         y7tMsSMoVKMH0y8GXyRFyqKVVXLlvT5p+2bN225RNns1qJ4BaWr90ubNBeg0E8aZa1cP
         vdmlxNuhT6GxrpDAx8ygVkMC6JUmhFQjeD0e6jYj7GGdQZEIQFikaRxvASiVC9jWHSst
         KWoB96kLu/3CiDEYFNffV1ofM8GWKhn4Z7D8wyf0iLMsCXR5Np1H2q+J9zCgeSt2ZI82
         H3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jwGeQzDdrOzdJlAD0ghWVZoxVjm5XtEA2WK3XkkvxyQ=;
        b=uk/XOqzW5lhYzjA93bc1KmH63fN7ZYqe7TbbaArCNOwNw2jwaFbf7/N+BY48vsPYUf
         iEA9i8qbX8fqlJhXDiQjhwCwDsn+boG7IpAhz3s0hBHtxBw7h1NhFoU7YfBIsqqX19uS
         ElMfxMt2Cg4Buq/haqFHQFYXxi7OYn7avk7aSP3/C7RfmJKUA733lB8Kr0y7m1DlE6s0
         vBiubRxmTUXNrzwv24rimIpCHSsgtE4RfbLbFVQq5sT1hLwcp8t+0UmN2L0C2OWSCB2k
         5T67pYN3//xsV1vrHjOHhwzHEMJKmm5rIUzVclRNlvpcAo4Ccn4j/YIg8lTkHQ/jH63P
         m4SQ==
X-Gm-Message-State: AGi0PuZXPLD4nf+2da6h3Ayl4fbGFPHA5TtMOVHfVc7TLaa1Ozee/IGc
        OCHTIuHr0Cit2AHjd0fvJBM=
X-Google-Smtp-Source: APiQypKA30+eSP0g8fNHbH1LI6/q74o+Jz6pppFA2VazsE3KBb6jIhN1/k/smTSq+IrQK+28Z0LPyA==
X-Received: by 2002:ac8:38eb:: with SMTP id g40mr21980140qtc.386.1587482449928;
        Tue, 21 Apr 2020 08:20:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6b75])
        by smtp.gmail.com with ESMTPSA id p2sm1941810qkm.65.2020.04.21.08.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 08:20:49 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:20:47 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
Message-ID: <20200421152047.GA5462@mtj.thefacebook.com>
References: <20200417173615.GB43469@mtj.thefacebook.com>
 <CALvZod7-r0OrJ+-_uCy_p3BU3348ve2+YatiSdLvFaVqcqCs=w@mail.gmail.com>
 <20200417193539.GC43469@mtj.thefacebook.com>
 <CALvZod6LT25t9aAA1KHmf1U4-L8zSjUXQ4VQvX4cMT1A+R_g+w@mail.gmail.com>
 <20200417225941.GE43469@mtj.thefacebook.com>
 <CALvZod6M4OsM-t8m_KX9wCkEutdwUMgbP9682eHGQor9JvO_BQ@mail.gmail.com>
 <20200420164740.GF43469@mtj.thefacebook.com>
 <20200420170318.GV27314@dhcp22.suse.cz>
 <20200420170650.GA169746@mtj.thefacebook.com>
 <20200421110612.GD27314@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421110612.GD27314@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Apr 21, 2020 at 01:06:12PM +0200, Michal Hocko wrote:
> I suspect that the problem is more related to the swap being handled as
> a separate resource. And it is still not clear to me why it is easier
> for you to tune swap.high than memory.high. You have said that you do
> not want to set up memory.high because it is harder to tune but I do
> not see why swap is easier in this regards. Maybe it is just that the
> swap is almost never used so a bad estimate is much easier to tolerate
> and you really do care about runaways?

Johannes responded a lot better. I'm just gonna add a bit here.

Swap is intertwined with memory but is a very different resource from
memory. You can't seriously equate primary and secondary storages. We never
want to underutilize memory but we never want to completely fill up
secondary storage. They're exactly the opposite in that sense. It's not that
protection schemes can't apply to swap but that such level of dynamic
control isn't required because simple upper limit is useful and easy enough.

Another backing point I want to raise is that the abrupt transition which
happens on swap depletion is a real problem that userspace has been trying
to work around. memory.low based protection and oomd is an obvious example
but not the only one. earlyoom[1] is an independent project which predates
all these things and kills when swap runs low to protect the system from
going down the gutter.

In this respect, both oomd and earlyoom basically do the same thing but
they're racing against the kernel filling up the space. Once the swap space
is gone, the programs themselves might not be able to make reasonable
forward progress. The only measure they can currently employ is polling more
frequently and killing ealier so that swap space never actually runs out,
but it's a silly and losing game as the underyling device gets faster and
faster.

Note that at least fedora is considering including either earlyoom or oomd
by default. The problem addressed by swap.high is real and immediate.

Thanks.

-- 
tejun

[1] https://github.com/rfjakob/earlyoom

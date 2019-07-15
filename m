Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6287B69F42
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2019 00:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfGOW5e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Jul 2019 18:57:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34980 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730954AbfGOW5d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Jul 2019 18:57:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so16743573wmg.0
        for <cgroups@vger.kernel.org>; Mon, 15 Jul 2019 15:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7VSl4WMlmc5jmN5dNuL2dV5fcPROFvmtmokhA+NF36I=;
        b=FupgII/o9bbimWyh0bR/UkrMCpIcBrEpJ9ja2EO6K5VA/hOxrdLwUrKeytS0QyP0Y0
         OhXsBBkmUiEHwe9vHBVKjTY1KbQ8/G/lcXfmnhG5kapCPmdHusIlp+cwSXAld52Wnqa/
         nRh649s69N06QxHZL6McwutEtJnh9SDnxj+SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7VSl4WMlmc5jmN5dNuL2dV5fcPROFvmtmokhA+NF36I=;
        b=Cw6vVQWyq3mUZwJbekqyMzesT0Rl+EhmGLjSnS9/zrKLNjDx0rhqUAGAD9OmWEYuXj
         pQErLEBYoKxT3ccXsVKqwqJxcj5h1vzZr0LJd9/mBmTycHzxgT9zUOWxBMiAP5JjhWYj
         JpYamO6+n5V/DrRdDoM8Kn02Wwf+u3qpLh0Tj2pRUKGSmL830S6l3RWKSgmK6L5IATKG
         5grARr/cHmGIg7ZPmZvIv9wlUPJxmEElriVb4KSRiFqROiT+0kttMPNoDymrxCf4XcLp
         uKbdQI6BRsdoJmciT2k+l8Jiw/uCGx3O0IqjUkjOuKNmbnfTyw3K3QvZnreM2J3e4yWp
         TsCQ==
X-Gm-Message-State: APjAAAXZZwyrQ8UGU/GxDao9ZaMaPLK11gobuYvMwnp6mmARCstEpeWE
        CNSwijKZ82Wa5x3Klr/d8NhmKQ==
X-Google-Smtp-Source: APXvYqy3qZPv7NxVmAgsG8P+5YpErVdVg3oEYNfChcxlHtHFxfOQT0uIAVxdzoD2pqCzf24bVM8CQw==
X-Received: by 2002:a7b:c766:: with SMTP id x6mr27363436wmk.40.1563231451449;
        Mon, 15 Jul 2019 15:57:31 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:d8da])
        by smtp.gmail.com with ESMTPSA id h8sm17918169wmf.12.2019.07.15.15.57.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 15:57:30 -0700 (PDT)
Date:   Mon, 15 Jul 2019 23:57:29 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: Proportional memory.{low,min} reclaim
Message-ID: <20190715225729.GA19191@chrisdown.name>
References: <20190124014455.GA6396@chrisdown.name>
 <20190128210031.GA31446@castle.DHCP.thefacebook.com>
 <20190128214213.GB15349@chrisdown.name>
 <20190128215230.GA32069@castle.DHCP.thefacebook.com>
 <20190715153527.86a3f6e65ecf5d501252dbf1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190715153527.86a3f6e65ecf5d501252dbf1@linux-foundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey Andrew,

Andrew Morton writes:
>On Mon, 28 Jan 2019 21:52:40 +0000 Roman Gushchin <guro@fb.com> wrote:
>
>> > Hmm, this isn't really a common situation that I'd thought about, but it
>> > seems reasonable to make the boundaries when in low reclaim to be between
>> > min and low, rather than 0 and low. I'll add another patch with that. Thanks
>>
>> It's not a stopper, so I'm perfectly fine with a follow-up patch.
>
>Did this happen?

Yes, that's "mm, memcg: make memory.emin the baseline for utilisation 
determination" :-)

>I'm still trying to get this five month old patchset unstuck :(.

Thank you for your help. The patches are stable and proven to do what they're 
intended to do at scale (both shown by the test results, and production use 
inside FB at scale).

>I do have a note here that mhocko intended to take a closer look but I
>don't recall whether that happened.
>
>I could
>
>a) say what the hell and merge them or
>b) sit on them for another cycle or
>c) drop them and ask Chris for a resend so we can start again.

Is there any reason to resend? As far as I know these patches are good to go.  
I'm happy to rebase them, as long as it doesn't extend the time they're being 
sat on. I don't see anything changing before the next release, though, and I 
feel any reviews are clearly not coming at this series with any urgency.

Thanks for the poke on this, I appreciate it.

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B067B55E1
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 17:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbjJBOm4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbjJBOmz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 10:42:55 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEF691
        for <cgroups@vger.kernel.org>; Mon,  2 Oct 2023 07:42:52 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-774105e8c37so1105145285a.3
        for <cgroups@vger.kernel.org>; Mon, 02 Oct 2023 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696257772; x=1696862572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9gT0sJ6bxJ7LFGJ3qcn0lur/HHwUZlrfxhEFRGE3Lc=;
        b=c6OXd9YFBsot277vrDT83xXwBobB0wm3QiKoEK3jxGefiNII0hx0/53I6hHHWBXXVI
         PjFknMvxds4R53+FJpAlBJ054OExLeKNeXw7qmnc4NxhEvXGplheOaY1MxMALVEdpnEm
         W9xaYOEaB8aSe+ML2F/9TOrJtMvONMM7IqgjwKu4XXCQXF2/cTBOxwCBeOnLp3QkJYMR
         JT0J8y/YwBi84rPL28BZJBtN5ohIIA/Rz8NRLRykwAuige0IT+Hi03kYU4VokLkQ+4dT
         su6T6pt0wlQHfEpCPdEAQscQR4fNXz7ttI3OKWzyE9lr6OI8GD7BTbehBqmSuPE8mkIC
         kwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696257772; x=1696862572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9gT0sJ6bxJ7LFGJ3qcn0lur/HHwUZlrfxhEFRGE3Lc=;
        b=McooobVHvyL6/gzldsodMAbyyRf14Ke0o9NvaKb96Roab74O63E3wKsDpEGgNXTYHL
         i4I+h7l3Nz3JChQ3NtBnUymNznaC+Jrt2wVEUEGN67C5SYkvRE3c7g8TKKFvq+pi2dXX
         lN/8MN2/NPJj4zyCEzIkWUOluTknKlkMec6/WUHz/JyXivKuoM7gZrz8Tr58DxSRtN4E
         MtCKozb7m8xS1wBpGY840K32cpI1NCIo2ojh45OvwK/NojCG7SnNO1rILe7YzEbDhhv5
         DuzMpHFdIOQjHRePrRsQ9InuNUikab3jtsLdvH7qd88bO4/2V5gOEa1kmjkk6hY6Oq88
         rm5A==
X-Gm-Message-State: AOJu0Yxd4rV+uGHklXgrU0+CQdHtlqVbeFfxMJE99akDqrXnOUtG8nIj
        ZRWmaanE1zHEtuQwKnKxb9Mh2A==
X-Google-Smtp-Source: AGHT+IFa+AtbCwYbo1F1bL/0dGXEiEXwwHQPJD08WSpIXpwHS50M5VhohUTqeEfXszT9O2DE8i1vpg==
X-Received: by 2002:ac8:588a:0:b0:417:95e7:a2f7 with SMTP id t10-20020ac8588a000000b0041795e7a2f7mr12774184qta.19.1696257771693;
        Mon, 02 Oct 2023 07:42:51 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id h20-20020ac846d4000000b0041812600a47sm6261207qto.59.2023.10.02.07.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:42:51 -0700 (PDT)
Date:   Mon, 2 Oct 2023 10:42:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@suse.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, riel@surriel.com,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, yosryahmed@google.com, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
Message-ID: <20231002144250.GA4414@cmpxchg.org>
References: <20230926194949.2637078-1-nphamcs@gmail.com>
 <ZRQQMABiVIcXXcrg@dhcp22.suse.cz>
 <20230927184738.GC365513@cmpxchg.org>
 <20231001232730.GA11194@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001232730.GA11194@monkey>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Oct 01, 2023 at 04:27:30PM -0700, Mike Kravetz wrote:
> On 09/27/23 14:47, Johannes Weiner wrote:
> > On Wed, Sep 27, 2023 at 01:21:20PM +0200, Michal Hocko wrote:
> > > On Tue 26-09-23 12:49:47, Nhat Pham wrote:
> > 
> > So that if you use 80% hugetlb, the other memory is forced to stay in
> > the remaining 20%, or it OOMs; and that if you don't use hugetlb, the
> > group is still allowed to use the full 100% of its host memory
> > allowance, without requiring some outside agent continuously
> > monitoring and adjusting the container limits.
> 
> Jumping in late here as I was traveling last week.  In addition, I want
> to state my limited cgroup knowledge up front.
> 
> I was thinking of your scenario above a little differently.  Suppose a
> group is up and running at almost 100% memory usage.  However, the majority
> of that memory is reclaimable.  Now, someone wants to allocate a 2M hugetlb
> page.  There is not 2MB free, but we could easily reclaim 2MB to make room
> for the hugetlb page.  I may be missing something, but I do not see how that
> is going to happen.  It seems like we would really want that behavior.

But that is actually what it does, no?

alloc_hugetlb_folio
  mem_cgroup_hugetlb_charge_folio
    charge_memcg
      try_charge
        !page_counter_try_charge ?
          !try_to_free_mem_cgroup_pages ?
            mem_cgroup_oom

So it does reclaim when the hugetlb hits the cgroup limit. And if that
fails to make room, it OOMs the cgroup.

Or maybe I'm missing something?

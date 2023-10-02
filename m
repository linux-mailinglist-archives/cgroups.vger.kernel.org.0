Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9BF7B56AE
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 17:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbjJBP0C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 11:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbjJBP0B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 11:26:01 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A544B8
        for <cgroups@vger.kernel.org>; Mon,  2 Oct 2023 08:25:58 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77574dec71bso480073885a.2
        for <cgroups@vger.kernel.org>; Mon, 02 Oct 2023 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696260357; x=1696865157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z686kNiWukEPuUFPdj5Zpdh2jq/+sj08V/foqt23i+A=;
        b=y4Lpd+/4SIcTmMP+it4zIC2bLkghe/X8cNL2Hpr66K0KhC/8NgnTKxgtiai1lq8JlT
         yRnNDfTjrGENFRjPNJwZ/Kx3r336mjDgS9perjkesmiZjPMq8OAOTK+v7UqkfmFy1Miz
         xuaJ9LEqus9y77xTAskjdm6WHdQ7naVXSvjbTtFM6qBKKZLPMHy7UYld5kpc8FzQoXzT
         fLzLFh4+4tYI7x+GS6ekbW9zxITAeVUAgX+qnV8W98vnP0lFXh1Cc70eMEY13mYYhQM7
         9/c+pOfSkf2UZYRDZytYO8zC1lkjpmiYMmzj3ULBIHtyJi53pwUD4wbfHgnzGwGsSB2N
         b1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696260357; x=1696865157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z686kNiWukEPuUFPdj5Zpdh2jq/+sj08V/foqt23i+A=;
        b=d1vZbPsUXS6fMGwQsjTpe0PrNt1gLHneLb+ulTSjfQbqexj/TtR+Vsa+/UMr8ExyJM
         +ygcLihvuRCLf5d/osOXeJ6u/lkZCMTm4IbXAaQ2F7/wRVeRCcibguKWIkX0Shr1L8gO
         +EZat2mxJ0LXp430kaOqB4NAOb4qn6xCVSSFJ4VBkGuH64meA8cBFlRIpObDqnlo+atC
         rbgBKK1LDLyre39Gib3NRcRLMnigQx3uJAi8LKEH5pbtuFkYO0vJssjrywaF77tibiYW
         o8prfS+Gyh5sY7I1XI0SQ7/oPqbNfqSRzhKWUL2LbCwCb7vRdz73eIoQktnTLHDW5wMY
         Ozyw==
X-Gm-Message-State: AOJu0YwhNWRFBQwcYT+SVC8GGJxJivCg8Iz8IIPetNtqnI7ChrGLzEBZ
        OSBl38qFVdFmQrZmmkGveNWFtQ==
X-Google-Smtp-Source: AGHT+IGOzBNgnR/8kyNK9t/3Vfmd2zrtQURJkh2zz1eHoYnXPAUTPdrNqNl1BvQCUeX7rTJ8yRuL2w==
X-Received: by 2002:a05:620a:4891:b0:775:9766:cb69 with SMTP id ea17-20020a05620a489100b007759766cb69mr7612236qkb.75.1696260356936;
        Mon, 02 Oct 2023 08:25:56 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id b6-20020a05620a126600b007759e9b0eb8sm1707697qkl.99.2023.10.02.08.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:25:56 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:25:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
Message-ID: <20231002152555.GA5054@cmpxchg.org>
References: <20230928005723.1709119-1-nphamcs@gmail.com>
 <20230928005723.1709119-2-nphamcs@gmail.com>
 <ZRrI90KcRBwVZn/r@dhcp22.suse.cz>
 <20231002145026.GB4414@cmpxchg.org>
 <ZRrc8hv4t740MZar@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRrc8hv4t740MZar@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 02, 2023 at 05:08:34PM +0200, Michal Hocko wrote:
> On Mon 02-10-23 10:50:26, Johannes Weiner wrote:
> > On Mon, Oct 02, 2023 at 03:43:19PM +0200, Michal Hocko wrote:
> > > On Wed 27-09-23 17:57:22, Nhat Pham wrote:
> [...]
> > > - memcg limit reclaim doesn't assist hugetlb pages allocation when
> > >   hugetlb overcommit is configured (i.e. pages are not consumed from the
> > >   pool) which means that the page allocation might disrupt workloads
> > >   from other memcgs.
> > > - failure to charge a hugetlb page results in SIGBUS rather
> > >   than memcg oom killer. That could be the case even if the
> > >   hugetlb pool still has pages available and there is
> > >   reclaimable memory in the memcg.
> > 
> > Are these actually true? AFAICS, regardless of whether the page comes
> > from the pool or the buddy allocator, the memcg code will go through
> > the regular charge path, attempt reclaim, and OOM if that fails.
> 
> OK, I should have been more explicit. Let me expand. Charges are
> accounted only _after_ the actual allocation is done. So the actual
> allocation is not constrained by the memcg context. It might reclaim
> from the memcg at that time but the disruption could have already
> happened. Not really any different from regular memory allocation
> attempt but much more visible with GB pages and one could reasonably
> expect that memcg should stop such a GB allocation if the local reclaim
> would be hopeless to free up enough from its own consumption.
> 
> Makes more sense?

Yes, that makes sense.

This should be fairly easy to address by having hugetlb do the split
transaction that charge_memcg() does in one go, similar to what we do
for the hugetlb controller as well. IOW,

alloc_hugetlb_folio()
{
	if (mem_cgroup_hugetlb_try_charge())
		return ERR_PTR(-ENOMEM);

	folio = dequeue();
	if (!folio) {
		folio = alloc_buddy();
		if (!folio)
			goto uncharge;
	}

	mem_cgroup_hugetlb_commit_charge();
}

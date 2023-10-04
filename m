Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18207B8205
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 16:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbjJDOR1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 10:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242852AbjJDOR0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 10:17:26 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F106C1
        for <cgroups@vger.kernel.org>; Wed,  4 Oct 2023 07:17:22 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7743448d88eso150621285a.2
        for <cgroups@vger.kernel.org>; Wed, 04 Oct 2023 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696429041; x=1697033841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0iVKRRlivbZawLpQE+aqhCrFfCHAJWFRH4b1xYHHXmU=;
        b=Uen7Uk+OcZfpZ6NOOR/CtLouBvKuDLkL6h8xwIoLLP0AGP0SztviHiyReGovSM0ChO
         OKaUwFlIZpHQBfmAC+cVABbNwf3z7vDWdme8oLUAlgiJVADLkO7y9/bLsZEFmUFk6/yr
         /6U0ze/AsCJ0YnMvWgYSUbQ0KWaC29CjGlWGd/5VVgIshzon5YffLqZI0O4VbveobISn
         bwKnRKlu+XX7S39ZvTlgz7wWzJJcLy35tXa/BGQGyHjaI5ls1S7lkygPk53EwcYOU6VX
         YsapwNZRtocPIFQU7gVrKZdiV4Wjr3v21kcwJyn14tkcVpmksMAAxN19w2BgrslkGy99
         G3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696429041; x=1697033841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iVKRRlivbZawLpQE+aqhCrFfCHAJWFRH4b1xYHHXmU=;
        b=iuyESFcx5uMMZ6zeLY3ERT9g9FRXBwQbmXCSUUB0I0shCUGYWjtGdwasghj0i8AJah
         mSOzyKxk6VbsuN53BQDB2ga5ps0vXSO7JoZzVDa5zmDZkepE0m9XQEllIwZ4FY13HuyY
         kXdjeQVxECuHSY1joh3zPCCFc20z/UOna92dfQ6QvfxKtl3vuOGrMQ8eYFLvo5dRv7aJ
         PEc3hGd6FtiHYwQ1mHBQsDo8wv0YTpaVfyAZ5rXKchVUeMJG1q2Y0wFYmTYyYK0Gv7GC
         GVKs7fwaUifY4CsSCi2tkBfTmAayYItyGy5PIIXU5mj7T/Ko30KzPRaUWO7YEWafp6XE
         RK0w==
X-Gm-Message-State: AOJu0YzxKId22HsSQdQ8BxfWDdajE3aIkuFqNx2PJOwnWFzv50RVUIdM
        cA2FiUkYZSpJrFrIoFIkqs2ECQ==
X-Google-Smtp-Source: AGHT+IHwbweLrbblB6DFXPXXebkAKQNIMi3Tti+rzdpJw79HDk06ZZMQubaZZkRYtiU5APTTeVDCUg==
X-Received: by 2002:a05:620a:454c:b0:773:b623:72f7 with SMTP id u12-20020a05620a454c00b00773b62372f7mr3286274qkp.50.1696429041546;
        Wed, 04 Oct 2023 07:17:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:753d])
        by smtp.gmail.com with ESMTPSA id g23-20020a05620a109700b007756736aee0sm1280773qkk.115.2023.10.04.07.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:17:21 -0700 (PDT)
Date:   Wed, 4 Oct 2023 10:17:20 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] memcontrol: only transfer the memcg data for migration
Message-ID: <20231004141720.GA35281@cmpxchg.org>
References: <20231003171329.GB314430@monkey>
 <20231003231422.4046187-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003231422.4046187-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 03, 2023 at 04:14:22PM -0700, Nhat Pham wrote:
> For most migration use cases, only transfer the memcg data from the old
> folio to the new folio, and clear the old folio's memcg data. No
> charging and uncharging will be done. These use cases include the new
> hugetlb memcg accounting behavior (which was not previously handled).
> 
> This shaves off some work on the migration path, and avoids the
> temporary double charging of a folio during its migration.
> 
> The only exception is replace_page_cache_folio(), which will use the old
> mem_cgroup_migrate() (now renamed to mem_cgroup_replace_folio). In that
> context, the isolation of the old page isn't quite as thorough as with
> migration, so we cannot use our new implementation directly.
> 
> This patch is the result of the following discussion on the new hugetlb
> memcg accounting behavior:
> 
> https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
> 
> Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
> Closes: https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

For squashing, the patch title should be:

hugetlb: memcg: account hugetlb-backed memory in memory controller fix

However, I think this should actually be split out. It changes how all
pages are cgroup-migrated, which is a bit too large of a side effect
for the hugetlb accounting patch itself. Especially because the
reasoning outlined above will get lost once this fixup is folded.

IOW, send one prep patch, to go before the series, which splits
mem_cgroup_replace_folio() and does the mem_cgroup_migrate()
optimization() with the above explanation.

Then send a fixlet for the hugetlb accounting patch that removes the
!hugetlb-conditional for the mem_cgroup_migrate() call.

If you're clear in the queueing instructions for both patches, Andrew
can probably do it in-place without having to resend everything :)

> +void mem_cgroup_migrate(struct folio *old, struct folio *new)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
> +	VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
> +	VM_BUG_ON_FOLIO(folio_test_anon(old) != folio_test_anon(new), new);
> +	VM_BUG_ON_FOLIO(folio_nr_pages(old) != folio_nr_pages(new), new);
> +
> +	if (mem_cgroup_disabled())
> +		return;
> +
> +	memcg = folio_memcg(old);
> +	/*
> +	 * Note that it is normal to see !memcg for a hugetlb folio.
> +	 * It could have been allocated when memory_hugetlb_accounting was not
> +	 * selected, for e.g.

Is that sentence truncated?

> +	 */
> +	VM_WARN_ON_ONCE_FOLIO(!memcg, old);
> +	if (!memcg)
> +		return;

If this is expected to happen, it shouldn't warn:

VM_WARN_ON_ONCE(!folio_test_hugetlb(old) && !memcg, old);

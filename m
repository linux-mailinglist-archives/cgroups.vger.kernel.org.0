Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108D177FC82
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 19:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353809AbjHQRHR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Aug 2023 13:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353817AbjHQRHK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Aug 2023 13:07:10 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E904E30C4
        for <cgroups@vger.kernel.org>; Thu, 17 Aug 2023 10:07:05 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bbdced15f3so263685ad.2
        for <cgroups@vger.kernel.org>; Thu, 17 Aug 2023 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692292025; x=1692896825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QnA3zPm2q98qby0UoFFaFMSu7nPrN723bBGGT2+DgLs=;
        b=cPbrT9R7dbSgZyIYn0MoABD+dW9CzgzB0c2szdO9q2gaQezgEccSgLaZARJUxDii3N
         z2xVLOsuI32LBrHAJjco19jtnJttDM9z5VTOcV4d0KghDeGC/LeT+LQNnXzLb5hXhfac
         epcWSxrBvzEcCnO1xidylUFN1IPNUinKwyDkLHxFBALc+nXRm8rKZcufVEx5nlkyrSzw
         8mIVqtIoFXayBbkUJNL8QSXTjk3u5fdN6MtfgO9MUf2uBhJ0JgHKIRfXe6BEmApaJufR
         vKiuZpi7tq+ULrqeuRVyaDWvIZTtmJqvL2nsHH8hLJF84cIrJNlcfxBv7IXZxOuZxpUV
         SCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692292025; x=1692896825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnA3zPm2q98qby0UoFFaFMSu7nPrN723bBGGT2+DgLs=;
        b=JC0V9grF7W4RzNbZ0R2jCGrh+lPnPO/PY1DQASgbYk/H/I9gZme90IW/MXsRrX3d38
         iYkTcew217j8JKpxF8y7GHMX6DYCbqeXcFNh4lFJPXEFwi2xI7SO+iGw8n4JJTcwKKMw
         laUw5BWzGmJOJ+Xl0/qvA+Ye74jJOdylp4r361Tk9yBOYo9RpeuheCmUN5ZQGNH+HDgW
         RNtyOE3oAAM3TnzbgvcuBr7j7XcchIRoshlTeKcNubyx3BbPrkr36EB5OoNqStqLR6tI
         +CmPymgOrPTeUCVttTm7/ey1/BrxOuVSo8x7QY/nha2trMy5gPw5bKEPfz/ECoIn4TcS
         vc5w==
X-Gm-Message-State: AOJu0YxEVTbcrf1R9uhmyLY2XYJJjNUhvN2EFSf9mHcOdB1kbqfUT97E
        PaYvtwxw0bK+qvsbCsXtLF1bqi+uONB5fA==
X-Google-Smtp-Source: AGHT+IEwMltNFPnv+TWY5AbM/L2SSVB4Cwu+aXXJkg5TrmecyH0tcs+CbpYVLgXJ5E30Hfo3VlYRap3agDlaNA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:903:64e:b0:1b8:d44:32aa with SMTP id
 kh14-20020a170903064e00b001b80d4432aamr3467plb.1.1692292025414; Thu, 17 Aug
 2023 10:07:05 -0700 (PDT)
Date:   Thu, 17 Aug 2023 17:07:02 +0000
In-Reply-To: <jnyjalhg43mdnn6su2a2kmwzqasdyjsfdvipim2i2hvqo7w6y2@st57sbo4bkxf>
Mime-Version: 1.0
References: <jnyjalhg43mdnn6su2a2kmwzqasdyjsfdvipim2i2hvqo7w6y2@st57sbo4bkxf>
Message-ID: <20230817170702.mwem4nsy2ka4gj7n@google.com>
Subject: Re: [PATCH v2] selftests: cgroup: fix test_kmem_memcg_deletion kernel
 mem check
From:   Shakeel Butt <shakeelb@google.com>
To:     Lucas Karpinski <lkarpins@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 17, 2023 at 08:47:26AM -0400, Lucas Karpinski wrote:
> The combination of using slab, anon, file, kernel_stack, and percpu is
> not accurate for total kernel memory utilization. Checking kernel within
> memory.stat provides a more accurate measurement.
> 
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> ---
>  v1: https://lore.kernel.org/all/eex2vdlg4ow2j5bybmav73nbfzuspkk4zobnk7svua4jaypqb5@7ie6e4mci43t/
> 
>  tools/testing/selftests/cgroup/test_kmem.c | 25 +++++-----------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> index ed2e50bb1e76..3ef979ee0edf 100644
> --- a/tools/testing/selftests/cgroup/test_kmem.c
> +++ b/tools/testing/selftests/cgroup/test_kmem.c
> @@ -166,7 +166,7 @@ static int cg_run_in_subcgroups(const char *parent,
>   */
>  static int test_kmem_memcg_deletion(const char *root)
>  {
> -	long current, slab, anon, file, kernel_stack, pagetables, percpu, sock, sum;
> +	long current, kernel;
>  	int ret = KSFT_FAIL;
>  	char *parent;
>  
> @@ -184,30 +184,15 @@ static int test_kmem_memcg_deletion(const char *root)
>  		goto cleanup;
>  
>  	current = cg_read_long(parent, "memory.current");
> -	slab = cg_read_key_long(parent, "memory.stat", "slab ");
> -	anon = cg_read_key_long(parent, "memory.stat", "anon ");
> -	file = cg_read_key_long(parent, "memory.stat", "file ");
> -	kernel_stack = cg_read_key_long(parent, "memory.stat", "kernel_stack ");
> -	pagetables = cg_read_key_long(parent, "memory.stat", "pagetables ");
> -	percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
> -	sock = cg_read_key_long(parent, "memory.stat", "sock ");
> -	if (current < 0 || slab < 0 || anon < 0 || file < 0 ||
> -	    kernel_stack < 0 || pagetables < 0 || percpu < 0 || sock < 0)
> +	kernel = cg_read_key_long(parent, "memory.stat", "kernel ");
> +	if (current < 0 || kernel < 0)
>  		goto cleanup;
>  
> -	sum = slab + anon + file + kernel_stack + pagetables + percpu + sock;
> -	if (abs(sum - current) < MAX_VMSTAT_ERROR) {
> +	if (abs(kernel - current) < MAX_VMSTAT_ERROR) {

I don't think this is what you want. Since slab, kernel_stack,
pagetables and percpu are included in the kmem stats, you just want to
replace those with kmem. Basically keep the anon, file and sock stats.


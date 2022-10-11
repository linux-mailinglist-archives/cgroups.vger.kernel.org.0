Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F033C5FA933
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 02:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJKASn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 20:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJKAS3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 20:18:29 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301DB5C9E3;
        Mon, 10 Oct 2022 17:18:28 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 204so12054289pfx.10;
        Mon, 10 Oct 2022 17:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xm8Uch19R6NmYEbBkjcqkxQLt/DtdpQviAbU+5kyHeg=;
        b=HBXnfJdLfLouo9iEPM66BHhv/PtDj/o/wxFo1cOhKl/R5e1EWC6xOAGDiaw0T1frh+
         QuCSxWZLMbBAtcHs2EZ+10XspyM7Vsi6Z2OnpUhJ2Y7m8RSSikhiqgQJ4lDMYZ425Yei
         bhO7e/Focu7uTT1h+Nx1QpZs4+BZ1Ze/bDoqcyY5Hav29eBAW8/8a9eNjtplJArxP8/x
         N/qDDfqGIiGI+SwaNDbzujkHfMOvd8T25luGAFsbVcgKx9FkDQqFSPhzZjHysqGag6Bu
         NWfJxrXndFcrX22F6bvnLh6q9rqZhP1FnjtBuhe7M46mjW95TnA0Bya8gFdyvjGQypH5
         I5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm8Uch19R6NmYEbBkjcqkxQLt/DtdpQviAbU+5kyHeg=;
        b=jfb2waQdL03g6cjQw4BcU/poBoNa0yz2q4IWrScDJcwsxXLT5AZCIQX6qpOGhB8MgW
         LuMfln4vaX//YUHRc0HT4GYTUt3GKuO/dxQQN7DKmwjnlNBFL0UlEpL4oqQlqJE6AN34
         Nrppuz16cb+ygiyDHn2FVc14gbpufcrLbyJvA0kBCuTRGIenf+DB9UJXVFOKk8zdrx5m
         MYvbRjHpqVA2WAf3mLLnSG6yg9D5z/4s/BDE4Vb8/91Y2fvoHAgPunlaSVUDGthCgGS2
         juRfJmr3P90AqWR8wh2YxHhfYCo3j6vHWY5g4hf5Q/f1puLsnlQLbjp5zDKnqULd0nE+
         KLUA==
X-Gm-Message-State: ACrzQf2bQvfwdv0k6W38Z/pXNOvziByGud/mvBC1mu2iqe7JALbNuuin
        cHPZeIkd+84OhtUw98B+hOM=
X-Google-Smtp-Source: AMsMyM6bdfpr/R75A28nYjhdauGVB7hAOtJRLtv7DZ3d5D7k2S9Ypzqr8t3MG5ylFEVSyxAuiXUJDw==
X-Received: by 2002:a63:942:0:b0:43c:428d:16a9 with SMTP id 63-20020a630942000000b0043c428d16a9mr18164718pgj.423.1665447507505;
        Mon, 10 Oct 2022 17:18:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g20-20020a63dd54000000b0043c9da02729sm6852023pgj.6.2022.10.10.17.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 17:18:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 14:18:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 2/3] cgroup: add cgroup_all_get_from_[fd/file]()
Message-ID: <Y0S2UeE4reIRUdBH@slm.duckdns.org>
References: <20221010235845.3379019-1-yosryahmed@google.com>
 <20221010235845.3379019-3-yosryahmed@google.com>
 <Y0S0nFSyivpU4H0n@slm.duckdns.org>
 <CAJD7tkbDNqxE+bYQvo5YAbK01qz7UVd-s6bOf==Ao44bmNsk=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbDNqxE+bYQvo5YAbK01qz7UVd-s6bOf==Ao44bmNsk=Q@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 10, 2022 at 05:14:24PM -0700, Yosry Ahmed wrote:
> On Mon, Oct 10, 2022 at 5:11 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Mon, Oct 10, 2022 at 11:58:44PM +0000, Yosry Ahmed wrote:
> > > Add cgroup_all_get_from_fd() and cgroup_all_get_from_file() that
> > > support both cgroup1 and cgroup2.
> >
> > Looks generally good. How about cgroup_v1v2_ as the prefix?
> 
> Thanks for taking a look.
> 
> I don't have a strong opinion here. I picked cgroup_all_* vs
> cgroup12_* or cgroup_v1v2_* because it's easier on the eyes.

I'd rather have something which is really distinctive because the difference
is rather subtle.

> My preference would have been to rename the old versions to
> cgroup_dfl_* instead, but like you said this might confuse existing
> users.

Yeah, it's confusing to have parallel file / id lookup functions with
different behaviors and we've asssumed that all these from-userspace lookups
are cgroup2 only for a while now.

> Anyway, I am fine with whatever you choose. Let me know if you need me
> to send a v2 for changing the prefix.

Please send an updated version. I don't mind whether it's cgroup12_ or
cgroup_v1v2_.

Thanks.

-- 
tejun

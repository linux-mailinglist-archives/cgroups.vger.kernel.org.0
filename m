Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E280268F808
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 20:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjBHT3r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 14:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjBHT3q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 14:29:46 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916FD1F5C4
        for <cgroups@vger.kernel.org>; Wed,  8 Feb 2023 11:29:45 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id f10so22163051qtv.1
        for <cgroups@vger.kernel.org>; Wed, 08 Feb 2023 11:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ckq//vME+Nz5mmbgePkAmCR230i6+DQZLOGVcNp8OPI=;
        b=mY9IBBFHZrMt3A7IAF4mj5amR2XXHtGbkhKVwWX3uZwbz8T5AaiDODgRKqOBw8LfK2
         5dl7uRpC26Fv81ZHwfOHZsYObi8lbqOW7Q/VFNQroo9KB2njDmFW+73tT9lRFbtTq14D
         RNGfsDHsmXQ3q5g71UxwNdqeC2twiEB88FJg27NRVBL9OfPo4/SnRJ1x8335humNkyKB
         Z+uUnGrUZvdq5MbT51Uq35FqJwaR42M7g0FznkYlVTRsPISYBQqXCcJ2P4zg/sjddj0T
         WTr7Yws0uYkc/sb/ahUuZfkDxJxO+KFPudzY8szdtLIuKqyYXr9PPcXBkUcR909g7awT
         gYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckq//vME+Nz5mmbgePkAmCR230i6+DQZLOGVcNp8OPI=;
        b=GuhBj6aa8aQ4Ka1STxbEW42mMTR6dbdskSS0IkXKxT9gMo9+c+7hTqy1tVyTjJRmyV
         73eNHgzx2t1zQEjr16cOoxwnJVa8rOkLeRexvx7NTfLz2s20VaAJhIHD46QBakXdZxvx
         oaWFmNKxqJPUfPdsuTFzSGCQxEeQPVwNjfNTIl2iJ1ikBXnuqixG7/NZuF/uajthzms3
         8zornCMVse4BTffSVfqbXw2rNWfnTtEDf9gwfhsAR9RGSDobmBdvaSi5voZXKeYPne3S
         J5p9Z6JxEaHLUrfo3bTkO+GaIyMByZjyiMC8+cdSlcE0A9IFKuaX2/+CQuUrk4JA4yRW
         FdPw==
X-Gm-Message-State: AO0yUKUGWECrl5KxDZo1UypOnrhOlBZZJx3cciFs6oJC4pcoQE+LImN1
        lbHkle7ANduJH1GpNQTrJ3KiIQ==
X-Google-Smtp-Source: AK7set8cqt0MxPHihAGzpJgJIlfeT+7jZoje0NwtWNYsxsJqrwmwIJFEA4dWfyywZu8Jm1Yv7PFFsg==
X-Received: by 2002:a05:622a:192:b0:3b8:4729:8225 with SMTP id s18-20020a05622a019200b003b847298225mr15495080qtw.9.1675884584734;
        Wed, 08 Feb 2023 11:29:44 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id y125-20020a37af83000000b00726b480880esm12316156qke.68.2023.02.08.11.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:29:44 -0800 (PST)
Date:   Wed, 8 Feb 2023 14:29:43 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH bpf-next 0/5] bpf, mm: introduce cgroup.memory=nobpf
Message-ID: <Y+P4J5+fykUp67b5@cmpxchg.org>
References: <20230205065805.19598-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205065805.19598-1-laoar.shao@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Feb 05, 2023 at 06:58:00AM +0000, Yafang Shao wrote:
> The bpf memory accouting has some known problems in contianer
> environment,
> 
> - The container memory usage is not consistent if there's pinned bpf
>   program
>   After the container restart, the leftover bpf programs won't account
>   to the new generation, so the memory usage of the container is not
>   consistent. This issue can be resolved by introducing selectable
>   memcg, but we don't have an agreement on the solution yet. See also
>   the discussions at https://lwn.net/Articles/905150/ .
> 
> - The leftover non-preallocated bpf map can't be limited
>   The leftover bpf map will be reparented, and thus it will be limited by 
>   the parent, rather than the container itself. Furthermore, if the
>   parent is destroyed, it be will limited by its parent's parent, and so
>   on. It can also be resolved by introducing selectable memcg.
> 
> - The memory dynamically allocated in bpf prog is charged into root memcg
>   only
>   Nowdays the bpf prog can dynamically allocate memory, for example via
>   bpf_obj_new(), but it only allocate from the global bpf_mem_alloc
>   pool, so it will charge into root memcg only. That needs to be
>   addressed by a new proposal.
> 
> So let's give the user an option to disable bpf memory accouting.
> 
> The idea of "cgroup.memory=nobpf" is originally by Tejun[1].

I'm not the most familiar with bpf internals, but the memcg bits and
adding the boot time flag look good to me:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

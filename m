Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C2F1DA741
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2020 03:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgETBik (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 May 2020 21:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgETBij (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 May 2020 21:38:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A81EC061A0E
        for <cgroups@vger.kernel.org>; Tue, 19 May 2020 18:38:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l15so1418214lje.9
        for <cgroups@vger.kernel.org>; Tue, 19 May 2020 18:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wp6yM374SAibTrarxPnW2QuRcQ8ZTv0Nb2h0Ye6/kEg=;
        b=uulinYLhsvfZVnTYwjEQphJFr342xI5I6a3rn5kvcU02c0T5EWd7KeyG1taB59rcr6
         lHLtdaknZUCThMfwoFb2bMFBouixn/8lQNcbXD16mvPEVfH3DZzrzR3fnNcyBL4NZZu4
         cClnAC67SoFzH87oGdTZPYEP3qjp/5J/A2acf+DUFBKb0Q75h7TH0DyG3eP5iku/AvY6
         MC9zgb4pC5wLyacw+AMwF98uyNJm/JlIDrRGrARSbZghkGeS2E9t77kSYLAHpQcCsZMi
         MzK8fk2Yp9h/SiCWzBAW1hvRLZaO4MPgofxbKTj8zA2CQ6XZlj2Amdcl0cP1Vwq/nL3k
         vnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wp6yM374SAibTrarxPnW2QuRcQ8ZTv0Nb2h0Ye6/kEg=;
        b=PJLO65FSaM8EUU1EEGDqAanFZMrlzxSdxsv7dpcBR1KrgNh+SSRuuRPSbzR07XD63b
         u08Zi/8CZyPIRBPj4fUnof0u/7AQ355tex+KGicN9PwAcKqn2mMTmVELhOhxm7wipXrE
         j2h4MHgj96QDREODp/XH+10k3lp0YcYBAYtMLipub+RCOGFhSUKXNdkQjOX9FfwUM/hs
         iOj+ZaNnmfbdTMVJ4u/1VtK1blvKuCSoehKbUORZIPZnRQLVNw2txWDraKXQDWRXGOwx
         DO/wHGQKz4E0tIxzZ2U5TdsiP+5FtrekE44pFGCHbsw8F4/x+LtEKjfkpWI53lnHC+EN
         wLtg==
X-Gm-Message-State: AOAM530x9BP3D6sClJvqPH70zLBactSTYwKqrOp2EvTuKwmidOwxlFlB
        Vr7xB8jE2XWG60lJ91PqoyyLmTTPcFDrtxu2VxhA1g==
X-Google-Smtp-Source: ABdhPJzR0zWCr2wmVI7chSmKOARMOXZ8zU/iu17/PAAkcpEdHObL7lrKfrBcA0Jq8jhL9Fenl/hCwX2uhNHxuH+QuYk=
X-Received: by 2002:a2e:9706:: with SMTP id r6mr1262493lji.222.1589938715320;
 Tue, 19 May 2020 18:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200519171938.3569605-1-kuba@kernel.org> <20200519171938.3569605-2-kuba@kernel.org>
In-Reply-To: <20200519171938.3569605-2-kuba@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 May 2020 18:38:24 -0700
Message-ID: <CALvZod66pJ0iP40n+-N3wZCRiM7AuwcrMWx5nu5-ZEqhWzfoTA@mail.gmail.com>
Subject: Re: [PATCH mm v4 1/4] mm: prepare for swap over-high accounting and
 penalty calculation
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 19, 2020 at 10:19 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Slice the memory overage calculation logic a little bit so we can
> reuse it to apply a similar penalty to the swap. The logic which
> accesses the memory-specific fields (use and high values) has to
> be taken out of calculate_high_delay().
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
